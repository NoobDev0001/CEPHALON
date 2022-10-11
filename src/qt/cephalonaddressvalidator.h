// Copyright (c) 2011-2014 The Bitcoin Core developers
// Copyright (c) 2017-2019 The Raven Core developers
// Copyright (c) 2020-2021 The Cephalon Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef CEPHALON_QT_CEPHALONADDRESSVALIDATOR_H
#define CEPHALON_QT_CEPHALONADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class CephalonAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CephalonAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** cephalon address widget validator, checks for a valid cephalon address.
 */
class CephalonAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CephalonAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // CEPHALON_QT_CEPHALONADDRESSVALIDATOR_H

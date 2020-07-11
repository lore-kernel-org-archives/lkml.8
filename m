Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F597C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D322075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XRlcVbB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGKGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:51:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46712 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728233AbgGKGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:03 -0400
X-UUID: 024ce4f14af9483495b76cbe6d81beb7-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=A6+q+22FagzSCao2f0Ta4oPidTfn5MvJ+7lol/cwNio=;
        b=XRlcVbB6VF7od5Q4sv5IC58e0DqKTqavd56/cRHtpRyAUhtZKhV+PrZt1bnm+mHHi3KKXzuvJyrWgX+Cdxn+s83G+SZO+3YMd5sRB9ur+XMDN6O8IfTX4G0SndBAm8RqA49EiH+f1PY3RStlm6zC/rjOirXeWaBZHLUG9uBunrg=;
X-UUID: 024ce4f14af9483495b76cbe6d81beb7-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 715424698; Sat, 11 Jul 2020 14:50:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:50:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:50:55 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 08/21] iommu/io-pgtable-arm-v7s: Add cfg as a param in some macros
Date:   Sat, 11 Jul 2020 14:48:33 +0800
Message-ID: <20200711064846.16007-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJjZmciIGFzIGEgcGFyYW1ldGVyIGZvciBzb21lIG1hY3Jvcy4gVGhpcyBpcyBhIHByZXBh
cmluZyBwYXRjaCBmb3INCm1lZGlhdGVrIGV4dGVuZCB0aGUgbHZsMSBwZ3RhYmxlLiBObyBmdW5j
dGlvbmFsIGNoYW5nZS4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jIHwgMzQgKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1w
Z3RhYmxlLWFybS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCmlu
ZGV4IDI4MzA3MThiOWQ4My4uZTFjOThiZTYxZTFiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21t
dS9pby1wZ3RhYmxlLWFybS12N3MuYw0KKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFy
bS12N3MuYw0KQEAgLTUzLDE3ICs1MywxNyBAQA0KICNkZWZpbmUgQVJNX1Y3U19MVkxfU0hJRlQo
bHZsKQkJKEFSTV9WN1NfQUREUl9CSVRTIC0gKDQgKyA4ICogKGx2bCkpKQ0KICNkZWZpbmUgQVJN
X1Y3U19UQUJMRV9TSElGVAkJMTANCiANCi0jZGVmaW5lIEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2
bCkJKDEgPDwgX0FSTV9WN1NfTFZMX0JJVFMobHZsKSkNCi0jZGVmaW5lIEFSTV9WN1NfVEFCTEVf
U0laRShsdmwpCQkJCQkJXA0KLQkoQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZsKSAqIHNpemVvZihh
cm1fdjdzX2lvcHRlKSkNCisjZGVmaW5lIEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2ZnKQko
MSA8PCBfQVJNX1Y3U19MVkxfQklUUyhsdmwpKQ0KKyNkZWZpbmUgQVJNX1Y3U19UQUJMRV9TSVpF
KGx2bCwgY2ZnKQkJCQkJXA0KKwkoQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZsLCBjZmcpICogc2l6
ZW9mKGFybV92N3NfaW9wdGUpKQ0KIA0KICNkZWZpbmUgQVJNX1Y3U19CTE9DS19TSVpFKGx2bCkJ
CSgxVUwgPDwgQVJNX1Y3U19MVkxfU0hJRlQobHZsKSkNCiAjZGVmaW5lIEFSTV9WN1NfTFZMX01B
U0sobHZsKQkJKCh1MzIpKH4wVSA8PCBBUk1fVjdTX0xWTF9TSElGVChsdmwpKSkNCiAjZGVmaW5l
IEFSTV9WN1NfVEFCTEVfTUFTSwkJKCh1MzIpKH4wVSA8PCBBUk1fVjdTX1RBQkxFX1NISUZUKSkN
Ci0jZGVmaW5lIF9BUk1fVjdTX0lEWF9NQVNLKGx2bCkJCShBUk1fVjdTX1BURVNfUEVSX0xWTChs
dmwpIC0gMSkNCi0jZGVmaW5lIEFSTV9WN1NfTFZMX0lEWChhZGRyLCBsdmwpCSh7CQkJCVwNCisj
ZGVmaW5lIF9BUk1fVjdTX0lEWF9NQVNLKGx2bCwgY2ZnKQkoQVJNX1Y3U19QVEVTX1BFUl9MVkwo
bHZsLCBjZmcpIC0gMSkNCisjZGVmaW5lIEFSTV9WN1NfTFZMX0lEWChhZGRyLCBsdmwsIGNmZykJ
KHsJCQlcDQogCWludCBfbCA9IGx2bDsJCQkJCQkJXA0KLQkoKHUzMikoYWRkcikgPj4gQVJNX1Y3
U19MVkxfU0hJRlQoX2wpKSAmIF9BUk1fVjdTX0lEWF9NQVNLKF9sKTsgXA0KKwkoKHUzMikoYWRk
cikgPj4gQVJNX1Y3U19MVkxfU0hJRlQoX2wpKSAmIF9BUk1fVjdTX0lEWF9NQVNLKF9sLCBjZmcp
OyBcDQogfSkNCiANCiAvKg0KQEAgLTIzOSw3ICsyMzksNyBAQCBzdGF0aWMgdm9pZCAqX19hcm1f
djdzX2FsbG9jX3RhYmxlKGludCBsdmwsIGdmcF90IGdmcCwNCiAJc3RydWN0IGRldmljZSAqZGV2
ID0gY2ZnLT5pb21tdV9kZXY7DQogCXBoeXNfYWRkcl90IHBoeXM7DQogCWRtYV9hZGRyX3QgZG1h
Ow0KLQlzaXplX3Qgc2l6ZSA9IEFSTV9WN1NfVEFCTEVfU0laRShsdmwpOw0KKwlzaXplX3Qgc2l6
ZSA9IEFSTV9WN1NfVEFCTEVfU0laRShsdmwsIGNmZyk7DQogCXZvaWQgKnRhYmxlID0gTlVMTDsN
CiANCiAJaWYgKGx2bCA9PSAxKQ0KQEAgLTI4NSw3ICsyODUsNyBAQCBzdGF0aWMgdm9pZCBfX2Fy
bV92N3NfZnJlZV90YWJsZSh2b2lkICp0YWJsZSwgaW50IGx2bCwNCiB7DQogCXN0cnVjdCBpb19w
Z3RhYmxlX2NmZyAqY2ZnID0gJmRhdGEtPmlvcC5jZmc7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9
IGNmZy0+aW9tbXVfZGV2Ow0KLQlzaXplX3Qgc2l6ZSA9IEFSTV9WN1NfVEFCTEVfU0laRShsdmwp
Ow0KKwlzaXplX3Qgc2l6ZSA9IEFSTV9WN1NfVEFCTEVfU0laRShsdmwsIGNmZyk7DQogDQogCWlm
ICghY2ZnLT5jb2hlcmVudF93YWxrKQ0KIAkJZG1hX3VubWFwX3NpbmdsZShkZXYsIF9fYXJtX3Y3
c19kbWFfYWRkcih0YWJsZSksIHNpemUsDQpAQCAtNDI5LDcgKzQyOSw3IEBAIHN0YXRpYyBpbnQg
YXJtX3Y3c19pbml0X3B0ZShzdHJ1Y3QgYXJtX3Y3c19pb19wZ3RhYmxlICpkYXRhLA0KIAkJCWFy
bV92N3NfaW9wdGUgKnRibHA7DQogCQkJc2l6ZV90IHN6ID0gQVJNX1Y3U19CTE9DS19TSVpFKGx2
bCk7DQogDQotCQkJdGJscCA9IHB0ZXAgLSBBUk1fVjdTX0xWTF9JRFgoaW92YSwgbHZsKTsNCisJ
CQl0YmxwID0gcHRlcCAtIEFSTV9WN1NfTFZMX0lEWChpb3ZhLCBsdmwsIGNmZyk7DQogCQkJaWYg
KFdBUk5fT04oX19hcm1fdjdzX3VubWFwKGRhdGEsIE5VTEwsIGlvdmEgKyBpICogc3osDQogCQkJ
CQkJICAgIHN6LCBsdmwsIHRibHApICE9IHN6KSkNCiAJCQkJcmV0dXJuIC1FSU5WQUw7DQpAQCAt
NDgyLDcgKzQ4Miw3IEBAIHN0YXRpYyBpbnQgX19hcm1fdjdzX21hcChzdHJ1Y3QgYXJtX3Y3c19p
b19wZ3RhYmxlICpkYXRhLCB1bnNpZ25lZCBsb25nIGlvdmEsDQogCWludCBudW1fZW50cmllcyA9
IHNpemUgPj4gQVJNX1Y3U19MVkxfU0hJRlQobHZsKTsNCiANCiAJLyogRmluZCBvdXIgZW50cnkg
YXQgdGhlIGN1cnJlbnQgbGV2ZWwgKi8NCi0JcHRlcCArPSBBUk1fVjdTX0xWTF9JRFgoaW92YSwg
bHZsKTsNCisJcHRlcCArPSBBUk1fVjdTX0xWTF9JRFgoaW92YSwgbHZsLCBjZmcpOw0KIA0KIAkv
KiBJZiB3ZSBjYW4gaW5zdGFsbCBhIGxlYWYgZW50cnkgYXQgdGhpcyBsZXZlbCwgdGhlbiBkbyBz
byAqLw0KIAlpZiAobnVtX2VudHJpZXMpDQpAQCAtNTU1LDcgKzU1NSw3IEBAIHN0YXRpYyB2b2lk
IGFybV92N3NfZnJlZV9wZ3RhYmxlKHN0cnVjdCBpb19wZ3RhYmxlICppb3ApDQogCXN0cnVjdCBh
cm1fdjdzX2lvX3BndGFibGUgKmRhdGEgPSBpb19wZ3RhYmxlX3RvX2RhdGEoaW9wKTsNCiAJaW50
IGk7DQogDQotCWZvciAoaSA9IDA7IGkgPCBBUk1fVjdTX1BURVNfUEVSX0xWTCgxKTsgaSsrKSB7
DQorCWZvciAoaSA9IDA7IGkgPCBBUk1fVjdTX1BURVNfUEVSX0xWTCgxLCAmZGF0YS0+aW9wLmNm
Zyk7IGkrKykgew0KIAkJYXJtX3Y3c19pb3B0ZSBwdGUgPSBkYXRhLT5wZ2RbaV07DQogDQogCQlp
ZiAoQVJNX1Y3U19QVEVfSVNfVEFCTEUocHRlLCAxKSkNCkBAIC02MDcsOSArNjA3LDkgQEAgc3Rh
dGljIHNpemVfdCBhcm1fdjdzX3NwbGl0X2Jsa191bm1hcChzdHJ1Y3QgYXJtX3Y3c19pb19wZ3Rh
YmxlICpkYXRhLA0KIAlpZiAoIXRhYmxlcCkNCiAJCXJldHVybiAwOyAvKiBCeXRlcyB1bm1hcHBl
ZCAqLw0KIA0KLQludW1fcHRlcyA9IEFSTV9WN1NfUFRFU19QRVJfTFZMKDIpOw0KKwludW1fcHRl
cyA9IEFSTV9WN1NfUFRFU19QRVJfTFZMKDIsIGNmZyk7DQogCW51bV9lbnRyaWVzID0gc2l6ZSA+
PiBBUk1fVjdTX0xWTF9TSElGVCgyKTsNCi0JdW5tYXBfaWR4ID0gQVJNX1Y3U19MVkxfSURYKGlv
dmEsIDIpOw0KKwl1bm1hcF9pZHggPSBBUk1fVjdTX0xWTF9JRFgoaW92YSwgMiwgY2ZnKTsNCiAN
CiAJcHRlID0gYXJtX3Y3c19wcm90X3RvX3B0ZShhcm1fdjdzX3B0ZV90b19wcm90KGJsa19wdGUs
IDEpLCAyLCBjZmcpOw0KIAlpZiAobnVtX2VudHJpZXMgPiAxKQ0KQEAgLTY1MSw3ICs2NTEsNyBA
QCBzdGF0aWMgc2l6ZV90IF9fYXJtX3Y3c191bm1hcChzdHJ1Y3QgYXJtX3Y3c19pb19wZ3RhYmxl
ICpkYXRhLA0KIAlpZiAoV0FSTl9PTihsdmwgPiAyKSkNCiAJCXJldHVybiAwOw0KIA0KLQlpZHgg
PSBBUk1fVjdTX0xWTF9JRFgoaW92YSwgbHZsKTsNCisJaWR4ID0gQVJNX1Y3U19MVkxfSURYKGlv
dmEsIGx2bCwgJmlvcC0+Y2ZnKTsNCiAJcHRlcCArPSBpZHg7DQogCWRvIHsNCiAJCXB0ZVtpXSA9
IFJFQURfT05DRShwdGVwW2ldKTsNCkBAIC03MzcsNyArNzM3LDcgQEAgc3RhdGljIHBoeXNfYWRk
cl90IGFybV92N3NfaW92YV90b19waHlzKHN0cnVjdCBpb19wZ3RhYmxlX29wcyAqb3BzLA0KIAl1
MzIgbWFzazsNCiANCiAJZG8gew0KLQkJcHRlcCArPSBBUk1fVjdTX0xWTF9JRFgoaW92YSwgKyts
dmwpOw0KKwkJcHRlcCArPSBBUk1fVjdTX0xWTF9JRFgoaW92YSwgKytsdmwsICZkYXRhLT5pb3Au
Y2ZnKTsNCiAJCXB0ZSA9IFJFQURfT05DRSgqcHRlcCk7DQogCQlwdGVwID0gaW9wdGVfZGVyZWYo
cHRlLCBsdmwsIGRhdGEpOw0KIAl9IHdoaWxlIChBUk1fVjdTX1BURV9JU19UQUJMRShwdGUsIGx2
bCkpOw0KQEAgLTc4MCw4ICs3ODAsOCBAQCBzdGF0aWMgc3RydWN0IGlvX3BndGFibGUgKmFybV92
N3NfYWxsb2NfcGd0YWJsZShzdHJ1Y3QgaW9fcGd0YWJsZV9jZmcgKmNmZywNCiANCiAJc3Bpbl9s
b2NrX2luaXQoJmRhdGEtPnNwbGl0X2xvY2spOw0KIAlkYXRhLT5sMl90YWJsZXMgPSBrbWVtX2Nh
Y2hlX2NyZWF0ZSgiaW8tcGd0YWJsZV9hcm12N3NfbDIiLA0KLQkJCQkJICAgIEFSTV9WN1NfVEFC
TEVfU0laRSgyKSwNCi0JCQkJCSAgICBBUk1fVjdTX1RBQkxFX1NJWkUoMiksDQorCQkJCQkgICAg
QVJNX1Y3U19UQUJMRV9TSVpFKDIsIGNmZyksDQorCQkJCQkgICAgQVJNX1Y3U19UQUJMRV9TSVpF
KDIsIGNmZyksDQogCQkJCQkgICAgQVJNX1Y3U19UQUJMRV9TTEFCX0ZMQUdTLCBOVUxMKTsNCiAJ
aWYgKCFkYXRhLT5sMl90YWJsZXMpDQogCQlnb3RvIG91dF9mcmVlX2RhdGE7DQotLSANCjIuMTgu
MA0K


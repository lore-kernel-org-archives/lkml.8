Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E10C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F220820760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j8tJWAfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgIEIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:12:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728387AbgIEIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:48 -0400
X-UUID: 668daa294ea64114bcc27b3ac39ad3dd-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u2nLowWb9320Nhqe4Te3XyjuUyh2p45gZPSNv8O11x4=;
        b=j8tJWAfrWINKsdUXpL6q6M32Vcm/3NtoX0kgDNpCxHWX2kO2Ht/NwJHl6LENTZon+w9YxJfbh4vi2Rut5FfpQcHJLySjS6vZqCK73IjH3VbtNMbC12xQUmqJNYzMs3RzNc9rNj9BpcHUkAFCj5ibEIGyh6yhqs5kXOOLhv4cwq0=;
X-UUID: 668daa294ea64114bcc27b3ac39ad3dd-20200905
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 367943681; Sat, 05 Sep 2020 16:12:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:39 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 09/23] iommu/io-pgtable-arm-v7s: Extend PA34 for MediaTek
Date:   Sat, 5 Sep 2020 16:09:06 +0800
Message-ID: <20200905080920.13396-10-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWFUZWsgZXh0ZW5kIHRoZSBiaXQ1IGluIGx2bDEgYW5kIGx2bDIgZGVzY3JpcHRvciBhcyBQ
QTM0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgfCA5ICsrKysrKystLQ0KIGRy
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgICAgICAgICAgfCAyICstDQogaW5jbHVkZS9saW51eC9p
by1wZ3RhYmxlLmggICAgICAgICB8IDQgKystLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW8t
cGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQpp
bmRleCA0YzlkOGRjY2ZjNWEuLmEzYjNlOTE0N2I4ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9t
bXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1h
cm0tdjdzLmMNCkBAIC0xMTIsOSArMTEyLDEwIEBADQogI2RlZmluZSBBUk1fVjdTX1RFWF9NQVNL
CQkweDcNCiAjZGVmaW5lIEFSTV9WN1NfQVRUUl9URVgodmFsKQkJKCgodmFsKSAmIEFSTV9WN1Nf
VEVYX01BU0spIDw8IEFSTV9WN1NfVEVYX1NISUZUKQ0KIA0KLS8qIE1lZGlhVGVrIGV4dGVuZCB0
aGUgdHdvIGJpdHMgZm9yIFBBIDMyYml0LzMzYml0ICovDQorLyogTWVkaWFUZWsgZXh0ZW5kIHRo
ZSBiaXRzIGJlbG93IGZvciBQQSAzMmJpdC8zM2JpdC8zNGJpdCAqLw0KICNkZWZpbmUgQVJNX1Y3
U19BVFRSX01US19QQV9CSVQzMglCSVQoOSkNCiAjZGVmaW5lIEFSTV9WN1NfQVRUUl9NVEtfUEFf
QklUMzMJQklUKDQpDQorI2RlZmluZSBBUk1fVjdTX0FUVFJfTVRLX1BBX0JJVDM0CUJJVCg1KQ0K
IA0KIC8qICp3ZWxsLCBleGNlcHQgZm9yIFRFWCBvbiBsZXZlbCAyIGxhcmdlIHBhZ2VzLCBvZiBj
b3Vyc2UgOiggKi8NCiAjZGVmaW5lIEFSTV9WN1NfQ09OVF9QQUdFX1RFWF9TSElGVAk2DQpAQCAt
MTk0LDYgKzE5NSw4IEBAIHN0YXRpYyBhcm1fdjdzX2lvcHRlIHBhZGRyX3RvX2lvcHRlKHBoeXNf
YWRkcl90IHBhZGRyLCBpbnQgbHZsLA0KIAkJcHRlIHw9IEFSTV9WN1NfQVRUUl9NVEtfUEFfQklU
MzI7DQogCWlmIChwYWRkciAmIEJJVF9VTEwoMzMpKQ0KIAkJcHRlIHw9IEFSTV9WN1NfQVRUUl9N
VEtfUEFfQklUMzM7DQorCWlmIChwYWRkciAmIEJJVF9VTEwoMzQpKQ0KKwkJcHRlIHw9IEFSTV9W
N1NfQVRUUl9NVEtfUEFfQklUMzQ7DQogCXJldHVybiBwdGU7DQogfQ0KIA0KQEAgLTIxOCw2ICsy
MjEsOCBAQCBzdGF0aWMgcGh5c19hZGRyX3QgaW9wdGVfdG9fcGFkZHIoYXJtX3Y3c19pb3B0ZSBw
dGUsIGludCBsdmwsDQogCQlwYWRkciB8PSBCSVRfVUxMKDMyKTsNCiAJaWYgKHB0ZSAmIEFSTV9W
N1NfQVRUUl9NVEtfUEFfQklUMzMpDQogCQlwYWRkciB8PSBCSVRfVUxMKDMzKTsNCisJaWYgKHB0
ZSAmIEFSTV9WN1NfQVRUUl9NVEtfUEFfQklUMzQpDQorCQlwYWRkciB8PSBCSVRfVUxMKDM0KTsN
CiAJcmV0dXJuIHBhZGRyOw0KIH0NCiANCkBAIC03NTMsNyArNzU4LDcgQEAgc3RhdGljIHN0cnVj
dCBpb19wZ3RhYmxlICphcm1fdjdzX2FsbG9jX3BndGFibGUoc3RydWN0IGlvX3BndGFibGVfY2Zn
ICpjZmcsDQogCWlmIChjZmctPmlhcyA+IEFSTV9WN1NfQUREUl9CSVRTKQ0KIAkJcmV0dXJuIE5V
TEw7DQogDQotCWlmIChjZmctPm9hcyA+IChhcm1fdjdzX2lzX210a19lbmFibGVkKGNmZykgPyAz
NCA6IEFSTV9WN1NfQUREUl9CSVRTKSkNCisJaWYgKGNmZy0+b2FzID4gKGFybV92N3NfaXNfbXRr
X2VuYWJsZWQoY2ZnKSA/IDM1IDogQVJNX1Y3U19BRERSX0JJVFMpKQ0KIAkJcmV0dXJuIE5VTEw7
DQogDQogCWlmIChjZmctPnF1aXJrcyAmIH4oSU9fUEdUQUJMRV9RVUlSS19BUk1fTlMgfA0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQppbmRleCBmZDgzMjJlZTQ5ODAuLmY2YTJlM2ViNTlkMiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
CkBAIC0zMTcsNyArMzE3LDcgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfZG9tYWluX2ZpbmFsaXNl
KHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICpkb20pDQogCQkJSU9fUEdUQUJMRV9RVUlSS19BUk1f
TVRLX0VYVCwNCiAJCS5wZ3NpemVfYml0bWFwID0gbXRrX2lvbW11X29wcy5wZ3NpemVfYml0bWFw
LA0KIAkJLmlhcyA9IDMyLA0KLQkJLm9hcyA9IDM0LA0KKwkJLm9hcyA9IDM1LA0KIAkJLnRsYiA9
ICZtdGtfaW9tbXVfZmx1c2hfb3BzLA0KIAkJLmlvbW11X2RldiA9IGRhdGEtPmRldiwNCiAJfTsN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvLXBndGFibGUuaCBiL2luY2x1ZGUvbGludXgv
aW8tcGd0YWJsZS5oDQppbmRleCAyMzI4NWJhNjQ1ZGIuLjhjOWE4ODlkOGRmOSAxMDA2NDQNCi0t
LSBhL2luY2x1ZGUvbGludXgvaW8tcGd0YWJsZS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2lvLXBn
dGFibGUuaA0KQEAgLTc3LDggKzc3LDggQEAgc3RydWN0IGlvX3BndGFibGVfY2ZnIHsNCiAJICoJ
VExCIG1haW50ZW5hbmNlIHdoZW4gbWFwcGluZyBhcyB3ZWxsIGFzIHdoZW4gdW5tYXBwaW5nLg0K
IAkgKg0KIAkgKiBJT19QR1RBQkxFX1FVSVJLX0FSTV9NVEtfRVhUOiAoQVJNIHY3cyBmb3JtYXQp
IE1lZGlhVGVrIElPTU1VcyBleHRlbmQNCi0JICoJdG8gc3VwcG9ydCB1cCB0byAzNCBiaXRzIFBB
IHdoZXJlIHRoZSBiaXQzMiBhbmQgYml0MzMgYXJlDQotCSAqCWVuY29kZWQgaW4gdGhlIGJpdDkg
YW5kIGJpdDQgb2YgdGhlIFBURSByZXNwZWN0aXZlbHkuDQorCSAqCXRvIHN1cHBvcnQgdXAgdG8g
MzUgYml0cyBQQSB3aGVyZSB0aGUgYml0MzIsIGJpdDMzIGFuZCBiaXQzNCBhcmUNCisJICoJZW5j
b2RlZCBpbiB0aGUgYml0OSwgYml0NCBhbmQgYml0NSBvZiB0aGUgUFRFIHJlc3BlY3RpdmVseS4N
CiAJICoNCiAJICogSU9fUEdUQUJMRV9RVUlSS19OT05fU1RSSUNUOiBTa2lwIGlzc3Vpbmcgc3lu
Y2hyb25vdXMgbGVhZiBUTEJJcw0KIAkgKglvbiB1bm1hcCwgZm9yIERNQSBkb21haW5zIHVzaW5n
IHRoZSBmbHVzaCBxdWV1ZSBtZWNoYW5pc20gZm9yDQotLSANCjIuMTguMA0K


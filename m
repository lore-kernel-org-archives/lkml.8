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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A97C2D0A7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709242074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="McRNkxZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgIEIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:14:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13377 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbgIEIOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:14:07 -0400
X-UUID: c1e2d3bec24a4cc3b21e633c4557400c-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yfi9vzm0fW6xqegWSEoNYQMITtGrjQdMcYatXg3F9hk=;
        b=McRNkxZhk5Dw3xI8zdQRHkBnzwWEXIsDySgl4LCjcWQCe+7waXGxVHzmly4CjoIhwtNUaaftxGMtXmz/Ovtfnd+x6mSyVcNwoBuZZLQoEizwNvEaR6mcOgw6R/HD55DyfIOKfPkNN269RPksbklKbrKJH1LjG/xDNiHCBOS9ow0=;
X-UUID: c1e2d3bec24a4cc3b21e633c4557400c-20200905
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 319648558; Sat, 05 Sep 2020 16:14:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:13:59 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:13:59 +0800
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
Subject: [PATCH v2 17/23] iommu/mediatek: Support master use iova over 32bit
Date:   Sat, 5 Sep 2020 16:09:14 +0800
Message-ID: <20200905080920.13396-18-yong.wu@mediatek.com>
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

QWZ0ZXIgZXh0ZW5kaW5nIHY3cywgb3VyIHBhZ2V0YWJsZSBhbHJlYWR5IHN1cHBvcnQgaW92YSBy
ZWFjaA0KMTZHQigzNGJpdCkuIHRoZSBtYXN0ZXIgZ290IHRoZSBpb3ZhIHZpYSBkbWFfYWxsb2Nf
YXR0cnMgbWF5IHJlYWNoDQozNGJpdHMsIGJ1dCBpdHMgSFcgcmVnaXN0ZXIgc3RpbGwgaXMgMzJi
aXQuIHRoZW4gaG93IHRvIHNldCB0aGUNCmJpdDMyL2JpdDMzIGlvdmE/IHRoaXMgZGVwZW5kIG9u
IGEgU01JIGxhcmIgc2V0dGluZyhiYW5rX3NlbCkuDQoNCndlIHNlcGFyYXRlIHdob2xlIDE2R0Ig
aW92YSB0byBmb3VyIGJhbmtzOg0KYmFuazogMDogMH40RzsgMTogNH44RzsgMjogOC0xMkc7IDM6
IDEyLTE2RzsNClRoZSBiYW5rIG51bWJlciBpcyAoaW92YSA+PiAzMikuDQoNCldlIHdpbGwgcHJl
YXNzaWduIHdoaWNoIGJhbmsgdGhlIGxhcmJzIGJlbG9uZyB0by4gY3VycmVudGx5IHdlIGRvbid0
DQpoYXZlIGEgaW50ZXJmYWNlIGZvciBtYXN0ZXIgdG8gYWRqdXN0IGl0cyBiYW5rIG51bWJlci4N
Cg0KRWFjaCBhIGJhbmsgaXMgYSBpb3ZhX3JlZ2lvbiB3aGljaCBpcyBhIGluZGVwZW5kZW50IGlv
bW11LWRvbWFpbi4NCnRoZSBpb3ZhIHJhbmdlIGZvciBlYWNoIGlvbW11LWRvbWFpbiBjYW4ndCBj
cm9zcyA0Ry4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jICB8IDEyICsrKysrKysrKy0tLQ0KIGRy
aXZlcnMvbWVtb3J5L210ay1zbWkuYyAgIHwgIDcgKysrKysrKw0KIGluY2x1ZGUvc29jL21lZGlh
dGVrL3NtaS5oIHwgIDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCAxMGI5YTg2ZWE4MjYuLjU0Y2FkOTIzYWUx
NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zMDMsMTcgKzMwMywyMyBAQCBzdGF0aWMgdm9pZCBtdGtf
aW9tbXVfY29uZmlnKHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSwNCiAJCQkgICAgIHN0cnVj
dCBkZXZpY2UgKmRldiwgYm9vbCBlbmFibGUpDQogew0KIAlzdHJ1Y3QgbXRrX3NtaV9sYXJiX2lv
bW11ICAgICpsYXJiX21tdTsNCi0JdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgICBsYXJiaWQs
IHBvcnRpZDsNCisJdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgICBsYXJiaWQsIHBvcnRpZCwg
ZG9taWQ7DQogCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNf
Z2V0KGRldik7DQorCWNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdpb24gKnJlZ2lvbjsN
CiAJaW50IGk7DQogDQogCWZvciAoaSA9IDA7IGkgPCBmd3NwZWMtPm51bV9pZHM7ICsraSkgew0K
IAkJbGFyYmlkID0gTVRLX000VV9UT19MQVJCKGZ3c3BlYy0+aWRzW2ldKTsNCiAJCXBvcnRpZCA9
IE1US19NNFVfVE9fUE9SVChmd3NwZWMtPmlkc1tpXSk7DQorCQlkb21pZCA9IE1US19NNFVfVE9f
RE9NKGZ3c3BlYy0+aWRzW2ldKTsNCisNCiAJCWxhcmJfbW11ID0gJmRhdGEtPmxhcmJfaW11W2xh
cmJpZF07DQorCQlyZWdpb24gPSBkYXRhLT5wbGF0X2RhdGEtPmlvdmFfcmVnaW9uICsgZG9taWQ7
DQorCQlsYXJiX21tdS0+YmFua1twb3J0aWRdID0gdXBwZXJfMzJfYml0cyhyZWdpb24tPmlvdmFf
YmFzZSk7DQogDQotCQlkZXZfZGJnKGRldiwgIiVzIGlvbW11IHBvcnQ6ICVkXG4iLA0KLQkJCWVu
YWJsZSA/ICJlbmFibGUiIDogImRpc2FibGUiLCBwb3J0aWQpOw0KKwkJZGV2X2RiZyhkZXYsICIl
cyBpb21tdSBmb3IgbGFyYiglcykgcG9ydCAlZCBkb20gJWQgYmFuayAlZC5cbiIsDQorCQkJZW5h
YmxlID8gImVuYWJsZSIgOiAiZGlzYWJsZSIsIGRldl9uYW1lKGxhcmJfbW11LT5kZXYpLA0KKwkJ
CXBvcnRpZCwgZG9taWQsIGxhcmJfbW11LT5iYW5rW3BvcnRpZF0pOw0KIA0KIAkJaWYgKGVuYWJs
ZSkNCiAJCQlsYXJiX21tdS0+bW11IHw9IE1US19TTUlfTU1VX0VOKHBvcnRpZCk7DQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5j
DQppbmRleCBlYzgzZjFhYzQ4YjEuLmU5NGM5OWNhMjg4MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bWVtb3J5L210ay1zbWkuYw0KKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQpAQCAtNDEs
NiArNDEsMTAgQEANCiAvKiBtdDI3MTIgKi8NCiAjZGVmaW5lIFNNSV9MQVJCX05PTlNFQ19DT04o
aWQpCSgweDM4MCArICgoaWQpICogNCkpDQogI2RlZmluZSBGX01NVV9FTgkJQklUKDApDQorI2Rl
ZmluZSBCQU5LX1NFTChpZCkJCSh7CQkJXA0KKwl1MzIgX2lkID0gKGlkKSAmIDB4MzsJCQkJXA0K
KwkoX2lkIDw8IDggfCBfaWQgPDwgMTAgfCBfaWQgPDwgMTIgfCBfaWQgPDwgMTQpOwlcDQorfSkN
CiANCiAvKiBTTUkgQ09NTU9OICovDQogI2RlZmluZSBTTUlfQlVTX1NFTAkJCTB4MjIwDQpAQCAt
ODUsNiArODksNyBAQCBzdHJ1Y3QgbXRrX3NtaV9sYXJiIHsgLyogbGFyYjogbG9jYWwgYXJiaXRl
ciAqLw0KIAljb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbgkqbGFyYl9nZW47DQogCWludAkJ
CQlsYXJiaWQ7DQogCXUzMgkJCQkqbW11Ow0KKwl1bnNpZ25lZCBjaGFyCQkJKmJhbms7DQogfTsN
CiANCiBzdGF0aWMgaW50IG10a19zbWlfY2xrX2VuYWJsZShjb25zdCBzdHJ1Y3QgbXRrX3NtaSAq
c21pKQ0KQEAgLTE1MSw2ICsxNTYsNyBAQCBtdGtfc21pX2xhcmJfYmluZChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3Rlciwgdm9pZCAqZGF0YSkNCiAJCWlmIChkZXYgPT0g
bGFyYl9tbXVbaV0uZGV2KSB7DQogCQkJbGFyYi0+bGFyYmlkID0gaTsNCiAJCQlsYXJiLT5tbXUg
PSAmbGFyYl9tbXVbaV0ubW11Ow0KKwkJCWxhcmItPmJhbmsgPSBsYXJiX21tdVtpXS5iYW5rOw0K
IAkJCXJldHVybiAwOw0KIAkJfQ0KIAl9DQpAQCAtMTY5LDYgKzE3NSw3IEBAIHN0YXRpYyB2b2lk
IG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dlbmVyYWwoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAlmb3JfZWFjaF9zZXRfYml0KGksICh1bnNpZ25lZCBsb25nICopbGFyYi0+bW11LCAzMikg
ew0KIAkJcmVnID0gcmVhZGxfcmVsYXhlZChsYXJiLT5iYXNlICsgU01JX0xBUkJfTk9OU0VDX0NP
TihpKSk7DQogCQlyZWcgfD0gRl9NTVVfRU47DQorCQlyZWcgfD0gQkFOS19TRUwobGFyYi0+YmFu
a1tpXSk7DQogCQl3cml0ZWwocmVnLCBsYXJiLT5iYXNlICsgU01JX0xBUkJfTk9OU0VDX0NPTihp
KSk7DQogCX0NCiB9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmggYi9p
bmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaA0KaW5kZXggOTM3MWJmNTcyYWI4Li40Y2Y0NDVkYmJk
YWEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaA0KKysrIGIvaW5jbHVk
ZS9zb2MvbWVkaWF0ZWsvc21pLmgNCkBAIC0xNiw2ICsxNiw3IEBADQogc3RydWN0IG10a19zbWlf
bGFyYl9pb21tdSB7DQogCXN0cnVjdCBkZXZpY2UgKmRldjsNCiAJdW5zaWduZWQgaW50ICAgbW11
Ow0KKwl1bnNpZ25lZCBjaGFyICBiYW5rWzMyXTsNCiB9Ow0KIA0KIC8qDQotLSANCjIuMTguMA0K


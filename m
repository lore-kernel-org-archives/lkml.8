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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330D42075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oPAmaX60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGKGvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:51:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51578 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728088AbgGKGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:23 -0400
X-UUID: 81a0309cd95e433e82dfbc2cf8b1ea1c-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=48/UK+pMJVg/hE9P6jxoR496KIP33DCqvBZjUELFnFg=;
        b=oPAmaX60uRSx26koi+eRGvtrdI+O9tYh+fohIAUpS8g5CiG9sBtI1yPgpnyToFlTj72BrGIQao6O8WodtAzpm2SgN1+cv740IwhwMW3WmoHUnyc3w844WY0bqc/ec/DrJE4LlMJI+DuqsfhP/M4GlIiwdYMpg+ZTwD6fGYsOh7M=;
X-UUID: 81a0309cd95e433e82dfbc2cf8b1ea1c-20200711
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1958700887; Sat, 11 Jul 2020 14:51:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:14 +0800
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
Subject: [PATCH 10/21] iommu/mediatek: Add device link for smi-common and m4u
Date:   Sat, 11 Jul 2020 14:48:35 +0800
Message-ID: <20200711064846.16007-11-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D5DE7707B4F1FBFA6AF98E44E3207208E81982E452159E1C3B004CE2ACFBD5282000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIGxhc3Rlc3QgU29DLCBNNFUgaGFzIGl0cyBzcGVjaWFsIHBvd2VyIGRvbWFpbi4gdGh1
cywgSWYgdGhlIGVuZ2luZQ0KYmVnaW4gdG8gd29yaywgaXQgc2hvdWxkIGhlbHAgZW5hYmxlIHRo
ZSBwb3dlciBmb3IgTTRVIGZpcnN0bHkuDQpDdXJyZW50bHkgaWYgdGhlIGVuZ2luZSB3b3JrLCBp
dCBhbHdheXMgZW5hYmxlIHRoZSBwb3dlci9jbG9ja3MgZm9yDQpzbWktbGFyYnMvc21pLWNvbW1v
bi4gVGhpcyBwYXRjaCBhZGRzIGRldmljZV9saW5rIGZvciBzbWktY29tbW9uIGFuZCBNNFUuDQp0
aGVuLCBpZiBzbWktY29tbW9uIHBvd2VyIGlzIGVuYWJsZWQsIHRoZSBNNFUgcG93ZXIgYWxzbyBp
cyBwb3dlcmVkIG9uDQphdXRvbWF0aWNhbGx5Lg0KDQpJbiB0aGlzIHBhdGNoLCBhIE00VSBjb25u
ZWN0cyB3aXRoIHNldmVyYWwgc21pLWxhcmJzIGFuZCB0aGVpciBzbWktY29tbW9uDQphbHdheXMg
YXJlIHRoZSBzYW1lLCB0aHVzIGl0IGFkZHMgdGhlIGRldmljZS1saW5rIG9uY2UgaXMgZW5vdWdo
Lg0KQW5kIHRoZSBkZXZpY2VsaW5rIG9ubHkgaXMgbmVlZGVkIHdoaWxlIG00dSBoYXMgcG93ZXIt
ZG9tYWluLg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyNiArKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAgMSArDQogMiBmaWxlcyBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXgg
YTY0MTJkNDU0ZTBiLi45MzFmZGQxOWM4ZjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtNjc1LDggKzY3
NSw5IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogCQlyZXR1cm4gbGFyYl9ucjsNCiANCiAJZm9yIChpID0gMDsgaSA8IGxhcmJfbnI7
IGkrKykgew0KLQkJc3RydWN0IGRldmljZV9ub2RlICpsYXJibm9kZTsNCisJCXN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbGFyYm5vZGUsICpzbWljb21tX25vZGU7DQogCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwbGFyYmRldjsNCisJCXN0cnVjdCBkZXZpY2VfbGluayAqbGluazsNCiAJCXUzMiBpZDsN
CiANCiAJCWxhcmJub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJtZWRpYXRl
ayxsYXJicyIsIGkpOw0KQEAgLTcwMSw2ICs3MDIsMjggQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJCWNvbXBvbmVudF9tYXRj
aF9hZGRfcmVsZWFzZShkZXYsICZtYXRjaCwgcmVsZWFzZV9vZiwNCiAJCQkJCSAgICBjb21wYXJl
X29mLCBsYXJibm9kZSk7DQorDQorCQkvKg0KKwkJICogQWRkIGxpbmsgZm9yIHNtaS1jb21tb24g
YW5kIG00dSBvbmNlIGlzIG9rLiBhbmQgdGhlIGxpbmsgaXMNCisJCSAqIG9ubHkgbmVlZGVkIHdo
aWxlIG00dSBoYXMgcG93ZXItZG9tYWluLg0KKwkJICovDQorCQlpZiAoaSB8fCAhcG1fcnVudGlt
ZV9lbmFibGVkKGRldikpDQorCQkJY29udGludWU7DQorDQorCQlzbWljb21tX25vZGUgPSBvZl9w
YXJzZV9waGFuZGxlKGxhcmJub2RlLCAibWVkaWF0ZWssc21pIiwgMCk7DQorCQlpZiAoIXNtaWNv
bW1fbm9kZSkgew0KKwkJCW9mX25vZGVfcHV0KGxhcmJub2RlKTsNCisJCQlyZXR1cm4gLUVJTlZB
TDsNCisJCX0NCisNCisJCXBsYXJiZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShzbWljb21t
X25vZGUpOw0KKwkJb2Zfbm9kZV9wdXQoc21pY29tbV9ub2RlKTsNCisJCWRhdGEtPnNtaWNvbW1f
ZGV2ID0gJnBsYXJiZGV2LT5kZXY7DQorDQorCQlsaW5rID0gZGV2aWNlX2xpbmtfYWRkKCZwbGFy
YmRldi0+ZGV2LCBkZXYsDQorCQkJCSAgICAgICBETF9GTEFHX1NUQVRFTEVTUyB8IERMX0ZMQUdf
UE1fUlVOVElNRSk7DQorCQlpZiAoIWxpbmspDQorCQkJZGV2X2VycihkZXYsICJVbmFibGUgbGlu
ayAlcy5cbiIsIHBsYXJiZGV2LT5uYW1lKTsNCiAJfQ0KIA0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0
YShwZGV2LCBkYXRhKTsNCkBAIC03NDAsNiArNzYzLDcgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWlmIChpb21tdV9wcmVzZW50
KCZwbGF0Zm9ybV9idXNfdHlwZSkpDQogCQlidXNfc2V0X2lvbW11KCZwbGF0Zm9ybV9idXNfdHlw
ZSwgTlVMTCk7DQogDQorCWRldmljZV9saW5rX3JlbW92ZShkYXRhLT5zbWljb21tX2RldiwgJnBk
ZXYtPmRldik7DQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRhLT5iY2xrKTsNCiAJZGV2bV9m
cmVlX2lycSgmcGRldi0+ZGV2LCBkYXRhLT5pcnEsIGRhdGEpOw0KIAljb21wb25lbnRfbWFzdGVy
X2RlbCgmcGRldi0+ZGV2LCAmbXRrX2lvbW11X2NvbV9vcHMpOw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCAx
YTA4N2FmNTBhNGUuLmU5NjViY2IxNjljMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC02Niw2ICs2Niw3
IEBAIHN0cnVjdCBtdGtfaW9tbXVfZGF0YSB7DQogDQogCXN0cnVjdCBpb21tdV9kZXZpY2UJCWlv
bW11Ow0KIAljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSAqcGxhdF9kYXRhOw0KKwlz
dHJ1Y3QgZGV2aWNlCQkJKnNtaWNvbW1fZGV2Ow0KIA0KIAlzdHJ1Y3QgbGlzdF9oZWFkCQlsaXN0
Ow0KIAlzdHJ1Y3QgbXRrX3NtaV9sYXJiX2lvbW11CWxhcmJfaW11W01US19MQVJCX05SX01BWF07
DQotLSANCjIuMTguMA0K


Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9672EC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E3C20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LZXfok9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgGKGw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36895 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:27 -0400
X-UUID: d00f0842725b4934b79905f092bbc8fc-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i+xI+KeJuezDZCl6yM9uO3x45152AOUlch6QK5pwCQk=;
        b=LZXfok9ig7/OmOzfQGA1FLxgGHqe/1TYwmxbA36TrTczirJv3cVfPLEy5gwcob8R7EtS+95yBTEmEC8uayDYz3z0opliqpP2ueBoVWUUAA06BVRmrRsaSA1Pt64el0Af1an5xY+SdDUL2UIR1kYHZdiOR3hh5ck6l5G14W9DCls=;
X-UUID: d00f0842725b4934b79905f092bbc8fc-20200711
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 619948064; Sat, 11 Jul 2020 14:52:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:18 +0800
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
Subject: [PATCH 17/21] iommu/mediatek: Support report iova 34bit translation fault in ISR
Date:   Sat, 11 Jul 2020 14:48:42 +0800
Message-ID: <20200711064846.16007-18-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E322B87B68A8DC1470E5469B2953FD5E87CB7C7BC1EDF1B4D37DF27B250DBE302000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlvdmEgaXMgb3ZlciAzMmJpdCwgdGhlIGZhdWx0IHN0YXR1cyByZWdpc3RlciBiaXQg
aXMgYSBsaXR0bGUNCmRpZmZlcmVudC4gQWRkIGEgZmxhZyBmb3IgdGhlIHNwZWNpYWwgcmVnaXN0
ZXIgYml0cy4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTggKysrKysrKysrKysrKysrKy0t
DQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KaW5kZXggOWM2NjQ5YTk3YmQ3Li43NjZjOWU3M2Q1NDEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQpAQCAtNCw2ICs0LDcgQEANCiAgKiBBdXRob3I6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsu
Y29tPg0KICAqLw0KICNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KKyNpbmNsdWRlIDxsaW51
eC9iaXRmaWVsZC5oPg0KICNpbmNsdWRlIDxsaW51eC9idWcuaD4NCiAjaW5jbHVkZSA8bGludXgv
Y2xrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KQEAgLTg3LDYgKzg4LDkgQEAN
CiAjZGVmaW5lIEZfUkVHX01NVTFfRkFVTFRfTUFTSwkJCUdFTk1BU0soMTMsIDcpDQogDQogI2Rl
ZmluZSBSRUdfTU1VMF9GQVVMVF9WQQkJCTB4MTNjDQorI2RlZmluZSBGX01NVV9JTlZBTF9WQV8z
MV8xMl9NQVNLCQlHRU5NQVNLKDMxLCAxMikNCisjZGVmaW5lIEZfTU1VX0lOVkFMX1ZBXzM0XzMy
X01BU0sJCUdFTk1BU0soMTEsIDkpDQorI2RlZmluZSBGX01NVV9JTlZBTF9QQV8zNF8zMl9NQVNL
CQlHRU5NQVNLKDgsIDYpDQogI2RlZmluZSBGX01NVV9GQVVMVF9WQV9XUklURV9CSVQJCUJJVCgx
KQ0KICNkZWZpbmUgRl9NTVVfRkFVTFRfVkFfTEFZRVJfQklUCQlCSVQoMCkNCiANCkBAIC0xMTAs
NiArMTE0LDcgQEANCiAjZGVmaW5lIE9VVF9PUkRFUl9XUl9FTgkJCUJJVCg0KQ0KICNkZWZpbmUg
SEFTX1NVQl9DT01NCQkJQklUKDUpDQogI2RlZmluZSBXUl9USFJPVF9FTgkJCUJJVCg2KQ0KKyNk
ZWZpbmUgSU9WQV8zNF9FTgkJCUJJVCg3KQ0KIA0KICNkZWZpbmUgTVRLX0lPTU1VX0hBU19GTEFH
KHBkYXRhLCBfeCkgXA0KIAkJKCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkgPT0gKF94KSkNCkBA
IC0yNjksOCArMjc0LDkgQEAgc3RhdGljIGlycXJldHVybl90IG10a19pb21tdV9pc3IoaW50IGly
cSwgdm9pZCAqZGV2X2lkKQ0KIHsNCiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2
X2lkOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tID0gZGF0YS0+bTR1X2RvbTsNCi0J
dTMyIGludF9zdGF0ZSwgcmVndmFsLCBmYXVsdF9pb3ZhLCBmYXVsdF9wYTsNCiAJdW5zaWduZWQg
aW50IGZhdWx0X2xhcmIsIGZhdWx0X3BvcnQsIHN1Yl9jb21tID0gMDsNCisJdTMyIGludF9zdGF0
ZSwgcmVndmFsLCB2YTM0XzMyLCBwYTM0XzMyOw0KKwl1NjQgZmF1bHRfaW92YSwgZmF1bHRfcGE7
DQogCWJvb2wgbGF5ZXIsIHdyaXRlOw0KIA0KIAkvKiBSZWFkIGVycm9yIGluZm8gZnJvbSByZWdp
c3RlcnMgKi8NCkBAIC0yODYsNiArMjkyLDE0IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9t
bXVfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCiAJfQ0KIAlsYXllciA9IGZhdWx0X2lvdmEg
JiBGX01NVV9GQVVMVF9WQV9MQVlFUl9CSVQ7DQogCXdyaXRlID0gZmF1bHRfaW92YSAmIEZfTU1V
X0ZBVUxUX1ZBX1dSSVRFX0JJVDsNCisJaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0
X2RhdGEsIElPVkFfMzRfRU4pKSB7DQorCQl2YTM0XzMyID0gRklFTERfR0VUKEZfTU1VX0lOVkFM
X1ZBXzM0XzMyX01BU0ssIGZhdWx0X2lvdmEpOw0KKwkJcGEzNF8zMiA9IEZJRUxEX0dFVChGX01N
VV9JTlZBTF9QQV8zNF8zMl9NQVNLLCBmYXVsdF9pb3ZhKTsNCisJCWZhdWx0X2lvdmEgPSBmYXVs
dF9pb3ZhICYgRl9NTVVfSU5WQUxfVkFfMzFfMTJfTUFTSzsNCisJCWZhdWx0X2lvdmEgfD0gICh1
NjQpdmEzNF8zMiA8PCAzMjsNCisJCWZhdWx0X3BhIHw9ICh1NjQpcGEzNF8zMiA8PCAzMjsNCisJ
fQ0KKw0KIAlmYXVsdF9wb3J0ID0gRl9NTVVfSU5UX0lEX1BPUlRfSUQocmVndmFsKTsNCiAJaWYg
KE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhBU19TVUJfQ09NTSkpIHsNCiAJ
CWZhdWx0X2xhcmIgPSBGX01NVV9JTlRfSURfQ09NTV9JRChyZWd2YWwpOw0KQEAgLTI5OSw3ICsz
MTMsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2lvbW11X2lzcihpbnQgaXJxLCB2b2lkICpk
ZXZfaWQpDQogCQkJICAgICAgIHdyaXRlID8gSU9NTVVfRkFVTFRfV1JJVEUgOiBJT01NVV9GQVVM
VF9SRUFEKSkgew0KIAkJZGV2X2Vycl9yYXRlbGltaXRlZCgNCiAJCQlkYXRhLT5kZXYsDQotCQkJ
ImZhdWx0IHR5cGU9MHgleCBpb3ZhPTB4JXggcGE9MHgleCBsYXJiPSVkIHBvcnQ9JWQgbGF5ZXI9
JWQgJXNcbiIsDQorCQkJImZhdWx0IHR5cGU9MHgleCBpb3ZhPTB4JWxseCBwYT0weCVsbHggbGFy
Yj0lZCBwb3J0PSVkIGxheWVyPSVkICVzXG4iLA0KIAkJCWludF9zdGF0ZSwgZmF1bHRfaW92YSwg
ZmF1bHRfcGEsIGZhdWx0X2xhcmIsIGZhdWx0X3BvcnQsDQogCQkJbGF5ZXIsIHdyaXRlID8gIndy
aXRlIiA6ICJyZWFkIik7DQogCX0NCi0tIA0KMi4xOC4wDQo=


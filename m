Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4CAC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1608320757
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rr1eBPx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIEIO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:14:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28111 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726590AbgIEIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:14:25 -0400
X-UUID: 9918ef2972f745c5a988aa7a270bf88f-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PIbXELuPQjFkrh0UItyRLEdShKd20XSdsaqHYcx2M7M=;
        b=rr1eBPx0oPeFlvwAuoX2D4uFBnObgwj+qUM3EUeSVKjeWAd7zjsI3pgAurYMx6q3zJTNv+z8BY9+0BnYRMqZLb+YlGdLPsdWJ+qV/SlJ0Vh4TaZb36YtS/bT2NnQWLyk402PuioirzuyFdwkP3c9iuHTvr4exr9kTpMtCnke5BE=;
X-UUID: 9918ef2972f745c5a988aa7a270bf88f-20200905
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1730784127; Sat, 05 Sep 2020 16:14:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:14:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:14:17 +0800
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
Subject: [PATCH v2 19/23] iommu/mediatek: Support report iova 34bit translation fault in ISR
Date:   Sat, 5 Sep 2020 16:09:16 +0800
Message-ID: <20200905080920.13396-20-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3105DFC150F724EE161285D9AE1E3D08F98FB508E4D67BFC24705C50D97D03932000:8
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
aW9tbXUuYw0KaW5kZXggOWZlOWE3MDY3NDJjLi40ZGE5MmU1NzM5ZjMgMTAwNjQ0DQotLS0gYS9k
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
IC0yNTgsOCArMjYzLDkgQEAgc3RhdGljIGlycXJldHVybl90IG10a19pb21tdV9pc3IoaW50IGly
cSwgdm9pZCAqZGV2X2lkKQ0KIHsNCiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2
X2lkOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tID0gZGF0YS0+bTR1X2RvbTsNCi0J
dTMyIGludF9zdGF0ZSwgcmVndmFsLCBmYXVsdF9pb3ZhLCBmYXVsdF9wYTsNCiAJdW5zaWduZWQg
aW50IGZhdWx0X2xhcmIsIGZhdWx0X3BvcnQsIHN1Yl9jb21tID0gMDsNCisJdTMyIGludF9zdGF0
ZSwgcmVndmFsLCB2YTM0XzMyLCBwYTM0XzMyOw0KKwl1NjQgZmF1bHRfaW92YSwgZmF1bHRfcGE7
DQogCWJvb2wgbGF5ZXIsIHdyaXRlOw0KIA0KIAkvKiBSZWFkIGVycm9yIGluZm8gZnJvbSByZWdp
c3RlcnMgKi8NCkBAIC0yNzUsNiArMjgxLDE0IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9t
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
CWZhdWx0X2xhcmIgPSBGX01NVV9JTlRfSURfQ09NTV9JRChyZWd2YWwpOw0KQEAgLTI4OCw3ICsz
MDIsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2lvbW11X2lzcihpbnQgaXJxLCB2b2lkICpk
ZXZfaWQpDQogCQkJICAgICAgIHdyaXRlID8gSU9NTVVfRkFVTFRfV1JJVEUgOiBJT01NVV9GQVVM
VF9SRUFEKSkgew0KIAkJZGV2X2Vycl9yYXRlbGltaXRlZCgNCiAJCQlkYXRhLT5kZXYsDQotCQkJ
ImZhdWx0IHR5cGU9MHgleCBpb3ZhPTB4JXggcGE9MHgleCBsYXJiPSVkIHBvcnQ9JWQgbGF5ZXI9
JWQgJXNcbiIsDQorCQkJImZhdWx0IHR5cGU9MHgleCBpb3ZhPTB4JWxseCBwYT0weCVsbHggbGFy
Yj0lZCBwb3J0PSVkIGxheWVyPSVkICVzXG4iLA0KIAkJCWludF9zdGF0ZSwgZmF1bHRfaW92YSwg
ZmF1bHRfcGEsIGZhdWx0X2xhcmIsIGZhdWx0X3BvcnQsDQogCQkJbGF5ZXIsIHdyaXRlID8gIndy
aXRlIiA6ICJyZWFkIik7DQogCX0NCi0tIA0KMi4xOC4wDQo=


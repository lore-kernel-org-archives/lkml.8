Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26285C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AEB207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GmcOmGcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgICDYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:24:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61351 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgICDX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:23:56 -0400
X-UUID: c250b6da12e94d0688d4db0d5f1c92eb-20200903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6GC5eAEhDoBuRbi+wwESswcqG++nDs52pqdjgqQ4Kzg=;
        b=GmcOmGcg5ODq6pzJRiuKhETv8OU3gliwCfSKMW5Ig+47/NOSeoSt6G8HjqF9gCh+PpBnSKZrJ65ZezowOkJugJR/F23Yy+HXcvwK4l+xVh5N/vcDUJdgO+ra0Kjdi5RM181Lb57TTny1jDTu1KprBf0yvz7KC7+altu74mn1LCc=;
X-UUID: c250b6da12e94d0688d4db0d5f1c92eb-20200903
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 698853126; Thu, 03 Sep 2020 11:23:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Sep 2020 11:23:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Sep 2020 11:23:25 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH v3 8/9] clk: mediatek: Add configurable enable control to mtk_pll_data
Date:   Thu, 3 Sep 2020 11:22:59 +0800
Message-ID: <1599103380-4155-9-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
References: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gYWxsIE1lZGlhVGVrIFBMTCBkZXNpZ24sIGJpdDAgb2YgQ09OMCByZWdpc3RlciBpcyBhbHdh
eXMNCnRoZSBlbmFibGUgYml0Lg0KSG93ZXZlciwgdGhlcmUncyBhIHNwZWNpYWwgY2FzZSBvZiB1
c2JwbGwgb24gTVQ4MTkyLg0KVGhlIGVuYWJsZSBiaXQgb2YgdXNicGxsIGlzIG1vdmVkIHRvIGJp
dDIgb2Ygb3RoZXIgcmVnaXN0ZXIuDQpBZGQgY29uZmlndXJhYmxlIGVuX3JlZyBhbmQgcGxsX2Vu
X2JpdCBmb3IgZW5hYmxlIGNvbnRyb2wgb3INCmRlZmF1bHQgMCB3aGVyZSBwbGwgZGF0YSBhcmUg
c3RhdGljIHZhcmlhYmxlcy4NCkhlbmNlLCBDT04wX0JBU0VfRU4gY291bGQgYWxzbyBiZSByZW1v
dmVkLg0KQW5kIHRoZXJlIG1pZ2h0IGhhdmUgYW5vdGhlciBzcGVjaWFsIGNhc2Ugb24gb3RoZXIg
Y2hpcHMsDQp0aGUgZW5hYmxlIGJpdCBpcyBzdGlsbCBvbiBDT04wIHJlZ2lzdGVyIGJ1dCBub3Qg
YXQgYml0MC4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaCB8ICAyICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jIHwgMTYgKysrKysrKysrKy0tLS0tLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaCBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Ns
ay1tdGsuaA0KaW5kZXggYzNkNjc1Ni4uYzU4MDY2MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdGsuaA0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5o
DQpAQCAtMjMzLDYgKzIzMyw4IEBAIHN0cnVjdCBtdGtfcGxsX2RhdGEgew0KIAl1aW50MzJfdCBw
Y3dfY2hnX3JlZzsNCiAJY29uc3Qgc3RydWN0IG10a19wbGxfZGl2X3RhYmxlICpkaXZfdGFibGU7
DQogCWNvbnN0IGNoYXIgKnBhcmVudF9uYW1lOw0KKwl1aW50MzJfdCBlbl9yZWc7DQorCXVpbnQ4
X3QgcGxsX2VuX2JpdDsgLyogQXNzdW1lIDAsIGluZGljYXRlcyBCSVQoMCkgYnkgZGVmYXVsdCAq
Lw0KIH07DQogDQogdm9pZCBtdGtfY2xrX3JlZ2lzdGVyX3BsbHMoc3RydWN0IGRldmljZV9ub2Rl
ICpub2RlLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0KaW5kZXggZTBiMDBiYy4uYmQ5MTExMyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0KKysrIGIvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQpAQCAtMTYsNyArMTYsNiBAQA0KICNkZWZpbmUgUkVHX0NP
TjAJCTANCiAjZGVmaW5lIFJFR19DT04xCQk0DQogDQotI2RlZmluZSBDT04wX0JBU0VfRU4JCUJJ
VCgwKQ0KICNkZWZpbmUgQ09OMF9QV1JfT04JCUJJVCgwKQ0KICNkZWZpbmUgQ09OMF9JU09fRU4J
CUJJVCgxKQ0KICNkZWZpbmUgUENXX0NIR19NQVNLCQlCSVQoMzEpDQpAQCAtNDQsNiArNDMsNyBA
QCBzdHJ1Y3QgbXRrX2Nsa19wbGwgew0KIAl2b2lkIF9faW9tZW0JKnR1bmVyX2VuX2FkZHI7DQog
CXZvaWQgX19pb21lbQkqcGN3X2FkZHI7DQogCXZvaWQgX19pb21lbQkqcGN3X2NoZ19hZGRyOw0K
Kwl2b2lkIF9faW9tZW0JKmVuX2FkZHI7DQogCWNvbnN0IHN0cnVjdCBtdGtfcGxsX2RhdGEgKmRh
dGE7DQogfTsNCiANCkBAIC01Niw3ICs1Niw3IEBAIHN0YXRpYyBpbnQgbXRrX3BsbF9pc19wcmVw
YXJlZChzdHJ1Y3QgY2xrX2h3ICpodykNCiB7DQogCXN0cnVjdCBtdGtfY2xrX3BsbCAqcGxsID0g
dG9fbXRrX2Nsa19wbGwoaHcpOw0KIA0KLQlyZXR1cm4gKHJlYWRsKHBsbC0+YmFzZV9hZGRyICsg
UkVHX0NPTjApICYgQ09OMF9CQVNFX0VOKSAhPSAwOw0KKwlyZXR1cm4gKHJlYWRsKHBsbC0+ZW5f
YWRkcikgJiBCSVQocGxsLT5kYXRhLT5wbGxfZW5fYml0KSkgIT0gMDsNCiB9DQogDQogc3RhdGlj
IHVuc2lnbmVkIGxvbmcgX19tdGtfcGxsX3JlY2FsY19yYXRlKHN0cnVjdCBtdGtfY2xrX3BsbCAq
cGxsLCB1MzIgZmluLA0KQEAgLTI0Nyw4ICsyNDcsOCBAQCBzdGF0aWMgaW50IG10a19wbGxfcHJl
cGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCiAJd3JpdGVsKHIsIHBsbC0+cHdyX2FkZHIpOw0KIAl1
ZGVsYXkoMSk7DQogDQotCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKSB8IENP
TjBfQkFTRV9FTjsNCi0Jd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KKwly
ID0gcmVhZGwocGxsLT5lbl9hZGRyKSB8IEJJVChwbGwtPmRhdGEtPnBsbF9lbl9iaXQpOw0KKwl3
cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCiANCiAJaWYgKHBsbC0+ZGF0YS0+ZW5fbWFzaykgew0K
IAkJciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApIHwgcGxsLT5kYXRhLT5lbl9t
YXNrOw0KQEAgLTI4Niw4ICsyODYsOCBAQCBzdGF0aWMgdm9pZCBtdGtfcGxsX3VucHJlcGFyZShz
dHJ1Y3QgY2xrX2h3ICpodykNCiAJCXdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04w
KTsNCiAJfQ0KIA0KLQlyID0gcmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCkgJiB+Q09O
MF9CQVNFX0VOOw0KLQl3cml0ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQorCXIg
PSByZWFkbChwbGwtPmVuX2FkZHIpICYgfkJJVChwbGwtPmRhdGEtPnBsbF9lbl9iaXQpOw0KKwl3
cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCiANCiAJciA9IHJlYWRsKHBsbC0+cHdyX2FkZHIpIHwg
Q09OMF9JU09fRU47DQogCXdyaXRlbChyLCBwbGwtPnB3cl9hZGRyKTsNCkBAIC0zMjksNiArMzI5
LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xrICptdGtfY2xrX3JlZ2lzdGVyX3BsbChjb25zdCBzdHJ1
Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0KIAkJcGxsLT50dW5lcl9hZGRyID0gYmFzZSArIGRhdGEt
PnR1bmVyX3JlZzsNCiAJaWYgKGRhdGEtPnR1bmVyX2VuX3JlZykNCiAJCXBsbC0+dHVuZXJfZW5f
YWRkciA9IGJhc2UgKyBkYXRhLT50dW5lcl9lbl9yZWc7DQorCWlmIChkYXRhLT5lbl9yZWcpDQor
CQlwbGwtPmVuX2FkZHIgPSBiYXNlICsgZGF0YS0+ZW5fcmVnOw0KKwllbHNlDQorCQlwbGwtPmVu
X2FkZHIgPSBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wOw0KIAlwbGwtPmh3LmluaXQgPSAmaW5p
dDsNCiAJcGxsLT5kYXRhID0gZGF0YTsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K


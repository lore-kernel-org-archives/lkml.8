Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AF12076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PqGRqO6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgG2Iow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:44:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61277 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbgG2Iov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:44:51 -0400
X-UUID: 4668ce90530145b4923c48b6407d23c2-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=icLm6g1748z7DYcLHifdFYxCZ/ADR68roycANjVA/Jg=;
        b=PqGRqO6W7K9DWfOZHSROsp1g3F04HXteXl7aZhZCZ5GFSQrPwpz1PTkwHLLHzgtKToUv3ikbp5HSfCjaIRXpPcHhlFpy2mvjDvAI1B2NKyU4BAHgtvokhTNgsRD2W3hTaagLWpaSQ8++uR9AODRkp954oIwUtu482KDlnym3K50=;
X-UUID: 4668ce90530145b4923c48b6407d23c2-20200729
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1210015455; Wed, 29 Jul 2020 16:44:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 16:44:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 16:44:46 +0800
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
Subject: [PATCH v2 4/5] clk: mediatek: Add configurable enable control to mtk_pll_data
Date:   Wed, 29 Jul 2020 16:44:36 +0800
Message-ID: <1596012277-8448-5-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com>
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com>
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
cy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jIHwgMTggKysrKysrKysrKystLS0tLS0tDQogMiBmaWxl
cyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
Y2xrLW10ay5oDQppbmRleCBjM2Q2NzU2Li44MTBlYjk3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ay5oDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRr
LmgNCkBAIC0yMzMsNiArMjMzLDggQEAgc3RydWN0IG10a19wbGxfZGF0YSB7DQogCXVpbnQzMl90
IHBjd19jaGdfcmVnOw0KIAljb25zdCBzdHJ1Y3QgbXRrX3BsbF9kaXZfdGFibGUgKmRpdl90YWJs
ZTsNCiAJY29uc3QgY2hhciAqcGFyZW50X25hbWU7DQorCXVpbnQzMl90IGVuX3JlZzsNCisJdWlu
dDhfdCBwbGxfZW5fYml0Ow0KIH07DQogDQogdm9pZCBtdGtfY2xrX3JlZ2lzdGVyX3BsbHMoc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1wbGwuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0KaW5kZXggM2M3OWUx
YS4uMTQzNGU5OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0K
KysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQpAQCAtMTYsNyArMTYsNiBAQA0K
ICNkZWZpbmUgUkVHX0NPTjAJCTANCiAjZGVmaW5lIFJFR19DT04xCQk0DQogDQotI2RlZmluZSBD
T04wX0JBU0VfRU4JCUJJVCgwKQ0KICNkZWZpbmUgQ09OMF9QV1JfT04JCUJJVCgwKQ0KICNkZWZp
bmUgQ09OMF9JU09fRU4JCUJJVCgxKQ0KICNkZWZpbmUgUENXX0NIR19NQVNLCQlCSVQoMzEpDQpA
QCAtNDQsNiArNDMsNyBAQCBzdHJ1Y3QgbXRrX2Nsa19wbGwgew0KIAl2b2lkIF9faW9tZW0JKnR1
bmVyX2VuX2FkZHI7DQogCXZvaWQgX19pb21lbQkqcGN3X2FkZHI7DQogCXZvaWQgX19pb21lbQkq
cGN3X2NoZ19hZGRyOw0KKwl2b2lkIF9faW9tZW0JKmVuX2FkZHI7DQogCWNvbnN0IHN0cnVjdCBt
dGtfcGxsX2RhdGEgKmRhdGE7DQogfTsNCiANCkBAIC01Niw3ICs1Niw3IEBAIHN0YXRpYyBpbnQg
bXRrX3BsbF9pc19wcmVwYXJlZChzdHJ1Y3QgY2xrX2h3ICpodykNCiB7DQogCXN0cnVjdCBtdGtf
Y2xrX3BsbCAqcGxsID0gdG9fbXRrX2Nsa19wbGwoaHcpOw0KIA0KLQlyZXR1cm4gKHJlYWRsKHBs
bC0+YmFzZV9hZGRyICsgUkVHX0NPTjApICYgQ09OMF9CQVNFX0VOKSAhPSAwOw0KKwlyZXR1cm4g
KHJlYWRsKHBsbC0+ZW5fYWRkcikgJiBCSVQocGxsLT5kYXRhLT5wbGxfZW5fYml0KSkgIT0gMDsN
CiB9DQogDQogc3RhdGljIHVuc2lnbmVkIGxvbmcgX19tdGtfcGxsX3JlY2FsY19yYXRlKHN0cnVj
dCBtdGtfY2xrX3BsbCAqcGxsLCB1MzIgZmluLA0KQEAgLTI0Nyw4ICsyNDcsOCBAQCBzdGF0aWMg
aW50IG10a19wbGxfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCiAJd3JpdGVsKHIsIHBsbC0+
cHdyX2FkZHIpOw0KIAl1ZGVsYXkoMSk7DQogDQotCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciAr
IFJFR19DT04wKSB8IENPTjBfQkFTRV9FTjsNCi0Jd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsg
UkVHX0NPTjApOw0KKwlyID0gcmVhZGwocGxsLT5lbl9hZGRyKSB8IEJJVChwbGwtPmRhdGEtPnBs
bF9lbl9iaXQpOw0KKwl3cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCiANCiAJciA9IHJlYWRsKHBs
bC0+YmFzZV9hZGRyICsgUkVHX0NPTjApIHwgcGxsLT5kYXRhLT5lbl9tYXNrOw0KIAl3cml0ZWwo
ciwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQpAQCAtMjgzLDkgKzI4Myw5IEBAIHN0YXRp
YyB2b2lkIG10a19wbGxfdW5wcmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KIAlyICY9IH5wbGwt
PmRhdGEtPmVuX21hc2s7DQogCXdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsN
CiANCi0JciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KLQlyICY9IH5DT04w
X0JBU0VfRU47DQotCXdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCisJciA9
IHJlYWRsKHBsbC0+ZW5fYWRkcik7DQorCXIgJj0gfkJJVChwbGwtPmRhdGEtPnBsbF9lbl9iaXQp
Ow0KKwl3cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCiANCiAJciA9IHJlYWRsKHBsbC0+cHdyX2Fk
ZHIpIHwgQ09OMF9JU09fRU47DQogCXdyaXRlbChyLCBwbGwtPnB3cl9hZGRyKTsNCkBAIC0zMjcs
NiArMzI3LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xrICptdGtfY2xrX3JlZ2lzdGVyX3BsbChjb25z
dCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0KIAkJcGxsLT50dW5lcl9hZGRyID0gYmFzZSAr
IGRhdGEtPnR1bmVyX3JlZzsNCiAJaWYgKGRhdGEtPnR1bmVyX2VuX3JlZykNCiAJCXBsbC0+dHVu
ZXJfZW5fYWRkciA9IGJhc2UgKyBkYXRhLT50dW5lcl9lbl9yZWc7DQorCWlmIChkYXRhLT5lbl9y
ZWcpDQorCQlwbGwtPmVuX2FkZHIgPSBiYXNlICsgZGF0YS0+ZW5fcmVnOw0KKwllbHNlDQorCQlw
bGwtPmVuX2FkZHIgPSBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wOw0KIAlwbGwtPmh3LmluaXQg
PSAmaW5pdDsNCiAJcGxsLT5kYXRhID0gZGF0YTsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K


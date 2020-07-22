Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3425A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hFPE3BNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgGVGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:50:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7646 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727922AbgGVGuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:50:10 -0400
X-UUID: 5920cdbb1629478e95836c804a6b1bc6-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xL2c15rMm6n2+VIEB3St5dv1LPcg+CbSCv0clpzLX0E=;
        b=hFPE3BNubhi0y7W+oB6eZ/O5Zh3clLYHzaY8SOnESE3KvTYlI33/OYSEvUjdgFUX6Ikhqp6zIT7Dspg3vA0flQlMcRlYmuyhZNBtHXkEsQfZ52Z4oSihYAq4b4tNiX3Kv8T2FCtJ4MNip4ymIZItTuO4dpRgWl2llHHKRepN5ww=;
X-UUID: 5920cdbb1629478e95836c804a6b1bc6-20200722
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 66332343; Wed, 22 Jul 2020 14:50:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 14:50:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 14:50:03 +0800
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
Subject: [PATCH 3/4] clk: mediatek: Add configurable enable control to mtk_pll_data
Date:   Wed, 22 Jul 2020 14:50:00 +0800
Message-ID: <1595400601-26220-4-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595400601-26220-1-git-send-email-weiyi.lu@mediatek.com>
References: <1595400601-26220-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8AB9C873B56F031AD0C2855AC0E93D53A97E5A87F77F9EDAA49315D4E812308E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gYWxsIE1lZGlhVGVrIFBMTCBkZXNpZ24sIGJpdCAwIG9mIENPTjAgcmVnaXN0ZXIgaXMgYWx3
YXlzDQp0aGUgZW5hYmxlIGJpdC4NCkhvd2V2ZXIsIHRoZXJlJ3MgYSBzcGVjaWFsIGNhc2Ugb2Yg
dXNicGxsIG9uIE1UODE5Mi4NClRoZSBlbmFibGUgYml0IG9mIHVzYnBsbCBpcyBtb3ZlZCB0byBi
aXQgMiBvZiBvdGhlciByZWdpc3Rlci4NCkFkZCBjb25maWd1cmFibGUgZW5fcmVnIGFuZCBiYXNl
X2VuX2JpdCBmb3IgZW5hYmxlIGNvbnRyb2wgb3INCnVzaW5nIHRoZSBkZWZhdWx0IGlmIHdpdGhv
dXQgc2V0dGluZyBpbiBwbGwgZGF0YS4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlp
Lmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaCB8
ICAyICsrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKy0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgg
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgNCmluZGV4IGMzZDY3NTYuLjhiYjBiM2Qg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgNCisrKyBiL2RyaXZl
cnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaA0KQEAgLTIzMyw2ICsyMzMsOCBAQCBzdHJ1Y3QgbXRr
X3BsbF9kYXRhIHsNCiAJdWludDMyX3QgcGN3X2NoZ19yZWc7DQogCWNvbnN0IHN0cnVjdCBtdGtf
cGxsX2Rpdl90YWJsZSAqZGl2X3RhYmxlOw0KIAljb25zdCBjaGFyICpwYXJlbnRfbmFtZTsNCisJ
dWludDMyX3QgZW5fcmVnOw0KKwl1aW50OF90IGJhc2VfZW5fYml0Ow0KIH07DQogDQogdm9pZCBt
dGtfY2xrX3JlZ2lzdGVyX3BsbHMoc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1wbGwuYw0KaW5kZXggZjQ0MGYyY2QuLmI4Y2NkNDIgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstcGxsLmMNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1w
bGwuYw0KQEAgLTQ0LDYgKzQ0LDcgQEAgc3RydWN0IG10a19jbGtfcGxsIHsNCiAJdm9pZCBfX2lv
bWVtCSp0dW5lcl9lbl9hZGRyOw0KIAl2b2lkIF9faW9tZW0JKnBjd19hZGRyOw0KIAl2b2lkIF9f
aW9tZW0JKnBjd19jaGdfYWRkcjsNCisJdm9pZCBfX2lvbWVtCSplbl9hZGRyOw0KIAljb25zdCBz
dHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhOw0KIH07DQogDQpAQCAtNTYsNyArNTcsMTAgQEAgc3Rh
dGljIGludCBtdGtfcGxsX2lzX3ByZXBhcmVkKHN0cnVjdCBjbGtfaHcgKmh3KQ0KIHsNCiAJc3Ry
dWN0IG10a19jbGtfcGxsICpwbGwgPSB0b19tdGtfY2xrX3BsbChodyk7DQogDQotCXJldHVybiAo
cmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCkgJiBDT04wX0JBU0VfRU4pICE9IDA7DQor
CWlmIChwbGwtPmVuX2FkZHIpDQorCQlyZXR1cm4gKHJlYWRsKHBsbC0+ZW5fYWRkcikgJiBCSVQo
cGxsLT5kYXRhLT5iYXNlX2VuX2JpdCkpICE9IDA7DQorCWVsc2UNCisJCXJldHVybiAocmVhZGwo
cGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCkgJiBDT04wX0JBU0VfRU4pICE9IDA7DQogfQ0KIA0K
IHN0YXRpYyB1bnNpZ25lZCBsb25nIF9fbXRrX3BsbF9yZWNhbGNfcmF0ZShzdHJ1Y3QgbXRrX2Ns
a19wbGwgKnBsbCwgdTMyIGZpbiwNCkBAIC0yNTEsNiArMjU1LDEyIEBAIHN0YXRpYyBpbnQgbXRr
X3BsbF9wcmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KIAlyIHw9IHBsbC0+ZGF0YS0+ZW5fbWFz
azsNCiAJd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KIA0KKwlpZiAocGxs
LT5lbl9hZGRyKSB7DQorCQlyID0gcmVhZGwocGxsLT5lbl9hZGRyKTsNCisJCXIgfD0gQklUKHBs
bC0+ZGF0YS0+YmFzZV9lbl9iaXQpOw0KKwkJd3JpdGVsKHIsIHBsbC0+ZW5fYWRkcik7DQorCX0N
CisNCiAJX19tdGtfcGxsX3R1bmVyX2VuYWJsZShwbGwpOw0KIA0KIAl1ZGVsYXkoMjApOw0KQEAg
LTI3Nyw5ICsyODcsMTUgQEAgc3RhdGljIHZvaWQgbXRrX3BsbF91bnByZXBhcmUoc3RydWN0IGNs
a19odyAqaHcpDQogDQogCV9fbXRrX3BsbF90dW5lcl9kaXNhYmxlKHBsbCk7DQogDQotCXIgPSBy
ZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCi0JciAmPSB+Q09OMF9CQVNFX0VOOw0K
LQl3cml0ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQorCWlmIChwbGwtPmVuX2Fk
ZHIpIHsNCisJCXIgPSByZWFkbChwbGwtPmVuX2FkZHIpOw0KKwkJciAmPSB+QklUKHBsbC0+ZGF0
YS0+YmFzZV9lbl9iaXQpOw0KKwkJd3JpdGVsKHIsIHBsbC0+ZW5fYWRkcik7DQorCX0gZWxzZSB7
DQorCQlyID0gcmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQorCQlyICY9IH5DT04w
X0JBU0VfRU47DQorCQl3cml0ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQorCX0N
CiANCiAJciA9IHJlYWRsKHBsbC0+cHdyX2FkZHIpIHwgQ09OMF9JU09fRU47DQogCXdyaXRlbChy
LCBwbGwtPnB3cl9hZGRyKTsNCkBAIC0zMjEsNiArMzM3LDggQEAgc3RhdGljIHN0cnVjdCBjbGsg
Km10a19jbGtfcmVnaXN0ZXJfcGxsKGNvbnN0IHN0cnVjdCBtdGtfcGxsX2RhdGEgKmRhdGEsDQog
CQlwbGwtPnR1bmVyX2FkZHIgPSBiYXNlICsgZGF0YS0+dHVuZXJfcmVnOw0KIAlpZiAoZGF0YS0+
dHVuZXJfZW5fcmVnKQ0KIAkJcGxsLT50dW5lcl9lbl9hZGRyID0gYmFzZSArIGRhdGEtPnR1bmVy
X2VuX3JlZzsNCisJaWYgKGRhdGEtPmVuX3JlZykNCisJCXBsbC0+ZW5fYWRkciA9IGJhc2UgKyBk
YXRhLT5lbl9yZWc7DQogCXBsbC0+aHcuaW5pdCA9ICZpbml0Ow0KIAlwbGwtPmRhdGEgPSBkYXRh
Ow0KIA0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


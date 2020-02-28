Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B692072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ttk8HpDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgB1Np0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727198AbgB1NpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:25 -0500
X-UUID: eb7561b2d4244b5b8f8e12dc32e9df4b-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YLUdJKRfiJIcoz0CVJslG4/S74gVNxgmK3lksKBnILo=;
        b=Ttk8HpDcA5bZW6/9vbvooYjr4W7AhI9/X/n9QGXoL/cqMSzLtMfetS3AGqRA6EEfWSZKe7Hf3kSJg13rwI5O3XVjmZzbUVMYEWUM3dVhGDCdbrDxflZ4HPAiswfKQUfLI9JNpjRirlXOtH8sgt4kN/ADHMGQVITEdZmU/sbk/3w=;
X-UUID: eb7561b2d4244b5b8f8e12dc32e9df4b-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 332029808; Fri, 28 Feb 2020 21:45:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:46:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:45:04 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 08/13] soc: mediatek: cmdq: add read_s function
Date:   Fri, 28 Feb 2020 21:44:16 +0800
Message-ID: <1582897461-15105-10-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHJlYWRfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggc3VwcG9y
dCByZWFkIHZhbHVlIGZyb20NCnJlZ2lzdGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8g
Z2NlIGludGVybmFsIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMTUgKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51
eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAxICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oICAgIHwgMTMgKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdl
ZCwgMjkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KaW5kZXggNjhiNDJjOTM1ZmU2Li40MjhmOTkyODhjYTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0yMjYsNiArMjI2LDIxIEBAIGludCBjbWRxX3BrdF93
cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogfQ0KIEVYUE9SVF9T
WU1CT0woY21kcV9wa3Rfd3JpdGVfbWFzayk7DQogDQoraW50IGNtZHFfcGt0X3JlYWRfcyhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LCB1MTYgYWRkcl9sb3csDQor
CQkgICAgdTE2IHJlZ19pZHgpDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0g
eyB7MH0gfTsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9SRUFEX1M7DQorCWluc3QuZHN0X3Qg
PSBDTURRX1JFR19UWVBFOw0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KKwlpbnN0
LnJlZ19kc3QgPSByZWdfaWR4Ow0KKwlpbnN0LnNyY19yZWcgPSBhZGRyX2xvdzsNCisNCisJcmV0
dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1C
T0woY21kcV9wa3RfcmVhZF9zKTsNCisNCiBpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KIAkJICAgICB1MTYgYWRkcl9sb3cs
IHUxNiBzcmNfcmVnX2lkeCwgdTMyIG1hc2spDQogew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQppbmRleCA4ZWY4N2UxYmQwM2IuLjNmNmJjMGRmZDVkYSAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC01OSw2ICs1OSw3IEBA
IGVudW0gY21kcV9jb2RlIHsNCiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlDTURRX0NPREVf
V0ZFID0gMHgyMCwNCiAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQorCUNNRFFfQ09ERV9SRUFEX1Mg
PSAweDgwLA0KIAlDTURRX0NPREVfV1JJVEVfUyA9IDB4OTAsDQogCUNNRFFfQ09ERV9XUklURV9T
X01BU0sgPSAweDkxLA0KIAlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBjNzJkODI2ZDg5MzQuLjAxYjQxODRhZjMxMCAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMDQsNiArMTA0LDE5IEBA
IGludCBjbWRxX3BrdF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLCB1MTYg
b2Zmc2V0LCB1MzIgdmFsdWUpOw0KIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogCQkJdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFz
ayk7DQogDQorLyoNCisgKiBjbWRxX3BrdF9yZWFkX3MoKSAtIGFwcGVuZCByZWFkX3MgY29tbWFu
ZCB0byB0aGUgQ01EUSBwYWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAaGln
aF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzZ2VyIElEIHdoaWNoIGNvbnRhaW5zIGhpZ2gg
YWRkcmVzcyBvZiBwYQ0KKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mgb2YgcGENCisgKiBAYWRk
cjoJdGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hIHRvIHJlYWQNCisgKiBA
cmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgdG8gY2FjaGUgcmVhZCBkYXRh
DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMg
cmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsIHUxNiBhZGRyX2xvdywNCisJCSAgICB1MTYgcmVnX2lk
eCk7DQorDQogLyoqDQogICogY21kcV9wa3Rfd3JpdGVfcygpIC0gYXBwZW5kIHdyaXRlX3MgY29t
bWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0tIA0K
Mi4xOC4wDQo=


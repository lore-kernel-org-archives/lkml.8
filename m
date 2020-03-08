Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F73C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AC5206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ctWE+6J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCHKxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60581 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726418AbgCHKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:12 -0400
X-UUID: b06b08725a9b4c8c9e7a30ebd23a6373-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=330LQhd/xVZ1G+avzxWZxFCOS8OiLlS0YT5gBwzchlc=;
        b=ctWE+6J3C7uELSxU6LJixbbXakTnt86mHVV3lH0vHXf1G987mkzKFpPbhbFwq4o3Tfqb33GIzU6JXwt+WuEAnYcB15qGVbDtqyTxuwmt3Is9L8ukGAh47XhlhO6/WOA3f4GjOALzDubtgM2bAhsDQGczqOV0Gkw3PyJAJtAjFIk=;
X-UUID: b06b08725a9b4c8c9e7a30ebd23a6373-20200308
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1026291922; Sun, 08 Mar 2020 18:53:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:51:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:59 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v5 08/13] soc: mediatek: cmdq: add read_s function
Date:   Sun, 8 Mar 2020 18:52:50 +0800
Message-ID: <1583664775-19382-9-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 631F22436D59D67E0ABAD80506678CF3B60102FEC44A73769B41787CAC3414502000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHJlYWRfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggc3VwcG9y
dCByZWFkIHZhbHVlIGZyb20NCnJlZ2lzdGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8g
Z2NlIGludGVybmFsIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jICAgfCAxNSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oIHwgIDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmggICAgfCAxMyArKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA5MGYxZmYy
YjRiMDAuLjAzYzEyOTIzMGNkNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KQEAgLTIyNiw2ICsyMjYsMjEgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93
cml0ZV9tYXNrKTsNCiANCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsIHUxNiBhZGRyX2xvdywNCisJCSAgICB1MTYgcmVnX2lk
eCkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKw0KKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX1JFQURfUzsNCisJaW5zdC5kc3RfdCA9IENNRFFfUkVHX1RZUEU7
DQorCWluc3Quc29wID0gaGlnaF9hZGRyX3JlZ19pZHg7DQorCWluc3QucmVnX2RzdCA9IHJlZ19p
ZHg7DQorCWluc3Quc3JjX3JlZyA9IGFkZHJfbG93Ow0KKw0KKwlyZXR1cm4gY21kcV9wa3RfYXBw
ZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9yZWFk
X3MpOw0KKw0KIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYg
aGlnaF9hZGRyX3JlZ19pZHgsDQogCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4
LCB1MzIgbWFzaykNCiB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgN
CmluZGV4IDhlZjg3ZTFiZDAzYi4uM2Y2YmMwZGZkNWRhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWls
Ym94L210ay1jbWRxLW1haWxib3guaA0KQEAgLTU5LDYgKzU5LDcgQEAgZW51bSBjbWRxX2NvZGUg
ew0KIAlDTURRX0NPREVfSlVNUCA9IDB4MTAsDQogCUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KIAlD
TURRX0NPREVfRU9DID0gMHg0MCwNCisJQ01EUV9DT0RFX1JFQURfUyA9IDB4ODAsDQogCUNNRFFf
Q09ERV9XUklURV9TID0gMHg5MCwNCiAJQ01EUV9DT0RFX1dSSVRFX1NfTUFTSyA9IDB4OTEsDQog
CUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCmluZGV4IGM3MmQ4MjZkODkzNC4uMDFiNDE4NGFmMzEwIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTEwNCw2ICsxMDQsMTkgQEAgaW50IGNtZHFfcGt0X3dy
aXRlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsIHUxNiBvZmZzZXQsIHUzMiB2YWx1
ZSk7DQogaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1
YnN5cywNCiAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCiANCisvKg0KKyAq
IGNtZHFfcGt0X3JlYWRfcygpIC0gYXBwZW5kIHJlYWRfcyBjb21tYW5kIHRvIHRoZSBDTURRIHBh
Y2tldA0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJ
aW50ZXJuYWwgcmVnaXNnZXIgSUQgd2hpY2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQor
ICogQGFkZHJfbG93Oglsb3cgYWRkcmVzcyBvZiBwYQ0KKyAqIEBhZGRyOgl0aGUgcGh5c2ljYWwg
YWRkcmVzcyBvZiByZWdpc3RlciBvciBkbWEgdG8gcmVhZA0KKyAqIEByZWdfaWR4Ogl0aGUgQ01E
USBpbnRlcm5hbCByZWdpc3RlciBJRCB0byBjYWNoZSByZWFkIGRhdGENCisgKg0KKyAqIFJldHVy
bjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0K
K2ludCBjbWRxX3BrdF9yZWFkX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJf
cmVnX2lkeCwgdTE2IGFkZHJfbG93LA0KKwkJICAgIHUxNiByZWdfaWR4KTsNCisNCiAvKioNCiAg
KiBjbWRxX3BrdF93cml0ZV9zKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRoZSBDTURR
IHBhY2tldA0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==


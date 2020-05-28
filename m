Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83810C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6322B207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DFgrxuS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405402AbgE1RFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:05:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405360AbgE1RFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:19 -0400
X-UUID: e48d3ca3a95e4226a5f1fe9fe5bca577-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UVgt7ge/fa+21BVMr/cXRd5QjAWybnpNKjM4SADa62M=;
        b=DFgrxuS17pSGh2Ocfst6KDX1Ee7fij9acL+QEiOtjASA118bBLLVsMWMFEv840/yi1IilnrsGTOnNsGEZ/ZSX2jNS3Wauf2Yo2RImypWTw5eCqNnUXakMOkwnJYC5vB6y2QtzmJHo+cdN3wKszV7pFT9jsGC4JDMHbi0XeLJbPY=;
X-UUID: e48d3ca3a95e4226a5f1fe9fe5bca577-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 635232611; Fri, 29 May 2020 01:05:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:09 +0800
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
Subject: [PATCH v6 12/16] soc: mediatek: cmdq: add write_s_mask value function
Date:   Fri, 29 May 2020 01:04:47 +0800
Message-ID: <1590685491-17107-13-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3NfbWFza192YWx1ZSBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMg
d2hpY2gNCndyaXRlcyBhIGNvbnN0YW50IHZhbHVlIHRvIGFkZHJlc3Mgd2l0aCBtYXNrIGFuZCBs
YXJnZSBkbWENCmFjY2VzcyBzdXBwb3J0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNp
ZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTUgKysrKysrKysrKysrKysrDQog
MiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQppbmRleCAxMjA5NWExYjcwMWIuLjRiMDdkYTU2YzdiYiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTI5Myw2ICsyOTMsMjcgQEAg
aW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hf
YWRkcl9yZWdfaWR4LA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUp
Ow0KIA0KK2ludCBjbWRxX3BrdF93cml0ZV9zX21hc2tfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KKwkJCQl1MTYgYWRkcl9sb3csIHUzMiB2YWx1ZSwg
dTMyIG1hc2spDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsN
CisJaW50IGVycjsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KKwlpbnN0Lm1hc2sg
PSB+bWFzazsNCisJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCisJ
aWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0KKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dS
SVRFX1NfTUFTSzsNCisJaW5zdC5zb3AgPSBoaWdoX2FkZHJfcmVnX2lkeDsNCisJaW5zdC5vZmZz
ZXQgPSBhZGRyX2xvdzsNCisJaW5zdC52YWx1ZSA9IHZhbHVlOw0KKw0KKwlyZXR1cm4gY21kcV9w
a3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF93cml0ZV9zX21hc2tfdmFsdWUpOw0KKw0KIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiBldmVudCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3Qg
PSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBiYjM2
NzUwYmU1OGMuLjI4YTUwYzNjZjZhMSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCkBAIC0xNjUsNiArMTY1LDIxIEBAIGludCBjbWRxX3BrdF93cml0ZV9zX21hc2soc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCiBpbnQgY21kcV9wa3Rf
d3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgs
DQogCQkJICAgdTE2IGFkZHJfbG93LCB1MzIgdmFsdWUpOw0KIA0KKy8qKg0KKyAqIGNtZHFfcGt0
X3dyaXRlX3NfbWFza192YWx1ZSgpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB3aXRoIG1hc2sg
dG8gdGhlIENNRFENCisgKgkJCQkgICBwYWNrZXQgd2hpY2ggd3JpdGUgdmFsdWUgdG8gYSBwaHlz
aWNhbA0KKyAqCQkJCSAgIGFkZHJlc3MNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBA
aGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNvbnRhaW5zIGhp
Z2ggYWRkcmVzcyBvZiBwYQ0KKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mgb2YgcGENCisgKiBA
dmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHZhbHVlDQorICogQG1hc2s6CXRoZSBzcGVjaWZp
ZWQgdGFyZ2V0IG1hc2sNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUg
ZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF93cml0ZV9zX21hc2tf
dmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KKwkJCQl1
MTYgYWRkcl9sb3csIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0
X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0
DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotLSANCjIuMTguMA0K


Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F41FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF5B246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QYfI9vPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgB1NqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:46:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgB1NpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:12 -0500
X-UUID: fd638e1a525643c1bd7174593202d998-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6UQiazPp6mEi0e2sLZd+ePjNTwzK31Dm31hGd7uJBTw=;
        b=QYfI9vPXycwyT1vNFOOikXtwVnSeIGLvcdSktIt5Mc87py9viuXSZ9nz304YA3v+wqFN8mVlgrKZ8D2CqHwAJ5T05tPc/n1mT6joZWCzEslpqsgWXwbSaRMvw/W8mFfiMk4IZIftYZ2OIrQy1gbASTNiXjEVlTo1Bf3d8iW6bh0=;
X-UUID: fd638e1a525643c1bd7174593202d998-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1576130903; Fri, 28 Feb 2020 21:45:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:01 +0800
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
Subject: [PATCH v3 07/13] soc: mediatek: cmdq: add write_s function
Date:   Fri, 28 Feb 2020 21:44:15 +0800
Message-ID: <1582897461-15105-9-git-send-email-dennis-yc.hsieh@mediatek.com>
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

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0Kd2l0aCBs
YXJnZSBkbWEgYWNjZXNzIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKy0NCiBp
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDIgKysNCiBpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMjAgKysrKysrKysrKysrKysNCiAz
IGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDgzNDJhNWM5NGJjNy4uNjhiNDJj
OTM1ZmU2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMTgs
NiArMTgsMTAgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAl1bmlvbiB7DQogCQl1MzIg
dmFsdWU7DQogCQl1MzIgbWFzazsNCisJCXN0cnVjdCB7DQorCQkJdTE2IGFyZ19jOw0KKwkJCXUx
NiBzcmNfcmVnOw0KKwkJfTsNCiAJfTsNCiAJdW5pb24gew0KIAkJdTE2IG9mZnNldDsNCkBAIC0y
OSw3ICszMyw3IEBAIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCiAJCXN0cnVjdCB7DQogCQkJ
dTggc29wOjU7DQogCQkJdTggYXJnX2NfdDoxOw0KLQkJCXU4IGFyZ19iX3Q6MTsNCisJCQl1OCBz
cmNfdDoxOw0KIAkJCXU4IGRzdF90OjE7DQogCQl9Ow0KIAl9Ow0KQEAgLTIyMiw2ICsyMjYsMzQg
QEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5
cywNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCiANCitpbnQgY21k
cV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4
LA0KKwkJICAgICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCwgdTMyIG1hc2spDQorew0K
KwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisJaW50IGVycjsNCisN
CisJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0KKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0K
KwkJaW5zdC5tYXNrID0gfm1hc2s7DQorCQllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChw
a3QsIGluc3QpOw0KKwkJaWYgKGVyciA8IDApDQorCQkJcmV0dXJuIGVycjsNCisNCisJCWluc3Qu
bWFzayA9IDA7DQorCQlpbnN0Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1NfTUFTSzsNCisJfSBlbHNl
IHsNCisJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCisJfQ0KKw0KKwlpbnN0LnNyY190
ID0gQ01EUV9SRUdfVFlQRTsNCisJaW5zdC5zb3AgPSBoaWdoX2FkZHJfcmVnX2lkeDsNCisJaW5z
dC5vZmZzZXQgPSBhZGRyX2xvdzsNCisJaW5zdC5zcmNfcmVnID0gc3JjX3JlZ19pZHg7DQorDQor
CXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0KKw0KIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpp
bmRleCAxMjFjM2JiNmQzZGUuLjhlZjg3ZTFiZDAzYiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC01OSw2ICs1OSw4IEBAIGVudW0gY21kcV9jb2RlIHsN
CiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCiAJQ01E
UV9DT0RFX0VPQyA9IDB4NDAsDQorCUNNRFFfQ09ERV9XUklURV9TID0gMHg5MCwNCisJQ01EUV9D
T0RFX1dSSVRFX1NfTUFTSyA9IDB4OTEsDQogCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQogfTsN
CiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggODMzNDAyMTFlMWQz
Li5jNzJkODI2ZDg5MzQgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpA
QCAtMTIsNiArMTIsOCBAQA0KICNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0KIA0KICNkZWZpbmUg
Q01EUV9OT19USU1FT1VUCQkweGZmZmZmZmZmdQ0KKyNkZWZpbmUgQ01EUV9BRERSX0hJR0goYWRk
cikJKCh1MzIpKCgoYWRkcikgPj4gMTYpICYgR0VOTUFTSygzMSwgMCkpKQ0KKyNkZWZpbmUgQ01E
UV9BRERSX0xPVyhhZGRyKQkoKHUxNikoYWRkcikgfCBCSVQoMSkpDQogDQogc3RydWN0IGNtZHFf
cGt0Ow0KIA0KQEAgLTEwMiw2ICsxMDQsMjQgQEAgaW50IGNtZHFfcGt0X3dyaXRlKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSk7DQogaW50IGNt
ZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiAJCQl1
MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCiANCisvKioNCisgKiBjbWRxX3BrdF93
cml0ZV9zKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KKyAq
IEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwg
cmVnaXNnZXIgSUQgd2hpY2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQorICogQGFkZHJf
bG93Oglsb3cgYWRkcmVzcyBvZiBwYQ0KKyAqIEBzcmNfcmVnX2lkeDoJdGhlIENNRFEgaW50ZXJu
YWwgcmVnaXN0ZXIgSUQgd2hpY2ggY2FjaGUgc291cmNlIHZhbHVlDQorICogQG1hc2s6CXRoZSBz
cGVjaWZpZWQgdGFyZ2V0IGFkZHJlc3MgbWFzaywgdXNlIFUzMl9NQVggaWYgbm8gbmVlZA0KKyAq
DQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVy
bmVkDQorICoNCisgKiBTdXBwb3J0IHdyaXRlIHZhbHVlIHRvIHBoeXNpY2FsIGFkZHJlc3Mgd2l0
aG91dCBzdWJzeXMuIFVzZSBDTURRX0FERFJfSElHSCgpDQorICogdG8gZ2V0IGhpZ2ggYWRkcmVl
cyBhbmQgY2FsbCBjbWRxX3BrdF9hc3NpZ24oKSB0byBhc3NpZ24gdmFsdWUgaW50byBpbnRlcm5h
bA0KKyAqIHJlZy4gQWxzbyB1c2UgQ01EUV9BRERSX0xPVygpIHRvIGdldCBsb3cgYWRkcmVzcyBm
b3IgYWRkcl9sb3cgcGFyYW1ldGVyd2hlbg0KKyAqIGNhbGwgdG8gdGhpcyBmdW5jdGlvbi4NCisg
Ki8NCitpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hf
YWRkcl9yZWdfaWR4LA0KKwkJICAgICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCwgdTMy
IG1hc2spOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2
ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0
DQotLSANCjIuMTguMA0K


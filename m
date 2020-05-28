Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E74DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18362089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A1ztlDRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405477AbgE1RGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:06:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405384AbgE1RFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:24 -0400
X-UUID: 76bfacfd98a449ddb4d286df51d7a1a9-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Eom+bJqurS/dqNzfrcniOtuvCPDFdKtJTHEiGRe1jB8=;
        b=A1ztlDRy+c0Y4KgklbZr85/GbJkwzn1GnPGcKYQBmZIwC68JCHtnGAGpA5FNCyIw7+pRcFZiViHUg3jcFz8Dcnk3VHcoRhfybnIulwokRt06RHKoHB10y7gdPozmeU+zIRPWBzX4Jx5B7g/qQc6xZGDnuf9Jwygk2ICCcyrRKHA=;
X-UUID: 76bfacfd98a449ddb4d286df51d7a1a9-20200529
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1990888823; Fri, 29 May 2020 01:05:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v6 14/16] soc: mediatek: cmdq: add jump function
Date:   Fri, 29 May 2020 01:04:49 +0800
Message-ID: <1590685491-17107-15-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCmNvbnRhaW5zIGluc3RydWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIHwgMTMgKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmggIHwgMTEgKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IGVi
Y2RkMzBjZDc4My4uNWNmOWU3MWI3OTAwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQpAQCAtMTMsNiArMTMsNyBAQA0KICNkZWZpbmUgQ01EUV9QT0xMX0VOQUJMRV9N
QVNLCUJJVCgwKQ0KICNkZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQoMCkNCiAjZGVmaW5lIENN
RFFfUkVHX1RZUEUJCTENCisjZGVmaW5lIENNRFFfSlVNUF9SRUxBVElWRQkxDQogDQogc3RydWN0
IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAl1bmlvbiB7DQpAQCAtMzkxLDYgKzM5MiwxOCBAQCBpbnQg
Y21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZh
bHVlKQ0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQogDQoraW50IGNtZHFf
cGt0X2p1bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkcikNCit7DQorCXN0
cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKw0KKwlpbnN0Lm9wID0gQ01E
UV9DT0RFX0pVTVA7DQorCWluc3Qub2Zmc2V0ID0gQ01EUV9KVU1QX1JFTEFUSVZFOw0KKwlpbnN0
LnZhbHVlID0gYWRkciA+Pg0KKwkJY21kcV9tYm94X3NoaWZ0KCgoc3RydWN0IGNtZHFfY2xpZW50
ICopcGt0LT5jbCktPmNoYW4pOw0KKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0
LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9qdW1wKTsNCisNCiBpbnQgY21k
cV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQogew0KIAlzdHJ1Y3QgY21kcV9p
bnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KaW5kZXggNzAzY2ZmY2Q1NWJkLi45NDk0YjI5M2JhZDkgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMjQ0LDYgKzI0NCwxNyBAQCBpbnQgY21kcV9wa3Rf
cG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogICovDQogaW50IGNt
ZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1
ZSk7DQogDQorLyoqDQorICogY21kcV9wa3RfanVtcCgpIC0gQXBwZW5kIGp1bXAgY29tbWFuZCB0
byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0UNCisgKgkJICAgICB0byBleGVjdXRlIGFuIGluc3Ry
dWN0aW9uIHRoYXQgY2hhbmdlIGN1cnJlbnQgdGhyZWFkIFBDIHRvDQorICoJCSAgICAgYSBwaHlz
aWNhbCBhZGRyZXNzIHdoaWNoIHNob3VsZCBjb250YWlucyBtb3JlIGluc3RydWN0aW9uLg0KKyAq
IEBwa3Q6ICAgICAgICB0aGUgQ01EUSBwYWNrZXQNCisgKiBAYWRkcjogICAgICAgcGh5c2ljYWwg
YWRkcmVzcyBvZiB0YXJnZXQgaW5zdHJ1Y3Rpb24gYnVmZmVyDQorICoNCisgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQg
Y21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKTsNCisN
CiAvKioNCiAgKiBjbWRxX3BrdF9maW5hbGl6ZSgpIC0gQXBwZW5kIEVPQyBhbmQganVtcCBjb21t
YW5kIHRvIHBrdC4NCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0tIA0KMi4xOC4wDQo=


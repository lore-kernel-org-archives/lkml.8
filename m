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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF8AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F9820721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UlqcHc6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405469AbgE1RGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:06:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405313AbgE1RF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:28 -0400
X-UUID: f1385f5137d9470e92b3f4c747d2aacc-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JyUcWSwU7BWDPIWeAHfphybpVN13p9DbJEg8wfLwcxg=;
        b=UlqcHc6rarXCJtfv39tyErmrTTvj6vOL4NdkDb/9GKlsRxDYUubXkzjTBu2BvH/AubxFPKv4nwp1G6nT4J7LBzd8H0F2lJS7GVGMBjG3pPv8DWrCEeLOKQOis0FjfQt0sHqF6A5/Nw6tCg6pU7uK//8u895ws/ZKequUVbA652E=;
X-UUID: f1385f5137d9470e92b3f4c747d2aacc-20200529
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 123650689; Fri, 29 May 2020 01:05:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:08 +0800
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
Subject: [PATCH v6 09/16] soc: mediatek: cmdq: add write_s_mask function
Date:   Fri, 29 May 2020 01:04:44 +0800
Message-ID: <1590685491-17107-10-git-send-email-dennis-yc.hsieh@mediatek.com>
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

YWRkIHdyaXRlX3NfbWFzayBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2gN
CndyaXRlcyB2YWx1ZSBjb250YWlucyBpbiBpbnRlcm5hbCByZWdpc3RlciB0byBhZGRyZXNzDQp3
aXRoIG1hc2sgYW5kIGxhcmdlIGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTog
RGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDIzICsrKysrKysrKysrKysr
KysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAx
ICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMTkgKysrKysr
KysrKysrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggZWUy
NGMwZWMwYTI0Li41OGE0MTQ3OTA0NzEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMNCkBAIC0yNDEsNiArMjQxLDI5IEBAIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQogfQ0KIEVYUE9SVF9TWU1C
T0woY21kcV9wa3Rfd3JpdGVfcyk7DQogDQoraW50IGNtZHFfcGt0X3dyaXRlX3NfbWFzayhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KKwkJCSAgdTE2IGFkZHJf
bG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNrKQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1
Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorCWludCBlcnI7DQorDQorCWluc3Qub3AgPSBDTURRX0NP
REVfTUFTSzsNCisJaW5zdC5tYXNrID0gfm1hc2s7DQorCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9j
b21tYW5kKHBrdCwgaW5zdCk7DQorCWlmIChlcnIgPCAwKQ0KKwkJcmV0dXJuIGVycjsNCisNCisJ
aW5zdC5tYXNrID0gMDsNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TX01BU0s7DQorCWlu
c3Quc3JjX3QgPSBDTURRX1JFR19UWVBFOw0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4
Ow0KKwlpbnN0Lm9mZnNldCA9IGFkZHJfbG93Ow0KKwlpbnN0LnNyY19yZWcgPSBzcmNfcmVnX2lk
eDsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0K
K0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc19tYXNrKTsNCisNCiBpbnQgY21kcV9wa3Rf
d2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogew0KIAlzdHJ1Y3QgY21kcV9p
bnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaA0KaW5kZXggZWU2N2RkM2I4NmY1Li44ZWY4N2UxYmQwM2IgMTAwNjQ0DQotLS0g
YS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpAQCAtNjAsNiArNjAsNyBAQCBlbnVt
IGNtZHFfY29kZSB7DQogCUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KIAlDTURRX0NPREVfRU9DID0g
MHg0MCwNCiAJQ01EUV9DT0RFX1dSSVRFX1MgPSAweDkwLA0KKwlDTURRX0NPREVfV1JJVEVfU19N
QVNLID0gMHg5MSwNCiAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCiB9Ow0KIA0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBkNjIzZjFhYTc4MTQuLmNhOWM3NWZkODEy
NSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMTAsNyArMTEw
LDYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1
YnN5cywNCiAgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzdGVyIElEIHdoaWNo
IGNvbnRhaW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KICAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mg
b2YgcGENCiAgKiBAc3JjX3JlZ19pZHg6CXRoZSBDTURRIGludGVybmFsIHJlZ2lzdGVyIElEIHdo
aWNoIGNhY2hlIHNvdXJjZSB2YWx1ZQ0KLSAqIEBtYXNrOgl0aGUgc3BlY2lmaWVkIHRhcmdldCBh
ZGRyZXNzIG1hc2ssIHVzZSBVMzJfTUFYIGlmIG5vIG5lZWQNCiAgKg0KICAqIFJldHVybjogMCBm
b3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KICAqDQpAQCAtMTIy
LDYgKzEyMSwyNCBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTggc3Vic3lzLA0KIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQogCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19y
ZWdfaWR4KTsNCiANCisvKioNCisgKiBjbWRxX3BrdF93cml0ZV9zX21hc2soKSAtIGFwcGVuZCB3
cml0ZV9zIHdpdGggbWFzayBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KKyAqIEBwa3Q6CXRo
ZSBDTURRIHBhY2tldA0KKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXN0ZXIg
SUQgd2hpY2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQorICogQGFkZHJfbG93Oglsb3cg
YWRkcmVzcyBvZiBwYQ0KKyAqIEBzcmNfcmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0
ZXIgSUQgd2hpY2ggY2FjaGUgc291cmNlIHZhbHVlDQorICogQG1hc2s6CXRoZSBzcGVjaWZpZWQg
dGFyZ2V0IGFkZHJlc3MgbWFzaywgdXNlIFUzMl9NQVggaWYgbm8gbmVlZA0KKyAqDQorICogUmV0
dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICoN
CisgKiBTdXBwb3J0IHdyaXRlIHZhbHVlIHRvIHBoeXNpY2FsIGFkZHJlc3Mgd2l0aG91dCBzdWJz
eXMuIFVzZSBDTURRX0FERFJfSElHSCgpDQorICogdG8gZ2V0IGhpZ2ggYWRkcmVzcyBhbmQgY2Fs
bCBjbWRxX3BrdF9hc3NpZ24oKSB0byBhc3NpZ24gdmFsdWUgaW50byBpbnRlcm5hbA0KKyAqIHJl
Zy4gQWxzbyB1c2UgQ01EUV9BRERSX0xPVygpIHRvIGdldCBsb3cgYWRkcmVzcyBmb3IgYWRkcl9s
b3cgcGFyYW1ldGVyIHdoZW4NCisgKiBjYWxsIHRvIHRoaXMgZnVuY3Rpb24uDQorICovDQoraW50
IGNtZHFfcGt0X3dyaXRlX3NfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRk
cl9yZWdfaWR4LA0KKwkJCSAgdTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNr
KTsNCisNCiAvKioNCiAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBj
b21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLS0g
DQoyLjE4LjANCg==


Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739F1C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3592491C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W4vZCdWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgFUOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17793 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730226AbgFUOSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:50 -0400
X-UUID: ccaf08de44bf4e5ba52618804f0a4b3b-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Zam9mPbD4TBF/qNyMPB/G3Srii8O8qND0/RAC8+CNYQ=;
        b=W4vZCdWSjeUpWliIMXFQ7qoABeR46fjzrvo4yMjUzrc75YwJ4SEHKJPuRLAsnT4Ow6OgQ1duG0VYFdb62+wnuHf6MHFbotA7OSe3nUMxOLw3YJjjlMahh+TxEz7eA5AZcPkp0beIYFG9SyoSIjTtuVaYNb9OCsps9OBC/jx91W8=;
X-UUID: ccaf08de44bf4e5ba52618804f0a4b3b-20200621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1886059077; Sun, 21 Jun 2020 22:18:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 22:18:30 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v1 02/11] soc: mediatek: cmdq: add assign function
Date:   Sun, 21 Jun 2020 22:18:26 +0800
Message-ID: <1592749115-24158-3-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFzc2lnbiBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciB3aGljaCBhc3NpZ24gY29uc3RhbnQg
dmFsdWUgaW50bw0KaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5kZXguDQoNClNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAgIDI0ICsrKysrKysrKysr
KysrKysrKysrKysrLQ0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94Lmgg
fCAgICAxICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgICAx
NCArKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXgg
OThmMjNiYTNiYTQ3Li5iZjMyZTNiMmNhNmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMNCkBAIC0xMiw2ICsxMiw3IEBADQogI2RlZmluZSBDTURRX1dSSVRFX0VOQUJM
RV9NQVNLCUJJVCgwKQ0KICNkZWZpbmUgQ01EUV9QT0xMX0VOQUJMRV9NQVNLCUJJVCgwKQ0KICNk
ZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQoMCkNCisjZGVmaW5lIENNRFFfUkVHX1RZUEUJCTEN
CiANCiBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCkBAIC0yMSw4ICsyMiwx
NyBAQCBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCiAJCXUxNiBvZmZzZXQ7
DQogCQl1MTYgZXZlbnQ7DQorCQl1MTYgcmVnX2RzdDsNCisJfTsNCisJdW5pb24gew0KKwkJdTgg
c3Vic3lzOw0KKwkJc3RydWN0IHsNCisJCQl1OCBzb3A6NTsNCisJCQl1OCBhcmdfY190OjE7DQor
CQkJdTggc3JjX3Q6MTsNCisJCQl1OCBkc3RfdDoxOw0KKwkJfTsNCiAJfTsNCi0JdTggc3Vic3lz
Ow0KIAl1OCBvcDsNCiB9Ow0KIA0KQEAgLTI3Nyw2ICsyODcsMTggQEAgaW50IGNtZHFfcGt0X3Bv
bGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIH0NCiBFWFBPUlRfU1lN
Qk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQogDQoraW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCit7DQorCXN0cnVjdCBjbWRx
X2luc3RydWN0aW9uIGluc3QgPSB7fTsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9MT0dJQzsN
CisJaW5zdC5kc3RfdCA9IENNRFFfUkVHX1RZUEU7DQorCWluc3QucmVnX2RzdCA9IHJlZ19pZHg7
DQorCWluc3QudmFsdWUgPSB2YWx1ZTsNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5k
KHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfYXNzaWduKTsNCisNCiBz
dGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIHsNCiAJ
c3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IGRmZTViMmViODVjYy4uMTIxYzNiYjZkM2Rl
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0K
KysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KQEAgLTU5LDYg
KzU5LDcgQEAgZW51bSBjbWRxX2NvZGUgew0KIAlDTURRX0NPREVfSlVNUCA9IDB4MTAsDQogCUNN
RFFfQ09ERV9XRkUgPSAweDIwLA0KIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCisJQ01EUV9DT0RF
X0xPR0lDID0gMHhhMCwNCiB9Ow0KIA0KIGVudW0gY21kcV9jYl9zdGF0dXMgew0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBhNzRjMWQ1YWNkZjMuLjgzMzQwMjExZTFk
MyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xNTIsNiArMTUy
LDIwIEBAIGludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMs
DQogICovDQogaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgg
c3Vic3lzLA0KIAkJICAgICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KKw0K
Ky8qKg0KKyAqIGNtZHFfcGt0X2Fzc2lnbigpIC0gQXBwZW5kIGxvZ2ljIGFzc2lnbiBjb21tYW5k
IHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdDRQ0KKyAqCQkgICAgICAgdG8gZXhlY3V0ZSBhbiBp
bnN0cnVjdGlvbiB0aGF0IHNldCBhIGNvbnN0YW50IHZhbHVlIGludG8NCisgKgkJICAgICAgIGlu
dGVybmFsIHJlZ2lzdGVyIGFuZCB1c2UgYXMgdmFsdWUsIG1hc2sgb3IgYWRkcmVzcyBpbg0KKyAq
CQkgICAgICAgcmVhZC93cml0ZSBpbnN0cnVjdGlvbi4NCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCisgKiBAcmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQNCisgKiBAdmFs
dWU6CXRoZSBzcGVjaWZpZWQgdmFsdWUNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2Vzczsg
ZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF9hc3Np
Z24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KKw0KIC8q
Kg0KICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9u
b3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KICAqICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNr
ZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQotLSANCjEuNy45LjUN
Cg==


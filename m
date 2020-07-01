Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB2EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABFA20773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d2xBVULK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgGAH0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:26:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39173 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728142AbgGAH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:26:33 -0400
X-UUID: 59938f75d406464e96cd98d1b2a2d936-20200701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JRqYp/xDZ/pH0zSlS3a3fPsoVQlaK55JVqABn0ZptlI=;
        b=d2xBVULKZVfIxBRVrc6tL1PgvXR7AT8Lx3l7CX7MrVlNS8GuLmiwQPxwOvQA46UTSeJTf/ooy/MpNdrQoYjPhynQMq53JgE2TBU8td8Z3rSWUjtaI8rTNXebsw/7q6wk1crX6oUhxXhn6fJwkzVXKxeXpVHruTUsqlggrN9yRZw=;
X-UUID: 59938f75d406464e96cd98d1b2a2d936-20200701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2098295976; Wed, 01 Jul 2020 15:26:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jul 2020 15:26:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Jul 2020 15:26:25 +0800
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH 2/2] clk: mediatek: Add EXPORT_SYMBOL for kernel module support
Date:   Wed, 1 Jul 2020 15:26:22 +0800
Message-ID: <1593588382-19049-3-git-send-email-wendell.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
References: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXhwb3J0IGNvbW1vbiBBUElzIGZyb20gTWVkaWF0ZWsgY2xvY2sgZHJpdmVyLg0KDQpTaWduZWQt
b2ZmLWJ5OiBXZW5kZWxsIExpbiA8d2VuZGVsbC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5jIHwgICAxMyArKysrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdGsuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuYw0KaW5kZXgg
Y2VjMWM4YS4uNmI0ZGNhMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dGsuYw0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5jDQpAQCAtMTMsNiArMTMs
NyBAQA0KICNpbmNsdWRlIDxsaW51eC9jbGtkZXYuaD4NCiAjaW5jbHVkZSA8bGludXgvbWZkL3N5
c2Nvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQogDQogI2luY2x1ZGUgImNsay1tdGsuaCINCiAjaW5jbHVkZSAiY2xrLWdhdGUuaCIN
CkBAIC00MSw2ICs0Miw3IEBAIHN0cnVjdCBjbGtfb25lY2VsbF9kYXRhICptdGtfYWxsb2NfY2xr
X2RhdGEodW5zaWduZWQgaW50IGNsa19udW0pDQogDQogCXJldHVybiBOVUxMOw0KIH0NCitFWFBP
UlRfU1lNQk9MKG10a19hbGxvY19jbGtfZGF0YSk7DQogDQogdm9pZCBtdGtfY2xrX3JlZ2lzdGVy
X2ZpeGVkX2Nsa3MoY29uc3Qgc3RydWN0IG10a19maXhlZF9jbGsgKmNsa3MsDQogCQlpbnQgbnVt
LCBzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGEpDQpAQCAtNjcsNiArNjksNyBAQCB2
b2lkIG10a19jbGtfcmVnaXN0ZXJfZml4ZWRfY2xrcyhjb25zdCBzdHJ1Y3QgbXRrX2ZpeGVkX2Ns
ayAqY2xrcywNCiAJCQljbGtfZGF0YS0+Y2xrc1tyYy0+aWRdID0gY2xrOw0KIAl9DQogfQ0KK0VY
UE9SVF9TWU1CT0wobXRrX2Nsa19yZWdpc3Rlcl9maXhlZF9jbGtzKTsNCiANCiB2b2lkIG10a19j
bGtfcmVnaXN0ZXJfZmFjdG9ycyhjb25zdCBzdHJ1Y3QgbXRrX2ZpeGVkX2ZhY3RvciAqY2xrcywN
CiAJCWludCBudW0sIHN0cnVjdCBjbGtfb25lY2VsbF9kYXRhICpjbGtfZGF0YSkNCkBAIC05Myw2
ICs5Niw3IEBAIHZvaWQgbXRrX2Nsa19yZWdpc3Rlcl9mYWN0b3JzKGNvbnN0IHN0cnVjdCBtdGtf
Zml4ZWRfZmFjdG9yICpjbGtzLA0KIAkJCWNsa19kYXRhLT5jbGtzW2ZmLT5pZF0gPSBjbGs7DQog
CX0NCiB9DQorRVhQT1JUX1NZTUJPTChtdGtfY2xrX3JlZ2lzdGVyX2ZhY3RvcnMpOw0KIA0KIGlu
dCBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzX3dpdGhfZGV2KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSwNCiAJCWNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSAqY2xrcywNCkBAIC0xMzcsNiArMTQxLDcgQEAg
aW50IG10a19jbGtfcmVnaXN0ZXJfZ2F0ZXNfd2l0aF9kZXYoc3RydWN0IGRldmljZV9ub2RlICpu
b2RlLA0KIA0KIAlyZXR1cm4gMDsNCiB9DQorRVhQT1JUX1NZTUJPTChtdGtfY2xrX3JlZ2lzdGVy
X2dhdGVzX3dpdGhfZGV2KTsNCiANCiBpbnQgbXRrX2Nsa19yZWdpc3Rlcl9nYXRlcyhzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5vZGUsDQogCQljb25zdCBzdHJ1Y3QgbXRrX2dhdGUgKmNsa3MsDQpAQCAt
MTQ1LDYgKzE1MCw3IEBAIGludCBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbm9kZSwNCiAJcmV0dXJuIG10a19jbGtfcmVnaXN0ZXJfZ2F0ZXNfd2l0aF9kZXYobm9k
ZSwNCiAJCWNsa3MsIG51bSwgY2xrX2RhdGEsIE5VTEwpOw0KIH0NCitFWFBPUlRfU1lNQk9MKG10
a19jbGtfcmVnaXN0ZXJfZ2F0ZXMpOw0KIA0KIHN0cnVjdCBjbGsgKm10a19jbGtfcmVnaXN0ZXJf
Y29tcG9zaXRlKGNvbnN0IHN0cnVjdCBtdGtfY29tcG9zaXRlICptYywNCiAJCXZvaWQgX19pb21l
bSAqYmFzZSwgc3BpbmxvY2tfdCAqbG9jaykNCkBAIC0yMzIsNiArMjM4LDcgQEAgc3RydWN0IGNs
ayAqbXRrX2Nsa19yZWdpc3Rlcl9jb21wb3NpdGUoY29uc3Qgc3RydWN0IG10a19jb21wb3NpdGUg
Km1jLA0KIA0KIAlyZXR1cm4gRVJSX1BUUihyZXQpOw0KIH0NCitFWFBPUlRfU1lNQk9MKG10a19j
bGtfcmVnaXN0ZXJfY29tcG9zaXRlKTsNCiANCiB2b2lkIG10a19jbGtfcmVnaXN0ZXJfY29tcG9z
aXRlcyhjb25zdCBzdHJ1Y3QgbXRrX2NvbXBvc2l0ZSAqbWNzLA0KIAkJaW50IG51bSwgdm9pZCBf
X2lvbWVtICpiYXNlLCBzcGlubG9ja190ICpsb2NrLA0KQEAgLTI1OCw2ICsyNjUsNyBAQCB2b2lk
IG10a19jbGtfcmVnaXN0ZXJfY29tcG9zaXRlcyhjb25zdCBzdHJ1Y3QgbXRrX2NvbXBvc2l0ZSAq
bWNzLA0KIAkJCWNsa19kYXRhLT5jbGtzW21jLT5pZF0gPSBjbGs7DQogCX0NCiB9DQorRVhQT1JU
X1NZTUJPTChtdGtfY2xrX3JlZ2lzdGVyX2NvbXBvc2l0ZXMpOw0KIA0KIHZvaWQgbXRrX2Nsa19y
ZWdpc3Rlcl9kaXZpZGVycyhjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kaXZpZGVyICptY2RzLA0KIAkJ
CWludCBudW0sIHZvaWQgX19pb21lbSAqYmFzZSwgc3BpbmxvY2tfdCAqbG9jaywNCkBAIC0yODYs
MyArMjk0LDggQEAgdm9pZCBtdGtfY2xrX3JlZ2lzdGVyX2RpdmlkZXJzKGNvbnN0IHN0cnVjdCBt
dGtfY2xrX2RpdmlkZXIgKm1jZHMsDQogCQkJY2xrX2RhdGEtPmNsa3NbbWNkLT5pZF0gPSBjbGs7
DQogCX0NCiB9DQorRVhQT1JUX1NZTUJPTChtdGtfY2xrX3JlZ2lzdGVyX2RpdmlkZXJzKTsNCisN
CitNT0RVTEVfTElDRU5TRSgiR1BMIik7DQorTU9EVUxFX0RFU0NSSVBUSU9OKCJNZWRpYXRlayBD
bG9ja3MiKTsNCitNT0RVTEVfQVVUSE9SKCJNZWRpYVRlayBJbmMuIik7DQotLSANCjEuNy45LjU=


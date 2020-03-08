Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FAEC10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4148120838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kxNjrTgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCHKxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47671 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgCHKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:08 -0400
X-UUID: 6ac139c1dcc74bb2aebe453063fab199-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MYH+JWtN3TW3+5HBk7PMR9MHuRJoGMcqVVaD9IZJVF0=;
        b=kxNjrTgrtRcrXxFsl0CIgOJ8nfidqGM/m0857NETEPBUizAz8MBKzOs9P9QsATVSgi2p9+GeBTvwXC3M7Ir0hNWDwqMY3os4m75h34RhnqKfBxdcZ8dHlmua8gSUjPU6mC7OwHWyYED7gtRiLhl2btQnmQvm+INMe2ynUv8CuoY=;
X-UUID: 6ac139c1dcc74bb2aebe453063fab199-20200308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 85943508; Sun, 08 Mar 2020 18:53:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:52:03 +0800
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
Subject: [PATCH v5 10/13] soc: mediatek: cmdq: export finalize function
Date:   Sun, 8 Mar 2020 18:52:52 +0800
Message-ID: <1583664775-19382-11-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXhwb3J0IGZpbmFsaXplIGZ1bmN0aW9uIHRvIGNsaWVudCB3aGljaCBoZWxwcyBhcHBlbmQgZW9j
IGFuZCBqdW1wDQpjb21tYW5kIHRvIHBrdC4gTGV0IGNsaWVudCBkZWNpZGUgY2FsbCBmaW5hbGl6
ZSBvciBub3QuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhz
aWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgMSArDQog
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgIHwgNyArKy0tLS0tDQogaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgIHwgOCArKysrKysrKw0KIDMgZmls
ZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KaW5kZXggMGRmY2QxNzg3ZTY1Li43ZGFhYWJj
MjZlYjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRj
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KQEAgLTQ5
MCw2ICs0OTAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfaHdfY29uZmlnKHN0cnVjdCBt
dGtfZHJtX2NydGMgKm10a19jcnRjKQ0KIAkJY21kcV9wa3RfY2xlYXJfZXZlbnQoY21kcV9oYW5k
bGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCiAJCWNtZHFfcGt0X3dmZShjbWRxX2hhbmRsZSwg
bXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBjbWRx
X2hhbmRsZSk7DQorCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7DQogCQljbWRxX3Br
dF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFfY2IsIGNtZHFfaGFuZGxlKTsNCiAJ
fQ0KICNlbmRpZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IGE5
ZWJiYWJiNzQzOS4uNTliYzExNjRiNDExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQpAQCAtMzcyLDcgKzM3Miw3IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQogfQ0KIEVYUE9SVF9TWU1C
T0woY21kcV9wa3RfYXNzaWduKTsNCiANCi1zdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0
cnVjdCBjbWRxX3BrdCAqcGt0KQ0KK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9w
a3QgKnBrdCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0K
IAlpbnQgZXJyOw0KQEAgLTM5Miw2ICszOTIsNyBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFs
aXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIA0KIAlyZXR1cm4gZXJyOw0KIH0NCitFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplKTsNCiANCiBzdGF0aWMgdm9pZCBjbWRxX3BrdF9mbHVz
aF9hc3luY19jYihzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpDQogew0KQEAgLTQyNiwxMCArNDI3
LDYgQEAgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBjbWRx
X2FzeW5jX2ZsdXNoX2NiIGNiLA0KIAl1bnNpZ25lZCBsb25nIGZsYWdzID0gMDsNCiAJc3RydWN0
IGNtZHFfY2xpZW50ICpjbGllbnQgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsNCiAN
Ci0JZXJyID0gY21kcV9wa3RfZmluYWxpemUocGt0KTsNCi0JaWYgKGVyciA8IDApDQotCQlyZXR1
cm4gZXJyOw0KLQ0KIAlwa3QtPmNiLmNiID0gY2I7DQogCXBrdC0+Y2IuZGF0YSA9IGRhdGE7DQog
CXBrdC0+YXN5bmNfY2IuY2IgPSBjbWRxX3BrdF9mbHVzaF9hc3luY19jYjsNCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggZmVjMjkyYWFjODNjLi45OWU3NzE1NWY5Njcg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysg
Yi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMjEzLDYgKzIxMywx
NCBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJz
eXMsDQogICovDQogaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IHJlZ19pZHgsIHUzMiB2YWx1ZSk7DQogDQorLyoqDQorICogY21kcV9wa3RfZmluYWxpemUoKSAt
IEFwcGVuZCBFT0MgYW5kIGp1bXAgY29tbWFuZCB0byBwa3QuDQorICogQHBrdDoJdGhlIENNRFEg
cGFja2V0DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNv
ZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFf
cGt0ICpwa3QpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2Vy
IENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFj
a2V0DQotLSANCjIuMTguMA0K


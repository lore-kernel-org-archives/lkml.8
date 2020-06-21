Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24902491C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mhRGmrFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgFUOSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17793 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730167AbgFUOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:44 -0400
X-UUID: e125096b405f44278cb953e13374a93c-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TkOkIDLhlS19sptnDuqd/11Wt1fkDOu2XgPHJBhqzx0=;
        b=mhRGmrFR8w90RrdcRZ6zGJFfnaaxs9OfsT4BIFKgLD1uVO4EU9pJTyCNRyB77J1wPiKodQEVVZLTZsAlaMTQvUl9yjoDxGuHJTee2OFuZF3q+UT7JJhErr+3PNx2tIwSfaxxu3mTTDTVygqwY7ysjpz6/IkRQritzmv4AnmNJyg=;
X-UUID: e125096b405f44278cb953e13374a93c-20200621
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 678863230; Sun, 21 Jun 2020 22:18:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 22:18:31 +0800
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
Subject: [PATCH v1 08/11] soc: mediatek: cmdq: export finalize function
Date:   Sun, 21 Jun 2020 22:18:32 +0800
Message-ID: <1592749115-24158-9-git-send-email-dennis-yc.hsieh@mediatek.com>
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

RXhwb3J0IGZpbmFsaXplIGZ1bmN0aW9uIHRvIGNsaWVudCB3aGljaCBoZWxwcyBhcHBlbmQgZW9j
IGFuZCBqdW1wDQpjb21tYW5kIHRvIHBrdC4gTGV0IGNsaWVudCBkZWNpZGUgY2FsbCBmaW5hbGl6
ZSBvciBub3QuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhz
aWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KQWNrZWQtYnk6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgICAgMSArDQogZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgIHwgICAgNyArKy0tLS0tDQogaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgIHwgICAgOCArKysrKysrKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KaW5kZXggMGRmY2QxNzg3ZTY1Li43ZGFh
YWJjMjZlYjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KQEAg
LTQ5MCw2ICs0OTAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfaHdfY29uZmlnKHN0cnVj
dCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KIAkJY21kcV9wa3RfY2xlYXJfZXZlbnQoY21kcV9o
YW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCiAJCWNtZHFfcGt0X3dmZShjbWRxX2hhbmRs
ZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBj
bWRxX2hhbmRsZSk7DQorCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7DQogCQljbWRx
X3BrdF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFfY2IsIGNtZHFfaGFuZGxlKTsN
CiAJfQ0KICNlbmRpZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4
IGUzNzJhZTA2NTI0MC4uMjQ4OTQ1MTA4YTM2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQpAQCAtMzkxLDcgKzM5MSw3IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQogfQ0KIEVYUE9SVF9T
WU1CT0woY21kcV9wa3RfYXNzaWduKTsNCiANCi1zdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXpl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9
Ow0KIAlpbnQgZXJyOw0KQEAgLTQxMSw2ICs0MTEsNyBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2Zp
bmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIA0KIAlyZXR1cm4gZXJyOw0KIH0NCitFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplKTsNCiANCiBzdGF0aWMgdm9pZCBjbWRxX3BrdF9m
bHVzaF9hc3luY19jYihzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpDQogew0KQEAgLTQ0NSwxMCAr
NDQ2LDYgQEAgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBj
bWRxX2FzeW5jX2ZsdXNoX2NiIGNiLA0KIAl1bnNpZ25lZCBsb25nIGZsYWdzID0gMDsNCiAJc3Ry
dWN0IGNtZHFfY2xpZW50ICpjbGllbnQgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsN
CiANCi0JZXJyID0gY21kcV9wa3RfZmluYWxpemUocGt0KTsNCi0JaWYgKGVyciA8IDApDQotCQly
ZXR1cm4gZXJyOw0KLQ0KIAlwa3QtPmNiLmNiID0gY2I7DQogCXBrdC0+Y2IuZGF0YSA9IGRhdGE7
DQogCXBrdC0+YXN5bmNfY2IuY2IgPSBjbWRxX3BrdF9mbHVzaF9hc3luY19jYjsNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggNmU4Y2FhY2VkYzgwLi5lYWMxNDA1ZTQ4
NzIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQor
KysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMjQ0LDYgKzI0
NCwxNCBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBz
dWJzeXMsDQogaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJl
Z19pZHgsIHUzMiB2YWx1ZSk7DQogDQogLyoqDQorICogY21kcV9wa3RfZmluYWxpemUoKSAtIEFw
cGVuZCBFT0MgYW5kIGp1bXAgY29tbWFuZCB0byBwa3QuDQorICogQHBrdDoJdGhlIENNRFEgcGFj
a2V0DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUg
aXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0
ICpwa3QpOw0KKw0KKy8qKg0KICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENN
RFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KICAqICAgICAgICAgICAgICAg
ICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0
DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotLSANCjEuNy45LjUNCg==


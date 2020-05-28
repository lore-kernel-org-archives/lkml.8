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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC99C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE68120721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AKmun7AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405504AbgE1RG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:06:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405371AbgE1RFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:23 -0400
X-UUID: 7c0abf73305c400bb76417665d51c855-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jXJOAQoUzXd2rU2iANdUYvuiImO+8biZmv0Q5o4y4ds=;
        b=AKmun7AFyD5+565g1rkS9N5SKFunYuRDRagJlCtJX1fw/vrHHjn0c1+f4hwixg8LTXoOPdVpY3bXeOoStNcqOfc3+e+hrQQXoBAkyglyFAkCD5X1nvCHVJFgdMD0lo0xjGiZfkOzxPOwAyw/5ubCdY9To4/Wg2T1V2Wfa3FliGQ=;
X-UUID: 7c0abf73305c400bb76417665d51c855-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 206309768; Fri, 29 May 2020 01:05:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v6 13/16] soc: mediatek: cmdq: export finalize function
Date:   Fri, 29 May 2020 01:04:48 +0800
Message-ID: <1590685491-17107-14-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B222A76046E33343BE5B049134F52DC03B6DFA20A3152CD5D1241F3BE9943F9E2000:8
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
DQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgMSArDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgIHwgNyArKy0tLS0tDQogaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgIHwgOCArKysrKysrKw0KIDMgZmlsZXMgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KaW5kZXggMGRmY2QxNzg3ZTY1Li43ZGFhYWJjMjZlYjEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KQEAgLTQ5MCw2ICs0
OTAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfaHdfY29uZmlnKHN0cnVjdCBtdGtfZHJt
X2NydGMgKm10a19jcnRjKQ0KIAkJY21kcV9wa3RfY2xlYXJfZXZlbnQoY21kcV9oYW5kbGUsIG10
a19jcnRjLT5jbWRxX2V2ZW50KTsNCiAJCWNtZHFfcGt0X3dmZShjbWRxX2hhbmRsZSwgbXRrX2Ny
dGMtPmNtZHFfZXZlbnQpOw0KIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBjbWRxX2hhbmRs
ZSk7DQorCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7DQogCQljbWRxX3BrdF9mbHVz
aF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFfY2IsIGNtZHFfaGFuZGxlKTsNCiAJfQ0KICNl
bmRpZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDRiMDdkYTU2
YzdiYi4uZWJjZGQzMGNkNzgzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQpAQCAtMzkxLDcgKzM5MSw3IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQogfQ0KIEVYUE9SVF9TWU1CT0woY21k
cV9wa3RfYXNzaWduKTsNCiANCi1zdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBr
dCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KIAlpbnQg
ZXJyOw0KQEAgLTQxMSw2ICs0MTEsNyBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0
cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIA0KIAlyZXR1cm4gZXJyOw0KIH0NCitFWFBPUlRfU1lNQk9M
KGNtZHFfcGt0X2ZpbmFsaXplKTsNCiANCiBzdGF0aWMgdm9pZCBjbWRxX3BrdF9mbHVzaF9hc3lu
Y19jYihzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpDQogew0KQEAgLTQ0NSwxMCArNDQ2LDYgQEAg
aW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBjbWRxX2FzeW5j
X2ZsdXNoX2NiIGNiLA0KIAl1bnNpZ25lZCBsb25nIGZsYWdzID0gMDsNCiAJc3RydWN0IGNtZHFf
Y2xpZW50ICpjbGllbnQgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsNCiANCi0JZXJy
ID0gY21kcV9wa3RfZmluYWxpemUocGt0KTsNCi0JaWYgKGVyciA8IDApDQotCQlyZXR1cm4gZXJy
Ow0KLQ0KIAlwa3QtPmNiLmNiID0gY2I7DQogCXBrdC0+Y2IuZGF0YSA9IGRhdGE7DQogCXBrdC0+
YXN5bmNfY2IuY2IgPSBjbWRxX3BrdF9mbHVzaF9hc3luY19jYjsNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggMjhhNTBjM2NmNmExLi43MDNjZmZjZDU1YmQgMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMjQ0LDYgKzI0NCwxNCBAQCBp
bnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQog
ICovDQogaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19p
ZHgsIHUzMiB2YWx1ZSk7DQogDQorLyoqDQorICogY21kcV9wa3RfZmluYWxpemUoKSAtIEFwcGVu
ZCBFT0MgYW5kIGp1bXAgY29tbWFuZCB0byBwa3QuDQorICogQHBrdDoJdGhlIENNRFEgcGFja2V0
DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMg
cmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpw
a3QpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENNRFEg
dG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KICAqICAgICAgICAgICAgICAgICAg
ICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQot
LSANCjIuMTguMA0K


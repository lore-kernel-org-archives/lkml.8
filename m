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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB4C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B134B2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hrGWATHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgB1NpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59345 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727096AbgB1NpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:23 -0500
X-UUID: ebade297b4e34edcaae20c38a95773f6-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TKXJL9vVzdhmozmVndYQ12k2PLHyLpmAwIObwMyzwYk=;
        b=hrGWATHvPQ0dIkcKYG0cnSs3SY1Fn95rVMRS1VQ3dGne831rekNytHQUqCo9Pb/xZfUFKvJasrGBrMbqukVq00URXRZsNsqCbnQG2bbBCg7KqDj+FeRaWKslda0ZSfnfzwnjaDbhImL1ZUR7gcfsRW0A0E8mbFAFHUBLlqjdFgE=;
X-UUID: ebade297b4e34edcaae20c38a95773f6-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 353035926; Fri, 28 Feb 2020 21:45:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:46:46 +0800
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
Subject: [PATCH v3 10/13] soc: mediatek: cmdq: export finalize function
Date:   Fri, 28 Feb 2020 21:44:18 +0800
Message-ID: <1582897461-15105-12-git-send-email-dennis-yc.hsieh@mediatek.com>
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

RXhwb3J0IGZpbmFsaXplIGZ1bmN0aW9uIHRvIGNsaWVudCB3aGljaCBoZWxwcyBhcHBlbmQgZW9j
IGFuZCBqdW1wDQpjb21tYW5kIHRvIHBrdC4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhz
aWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYyB8IDcgKystLS0tLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmggIHwgOCArKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4
IDEzMzY1MjNlYjdkNC4uNThmZWM2MzRkY2YxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQpAQCAtMzcyLDcgKzM3Miw3IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQogfQ0KIEVYUE9SVF9T
WU1CT0woY21kcV9wa3RfYXNzaWduKTsNCiANCi1zdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXpl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9
Ow0KIAlpbnQgZXJyOw0KQEAgLTM5Miw2ICszOTIsNyBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2Zp
bmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIA0KIAlyZXR1cm4gZXJyOw0KIH0NCitFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplKTsNCiANCiBzdGF0aWMgdm9pZCBjbWRxX3BrdF9m
bHVzaF9hc3luY19jYihzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpDQogew0KQEAgLTQyNiwxMCAr
NDI3LDYgQEAgaW50IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBj
bWRxX2FzeW5jX2ZsdXNoX2NiIGNiLA0KIAl1bnNpZ25lZCBsb25nIGZsYWdzID0gMDsNCiAJc3Ry
dWN0IGNtZHFfY2xpZW50ICpjbGllbnQgPSAoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbDsN
CiANCi0JZXJyID0gY21kcV9wa3RfZmluYWxpemUocGt0KTsNCi0JaWYgKGVyciA8IDApDQotCQly
ZXR1cm4gZXJyOw0KLQ0KIAlwa3QtPmNiLmNiID0gY2I7DQogCXBrdC0+Y2IuZGF0YSA9IGRhdGE7
DQogCXBrdC0+YXN5bmNfY2IuY2IgPSBjbWRxX3BrdF9mbHVzaF9hc3luY19jYjsNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggZmVjMjkyYWFjODNjLi45OWU3NzE1NWY5
NjcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQor
KysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMjEzLDYgKzIx
MywxNCBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBz
dWJzeXMsDQogICovDQogaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSk7DQogDQorLyoqDQorICogY21kcV9wa3RfZmluYWxpemUo
KSAtIEFwcGVuZCBFT0MgYW5kIGp1bXAgY29tbWFuZCB0byBwa3QuDQorICogQHBrdDoJdGhlIENN
RFEgcGFja2V0DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9y
IGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmln
Z2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KICAqICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUg
cGFja2V0DQotLSANCjIuMTguMA0K


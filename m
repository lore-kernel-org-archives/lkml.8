Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4FC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD5C24699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KtqMprH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgB1NpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:64957 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727018AbgB1NpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:13 -0500
X-UUID: 1fac3e626be44ad4b71fe01dd4a9ffe2-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cboCRZgtbMRKG7dnNyYFwyS8wl4wWUNnD8jnwAzifvk=;
        b=KtqMprH2hVpda6wbcgox6QJjrp+yPQ+GH4UEpsKb85wnHeEkDjDNRLpbgIHkvBJ3wcfYdWWDdJZa4P7hEMi3SABfHyU0eSgSnh2+NkpP1VAgR8fFfqxdwxtKYIh2lue8M2j9Y9I4zPzHUEfgKjLJK5xa2sEX1stxRB2gL5UtXsQ=;
X-UUID: 1fac3e626be44ad4b71fe01dd4a9ffe2-20200228
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 915688716; Fri, 28 Feb 2020 21:45:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:45:05 +0800
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
Subject: [PATCH v3 13/13] soc: mediatek: cmdq: add set event function
Date:   Fri, 28 Feb 2020 21:44:21 +0800
Message-ID: <1582897461-15105-15-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIHNldCBldmVudCBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgdG8gc2V0IHNw
ZWNpZmljIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyAgIHwgMTUgKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaCB8ICAxICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oICAgIHwgIDkgKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA0MDZl
MWQzNGQyMzQuLjczOGY4M2Q5MGI1OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KQEAgLTMyNiw2ICszMjYsMjEgQEAgaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9w
a3RfY2xlYXJfZXZlbnQpOw0KIA0KK2ludCBjbWRxX3BrdF9zZXRfZXZlbnQoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiBldmVudCkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3Qg
PSB7IHswfSB9Ow0KKw0KKwlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQorCQlyZXR1cm4g
LUVJTlZBTDsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7DQorCWluc3QudmFsdWUgPSBD
TURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFMVUU7DQorCWluc3QuZXZlbnQgPSBl
dmVudDsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQor
fQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfc2V0X2V2ZW50KTsNCisNCiBpbnQgY21kcV9wa3Rf
cG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIAkJICB1MTYgb2Zmc2V0LCB1
MzIgdmFsdWUpDQogew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpp
bmRleCA0MmQyYTMwZTZhNzAuLmJhMmQ4MTExODNhOSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC0xNyw2ICsxNyw3IEBADQogI2RlZmluZSBDTURRX0pV
TVBfUEFTUwkJCUNNRFFfSU5TVF9TSVpFDQogDQogI2RlZmluZSBDTURRX1dGRV9VUERBVEUJCQlC
SVQoMzEpDQorI2RlZmluZSBDTURRX1dGRV9VUERBVEVfVkFMVUUJCUJJVCgxNikNCiAjZGVmaW5l
IENNRFFfV0ZFX1dBSVQJCQlCSVQoMTUpDQogI2RlZmluZSBDTURRX1dGRV9XQUlUX1ZBTFVFCQkw
eDENCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggZDYzNzQ5NDQw
Njk3Li5jYTcwMjk2YWUxMjAgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQpAQCAtMTY4LDYgKzE2OCwxNSBAQCBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpOw0KICAqLw0KIGludCBjbWRxX3BrdF9jbGVhcl9l
dmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsNCiANCisvKioNCisgKiBjbWRx
X3BrdF9zZXRfZXZlbnQoKSAtIGFwcGVuZCBzZXQgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBw
YWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAZXZlbnQ6CXRoZSBkZXNpcmVk
IGV2ZW50IHRvIGJlIHNldA0KKyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRo
ZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNtZHFfcGt0X3NldF9ldmVudChz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsNCisNCiAvKioNCiAgKiBjbWRxX3BrdF9w
b2xsKCkgLSBBcHBlbmQgcG9sbGluZyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdD
RSB0bw0KICAqCQkgICAgIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCB3YWl0IGZvciBhIHNw
ZWNpZmllZA0KLS0gDQoyLjE4LjANCg==


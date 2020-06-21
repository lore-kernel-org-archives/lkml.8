Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B206C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD0C24922
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="la4Z/SQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgFUOSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12535 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730077AbgFUOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:44 -0400
X-UUID: 6ed932bbf5a04794b0433ec4411c5b3e-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n/QD0qcLAJD0OBYaRATvoXFlm1r9NgBpP+XU1dQaC1I=;
        b=la4Z/SQm9lVobvrt6Rt+AX1jbrmpgZNN/NT6FgKFuoKZxbIzYEPZ5osJgjC6CH4e6CDr4BadfkHNTWTcl25mN+33/P/wGFkikgvo227h2/g0y8ugRgaisZjjOjukQrO1io2dVxmwhzckamhOYwdTtolNfZ69HVCmSQTl1yoq73g=;
X-UUID: 6ed932bbf5a04794b0433ec4411c5b3e-20200621
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1779418893; Sun, 21 Jun 2020 22:18:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:31 +0800
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
Subject: [PATCH v1 11/11] soc: mediatek: cmdq: add set event function
Date:   Sun, 21 Jun 2020 22:18:35 +0800
Message-ID: <1592749115-24158-12-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9B5C3261FC5246A9A8EF586AE5D0421AEB9F7773125B606A94C455B17CD4583D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNldCBldmVudCBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgdG8gc2V0IHNw
ZWNpZmljIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyAgIHwgICAxNSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSArDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCAgICB8ICAgIDkgKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRl
eCAxM2Y3OGM5YjU5MDEuLmU2MTMzYTQyZDIyOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KQEAgLTM0Niw2ICszNDYsMjEgQEAgaW50IGNtZHFfcGt0X2NsZWFyX2V2
ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogfQ0KIEVYUE9SVF9TWU1CT0wo
Y21kcV9wa3RfY2xlYXJfZXZlbnQpOw0KIA0KK2ludCBjbWRxX3BrdF9zZXRfZXZlbnQoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9u
IGluc3QgPSB7fTsNCisNCisJaWYgKGV2ZW50ID49IENNRFFfTUFYX0VWRU5UKQ0KKwkJcmV0dXJu
IC1FSU5WQUw7DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfV0ZFOw0KKwlpbnN0LnZhbHVlID0g
Q01EUV9XRkVfVVBEQVRFIHwgQ01EUV9XRkVfVVBEQVRFX1ZBTFVFOw0KKwlpbnN0LmV2ZW50ID0g
ZXZlbnQ7DQorDQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0K
K30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3NldF9ldmVudCk7DQorDQogaW50IGNtZHFfcGt0
X3BvbGwoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiAJCSAgdTE2IG9mZnNldCwg
dTMyIHZhbHVlKQ0KIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0K
aW5kZXggNDJkMmEzMGU2YTcwLi5iYTJkODExMTgzYTkgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oDQpAQCAtMTcsNiArMTcsNyBAQA0KICNkZWZpbmUgQ01EUV9K
VU1QX1BBU1MJCQlDTURRX0lOU1RfU0laRQ0KIA0KICNkZWZpbmUgQ01EUV9XRkVfVVBEQVRFCQkJ
QklUKDMxKQ0KKyNkZWZpbmUgQ01EUV9XRkVfVVBEQVRFX1ZBTFVFCQlCSVQoMTYpDQogI2RlZmlu
ZSBDTURRX1dGRV9XQUlUCQkJQklUKDE1KQ0KICNkZWZpbmUgQ01EUV9XRkVfV0FJVF9WQUxVRQkJ
MHgxDQogDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDRiNWY1ZDE1
NGJhZC4uOTYwNzA0ZDc1OTk0IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aA0KQEAgLTE5OSw2ICsxOTksMTUgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZShz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgsDQogaW50IGNtZHFfcGt0
X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KIA0KIC8qKg0K
KyAqIGNtZHFfcGt0X3NldF9ldmVudCgpIC0gYXBwZW5kIHNldCBldmVudCBjb21tYW5kIHRvIHRo
ZSBDTURRIHBhY2tldA0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqIEBldmVudDoJdGhl
IGRlc2lyZWQgZXZlbnQgdG8gYmUgc2V0DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7
IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3Rfc2V0
X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KKw0KKy8qKg0KICAqIGNt
ZHFfcGt0X3BvbGwoKSAtIEFwcGVuZCBwb2xsaW5nIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0
LCBhc2sgR0NFIHRvDQogICoJCSAgICAgZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHdhaXQg
Zm9yIGEgc3BlY2lmaWVkDQogICoJCSAgICAgaGFyZHdhcmUgcmVnaXN0ZXIgdG8gY2hlY2sgZm9y
IHRoZSB2YWx1ZSB3L28gbWFzay4NCi0tIA0KMS43LjkuNQ0K


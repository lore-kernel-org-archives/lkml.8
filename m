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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02562208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V1pchG7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405447AbgE1RF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:05:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405378AbgE1RFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:23 -0400
X-UUID: 472895f1d076407fa927842fa5903ceb-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jXGE+hYgBs3oPyBPAQ0ebVKN3bSWPLCsVNhlOqhbvHg=;
        b=V1pchG7AVkud645jmQ3QAjaqrm3sbr1oB0R0E7zI7sH7fd5x0uSQ3LKzTt7gMfZxoXu9D4n4aVIAVM0oyVtEWWlfGju1pxJZFzDTXk64UtdxaFI5qLuwHAPtERzq/AebaYmanxQGWht3+ConwvRf2yr03Ixuhpw2gcE77EIB5l4=;
X-UUID: 472895f1d076407fa927842fa5903ceb-20200529
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 276028837; Fri, 29 May 2020 01:05:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:10 +0800
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
Subject: [PATCH v6 16/16] soc: mediatek: cmdq: add set event function
Date:   Fri, 29 May 2020 01:04:51 +0800
Message-ID: <1590685491-17107-17-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 56617F63CC51ADD7C66EDB7B1D4639E09A5C3E1F232749219309A55CBEC22B882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNldCBldmVudCBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgdG8gc2V0IHNw
ZWNpZmljIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAx
NSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIHwgIDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAg
OSArKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDllOWE0YzgxNTUzYS4uZTliMWRk
MzFmNjNiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMzQ2
LDYgKzM0NiwyMSBAQCBpbnQgY21kcV9wa3RfY2xlYXJfZXZlbnQoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9jbGVhcl9ldmVudCk7
DQogDQoraW50IGNtZHFfcGt0X3NldF9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorDQor
CWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCisJaW5zdC52YWx1ZSA9IENNRFFfV0ZFX1VQREFURSB8
IENNRFFfV0ZFX1VQREFURV9WQUxVRTsNCisJaW5zdC5ldmVudCA9IGV2ZW50Ow0KKw0KKwlyZXR1
cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF9zZXRfZXZlbnQpOw0KKw0KIGludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogCQkgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSkNCiB7DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IDQyZDJhMzBlNmE3
MC4uYmEyZDgxMTE4M2E5IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KQEAgLTE3LDYgKzE3LDcgQEANCiAjZGVmaW5lIENNRFFfSlVNUF9QQVNTCQkJQ01EUV9J
TlNUX1NJWkUNCiANCiAjZGVmaW5lIENNRFFfV0ZFX1VQREFURQkJCUJJVCgzMSkNCisjZGVmaW5l
IENNRFFfV0ZFX1VQREFURV9WQUxVRQkJQklUKDE2KQ0KICNkZWZpbmUgQ01EUV9XRkVfV0FJVAkJ
CUJJVCgxNSkNCiAjZGVmaW5lIENNRFFfV0ZFX1dBSVRfVkFMVUUJCTB4MQ0KIA0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCAzMjE2Y2NmZmY0YTkuLmVhMjYwMjBlNjNi
ZiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xOTksNiArMTk5
LDE1IEBAIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwg
Ym9vbCBjbGVhcik7DQogICovDQogaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KIA0KKy8qKg0KKyAqIGNtZHFfcGt0X3NldF9ldmVudCgp
IC0gYXBwZW5kIHNldCBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KKyAqIEBwa3Q6
CXRoZSBDTURRIHBhY2tldA0KKyAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdG8gYmUgc2V0
DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMg
cmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3Rfc2V0X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgZXZlbnQpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X3BvbGwoKSAtIEFwcGVuZCBw
b2xsaW5nIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFIHRvDQogICoJCSAgICAg
ZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHdhaXQgZm9yIGEgc3BlY2lmaWVkDQotLSANCjIu
MTguMA0K


Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABEAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39E7246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GJJP3xaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgB1NpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59345 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727048AbgB1NpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:21 -0500
X-UUID: 15e91380469f439d9cdfc43b14ebad27-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Diu/R7310fYqKDaScMuQ2G1V+kxkV4MYnxmjnyYom8M=;
        b=GJJP3xaSQTyBSZfx9SyRlKqioqnoh2yvyyEfL/2PVBnPi4lH88abt+SIhtRxDllTrXxdrvnUu+lUml3AMjxlkTtbI+xQ+WVPgs50GY5VQe+5oVrOe2SXW3tvSi4C+OrPsTWAP0Vs+RBceAXlKwCsDrgib2/SqQTLaBuIjSDTjcM=;
X-UUID: 15e91380469f439d9cdfc43b14ebad27-20200228
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 104163788; Fri, 28 Feb 2020 21:45:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v3 12/13] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Fri, 28 Feb 2020 21:44:20 +0800
Message-ID: <1582897461-15105-14-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8C8D12D3777DD2317846D04236839F1ED3959A154CEC5FADD60573DE943199792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCA1ICsrKy0tDQogaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8IDMgKy0tDQogaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDUgKysrLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMNCmluZGV4IGJiYzY4YTdjODFlOS4uNDA2ZTFkMzRkMjM0IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMjk1LDE1ICsyOTUsMTYgQEAgaW50
IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2Fk
ZHJfcmVnX2lkeCwNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKTsN
CiANCi1pbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQor
aW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50LCBib29sIGNs
ZWFyKQ0KIHsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorCXUz
MiBjbGVhcl9vcHRpb24gPSBjbGVhciA/IENNRFFfV0ZFX1VQREFURSA6IDA7DQogDQogCWlmIChl
dmVudCA+PSBDTURRX01BWF9FVkVOVCkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KIAlpbnN0Lm9w
ID0gQ01EUV9DT0RFX1dGRTsNCi0JaW5zdC52YWx1ZSA9IENNRFFfV0ZFX09QVElPTjsNCisJaW5z
dC52YWx1ZSA9IENNRFFfV0ZFX09QVElPTiB8IGNsZWFyX29wdGlvbjsNCiAJaW5zdC5ldmVudCA9
IGV2ZW50Ow0KIA0KIAlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KaW5kZXggM2Y2YmMwZGZk
NWRhLi40MmQyYTMwZTZhNzAgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFp
bGJveC5oDQpAQCAtMjcsOCArMjcsNyBAQA0KICAqIGJpdCAxNi0yNzogdXBkYXRlIHZhbHVlDQog
ICogYml0IDMxOiAxIC0gdXBkYXRlLCAwIC0gbm8gdXBkYXRlDQogICovDQotI2RlZmluZSBDTURR
X1dGRV9PUFRJT04JCQkoQ01EUV9XRkVfVVBEQVRFIHwgQ01EUV9XRkVfV0FJVCB8IFwNCi0JCQkJ
CUNNRFFfV0ZFX1dBSVRfVkFMVUUpDQorI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9X
RkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQogDQogLyoqIGNtZHEgZXZlbnQgbWF4aW11
bSAqLw0KICNkZWZpbmUgQ01EUV9NQVhfRVZFTlQJCQkweDNmZg0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQppbmRleCAxYTZjNTZmM2JlYzEuLmQ2Mzc0OTQ0MDY5NyAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xNTIsMTEgKzE1MiwxMiBAQCBp
bnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hf
YWRkcl9yZWdfaWR4LA0KIC8qKg0KICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9y
IGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFj
a2V0DQotICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvICJ3YWl0IGFuZCBDTEVB
UiINCisgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gd2FpdA0KKyAqIEBjbGVh
cjoJY2xlYXIgZXZlbnQgb3Igbm90IGFmdGVyIGV2ZW50IGFycml2ZQ0KICAqDQogICogUmV0dXJu
OiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQogICovDQot
aW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsNCitpbnQg
Y21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIp
Ow0KIA0KIC8qKg0KICAqIGNtZHFfcGt0X2NsZWFyX2V2ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZl
bnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCi0tIA0KMi4xOC4wDQo=


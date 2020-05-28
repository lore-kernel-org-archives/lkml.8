Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18FD208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tyRoWPAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405434AbgE1RFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:05:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405372AbgE1RFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:21 -0400
X-UUID: c17741b5fcb1400b831acbb7300696ef-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ji9H1E5vbwxd7CeKqgjMppwKo2IKtgv1TNRwCWXxzlU=;
        b=tyRoWPAzaQf1rtT0N8NuM4Tt9wGzM0FxhdtwNRCk/Z1YSme3I9PDIA11aqacG+daWvrZdW+Hv6A+za49witPN6lZ+0I1j0wYITyJ5zx09onb71F+JD2HFxPsWmNA643E47pKbaUapHZo/bEJwZFFSqAALsJrt+aHdcM6M1CBW9Q=;
X-UUID: c17741b5fcb1400b831acbb7300696ef-20200529
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1113529576; Fri, 29 May 2020 01:05:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v6 15/16] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Fri, 29 May 2020 01:04:50 +0800
Message-ID: <1590685491-17107-16-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jICB8IDIgKy0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyAgIHwgNSArKystLQ0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmggfCAzICstLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
ICAgfCA1ICsrKy0tDQogNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCmluZGV4IDdk
YWFhYmMyNmViMS4uYTA2NWIzYTQxMmNmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMNCkBAIC00ODgsNyArNDg4LDcgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRj
X2h3X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJaWYgKG10a19jcnRj
LT5jbWRxX2NsaWVudCkgew0KIAkJY21kcV9oYW5kbGUgPSBjbWRxX3BrdF9jcmVhdGUobXRrX2Ny
dGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KIAkJY21kcV9wa3RfY2xlYXJfZXZlbnQoY21k
cV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCi0JCWNtZHFfcGt0X3dmZShjbWRxX2hh
bmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KKwkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxl
LCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgZmFsc2UpOw0KIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhj
cnRjLCBjbWRxX2hhbmRsZSk7DQogCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7DQog
CQljbWRxX3BrdF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFfY2IsIGNtZHFfaGFu
ZGxlKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA1Y2Y5ZTcx
Yjc5MDAuLjllOWE0YzgxNTUzYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KQEAgLTMxNSwxNSArMzE1LDE2IEBAIGludCBjbWRxX3BrdF93cml0ZV9zX21hc2tfdmFs
dWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KIH0NCiBFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZSk7DQogDQotaW50IGNtZHFfcGt0
X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KK2ludCBjbWRxX3BrdF93ZmUo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikNCiB7DQogCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwl1MzIgY2xlYXJfb3B0aW9uID0g
Y2xlYXIgPyBDTURRX1dGRV9VUERBVEUgOiAwOw0KIA0KIAlpZiAoZXZlbnQgPj0gQ01EUV9NQVhf
RVZFTlQpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7
DQotCWluc3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT047DQorCWluc3QudmFsdWUgPSBDTURRX1dG
RV9PUFRJT04gfCBjbGVhcl9vcHRpb247DQogCWluc3QuZXZlbnQgPSBldmVudDsNCiANCiAJcmV0
dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IDNmNmJjMGRmZDVkYS4uNDJkMmEzMGU2YTcw
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0K
KysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KQEAgLTI3LDgg
KzI3LDcgQEANCiAgKiBiaXQgMTYtMjc6IHVwZGF0ZSB2YWx1ZQ0KICAqIGJpdCAzMTogMSAtIHVw
ZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KICAqLw0KLSNkZWZpbmUgQ01EUV9XRkVfT1BUSU9OCQkJKENN
RFFfV0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBcDQotCQkJCQlDTURRX1dGRV9XQUlUX1ZB
TFVFKQ0KKyNkZWZpbmUgQ01EUV9XRkVfT1BUSU9OCQkJKENNRFFfV0ZFX1dBSVQgfCBDTURRX1dG
RV9XQUlUX1ZBTFVFKQ0KIA0KIC8qKiBjbWRxIGV2ZW50IG1heGltdW0gKi8NCiAjZGVmaW5lIENN
RFFfTUFYX0VWRU5UCQkJMHgzZmYNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
aW5kZXggOTQ5NGIyOTNiYWQ5Li4zMjE2Y2NmZmY0YTkgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQpAQCAtMTgzLDExICsxODMsMTIgQEAgaW50IGNtZHFfcGt0X3dyaXRl
X3NfbWFza192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgs
DQogLyoqDQogICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFu
ZCB0byB0aGUgQ01EUSBwYWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0gKiBAZXZl
bnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gIndhaXQgYW5kIENMRUFSIg0KKyAqIEBldmVu
dDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byB3YWl0DQorICogQGNsZWFyOgljbGVhciBldmVu
dCBvciBub3QgYWZ0ZXIgZXZlbnQgYXJyaXZlDQogICoNCiAgKiBSZXR1cm46IDAgZm9yIHN1Y2Nl
c3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCiAgKi8NCi1pbnQgY21kcV9wa3Rf
d2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KK2ludCBjbWRxX3BrdF93ZmUo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQogDQogLyoqDQog
ICogY21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVudCBjb21tYW5kIHRv
IHRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==


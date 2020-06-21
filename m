Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5196AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333A52491F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iJltMxXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgFUOSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53483 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730180AbgFUOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:46 -0400
X-UUID: fe77747e07774aab9990b85ab1a9866c-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5m2JuhX9blldWadMtmtkEJTjR2iulTmsLwnDRtr3KBU=;
        b=iJltMxXx9S4xJFgnMavKDgCD80PaI/KRc1CTNSLEcreT1paOUvVpH1d2LqyEOqFs8zv+3QaxnS56QeKGZmxHrP6F/GXznor5E5K9YDGcUc6/JiNSzDfT4FfcmX7HhzmVmQzfaFiCW+6B+3kuYkHkTWK4UYSoZF+utytewb+amsI=;
X-UUID: fe77747e07774aab9990b85ab1a9866c-20200621
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1670965879; Sun, 21 Jun 2020 22:18:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v1 10/11] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Sun, 21 Jun 2020 22:18:34 +0800
Message-ID: <1592749115-24158-11-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jICB8ICAgIDIgKy0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYyAgIHwgICAgNSArKystLQ0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmggfCAgICAzICstLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmggICAgfCAgICA1ICsrKy0tDQogNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRj
LmMNCmluZGV4IDdkYWFhYmMyNmViMS4uYTA2NWIzYTQxMmNmIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCkBAIC00ODgsNyArNDg4LDcgQEAgc3RhdGljIHZvaWQg
bXRrX2RybV9jcnRjX2h3X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJ
aWYgKG10a19jcnRjLT5jbWRxX2NsaWVudCkgew0KIAkJY21kcV9oYW5kbGUgPSBjbWRxX3BrdF9j
cmVhdGUobXRrX2NydGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KIAkJY21kcV9wa3RfY2xl
YXJfZXZlbnQoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCi0JCWNtZHFfcGt0
X3dmZShjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KKwkJY21kcV9wa3Rfd2Zl
KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgZmFsc2UpOw0KIAkJbXRrX2NydGNf
ZGRwX2NvbmZpZyhjcnRjLCBjbWRxX2hhbmRsZSk7DQogCQljbWRxX3BrdF9maW5hbGl6ZShjbWRx
X2hhbmRsZSk7DQogCQljbWRxX3BrdF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFf
Y2IsIGNtZHFfaGFuZGxlKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpp
bmRleCAwMDlmODZhZTcyYzYuLjEzZjc4YzliNTkwMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KQEAgLTMxNSwxNSArMzE1LDE2IEBAIGludCBjbWRxX3BrdF93cml0
ZV9zX21hc2tfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4
LA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZSk7DQogDQot
aW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KK2ludCBj
bWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikN
CiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwl1MzIgY2xl
YXJfb3B0aW9uID0gY2xlYXIgPyBDTURRX1dGRV9VUERBVEUgOiAwOw0KIA0KIAlpZiAoZXZlbnQg
Pj0gQ01EUV9NQVhfRVZFTlQpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJaW5zdC5vcCA9IENN
RFFfQ09ERV9XRkU7DQotCWluc3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT047DQorCWluc3QudmFs
dWUgPSBDTURRX1dGRV9PUFRJT04gfCBjbGVhcl9vcHRpb247DQogCWluc3QuZXZlbnQgPSBldmVu
dDsNCiANCiAJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1
ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IDNmNmJjMGRmZDVkYS4u
NDJkMmEzMGU2YTcwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
aA0KQEAgLTI3LDggKzI3LDcgQEANCiAgKiBiaXQgMTYtMjc6IHVwZGF0ZSB2YWx1ZQ0KICAqIGJp
dCAzMTogMSAtIHVwZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KICAqLw0KLSNkZWZpbmUgQ01EUV9XRkVf
T1BUSU9OCQkJKENNRFFfV0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBcDQotCQkJCQlDTURR
X1dGRV9XQUlUX1ZBTFVFKQ0KKyNkZWZpbmUgQ01EUV9XRkVfT1BUSU9OCQkJKENNRFFfV0ZFX1dB
SVQgfCBDTURRX1dGRV9XQUlUX1ZBTFVFKQ0KIA0KIC8qKiBjbWRxIGV2ZW50IG1heGltdW0gKi8N
CiAjZGVmaW5lIENNRFFfTUFYX0VWRU5UCQkJMHgzZmYNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KaW5kZXggMTgzNjRkODFlOGY3Li40YjVmNWQxNTRiYWQgMTAwNjQ0DQotLS0g
YS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMTgyLDExICsxODIsMTIgQEAgaW50IGNt
ZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggaGlnaF9h
ZGRyX3JlZ19pZHgsDQogLyoqDQogICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3Ig
ZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCi0gKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gIndhaXQgYW5kIENMRUFS
Ig0KKyAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byB3YWl0DQorICogQGNsZWFy
OgljbGVhciBldmVudCBvciBub3QgYWZ0ZXIgZXZlbnQgYXJyaXZlDQogICoNCiAgKiBSZXR1cm46
IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCiAgKi8NCi1p
bnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KK2ludCBj
bWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7
DQogDQogLyoqDQogICogY21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVu
dCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KLS0gDQoxLjcuOS41DQo=


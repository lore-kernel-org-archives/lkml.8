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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0947C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D6020721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bdLkZ55g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405455AbgE1RGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:06:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54841 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405379AbgE1RFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:24 -0400
X-UUID: 8e47409db21241609d0e96975fd64d74-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y/SpmX9E+bEC8sh0zo1++jK/O9BI2h4qV9elHeuJ+go=;
        b=bdLkZ55gFj148EfHy8/SSTn7B4xpFYuajYjCgkZehmtw9lIP7ERmv4xbg8H6bA/s0gnREqYxuZcizPFSCnGVk2aTvqFcKAPHFVnmuGU17BJRKiMtuo5H3/rrcKpO3mLl/goNK0VGHTIPiNkFWrO2TrerpmnmigrCrFWdWoZpMIo=;
X-UUID: 8e47409db21241609d0e96975fd64d74-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1513456672; Fri, 29 May 2020 01:05:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:08 +0800
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
Subject: [PATCH v6 08/16] soc: mediatek: cmdq: add write_s function
Date:   Fri, 29 May 2020 01:04:43 +0800
Message-ID: <1590685491-17107-9-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E3C3D0E7B3FF7BF8B63BF0C3994412FE370B6B6C6A306CE9CEEAA4033BFA898B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0Kd2l0aCBs
YXJnZSBkbWEgYWNjZXNzIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAyMSArKysrKysrKysrKysrKysrKysrKy0NCiBpbmNs
dWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDEgKw0KIGluY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0K
IDMgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMzMxNTNkMTdjOWQ5Li5lZTI0
YzBlYzBhMjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0x
OCw2ICsxOCwxMCBAQCBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCiAJCXUz
MiB2YWx1ZTsNCiAJCXUzMiBtYXNrOw0KKwkJc3RydWN0IHsNCisJCQl1MTYgYXJnX2M7DQorCQkJ
dTE2IHNyY19yZWc7DQorCQl9Ow0KIAl9Ow0KIAl1bmlvbiB7DQogCQl1MTYgb2Zmc2V0Ow0KQEAg
LTI5LDcgKzMzLDcgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAkJc3RydWN0IHsNCiAJ
CQl1OCBzb3A6NTsNCiAJCQl1OCBhcmdfY190OjE7DQotCQkJdTggYXJnX2JfdDoxOw0KKwkJCXU4
IHNyY190OjE7DQogCQkJdTggZHN0X3Q6MTsNCiAJCX07DQogCX07DQpAQCAtMjIyLDYgKzIyNiwy
MSBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vi
c3lzLA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX21hc2spOw0KIA0KK2ludCBj
bWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19p
ZHgsDQorCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4KQ0KK3sNCisJc3RydWN0
IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorDQorCWluc3Qub3AgPSBDTURRX0NP
REVfV1JJVEVfUzsNCisJaW5zdC5zcmNfdCA9IENNRFFfUkVHX1RZUEU7DQorCWluc3Quc29wID0g
aGlnaF9hZGRyX3JlZ19pZHg7DQorCWluc3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQorCWluc3Quc3Jj
X3JlZyA9IHNyY19yZWdfaWR4Ow0KKw0KKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQo
cGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zKTsNCisNCiBp
bnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogew0KIAlz
dHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWls
Ym94L210ay1jbWRxLW1haWxib3guaA0KaW5kZXggMTIxYzNiYjZkM2RlLi5lZTY3ZGQzYjg2ZjUg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQor
KysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpAQCAtNTksNiAr
NTksNyBAQCBlbnVtIGNtZHFfY29kZSB7DQogCUNNRFFfQ09ERV9KVU1QID0gMHgxMCwNCiAJQ01E
UV9DT0RFX1dGRSA9IDB4MjAsDQogCUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KKwlDTURRX0NPREVf
V1JJVEVfUyA9IDB4OTAsDQogCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQogfTsNCiANCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggODMzNDAyMTFlMWQzLi5kNjIzZjFh
YTc4MTQgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMTIsNiAr
MTIsOCBAQA0KICNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0KIA0KICNkZWZpbmUgQ01EUV9OT19U
SU1FT1VUCQkweGZmZmZmZmZmdQ0KKyNkZWZpbmUgQ01EUV9BRERSX0hJR0goYWRkcikJKCh1MzIp
KCgoYWRkcikgPj4gMTYpICYgR0VOTUFTSygzMSwgMCkpKQ0KKyNkZWZpbmUgQ01EUV9BRERSX0xP
VyhhZGRyKQkoKHUxNikoYWRkcikgfCBCSVQoMSkpDQogDQogc3RydWN0IGNtZHFfcGt0Ow0KIA0K
QEAgLTEwMiw2ICsxMDQsMjQgQEAgaW50IGNtZHFfcGt0X3dyaXRlKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1OCBzdWJzeXMsIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSk7DQogaW50IGNtZHFfcGt0X3dy
aXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiAJCQl1MTYgb2Zmc2V0
LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCiANCisvKioNCisgKiBjbWRxX3BrdF93cml0ZV9zKCkg
LSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KKyAqIEBwa3Q6CXRo
ZSBDTURRIHBhY2tldA0KKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXN0ZXIg
SUQgd2hpY2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQorICogQGFkZHJfbG93Oglsb3cg
YWRkcmVzcyBvZiBwYQ0KKyAqIEBzcmNfcmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0
ZXIgSUQgd2hpY2ggY2FjaGUgc291cmNlIHZhbHVlDQorICogQG1hc2s6CXRoZSBzcGVjaWZpZWQg
dGFyZ2V0IGFkZHJlc3MgbWFzaywgdXNlIFUzMl9NQVggaWYgbm8gbmVlZA0KKyAqDQorICogUmV0
dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICoN
CisgKiBTdXBwb3J0IHdyaXRlIHZhbHVlIHRvIHBoeXNpY2FsIGFkZHJlc3Mgd2l0aG91dCBzdWJz
eXMuIFVzZSBDTURRX0FERFJfSElHSCgpDQorICogdG8gZ2V0IGhpZ2ggYWRkcmVzcyBhbmQgY2Fs
bCBjbWRxX3BrdF9hc3NpZ24oKSB0byBhc3NpZ24gdmFsdWUgaW50byBpbnRlcm5hbA0KKyAqIHJl
Zy4gQWxzbyB1c2UgQ01EUV9BRERSX0xPVygpIHRvIGdldCBsb3cgYWRkcmVzcyBmb3IgYWRkcl9s
b3cgcGFyYW1ldGVyIHdoZW4NCisgKiBjYWxsIHRvIHRoaXMgZnVuY3Rpb24uDQorICovDQoraW50
IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVn
X2lkeCwNCisJCSAgICAgdTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgpOw0KKw0KIC8qKg0K
ICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhl
IENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotLSANCjIuMTguMA0K


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14A420721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X1pyLM8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbgE1RGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:06:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405387AbgE1RF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:26 -0400
X-UUID: e85c917b7d314a21b8572b409e964c61-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cDduTwzUM4cbHoNLZW4CkXVkomSzj7HUBGDiEdYn5EU=;
        b=X1pyLM8Dk9OljAtgcrw9SDX5I3ugybx8awrLQsVE4sPmCXST2oaPjFZsb1AI5EFcrbNaPS6x/0rTGfrPZthM8NY2kNKKvyhaTplBuMD6Z6l1EXVzrxxVXiG9THUSgkP7WdTDHvfUG1QfH0yfptVchOtKnqlrnnFHhxeldu/rWN0=;
X-UUID: e85c917b7d314a21b8572b409e964c61-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 261678183; Fri, 29 May 2020 01:05:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:09 +0800
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
Subject: [PATCH v6 10/16] soc: mediatek: cmdq: add read_s function
Date:   Fri, 29 May 2020 01:04:45 +0800
Message-ID: <1590685491-17107-11-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIHJlYWRfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggc3VwcG9y
dCByZWFkIHZhbHVlIGZyb20NCnJlZ2lzdGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8g
Z2NlIGludGVybmFsIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jICAgfCAxNSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oIHwgIDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmggICAgfCAxMyArKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA1OGE0MTQ3
OTA0NzEuLjAyYWMwY2EyM2Y2ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KQEAgLTIyNiw2ICsyMjYsMjEgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93
cml0ZV9tYXNrKTsNCiANCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsIHUxNiBhZGRyX2xvdywNCisJCSAgICB1MTYgcmVnX2lk
eCkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKw0KKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX1JFQURfUzsNCisJaW5zdC5kc3RfdCA9IENNRFFfUkVHX1RZUEU7
DQorCWluc3Quc29wID0gaGlnaF9hZGRyX3JlZ19pZHg7DQorCWluc3QucmVnX2RzdCA9IHJlZ19p
ZHg7DQorCWluc3Quc3JjX3JlZyA9IGFkZHJfbG93Ow0KKw0KKwlyZXR1cm4gY21kcV9wa3RfYXBw
ZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9yZWFk
X3MpOw0KKw0KIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYg
aGlnaF9hZGRyX3JlZ19pZHgsDQogCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4
KQ0KIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KaW5kZXggOGVm
ODdlMWJkMDNiLi4zZjZiYzBkZmQ1ZGEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oDQpAQCAtNTksNiArNTksNyBAQCBlbnVtIGNtZHFfY29kZSB7DQogCUNNRFFf
Q09ERV9KVU1QID0gMHgxMCwNCiAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQogCUNNRFFfQ09ERV9F
T0MgPSAweDQwLA0KKwlDTURRX0NPREVfUkVBRF9TID0gMHg4MCwNCiAJQ01EUV9DT0RFX1dSSVRF
X1MgPSAweDkwLA0KIAlDTURRX0NPREVfV1JJVEVfU19NQVNLID0gMHg5MSwNCiAJQ01EUV9DT0RF
X0xPR0lDID0gMHhhMCwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXgg
Y2E5Yzc1ZmQ4MTI1Li5jMDdiYWExNTM0Y2EgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oDQpAQCAtMTA0LDYgKzEwNCwxOSBAQCBpbnQgY21kcV9wa3Rfd3JpdGUoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsNCiBpbnQg
Y21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIAkJ
CXUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KIA0KKy8qDQorICogY21kcV9wa3Rf
cmVhZF9zKCkgLSBhcHBlbmQgcmVhZF9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQorICog
QHBrdDoJdGhlIENNRFEgcGFja2V0DQorICogQGhpZ2hfYWRkcl9yZWdfaWR4OglpbnRlcm5hbCBy
ZWdpc3RlciBJRCB3aGljaCBjb250YWlucyBoaWdoIGFkZHJlc3Mgb2YgcGENCisgKiBAYWRkcl9s
b3c6CWxvdyBhZGRyZXNzIG9mIHBhDQorICogQGFkZHI6CXRoZSBwaHlzaWNhbCBhZGRyZXNzIG9m
IHJlZ2lzdGVyIG9yIGRtYSB0byByZWFkDQorICogQHJlZ19pZHg6CXRoZSBDTURRIGludGVybmFs
IHJlZ2lzdGVyIElEIHRvIGNhY2hlIHJlYWQgZGF0YQ0KKyAqDQorICogUmV0dXJuOiAwIGZvciBz
dWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNtZHFf
cGt0X3JlYWRfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LCB1
MTYgYWRkcl9sb3csDQorCQkgICAgdTE2IHJlZ19pZHgpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0
X3dyaXRlX3MoKSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQog
ICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotLSANCjIuMTguMA0K


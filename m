Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58420838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NpgtF6Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCHKxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60581 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726298AbgCHKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:14 -0400
X-UUID: 25a511fc1dcf41e9844a0cd7d3517c7b-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CvTPJvmtqN1E8WLI9vWa00KK/YVMkDvmUTHUqyoLW4s=;
        b=NpgtF6MkxxZaCiiKjB3ctxCDiXFxd3UY6uHqHu3AjZfohsq3sjgVERXN4Id0rnI3Fv32MIQdoVzQBvjllNAJHMIwsYxxNGFKjzHYs8o6ruC3hTCWsw4EmFc5GhocrnE4UnxQPyeXFjW1Od9/J1U7Rq9DHHPT6Wpi3q/+uLdR6Kk=;
X-UUID: 25a511fc1dcf41e9844a0cd7d3517c7b-20200308
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1949027757; Sun, 08 Mar 2020 18:53:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:51:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:59 +0800
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
Subject: [PATCH v5 12/13] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Sun, 8 Mar 2020 18:52:54 +0800
Message-ID: <1583664775-19382-13-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E3435D08E6740123CC940912060538D8D2835AD76DD5089F1A698B1829C76E2E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAyICstDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDUgKysrLS0NCiBpbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgMyArLS0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oICAgIHwgNSArKystLQ0KIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQppbmRleCA3ZGFhYWJjMjZlYjEuLmEwNjViM2E0MTJjZiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNDg4LDcgKzQ4OCw3IEBAIHN0YXRpYyB2
b2lkIG10a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMp
DQogCWlmIChtdGtfY3J0Yy0+Y21kcV9jbGllbnQpIHsNCiAJCWNtZHFfaGFuZGxlID0gY21kcV9w
a3RfY3JlYXRlKG10a19jcnRjLT5jbWRxX2NsaWVudCwgUEFHRV9TSVpFKTsNCiAJCWNtZHFfcGt0
X2NsZWFyX2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQotCQljbWRx
X3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCisJCWNtZHFfcGt0
X3dmZShjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQsIGZhbHNlKTsNCiAJCW10a19j
cnRjX2RkcF9jb25maWcoY3J0YywgY21kcV9oYW5kbGUpOw0KIAkJY21kcV9wa3RfZmluYWxpemUo
Y21kcV9oYW5kbGUpOw0KIAkJY21kcV9wa3RfZmx1c2hfYXN5bmMoY21kcV9oYW5kbGUsIGRkcF9j
bWRxX2NiLCBjbWRxX2hhbmRsZSk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KaW5kZXggYmI1YmUyMGZjNzBhLi5lYzU2MzdkNDMyNTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0yOTYsMTUgKzI5NiwxNiBAQCBpbnQgY21kcV9wa3Rf
d3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4
LA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUpOw0KIA0KLWludCBj
bWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCitpbnQgY21kcV9w
a3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpDQogew0K
IAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisJdTMyIGNsZWFyX29w
dGlvbiA9IGNsZWFyID8gQ01EUV9XRkVfVVBEQVRFIDogMDsNCiANCiAJaWYgKGV2ZW50ID49IENN
RFFfTUFYX0VWRU5UKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQogCWluc3Qub3AgPSBDTURRX0NP
REVfV0ZFOw0KLQlpbnN0LnZhbHVlID0gQ01EUV9XRkVfT1BUSU9OOw0KKwlpbnN0LnZhbHVlID0g
Q01EUV9XRkVfT1BUSU9OIHwgY2xlYXJfb3B0aW9uOw0KIAlpbnN0LmV2ZW50ID0gZXZlbnQ7DQog
DQogCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQppbmRleCAzZjZiYzBkZmQ1ZGEuLjQyZDJh
MzBlNmE3MCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBA
IC0yNyw4ICsyNyw3IEBADQogICogYml0IDE2LTI3OiB1cGRhdGUgdmFsdWUNCiAgKiBiaXQgMzE6
IDEgLSB1cGRhdGUsIDAgLSBubyB1cGRhdGUNCiAgKi8NCi0jZGVmaW5lIENNRFFfV0ZFX09QVElP
TgkJCShDTURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9XQUlUIHwgXA0KLQkJCQkJQ01EUV9XRkVf
V0FJVF9WQUxVRSkNCisjZGVmaW5lIENNRFFfV0ZFX09QVElPTgkJCShDTURRX1dGRV9XQUlUIHwg
Q01EUV9XRkVfV0FJVF9WQUxVRSkNCiANCiAvKiogY21kcSBldmVudCBtYXhpbXVtICovDQogI2Rl
ZmluZSBDTURRX01BWF9FVkVOVAkJCTB4M2ZmDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCmluZGV4IDFhNmM1NmYzYmVjMS4uZDYzNzQ5NDQwNjk3IDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTE1MiwxMSArMTUyLDEyIEBAIGludCBjbWRxX3Br
dF93cml0ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19p
ZHgsDQogLyoqDQogICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29t
bWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0gKiBA
ZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gIndhaXQgYW5kIENMRUFSIg0KKyAqIEBl
dmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byB3YWl0DQorICogQGNsZWFyOgljbGVhciBl
dmVudCBvciBub3QgYWZ0ZXIgZXZlbnQgYXJyaXZlDQogICoNCiAgKiBSZXR1cm46IDAgZm9yIHN1
Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCiAgKi8NCi1pbnQgY21kcV9w
a3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KK2ludCBjbWRxX3BrdF93
ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQogDQogLyoq
DQogICogY21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVudCBjb21tYW5k
IHRvIHRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==


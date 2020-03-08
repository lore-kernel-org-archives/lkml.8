Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4534C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751A820838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VVcirgNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCHKxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbgCHKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:12 -0400
X-UUID: 71d8b507b23e45a8976468faff248270-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eLK55L0fZn7XN3zfsQBv7sALD9rbgqr0/O+Yq+Tslao=;
        b=VVcirgNUfStpi9lGzJLXdc+709Hgxgto8CCKOOrIyKH3NOG405gAeZR8v2FiZFNBOJIF6z+G3V+SfFfCeseIbRIhdTMLqMChECtikveduR7z9SzU+J71H/6ANcYcxI7RUnWFivw2tSZ/r9pETKXwlYNCC+rdEGyNhs+u1XHIGes=;
X-UUID: 71d8b507b23e45a8976468faff248270-20200308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1104674785; Sun, 08 Mar 2020 18:53:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:54:07 +0800
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
Subject: [PATCH v5 07/13] soc: mediatek: cmdq: add write_s function
Date:   Sun, 8 Mar 2020 18:52:49 +0800
Message-ID: <1583664775-19382-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0Kd2l0aCBs
YXJnZSBkbWEgYWNjZXNzIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KIGluY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgMiArKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmggICAgfCAyMCArKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwg
NTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KaW5kZXggMzMxNTNkMTdjOWQ5Li45MGYxZmYyYjRiMDAgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0xOCw2ICsxOCwxMCBAQCBzdHJ1
Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCiAJCXUzMiB2YWx1ZTsNCiAJCXUzMiBt
YXNrOw0KKwkJc3RydWN0IHsNCisJCQl1MTYgYXJnX2M7DQorCQkJdTE2IHNyY19yZWc7DQorCQl9
Ow0KIAl9Ow0KIAl1bmlvbiB7DQogCQl1MTYgb2Zmc2V0Ow0KQEAgLTI5LDcgKzMzLDcgQEAgc3Ry
dWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAkJc3RydWN0IHsNCiAJCQl1OCBzb3A6NTsNCiAJCQl1
OCBhcmdfY190OjE7DQotCQkJdTggYXJnX2JfdDoxOw0KKwkJCXU4IHNyY190OjE7DQogCQkJdTgg
ZHN0X3Q6MTsNCiAJCX07DQogCX07DQpAQCAtMjIyLDYgKzIyNiwzNCBAQCBpbnQgY21kcV9wa3Rf
d3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIH0NCiBFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X3dyaXRlX21hc2spOw0KIA0KK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkgICAgIHUxNiBh
ZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4LCB1MzIgbWFzaykNCit7DQorCXN0cnVjdCBjbWRxX2lu
c3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwlpbnQgZXJyOw0KKw0KKwlpZiAobWFzayAhPSBV
MzJfTUFYKSB7DQorCQlpbnN0Lm9wID0gQ01EUV9DT0RFX01BU0s7DQorCQlpbnN0Lm1hc2sgPSB+
bWFzazsNCisJCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorCQlp
ZiAoZXJyIDwgMCkNCisJCQlyZXR1cm4gZXJyOw0KKw0KKwkJaW5zdC5tYXNrID0gMDsNCisJCWlu
c3Qub3AgPSBDTURRX0NPREVfV1JJVEVfU19NQVNLOw0KKwl9IGVsc2Ugew0KKwkJaW5zdC5vcCA9
IENNRFFfQ09ERV9XUklURV9TOw0KKwl9DQorDQorCWluc3Quc3JjX3QgPSBDTURRX1JFR19UWVBF
Ow0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KKwlpbnN0Lm9mZnNldCA9IGFkZHJf
bG93Ow0KKwlpbnN0LnNyY19yZWcgPSBzcmNfcmVnX2lkeDsNCisNCisJcmV0dXJuIGNtZHFfcGt0
X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rf
d3JpdGVfcyk7DQorDQogaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IGV2ZW50KQ0KIHsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IDEyMWMzYmI2ZDNk
ZS4uOGVmODdlMWJkMDNiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KQEAgLTU5LDYgKzU5LDggQEAgZW51bSBjbWRxX2NvZGUgew0KIAlDTURRX0NPREVfSlVN
UCA9IDB4MTAsDQogCUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KIAlDTURRX0NPREVfRU9DID0gMHg0
MCwNCisJQ01EUV9DT0RFX1dSSVRFX1MgPSAweDkwLA0KKwlDTURRX0NPREVfV1JJVEVfU19NQVNL
ID0gMHg5MSwNCiAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCiB9Ow0KIA0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCA4MzM0MDIxMWUxZDMuLmM3MmQ4MjZkODkzNCAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMiw2ICsxMiw4IEBA
DQogI2luY2x1ZGUgPGxpbnV4L3RpbWVyLmg+DQogDQogI2RlZmluZSBDTURRX05PX1RJTUVPVVQJ
CTB4ZmZmZmZmZmZ1DQorI2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRy
KSA+PiAxNikgJiBHRU5NQVNLKDMxLCAwKSkpDQorI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIp
CSgodTE2KShhZGRyKSB8IEJJVCgxKSkNCiANCiBzdHJ1Y3QgY21kcV9wa3Q7DQogDQpAQCAtMTAy
LDYgKzEwNCwyNCBAQCBpbnQgY21kcV9wa3Rfd3JpdGUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4
IHN1YnN5cywgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsNCiBpbnQgY21kcV9wa3Rfd3JpdGVfbWFz
ayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIAkJCXUxNiBvZmZzZXQsIHUzMiB2
YWx1ZSwgdTMyIG1hc2spOw0KIA0KKy8qKg0KKyAqIGNtZHFfcGt0X3dyaXRlX3MoKSAtIGFwcGVu
ZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQorICogQHBrdDoJdGhlIENNRFEg
cGFja2V0DQorICogQGhpZ2hfYWRkcl9yZWdfaWR4OglpbnRlcm5hbCByZWdpc2dlciBJRCB3aGlj
aCBjb250YWlucyBoaWdoIGFkZHJlc3Mgb2YgcGENCisgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNz
IG9mIHBhDQorICogQHNyY19yZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRCB3
aGljaCBjYWNoZSBzb3VyY2UgdmFsdWUNCisgKiBAbWFzazoJdGhlIHNwZWNpZmllZCB0YXJnZXQg
YWRkcmVzcyBtYXNrLCB1c2UgVTMyX01BWCBpZiBubyBuZWVkDQorICoNCisgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKg0KKyAqIFN1
cHBvcnQgd3JpdGUgdmFsdWUgdG8gcGh5c2ljYWwgYWRkcmVzcyB3aXRob3V0IHN1YnN5cy4gVXNl
IENNRFFfQUREUl9ISUdIKCkNCisgKiB0byBnZXQgaGlnaCBhZGRyZWVzIGFuZCBjYWxsIGNtZHFf
cGt0X2Fzc2lnbigpIHRvIGFzc2lnbiB2YWx1ZSBpbnRvIGludGVybmFsDQorICogcmVnLiBBbHNv
IHVzZSBDTURRX0FERFJfTE9XKCkgdG8gZ2V0IGxvdyBhZGRyZXNzIGZvciBhZGRyX2xvdyBwYXJh
bWV0ZXJ3aGVuDQorICogY2FsbCB0byB0aGlzIGZ1bmN0aW9uLg0KKyAqLw0KK2ludCBjbWRxX3Br
dF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQor
CQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4LCB1MzIgbWFzayk7DQorDQogLyoq
DQogICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0
aGUgQ01EUSBwYWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0tIA0KMi4xOC4wDQo=


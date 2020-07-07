Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA96C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3994120578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C/eo/y+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgGGPqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:46:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52321 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728495AbgGGPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:32 -0400
X-UUID: 0be132844e2548488f17290144977874-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3FlNZdINnBEnXf9Fz8xF8oCrmMoDe3gvspWZzkBEGQA=;
        b=C/eo/y+PsTiY4BgfYyh8k8uvIQ3ChsYSXkgyXz1GtaEwiRRa95wiTUDNVh4w8hDliNPBOoqgHARHCb+zBwkZKAzBNx8AAQGa+QTffEF7ZFqe1v7aZowtIJnA3tRzRyh0ahUHEHWCHk1McqbndVClPq6TE5qkf4nj21k76q9h2zs=;
X-UUID: 0be132844e2548488f17290144977874-20200707
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 400272969; Tue, 07 Jul 2020 23:46:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 23:46:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 23:46:25 +0800
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
Subject: [PATCH v3 8/9] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Tue, 7 Jul 2020 23:45:13 +0800
Message-ID: <1594136714-11650-9-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNCkNoYW5nZSBzaW5jZSB2MjoN
Ci0gS2VlcCBiZWhhdmlvciBpbiBkcm0gY3J0YyBkcml2ZXIgYW5kDQogIHNlcGFyYXRlIGJ1ZyBm
aXggY29kZSBpbnRvIGFub3RoZXIgcGF0Y2guDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBI
c2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAgICAyICstDQogZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8ICAgIDUgKysrLS0NCiBpbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMyArLS0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oICAgIHwgICAgNSArKystLQ0KIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQppbmRleCBlYzZjOWZmYmYzNWUuLmM4NGU3YTE0ZDRhOCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNDkwLDcgKzQ5MCw3IEBAIHN0YXRp
YyB2b2lkIG10a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2Ny
dGMpDQogCQltYm94X2ZsdXNoKG10a19jcnRjLT5jbWRxX2NsaWVudC0+Y2hhbiwgMjAwMCk7DQog
CQljbWRxX2hhbmRsZSA9IGNtZHFfcGt0X2NyZWF0ZShtdGtfY3J0Yy0+Y21kcV9jbGllbnQsIFBB
R0VfU0laRSk7DQogCQljbWRxX3BrdF9jbGVhcl9ldmVudChjbWRxX2hhbmRsZSwgbXRrX2NydGMt
PmNtZHFfZXZlbnQpOw0KLQkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21k
cV9ldmVudCk7DQorCQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2
ZW50LCB0cnVlKTsNCiAJCW10a19jcnRjX2RkcF9jb25maWcoY3J0YywgY21kcV9oYW5kbGUpOw0K
IAkJY21kcV9wa3RfZmluYWxpemUoY21kcV9oYW5kbGUpOw0KIAkJY21kcV9wa3RfZmx1c2hfYXN5
bmMoY21kcV9oYW5kbGUsIGRkcF9jbWRxX2NiLCBjbWRxX2hhbmRsZSk7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggZDU1ZGMzMjk2MTA1Li41MDU2NTFiMGQ3MTUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysr
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0zMTYsMTUgKzMx
NiwxNiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1OCBoaWdoX2FkZHJfcmVnX2lkeCwNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93
cml0ZV9zX21hc2tfdmFsdWUpOw0KIA0KLWludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBldmVudCkNCitpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpDQogew0KIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBp
bnN0ID0geyB7MH0gfTsNCisJdTMyIGNsZWFyX29wdGlvbiA9IGNsZWFyID8gQ01EUV9XRkVfVVBE
QVRFIDogMDsNCiANCiAJaWYgKGV2ZW50ID49IENNRFFfTUFYX0VWRU5UKQ0KIAkJcmV0dXJuIC1F
SU5WQUw7DQogDQogCWluc3Qub3AgPSBDTURRX0NPREVfV0ZFOw0KLQlpbnN0LnZhbHVlID0gQ01E
UV9XRkVfT1BUSU9OOw0KKwlpbnN0LnZhbHVlID0gQ01EUV9XRkVfT1BUSU9OIHwgY2xlYXJfb3B0
aW9uOw0KIAlpbnN0LmV2ZW50ID0gZXZlbnQ7DQogDQogCXJldHVybiBjbWRxX3BrdF9hcHBlbmRf
Y29tbWFuZChwa3QsIGluc3QpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oDQppbmRleCBlZmJkOGE5ZWIyZDEuLmQ1YTk4M2Q2NWYwNSAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2luY2x1ZGUvbGludXgv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC0yOCw4ICsyOCw3IEBADQogICogYml0IDE2
LTI3OiB1cGRhdGUgdmFsdWUNCiAgKiBiaXQgMzE6IDEgLSB1cGRhdGUsIDAgLSBubyB1cGRhdGUN
CiAgKi8NCi0jZGVmaW5lIENNRFFfV0ZFX09QVElPTgkJCShDTURRX1dGRV9VUERBVEUgfCBDTURR
X1dGRV9XQUlUIHwgXA0KLQkJCQkJQ01EUV9XRkVfV0FJVF9WQUxVRSkNCisjZGVmaW5lIENNRFFf
V0ZFX09QVElPTgkJCShDTURRX1dGRV9XQUlUIHwgQ01EUV9XRkVfV0FJVF9WQUxVRSkNCiANCiAv
KiogY21kcSBldmVudCBtYXhpbXVtICovDQogI2RlZmluZSBDTURRX01BWF9FVkVOVAkJCTB4M2Zm
DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDM0MzU0ZTk1MmY2MC4u
OTYwNzA0ZDc1OTk0IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAg
LTE4MiwxMSArMTgyLDEyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zX21hc2tfdmFsdWUoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KIC8qKg0KICAqIGNtZHFfcGt0
X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0
DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVu
dCB0eXBlIHRvICJ3YWl0IGFuZCBDTEVBUiINCisgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50
IHR5cGUgdG8gd2FpdA0KKyAqIEBjbGVhcjoJY2xlYXIgZXZlbnQgb3Igbm90IGFmdGVyIGV2ZW50
IGFycml2ZQ0KICAqDQogICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBj
b2RlIGlzIHJldHVybmVkDQogICovDQotaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTE2IGV2ZW50KTsNCitpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpOw0KIA0KIC8qKg0KICAqIGNtZHFfcGt0X2NsZWFyX2V2
ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCi0t
IA0KMS43LjkuNQ0K


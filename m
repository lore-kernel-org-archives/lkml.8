Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE3BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DCB2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f3XIaZMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgFVPkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:40:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15414 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729092AbgFVPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:40:05 -0400
X-UUID: a34d21fcf9f848ef86d638147d7f39eb-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4oG//lsr7WdU0sHSnJkzG35AGLgyMUzysVPRVO5h3hw=;
        b=f3XIaZMmkgBYWROQTozQj3+ZVsPfU/Yg5qS8MN672i/M4VXosArM/LwD6peLJNWuIODscHcjy+zMy+WmZcwtKE2WMEFZ/b0b0qc2LIYfkbLeV4hu/mrjuOjZbbb5sfjSBPsXvTEKiBeY6WzAT6am6AP6ZVJS816FYtVwUEWQ3Bw=;
X-UUID: a34d21fcf9f848ef86d638147d7f39eb-20200622
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 374711574; Mon, 22 Jun 2020 23:40:00 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 23:39:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 23:39:55 +0800
Message-ID: <1592840399.1307.15.camel@mtkswgap22>
Subject: Re: [PATCH v1 10/11] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 22 Jun 2020 23:39:59 +0800
In-Reply-To: <8b469701-2295-2cb5-1b60-8681322db678@gmail.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592749115-24158-11-git-send-email-dennis-yc.hsieh@mediatek.com>
         <8b469701-2295-2cb5-1b60-8681322db678@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCnRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBNb24sIDIwMjAt
MDYtMjIgYXQgMTM6MTkgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAy
MS8wNi8yMDIwIDE2OjE4LCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4gQWRkIGNsZWFyIHBh
cmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KPiA+IGV2ZW50IHNob3VsZCBiZSBjbGVh
ciB0byAwIGFmdGVyIEdDRSByZWNlaXZlIGl0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8ICAgIDIgKy0NCj4gPiAgZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8ICAgIDUgKysrLS0NCj4gPiAgaW5jbHVk
ZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAgIDMgKy0tDQo+ID4gIGluY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAgICA1ICsrKy0tDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBpbmRleCA3ZGFhYWJj
MjZlYjEuLmEwNjViM2E0MTJjZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9jcnRjLmMNCj4gPiBAQCAtNDg4LDcgKzQ4OCw3IEBAIHN0YXRpYyB2b2lkIG10a19k
cm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ID4gIAlp
ZiAobXRrX2NydGMtPmNtZHFfY2xpZW50KSB7DQo+ID4gIAkJY21kcV9oYW5kbGUgPSBjbWRxX3Br
dF9jcmVhdGUobXRrX2NydGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KPiA+ICAJCWNtZHFf
cGt0X2NsZWFyX2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4g
LQkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4g
KwkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgZmFsc2Up
Ow0KPiANCj4gVGhpcyBkb2VzIG5vdCBzZXQgQ01EUV9XRkVfVVBEQVRFIHdoaWxlIHRoZSBvbGQg
Y29kZSBkaWQuIElzIHRoaXMgYSBidWcgZml4IG9yIGENCj4gYnVnIGluIHRoZSBjb2RlPw0KPiBJ
ZiBpdCdzIGEgZml4LCBwbGVhc2UgcHJvdmlkZSBhIGZpeGVzIHRhZy4NCg0Kbm8gbmVlZCB0byB0
byB1cGRhdGUgYWdhaW4gc2luY2UgZXZlbnQgYWx3YXlzIGNsZWFyIGJlZm9yZSB3YWl0Lg0KSSds
bCBwcm92aWRlIGEgZml4IHRhZywgdGhhbmtzLg0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiAN
Cj4gVGhhbmtzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiAgCQltdGtfY3J0Y19kZHBfY29uZmlnKGNy
dGMsIGNtZHFfaGFuZGxlKTsNCj4gPiAgCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7
DQo+ID4gIAkJY21kcV9wa3RfZmx1c2hfYXN5bmMoY21kcV9oYW5kbGUsIGRkcF9jbWRxX2NiLCBj
bWRxX2hhbmRsZSk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4g
PiBpbmRleCAwMDlmODZhZTcyYzYuLjEzZjc4YzliNTkwMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTMxNSwxNSArMzE1LDE2IEBAIGlu
dCBjbWRxX3BrdF93cml0ZV9zX21hc2tfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhp
Z2hfYWRkcl9yZWdfaWR4LA0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3Jp
dGVfc19tYXNrX3ZhbHVlKTsNCj4gPiAgDQo+ID4gLWludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiAraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTE2IGV2ZW50LCBib29sIGNsZWFyKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiArCXUzMiBjbGVhcl9vcHRpb24g
PSBjbGVhciA/IENNRFFfV0ZFX1VQREFURSA6IDA7DQo+ID4gIA0KPiA+ICAJaWYgKGV2ZW50ID49
IENNRFFfTUFYX0VWRU5UKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICANCj4gPiAgCWlu
c3Qub3AgPSBDTURRX0NPREVfV0ZFOw0KPiA+IC0JaW5zdC52YWx1ZSA9IENNRFFfV0ZFX09QVElP
TjsNCj4gPiArCWluc3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT04gfCBjbGVhcl9vcHRpb247DQo+
ID4gIAlpbnN0LmV2ZW50ID0gZXZlbnQ7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIGNtZHFfcGt0X2Fw
cGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oDQo+ID4gaW5kZXggM2Y2YmMwZGZkNWRhLi40MmQyYTMwZTZhNzAgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBAQCAt
MjcsOCArMjcsNyBAQA0KPiA+ICAgKiBiaXQgMTYtMjc6IHVwZGF0ZSB2YWx1ZQ0KPiA+ICAgKiBi
aXQgMzE6IDEgLSB1cGRhdGUsIDAgLSBubyB1cGRhdGUNCj4gPiAgICovDQo+ID4gLSNkZWZpbmUg
Q01EUV9XRkVfT1BUSU9OCQkJKENNRFFfV0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBcDQo+
ID4gLQkJCQkJQ01EUV9XRkVfV0FJVF9WQUxVRSkNCj4gPiArI2RlZmluZSBDTURRX1dGRV9PUFRJ
T04JCQkoQ01EUV9XRkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQo+ID4gIA0KPiA+ICAv
KiogY21kcSBldmVudCBtYXhpbXVtICovDQo+ID4gICNkZWZpbmUgQ01EUV9NQVhfRVZFTlQJCQkw
eDNmZg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IDE4
MzY0ZDgxZThmNy4uNGI1ZjVkMTU0YmFkIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTE4MiwxMSArMTgyLDEyIEBAIGludCBjbWRxX3BrdF93
cml0ZV9zX21hc2tfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdf
aWR4LA0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3Ig
ZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhlIENNRFEg
cGFja2V0DQo+ID4gLSAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byAid2FpdCBh
bmQgQ0xFQVIiDQo+ID4gKyAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byB3YWl0
DQo+ID4gKyAqIEBjbGVhcjoJY2xlYXIgZXZlbnQgb3Igbm90IGFmdGVyIGV2ZW50IGFycml2ZQ0K
PiA+ICAgKg0KPiA+ICAgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNv
ZGUgaXMgcmV0dXJuZWQNCj4gPiAgICovDQo+ID4gLWludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQo+ID4gK2ludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQo+ID4gIA0KPiA+ICAvKioNCj4g
PiAgICogY21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVudCBjb21tYW5k
IHRvIHRoZSBDTURRIHBhY2tldA0KPiA+IA0KDQo=


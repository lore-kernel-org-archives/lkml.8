Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB41EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA41206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pkgM4Awg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGGAqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:46:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51162 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgGGAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:46:45 -0400
X-UUID: e40676f9293240e6a31db48b3fdd0b16-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9+BgWtK/CBgwcVCXkyOr08QW0zYWgf+PY9UfH+ilC/c=;
        b=pkgM4AwgulucaxKgow4xvjadIqp24Lynb/33XkSbzV8yEmSqxxSRSSttDwK2otU0YGxNWGJrvQgowRL23aNBjwzo2UczvnLhXBEvx+93xXsqvqSH5eyss72owU4KTBkrzX521pzBWGEp4QwGeK+4TyDuvWtFj9rG8MuuEBRKa7Q=;
X-UUID: e40676f9293240e6a31db48b3fdd0b16-20200707
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 455299607; Tue, 07 Jul 2020 08:46:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 08:46:39 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 08:46:39 +0800
Message-ID: <1594082800.24876.0.camel@mtkswgap22>
Subject: Re: [PATCH v2 8/8] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        HS Liao <hs.liao@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 7 Jul 2020 08:46:40 +0800
In-Reply-To: <CAAOTY_-5um+X=cS3rkuN7YHycK2AyJsovumCQ4t+dbwXw62uAQ@mail.gmail.com>
References: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1593931715-32761-9-git-send-email-dennis-yc.hsieh@mediatek.com>
         <CAAOTY_-5um+X=cS3rkuN7YHycK2AyJsovumCQ4t+dbwXw62uAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBUdWUsIDIwMjAtMDctMDcg
YXQgMDc6NDYgKzA4MDAsIENodW4tS3VhbmcgSHUgd3JvdGU6DQo+IEhpLCBEZW5uaXM6DQo+IA0K
PiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+IOaWvCAyMDIw
5bm0N+aciDbml6Ug6YCx5LiAIOS4i+WNiDM6MjDlr6vpgZPvvJoNCj4gPg0KPiA+IEFkZCBjbGVh
ciBwYXJhbWV0ZXIgdG8gbGV0IGNsaWVudCBkZWNpZGUgaWYNCj4gPiBldmVudCBzaG91bGQgYmUg
Y2xlYXIgdG8gMCBhZnRlciBHQ0UgcmVjZWl2ZSBpdC4NCj4gPg0KPiA+IEZpeGVzOiAyZjk2NWJl
N2Y5MDA4ICgiZHJtL21lZGlhdGVrOiBhcHBseSBDTURRIGNvbnRyb2wgZmxvdyIpDQo+IA0KPiBJ
IHRoaW5rIHRoaXMgcGF0Y2ggaW5jbHVkZSB0d28gdGhpbmdzLCBvbmUgaXMgYnVnIGZpeCwgYW5v
dGhlciBpcw0KPiBjaGFuZ2luZyBpbnRlcmZhY2UuDQo+IGJlbG93IGlzIHRoZSBidWcgZml4IHBh
cnQuDQo+IA0KPiAtI2RlZmluZSBDTURRX1dGRV9PUFRJT04gICAgICAgICAgICAgICAgICAgICAg
ICAoQ01EUV9XRkVfVVBEQVRFIHwNCj4gQ01EUV9XRkVfV0FJVCB8IFwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENNRFFfV0ZFX1dBSVRfVkFMVUUpDQo+ICsjZGVm
aW5lIENNRFFfV0ZFX09QVElPTiAgICAgICAgICAgICAgICAgICAgICAgIChDTURRX1dGRV9XQUlU
IHwNCj4gQ01EUV9XRkVfV0FJVF9WQUxVRSkNCj4gDQo+IHRoZSBvdGhlciBpcyBjaGFuZ2luZyBp
bnRlcmZhY2UgcGFydC4gU28gdGhpcyBwYXRjaCBzaG91bGQgYmUgYnJva2VuDQo+IGludG8gdHdv
IHBhdGNoZXMuDQoNCm9rIEknbGwgYnJlYWsgaW50byB0d28gcGF0Y2hlcw0KDQoNClJlZ2FyZHMs
DQpEZW5uaXMNCg0KPiANCj4gUmVnYXJkcywNCj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwgICAgMiArLQ0KPiA+
ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgICAgNSArKystLQ0K
PiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMyArLS0N
Cj4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgIDUgKysr
LS0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5k
ZXggZWM2YzlmZmJmMzVlLi5iYTZjZjk1NmIyMzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gQEAgLTQ5MCw3ICs0OTAsNyBAQCBzdGF0aWMg
dm9pZCBtdGtfZHJtX2NydGNfaHdfY29uZmlnKHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRj
KQ0KPiA+ICAgICAgICAgICAgICAgICBtYm94X2ZsdXNoKG10a19jcnRjLT5jbWRxX2NsaWVudC0+
Y2hhbiwgMjAwMCk7DQo+ID4gICAgICAgICAgICAgICAgIGNtZHFfaGFuZGxlID0gY21kcV9wa3Rf
Y3JlYXRlKG10a19jcnRjLT5jbWRxX2NsaWVudCwgUEFHRV9TSVpFKTsNCj4gPiAgICAgICAgICAg
ICAgICAgY21kcV9wa3RfY2xlYXJfZXZlbnQoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2
ZW50KTsNCj4gPiAtICAgICAgICAgICAgICAgY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtf
Y3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4gKyAgICAgICAgICAgICAgIGNtZHFfcGt0X3dmZShjbWRx
X2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQsIGZhbHNlKTsNCj4gPiAgICAgICAgICAgICAg
ICAgbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBjbWRxX2hhbmRsZSk7DQo+ID4gICAgICAgICAg
ICAgICAgIGNtZHFfcGt0X2ZpbmFsaXplKGNtZHFfaGFuZGxlKTsNCj4gPiAgICAgICAgICAgICAg
ICAgY21kcV9wa3RfZmx1c2hfYXN5bmMoY21kcV9oYW5kbGUsIGRkcF9jbWRxX2NiLCBjbWRxX2hh
bmRsZSk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRl
eCBkNTVkYzMyOTYxMDUuLjUwNTY1MWIwZDcxNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTMxNiwxNSArMzE2LDE2IEBAIGludCBjbWRx
X3BrdF93cml0ZV9zX21hc2tfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRk
cl9yZWdfaWR4LA0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc19t
YXNrX3ZhbHVlKTsNCj4gPg0KPiA+IC1pbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgZXZlbnQpDQo+ID4gK2ludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IGNt
ZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gKyAgICAgICB1MzIgY2xlYXJfb3B0
aW9uID0gY2xlYXIgPyBDTURRX1dGRV9VUERBVEUgOiAwOw0KPiA+DQo+ID4gICAgICAgICBpZiAo
ZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiA+DQo+ID4gICAgICAgICBpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCj4gPiAtICAg
ICAgIGluc3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT047DQo+ID4gKyAgICAgICBpbnN0LnZhbHVl
ID0gQ01EUV9XRkVfT1BUSU9OIHwgY2xlYXJfb3B0aW9uOw0KPiA+ICAgICAgICAgaW5zdC5ldmVu
dCA9IGV2ZW50Ow0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1h
bmQocGt0LCBpbnN0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210
ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmgNCj4gPiBpbmRleCBlZmJkOGE5ZWIyZDEuLmQ1YTk4M2Q2NWYwNSAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC0yOCw4ICsyOCw3
IEBADQo+ID4gICAqIGJpdCAxNi0yNzogdXBkYXRlIHZhbHVlDQo+ID4gICAqIGJpdCAzMTogMSAt
IHVwZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KPiA+ICAgKi8NCj4gPiAtI2RlZmluZSBDTURRX1dGRV9P
UFRJT04gICAgICAgICAgICAgICAgICAgICAgICAoQ01EUV9XRkVfVVBEQVRFIHwgQ01EUV9XRkVf
V0FJVCB8IFwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ01E
UV9XRkVfV0FJVF9WQUxVRSkNCj4gPiArI2RlZmluZSBDTURRX1dGRV9PUFRJT04gICAgICAgICAg
ICAgICAgICAgICAgICAoQ01EUV9XRkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQo+ID4N
Cj4gPiAgLyoqIGNtZHEgZXZlbnQgbWF4aW11bSAqLw0KPiA+ICAjZGVmaW5lIENNRFFfTUFYX0VW
RU5UICAgICAgICAgICAgICAgICAweDNmZg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiA+IGluZGV4IDM0MzU0ZTk1MmY2MC4uOTYwNzA0ZDc1OTk0IDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTE4MiwxMSArMTgy
LDEyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zX21hc2tfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3Rfd2Zl
KCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4g
PiAgICogQHBrdDogICAgICAgdGhlIENNRFEgcGFja2V0DQo+ID4gLSAqIEBldmVudDogICAgIHRo
ZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gIndhaXQgYW5kIENMRUFSIg0KPiA+ICsgKiBAZXZlbnQ6
ICAgICB0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvIHdhaXQNCj4gPiArICogQGNsZWFyOiAgICAg
Y2xlYXIgZXZlbnQgb3Igbm90IGFmdGVyIGV2ZW50IGFycml2ZQ0KPiA+ICAgKg0KPiA+ICAgKiBS
ZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4g
PiAgICovDQo+ID4gLWludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBl
dmVudCk7DQo+ID4gK2ludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBl
dmVudCwgYm9vbCBjbGVhcik7DQo+ID4NCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X2NsZWFy
X2V2ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQN
Cj4gPiAtLQ0KPiA+IDEuNy45LjUNCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiA+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
X187ISFDVFJOS0E5d01nMEFSYnchd24wS1BpWWFHSnhmWjNPczJMZWF2dXZCWHRoM0hVZWpuMXNO
aGk4X1duVmdSX2pUeWZtTGdvX2tCYkdIcFRGMFVxb0RRUSQgDQoNCg==


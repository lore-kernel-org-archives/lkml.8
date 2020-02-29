Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8823C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7312469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CAa8qCMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgB2Ohq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 09:37:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:64607 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbgB2Ohp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:37:45 -0500
X-UUID: 89f67a14a8264cb58726f652872fb23f-20200229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xQp3WRgKEp5tZlL+HV4rSlO/znTkeJUSxq/TzrB4xVA=;
        b=CAa8qCMDc3E2m//OdnZWoBS1Dr0/VgXjUghrflPtNw/6kAfYc/iMb7t0rJmvhBovX2/4ujKNzGqVCjhZDhLhjj5WKnBneve6DDbWI5K2jygoJwfH2xvMpFqpPPYKUUoz42cGqMLA2+ahns1Oci7KQYJs08ObiD9SFN93WOrMKXM=;
X-UUID: 89f67a14a8264cb58726f652872fb23f-20200229
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2070284286; Sat, 29 Feb 2020 22:37:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Feb 2020 22:36:38 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Feb 2020 22:37:14 +0800
Message-ID: <1582987056.13875.0.camel@mtkswgap22>
Subject: Re: [PATCH v3 12/13] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Sat, 29 Feb 2020 22:37:36 +0800
In-Reply-To: <1582900369.14824.2.camel@mtksdaap41>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-14-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582900369.14824.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91IGNvbW1lbnQuDQoNCk9uIEZyaSwgMjAyMC0wMi0yOCBh
dCAyMjozMiArMDgwMCwgQ0sgSHUgd3JvdGU6DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBGcmks
IDIwMjAtMDItMjggYXQgMjE6NDQgKzA4MDAsIERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBB
ZGQgY2xlYXIgcGFyYW1ldGVyIHRvIGxldCBjbGllbnQgZGVjaWRlIGlmDQo+ID4gZXZlbnQgc2hv
dWxkIGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwg
NSArKystLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwg
MyArLS0NCj4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDUg
KysrLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBp
bmRleCBiYmM2OGE3YzgxZTkuLjQwNmUxZDM0ZDIzNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTI5NSwxNSArMjk1LDE2IEBAIGludCBj
bWRxX3BrdF93cml0ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRy
X3JlZ19pZHgsDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3Zh
bHVlKTsNCj4gPiAgDQo+ID4gLWludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiBldmVudCkNCj4gPiAraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IGV2ZW50LCBib29sIGNsZWFyKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVj
dGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiArCXUzMiBjbGVhcl9vcHRpb24gPSBjbGVhciA/IENN
RFFfV0ZFX1VQREFURSA6IDA7DQo+ID4gIA0KPiA+ICAJaWYgKGV2ZW50ID49IENNRFFfTUFYX0VW
RU5UKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICANCj4gPiAgCWluc3Qub3AgPSBDTURR
X0NPREVfV0ZFOw0KPiA+IC0JaW5zdC52YWx1ZSA9IENNRFFfV0ZFX09QVElPTjsNCj4gPiArCWlu
c3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT04gfCBjbGVhcl9vcHRpb247DQo+ID4gIAlpbnN0LmV2
ZW50ID0gZXZlbnQ7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5k
KHBrdCwgaW5zdCk7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5o
DQo+ID4gaW5kZXggM2Y2YmMwZGZkNWRhLi40MmQyYTMwZTZhNzAgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBAQCAtMjcsOCArMjcsNyBA
QA0KPiA+ICAgKiBiaXQgMTYtMjc6IHVwZGF0ZSB2YWx1ZQ0KPiA+ICAgKiBiaXQgMzE6IDEgLSB1
cGRhdGUsIDAgLSBubyB1cGRhdGUNCj4gPiAgICovDQo+ID4gLSNkZWZpbmUgQ01EUV9XRkVfT1BU
SU9OCQkJKENNRFFfV0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBcDQo+ID4gLQkJCQkJQ01E
UV9XRkVfV0FJVF9WQUxVRSkNCj4gPiArI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9X
RkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQo+ID4gIA0KPiA+ICAvKiogY21kcSBldmVu
dCBtYXhpbXVtICovDQo+ID4gICNkZWZpbmUgQ01EUV9NQVhfRVZFTlQJCQkweDNmZg0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IDFhNmM1NmYzYmVjMS4u
ZDYzNzQ5NDQwNjk3IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oDQo+ID4gQEAgLTE1MiwxMSArMTUyLDEyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zX3ZhbHVl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4gIC8qKg0K
PiA+ICAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRv
IHRoZSBDTURRIHBhY2tldA0KPiA+ICAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPiAtICog
QGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvICJ3YWl0IGFuZCBDTEVBUiINCj4gPiAr
ICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvIHdhaXQNCj4gPiArICogQGNsZWFy
OgljbGVhciBldmVudCBvciBub3QgYWZ0ZXIgZXZlbnQgYXJyaXZlDQo+ID4gICAqDQo+ID4gICAq
IFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0K
PiA+ICAgKi8NCj4gPiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IGV2ZW50KTsNCj4gPiAraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IGV2ZW50LCBib29sIGNsZWFyKTsNCj4gDQo+IEkgdGhpbmsgeW91IHNob3VsZCBtb2RpZnkgY2xp
ZW50IGRyaXZlciBbMV0gYXMgd2VsbCBpbiB0aGlzIHBhdGNoLg0KPiBDaGFuZ2UgaXQgdG8NCj4g
DQo+IGNtZHFfcGt0X3dmZShjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQsIGZhbHNl
KTsNCj4gDQo+IFsxXQ0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9jcnRjLmM/aD12NS42LXJjMyNuNDkxDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KDQpv
aywgd2lsbCBkbw0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KDQo+IA0KPiA+ICANCj4gPiAgLyoq
DQo+ID4gICAqIGNtZHFfcGt0X2NsZWFyX2V2ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZlbnQgY29t
bWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gDQo+IA0KDQo=


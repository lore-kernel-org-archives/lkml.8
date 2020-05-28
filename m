Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C83E206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NIxGHYFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbgE1Meo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:34:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5246 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389714AbgE1Men (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:34:43 -0400
X-UUID: b24a7ef77cc749cf851ff1f7787f76e6-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fKh8D1t1OVVDs+JciXz04pHTnlmXfwWrSIaEhxD3uRw=;
        b=NIxGHYFiAtOrGoQ5o/iCDyaJM2YBrgk0eKcLj93wLgE22VWHlXo4XH1JpJ9S3YfMbjIOLD/7a2haAeVyet8hIv5ZdD+k8MffBvOx8MwfcuIDKT8gOTpq7yt84rBbWA2MNvi6J18iKIQBVsiKPQVporFKnythSF3LJa2Xm2o0Yao=;
X-UUID: b24a7ef77cc749cf851ff1f7787f76e6-20200528
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 165048045; Thu, 28 May 2020 20:34:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 20:34:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 20:34:33 +0800
Message-ID: <1590669276.4266.8.camel@mtkswgap22>
Subject: Re: [PATCH v5 4/6] pinctrl: mediatek: add pinctrl support for
 MT6779 SoC
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Andy Teng <andy.teng@mediatek.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Date:   Thu, 28 May 2020 20:34:36 +0800
In-Reply-To: <CAGp9Lzrci=qhU6QXPfGg=-dGtKNq1Xn-rhYWvPp-8Wj6v6oJwA@mail.gmail.com>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
         <1585128694-13881-5-git-send-email-hanks.chen@mediatek.com>
         <CAGp9Lzrci=qhU6QXPfGg=-dGtKNq1Xn-rhYWvPp-8Wj6v6oJwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTAyIGF0IDE0OjQ2IC0wNzAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+IEhp
IEhhbmtzLA0KPiANCj4gT24gV2VkLCBNYXIgMjUsIDIwMjAgYXQgMjozMSBBTSBIYW5rcyBDaGVu
IDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIGFkZHMgTVQ2
Nzc5IHBpbmN0cmwgZHJpdmVyIGJhc2VkIG9uIE1lZGlhVGVrIHBpbmN0cmwtcGFyaXMgY29yZS4N
Cj4gPg0KPiANCj4gV2UgY2FuIGFkZCBzb21lIHVzZWZ1bCBoZWxwIHRleHQgYWJvdXQgTVQ2Nzc5
IHBpbmN0cmwsIGVzcGVjaWFsbHkNCj4gYWJvdXQgc3BlY2lmaWMgcGFydHMgbGlrZSB2aXJ0dWFs
IGdwaW8gYW5kIGl0cyBhdHRyaWJ1dGVzDQo+IFRoZW4gQWNrZWQtYnk6IFNlYW4gV2FuZyA8c2Vh
bi53YW5nQGtlcm5lbC5vcmc+DQo+IA0KR290IGl0LCBJJ2xsIGFkZCBpdCBpbiBuZXh0IHZlcnNp
b24uDQpUaGFua3MgZm9yIHRoZSBhZHZpY2VzLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFua3Mg
Q2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFycyBD
aGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5keSBU
ZW5nIDxhbmR5LnRlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgfCAgICA3ICsNCj4gPiAgZHJpdmVycy9w
aW5jdHJsL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIGRyaXZl
cnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10Njc3OS5jICAgICB8ICA3NzUgKysrKysrKysr
DQo+ID4gIGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1tdDY3NzkuaCB8IDIw
ODUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDI4Njgg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL3BpbmN0cmwtbXQ2Nzc5LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1tdDY3NzkuaA0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9LY29uZmlnIGIvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL0tjb25maWcNCj4gPiBpbmRleCA3MDFmOWFmLi5mNjI4ZDAxIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9w
aW5jdHJsL21lZGlhdGVrL0tjb25maWcNCj4gPiBAQCAtODYsNiArODYsMTMgQEAgY29uZmlnIFBJ
TkNUUkxfTVQ2NzY1DQo+ID4gICAgICAgICBkZWZhdWx0IEFSTTY0ICYmIEFSQ0hfTUVESUFURUsN
Cj4gPiAgICAgICAgIHNlbGVjdCBQSU5DVFJMX01US19QQVJJUw0KPiA+DQo+ID4gK2NvbmZpZyBQ
SU5DVFJMX01UNjc3OQ0KPiA+ICsgICAgICAgYm9vbCAiTWVkaWF0ZWsgTVQ2Nzc5IHBpbiBjb250
cm9sIg0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBPRg0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBB
Uk02NCB8fCBDT01QSUxFX1RFU1QNCj4gPiArICAgICAgIGRlZmF1bHQgQVJNNjQgJiYgQVJDSF9N
RURJQVRFSw0KPiA+ICsgICAgICAgc2VsZWN0IFBJTkNUUkxfTVRLX1BBUklTDQo+ID4gKw0KPiA+
ICBjb25maWcgUElOQ1RSTF9NVDY3OTcNCj4gPiAgICAgICAgIGJvb2wgIk1lZGlhdGVrIE1UNjc5
NyBwaW4gY29udHJvbCINCj4gPiAgICAgICAgIGRlcGVuZHMgb24gT0YNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL01ha2VmaWxlIGIvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL01ha2VmaWxlDQo+ID4gaW5kZXggYTc0MzI1YS4uNTljMWM2MCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJz
L3BpbmN0cmwvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBAQCAtMTEsNiArMTEsNyBAQCBvYmotJChD
T05GSUdfUElOQ1RSTF9NVDI3MTIpICArPSBwaW5jdHJsLW10MjcxMi5vDQo+ID4gIG9iai0kKENP
TkZJR19QSU5DVFJMX01UODEzNSkgICArPSBwaW5jdHJsLW10ODEzNS5vDQo+ID4gIG9iai0kKENP
TkZJR19QSU5DVFJMX01UODEyNykgICArPSBwaW5jdHJsLW10ODEyNy5vDQo+ID4gIG9iai0kKENP
TkZJR19QSU5DVFJMX01UNjc2NSkgICArPSBwaW5jdHJsLW10Njc2NS5vDQo+ID4gK29iai0kKENP
TkZJR19QSU5DVFJMX01UNjc3OSkgICArPSBwaW5jdHJsLW10Njc3OS5vDQo+ID4gIG9iai0kKENP
TkZJR19QSU5DVFJMX01UNjc5NykgICArPSBwaW5jdHJsLW10Njc5Ny5vDQo+ID4gIG9iai0kKENP
TkZJR19QSU5DVFJMX01UNzYyMikgICArPSBwaW5jdHJsLW10NzYyMi5vDQo+ID4gIG9iai0kKENP
TkZJR19QSU5DVFJMX01UNzYyMykgICArPSBwaW5jdHJsLW10NzYyMy5vDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10Njc3OS5jIGIvZHJpdmVycy9w
aW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ2Nzc5LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+IGluZGV4IDAwMDAwMDAuLjE0NWJmMjINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ2Nzc5LmMNCj4gPiBAQCAtMCww
ICsxLDc3NSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+
ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTkgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKiBB
dXRob3I6IEFuZHkgVGVuZyA8YW5keS50ZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiArICoNCj4gPiAr
ICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAicGluY3RybC1tdGstbXQ2Nzc5LmgiDQo+ID4gKyNp
bmNsdWRlICJwaW5jdHJsLXBhcmlzLmgiDQo+ID4gKw0KPiA+ICsvKiBNVDY3NzkgaGF2ZSBtdWx0
aXBsZSBiYXNlcyB0byBwcm9ncmFtIHBpbiBjb25maWd1cmF0aW9uIGxpc3RlZCBhcyB0aGUgYmVs
b3c6DQo+ID4gKyAqIGdwaW86MHgxMDAwNTAwMCwgICAgIGlvY2ZnX3JtOjB4MTFDMjAwMDAsIGlv
Y2ZnX2JyOjB4MTFEMTAwMDAsDQo+ID4gKyAqIGlvY2ZnX2xtOjB4MTFFMjAwMDAsIGlvY2ZnX2xi
OjB4MTFFNzAwMDAsIGlvY2ZnX3J0OjB4MTFFQTAwMDAsDQo+ID4gKyAqIGlvY2ZnX2x0OjB4MTFG
MjAwMDAsIGlvY2ZnX3RsOjB4MTFGMzAwMDANCj4gPiArICogX2lfYmFzZWQgY291bGQgYmUgdXNl
ZCB0byBpbmRpY2F0ZSB3aGF0IGJhc2UgdGhlIHBpbiBzaG91bGQgYmUgbWFwcGVkIGludG8uDQo+
ID4gKyAqLw0KPiA+ICsNCj4gPiArI2RlZmluZSBQSU5fRklFTERfQkFTRShzX3BpbiwgZV9waW4s
IGlfYmFzZSwgc19hZGRyLCB4X2FkZHJzLCBzX2JpdCwgeF9iaXRzKSBcDQo+ID4gKyAgICAgICBQ
SU5fRklFTERfQ0FMQyhzX3BpbiwgZV9waW4sIGlfYmFzZSwgc19hZGRyLCB4X2FkZHJzLCBzX2Jp
dCwgeF9iaXRzLCBcDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAzMiwgMCkNCj4gPiArDQo+
IA0KPiA8c25pcD4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRl
a0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K


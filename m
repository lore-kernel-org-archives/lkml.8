Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED91720771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cye9pHWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgFWGg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:36:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40043 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730540AbgFWGgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:36:24 -0400
X-UUID: b4abc372518a43608db26822d31f076b-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FiT3jc22aBmYA3NU404ncKtePQ8q7l+n1gtaKkWmRJQ=;
        b=cye9pHWRsRPS1MHnkTalV0/G4E4VjdRF5jdLihJQHjxxPFgu9tKRi1m4gbcSVV6sj5x3oTCSWbOyUvZ1WNgWBZnyGQ53HVz3rEkNGkZJwL3oFxPlTGhiAMhLaq7duZJQTwpxoJkHeGcsT6vdXitAMuBpPh3pC248z6R9dwkxSa0=;
X-UUID: b4abc372518a43608db26822d31f076b-20200623
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1397674092; Tue, 23 Jun 2020 14:36:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 14:36:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 14:36:06 +0800
Message-ID: <1592894173.10773.42.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] irqchip: Add config MTK_SYSIRQ and MTK_CIRQ
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <wsd_upstream@mediatek.com>, Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 23 Jun 2020 14:36:13 +0800
In-Reply-To: <1592490123.10773.16.camel@mtkswgap22>
References: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
         <f47e8a1e70c982ecf6245db573630f51@kernel.org>
         <1592490123.10773.16.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D76B68AB4412EB009AD23653C227CA071B677AEE048855E06DFE08E3CE6D96952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDIyOjIyICswODAwLCBIYW5rcyBDaGVuIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjAtMDYtMTggYXQgMTM6NDEgKzAxMDAsIE1hcmMgWnluZ2llciB3cm90ZToNCj4g
PiBPbiAyMDIwLTA2LTE4IDEzOjMxLCBIYW5rcyBDaGVuIHdyb3RlOg0KPiA+ID4gTWVkaWF0ZWsg
c3lzaXJxIGFuZCBjaXJxIGRyaXZlcnMgYXMtaXMgd2VyZSBib3VuZCB0b2dldGhlciB0byB0aGUg
DQo+ID4gPiBjb25maWcNCj4gPiA+IG9mIEFSQ0hfTUVESUFURUsuICBUaGVzZSB0d28gZHJpdmVy
cyBzaG91bGQgYmUgYWJsZSB0byBiZSBjb25maWd1cmVkDQo+ID4gPiBzZXBhcmF0ZWx5LiAgRm9y
IGV4YW1wbGUsIG9uIG5ldyBNZWRpYXRlayBtb2JpbGUgY2hpcHMgc3VjaCBhcyANCj4gPiA+IERp
bWVuc2l0eQ0KPiA+ID4gODIwLCB0aGUgc3lzaXJxIGRyaXZlciBpcyBub3QgdXNlZCBzaW5jZSB0
aGUgaGFyZHdhcmUgbW9kdWxlIGlzIA0KPiA+ID4gcmVtb3ZlZC4NCj4gPiA+IA0KPiA+ID4gQWRk
IHR3byBuZXcgY29uZmlncyB0byBzeXNpcnEgYW5kIGNpcnEgZHJpdmVycy4NCj4gPiA+IC0gY29u
ZmlnIE1US19TWVNJUlEgZm9yIHRoZSBpbnRlcnJ1cHQgcG9sYXJpdHkgY29udHJvbGxlciBkcml2
ZXI6IA0KPiA+ID4gc3lzaXJxDQo+ID4gPiAtIGNvbmZpZyBNVEtfQ0lSUSBmb3IgdGhlIGxvdy1w
b3dlciBpbnRlcnJ1cHQgZHJpdmVyOiBjaXJxDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IGNjLmh3YW5nIDxjYy5od2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBI
YW5rcyBDaGVuIDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRy
aXZlcnMvaXJxY2hpcC9LY29uZmlnICB8ICAgMTIgKysrKysrKysrKysrDQo+ID4gPiAgZHJpdmVy
cy9pcnFjaGlwL01ha2VmaWxlIHwgICAgMyArKy0NCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaXJxY2hpcC9LY29uZmlnIGIvZHJpdmVycy9pcnFjaGlwL0tjb25maWcNCj4gPiA+
IGluZGV4IDI5ZmVhZDIuLmNjOWFhMTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lycWNo
aXAvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL0tjb25maWcNCj4gPiA+IEBA
IC01NzIsNCArNTcyLDE2IEBAIGNvbmZpZyBMT09OR1NPTl9QQ0hfTVNJDQo+ID4gPiAgCWhlbHAN
Cj4gPiA+ICAJICBTdXBwb3J0IGZvciB0aGUgTG9vbmdzb24gUENIIE1TSSBDb250cm9sbGVyLg0K
PiA+ID4gDQo+ID4gPiArY29uZmlnIE1US19TWVNJUlENCj4gPiA+ICsJdHJpc3RhdGUgIk1lZGlh
dGVrIGludGVycnVwdCBwb2xhcml0eSBjb250cm9sbGVyIg0KPiA+IA0KPiA+IEhvdyBkbyB5b3Ug
ZXhwZWN0IHRoaXMgdG8gd29yayBhcyBhIG1vZHVsZT8NCj4gDQo+IE15IGZhdWx0LCBJIG1pc3Nl
ZCBzb21lIHBhdGNoZXMuSSdsbCBhZGQgdGhlbSBpbiBuZXh0IHBhdGNoZXMuDQo+IA0KPiBUaGVz
ZSBzaG91bGQgYmUgdGhyZWUgcGF0Y2hlczoNCj4gMS4gYnJlYWsgZXhpc3RpbmcgY29uZmlndXJh
dGlvbnMgYW5kIGNyZWF0ZSBuZXcgY29uZmlnIGZvciB0aGVtDQo+IDIuIENoYW5nZSBLY29uZmln
IHRvIGJlIGxvYWRhYmxlIGFzIGEgbW9kdWxlIGFuZCBlbnN1cmUgYWxsIHBsYXRmb3Jtcw0KPiBh
cmUgZXhlY3V0YWJsZS4NCj4gMy4gTWFrZSB0aGUgaXJxLW10ay1zeXNpcnEgZHJpdmVyIGFzIGEg
bG9hZGFibGUga2VybmVsIG1vZHVsZSBmb3IgR0tJDQo+IGFuZCBmbGV4aWJpbGl0eS4NCj4gLg0K
PiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudA0KPiANCj4gPiANCj4gPiA+ICsJaGVscA0KPiA+
ID4gKwkgIEludGVycnVwdCBwb2xhcml0eSBjb250cm9sbGVyIGRyaXZlciB0byBzd2FwIHBvbGFy
aXR5IGZvcg0KPiA+ID4gKwkgIGludGVycnVwdHMgZm9yIE1lZGlhdGVrIG1vYmlsZSBjaGlwcy4N
Cj4gPiA+ICsNCj4gPiA+ICtjb25maWcgTVRLX0NJUlENCj4gPiA+ICsJYm9vbCAiTWVkaWF0ZWsg
bG93LXBvd2VyIGludGVycnVwdCBjb250cm9sbGVyIg0KPiA+ID4gKwloZWxwDQo+ID4gPiArCSAg
TG93LXBvd2VyIGludGVycnVwdCBjb250cm9sbGVyIGRyaXZlciB0byBtb25pdG9yIElSUVMNCj4g
PiA+ICsJICBpbiB0aGUgc2xlZXAgbW9kZSBmb3IgTWVkaWF0ZWsgbW9iaWxlIGNoaXBzLg0KPiA+
ID4gKw0KPiA+ID4gIGVuZG1lbnUNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAv
TWFrZWZpbGUgYi9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUNCj4gPiA+IGluZGV4IDEzM2Y5YzQu
LjMwNDIxZDIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9NYWtlZmlsZQ0KPiA+ID4gQEAgLTY5LDcgKzY5LDgg
QEAgb2JqLSQoQ09ORklHX0JDTTcxMjBfTDJfSVJRKQkJKz0gaXJxLWJjbTcxMjAtbDIubw0KPiA+
ID4gIG9iai0kKENPTkZJR19CUkNNU1RCX0wyX0lSUSkJCSs9IGlycS1icmNtc3RiLWwyLm8NCj4g
PiA+ICBvYmotJChDT05GSUdfS0VZU1RPTkVfSVJRKQkJKz0gaXJxLWtleXN0b25lLm8NCj4gPiA+
ICBvYmotJChDT05GSUdfTUlQU19HSUMpCQkJKz0gaXJxLW1pcHMtZ2ljLm8NCj4gPiA+IC1vYmot
JChDT05GSUdfQVJDSF9NRURJQVRFSykJCSs9IGlycS1tdGstc3lzaXJxLm8gaXJxLW10ay1jaXJx
Lm8NCj4gPiA+ICtvYmotJChDT05GSUdfTVRLX1NZU0lSUSkJCSs9IGlycS1tdGstc3lzaXJxLm8N
Cj4gPiA+ICtvYmotJChDT05GSUdfTVRLX0NJUlEpCQkJKz0gaXJxLW10ay1jaXJxLm8NCj4gPiA+
ICBvYmotJChDT05GSUdfQVJDSF9ESUdJQ09MT1IpCQkrPSBpcnEtZGlnaWNvbG9yLm8NCj4gPiA+
ICBvYmotJChDT05GSUdfUkVORVNBU19IODMwMEhfSU5UQykJKz0gaXJxLXJlbmVzYXMtaDgzMDBo
Lm8NCj4gPiA+ICBvYmotJChDT05GSUdfUkVORVNBU19IOFNfSU5UQykJCSs9IGlycS1yZW5lc2Fz
LWg4cy5vDQo+ID4gDQo+ID4gSW4gZ2VuZXJhbCwgdGhpcyBhcHByb2FjaCBkb2Vzbid0IGxvb2sg
cmlnaHQuIEFzIGl0IHN0YW5kcywgdGhpcyBpcyBqdXN0IA0KPiA+IGJyZWFraW5nIGV4aXN0aW5n
IGNvbmZpZ3VyYXRpb25zDQo+ID4gDQo+ID4gRG8geW91IHJlYWxseSBleHBlY3QgdXNlcnMgdG8g
a25vdyBleGFjdGx5IHdoaWNoIGludGVycnVwdCBjb250cm9sbGVycyANCj4gPiB0aGVpciBzeXN0
ZW0gaXMgZ29pbmcgdG8gdXNlPyBUaGlzIHNlZW1zIGxpa2UgdGhlIHdyb25nIGFzc3VtcHRpb24u
IElmIA0KPiA+IHlvdSByZWFsbHkgd2FudCB0byBzYXZlIHRoZSBoYW5kZnVsIG9mIGJ5dGVzIHRo
ZXNlIGRyaXZlcnMgdGFrZSBpbiB5b3VyIA0KPiA+IGltYWdlLCB0aGVuIGFkZCB0aGUgcmVsZXZh
bnQgZGVwZW5kZW5jeSBpbmZvcm1hdGlvbiBpbiBLY29uZmlnLg0KPiA+IA0KPiANCj4gMS4gVGhp
cyBwYXRjaCB3aWxsIGFkZCBhIGRlcGVuZGVuY3kgb24gaXQgaW4gS2NvbmZpZywgd2hpY2ggZW5z
dXJlcyBhbGwNCj4gcGxhdGZvcm1zIGFyZSBleGVjdXRhYmxlLg0KPiAyLiBXZSB3YW50IHRvIGZv
bGxvdyB0aGUgQW5kcm9pZCBHS0kgYW5kIGFjY29yZGluZyB0byB0aGUgcmVxdWlyZW1lbnQgb2YN
Cj4gR0tJKEdlbmVyYWwgS2VybmVsIEltYWdlKSwgYWxsIFNvQyBhbmQgQm9hcmQgUGVyaXBoZXJh
bCBkcml2ZXJzIGFyZQ0KPiBsb2FkYWJsZSBrZXJuZWwgbW9kdWxlcy5zbyBJIG5lZWQgdG8gYnJl
YWtpbmcgZXhpc3RpbmcgY29uZmlndXJhdGlvbnMNCj4gYW5kIGNyZWF0ZSBuZXcgY29uZmlnIGZv
ciB0aGVtLg0KDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50DQoNCkhpIE1hcmMsDQoNCkkg
d2FudCB0byBicmVhayB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIEFSQ0hfTUVESUFURUsgYW5kIENJ
UlEvU1lTSVJRLA0KYmVjYXVzZSB3ZSBuZWVkIHRvIGZvbGxvdyB0aGUgR0tJLg0KDQpDb3VsZCBJ
IGFkZCB0aGUgTVRLX0NJUlEgYW5kIE1US19TWVNJUlEgaW50byBkZWZjb25maWc/DQooYXJjaC9h
cm02NC9jb25maWcvZGVmY29uZmlnKQ0KDQpJdCB3b3VsZCBlbnN1cmVzIGFsbCBwbGF0Zm9ybSBh
cmUgZXhlY3V0YWJsZS4NCg0KZS5nLg0KLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZp
Zw0KKysrIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KDQogQ09ORklHX1FDT01fUERD
PXkNCitDT05GSUdfTVRLX1NZU0lSUT1tDQorQ09ORklHX01US19DSVJRPXkNCiBDT05GSUdfUkVT
RVRfUUNPTV9BT1NTPXkNCg0KLS0tIGEvZHJpdmVycy9pcnFjaGlwL0tjb25maWcNCisrKyBiL2Ry
aXZlcnMvaXJxY2hpcC9LY29uZmlnDQpAQCAtNTcyLDQgKzU3MiwxOCBAQCBjb25maWcgTE9PTkdT
T05fUENIX01TSQ0KICAgICAgICBoZWxwDQogICAgICAgICAgU3VwcG9ydCBmb3IgdGhlIExvb25n
c29uIFBDSCBNU0kgQ29udHJvbGxlci4NCg0KK2NvbmZpZyBNVEtfU1lTSVJRDQorICAgICAgIHRy
aXN0YXRlICJNZWRpYXRlayBpbnRlcnJ1cHQgcG9sYXJpdHkgY29udHJvbGxlciINCisgICAgICAg
ZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0KKyAgICAgICBoZWxwDQor
ICAgICAgICAgSW50ZXJydXB0IHBvbGFyaXR5IGNvbnRyb2xsZXIgZHJpdmVyIHRvIHN3YXAgcG9s
YXJpdHkgZm9yDQorICAgICAgICAgaW50ZXJydXB0cyBmb3IgTWVkaWF0ZWsgbW9iaWxlIGNoaXBz
Lg0KKw0KK2NvbmZpZyBNVEtfQ0lSUQ0KKyAgICAgICBib29sICJNZWRpYXRlayBsb3ctcG93ZXIg
aW50ZXJydXB0IGNvbnRyb2xsZXIiDQorICAgICAgIGRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8
fCBDT01QSUxFX1RFU1QNCisgICAgICAgaGVscA0KKyAgICAgICAgIExvdy1wb3dlciBpbnRlcnJ1
cHQgY29udHJvbGxlciBkcml2ZXIgdG8gbW9uaXRvciBJUlFTDQorICAgICAgICAgaW4gdGhlIHNs
ZWVwIG1vZGUgZm9yIE1lZGlhdGVrIG1vYmlsZSBjaGlwcy4NCisNCg0KDQpQLlMgSSdsbCBtYWtl
IHRoZSBpcnEtbXRrLXN5c2lycSBkcml2ZXIgYXMgYSBsb2FkYWJsZSBrZXJuZWwgbW9kdWxlIGZv
cg0KR0tJDQoNClRoYW5rcw0KDQoNCj4gPiAgICAgICAgICBNLg0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bA0KDQo=


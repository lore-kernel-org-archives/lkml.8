Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C68C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58452083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgD2N7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:59:05 -0400
Received: from mx-relay77-hz1.antispameurope.com ([94.100.132.239]:46954 "EHLO
        mx-relay77-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgD2N7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:59:04 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 09:59:02 EDT
Received: from mailgw1.iis.fraunhofer.de ([153.96.172.4]) by mx-relay77-hz1.antispameurope.com;
 Wed, 29 Apr 2020 15:53:06 +0200
Received: from mail.iis.fraunhofer.de (mail03.iis.fhg.de [153.96.171.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.iis.fraunhofer.de (Postfix) with ESMTPS id 8733D2400082;
        Wed, 29 Apr 2020 15:53:02 +0200 (CEST)
Received: from mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) by
 mail03.iis.fhg.de (2001:638:a0a:1111:314f:f22c:4a37:b25a) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 29 Apr 2020 15:53:02 +0200
Received: from mail01.iis.fhg.de ([fe80::fd91:8c2a:e4a5:e74e]) by
 mail01.iis.fhg.de ([fe80::fd91:8c2a:e4a5:e74e%12]) with mapi id
 15.00.1395.000; Wed, 29 Apr 2020 15:53:02 +0200
From:   "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Thread-Topic: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Thread-Index: AQHWFA15mQXQpLHKR0emWdXVXY2Gm6iOf4GAgAEst4CAAB7rgIAARjmA
Date:   Wed, 29 Apr 2020 13:53:02 +0000
Message-ID: <03b6755c07fb19420a7fb21b434b137aaa238893.camel@iis-extern.fraunhofer.de>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
         <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
         <20200428135443.GA1437053@kroah.com>
         <eb405ab3782844e379629a655a3dcaf38dd2552d.camel@iis-extern.fraunhofer.de>
         <20200429094141.GB2080576@kroah.com>
In-Reply-To: <20200429094141.GB2080576@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [153.96.171.210]
Content-Type: text/plain; charset="utf-8"
Content-ID: <360A9EF8EDE7BB4B89D615F459782861@iis.fhg.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-cloud-security-sender: manuel.stahl@iis-extern.fraunhofer.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay77-hz1.antispameurope.com with AED91602119
X-cloud-security-connect: mailgw1.iis.fraunhofer.de[153.96.172.4], TLS=1, IP=153.96.172.4
X-cloud-security: scantime:.3293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMjAtMDQtMjkgYXQgMTE6NDEgKzAyMDAsIGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAyOSwgMjAyMCBhdCAwNzo1MTowMUFNICswMDAwLCBT
dGFobCwgTWFudWVsIHdyb3RlOg0KPiA+IE9uIERpLCAyMDIwLTA0LTI4IGF0IDE1OjU0ICswMjAw
LCBncmVna2ggQCBsaW51eGZvdW5kYXRpb24gLiBvcmcgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEFw
ciAxNiwgMjAyMCBhdCAwNjozODozMFBNICswMjAwLCBNYW51ZWwgU3RhaGwgd3JvdGU6DQo+ID4g
PiA+IA0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFNpbmNlIHRoZSBkcml2ZXIgZG9lcyBub3Qg
ZGVjbGFyZSBhbnkgZGV2aWNlIGlkcywgeW91IG11c3QgYWxsb2NhdGUNCj4gPiA+ID4gKyAqIGlk
IGFuZCBiaW5kIHRoZSBkZXZpY2UgdG8gdGhlIGRyaXZlciB5b3Vyc2VsZi4gIEZvciBleGFtcGxl
Og0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqICMgZWNobyAiODA4NiAxMGY1IiA+IC9zeXMvYnVz
L3BjaS9kcml2ZXJzL3Vpb19wY2lfZG1lbV9nZW5pcnEvbmV3X2lkDQo+ID4gPiA+ICsgKiAjIGVj
aG8gLW4gMDAwMDowMDoxOS4wID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvZTEwMDBlL3VuYmluZA0K
PiA+ID4gPiArICogIyBlY2hvIC1uIDAwMDA6MDA6MTkuMCA+IC9zeXMvYnVzL3BjaS9kcml2ZXJz
L3Vpb19wY2lfZG1lbV9nZW5pcnEvYmluZA0KPiA+ID4gPiArICogIyBscyAtbCAvc3lzL2J1cy9w
Y2kvZGV2aWNlcy8wMDAwOjAwOjE5LjAvZHJpdmVyDQo+ID4gPiA+ICsgKiAuLi4vMDAwMDowMDox
OS4wL2RyaXZlciAtPiAuLi8uLi8uLi9idXMvcGNpL2RyaXZlcnMvdWlvX3BjaV9kbWVtX2dlbmly
cQ0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIE9yIHVzZSBhIG1vZHByb2JlIGFsaWFzOg0KPiA+
ID4gPiArICogIyBhbGlhcyBwY2k6djAwMDAxMEVFZDAwMDAxMDAwc3Yqc2Qqc2MqaSogdWlvX3Bj
aV9kbWVtX2dlbmlycQ0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIERyaXZlciB3b24ndCBiaW5k
IHRvIGRldmljZXMgd2hpY2ggZG8gbm90IHN1cHBvcnQgdGhlIEludGVycnVwdCBEaXNhYmxlIEJp
dA0KPiA+ID4gPiArICogaW4gdGhlIGNvbW1hbmQgcmVnaXN0ZXIuIEFsbCBkZXZpY2VzIGNvbXBs
aWFudCB0byBQQ0kgMi4zIChjaXJjYSAyMDAyKSBhbmQNCj4gPiA+ID4gKyAqIGFsbCBjb21wbGlh
bnQgUENJIEV4cHJlc3MgZGV2aWNlcyBzaG91bGQgc3VwcG9ydCB0aGlzIGJpdC4NCj4gPiA+ID4g
KyAqDQo+ID4gPiA+ICsgKiBUaGUgRE1BIG1hc2sgYml0cyBhbmQgc2l6ZXMgb2YgZHluYW1pYyBy
ZWdpb25zIGFyZSBkZXJpdmVkIGZyb20gbW9kdWxlDQo+ID4gPiA+ICsgKiBwYXJhbWV0ZXJzLg0K
PiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFRoZSBmb3JtYXQgZm9yIHNwZWNpZnlpbmcgZHluYW1p
YyByZWdpb24gc2l6ZXMgaW4gbW9kdWxlIHBhcmFtZXRlcnMNCj4gPiA+ID4gKyAqIGlzIGFzIGZv
bGxvd3M6DQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICogdWlvX3BjaV9kbWVtX2dlbmlycS5kbWVt
X3NpemVzIDo9IDx1aW9fZG1lbV9zaXplc19kZWY+Wzs8dWlvX2RtZW1fc2l6ZXNfZGVmPl0NCj4g
PiA+ID4gKyAqIDx1aW9fZG1lbV9zaXplc19kZWY+ICAgICAgICAgICA6PSA8cGNpX2lkPjo8c2l6
ZT5bLDxzaXplPl0NCj4gPiA+ID4gKyAqIDxwY2lfaWQ+ICAgICAgICAgICAgICAgICAgICAgICA6
PSA8dmVuZG9yPjo8ZGV2aWNlPg0KPiA+ID4gPiArICogPHNpemU+ICAgICAgICAgICAgICAgICAg
ICAgICAgIDo9IHN0YW5kYXJkIGxpbnV4IG1lbXNpemUNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsg
KiBFeGFtcGxlczoNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiAxKSBVSU8gZG1lbSBkZXZpY2Ug
d2l0aCAzIGR5bmFtaWMgcmVnaW9uczoNCj4gPiA+ID4gKyAqIHVpb19wY2lfZG1lbV9nZW5pcnEu
ZG1lbV9zaXplcz04MDg2OjEwZjU6NEssMTZLLDRNDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICog
MikgVHdvIFVJTyBkbWVtIGRldmljZXMgd2l0aCBkaWZmZXJlbnQgbnVtYmVyIG9mIGR5bmFtaWMg
cmVnaW9uczoNCj4gPiA+ID4gKyAqIHVpb19wY2lfZG1lbV9nZW5pcnEuZG1lbV9zaXplcz04MDg2
OjEwZjU6NEssMTZLLDRNOzEyMzQ6MDAwMTo4Sw0KPiA+ID4gDQo+ID4gPiBNb2R1bGUgcGFyYW1l
dGVycyBhcmUgaG9ycmlkLCBhcmUgeW91IHN1cmUgdGhlcmUgaXMgbm8gb3RoZXIgd2F5Pw0KPiA+
IA0KPiA+IFlvdSdyZSByaWdodCwgc2VlbWVkIHRvIGJlIHRoZSBzaW1wbGVzdCBzb2x1dGlvbiBi
YWNrIHdoZW4gd2Ugc3RhcnRlZCBkZXZlbG9waW5nIHRoaXMgZHJpdmVyLiBJIHdpbGwgdHJ5IHRv
IGNoYW5nZSBpdCB0byBzeXNmcywgc28gdGhhdCBvbmUgY2FuIGFkZCByZWdpb25zIHdoaWxlIHRo
ZSBtb2R1bGUgaXMgYWxyZWFkeSBsb2FkZWQuDQo+IA0KPiAvbWUgaGFuZHMgeW91IHNvbWUgXG4g
Y2hhcmFjdGVycy4uLg0KPiANCj4gQW55d2F5LCBjb25maWdmcyBpcyBmb3IgY29uZmlndXJpbmcg
c3R1ZmYsIGRvbid0IG1ha2UgYSBzeXNmcyBmaWxlIHRoYXQNCj4geW91IGhhdmUgdG8gc29tZWhv
dyAicGFyc2UiIHBsZWFzZS4NCg0KTG9va2luZyBiYWNrIGF0IHRoaXMgZHJpdmVyIGFmdGVyIHNv
bWUgeWVhcnMgSSByZWFsaXplZCBhZ2FpbiB0aGUgcmVhc29uDQpmb3IgdXNpbmcga2VybmVsIHBh
cmFtZXRlcnM6DQoNClRoZSBjdXJyZW50IFVJTyBBUEkgbmVlZHMgdGhlIGluZm9ybWF0aW9uIGFi
b3V0IGF2YWlsYWJsZSBtZW1vcnkgbWFwcyB3aGVuDQpyZWdpc3RlcmluZyBhIG5ldyBVSU8gZGV2
aWNlIHdpdGggX191aW9fcmVnaXN0ZXJfZGV2aWNlKCksIHdoaWNoIG9idmlvdXNseQ0KbmVlZHMg
dG8gYmUgY2FsbGVkIGR1cmluZyBwcm9iZSgpIGluIHVpb19wY2lfZG1lbV9nZW5pcnEuIE90aGVy
d2lzZSB0aGVyZQ0KaXMgbm8gZGV2aWNlIGZpbGUgaW4gL2RldiB0byBvcGVuIGZvciB1c2VyIHNw
YWNlIGFwcGxpY2F0aW9ucy4NCg0KQWZ0ZXIgdGhhdCB0aGVyZSBpcyBubyBmdW5jdGlvbiB0byB1
cGRhdGUgdGhlIHVpb19tYXAgaW5mby4gU28gd2UgY2FuIGVpdGhlcg0Ka2VlcCB0aGUgbW9kdWxl
IHBhcmFtZXRlcnMgYW5kIGFsbG9jYXRlIHRoZSBETUEgbWVtb3J5IGR1cmluZyBwcm9iZSgpIG9y
DQphbGxvY2F0ZSB0aGUgRE1BIG1lbW9yeSBkdXJpbmcgbW1hcCgpIGFuZA0KICBhKSByZXBsaWNh
dGUgcGFydHMgb2YgdWlvX2Rldl9hZGRfYXR0cmlidXRlcygpIGluIHRoaXMgZHJpdmVyIHRvIHVw
ZGF0ZSBzeXNmcw0KICBiKSBhZGQgYSBmdW5jdGlvbiBpbiB1aW8uYyB0byBhbGxvdyB1cGRhdGVz
IHRvIHRoZSB1aW9fbWFwDQoNCldoaWNoIHdheSB3b3VsZCB5b3UgZ28/DQoNCkJlc3QgcmVnYXJk
cywNCk1hbnVlbCBTdGFobA0K

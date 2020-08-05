Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD992C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BF320738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHECgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:36:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37514 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHECgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:36:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0752ZrYY2004748, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0752ZrYY2004748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 5 Aug 2020 10:35:53 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Aug 2020 10:35:53 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Aug 2020 10:35:52 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::41b2:c3f0:a0f3:ce6d]) by
 RTEXMB01.realtek.com.tw ([fe80::41b2:c3f0:a0f3:ce6d%5]) with mapi id
 15.01.1779.005; Wed, 5 Aug 2020 10:35:52 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     Chris Clayton <chris2553@googlemail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: RE: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on Intel NUC boxes
Thread-Topic: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
 on Intel NUC boxes
Thread-Index: AQHWaQXnJbf1udfgtku7UiOjY+d5jakktnGAgAKFU9D//9NfgIAAiHfA//+I7ICAAKENcP//kYCAAC8lUQA=
Date:   Wed, 5 Aug 2020 02:35:52 +0000
Message-ID: <e1c295f28e3d4bdd8c78dfd3a5ed398c@realtek.com>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
 <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
 <19de15c2f07d447dace6bea483d38159@realtek.com>
 <152ef6c0-f3c0-bb67-4175-adced3c720cd@googlemail.com>
In-Reply-To: <152ef6c0-f3c0-bb67-4175-adced3c720cd@googlemail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQ2xheXRvbiBb
bWFpbHRvOmNocmlzMjU1M0Bnb29nbGVtYWlsLmNvbV0NCj4gU2VudDogVHVlc2RheSwgQXVndXN0
IDA0LCAyMDIwIDc6NTIgUE0NCj4gVG86IOWQs+aYiua+hCBSaWNreTsgZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmcNCj4gQ2M6IExLTUw7IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsgcGhpbHF1YWRy
YUBnbWFpbC5jb207IEFybmQgQmVyZ21hbm4NCj4gU3ViamVjdDogUmU6IFBBVENIOiBydHN4X3Bj
aSBkcml2ZXIgLSBkb24ndCBkaXNhYmxlIHRoZSBydHM1MjI5IGNhcmQgcmVhZGVyIG9uDQo+IElu
dGVsIE5VQyBib3hlcw0KPiANCj4gDQo+IA0KPiBPbiAwNC8wOC8yMDIwIDExOjQ2LCDlkLPmmIrm
voQgUmlja3kgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZy
b206IENocmlzIENsYXl0b24gW21haWx0bzpjaHJpczI1NTNAZ29vZ2xlbWFpbC5jb21dDQo+ID4+
IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAwNCwgMjAyMCA0OjUxIFBNDQo+ID4+IFRvOiDlkLPmmIrm
voQgUmlja3k7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4+IENjOiBMS01MOyByZHVu
bGFwQGluZnJhZGVhZC5vcmc7IHBoaWxxdWFkcmFAZ21haWwuY29tOyBBcm5kIEJlcmdtYW5uDQo+
ID4+IFN1YmplY3Q6IFJlOiBQQVRDSDogcnRzeF9wY2kgZHJpdmVyIC0gZG9uJ3QgZGlzYWJsZSB0
aGUgcnRzNTIyOSBjYXJkIHJlYWRlciBvbg0KPiA+PiBJbnRlbCBOVUMgYm94ZXMNCj4gPj4NCj4g
Pj4NCj4gPj4NCj4gPj4gT24gMDQvMDgvMjAyMCAwOTowOCwg5ZCz5piK5r6EIFJpY2t5IHdyb3Rl
Og0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmcgW21haWx0bzpncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZ10N
Cj4gPj4+PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMDQsIDIwMjAgMzo0OSBQTQ0KPiA+Pj4+IFRv
OiDlkLPmmIrmvoQgUmlja3kNCj4gPj4+PiBDYzogQ2hyaXMgQ2xheXRvbjsgTEtNTDsgcmR1bmxh
cEBpbmZyYWRlYWQub3JnOyBwaGlscXVhZHJhQGdtYWlsLmNvbTsNCj4gPj4gQXJuZA0KPiA+Pj4+
IEJlcmdtYW5uDQo+ID4+Pj4gU3ViamVjdDogUmU6IFBBVENIOiBydHN4X3BjaSBkcml2ZXIgLSBk
b24ndCBkaXNhYmxlIHRoZSBydHM1MjI5IGNhcmQgcmVhZGVyDQo+IG9uDQo+ID4+Pj4gSW50ZWwg
TlVDIGJveGVzDQo+ID4+Pj4NCj4gPj4+PiBPbiBUdWUsIEF1ZyAwNCwgMjAyMCBhdCAwMjo0NDo0
MUFNICswMDAwLCDlkLPmmIrmvoQgUmlja3kgd3JvdGU6DQo+ID4+Pj4+IEhpIENocmlzLA0KPiA+
Pj4+Pg0KPiA+Pj4+PiBydHN4X3BjaV93cml0ZV9yZWdpc3RlcihwY3IsIEZQRFRMLCBPQ19QT1dF
Ul9ET1dOLA0KPiA+PiBPQ19QT1dFUl9ET1dOKTsNCj4gPj4+Pj4gVGhpcyByZWdpc3RlciBvcGVy
YXRpb24gc2F2ZWQgcG93ZXIgdW5kZXIgMW1BLCBzbyBpZiBkbyBub3QgY2FyZSB0aGUgMW1BDQo+
ID4+Pj4gcG93ZXIgd2UgY2FuIGhhdmUgYSBwYXRjaCB0byByZW1vdmUgaXQsIG1ha2UgY29tcGF0
aWJsZSB3aXRoIE5VQzYNCj4gPj4+Pj4gV2UgdGVzdGVkIG90aGVycyBvdXIgY2FyZCByZWFkZXIg
dGhhdCByZW1vdmUgaXQsIHdlIGRpZCBub3Qgc2VlIGFueSBzaWRlDQo+ID4+IGVmZmVjdA0KPiA+
Pj4+Pg0KPiA+Pj4+PiBIaSBHcmVnIGstaCwNCj4gPj4+Pj4NCj4gPj4+Pj4gRG8geW91IGhhdmUg
YW55IGNvbW1lbnRzPw0KPiA+Pj4+DQo+ID4+Pj4gY29tbWVudHMgb24gd2hhdD8gIEkgZG9uJ3Qg
a25vdyB3aGF0IHlvdSBhcmUgcmVzcG9uZGluZyB0byBoZXJlLCBzb3JyeS4NCj4gPj4+Pg0KPiA+
Pj4gQ2FuIHdlIGhhdmUgYSBwYXRjaCB0byBrZXJuZWwgZm9yIE5VQzY/IEl0IG1heSBjYXVzZSBt
b3JlIHBvd2VyKDFtQSkgYnV0DQo+IGl0DQo+ID4+IHdpbGwgaGF2ZSBtb3JlIGNvbXBhdGliaWxp
dHkNCj4gPj4+DQo+ID4+DQo+ID4+IFJpY2t5LA0KPiA+Pg0KPiA+PiBJIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IHlvdSB3YW50IHRvIGNvbXBsZXRlbHkgcmVtb3ZlIHRoZSBjb2RlIHRoYXQgc2V0cyB1
cA0KPiB0aGUNCj4gPj4gMW1BIHBvd2VyIHNhdmluZy4gVGhhdCBjb2RlIHdhcyB0aGVyZQ0KPiA+
PiBldmVuIGJlZm9yZSB5b3VyIHBhdGNoIChiZWRlMDNhNTc5YjNiNGEwMzYwMDNjNDg2MmNjMWJh
YTRkZGMzNTFmKSwgc28gSQ0KPiA+PiBhc3N1bWUgaXQgYmVuZWZpdHMgc29tZSBvZiB0aGUgUmVh
bHRlayBjYXJkDQo+ID4+IHJlYWRlcnMuIEJlZm9yZSB5b3VyIHBhdGNoIGhvd2V2ZXIsIHJ0c3hf
cGNpX2luaXRfb2NwKCkgd2FzIG5vdCBjYWxsZWQgZm9yIHRoZQ0KPiA+PiBydHM1MjI5IHJlYWRl
ciwgYnV0IHRoZSBwYXRjaCBpbnRyb2R1Y2VkDQo+ID4+IGFuIHVuY29uZGl0aW9uYWwgY2FsbCB0
byB0aGF0IGZ1bmN0aW9uIGludG8gcnRzeF9wY2lfaW5pdF9odygpLCB3aGljaCBpcyBydW4gZm9y
DQo+IHRoZQ0KPiA+PiBydHM1MjI5LiBUaGF0IGlzIHdoYXQgbm93IGRpc2FibGVzDQo+ID4+IHRo
ZSBjYXJkIHJlYWRlci4NCj4gPj4NCj4gPj4gTm93LCBJIGRvbid0IGtub3cgd2hldGhlciBvdGhl
ciBjYXJkcyBhcmUgYWZmZWN0ZWQsIGFsdGhvdWdoIEkgZG9uJ3QgcmVjYWxsDQo+ID4+IHNlZWlu
ZyBhbnkgcmVwb3J0ZWQgYXMgSSBzZWFyY2hlZCB0aGUga2VybmVsDQo+ID4+IGFuZCB1YnVudHUg
YnVnemlsbGFzIGZvciBhbnkgYW5hbHlzaXMgb2YgdGhlIHByb2JsZW0uIEkga25vdyB0aGlzIGlz
IG5vdCB3aGF0DQo+IHRoZQ0KPiA+PiBwYXRjaCBJIHNlbnQgZG9lcywgYnV0IGhhdmluZyB0aG91
Z2h0DQo+ID4+IGFib3V0IGl0IG1vcmUsIHNlZW1zIHRvIG1lIHRoYXQgdGhlIHNpbXBsZXN0IGZp
eCBpcyB0byBza2lwIHRoZSBuZXcgY2FsbCB0bw0KPiA+PiBydHN4X3BjaV9pbml0X29jcCgpIGlm
IHRoZSByZWFkZXIgaXMgYW4gcnRzNTIyOS4NCj4gPj4NCj4gPg0KPiA+IEJlY2F1c2Ugd2UgYXJl
IHRoaW5raW5nIGFib3V0IGlmIG90aGVycyBvdXIgY2FyZCByZWFkZXIgdGhhdCBub3QgYmVsb25n
IEENCj4gc2VyaWVzKG15IG9jcCBwYXRjaCBjb3ZlcmFnZSkgYWxzbyBvbiBOVUM2IHBsYXRmb3Jt
IG1heWJlIGhhdmUgdGhlIHNhbWUNCj4gcHJvYmxlbS4uLg0KPiA+DQo+IA0KPiBPSy4gV2hhdCBp
ZiB3ZSBkbyBtYWtlIHRoZSBuZXcgY2FsbCBidXQgb25seSBmb3IgdGhlIGNhcmQgcmVhZGVycyB0
aGF0IGFyZSBpbiB0aGUNCj4gQSBzZXJpZXM/IEFyZSB0aGV5IHRoZSBvbmVzIHRoYXQgaGF2ZQ0K
PiBQSURfNW5ubiBkZWZpbmVzIGluIGluY2x1ZGUvbGludXgvcnRzeF9wY2kuaD8gT3IgaXMgdGhl
cmUgYW5vdGhlciBzaW1wbGUgd2F5IG9mDQo+IGlkZW50aWZ5aW5nIHRoYXQgYSByZWFkZXIgaXMg
YSBtZW1iZXIgb2YNCj4gdGhlIEEgc2VyaWVzPw0KPiANCj4gSSdtIHRoaW5raW5nIG9mIHNvbWV0
aGluZyBsaWtlOg0KPiBzdGF0aWMgYm9vbCBydHN4X3BjaV9pc19zZXJpZXNfQShwY3IpDQo+IHsN
Cj4gCXVuc2lnbmVkIHNob3J0IGRldmljZSA9IHBjci0+cGNpLT5kZXZpY2U7DQo+IA0KPiAJcmV0
dXJuIGRldmljZSA9PSBQSUQ1MjRBIHx8IGRldmljZSA9PSBQSURfNTI0OSB8fCBkZXZpY2UgPT0g
UElEXzUyNTAgfHwNCj4gZGV2aWNlID09IFBJRF81MjVBDQo+IAkJCXx8IGRldmljZSA9PSBQSURf
NTI1QSB8fCBkZXZpY2UgPT0gUElEXzUyNjAgfHwgZGV2aWNlID09DQo+IFBJRF81MjYxOw0KPiB9
DQo+IA0KPiB0aGVuIGluIHJ0c3hfcGNpX2luaXRfaHcoKSBjaGFuZ2UgdGhlIHVuY29uZGl0aW9u
YWwgY2FsbCB0bzoNCj4gDQo+IAlpZiBydHN4X3BjaV9pc19zZXJpZXNfQShwY3IpDQo+IAkJcnRz
eF9wY2lfaW5pdF9vY3AoKTsNCj4gDQo+IERvZXMgdGhhdCBzZWVtIE9LPw0KPiANClByZXZpb3Vz
bHksIEkgd2FudCB0byByZW1vdmUNCmVsc2Ugew0KCQkvKiBPQyBwb3dlciBkb3duICovDQoJCXJ0
c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgRlBEQ1RMLCBPQ19QT1dFUl9ET1dOLA0KCQkJT0Nf
UE9XRVJfRE9XTik7DQp9DQpCZWNhdXNlIGluIG91ciBBLXNlcmllcyBjYXJkIFJlYWRlciB3ZSBh
bHJlYWR5IGFzc2lnbmVkIG9wdGlvbi0+b2NwX2VuIHRvIDEgaW4gc2VsZiBpbml0X3BhcmFtcygp
ICwgdGhpcyBpcyBhbiBlYXN5IHdheSB0byBmaXggdGhpcyBwcm9ibGVtDQoNCj4gPj4gSWYgeW91
IGFncmVlLCBJIGNhbiBwcmVwYXJlIGEgcGF0Y2ggYW5kIHNlbmQgaXQgdG8geW91LiBXaGF0ZXZl
ciB0aGUgc29sdXRpb24gaXMsDQo+IGl0DQo+ID4+IHdpbGwgYWxzbyBiZSBuZWVkZWQgaW4gdGhl
IHN0YWJsZQ0KPiA+PiBrZXJuZWxzIGxhdGVyIHRoYW4gNS4wLg0KPiA+Pg0KPiA+DQo+ID4gT0ss
IEkgYWdyZWUgeW91ciBvcGluaW9uLCBmb3Igbm93IGNhbiBvbmx5IHBhdGNoIHJ0czUyMjkgZmly
c3QgbWFrZSBOVUM2IHVzZXINCj4gY2FuIHdvcmsgd2VsbA0KPiA+DQo+ID4gVGhhbmsgeW91DQo+
ID4NCj4gPj4gQ2hyaXMNCj4gPj4+PiBncmVnIGstaA0KPiA+Pj4+DQo+ID4+Pj4gLS0tLS0tUGxl
YXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwu
DQo=

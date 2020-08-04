Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFFF206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgHDKsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:48:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49747 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgHDKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:48:19 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 074AkxMO3015886, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 074AkxMO3015886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 4 Aug 2020 18:46:59 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 18:46:59 +0800
Received: from RTEXDAG01.realtek.com.tw ([fe80::a03a:1dc9:e464:2473]) by
 RTEXDAG01.realtek.com.tw ([fe80::a03a:1dc9:e464:2473%3]) with mapi id
 15.01.1779.005; Tue, 4 Aug 2020 18:46:59 +0800
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
Thread-Index: AQHWaQXnJbf1udfgtku7UiOjY+d5jakktnGAgAKFU9D//9NfgIAAiHfA//+I7ICAAKENcA==
Date:   Tue, 4 Aug 2020 10:46:58 +0000
Message-ID: <19de15c2f07d447dace6bea483d38159@realtek.com>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
 <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
In-Reply-To: <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpcyBDbGF5dG9uIFttYWls
dG86Y2hyaXMyNTUzQGdvb2dsZW1haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMDQs
IDIwMjAgNDo1MSBQTQ0KPiBUbzog5ZCz5piK5r6EIFJpY2t5OyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZw0KPiBDYzogTEtNTDsgcmR1bmxhcEBpbmZyYWRlYWQub3JnOyBwaGlscXVhZHJhQGdt
YWlsLmNvbTsgQXJuZCBCZXJnbWFubg0KPiBTdWJqZWN0OiBSZTogUEFUQ0g6IHJ0c3hfcGNpIGRy
aXZlciAtIGRvbid0IGRpc2FibGUgdGhlIHJ0czUyMjkgY2FyZCByZWFkZXIgb24NCj4gSW50ZWwg
TlVDIGJveGVzDQo+IA0KPiANCj4gDQo+IE9uIDA0LzA4LzIwMjAgMDk6MDgsIOWQs+aYiua+hCBS
aWNreSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTog
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgW21haWx0bzpncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZ10NCj4gPj4gU2VudDogVHVlc2RheSwgQXVndXN0IDA0LCAyMDIwIDM6NDkgUE0NCj4gPj4g
VG86IOWQs+aYiua+hCBSaWNreQ0KPiA+PiBDYzogQ2hyaXMgQ2xheXRvbjsgTEtNTDsgcmR1bmxh
cEBpbmZyYWRlYWQub3JnOyBwaGlscXVhZHJhQGdtYWlsLmNvbTsNCj4gQXJuZA0KPiA+PiBCZXJn
bWFubg0KPiA+PiBTdWJqZWN0OiBSZTogUEFUQ0g6IHJ0c3hfcGNpIGRyaXZlciAtIGRvbid0IGRp
c2FibGUgdGhlIHJ0czUyMjkgY2FyZCByZWFkZXIgb24NCj4gPj4gSW50ZWwgTlVDIGJveGVzDQo+
ID4+DQo+ID4+IE9uIFR1ZSwgQXVnIDA0LCAyMDIwIGF0IDAyOjQ0OjQxQU0gKzAwMDAsIOWQs+aY
iua+hCBSaWNreSB3cm90ZToNCj4gPj4+IEhpIENocmlzLA0KPiA+Pj4NCj4gPj4+IHJ0c3hfcGNp
X3dyaXRlX3JlZ2lzdGVyKHBjciwgRlBEVEwsIE9DX1BPV0VSX0RPV04sDQo+IE9DX1BPV0VSX0RP
V04pOw0KPiA+Pj4gVGhpcyByZWdpc3RlciBvcGVyYXRpb24gc2F2ZWQgcG93ZXIgdW5kZXIgMW1B
LCBzbyBpZiBkbyBub3QgY2FyZSB0aGUgMW1BDQo+ID4+IHBvd2VyIHdlIGNhbiBoYXZlIGEgcGF0
Y2ggdG8gcmVtb3ZlIGl0LCBtYWtlIGNvbXBhdGlibGUgd2l0aCBOVUM2DQo+ID4+PiBXZSB0ZXN0
ZWQgb3RoZXJzIG91ciBjYXJkIHJlYWRlciB0aGF0IHJlbW92ZSBpdCwgd2UgZGlkIG5vdCBzZWUg
YW55IHNpZGUNCj4gZWZmZWN0DQo+ID4+Pg0KPiA+Pj4gSGkgR3JlZyBrLWgsDQo+ID4+Pg0KPiA+
Pj4gRG8geW91IGhhdmUgYW55IGNvbW1lbnRzPw0KPiA+Pg0KPiA+PiBjb21tZW50cyBvbiB3aGF0
PyAgSSBkb24ndCBrbm93IHdoYXQgeW91IGFyZSByZXNwb25kaW5nIHRvIGhlcmUsIHNvcnJ5Lg0K
PiA+Pg0KPiA+IENhbiB3ZSBoYXZlIGEgcGF0Y2ggdG8ga2VybmVsIGZvciBOVUM2PyBJdCBtYXkg
Y2F1c2UgbW9yZSBwb3dlcigxbUEpIGJ1dCBpdA0KPiB3aWxsIGhhdmUgbW9yZSBjb21wYXRpYmls
aXR5DQo+ID4NCj4gDQo+IFJpY2t5LA0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3Ug
d2FudCB0byBjb21wbGV0ZWx5IHJlbW92ZSB0aGUgY29kZSB0aGF0IHNldHMgdXAgdGhlDQo+IDFt
QSBwb3dlciBzYXZpbmcuIFRoYXQgY29kZSB3YXMgdGhlcmUNCj4gZXZlbiBiZWZvcmUgeW91ciBw
YXRjaCAoYmVkZTAzYTU3OWIzYjRhMDM2MDAzYzQ4NjJjYzFiYWE0ZGRjMzUxZiksIHNvIEkNCj4g
YXNzdW1lIGl0IGJlbmVmaXRzIHNvbWUgb2YgdGhlIFJlYWx0ZWsgY2FyZA0KPiByZWFkZXJzLiBC
ZWZvcmUgeW91ciBwYXRjaCBob3dldmVyLCBydHN4X3BjaV9pbml0X29jcCgpIHdhcyBub3QgY2Fs
bGVkIGZvciB0aGUNCj4gcnRzNTIyOSByZWFkZXIsIGJ1dCB0aGUgcGF0Y2ggaW50cm9kdWNlZA0K
PiBhbiB1bmNvbmRpdGlvbmFsIGNhbGwgdG8gdGhhdCBmdW5jdGlvbiBpbnRvIHJ0c3hfcGNpX2lu
aXRfaHcoKSwgd2hpY2ggaXMgcnVuIGZvciB0aGUNCj4gcnRzNTIyOS4gVGhhdCBpcyB3aGF0IG5v
dyBkaXNhYmxlcw0KPiB0aGUgY2FyZCByZWFkZXIuDQo+IA0KPiBOb3csIEkgZG9uJ3Qga25vdyB3
aGV0aGVyIG90aGVyIGNhcmRzIGFyZSBhZmZlY3RlZCwgYWx0aG91Z2ggSSBkb24ndCByZWNhbGwN
Cj4gc2VlaW5nIGFueSByZXBvcnRlZCBhcyBJIHNlYXJjaGVkIHRoZSBrZXJuZWwNCj4gYW5kIHVi
dW50dSBidWd6aWxsYXMgZm9yIGFueSBhbmFseXNpcyBvZiB0aGUgcHJvYmxlbS4gSSBrbm93IHRo
aXMgaXMgbm90IHdoYXQgdGhlDQo+IHBhdGNoIEkgc2VudCBkb2VzLCBidXQgaGF2aW5nIHRob3Vn
aHQNCj4gYWJvdXQgaXQgbW9yZSwgc2VlbXMgdG8gbWUgdGhhdCB0aGUgc2ltcGxlc3QgZml4IGlz
IHRvIHNraXAgdGhlIG5ldyBjYWxsIHRvDQo+IHJ0c3hfcGNpX2luaXRfb2NwKCkgaWYgdGhlIHJl
YWRlciBpcyBhbiBydHM1MjI5Lg0KPg0KDQpCZWNhdXNlIHdlIGFyZSB0aGlua2luZyBhYm91dCBp
ZiBvdGhlcnMgb3VyIGNhcmQgcmVhZGVyIHRoYXQgbm90IGJlbG9uZyBBIHNlcmllcyhteSBvY3Ag
cGF0Y2ggY292ZXJhZ2UpIGFsc28gb24gTlVDNiBwbGF0Zm9ybSBtYXliZSBoYXZlIHRoZSBzYW1l
IHByb2JsZW0uLi4gDQogDQo+IElmIHlvdSBhZ3JlZSwgSSBjYW4gcHJlcGFyZSBhIHBhdGNoIGFu
ZCBzZW5kIGl0IHRvIHlvdS4gV2hhdGV2ZXIgdGhlIHNvbHV0aW9uIGlzLCBpdA0KPiB3aWxsIGFs
c28gYmUgbmVlZGVkIGluIHRoZSBzdGFibGUNCj4ga2VybmVscyBsYXRlciB0aGFuIDUuMC4NCj4g
DQoNCk9LLCBJIGFncmVlIHlvdXIgb3BpbmlvbiwgZm9yIG5vdyBjYW4gb25seSBwYXRjaCBydHM1
MjI5IGZpcnN0IG1ha2UgTlVDNiB1c2VyIGNhbiB3b3JrIHdlbGwNCg0KVGhhbmsgeW91IA0KDQo+
IENocmlzDQo+ID4+IGdyZWcgay1oDQo+ID4+DQo+ID4+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0
aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K

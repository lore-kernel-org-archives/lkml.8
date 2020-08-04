Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2175F20786
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgHDCpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:45:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42194 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgHDCpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:45:06 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0742iguX7030284, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0742iguX7030284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 4 Aug 2020 10:44:42 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 10:44:42 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 10:44:42 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Tue, 4 Aug 2020 10:44:42 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: RE: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on Intel NUC boxes
Thread-Topic: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
 on Intel NUC boxes
Thread-Index: AQHWaQXnJbf1udfgtku7UiOjY+d5jakktnGAgAKFU9A=
Date:   Tue, 4 Aug 2020 02:44:41 +0000
Message-ID: <5729c72bbc2740d3917619c85e2fde58@realtek.com>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
In-Reply-To: <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
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

SGkgQ2hyaXMsDQoNCnJ0c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgRlBEVEwsIE9DX1BPV0VS
X0RPV04sIE9DX1BPV0VSX0RPV04pOw0KVGhpcyByZWdpc3RlciBvcGVyYXRpb24gc2F2ZWQgcG93
ZXIgdW5kZXIgMW1BLCBzbyBpZiBkbyBub3QgY2FyZSB0aGUgMW1BIHBvd2VyIHdlIGNhbiBoYXZl
IGEgcGF0Y2ggdG8gcmVtb3ZlIGl0LCBtYWtlIGNvbXBhdGlibGUgd2l0aCBOVUM2DQpXZSB0ZXN0
ZWQgb3RoZXJzIG91ciBjYXJkIHJlYWRlciB0aGF0IHJlbW92ZSBpdCwgd2UgZGlkIG5vdCBzZWUg
YW55IHNpZGUgZWZmZWN0IA0KDQpIaSBHcmVnIGstaCwNCg0KRG8geW91IGhhdmUgYW55IGNvbW1l
bnRzPyANCg0KdGhhbmtzDQoNClJpY2t5DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IENocmlzIENsYXl0b24gW21haWx0bzpjaHJpczI1NTNAZ29vZ2xlbWFpbC5jb21dDQo+
IFNlbnQ6IE1vbmRheSwgQXVndXN0IDAzLCAyMDIwIDM6NTkgQU0NCj4gVG86IExLTUw7IOWQs+aY
iua+hCBSaWNreTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZzsNCj4gcGhpbHF1YWRyYUBnbWFpbC5jb207IEFybmQgQmVyZ21hbm4NCj4gU3ViamVjdDog
UmU6IFBBVENIOiBydHN4X3BjaSBkcml2ZXIgLSBkb24ndCBkaXNhYmxlIHRoZSBydHM1MjI5IGNh
cmQgcmVhZGVyIG9uDQo+IEludGVsIE5VQyBib3hlcw0KPiANCj4gU29ycnksIEkgc2hvdWxkIGhh
dmUgc2FpZCB0aGF0IHRoZSBwYXRjaCBpcyBhZ2FpbnN0IDUuNy4xMi4gSXQgYXBwbGllcyB0byB1
cHN0cmVhbSwNCj4gYnV0IHdpdGggb2Zmc2V0cy4NCj4gDQo+IE9uIDAyLzA4LzIwMjAgMjA6NDgs
IENocmlzIENsYXl0b24gd3JvdGU6DQo+ID4gYmVkZTAzYTU3OWIzIGludHJvZHVjZWQgYSBidWcg
d2hpY2ggbGVhdmVzIHRoZSBydHM1MjI5IFBDSSBFeHByZXNzIGNhcmQNCj4gcmVhZGVyIG9uIG15
IEludGVsIE5VQzZDQVlIIGJveC4NCj4gPg0KPiA+IFRoZSBidWcgaXMgaW4gZHJpdmVycy9taXNj
L2NhcmRyZWFkZXIvcnRzeF9wY3IuYy4gQSBjYWxsIHRvIHJ0c3hfcGNpX2luaXRfb2NwKCkNCj4g
d2FzIGFkZGVkIHRvIHJ0c3hfcGNpX2luaXRfaHcoKS4NCj4gPiBBdCB0aGUgY2FsbCBwb2ludCwg
cGNyLT5vcHMtPmluaXRfb2NwIGlzIE5VTEwgYW5kIHBjci0+b3B0aW9uLm9jcF9lbiBpcyAwLCBz
byBpbg0KPiBydHN4X3BjaV9pbml0X29jcCgpIHRoZSBjYXJkcmVhZGVyDQo+ID4gZ2V0cyBkaXNh
YmxlZC4NCj4gPg0KPiA+IEkndmUgYXZvaWRlZCB0aGlzIGJ5IG1ha2luZyBleGN1dGlvbiBjb2Rl
IHRoYXQgcmVzdWx0cyBpbiB0aGUgcmVhZGVyIGJlaW5nDQo+IGRpc2FibGVkIGNvbmRpdGlvbmFs
IG9uIHRoZSBkZXZpY2UNCj4gPiBub3QgYmVpbmcgYW4gUlRTNTIyOS4gT2YgY291cnNlLCBvdGhl
ciBydHN4eHggY2FyZCByZWFkZXJzIG1heSBhbHNvIGJlDQo+IGRpc2FibGVkIGJ5IHRoaXMgYnVn
LiBJIGRvbid0IGhhdmUgdGhlDQo+ID4ga25vd2xlZGdlIHRvIGFkZHJlc3MgdGhhdCwgc28gSSds
bCBsZWF2ZSB0byB0aGUgZHJpdmVyIG1haW50YWluZXJzLg0KPiA+DQo+ID4gVGhlIHBhdGNoIHRv
IGF2b2lkIHRoZSBidWcgaXMgYXR0YWNoZWQuDQo+ID4NCj4gPiBGaXhlczogYmVkZTAzYTU3OWIz
ICgibWlzYzogcnRzeDogRW5hYmxlIE9DUCBmb3IgcnRzNTIyYSBydHM1MjRhIHJ0czUyNWENCj4g
cnRzNTI2MCIpDQo+ID4gTGluazogaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgta2VybmVsJm09
MTU5MTA1OTEyODMyMjU3DQo+ID4gTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMDQwMDMNCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBDbGF5dG9uIDxj
aHJpczI1NTNAZ29vZ2xlbWFpbC5jb20+DQo+ID4NCj4gPiBiZWRlMDNhNTc5YjMgaW50cm9kdWNl
ZCBhIGJ1ZyB3aGljaCBsZWF2ZXMgdGhlIHJ0czUyMjkgUENJIEV4cHJlc3MgY2FyZA0KPiByZWFk
ZXIgb24gbXkgSW50ZWwgTlVDNkNBWUggYm94Lg0KPiA+DQo+ID4gVGhlIGJ1ZyBpcyBpbiBkcml2
ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3Bjci5jLiBBIGNhbGwgdG8gcnRzeF9wY2lfaW5pdF9v
Y3AoKQ0KPiB3YXMgYWRkZWQgdG8gcnRzeF9wY2lfaW5pdF9odygpLg0KPiA+IEF0IHRoZSBjYWxs
IHBvaW50LCBwY3ItPm9wcy0+aW5pdF9vY3AgaXMgTlVMTCBhbmQgcGNyLT5vcHRpb24ub2NwX2Vu
IGlzIDAsIHNvIGluDQo+IHJ0c3hfcGNpX2luaXRfb2NwKCkgdGhlIGNhcmRyZWFkZXINCj4gPiBn
ZXRzIGRpc2FibGVkLg0KPiA+DQo+ID4gSSd2ZSBhdm9pZGVkIHRoaXMgYnkgbWFraW5nIGV4Y3V0
aW9uIGNvZGUgdGhhdCByZXN1bHRzIGluIHRoZSByZWFkZXIgYmVpbmcNCj4gZGlzYWJsZWQgY29u
ZGl0aW9uYWwgb24gdGhlIGRldmljZQ0KPiA+IG5vdCBiZWluZyBhbiBSVFM1MjI5LiBPZiBjb3Vy
c2UsIG90aGVyIHJ0c3h4eCBjYXJkIHJlYWRlcnMgbWF5IGFsc28gYmUNCj4gZGlzYWJsZWQgYnkg
dGhpcyBidWcuIEkgZG9uJ3QgaGF2ZSB0aGUNCj4gPiBrbm93bGVkZ2UgdG8gYWRkcmVzcyB0aGF0
LCBzbyBJJ2xsIGxlYXZlIHRvIHRoZSBkcml2ZXIgbWFpbnRhaW5lcnMuDQo+ID4NCj4gPiBUaGUg
cGF0Y2ggdG8gYXZvaWQgdGhlIGJ1ZyBpcyBhdHRhY2hlZC4NCj4gPg0KPiA+IENocmlzDQo+ID4N
Cj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50
aW5nIHRoaXMgZS1tYWlsLg0K

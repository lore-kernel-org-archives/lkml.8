Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2ED206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHCDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:02:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57845 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHCDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:02:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07331uxB6017172, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07331uxB6017172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 3 Aug 2020 11:01:56 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Aug 2020 11:01:56 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Aug 2020 11:01:56 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Mon, 3 Aug 2020 11:01:56 +0800
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
Thread-Index: AQHWaQXnJbf1udfgtku7UiOjY+d5jakktnGAgAD4T5A=
Date:   Mon, 3 Aug 2020 03:01:55 +0000
Message-ID: <7c3f6a03f8cc4cb1ac69ec7322fba3d3@realtek.com>
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

SGkgQ2hyaXPvvIwNCg0KV2UgZG9u4oCZdCB0aGluayB0aGlzIGlzIG91ciBidWcuLi4NClRoaXMg
cmVnaXN0ZXIoRlBEQ1RMKSB3cml0ZSB0byBPQ19QT1dFUl9ET1dOIGlzIGZvciBvdXIgcG93ZXIg
c2F2aW5nIGZlYXR1cmUsIG5vdCB0byBkaXNhYmxlIHRoZSByZWFkZXINCkluIHlvdXIgY2FzZSwg
d2UgY2Fubm90IHJlcHJvZHVjZSB0aGlzIG9uIG91ciBzaWRlIHRoYXQgd2UgbWVudGlvbiBiZWZv
cmUsIHdlIGRvbuKAmXQgaGF2ZSB0aGUgcGxhdGZvcm0oSW50ZWwgTlVDIFRhbGwgQXJjaGVzIENh
bnlvbiBOVUM2Q0FZSCBDZWxlcm9uIEozNDUpIHRvIHNlZSB0aGlzIGlzc3VlDQpCdXQgd2UgdGhp
bmsgdGhpcyBpc3N1ZSBtYXliZSBvbmx5IG9uIHRoaXMgcGxhdGZvcm0sIG91ciBSVFM1MjI5IHdv
cmtzIHdlbGwgb24gdGhlIG5ldyBrZXJuZWwgYWxsIHBsYXRmb3JtIHRoYXQgd2UgaGF2ZSAgDQoN
ClJpY2t5ICAgIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlz
IENsYXl0b24gW21haWx0bzpjaHJpczI1NTNAZ29vZ2xlbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRh
eSwgQXVndXN0IDAzLCAyMDIwIDM6NTkgQU0NCj4gVG86IExLTUw7IOWQs+aYiua+hCBSaWNreTsg
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gcGhp
bHF1YWRyYUBnbWFpbC5jb207IEFybmQgQmVyZ21hbm4NCj4gU3ViamVjdDogUmU6IFBBVENIOiBy
dHN4X3BjaSBkcml2ZXIgLSBkb24ndCBkaXNhYmxlIHRoZSBydHM1MjI5IGNhcmQgcmVhZGVyIG9u
DQo+IEludGVsIE5VQyBib3hlcw0KPiANCj4gU29ycnksIEkgc2hvdWxkIGhhdmUgc2FpZCB0aGF0
IHRoZSBwYXRjaCBpcyBhZ2FpbnN0IDUuNy4xMi4gSXQgYXBwbGllcyB0byB1cHN0cmVhbSwNCj4g
YnV0IHdpdGggb2Zmc2V0cy4NCj4gDQo+IE9uIDAyLzA4LzIwMjAgMjA6NDgsIENocmlzIENsYXl0
b24gd3JvdGU6DQo+ID4gYmVkZTAzYTU3OWIzIGludHJvZHVjZWQgYSBidWcgd2hpY2ggbGVhdmVz
IHRoZSBydHM1MjI5IFBDSSBFeHByZXNzIGNhcmQNCj4gcmVhZGVyIG9uIG15IEludGVsIE5VQzZD
QVlIIGJveC4NCj4gPg0KPiA+IFRoZSBidWcgaXMgaW4gZHJpdmVycy9taXNjL2NhcmRyZWFkZXIv
cnRzeF9wY3IuYy4gQSBjYWxsIHRvIHJ0c3hfcGNpX2luaXRfb2NwKCkNCj4gd2FzIGFkZGVkIHRv
IHJ0c3hfcGNpX2luaXRfaHcoKS4NCj4gPiBBdCB0aGUgY2FsbCBwb2ludCwgcGNyLT5vcHMtPmlu
aXRfb2NwIGlzIE5VTEwgYW5kIHBjci0+b3B0aW9uLm9jcF9lbiBpcyAwLCBzbyBpbg0KPiBydHN4
X3BjaV9pbml0X29jcCgpIHRoZSBjYXJkcmVhZGVyDQo+ID4gZ2V0cyBkaXNhYmxlZC4NCj4gPg0K
PiA+IEkndmUgYXZvaWRlZCB0aGlzIGJ5IG1ha2luZyBleGN1dGlvbiBjb2RlIHRoYXQgcmVzdWx0
cyBpbiB0aGUgcmVhZGVyIGJlaW5nDQo+IGRpc2FibGVkIGNvbmRpdGlvbmFsIG9uIHRoZSBkZXZp
Y2UNCj4gPiBub3QgYmVpbmcgYW4gUlRTNTIyOS4gT2YgY291cnNlLCBvdGhlciBydHN4eHggY2Fy
ZCByZWFkZXJzIG1heSBhbHNvIGJlDQo+IGRpc2FibGVkIGJ5IHRoaXMgYnVnLiBJIGRvbid0IGhh
dmUgdGhlDQo+ID4ga25vd2xlZGdlIHRvIGFkZHJlc3MgdGhhdCwgc28gSSdsbCBsZWF2ZSB0byB0
aGUgZHJpdmVyIG1haW50YWluZXJzLg0KPiA+DQo+ID4gVGhlIHBhdGNoIHRvIGF2b2lkIHRoZSBi
dWcgaXMgYXR0YWNoZWQuDQo+ID4NCj4gPiBGaXhlczogYmVkZTAzYTU3OWIzICgibWlzYzogcnRz
eDogRW5hYmxlIE9DUCBmb3IgcnRzNTIyYSBydHM1MjRhIHJ0czUyNWENCj4gcnRzNTI2MCIpDQo+
ID4gTGluazogaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgta2VybmVsJm09MTU5MTA1OTEyODMy
MjU3DQo+ID4gTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMDQwMDMNCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBDbGF5dG9uIDxjaHJpczI1NTNAZ29v
Z2xlbWFpbC5jb20+DQo+ID4NCj4gPiBiZWRlMDNhNTc5YjMgaW50cm9kdWNlZCBhIGJ1ZyB3aGlj
aCBsZWF2ZXMgdGhlIHJ0czUyMjkgUENJIEV4cHJlc3MgY2FyZA0KPiByZWFkZXIgb24gbXkgSW50
ZWwgTlVDNkNBWUggYm94Lg0KPiA+DQo+ID4gVGhlIGJ1ZyBpcyBpbiBkcml2ZXJzL21pc2MvY2Fy
ZHJlYWRlci9ydHN4X3Bjci5jLiBBIGNhbGwgdG8gcnRzeF9wY2lfaW5pdF9vY3AoKQ0KPiB3YXMg
YWRkZWQgdG8gcnRzeF9wY2lfaW5pdF9odygpLg0KPiA+IEF0IHRoZSBjYWxsIHBvaW50LCBwY3It
Pm9wcy0+aW5pdF9vY3AgaXMgTlVMTCBhbmQgcGNyLT5vcHRpb24ub2NwX2VuIGlzIDAsIHNvIGlu
DQo+IHJ0c3hfcGNpX2luaXRfb2NwKCkgdGhlIGNhcmRyZWFkZXINCj4gPiBnZXRzIGRpc2FibGVk
Lg0KPiA+DQo+ID4gSSd2ZSBhdm9pZGVkIHRoaXMgYnkgbWFraW5nIGV4Y3V0aW9uIGNvZGUgdGhh
dCByZXN1bHRzIGluIHRoZSByZWFkZXIgYmVpbmcNCj4gZGlzYWJsZWQgY29uZGl0aW9uYWwgb24g
dGhlIGRldmljZQ0KPiA+IG5vdCBiZWluZyBhbiBSVFM1MjI5LiBPZiBjb3Vyc2UsIG90aGVyIHJ0
c3h4eCBjYXJkIHJlYWRlcnMgbWF5IGFsc28gYmUNCj4gZGlzYWJsZWQgYnkgdGhpcyBidWcuIEkg
ZG9uJ3QgaGF2ZSB0aGUNCj4gPiBrbm93bGVkZ2UgdG8gYWRkcmVzcyB0aGF0LCBzbyBJJ2xsIGxl
YXZlIHRvIHRoZSBkcml2ZXIgbWFpbnRhaW5lcnMuDQo+ID4NCj4gPiBUaGUgcGF0Y2ggdG8gYXZv
aWQgdGhlIGJ1ZyBpcyBhdHRhY2hlZC4NCj4gPg0KPiA+IENocmlzDQo+ID4NCj4gDQo+IC0tLS0t
LVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1t
YWlsLg0K

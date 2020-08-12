Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E78C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB7320838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgHLJsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:48:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45415 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbgHLJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:48:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-88-BXravPHFN-CLpwv5q6iGKw-1; Wed, 12 Aug 2020 10:48:48 +0100
X-MC-Unique: BXravPHFN-CLpwv5q6iGKw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 12 Aug 2020 10:48:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 12 Aug 2020 10:48:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miles Chen' <miles.chen@mediatek.com>
CC:     'Christoph Hellwig' <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [PATCH] net: untag pointer in sockptr_is_kernel
Thread-Topic: [PATCH] net: untag pointer in sockptr_is_kernel
Thread-Index: AQHWb9DKxxLX2AshVECOBLD3J//Za6kyxXFQgAFcawCAABZWMA==
Date:   Wed, 12 Aug 2020 09:48:48 +0000
Message-ID: <df130026160145f1abc1cbd63f11e8d3@AcuMS.aculab.com>
References: <20200811102704.17875-1-miles.chen@mediatek.com>
         <20200811111551.GA3958@lst.de>
         <36e381c558e24185bc2f7e80a758d06a@AcuMS.aculab.com>
 <1597223732.5467.10.camel@mtkswgap22>
In-Reply-To: <1597223732.5467.10.camel@mtkswgap22>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+IFNlbnQ6IDEyIEF1
Z3VzdCAyMDIwIDEwOjE2DQo+IA0KPiBPbiBUdWUsIDIwMjAtMDgtMTEgYXQgMTE6NDQgKzAwMDAs
IERhdmlkIExhaWdodCB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXVnIDExLCAyMDIwIGF0IDA2OjI3
OjA0UE0gKzA4MDAsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gPiA+IEZyb206IE1pbGVzIENoZW4g
PG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBzb2NrcHRyX2lzX2tl
cm5lbCgpIHVzZXMgKHNvY2twdHIua2VybmVsID49IFRBU0tfU0laRSkgdG8gdGVsbA0KPiA+ID4g
PiBpZiB0aGUgcG9pbnRlciBpcyBrZXJuZWwgc3BhY2Ugb3IgdXNlciBzcGFjZS4gV2hlbiB1c2Vy
IHNwYWNlIHVzZXMNCj4gPiA+ID4gdGhlICJ0b3AgYnl0ZSBpZ25vcmVkIiBmZWF0dXJlIHN1Y2gg
YXMgSFdBc2FuLCB3ZSBtdXN0IHVudGFnDQo+ID4gPiA+IHRoZSBwb2ludGVyIGJlZm9yZSBjaGVj
a2luZyBhZ2FpbnN0IFRBU0tfU0laRS4NCj4gPiA+ID4NCj4gPiA+ID4gc29ja3B0cl9pc19rZXJu
ZWwoKSB3aWxsIHZpZXcgYSB0YWdnZWQgdXNlciBwb2ludGVyIGFzIGEga2VybmVsIHBvaW50ZXIN
Cj4gPiA+ID4gYW5kIHVzZSBtZW1jcHkgZGlyZWN0bHkgYW5kIGNhdXNlcyBhIGtlcm5lbCBjcmFz
aC4NCj4gPiA+DQo+ID4gPiBEYXZlIG1lcmdlZCBhIHBhdGNoIGZyb20gbWUgdG8gcmV2ZXIgdGhl
IG9wdGltaXplZCBzb2NrcHRyDQo+ID4gPiBpbXBsZW1lbnRhdGlvbiBmb3Igbm93LiAgSWYgd2Ug
YnJpbmcgaXQgYmFjayB3ZSBzaG91bGQgZm9sZCBpbiB5b3VyDQo+ID4gPiBmaXguDQo+ID4NCj4g
PiBJIG1pc3NlZCB0aGF0IGdvaW5nIHRob3VnaCA6LSgNCj4gPiBJJ3ZlIGxvb2tlZCBmb3IgYSBm
aXggdG8gdGhlIGFjY2Vzc19vayhrZXJuZWxfYWRkciwwKSBiZWluZyB0cnVlIGlzc3VlLg0KPiA+
DQo+ID4gU2hvdWxkbid0IFRBU0tfU0laRSBiZSBpbmNyZWFzZWQgdG8gY292ZXIgYWxsIHRoZSAn
dGFnZ2VkJyBhZGRyZXNzZXM/DQo+ID4gSVNUUiB0aGUgJ3RhZycgYml0cyBhcmUgdGhlICduZXh0
JyA4IChvciBzbykgYWRkcmVzcyBiaXRzIGF0IHRoZSB0b3ANCj4gPiBvZiB2YWxpZCB1c2VyIGFk
ZHJlc3Nlcy4NCj4gDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBhIGdvb2QgaWRlYS4g
VEFTS19TSVpFIGlzIGFuIGFyY2ggZGVwZW5kZW50DQo+IGNvbnN0YW50LCBpZiB3ZSBpbmNyZWFz
ZSBUQVNLX1NJWkUgdG8gY292ZXIgdGhlICd0YWdnZWQnIGFkZHJlc3Mgc3BhY2UsDQo+IHRoZSBU
QVNLX1NJWkUgd2lsbCBub3QgdGVsbCB1cyB0aGUgYWN0dWFsIHZpcnR1YWwgYWRkcmVzcyBzaXpl
Lg0KPiANCj4gTWF5YmUgd2UgbmVlZCBhIG1hY3JvIHRvIHRlbGwgaWYgYSBwb2ludGVyIGlzIGlu
IHVzZXIgc3BhY2Ugb3Igbm90IGFuZA0KPiBoYW5kbGUgdGhlIG1lbW9yeSB0YWcgdGhlcmUuDQo+
IEJ1dCB0aGlzIG9ubHkgd29ya3MgZm9yIHRoZSAiaXMgdGhpcyBwb2ludGVyIGluIHVzZXIgc3Bh
Y2UiIHByb2JsZW0uDQoNCldlbGwgVEFTS19TSVpFIGlzbid0IGEgY29uc3RhbnQsIGl0IGlzIHJl
YWQgb3V0IG9mICdjdXJyZW50Jy4NClR5cGljYWxseSBpdCBpc24ndCBldmVuIHRoZSBsaW1pdCBv
biB0aGUgYWRkcmVzcyBzcGFjZSBzaW5jZQ0KKGF0IGxlYXN0IGluIHg4NikgaXQgaXMgY2hhbmdl
ZCBieSBzZXRmcyhLRVJORUxfRFMpIHNvIHRoYXQNCmFjY2Vzc19vaygpIGRvZXNuJ3QgcmVqZWN0
IGtlcm5lbCBhZGRyZXNzZXMuDQoNCkl0IGlzIGFsbW9zdCBhcyBpZiBUQVNLX1NJWkUgaXMgb25s
eSBhY3R1YWxseSB2YWxpZCBmb3IgdGhlDQpjaGVjayBpbiBhY2Nlc3Nfb2soKS4NCg0KSSdkIGFs
c28gaGF2ZSB0aG91Z2h0IHlvdSdkIHdhbnQgdGhlIGtlcm5lbCB0byB1c2UgdGhlICd0YWdnZWQn
DQphZGRyZXNzIHNvIHRoYXQgdGhlIGhhcmR3YXJlIGNoZWNrcyBpdCBtYXRjaGVzLg0KT3IgaXMg
dGhlcmUgc29tZSBzY2hlbWUgZm9yIGhhdmluZyB1c2VycGFjZSB1c2UgdGFnZ2VkIHBvaW50ZXJz
DQp3aXRob3V0IGhhcmR3YXJlIHN1cHBvcnQgLSBidXQgd291bGRuJ3QgdGhhdCByZXF1aXJlIG1h
c2tpbmcNCmFuZC9vciBsYXJnZSBvZmZzZXRzIGFsbCBvdmVyIHRoZSB1c2VyIGNvZGU/DQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=


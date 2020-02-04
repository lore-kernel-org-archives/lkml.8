Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF10C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFB120674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hXqPnBzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBDUD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:03:27 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55549 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBDUD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:03:27 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B831C891AA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Feb 2020 09:03:23 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580846603;
        bh=ig26wSjIaU+XQ4VrZdi08DwIHGWzCr7Ln2xYk19JyBc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=hXqPnBzS78/cyp7Bm0L7C2CnnI4uoLZupfSzl/Ws+SX0C4CtROaMVfIXOTa5hl9lf
         VHQ25G52iqp7iArZdCwxdamReubHFtQJTttpCRyapF6HNxO67P2gIxNu9oulk2au+f
         bUKMzDxUDAsm5ApWJHmpenY4n2seXpH53euL6ljT4xJxNeD5sFopfWEGaCdWYzpvnL
         DU8aM+7lOCKoP7H9R8ekrgGXsxHDpZqjLwN87OIJGkfW0TeD/WkWdiN9O8tTAELtNt
         jYCN/6zKlw7b7kWwhOIdtvss+Wd00KPMNA8kIRGEAnh22l6uDiNdjM3m7IW0imZbpS
         qLtgH+3lv5J2Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e39ce0b0000>; Wed, 05 Feb 2020 09:03:23 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb 2020 09:03:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Wed, 5 Feb 2020 09:03:21 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>
Subject: Re: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Thread-Topic: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Thread-Index: AQHV2vWmtCtKfNrhHkKtpp3ao2yroKgJy8oAgADQpwA=
Date:   Tue, 4 Feb 2020 20:03:20 +0000
Message-ID: <bc1ea2ef91314143f3b63497ac31468d0468d4d5.camel@alliedtelesis.co.nz>
References: <20191202141836.9363-1-linux@roeck-us.net>
         <20191202165231.GA728202@kroah.com> <20191202173620.GA29323@roeck-us.net>
         <20191202181505.GA732872@kroah.com>
         <8168627a60e9e851860f8cc295498423828401c9.camel@alliedtelesis.co.nz>
         <20200204073632.GB1085438@kroah.com>
In-Reply-To: <20200204073632.GB1085438@kroah.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:f95d:4478:4d90:53fe]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7E6EE56FAF96A4984CDAED8000C5A1B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTA0IGF0IDA3OjM2ICswMDAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gVHVlLCBGZWIgMDQsIDIwMjAgYXQgMTI6NTQ6MjZBTSArMDAwMCwg
Q2hyaXMgUGFja2hhbSB3cm90ZToNCj4gPiBIaSBHcmVnICYgQWxsLA0KPiA+IA0KPiA+IE9uIE1v
biwgMjAxOS0xMi0wMiBhdCAxOToxNSArMDEwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0K
PiA+ID4gT24gTW9uLCBEZWMgMDIsIDIwMTkgYXQgMDk6MzY6MjBBTSAtMDgwMCwgR3VlbnRlciBS
b2VjayB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCBEZWMgMDIsIDIwMTkgYXQgMDU6NTI6MzFQTSAr
MDEwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgRGVjIDAy
LCAyMDE5IGF0IDA2OjE4OjM2QU0gLTA4MDAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+ID4gPiA+
ID4gPiBUaGUgY29kZSBkb2Vzbid0IGNvbXBpbGUgZHVlIHRvIGluY29tcGF0aWJsZSBwb2ludGVy
IGVycm9ycw0KPiA+ID4gPiA+ID4gc3VjaCBhcw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBk
cml2ZXJzL3N0YWdpbmcvb2N0ZW9uL2V0aGVybmV0LXR4LmM6NjQ5OjUwOiBlcnJvcjoNCj4gPiA+
ID4gPiA+IAlwYXNzaW5nIGFyZ3VtZW50IDEgb2YgJ2N2bXhfd3FlX2dldF9ncnAnIGZyb20NCj4g
PiA+ID4gPiA+IGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUNCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gVGhpcyBpcyBkdWUgdG8gbWl4aW5nLCBmb3IgZXhhbXBsZSwgY3ZteF93cWVfdCB3aXRo
ICdzdHJ1Y3QNCj4gPiA+ID4gPiA+IGN2bXhfd3FlJy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gVW5mb3J0dW5hdGVseSwgb25lIGNhbiBub3QganVzdCByZXZlcnQgdGhlIHByaW1hcnkgb2Zm
ZW5kaW5nDQo+ID4gPiA+ID4gPiBjb21taXQsIGFzIGRvaW5nIHNvDQo+ID4gPiA+ID4gPiByZXN1
bHRzIGluIHNlY29uZGFyeSBlcnJvcnMuIFRoaXMgaXMgbWFkZSB3b3JzZSBieSB0aGUgZmFjdA0K
PiA+ID4gPiA+ID4gdGhhdCB0aGUgInJlbW92ZWQiDQo+ID4gPiA+ID4gPiB0eXBlZGVmcyBzdGls
bCBleGlzdCBhbmQgYXJlIHVzZWQgd2lkZWx5IG91dHNpZGUgdGhlIHN0YWdpbmcNCj4gPiA+ID4g
PiA+IGRpcmVjdG9yeSwNCj4gPiA+ID4gPiA+IG1ha2luZyB0aGUgZW50aXJlIHNldCBvZiAicmVt
b3ZlIHR5cGVkZWYiIGNoYW5nZXMgcG9pbnRsZXNzIGFuZA0KPiA+ID4gPiA+ID4gd3JvbmcuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gVWdoLCBzb3JyeSBhYm91dCB0aGF0Lg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gUmVmbGVjdCByZWFsaXR5IGFuZCBtYXJrIHRoZSBkcml2ZXIgYXMgQlJPS0VO
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNob3VsZCBJIGp1c3QgZGVsZXRlIHRoaXMgdGhpbmc/
ICBObyBvbmUgc2VlbXMgdG8gYmUgdXNpbmcgaXQgYW5kDQo+ID4gPiA+ID4gdGhlcmUNCj4gPiA+
ID4gPiBpcyBubyBtb3ZlIHRvIGdldCBpdCBvdXQgb2Ygc3RhZ2luZyBhdCBhbGwuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gV2lsbCBhbnlvbmUgYWN0dWFsbHkgbWlzcyBpdD8gIEl0IGNhbiBhbHdh
eXMgY29tZSBiYWNrIG9mIHNvbWVvbmUNCj4gPiA+ID4gPiBkb2VzLi4uDQo+ID4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiBBbGwgaXQgZG9lcyBpcyBjYXVzaW5nIHRyb3VibGUgYW5kIG1pc2d1
aWRlZCBhdHRlbXB0cyB0byBjbGVhbiBpdA0KPiA+ID4gPiB1cC4NCj4gPiA+ID4gSWYgYW55dGhp
bmcsIHRoZSB3aG9sZSB0aGluZyBnb2VzIGludG8gdGhlIHdyb25nIGRpcmVjdGlvbiAoZGVjbGFy
ZQ0KPiA+ID4gPiBhDQo+ID4gPiA+IGNvbXBsZXRlIHNldCBvZiBkdW1teSBmdW5jdGlvbnMganVz
dCB0byBiZSBhYmxlIHRvIGJ1aWxkIHRoZSBkcml2ZXINCj4gPiA+ID4gd2l0aCBDT01QSUxFX1RF
U1QgPyBTZXJpb3VzbHkgPykuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHNlY29uZCB0aGUgbW90aW9u
IHRvIGRyb3AgaXQuIFRoaXMgaGFzIGJlZW4gaW4gc3RhZ2luZyBmb3IgMTANCj4gPiA+ID4geWVh
cnMuDQo+ID4gPiA+IERvbid0IHdlIGhhdmUgc29tZSBraW5kIG9mIHRpbWUgbGltaXQgZm9yIGNv
ZGUgaW4gc3RhZ2luZyA/IElmIG5vdCwNCj4gPiA+ID4gc2hvdWxkIHdlID8gSWYgYW55b25lIHJl
YWxseSBuZWVkcyBpdCwgdGhhdCBwZXJzb24gb3IgZ3JvdXAgc2hvdWxkDQo+ID4gPiA+IHJlYWxs
eSBpbnZlc3QgdGhlIHRpbWUgdG8gZ2V0IGl0IG91dCBvZiBzdGFnaW5nIGZvciBnb29kLg0KPiA+
ID4gDQo+ID4gPiAxMCB5ZWFycz8gIFVnaCwgeWVzLCBpdCdzIHRpbWUgdG8gZHJvcCB0aGUgdGhp
bmcsIEknbGwgZG8gc28gYWZ0ZXINCj4gPiA+IC1yYzENCj4gPiA+IGlzIG91dC4NCj4gPiA+IA0K
PiA+IA0KPiA+IEFzIGEgbG9uZyBzdWZmZXJpbmcgQ2F2aXVtIE1JUHMgY3VzdG9tZXIgY291bGQg
SSByZXF1ZXN0IHRoYXQgdGhpcw0KPiA+IGlzbid0IGRyb3BwZWQuIEknbGwgZ2V0IHNvbWVvbmUg
aGVyZSB0byB0YWtlIGEgbG9vayBhdCBmaXhpbmcgdGhlIGJ1aWxkDQo+ID4gaXNzdWVzLg0KPiA+
IA0KPiA+IEdpdmVuIG91ciBwbGF0Zm9ybSBpc24ndCB1cHN0cmVhbSBJJ20gbm90IHN1cmUgdGhh
dCB3ZSdsbCBiZSBhYmxlIHRvDQo+ID4gbWVldCB0aGUgY3JpdGVyaWEgZm9yIGdldHRpbmcgaXQg
b3V0IG9mIHN0YWdpbmcuDQo+ID4gDQo+IA0KPiBDYW4ndCB5b3UgcHVzaCB0aGlzIG9udG8gQ2F2
aXVtIGFzIHlvdSBhcmUgcGF5aW5nIHRoZW0gZm9yIGhhcmR3YXJlIGFuZA0KPiBzdXBwb3J0Pw0K
PiANCg0KSSdsbCBjZXJ0YWlubHkgcmFpc2UgdGhpcyB3aXRoIGFueSBhbmQgYWxsIGNvbnRhY3Rz
IEkgaGF2ZSB3aXRoDQpDYXZpdW0vTWFydmVsbC4NCg==

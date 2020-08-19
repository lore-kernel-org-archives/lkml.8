Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7026B20639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHSJUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:20:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33340 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgHSJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:19:58 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-_229ysE0OG6jw3ucHhB40g-1; Wed, 19 Aug 2020 10:19:53 +0100
X-MC-Unique: _229ysE0OG6jw3ucHhB40g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 19 Aug 2020 10:19:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 19 Aug 2020 10:19:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Daniel Gutson <daniel@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        "Richard Hughes" <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
Thread-Topic: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Thread-Index: AQHWdgQqCdINb+eDE0uGZC/C71DMN6k/JlWw
Date:   Wed, 19 Aug 2020 09:19:52 +0000
Message-ID: <c62f0828d1f6463cb156107c0b21e219@AcuMS.aculab.com>
References: <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com>
 <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxOSBBdWd1c3QgMjAyMCAwOTozOA0KLi4uDQo+
IElmIHlvdSBhcmUgcmVhbGx5IHdvcnJpZWQgYWJvdXQgdGhlIHdyaXRlIHByb3RlY3Rpb24gYmVp
bmcgYnlwYXNzZWQgYnkNCj4gYSBkaWZmZXJlbnQgZHJpdmVyIG9yIGNvZGUgaW5qZWN0aW9uLCB0
aGUgYmVzdCB3YXkgd291bGQgc2VlbSB0byBiZSB0bw0KPiBvbmx5IGVuYWJsZSB3cml0aW5nIGlu
IHRoZSBtdGQgd3JpdGUgY2FsbGJhY2sgYW5kIGRpc2FibGUgaXQgaW1tZWRpYXRlbHkNCj4gYWZ0
ZXIgdGhlIHdyaXRlIGlzIGNvbXBsZXRlLiBJIHN0aWxsIGRvbid0IHNlZSB3aHkgdGhpcyBoYXJk
d2FyZSB3b3VsZA0KPiBiZSBtb3JlIHN1c2NlcHRpYmxlIHRvIHRoaXMga2luZCBvZiBhdHRhY2sg
dGhhbiBvdGhlciBkcml2ZXJzIHRob3VnaCwNCj4gYXMgaXQgYWxyZWFkeSBoYXMgdGhlIHNhZmVn
dWFyZCBhZ2FpbnN0IHdyaXRpbmcgdGhyb3VnaCB0aGUgTVREIGxheWVyDQo+IHdpdGhvdXQgdGhl
IG1vZHVsZSBwYXJhbWV0ZXIuDQoNCkl0IGlzIHByZXR0eSB1bmxpa2VseSB0aGF0IGFueW9uZSB3
aWxsIGFjY2lkZW50YWxseSBkbyBhbiBzcGkgd3JpdGUNCihpdCBpcyBhbGwgdG9vIGNvbXBsaWNh
dGVkKS4NCkFueXRoaW5nIHRoYXQgaXMgYmVpbmcgbWlzY2hpZXZvdXMgY2FuIHNlbmQgdGhlIHdy
aXRlIGVuYWJsZQ0KY29tbWFuZCBpdHNlbGYuDQoNCklmIHlvdSBjYXJlIHlvdSBuZWVkIHRvIHVz
ZSB0aGUgZGV2aWNlIHBpbiB0byBkaXNhYmxlIHdyaXRlcy4NCg0KCURhdmlkDQogDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


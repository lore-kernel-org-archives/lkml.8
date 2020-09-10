Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7745C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06B920719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgIJVwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:52:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:39276 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgIJVt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:49:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-267-HYL6WVvkPS-KP8gHonLJJg-1; Thu, 10 Sep 2020 22:49:20 +0100
X-MC-Unique: HYL6WVvkPS-KP8gHonLJJg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Sep 2020 22:49:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Sep 2020 22:49:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
Thread-Topic: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
Thread-Index: AQHWh6dGqbQ7jRFJakCUCViQLEfKfKliaKAA
Date:   Thu, 10 Sep 2020 21:49:20 +0000
Message-ID: <a9d5b868b1eb4d8bb45364e9b917ca8f@AcuMS.aculab.com>
References: <20200904155808.4997-1-leon@kernel.org>
 <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
 <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
Accept-Language: en-GB, en-US
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
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTAgU2VwdGVtYmVyIDIwMjAgMjA6MTkNCj4g
DQo+IE9uIFRodSwgU2VwIDEwLCAyMDIwIGF0IDU6NTIgQU0gUGV0ZXIgT2JlcnBhcmxlaXRlcg0K
PiA8b2JlcnBhckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IHVw
ZGF0aW5nIHRoZSBpbi1rZXJuZWwgR0NPVl9DT1VOVEVSUyB2YWx1ZS4gQWxzbyByZS1lbmFibGUN
Cj4gPiBjb25maWcgR0NPVl9LRVJORUwgZm9yIHVzZSB3aXRoIEdDQyAxMC4NCj4gDQo+IExvdmVs
eS4NCj4gDQo+IElzIHRoZXJlIHNvbWUgd2F5IHdlIGNvdWxkIHNlZSB0aGlzIHZhbHVlIGF1dG9t
YXRpY2FsbHksIG9yIGF0IGxlYXN0DQo+IGhhdmUgYSBjaGVjayBmb3IgaXQ/IFJpZ2h0IG5vdyBp
dCdzIHRoYXQgX3ZlcnlfIG1hZ2ljYWwgbnVtYmVyIHRoYXQNCj4gZGVwZW5kcyBvbiBhIGdjYyB2
ZXJzaW9uIGluIG9kZCBhbmQgdW5kb2N1bWVudGVkIHdheXMuLg0KPiANCj4gSU9XIC0gSSdtIGFz
c3VtaW5nIHVzZXIgc3BhY2UgZ2NvdiBpbmZyYXN0cnVjdHVyZSBmaW5kcyB0aGlzIG51bWJlcg0K
PiBzb21lIHdheSwgYW5kIHdvbmRlcmluZyBpZiB3ZSBjb3VsZG4ndCBkbyB0aGUgc2FtZT8NCj4g
DQo+IE9yIGlzIHRoZSBnY292IHRvb2wgaXRzZWxmIGp1c3QgZG9pbmcgdGhlIHNhbWUga2luZCBv
ZiB0aGluZywgYW5kDQo+IGhhdmluZyBtYWdpYyBudW1iZXJzPw0KPiANCj4gSSBnZXQgdGhlIGZl
ZWxpbmcgdGhhdCBzb21lYm9keSB3aG8ga25vd3MgZ2NvdiB3b3VsZCBnbyAiWW91IGFyZSBqdXN0
DQo+IGRvaW5nIHRoaXMgYWxsIGNvbXBsZXRlbHkgaW5jb3JyZWN0bHksIHlvdSBzaG91bGQgZG8g
WFlaIiB3aGVuIHRoZXkNCj4gc2VlIHRoYXQgR0NPVl9DT1VOVEVSUyB0aGluZy4NCj4gDQo+IE1h
eWJlIGp1c3QgYSBzY3JpcHQgdGhhdCBmaW5kcyB0aGUgcmlnaHQgaGVhZGVyIGZpbGUgaW4gdGhl
IGdjYw0KPiBpbnN0YWxsYXRpb24gYW5kIGV4dHJhY3RzIGl0IGZyb20gdGhlcmUsIGlmIG9ubHkg
dG8gdmVyaWZ5IHRoZSBtYWdpYw0KPiBudW1iZXIgdGhhdCB3ZSBoYXZlPw0KDQpJIHdhcyB3b25k
ZXJpbmcgd2hhdCBoYXBwZW5zIGlmIGZpbGVzIGNvbXBpbGVkIHdpdGggZGlmZmVyZW50DQp2ZXJz
aW9ucyBvZiBnY2MgZ2V0IGxpbmtlZCB0b2dldGhlcj8NCg0KTm90IHRvbyBmYXItZmV0Y2hlZCBm
b3Igc29tZW9uZSB0byByZWxlYXNlIGEgLmEgZmlsZSBjb250YWluaW5nDQonZ2NvbnYnIG9iamVj
dHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=


Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C6D20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgHSOgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:36:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:39635 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727926AbgHSOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:36:31 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-259--oeJpW0MO4CI3-hi_wxXYA-1; Wed, 19 Aug 2020 15:36:26 +0100
X-MC-Unique: -oeJpW0MO4CI3-hi_wxXYA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 19 Aug 2020 15:36:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 19 Aug 2020 15:36:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bernd Petrovitsch' <bernd@petrovitsch.priv.at>,
        Muni Sekhar <munisekharrms@gmail.com>
CC:     peter enderborg <peter.enderborg@sony.com>,
        Greg KH <greg@kroah.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: Scheduler benchmarks
Thread-Topic: Scheduler benchmarks
Thread-Index: AQHWdhhda8YDeK7akUe42i0mpbwe7qk/fn9w
Date:   Wed, 19 Aug 2020 14:36:25 +0000
Message-ID: <e8acd1a8444846b196d5fa1fe45806bb@AcuMS.aculab.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
 <4a20a4bb-0bc7-edb1-bd27-217d8dafe87c@petrovitsch.priv.at>
In-Reply-To: <4a20a4bb-0bc7-edb1-bd27-217d8dafe87c@petrovitsch.priv.at>
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

RnJvbTogQmVybmQgUGV0cm92aXRzY2gNCj4gU2VudDogMTkgQXVndXN0IDIwMjAgMTE6MjINCj4g
DQo+IE9uIDE5LzA4LzIwMjAgMTA6MTYsIE11bmkgU2VraGFyIHdyb3RlOg0KPiA+IE9uIFR1ZSwg
QXVnIDE4LCAyMDIwIGF0IDExOjQ1IFBNIHBldGVyIGVuZGVyYm9yZw0KPiA+IDxwZXRlci5lbmRl
cmJvcmdAc29ueS5jb20+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+PiBPbiB0aGUgNC40IGtlcm5lbCB5
b3UgZG9udCBoYXZlDQo+ID4+DQo+ID4+ICtDT05GSUdfUkVUUE9MSU5FPXkNCj4gPj4gK0NPTkZJ
R19JTlRFTF9SRFQ9eQ0KPiA+IFRoYW5rcyEgVGhhdCBpcyBoZWxwZnVsLiBZZXMsIEkgc2VlIDQu
NCBrZXJuZWwgZG9uJ3QgaGF2ZSB0aGUgYWJvdmUNCj4gPiB0d28gY29uZmlnIG9wdGlvbnMuDQo+
ID4gV2hhdCBhbmFseXNpcyBjYW4gYmUgZG9uZSB0byBuYXJyb3cgZG93biB0aGUgcm9vdCBjYXVz
ZT8NCj4gPiBBbnkgZXhhbXBsZSBvZiByZWZlcmVuY2UgY291bGQgYmUgaGVscGZ1bCB0byB1bmRl
cnN0YW5kLg0KPiANCj4gSSBoYXZlbid0IGNoZWNrZWQgdGhlIGRhdGUgb2YgdGhlIG9sZGVyIGtl
cm5lbCBidXQgU3BlY3RyZSsNCj4gTWVsdGRvd24gbWl0aWdhdGlvbiBjb3N0cyBhIGxvdCAoMjAl
LTMwJSBzcGVlZCBJSVJDLCBvdXQNCj4gb2YgdGhlIHRvcCBvZiBteSBoZWFkKS4NCg0KSXQgZGVw
ZW5kcyBncmVhdGx5IG9uIHRoZSBiZW5jaG1hcmsuDQoNClBhZ2UgdGFibGUgc2VwYXJhdGlvbiBo
YXMgYSBtYXNzaXZlIGVmZmVjdCBvbiBhbnl0aGluZyB0aGF0DQpkb2VzIGEgbG90IG9mIHNob3J0
IHN5c3RlbSBjYWxscy4NClRoZXJlIG1heSBiZSBzb21lIG1pdGlnYXRpb24gaW4gdmVyeSByZWNl
bnQgaGFyZHdhcmUuDQpBbmQgSSBjYW4ndCByZW1lbWJlciBpZiBpdCBnZXRzIGRpc2FibGVkIGZv
ciAncm9vdCcgcHJvY2Vzc2VzDQood2hpY2ggY2FuIHJlYWQga2VybmVsIG1lbW9yeSBhbnl3YXkp
Lg0KDQpJdCBpcyBkZWZpbml0ZWx5IHdvcnRoIGJ1aWxkaW5nIGEga2VybmVsIHdpdGggdGhlIG1p
dGlnYXRpb25zDQpkaXNhYmxlZCAgLSBpZiBvbmx5IHRvIGNoZWNrIHRoYXQgdGhleSBhcmUgcmVz
cG9uc2libGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


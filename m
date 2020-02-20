Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33205C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A5920656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBTOj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:39:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56097 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbgBTOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:39:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-230-Kqv9DHNyOZ6q5xUmIt1jAg-1; Thu, 20 Feb 2020 14:39:52 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 20 Feb 2020 14:39:51 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 20 Feb 2020 14:39:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'chris hyser' <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "qperret@qperret.net" <qperret@qperret.net>,
        "pjt@google.com" <pjt@google.com>, "tj@kernel.org" <tj@kernel.org>
Subject: RE: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
Thread-Topic: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
Thread-Index: AQHV5q881FBlSjXcbk+qN0I8G32+xqgiV6OQgABrx4CAAWSsQA==
Date:   Thu, 20 Feb 2020 14:39:51 +0000
Message-ID: <2870e44f41414fd58b58f7831d7386fe@AcuMS.aculab.com>
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <3ce2e8940fb14d95b011c8b30892aa62@AcuMS.aculab.com>
 <10f42efa-3750-491a-74fe-d84c9c4924e3@oracle.com>
In-Reply-To: <10f42efa-3750-491a-74fe-d84c9c4924e3@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Kqv9DHNyOZ6q5xUmIt1jAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogY2hyaXMgaHlzZXIgPGNocmlzLmh5c2VyQG9yYWNsZS5jb20+DQo+IFNlbnQ6IDE5IEZl
YnJ1YXJ5IDIwMjAgMTc6MTcNCj4gDQo+IE9uIDIvMTkvMjAgNjoxOCBBTSwgRGF2aWQgTGFpZ2h0
IHdyb3RlOg0KPiA+IEZyb206IGNocmlzIGh5c2VyDQo+ID4+IFNlbnQ6IDE4IEZlYnJ1YXJ5IDIw
MjAgMjM6MDANCj4gPiAuLi4NCj4gPj4gQWxsLCBJIHdhcyBhc2tlZCB0byB0YWtlIGEgbG9vayBh
dCB0aGUgb3JpZ2luYWwgbGF0ZW5jeV9uaWNlIHBhdGNoc2V0Lg0KPiA+PiBGaXJzdCwgdG8gY2xh
cmlmeSBvYmplY3RpdmVzLCBPcmFjbGUgaXMgbm90DQo+ID4+IGludGVyZXN0ZWQgaW4gdHJhZGlu
ZyB0aHJvdWdocHV0IGZvciBsYXRlbmN5Lg0KPiA+PiBXaGF0IHdlIGZvdW5kIGlzIHRoYXQgdGhl
IERCIGhhcyBzcGVjaWZpYyB0YXNrcyB3aGljaCBkbyB2ZXJ5IGxpdHRsZSBidXQNCj4gPj4gbmVl
ZCB0byBkbyB0aGlzIGFzIGFic29sdXRlbHkgcXVpY2tseSBhcyBwb3NzaWJsZSwgaWUgZXh0cmVt
ZSBsYXRlbmN5DQo+ID4+IHNlbnNpdGl2aXR5LiBTZWNvbmQsIHRoZSBrZXkgdG8gbGF0ZW5jeSBy
ZWR1Y3Rpb24NCj4gPj4gaW4gdGhlIHRhc2sgd2FrZXVwIHBhdGggc2VlbXMgdG8gYmUgbGltaXRp
bmcgdmFyaWF0aW9ucyBvZiAiaWRsZSBjcHUiIHNlYXJjaC4NCj4gPj4gVGhlIGxhdHRlciBwYXJ0
aWN1bGFybHkgaW50ZXJlc3RzIG1lIGFzIGFuIGV4YW1wbGUgb2YgInBsYXRmb3JtIHNpemUNCj4g
Pj4gYmFzZWQgbGF0ZW5jeSIgd2hpY2ggSSBiZWxpZXZlIHRvIGJlIGltcG9ydGFudCBnaXZlbiBh
bGwgdGhlIHZhcnlpbmcgc2l6ZQ0KPiA+PiBWTXMgYW5kIGNvbnRhaW5lcnMuDQo+ID4NCj4gPiAg
RnJvbSBteSBleHBlcmltZW50cyB0aGVyZSBhcmUgYSBmZXcgdGhpbmdzIHRoYXQgc2VlbSB0byBh
ZmZlY3QgbGF0ZW5jeQ0KPiA+IG9mIHdha2luZyB1cCByZWFsIHRpbWUgKHNjaGVkIGZpZm8pIHRh
c2tzIG9uIGEgbm9ybWFsIGtlcm5lbDoNCj4gDQo+IFNvcnJ5LiBJIHdhcyBvbmx5IGV2ZXIgdGFs
a2luZyBhYm91dCBzY2hlZF9vdGhlciBhcyBwZXIgdGhlIG9yaWdpbmFsIHBhdGNoc2V0LiBJIHJl
YWxpemUgdGhlIHRlcm0NCj4gZXh0cmVtZSBsYXRlbmN5DQo+IHNlbnNpdGl2aXR5IG1heSBoYXZl
IGNhdXNlZCBjb25mdXNpb24uIFdoYXQgdGhhdCBtZWFucyB0byBEQiBwZW9wbGUgaXMgbm8gZG91
YnQgZGlmZmVyZW50IHRoYW4gYXVkaW8NCj4gcGVvcGxlLiA6LSkNCg0KU2hvcnRlciBsaW5lcy4u
Li4uDQoNCklTVE0geW91IGFyZSBtYWtpbmcgc29tZSBhbHJlYWR5IGNvbXBsaWNhdGVkIGNvZGUg
ZXZlbiBtb3JlIGNvbXBsZXguDQpCZXR0ZXIgdG8gbWFrZSBpdCBzaW1wbGVyIGluc3RlYWQuDQoN
CklmIHlvdSBuZWVkIGEgdGhyZWFkIHRvIHJ1biBhcyBzb29uIGFzIHBvc3NpYmxlIGFmdGVyIGl0
IGlzIHdva2VuDQp3aHkgbm90IHVzZSB0aGUgUlQgc2NoZWR1bGVyIChlZyBTQ0hFRF9GSUZPKSB0
aGF0IGlzIHdoYXQgaXQgaXMgZm9yLg0KDQpJZiB0aGVyZSBhcmUgZGVsYXlzIGZpbmRpbmcgYW4g
aWRsZSBjcHUgdG8gbWlncmF0ZSBhIHByb2Nlc3MgdG8NCihlc3BlY2lhbGx5IG9uIHN5c3RlbXMg
d2l0aCBsYXJnZSBudW1iZXJzIG9mIGNwdSkgdGhlbiB0aGF0IGlzIGENCmdlbmVyYWwgcHJvYmxl
bSB0aGF0IGNhbiBiZSBhZGRyZXNzZWQgd2l0aG91dCBleHRyYSBrbm9icy4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==


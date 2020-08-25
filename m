Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2F120706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgHYKXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:23:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57723 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729628AbgHYKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:23:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-232-eP48536JOQWHk-TBJCTurQ-1; Tue, 25 Aug 2020 11:23:06 +0100
X-MC-Unique: eP48536JOQWHk-TBJCTurQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 11:23:05 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 11:23:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: RE: [PATCH v1] sched/topology: Make compiler happy about unused
 constant definitions
Thread-Topic: [PATCH v1] sched/topology: Make compiler happy about unused
 constant definitions
Thread-Index: AQHWertMvoDkJjq2DEiVVRVOhSPeqqlInXLQ
Date:   Tue, 25 Aug 2020 10:23:05 +0000
Message-ID: <8dbf0f1e60c848f0abafd5fa0490ff70@AcuMS.aculab.com>
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
 <jhjeenwdl7u.mognet@arm.com> <20200825082636.GQ1891694@smile.fi.intel.com>
In-Reply-To: <20200825082636.GQ1891694@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDI1IEF1Z3VzdCAyMDIwIDA5OjI3DQo+IA0K
PiBPbiBNb24sIEF1ZyAyNCwgMjAyMCBhdCAwNjowOTo0MVBNICswMTAwLCBWYWxlbnRpbiBTY2hu
ZWlkZXIgd3JvdGU6DQo+ID4gT24gMjQvMDgvMjAgMTY6MzksIEFuZHkgU2hldmNoZW5rbyB3cm90
ZToNCj4gPiA+IENvbXBpbGF0aW9uIG9mIGFsbW9zdCBlYWNoIGZpbGUgZW5kcyB1cCB3aXRoDQo+
ID4gPg0KPiA+ID4gIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi4vaW5jbHVkZS9saW51eC9lbmVy
Z3lfbW9kZWwuaDoxMCwNCj4gPiA+ICAgICAgICAgICAgICAgICBmcm9tIC4uLi9pbmNsdWRlL2xp
bnV4L2RldmljZS5oOjE2LA0KPiA+ID4gICAgICAgICAgICAgICAgIGZyb20gLi4uL2RyaXZlcnMv
c3BpL3NwaS5jOjg6DQo+ID4gPiAgLi4uL2luY2x1ZGUvbGludXgvc2NoZWQvdG9wb2xvZ3kuaDoz
MDoyNzogd2FybmluZzog4oCYU0RfREVHRU5FUkFURV9HUk9VUFNfTUFTS+KAmSBkZWZpbmVkIGJ1
dCBub3QNCj4gdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiA+ID4gICAgIDMwIHwg
c3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBTRF9ERUdFTkVSQVRFX0dST1VQU19NQVNLID0NCj4g
PiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fg0KPiA+ID4gIC4uLg0KPiA+ID4NCj4gPiA+IE1ha2UgY29tcGlsZXIgaGFwcHkgYnkg
YW5ub3RhdGluZyB0aGUgc3RhdGljIGNvbnN0YW50cyB3aXRoIF9fbWF5YndlX3VudXNlZC4NCj4g
PiA+DQo+ID4NCj4gPiBUaGF0IHNob3VsZCBzZWUgc29tZSB1c2UgYXMgbG9uZyBhcyB0aGUgYnVp
bGQgaXMgZm9yIFNNUC4gVGhpcyB3aG9sZSByZWdpb24NCj4gPiBpcyBndWFyZGVkIGJ5ICNpZmRl
ZiBDT05GSUdfU01QLCBzbyBhbiAhU01QIGJ1aWxkIHNob3VsZG4ndCB0cmlnZ2VyIHRoaXMuDQo+
IA0KPiBJc24ndCBTTVAgaXMgZGVmYXVsdCBmb3IgbW9zdCBvZiB0aGUga2VybmVsIGJ1aWxkcz8N
Cj4gQW5kIGhvbmVzdGx5IEkgZGlkbid0IGdldCB0aGUgcHVycG9zZSBvZiB0aGlzIGNvbW1lbnQu
DQoNClRoZSByZWFsIGZpeCBpcyB0byBub3QgdXNlICdzdGF0aWMgY29uc3QnIGluIEMuDQpJSVJD
IGl0IGlzIHN0aWxsIGEgbWVtb3J5IGxvY2F0aW9uICh0aGF0IGNhbiBiZSBwYXRjaGVkKSBub3QN
CmEgY29tcGlsZSB0aW1lIGNvbnN0YW50Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


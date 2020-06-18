Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACBE208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgFRQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:39:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45854 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729214AbgFRQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:39:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-262-hD1Yy6NVM8mnx0RAvwuLaA-1; Thu, 18 Jun 2020 17:39:42 +0100
X-MC-Unique: hD1Yy6NVM8mnx0RAvwuLaA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 18 Jun 2020 17:39:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 18 Jun 2020 17:39:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>
CC:     'Matt Fleming' <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "Kumar, Venkataramanan" <Venkataramanan.Kumar@amd.com>,
        Jan Kara <jack@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/asm/64: Align start of __clear_user() loop to
 16-bytes
Thread-Topic: [PATCH] x86/asm/64: Align start of __clear_user() loop to
 16-bytes
Thread-Index: AQHWRVoOsv5Rc5DeEUqSipuEjk3RuqjeLGswgAAdloCAAEi7sA==
Date:   Thu, 18 Jun 2020 16:39:35 +0000
Message-ID: <20b0166e11f44bf491062838090b93be@AcuMS.aculab.com>
References: <20200618102002.30034-1-matt@codeblueprint.co.uk>
 <39f8304b75094f87a54ace7732708d30@AcuMS.aculab.com>
 <20200618131655.GA24607@localhost.localdomain>
In-Reply-To: <20200618131655.GA24607@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuIA0KPiBTZW50OiAxOCBKdW5lIDIwMjAgMTQ6MTcNCi4uLg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xpYi91c2VyY29weV82NC5jIGIvYXJjaC94ODYv
bGliL3VzZXJjb3B5XzY0LmMNCj4gPiA+IGluZGV4IGZmZjI4YzZmNzNhMi4uYjBkZmFjM2QzZGY3
IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC94ODYvbGliL3VzZXJjb3B5XzY0LmMNCj4gPiA+ICsr
KyBiL2FyY2gveDg2L2xpYi91c2VyY29weV82NC5jDQo+ID4gPiBAQCAtMjQsNiArMjQsNyBAQCB1
bnNpZ25lZCBsb25nIF9fY2xlYXJfdXNlcih2b2lkIF9fdXNlciAqYWRkciwgdW5zaWduZWQgbG9u
ZyBzaXplKQ0KPiA+ID4gIAlhc20gdm9sYXRpbGUoDQo+ID4gPiAgCQkiCXRlc3RxICAlW3NpemU4
XSwlW3NpemU4XVxuIg0KPiA+ID4gIAkJIglqeiAgICAgNGZcbiINCj4gPiA+ICsJCSIJLmFsaWdu
IDE2XG4iDQo+ID4gPiAgCQkiMDoJbW92cSAkMCwoJVtkc3RdKVxuIg0KPiA+ID4gIAkJIglhZGRx
ICAgJDgsJVtkc3RdXG4iDQo+ID4gPiAgCQkiCWRlY2wgJSVlY3ggOyBqbnogICAwYlxuIg0KPiA+
DQo+ID4gWW91IGNhbiBkbyBiZXR0ZXIgdGhhdCB0aGF0IGxvb3AuDQo+ID4gQ2hhbmdlICdkc3Qn
IHRvIHBvaW50IHRvIHRoZSBlbmQgb2YgdGhlIGJ1ZmZlciwgbmVnYXRlIHRoZSBjb3VudA0KPiA+
IGFuZCBkaXZpZGUgYnkgOCBhbmQgeW91IGdldDoNCj4gPiAJCSIwOgltb3ZxICQwLCgkW2RzdF0s
JSVlY3gsOClcbiINCj4gPiAJCSIJYWRkICQxLCUlZWN4Ig0KPiA+IAkJIglqbnogMGJcbiINCj4g
PiB3aGljaCBtaWdodCBydW4gYXQgb25lIGl0ZXJhdGlvbiBwZXIgY2xvY2sgZXNwZWNpYWxseSBv
biBjcHUgdGhhdCBwYWlyDQo+ID4gdGhlIGFkZCBhbmQgam56IGludG8gYSBzaW5nbGUgdW9wLg0K
PiA+IChZb3UgbmVlZCB0byB1c2UgYWRkIG5vdCBpbmMuKQ0KPiANCj4gL2Rldi96ZXJvIHNob3Vs
ZCBwcm9iYWJseSB1c2UgUkVQIFNUT1NCIGV0YyBqdXN0IGxpa2UgZXZlcnl0aGluZyBlbHNlLg0K
DQpBbG1vc3QgY2VydGFpbmx5IGl0IHNob3VsZG4ndCwgYW5kIG5laXRoZXIgc2hvdWxkIGFueXRo
aW5nIGVsc2UuDQpQb3RlbnRpYWxseSBpdCBjb3VsZCB1c2Ugd2hhdGV2ZXIgbWVtc2V0KCkgaXMg
cGF0Y2hlZCB0by4NClRoYXQgTUlHSFQgYmUgJ3JlcCBzdG9zJyBvbiBzb21lIGNwdSB2YXJpYW50
cywgYnV0IGluIGdlbmVyYWwNCml0IGlzIHNsb3cuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


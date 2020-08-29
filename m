Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9641AC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD822076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgH2Tb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:31:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29419 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728370AbgH2Tb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:31:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-66-2ft33eF5NHCr6OGuIjxBCA-1; Sat, 29 Aug 2020 20:31:21 +0100
X-MC-Unique: 2ft33eF5NHCr6OGuIjxBCA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 29 Aug 2020 20:31:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 29 Aug 2020 20:31:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        'Will Deacon' <will@kernel.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        'Andrea Arcangeli' <aarcange@redhat.com>,
        "'Waiman Long'" <longman@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        'Andrew Cooper' <andrew.cooper3@citrix.com>,
        'Andy Lutomirski' <luto@kernel.org>,
        'Christoph Hellwig' <hch@lst.de>
Subject: RE: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWfXGL4X8nWl6IwEyifUSeZx09HqlPCNzQgABwecA=
Date:   Sat, 29 Aug 2020 19:31:20 +0000
Message-ID: <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
 <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
In-Reply-To: <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDI5IEF1Z3VzdCAyMDIwIDE0OjIxDQo+IA0KPiBG
cm9tOiBKb3NoIFBvaW1ib2V1Zg0KPiA+IFNlbnQ6IDI4IEF1Z3VzdCAyMDIwIDIwOjI5DQo+ID4N
Cj4gPiBPbiBXZWQsIEF1ZyAxOSwgMjAyMCBhdCAwOTo1MDowNkFNIC0wNTAwLCBKb3NoIFBvaW1i
b2V1ZiB3cm90ZToNCj4gPiA+IFRoZSB4ODYgdWFjY2VzcyBjb2RlIHVzZXMgYmFycmllcl9ub3Nw
ZWMoKSBpbiB2YXJpb3VzIHBsYWNlcyB0byBwcmV2ZW50DQo+ID4gPiBzcGVjdWxhdGl2ZSBkZXJl
ZmVyZW5jaW5nIG9mIHVzZXItY29udHJvbGxlZCBwb2ludGVycyAod2hpY2ggbWlnaHQgYmUNCj4g
PiA+IGNvbWJpbmVkIHdpdGggZnVydGhlciBnYWRnZXRzIG9yIENQVSBidWdzIHRvIGxlYWsgZGF0
YSkuDQo+ID4gPg0KPiA+ID4gVGhlcmUgYXJlIHNvbWUgaXNzdWVzIHdpdGggdGhlIGN1cnJlbnQg
aW1wbGVtZW50YXRpb246DQo+ID4gPg0KPiA+ID4gLSBUaGUgYmFycmllcl9ub3NwZWMoKSBpbiBj
b3B5X2Zyb21fdXNlcigpIHdhcyBpbmFkdmVydGVudGx5IHJlbW92ZWQNCj4gPiA+ICAgd2l0aDog
NGI4NDJlNGUyNWIxICgieDg2OiBnZXQgcmlkIG9mIHNtYWxsIGNvbnN0YW50IHNpemUgY2FzZXMg
aW4NCj4gPiA+ICAgcmF3X2NvcHlfe3RvLGZyb219X3VzZXIoKSIpDQo+ID4gPg0KPiA+ID4gLSBj
b3B5X3RvX3VzZXIoKSBhbmQgZnJpZW5kcyBzaG91bGQgYWxzbyBoYXZlIGEgc3BlY3VsYXRpb24g
YmFycmllciwNCj4gPiA+ICAgYmVjYXVzZSBhIHNwZWN1bGF0aXZlIHdyaXRlIHRvIGEgdXNlci1j
b250cm9sbGVkIGFkZHJlc3MgY2FuIHN0aWxsDQo+ID4gPiAgIHBvcHVsYXRlIHRoZSBjYWNoZSBs
aW5lIHdpdGggdGhlIG9yaWdpbmFsIGRhdGEuDQo+ID4gPg0KPiA+ID4gLSBUaGUgTEZFTkNFIGlu
IGJhcnJpZXJfbm9zcGVjKCkgaXMgb3ZlcmtpbGwsIHdoZW4gbW9yZSBsaWdodHdlaWdodCB1c2Vy
DQo+ID4gPiAgIHBvaW50ZXIgbWFza2luZyBjYW4gYmUgdXNlZCBpbnN0ZWFkLg0KPiA+ID4NCj4g
PiA+IFJlbW92ZSBhbGwgZXhpc3RpbmcgYmFycmllcl9ub3NwZWMoKSB1c2FnZSwgYW5kIGluc3Rl
YWQgZG8gdXNlciBwb2ludGVyDQo+ID4gPiBtYXNraW5nLCB0aHJvdWdob3V0IHRoZSB4ODYgdWFj
Y2VzcyBjb2RlLiAgVGhpcyBpcyBzaW1pbGFyIHRvIHdoYXQgYXJtNjQNCj4gPiA+IGlzIGFscmVh
ZHkgZG9pbmcuDQo+ID4gPg0KPiA+ID4gYmFycmllcl9ub3NwZWMoKSBpcyBub3cgdW51c2VkLCBh
bmQgY2FuIGJlIHJlbW92ZWQuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDRiODQyZTRlMjViMSAoIng4
NjogZ2V0IHJpZCBvZiBzbWFsbCBjb25zdGFudCBzaXplIGNhc2VzIGluIHJhd19jb3B5X3t0byxm
cm9tfV91c2VyKCkiKQ0KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBXaWxsIERlYWNvbiA8d2lsbEBrZXJu
ZWwub3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJl
ZGhhdC5jb20+DQo+ID4NCj4gPiBQaW5nPw0KPiANCj4gUmVyZWFkaW5nIHRoZSBwYXRjaCBpdCBs
b29rcyBsaWtlIGEgbG90IG9mIGJsb2F0IChhcyB3ZWxsIGFzIGENCj4gbG90IG9mIGNoYW5nZXMp
Lg0KPiBEb2VzIHRoZSBhcnJheV9tYXNrIGV2ZW4gd29yayBvbiAzMmJpdCBhcmNocyB3aGVyZSB0
aGUga2VybmVsDQo+IGJhc2UgYWRkcmVzcyBpcyAweGMwMDAwMDAwPw0KPiBJJ20gc3VyZSB0aGVy
ZSBpcyBzb21ldGhpbmcgbXVjaCBzaW1wbGVyLg0KPiANCj4gSWYgYWNjZXNzX29rKCkgZ2VuZXJh
dGVzIH4wdSBvciAwIHdpdGhvdXQgYSBjb25kaXRpb25hbCB0aGVuDQo+IHRoZSBhZGRyZXNzIGNh
biBiZSBtYXNrZWQgd2l0aCB0aGUgcmVzdWx0Lg0KPiBTbyB5b3UgcHJvYmFibHkgbmVlZCB0byBj
aGFuZ2UgYWNjZXNzX29rKCkgdG8gdGFrZSB0aGUgYWRkcmVzcw0KPiBvZiB0aGUgdXNlciBwb2lu
dGVyIC0gc28gdGhlIGNhbGxlcnMgYmVjb21lIGxpa2U6DQo+IAlpZiAoYWNjZXNzX29rKCZ1c2Vy
X2J1ZmZlciwgbGVuKSkNCj4gCQlyZXR1cm4gLUVGQVVMVA0KPiAJX19wdXRfdXNlcih1c2VyX2J1
ZmZlciwgdmFsdWUpOw0KPiANCj4gSXQgd291bGQgYmUgZWFzaWVyIGlmIE5VTEwgd2VyZSBndWFy
YW50ZWVkIHRvIGJlIGFuIGludmFsaWQNCj4gdXNlciBhZGRyZXNzIChpcyBpdD8pLg0KPiBUaGVu
IGFjY2Vzc19vaygpIGNvdWxkIHJldHVybiB0aGUgbW9kaWZpZWQgcG9pbnRlci4NCj4gU28geW91
IGdldCBzb21ldGhpbmcgbGlrZToNCj4gCXVzZXJfYnVmZmVyID0gYWNjZXNzX29rKHVzZXJfYnVm
ZmVyLCBsZW4pOw0KPiAJaWYgKCF1c2VyX2J1ZmZlcikNCj4gCQlyZXR1cm4gLUVGQVVMVC4NCj4g
DQo+IFByb3ZpZGVkIHRoZSAnbGFzdCcgdXNlciBwYWdlIGlzIG5ldmVyIGFsbG9jYXRlZCAoaXQg
Y2FuJ3QNCj4gYmUgb24gaTM4NiBkdWUgdG8gY3B1IHByZWZldGNoIGlzc3Vlcykgc29tZXRoaW5n
IGxpa2U6DQo+IChhbmQgd2l0aCB0aGUgYXNtIHByb2JhYmx5IGFsbCBicm9rZW4pDQo+IA0KPiBz
dGF0aWMgaW5saW5lIHZvaWQgX191c2VyICogYWNjZXNzX29rKHZvaWQgX191c2VyICpiLCBzaXpl
X3QgbGVuKQ0KPiB7DQo+IAl1bnNpZ25lZCBsb25nIHggPSAobG9uZyliIHwgKGxvbmcpKGIgKyBs
ZW4pOw0KPiAJdW5zaWduZWQgbG9uZyBsaW0gPSA2NF9iaXQgPyAxdSA8PCA2MyA6IDB4NDAwMDAw
MDA7DQo+IAlhc20gdm9sYXRpbGUgKCIgYWRkICUxLCAlMFxuIg0KPiAJCQkiIHNiYiAkMCwgJTAi
LCAiPXIiICh4KSwgInIiIChsaW0pKTsNCj4gCXJldHVybiAodm9pZCBfX3VzZXIgKikobG9uZyli
ICYgfngpOw0KPiB9DQoNCkFjdHVhbGx5LCB0aGlua2luZyBmdXJ0aGVyLCBpZjoNCjEpIHRoZSBh
Y2Nlc3Nfb2soKSBpbW1lZGlhdGVseSBwcmVjZWRlcyB0aGUgdXNlciBjb3B5IChhcyBpdCBzaG91
bGQpLg0KMikgdGhlIHVzZXItY29waWVzIHVzZSBhIHNlbnNpYmxlICdpbmNyZWFzaW5nIGFkZHJl
c3MnIGNvcHkuDQphbmQNCjMpIHRoZXJlIGlzIGEgJ2d1YXJkIHBhZ2UnIGJldHdlZW4gdmFsaWQg
dXNlciBhbmQga2VybmVsIGFkZHJlc3Nlcy4NClRoZW4gYWNjZXNzX29rKCkgb25seSBuZWVkIGNo
ZWNrIHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIHVzZXIgYnVmZmVyLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K


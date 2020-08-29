Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B538EC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6B92075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgH2NZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:25:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37043 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728215AbgH2NVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:21:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-138-LvN-gPRTMnunttHz6U4gHg-1; Sat, 29 Aug 2020 14:21:05 +0100
X-MC-Unique: LvN-gPRTMnunttHz6U4gHg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 29 Aug 2020 14:21:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 29 Aug 2020 14:21:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWfXGL4X8nWl6IwEyifUSeZx09HqlPCNzQ
Date:   Sat, 29 Aug 2020 13:21:04 +0000
Message-ID: <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
In-Reply-To: <20200828192911.ezqspexfb2gtvrr7@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMjggQXVndXN0IDIwMjAgMjA6MjkNCj4gDQo+
IE9uIFdlZCwgQXVnIDE5LCAyMDIwIGF0IDA5OjUwOjA2QU0gLTA1MDAsIEpvc2ggUG9pbWJvZXVm
IHdyb3RlOg0KPiA+IFRoZSB4ODYgdWFjY2VzcyBjb2RlIHVzZXMgYmFycmllcl9ub3NwZWMoKSBp
biB2YXJpb3VzIHBsYWNlcyB0byBwcmV2ZW50DQo+ID4gc3BlY3VsYXRpdmUgZGVyZWZlcmVuY2lu
ZyBvZiB1c2VyLWNvbnRyb2xsZWQgcG9pbnRlcnMgKHdoaWNoIG1pZ2h0IGJlDQo+ID4gY29tYmlu
ZWQgd2l0aCBmdXJ0aGVyIGdhZGdldHMgb3IgQ1BVIGJ1Z3MgdG8gbGVhayBkYXRhKS4NCj4gPg0K
PiA+IFRoZXJlIGFyZSBzb21lIGlzc3VlcyB3aXRoIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9u
Og0KPiA+DQo+ID4gLSBUaGUgYmFycmllcl9ub3NwZWMoKSBpbiBjb3B5X2Zyb21fdXNlcigpIHdh
cyBpbmFkdmVydGVudGx5IHJlbW92ZWQNCj4gPiAgIHdpdGg6IDRiODQyZTRlMjViMSAoIng4Njog
Z2V0IHJpZCBvZiBzbWFsbCBjb25zdGFudCBzaXplIGNhc2VzIGluDQo+ID4gICByYXdfY29weV97
dG8sZnJvbX1fdXNlcigpIikNCj4gPg0KPiA+IC0gY29weV90b191c2VyKCkgYW5kIGZyaWVuZHMg
c2hvdWxkIGFsc28gaGF2ZSBhIHNwZWN1bGF0aW9uIGJhcnJpZXIsDQo+ID4gICBiZWNhdXNlIGEg
c3BlY3VsYXRpdmUgd3JpdGUgdG8gYSB1c2VyLWNvbnRyb2xsZWQgYWRkcmVzcyBjYW4gc3RpbGwN
Cj4gPiAgIHBvcHVsYXRlIHRoZSBjYWNoZSBsaW5lIHdpdGggdGhlIG9yaWdpbmFsIGRhdGEuDQo+
ID4NCj4gPiAtIFRoZSBMRkVOQ0UgaW4gYmFycmllcl9ub3NwZWMoKSBpcyBvdmVya2lsbCwgd2hl
biBtb3JlIGxpZ2h0d2VpZ2h0IHVzZXINCj4gPiAgIHBvaW50ZXIgbWFza2luZyBjYW4gYmUgdXNl
ZCBpbnN0ZWFkLg0KPiA+DQo+ID4gUmVtb3ZlIGFsbCBleGlzdGluZyBiYXJyaWVyX25vc3BlYygp
IHVzYWdlLCBhbmQgaW5zdGVhZCBkbyB1c2VyIHBvaW50ZXINCj4gPiBtYXNraW5nLCB0aHJvdWdo
b3V0IHRoZSB4ODYgdWFjY2VzcyBjb2RlLiAgVGhpcyBpcyBzaW1pbGFyIHRvIHdoYXQgYXJtNjQN
Cj4gPiBpcyBhbHJlYWR5IGRvaW5nLg0KPiA+DQo+ID4gYmFycmllcl9ub3NwZWMoKSBpcyBub3cg
dW51c2VkLCBhbmQgY2FuIGJlIHJlbW92ZWQuDQo+ID4NCj4gPiBGaXhlczogNGI4NDJlNGUyNWIx
ICgieDg2OiBnZXQgcmlkIG9mIHNtYWxsIGNvbnN0YW50IHNpemUgY2FzZXMgaW4gcmF3X2NvcHlf
e3RvLGZyb219X3VzZXIoKSIpDQo+ID4gU3VnZ2VzdGVkLWJ5OiBXaWxsIERlYWNvbiA8d2lsbEBr
ZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPg0KPiANCj4gUGluZz8NCg0KUmVyZWFkaW5nIHRoZSBwYXRjaCBpdCBsb29rcyBs
aWtlIGEgbG90IG9mIGJsb2F0IChhcyB3ZWxsIGFzIGENCmxvdCBvZiBjaGFuZ2VzKS4NCkRvZXMg
dGhlIGFycmF5X21hc2sgZXZlbiB3b3JrIG9uIDMyYml0IGFyY2hzIHdoZXJlIHRoZSBrZXJuZWwN
CmJhc2UgYWRkcmVzcyBpcyAweGMwMDAwMDAwPw0KSSdtIHN1cmUgdGhlcmUgaXMgc29tZXRoaW5n
IG11Y2ggc2ltcGxlci4NCg0KSWYgYWNjZXNzX29rKCkgZ2VuZXJhdGVzIH4wdSBvciAwIHdpdGhv
dXQgYSBjb25kaXRpb25hbCB0aGVuDQp0aGUgYWRkcmVzcyBjYW4gYmUgbWFza2VkIHdpdGggdGhl
IHJlc3VsdC4NClNvIHlvdSBwcm9iYWJseSBuZWVkIHRvIGNoYW5nZSBhY2Nlc3Nfb2soKSB0byB0
YWtlIHRoZSBhZGRyZXNzDQpvZiB0aGUgdXNlciBwb2ludGVyIC0gc28gdGhlIGNhbGxlcnMgYmVj
b21lIGxpa2U6DQoJaWYgKGFjY2Vzc19vaygmdXNlcl9idWZmZXIsIGxlbikpDQoJCXJldHVybiAt
RUZBVUxUDQoJX19wdXRfdXNlcih1c2VyX2J1ZmZlciwgdmFsdWUpOw0KDQpJdCB3b3VsZCBiZSBl
YXNpZXIgaWYgTlVMTCB3ZXJlIGd1YXJhbnRlZWQgdG8gYmUgYW4gaW52YWxpZA0KdXNlciBhZGRy
ZXNzIChpcyBpdD8pLg0KVGhlbiBhY2Nlc3Nfb2soKSBjb3VsZCByZXR1cm4gdGhlIG1vZGlmaWVk
IHBvaW50ZXIuDQpTbyB5b3UgZ2V0IHNvbWV0aGluZyBsaWtlOg0KCXVzZXJfYnVmZmVyID0gYWNj
ZXNzX29rKHVzZXJfYnVmZmVyLCBsZW4pOw0KCWlmICghdXNlcl9idWZmZXIpDQoJCXJldHVybiAt
RUZBVUxULg0KDQpQcm92aWRlZCB0aGUgJ2xhc3QnIHVzZXIgcGFnZSBpcyBuZXZlciBhbGxvY2F0
ZWQgKGl0IGNhbid0DQpiZSBvbiBpMzg2IGR1ZSB0byBjcHUgcHJlZmV0Y2ggaXNzdWVzKSBzb21l
dGhpbmcgbGlrZToNCihhbmQgd2l0aCB0aGUgYXNtIHByb2JhYmx5IGFsbCBicm9rZW4pDQoNCnN0
YXRpYyBpbmxpbmUgdm9pZCBfX3VzZXIgKiBhY2Nlc3Nfb2sodm9pZCBfX3VzZXIgKmIsIHNpemVf
dCBsZW4pDQp7DQoJdW5zaWduZWQgbG9uZyB4ID0gKGxvbmcpYiB8IChsb25nKShiICsgbGVuKTsN
Cgl1bnNpZ25lZCBsb25nIGxpbSA9IDY0X2JpdCA/IDF1IDw8IDYzIDogMHg0MDAwMDAwMDsNCglh
c20gdm9sYXRpbGUgKCIgYWRkICUxLCAlMFxuIg0KCQkJIiBzYmIgJDAsICUwIiwgIj1yIiAoeCks
ICJyIiAobGltKSk7DQoJcmV0dXJuICh2b2lkIF9fdXNlciAqKShsb25nKWIgJiB+eCk7DQp9DQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=


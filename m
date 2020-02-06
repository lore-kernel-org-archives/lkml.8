Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81556C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEF214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFQ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:27:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:36737 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgBFQ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:27:52 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-185-_Inpmhi_MReCPYBTeRnDtw-1; Thu, 06 Feb 2020 16:27:47 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 6 Feb 2020 16:27:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 6 Feb 2020 16:27:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Kees Cook <keescook@chromium.org>
CC:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Thread-Topic: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Thread-Index: AQHV3O+Uub3eyEmx20OwpNUdqmwARKgOWIJQ
Date:   Thu, 6 Feb 2020 16:27:46 +0000
Message-ID: <9293be85241d49c182e614ffd7186bca@AcuMS.aculab.com>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-7-kristen@linux.intel.com>
 <202002060408.84005CEFFD@keescook>
 <CAG48ez19kRC_5+ykvQCnZxLq6Qg3xUy7fEMf3pYrG46vBZt6jQ@mail.gmail.com>
In-Reply-To: <CAG48ez19kRC_5+ykvQCnZxLq6Qg3xUy7fEMf3pYrG46vBZt6jQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: _Inpmhi_MReCPYBTeRnDtw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDA2IEZlYnJ1YXJ5IDIwMjAgMTM6MTYNCi4uLg0KPiA+
IEkgY2Fubm90IGZpbmQgZXZpZGVuY2UgZm9yDQo+ID4gd2hhdCBmdW5jdGlvbiBzdGFydCBhbGln
bm1lbnQgc2hvdWxkIGJlLg0KPiANCj4gVGhlcmUgaXMgbm8gYXJjaGl0ZWN0dXJhbGx5IHJlcXVp
cmVkIGFsaWdubWVudCBmb3IgZnVuY3Rpb25zLCBidXQNCj4gSW50ZWwncyBPcHRpbWl6YXRpb24g
TWFudWFsDQo+ICg8aHR0cHM6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQvZGFtL3d3dy9wdWJsaWMv
dXMvZW4vZG9jdW1lbnRzL21hbnVhbHMvNjQtaWEtMzItYXJjaGl0ZWN0dXJlcy0NCj4gb3B0aW1p
emF0aW9uLW1hbnVhbC5wZGY+KQ0KPiByZWNvbW1lbmRzIGluIHNlY3Rpb24gMy40LjEuNSwgIkNv
ZGUgQWxpZ25tZW50IjoNCj4gDQo+IHwgQXNzZW1ibHkvQ29tcGlsZXIgQ29kaW5nIFJ1bGUgMTIu
IChNIGltcGFjdCwgSCBnZW5lcmFsaXR5KQ0KPiB8IEFsbCBicmFuY2ggdGFyZ2V0cyBzaG91bGQg
YmUgMTYtYnl0ZSBhbGlnbmVkLg0KPiANCj4gQUZBSUsgdGhpcyBpcyByZWNvbW1lbmRlZCBiZWNh
dXNlLCBhcyBkb2N1bWVudGVkIGluIHNlY3Rpb24gMi4zLjIuMSwNCj4gIkxlZ2FjeSBEZWNvZGUg
UGlwZWxpbmUiIChkZXNjcmliaW5nIHRoZSBmcm9udGVuZCBvZiBTYW5keSBCcmlkZ2UsIGFuZA0K
PiB1c2VkIGFzIHRoZSBiYXNlIGZvciBuZXdlciBtaWNyb2FyY2hpdGVjdHVyZXMpOg0KPiANCj4g
fCBBbiBpbnN0cnVjdGlvbiBmZXRjaCBpcyBhIDE2LWJ5dGUgYWxpZ25lZCBsb29rdXAgdGhyb3Vn
aCB0aGUgSVRMQg0KPiBhbmQgaW50byB0aGUgaW5zdHJ1Y3Rpb24gY2FjaGUuDQo+IHwgVGhlIGlu
c3RydWN0aW9uIGNhY2hlIGNhbiBkZWxpdmVyIGV2ZXJ5IGN5Y2xlIDE2IGJ5dGVzIHRvIHRoZQ0K
PiBpbnN0cnVjdGlvbiBwcmUtZGVjb2Rlci4NCj4gDQo+IEFGQUlLIHRoaXMgbWVhbnMgdGhhdCBp
ZiBhIGJyYW5jaCBlbmRzIGNsb3NlIHRvIHRoZSBlbmQgb2YgYSAxNi1ieXRlDQo+IGJsb2NrLCB0
aGUgZnJvbnRlbmQgaXMgbGVzcyBlZmZpY2llbnQgYmVjYXVzZSBpdCBtYXkgaGF2ZSB0byBydW4g
dHdvDQo+IGluc3RydWN0aW9uIGZldGNoZXMgYmVmb3JlIHRoZSBmaXJzdCBpbnN0cnVjdGlvbiBj
YW4gZXZlbiBiZSBkZWNvZGVkLg0KDQpTZWUgYWxzbyBUaGUgbWljcm9hcmNoaXRlY3R1cmUgb2Yg
SW50ZWwsIEFNRCBhbmQgVklBIENQVXMgZnJvbSB3d3cuYWduZXIub3JnL29wdGltaXplIA0KDQpN
eSBzdXNwaWNpb24gaXMgdGhhdCByZWR1Y2luZyB0aGUgY2FjaGUgc2l6ZSAoc28gbW9yZSBjb2Rl
IGZpdHMgaW4pDQp3aWxsIGFsbW9zdCBhbHdheXMgYmUgYSB3aW4gb3ZlciBhbGlnbmluZyBicmFu
Y2ggdGFyZ2V0cyBhbmQgZW50cnkgcG9pbnRzLg0KSWYgdGhlIGFsaWdubWVudCBvZiBhIGZ1bmN0
aW9uIG1hdHRlcnMgdGhlbiB0aGVyZSBhcmUgcHJvYmFibHkgb3RoZXINCmNoYW5nZXMgdG8gdGhh
dCBiaXQgb2YgY29kZSB0aGF0IHdpbGwgZ2l2ZSBhIGxhcmdlciBiZW5lZml0Lg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K


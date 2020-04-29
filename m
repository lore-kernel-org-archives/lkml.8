Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A80BC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D2E20775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD2I4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:56:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33060 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgD2I4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:56:15 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-72-PEC8r6YnPqSaVPhMZbGowA-1; Wed, 29 Apr 2020 09:56:13 +0100
X-MC-Unique: PEC8r6YnPqSaVPhMZbGowA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 29 Apr 2020 09:56:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 Apr 2020 09:56:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jim Mattson' <jmattson@google.com>,
        'Paolo Bonzini' <pbonzini@redhat.com>
CC:     'LKML' <linux-kernel@vger.kernel.org>,
        'kvm list' <kvm@vger.kernel.org>,
        'Sean Christopherson' <sean.j.christopherson@intel.com>,
        'Joerg Roedel' <joro@8bytes.org>,
        "'everdox@gmail.com'" <everdox@gmail.com>
Subject: RE: [PATCH] KVM: x86: handle wrap around 32-bit address space
Thread-Topic: [PATCH] KVM: x86: handle wrap around 32-bit address space
Thread-Index: AQHWHPQJ/975q5rp/UiOQx/+1A4bJqiPy+vwgAABnFA=
Date:   Wed, 29 Apr 2020 08:56:12 +0000
Message-ID: <91c76eb0edcd4f1a9d5bc541d35f8ade@AcuMS.aculab.com>
References: <20200427165917.31799-1-pbonzini@redhat.com>
 <CALMp9eTBs=deSYu1=CMLwZcO8HTpGM2JsgDxvFR1Y220tdUQ3w@mail.gmail.com>
 <c3ac5f4c9e3a412cb57ea02df19dd2d2@AcuMS.aculab.com>
In-Reply-To: <c3ac5f4c9e3a412cb57ea02df19dd2d2@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDI5IEFwcmlsIDIwMjAgMDk6NTANCj4gRnJvbTog
SmltIE1hdHRzb24NCj4gPiBTZW50OiAyOCBBcHJpbCAyMDIwIDAxOjI5DQo+ID4gT24gTW9uLCBB
cHIgMjcsIDIwMjAgYXQgOTo1OSBBTSBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29t
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBLVk0gaXMgbm90IGhhbmRsaW5nIHRoZSBjYXNlIHdoZXJl
IEVJUCB3cmFwcyBhcm91bmQgdGhlIDMyLWJpdCBhZGRyZXNzDQo+ID4gPiBzcGFjZSAodGhhdCBp
cywgb3V0c2lkZSBsb25nIG1vZGUpLiAgVGhpcyBpcyBuZWVkZWQgYm90aCBpbiB2bXguYw0KPiA+
ID4gYW5kIGluIGVtdWxhdGUuYy4gIFNWTSB3aXRoIE5SSVBTIGlzIG9rYXksIGJ1dCBpdCBjYW4g
c3RpbGwgcHJpbnQNCj4gPiA+IGFuIGVycm9yIHRvIGRtZXNnIGR1ZSB0byBpbnRlZ2VyIG92ZXJm
bG93Lg0KPiAuLi4NCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoKChyaXAgXiBv
cmlnX3JpcCkgPj4gMzEpID09IDMpICYmICFpc182NF9iaXRfbW9kZSh2Y3B1KSkNCj4gDQo+IElz
bid0IHRoZSBtb3JlIG9idmlvdXM6DQo+IAlpZiAoKChyaXAgXiBvcmlnX3JpcCkgJiAxdWxsIDw8
IDMyKSAuLi4NCj4gZXF1aXZhbGVudD8NCg0KQWN0dWFsbHkgbm90IGV2ZW4gYmVpbmcgY2xldmVy
LCBob3cgYWJvdXQ6DQoJaWYgKG9yaWdfcmlwIDwgKDF1bGwgPDwgMzIpICYmIHVubGlrZWx5KHJp
cCA+PSAoMXVsbCA8PCAzMikpICYmIC4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


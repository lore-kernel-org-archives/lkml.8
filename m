Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F15C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DEB2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEGPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:09:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45021 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbgEGPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:09:40 -0400
X-Greylist: delayed 26691 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 11:09:39 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-eCu94Q7JP0-k2Oee_LKtag-1; Thu, 07 May 2020 16:09:36 +0100
X-MC-Unique: eCu94Q7JP0-k2Oee_LKtag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 7 May 2020 16:09:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 May 2020 16:09:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Brian Gerst' <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        stable <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] x86: bitops: fix build regression
Thread-Topic: [PATCH] x86: bitops: fix build regression
Thread-Index: AQHWJHPxnFcKS0TA9USbY8l3s67J1qicuE2A
Date:   Thu, 7 May 2020 15:09:35 +0000
Message-ID: <9c701ca55bc442c1899a70896f3ea73e@AcuMS.aculab.com>
References: <20200505174423.199985-1-ndesaulniers@google.com>
 <CAMzpN2idWF2_4wtPebM2B2HVyksknr9hAqK8HJi_vjQ06bgu2g@mail.gmail.com>
 <6A99766A-59FB-42DF-9350-80EA671A42B0@zytor.com>
 <CAMzpN2iCgr0rb=MCYPGMx8tcfLq2qdzv0h7YnX5hkzBB+O7JJQ@mail.gmail.com>
In-Reply-To: <CAMzpN2iCgr0rb=MCYPGMx8tcfLq2qdzv0h7YnX5hkzBB+O7JJQ@mail.gmail.com>
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

RnJvbTogQnJpYW4gR2Vyc3QNCj4gU2VudDogMDcgTWF5IDIwMjAgMTQ6MzINCi4uLg0KPiBJIHRo
aW5rIHRoZSBidWcgdGhpcyB3b3JrZWQgYXJvdW5kIHdhcyB0aGF0IHRoZSBjb21waWxlciBkaWRu
J3QgZGV0ZWN0DQo+IHRoYXQgQ09OU1RfTUFTSyhucikgd2FzIGFsc28gY29uc3RhbnQgYW5kIGRv
ZXNuJ3QgbmVlZCB0byBiZSBwdXQgaW50bw0KPiBhIHJlZ2lzdGVyLiAgVGhlIHF1ZXN0aW9uIGlz
IGRvZXMgdGhhdCBidWcgc3RpbGwgZXhpc3Qgb24gY29tcGlsZXINCj4gdmVyc2lvbnMgd2UgY2Fy
ZSBhYm91dD8NCg0KSG1tbS4uLg0KVGhhdCBvdWdodCB0byBoYXZlIGJlZW4gZml4ZWQgaW5zdGVh
ZCBvZiB3b3JyeWluZyBhYm91dCB0aGUgZmFjdA0KdGhhdCBhbiBpbnZhbGlkIHJlZ2lzdGVyIHdh
cyB1c2VkLg0KDQpBbHRlcm5hdGl2ZWx5IGlzIHRoZXJlIGFueSByZWFzb24gbm90IHRvIHVzZSB0
aGUgYnRzL2J0YyBpbnN0cnVjdGlvbnM/DQpZZXMsIEkga25vdyB0aGV5J2xsIGRvIHdpZGVyIGFj
Y2Vzc2VzLCBidXQgdmFyaWFibGUgYml0IG51bWJlcnMgZG8uDQpJdCBpcyBhbHNvIHBvc3NpYmxl
IHRoYXQgdGhlIGFzc2VtYmxlciB3aWxsIHN1cHBvcnQgY29uc3RhbnQgYml0DQpudW1iZXJzID49
IDMyIGJ5IGFkZGluZyB0byB0aGUgYWRkcmVzcyBvZmZzZXQuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


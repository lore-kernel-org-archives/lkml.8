Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E89C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B957206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgIAPA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:00:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42760 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgIAPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:00:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-43-fL2nrNnkO5KgEa_XAJpc8A-1; Tue, 01 Sep 2020 16:00:45 +0100
X-MC-Unique: fL2nrNnkO5KgEa_XAJpc8A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 1 Sep 2020 16:00:44 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 1 Sep 2020 16:00:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        "'Will Deacon'" <will@kernel.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        'Waiman Long' <longman@redhat.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Cooper' <andrew.cooper3@citrix.com>,
        'Andy Lutomirski' <luto@kernel.org>,
        'Christoph Hellwig' <hch@lst.de>
Subject: RE: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWfXGL4X8nWl6IwEyifUSeZx09HqlPCNzQgABwecCAAvQOAIABC1NggABTgICAABk0IA==
Date:   Tue, 1 Sep 2020 15:00:44 +0000
Message-ID: <0e91076ecda04055859b3ec32f8493ba@AcuMS.aculab.com>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
 <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
 <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
 <20200831173112.fjfnnup5cfc5t226@treble>
 <93873def6ede46f89fa33b3fc78876f6@AcuMS.aculab.com>
 <20200901142651.eir5nx4gpy63shlm@treble>
In-Reply-To: <20200901142651.eir5nx4gpy63shlm@treble>
Accept-Language: en-GB, en-US
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
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDEgU2VwdGVtYmVyIDIwMjAgMTU6MjcNCj4g
DQo+IE9uIFR1ZSwgU2VwIDAxLCAyMDIwIGF0IDA4OjMyOjIwQU0gKzAwMDAsIERhdmlkIExhaWdo
dCB3cm90ZToNCj4gPiA+IFllcywgaXQgd291bGQgbWFrZSBzZW5zZSB0byBwdXQgdGhlIG1hc2tp
bmcgaW4gYWNjZXNzX29rKCkgc29tZWhvdy4gIEJ1dA0KPiA+ID4gdG8gZG8gaXQgcHJvcGVybHks
IEkgdGhpbmsgd2UnZCBmaXJzdCBuZWVkIHRvIG1ha2UgYWNjZXNzX29rKCkgZ2VuZXJpYy4NCj4g
PiA+IE1heWJlIHRoYXQncyBkby1hYmxlLCBidXQgaXQgd291bGQgYmUgYSBtdWNoIGJpZ2dlciBw
YXRjaCBzZXQuDQo+ID4gPg0KPiA+ID4gRmlyc3QgSSdkIHByZWZlciB0byBqdXN0IGZpeCB4ODYs
IGxpa2UgbXkgcGF0Y2ggZG9lcy4gIFRoZW4gd2UgY291bGQgZG8NCj4gPiA+IGFuIGFjY2Vzc19v
aygpIHJld29yay4NCj4gPg0KPiA+IElmIHlvdSBkbyBhIG1vZGlmaWVkIGFjY2Vzc19vaygpIHlv
dSBnZXQgdG8gKHNsb3dseSkgY29sbGVjdCBhbGwNCj4gPiB0aGUgaW1wb3J0YW50IHBhdGhzLg0K
PiA+IE5vIHBvaW50IHJlcGxpY2F0aW5nIHRoZSBzYW1lIHRlc3QuDQo+ID4NCj4gPiBBIGxvdCBv
ZiB0aGUgYWNjZXNzX29rKCkgY2FuIGJlIGRlbGV0ZWQgLSBtYXliZSByZW1vdmUgc29tZSBfXw0K
PiA+IGZyb20gdGhlIGZvbGxvd2luZyBmdW5jdGlvbnMuDQo+ID4gT3IgY2hhbmdlIHRvIHRoZSB2
YXJpYW50cyB0aGF0IGVuYWJsZSB1c2VyLXNwYWNlIGFjY2Vzc2VzLg0KPiANCj4gV2VsbCwgeWVz
LCBidXQgdGhhdCdzIGEgbXVjaCBiaWdnZXIgam9iIHdoaWNoIGNhbiBiZSBkb25lIGxhdGVyLg0K
DQpJc24ndCB0aGlzIGFsbCByYXRoZXIgZGlmZmljdWx0IHRvIGV4cGxvaXQgdGhvdWdoPw0KKFVu
bGlrZSB0aGUgb3JpZ2luYWwgU3BlY3RyZSB3aGljaCB0cml2aWFsbHkgbGV0IGtlcm5lbA0KbWVt
b3J5IGJlIHJlYWQuKQ0KRG9uJ3QgeW91IG5lZWQgdG8gbWFuYWdlIHRvICdwcmVzZXQnIHRoZSBi
cmFuY2ggcHJlZGljdG9yIGFuZCBCVEINCnRvIHRoZSByaWdodCBzdGF0ZSBhbmQgdGhlbiBtYW5h
Z2Ugc29tZSBraW5kIG9mIHRpbWluZyBhdHRhY2sNCm9uIEwxIGNhY2hlPw0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K


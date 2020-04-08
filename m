Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F1C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA1920747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgDHJZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:25:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:22037 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgDHJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:25:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-103-umjWl9uwPP6HXCkUhJmNkA-1; Wed, 08 Apr 2020 10:25:46 +0100
X-MC-Unique: umjWl9uwPP6HXCkUhJmNkA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 8 Apr 2020 10:25:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 8 Apr 2020 10:25:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kiszka' <jan.kiszka@siemens.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kenny@panix.com" <kenny@panix.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "thellstrom@vmware.com" <thellstrom@vmware.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dcovelli@vmware.com" <dcovelli@vmware.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Subject: RE: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Thread-Topic: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Thread-Index: AQHWDYP6qgl1fjDEE0GOF/TmmkoV06hu88Kw
Date:   Wed, 8 Apr 2020 09:25:45 +0000
Message-ID: <a426788d340b477f8cc87a173a251fcb@AcuMS.aculab.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
 <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
 <20200408085138.GQ20713@hirez.programming.kicks-ass.net>
 <aa7a2547-9670-d04f-4ca0-ab52abf30441@siemens.com>
In-Reply-To: <aa7a2547-9670-d04f-4ca0-ab52abf30441@siemens.com>
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

RnJvbTogSmFuIEtpc3prYQ0KPiBTZW50OiAwOCBBcHJpbCAyMDIwIDA5OjU5DQouLi4NCj4gQXQg
dGhlIHJpc2sgb2YgY3V0dGluZyBvdXIgb3duIGJyYW5jaCBvZmY6IFRoYXQncyBub3QgdGhlIGZp
cm13YXJlDQo+IGxvYWRlciwgaXQncyBpb3JlbWFwIHdpdGggUEFHRV9LRVJORUxfRVhFQy4NCg0K
WW91IGNvdWxkIGxpbmsgdGhlICdibG9iJyBpbnRvIHRoZSAudGV4dCBwYXJ0IG9mIGEgbm9ybWFs
DQprZXJuZWwgbW9kdWxlIGFuZCB0aGVuIGxvYWQgdGhhdC4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


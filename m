Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBD5C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5112073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbgDCQQn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:16:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37247 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404035AbgDCQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:16:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-6-twe0tjGPOHmUDCCDvyBmWw-1;
 Fri, 03 Apr 2020 17:16:39 +0100
X-MC-Unique: twe0tjGPOHmUDCCDvyBmWw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 3 Apr 2020 17:16:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 Apr 2020 17:16:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Topic: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Index: AQHWCdKtcG9rEqgOYkCfAyvrdM/+1ahnkoQA
Date:   Fri, 3 Apr 2020 16:16:38 +0000
Message-ID: <7b83b632e41c48698ab892b07673f42d@AcuMS.aculab.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
 <20200403143459.GA30424@linux-8ccs>
 <20200403152158.GR20730@hirez.programming.kicks-ass.net>
 <20200403160156.GA2701@linux.intel.com>
 <20200403161205.GT20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200403161205.GT20730@hirez.programming.kicks-ass.net>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 03 April 2020 17:12
> On Fri, Apr 03, 2020 at 09:01:56AM -0700, Sean Christopherson wrote:
> > On Fri, Apr 03, 2020 at 05:21:58PM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:
> 
> > > > I wonder if it would make sense then to limit the text scans to just
> > > > out-of-tree modules (i.e., missing the intree modinfo flag)?
> > >
> > > It would; didn't know there was one.
> >
> > Rather than scanning modules at all, what about hooking native_write_cr4()
> > to kill SLD if CR4.VMXE is toggled on and the caller didn't increment a
> > "sld safe" counter?
> 
> And then you're hoping that the module uses that and not:
> 
>   asm volatile ("mov %0, cr4" :: "r" (val));
> 
> I think I feel safer with the scanning to be fair. Also with the intree
> hint on, we can extend the scanning for out-of-tree modules for more
> dodgy crap we really don't want modules to do, like for example the
> above.

Could you do the scanning in the last phase of the module build
that has to be done against the target kernel headers and with the
target kernel build infrastructure?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


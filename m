Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17968C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6206206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgHPB3O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 21:29:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45629 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgHPB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:29:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-83-xLw69Pq4OQiatc_ar3rOUw-1; Sat, 15 Aug 2020 10:25:17 +0100
X-MC-Unique: xLw69Pq4OQiatc_ar3rOUw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 15 Aug 2020 10:25:17 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 15 Aug 2020 10:25:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Thread-Topic: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Thread-Index: AQHWcpX67byqAvXV2kG6Q82PT/3E2ak45Ocg
Date:   Sat, 15 Aug 2020 09:25:16 +0000
Message-ID: <2777285d9e224c509e10b8448844f19a@AcuMS.aculab.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
         <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
         <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
         <20200813051853.GA510@jagdpanzerIV.localdomain>
         <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
         <20200813115435.GB483@jagdpanzerIV.localdomain>
         <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
 <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
In-Reply-To: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches
> Sent: 15 August 2020 00:52
...
> > This is why I think any discussion that says "people should buffer
> > their lines themselves and we should get rid if pr_cont()" is
> > fundamentally broken.
> >
> > Don't go down that hole. I won't take it. It's wrong.
> 
> I don't think it's wrong per se.
> 
> It's reasonable to avoid pr_cont when appropriate.
> 
> Trivial buffering, or adding and using YA vsprintf
> extension can avoid unnecessary message interleaving.
> 
> For instance, I just sent this patch to allow removal
> of print_vma_addr and its use of pr_cont.
> 
> https://lore.kernel.org/lkml/09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com/

ISTM that is a bit complex for a printf format.
Even with the 'noinline_for_stack' it is going to
use a lot of stack - and error printfs are already likely
to be near the stack limit.
The recursion for %pV might also cause grief.

In that case formatting the data into an on-stack char[]
before the printf is probably the simplest solution.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


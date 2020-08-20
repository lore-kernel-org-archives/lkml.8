Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB565C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA976207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHTHo3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:44:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52664 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbgHTHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:44:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-79-EZQzNz_MMTW5m19NmXdomw-1; Thu, 20 Aug 2020 08:44:24 +0100
X-MC-Unique: EZQzNz_MMTW5m19NmXdomw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 20 Aug 2020 08:44:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 20 Aug 2020 08:44:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/5] printk: implement pr_cont_t
Thread-Topic: [RFC PATCH 1/5] printk: implement pr_cont_t
Thread-Index: AQHWdomYXzVvufyPxEOt+PNltcCbQKlAmzJg
Date:   Thu, 20 Aug 2020 07:44:23 +0000
Message-ID: <b17fc8afc8984fedb852921366190104@AcuMS.aculab.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-2-john.ogness@linutronix.de>
 <e1e3164eabf69e04ad9e9ddc259ca685f48c5e27.camel@perches.com>
In-Reply-To: <e1e3164eabf69e04ad9e9ddc259ca685f48c5e27.camel@perches.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches
> Sent: 20 August 2020 01:34
> 
> On Thu, 2020-08-20 at 01:32 +0206, John Ogness wrote:
> > Implement a new buffering mechanism for pr_cont messages.
> >
> > Old mechanism syntax:
> >
> >     printk(KERN_INFO "text");
> >     printk(KERN_CONT " continued");
> >     printk(KERN_CONT "\n");
> >
> > New mechanism syntax:
> >
> >     pr_cont_t c;
> >
> >     pr_cont_begin(&c, KERN_INFO "text");
> 
> bikeshed:
> 
> I suggest:
> 
> 	printk_begin(&printk_context, fmt, ...)
> 	printk_continue(&printk_context, fmt, ...) (maybe printk_next())
> 	printk_end(&printk_context, fmt, ...)

I see some very long source lines looming ...

Blue bikeshed:

You'd probably want printk_end(&ctx, NULL) to work.
Although the example doesn't show where the '\n' comes from.
Although I guess it is now inferred and actually deleted
from 'normal' printk() call.

I've no idea how you'd 'size' the number of buffers.
You could use kmalloc(), perhaps falling back on a local buffer.
While might lead to:
	pr_init(&ctx, level, GFP_KERNEL);
	pr_cont(&ctx, fmt, ...);
	pr_flush(&ctx);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


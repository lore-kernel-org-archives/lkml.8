Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0780E20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgHTMdd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:33:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27665 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729745AbgHTMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:33:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-nhtq2MljN_maCPHdjtnu_A-1; Thu, 20 Aug 2020 13:33:23 +0100
X-MC-Unique: nhtq2MljN_maCPHdjtnu_A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 20 Aug 2020 13:33:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 20 Aug 2020 13:33:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/5] printk: implement pr_cont_t
Thread-Topic: [RFC PATCH 1/5] printk: implement pr_cont_t
Thread-Index: AQHWdtr1XzVvufyPxEOt+PNltcCbQKlA7OUQ
Date:   Thu, 20 Aug 2020 12:33:23 +0000
Message-ID: <fb47baa77ff940e99224feac85a2f2d7@AcuMS.aculab.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
 <20200820101625.GE4353@alley>
In-Reply-To: <20200820101625.GE4353@alley>
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

From: Petr Mladek
> Sent: 20 August 2020 11:16
...
> Now that I think about it. This is the biggest problem with any temporary buffer
> for pr_cont() lines. I am more and more convinced that we should just
> _keep the current behavior_. It is not ideal. But sometimes mixed
> messages are always better than lost ones.

Maybe a marker to say 'more expected' might be useful.
OTOH lack of a trailing '\n' probably signifies that a
pr_cont() is likely to be next.

Unexpected pr_cont() could be output with a leading "... "
to help indicate the message is a continuation.

> That said, some printk() API using local buffer would be still
> valuable for pieces of code where people really want to avoid
> mixed lines. But it should be optional and people should be
> aware of the risks.

That could be very useful if it supported multi-line output.
Thing like the stack backtrace code could use it avoid
the mess that happens when multiple processes generate
tracebacks at the same time.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


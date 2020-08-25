Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A187EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D7204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHYNls convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:41:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:38022 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbgHYNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:39:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-120-Q2tOW2ynOK-Wf1K_ok_aug-1; Tue, 25 Aug 2020 14:38:57 +0100
X-MC-Unique: Q2tOW2ynOK-Wf1K_ok_aug-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 14:38:57 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 14:38:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>
CC:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/5] printk: implement pr_cont_t
Thread-Topic: [RFC PATCH 1/5] printk: implement pr_cont_t
Thread-Index: AQHWdtr1XzVvufyPxEOt+PNltcCbQKlA7OUQgAfW5YCAABOKsA==
Date:   Tue, 25 Aug 2020 13:38:57 +0000
Message-ID: <0f3e3efffad64739a223273cc7c738bc@AcuMS.aculab.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
 <20200820101625.GE4353@alley>
 <fb47baa77ff940e99224feac85a2f2d7@AcuMS.aculab.com>
 <20200825131041.GV4353@alley>
In-Reply-To: <20200825131041.GV4353@alley>
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
> Sent: 25 August 2020 14:11
> 
> On Thu 2020-08-20 12:33:23, David Laight wrote:
> > From: Petr Mladek
> > > Sent: 20 August 2020 11:16
> > ...
> > > Now that I think about it. This is the biggest problem with any temporary buffer
> > > for pr_cont() lines. I am more and more convinced that we should just
> > > _keep the current behavior_. It is not ideal. But sometimes mixed
> > > messages are always better than lost ones.
> >
> > Maybe a marker to say 'more expected' might be useful.
> > OTOH lack of a trailing '\n' probably signifies that a
> > pr_cont() is likely to be next.
> 
> The problem is the "probably". Lack of trailing '\n' might also mean
> that the author did not care. Note that newline is not strictly
> required at the moment. The next message is concatenated only when
> pr_cont() is used from the same process.

Thinks.... (smoke comes out of ears...):
If the 'trace entry' contained the pid and whether it was a pr_cont
then the trace reader could merge continuation lines even if
there was a small number of interleaved other traces.

So anything reading continuously might break a continuation
(as might happen if there is a trace from an ISR).
But the output from dmesg and /var/log/messages will
almost always be correct.

This moves all the complexity away from the trace writing code.

> I would personally hate printk when I debugged some hard-to-reproduce
> bug, finally succeeded, and some message was missing just because
> of a missing newline.

My annoyance is that I want printk() to come out on the console
(like it used to 30 years ago).
I don't want the console output to be from a syslogd process.
On SYSV killing syslogd (mostly) did the trick.
x86 is annoying because you need to have setup a serial console
(or have a high speed camera pointing at the vga monitor).

> > Unexpected pr_cont() could be output with a leading "... "
> > to help indicate the message is a continuation.
> 
> Interesting idea. It might help to catch broken code. Well, I am still
> not sure that people would appreciate this printk() behavior.

I was thinking of just catching the case where pr_cont()
data can't be appended to the earlier line.

For direct tty output this would happen if an intervening
printk() had to add an extra '\n' to terminate the partial line.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


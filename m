Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D0A20409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgC3PeO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:34:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:35442 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728825AbgC3PeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:34:13 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-29-3T7qKML-MqukwX-6L-zRCQ-1; Mon, 30 Mar 2020 16:34:09 +0100
X-MC-Unique: 3T7qKML-MqukwX-6L-zRCQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Mar 2020 16:34:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Mar 2020 16:34:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: ftrace not showing the process names for all processes on syscall
 events
Thread-Topic: ftrace not showing the process names for all processes on
 syscall events
Thread-Index: AdYGnj+cWqFtVCqqTmCXgoqvHM5xrf///P+A///qkvA=
Date:   Mon, 30 Mar 2020 15:34:08 +0000
Message-ID: <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
 <20200330110855.437fe854@gandalf.local.home>
In-Reply-To: <20200330110855.437fe854@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 30 March 2020 16:09
> On Mon, 30 Mar 2020 14:28:01 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > I've just updated one of my systems to 5.6.0-rc7+ (end of last week).
> > ftrace in showing <...>-3179 in the system call events for a couple
> > of threads of the active processes.
> > Other threads of the same processes are fine.
> > The scheduler process switch events also show the full name.
> >
> > Is this a known regression?
> 
> 
> Well, that code hasn't changed in years. But can you explain more of what
> you did? Was this the "trace" file, or "trace_pipe" file? The command names
> are cached in an array (see /sys/kernel/tracing/saved_cmdlines) of the size
> that is defined by the saved_cmdlines_size file.

It was the 'trace' file - ie the text formatted by the kernel.
I've looked at a lot of traces over the last few weeks and not seen it before.
The workload is the same, so I assumed there might be a kernel change.
I've just updated from a 5.4-rc7 kernel to a 5.6-rc7 one.

> The cmdlines get updated via the sched_switch and sched_waking trace
> events. The update is protected by a spinlock, which is only taken with a
> "trylock", if the lock fails, then it does not get updated (we don't want
> to hold back the running code just to cache the name of an event), but it
> will try at the next sched event until it succeeds. This means that under
> strong contention, it may fail to cache certain names.

I've not got a silly number of context switches.
But it seemed to have consistently lost some process names even when they
went idle and then resumed.

I would have been tracing the schedule process wakeup and switch events,
system call entry/exit and irq+softirq.

> This is not a regression, it's really just the work load that can cause
> event names to be missed. I could work on something that if you have the
> sched events enabled, that the output side could do its own caching to get
> better results.

Ok if nothing has changed I'll stop worrying and work out what I've broken.

Oh, does the 'function_graph' code ignore tail calls?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


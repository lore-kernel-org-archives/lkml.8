Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F02C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FDF2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOM5P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:57:15 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:26466 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgAOM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:57:15 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-229-8hDPppHqO_qsVCTS73igrw-1; Wed, 15 Jan 2020 12:57:11 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jan 2020 12:57:10 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jan 2020 12:57:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Topic: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkAAAO3PAAAnruzA
Date:   Wed, 15 Jan 2020 12:57:10 +0000
Message-ID: <3960d46b3a4a4053a696a98ee6fd131d@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
        <20200114115906.22f952ff@gandalf.local.home>
        <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
 <20200114124812.4d5355ae@gandalf.local.home>
In-Reply-To: <20200114124812.4d5355ae@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 8hDPppHqO_qsVCTS73igrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt
> Sent: 14 January 2020 17:48
...
> > The cost of ftrace function call entry/exit (about 200 clocks) makes it
> > rather unsuitable for any performance measurements unless only
> > a very few functions are traced - which rather requires you know
> > what the code is doing :-(
> >
> 
> Well, when I use function tracing, I start all of them, analyze the
> trace, then the functions I don't care about (usually spin locks and
> other utils), I add to the set_ftrace_notrace file,  which keeps them
> from being part of the trace. I keep doing this until I find a set of
> functions that doesn't hurt overhead as much and gives me enough
> information to know what is happening. It also helps to enable all or
> most events (at least scheduling events).

I've been using schedviz - but have had to 'fixup' wrapped traces so that
all the cpu traces start at the same time to get it to load them.
I managed to find what the worker thread was running - but only
because it ran for the entire time 'echo t >/proc/sysrq-trigger' took
to finish. Then I looked at the sources to find the code...

I'm surprised the 'normal case' for tracing function entry isn't done
in assembler without saving all the registers (etc).
For tsc stamps I think it should be possible saving just 3 registers
in under 32 instructions. Scaling to ns is a bit harder.
It's a shame the ns scaling isn't left to the reading code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


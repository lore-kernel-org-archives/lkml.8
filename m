Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9347DC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5052465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANReA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:34:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37887 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgANReA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:34:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-48-ZhPI99vXO2Klxv0T-F0ggw-1; Tue, 14 Jan 2020 17:33:51 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 17:33:51 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Jan 2020 17:33:51 +0000
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
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkA=
Date:   Tue, 14 Jan 2020 17:33:50 +0000
Message-ID: <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
 <20200114115906.22f952ff@gandalf.local.home>
In-Reply-To: <20200114115906.22f952ff@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ZhPI99vXO2Klxv0T-F0ggw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 14 January 2020 16:59
> 
> On Tue, 14 Jan 2020 16:50:43 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > I've a test that uses four RT priority processes to process audio data every 10ms.
> > One process wakes up the other three, they all 'beaver away' clearing a queue of
> > jobs and the last one to finish sleeps until the next tick.
> > Usually this takes about 0.5ms, but sometimes takes over 3ms.
> >
> > AFAICT the processes are normally woken on the same cpu they last ran on.
> > There seems to be a problem when the selected cpu is running a (low priority)
> > process that is looping in kernel [1].
> > I'd expect my process to be picked up by one of the idle cpus, but this
> > doesn't happen.
> > Instead the process sits in state 'waiting' until the active processes sleeps
> > (or calls cond_resched()).
> >
> > Is this really the expected behaviour?????
> 
> It is with CONFIG_PREEMPT_VOLUNTARY. I think you want to recompile your
> kernel with CONFIG_PREEMPT. The idea is that the RT task will continue
> to run on the CPU it last ran on, and would push off the lower priority
> task to the idle CPU. But CONFIG_PREEMPT_VOLUNTARY means that this
> will have to wait for the running task to not be in kernel context or
> hit a cond_resched() which is the "voluntary" scheduling point.

I have added a cond_resched() to the offending loop, but a close look implies
that code is called with a lock held in another (less common) path so that
can't be directly committed and so CONFIG_PREEMPT won't help.

Indeed requiring CONFIG_PREEMPT doesn't help when customers are running
the application, nor (probably) on AWS since I doubt it is ever the default.

Does the same apply to non-RT tasks?
I can select almost any priority, but RT ones are otherwise a lot better.

I've also seen RT processes delayed by the network stack 'bh' that runs
in a softint from the hardware interrupt.
That can take a while (clearing up tx and refilling rx) and I don't think we
have any control over the cpu it runs on?

The cost of ftrace function call entry/exit (about 200 clocks) makes it
rather unsuitable for any performance measurements unless only
a very few functions are traced - which rather requires you know
what the code is doing :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


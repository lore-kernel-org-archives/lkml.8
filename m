Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE102C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0D92465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAOMoZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:44:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35849 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgAOMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:44:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-10-dGzufp_XNGKEFWd_Sp1x8w-1; Wed, 15 Jan 2020 12:44:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jan 2020 12:44:19 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jan 2020 12:44:19 +0000
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
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkAAAO3PAAAmXEgg
Date:   Wed, 15 Jan 2020 12:44:19 +0000
Message-ID: <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
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
X-MC-Unique: dGzufp_XNGKEFWd_Sp1x8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 14 January 2020 17:48
> 
> On Tue, 14 Jan 2020 17:33:50 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > I have added a cond_resched() to the offending loop, but a close look implies
> > that code is called with a lock held in another (less common) path so that
> > can't be directly committed and so CONFIG_PREEMPT won't help.
> >
> > Indeed requiring CONFIG_PREEMPT doesn't help when customers are running
> > the application, nor (probably) on AWS since I doubt it is ever the default.
> >
> > Does the same apply to non-RT tasks?
> > I can select almost any priority, but RT ones are otherwise a lot better.
> >
> > I've also seen RT processes delayed by the network stack 'bh' that runs
> > in a softint from the hardware interrupt.
> > That can take a while (clearing up tx and refilling rx) and I don't think we
> > have any control over the cpu it runs on?
> 
> Yes, even with CONFIG_PREEMPT, Linux has no guarantees of latency for
> any task regardless of priority. If you have latency requirements, then
> you need to apply the PREEMPT_RT patch (which may soon make it to
> mainline this year!), which spin locks and bh wont stop a task from
> scheduling (unless they need the same lock)

We're not trying to do anything life-threatening.
So the latency requirements are only moderate - failures mess up telephone
audio quality. There is also allowance for jitter elsewhere.
OTOH not running a high priority process when there are idle cpu seems 'sub-optimal'.

Code that runs with a spin-lock held (or otherwise disables preemption)
for significant periods probably ought to be detected and warned.
I'm not sure of a suitable limit, 100us is probably excessive on x86.

IIUC PREEMPT_RT adds overhead to quite a bit of code and is unlikely
to get enabled in 'distro' kernels.
Especially since they've not enabled CONFIG_PREEMPT which probably
has a lower impact - provided the cv+mutex wakeup has been arranged
to avoid the treble process switch.

Running the driver bh (which is often significant) from a high priority
worker thread instead of a softint (which isn't much different to the
'hardint' it is scheduled from) probably doesn't cost much (in-kernel
process switches shouldn't be much more than a stack switch).
That would benefit RT processes since they could be higher
priority than the bh code.
Although you'd probably want a 'strongly preferred' cpu for them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


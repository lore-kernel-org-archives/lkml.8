Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C3FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EF924671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgAORHe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:07:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:26056 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728896AbgAORHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:07:34 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-eVLAgkoGOnKRkGAs5C3fYw-1; Wed, 15 Jan 2020 17:07:30 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jan 2020 17:07:29 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jan 2020 17:07:29 +0000
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
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkAAAO3PAAAmXEggAAKDBAAAAvfesAABpyOAAABDBiA=
Date:   Wed, 15 Jan 2020 17:07:29 +0000
Message-ID: <ab54668ad13d48da8aa43f955631ef9e@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
        <20200114115906.22f952ff@gandalf.local.home>
        <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
        <20200114124812.4d5355ae@gandalf.local.home>
        <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
        <20200115081830.036ade4e@gandalf.local.home>
        <9f98b2dd807941a3b85d217815a4d9aa@AcuMS.aculab.com>
 <20200115103049.06600f6e@gandalf.local.home>
In-Reply-To: <20200115103049.06600f6e@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: eVLAgkoGOnKRkGAs5C3fYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Steven Rostedt
> Sent: 15 January 2020 15:31
...
> > For this case an idle cpu doing a unlocked check for a processes that has
> > been waiting 'ages' to preempt the running process may not be too
> > expensive.
> 
> How do you measure a process waiting for ages on another CPU? And then
> by the time you get the information to pull it, there's always the race
> that the process will get the chance to run. And if you think about it,
> by looking for a process waiting for a long time, it is likely it will
> start to run because "ages" means it's probably close to being released.

Without a CBU (Crystal Ball Unit) you can always be unlucky.
But once you get over the 'normal' delays for a system call you probably
get an exponential (or is it logarithmic) distribution and the additional
delay is likely to be at least some fraction of the time it has already waited.

While not entirely the same, but something I still need to look at further.
This is a histogram of time taken (in ns) to send on a raw IPv4 socket.
0k: 1874462617
96k: 260350
160k: 30771
224k: 14812
288k: 770
352k: 593
416k: 489
480k: 368
544k: 185
608k: 63
672k: 27
736k: 6
800k: 1
864k: 2
928k: 3
992k: 4
1056k: 1
1120k: 0
1184k: 1
1248k: 1
1312k: 2
1376k: 3
1440k: 1
1504k: 1
1568k: 1
1632k: 4
1696k: 0 (5 times)
2016k: 1
2080k: 0
2144k: 1
total: 1874771078, average 32k

I've improved it no end by using per-thread sockets and setting
the socket write queue size large.
But there are still some places where it takes > 600us.
The top end is rather more linear than one might expect.

> > I presume the locks are in place for the migrate itself.
> 
> Note, by grabbing locks on another CPU will incur overhead on that
> other CPU. I've seen huge latency caused by doing just this.

I'd have thought this would only be significant if the cache line
ends up being used by both cpus?

> > The only downside is that the process's data is likely to be in the wrong cache,
> > but unless the original cpu becomes available just after the migrate it is
> > probably still a win.
> 
> If you are doing this with just tasks that are waiting for the CPU to
> be preemptable, then it is most likely not a win at all.

You'd need a good guess that the wait would be long.

> Now, the RT tasks do have an aggressive push / pull logic, that keeps
> track of which CPUs are running lower priority tasks and will work hard
> to keep all RT tasks running (and aggressively migrate them). But this
> logic still only takes place at preemption points (cond_resched(), etc).

I guess this only 'gives away' extra RT processes.
Rather than 'stealing' them - which is what I need.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


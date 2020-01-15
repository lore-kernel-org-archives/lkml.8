Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A36C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5384B2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgAOPKA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:10:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31841 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbgAOPKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:10:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-0IKbv8msNxKpwXV72oqKfw-1; Wed, 15 Jan 2020 15:09:57 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jan 2020 15:09:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jan 2020 15:09:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     'Steven Rostedt' <rostedt@goodmis.org>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Topic: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkAAAO3PAAAmXEggAAXxcIAAADWFcA==
Date:   Wed, 15 Jan 2020 15:09:56 +0000
Message-ID: <c285a1e190d34b76b235b7e48f70d841@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
 <20200114115906.22f952ff@gandalf.local.home>
 <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
 <20200114124812.4d5355ae@gandalf.local.home>
 <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
 <20200115145645.GM2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20200115145645.GM2827@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 0IKbv8msNxKpwXV72oqKfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
> Sent: 15 January 2020 14:57
> On Wed, Jan 15, 2020 at 12:44:19PM +0000, David Laight wrote:
> 
> > Code that runs with a spin-lock held (or otherwise disables preemption)
> > for significant periods probably ought to be detected and warned.
> > I'm not sure of a suitable limit, 100us is probably excessive on x86.
> 
> Problem is, without CONFIG_PREEMPT_COUNT (basically only
> PREEMPT/PREEMPT_RT) we can't even tell.
> 
> And I think we tried adding warnings to things like softirq, but then we
> get into arguments with the pure performance people on how allowing it
> longer will make their benchmarks go faster.

The interval would have to be a sysctl - like the one for sleeping uninterruptibly.
(Although that one is a pain for some kernel threads. I'd like to be able to
mark some uninterruptible sleeps as 'long term' and also not affecting the load
average.)

I remember (a long time ago) adding code to an ethernet driver to limit it
to 90% of the bandwidth to allow other systems to transmit (10M HDX).
Someone said ' we can't do that, people expect 100%', a week later he
asked me how to enable it because the AMD Lance could never transmit
if receiving back to back packets  (eg in promiscuous mode).
Benchmarks are a PITA....

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


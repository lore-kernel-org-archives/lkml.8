Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A6EC3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7B22086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 23:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBPXjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 18:39:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgBPXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 18:39:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2008F328;
        Sun, 16 Feb 2020 15:39:04 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D563F6CF;
        Sun, 16 Feb 2020 15:39:02 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Replace zero-length array with flexible-array
 member
To:     Joe Perches <joe@perches.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200213151951.GA32363@embeddedor>
 <20200213164518.GI14914@hirez.programming.kicks-ass.net>
 <9d516501-2624-f915-32be-13ba6f881019@embeddedor.com>
 <20200213170639.GK14914@hirez.programming.kicks-ass.net>
 <c7df22d3f248c784e8960841c79fe2836d7ea8ab.camel@perches.com>
 <1d420ee4-7078-26d9-83ad-eb5f12106116@arm.com>
 <cb37f342635b045639d877034c9f6d175b5d80cd.camel@perches.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a92cb1a6-6b58-6cd5-5629-d9c3f3d28a19@arm.com>
Date:   Sun, 16 Feb 2020 23:38:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cb37f342635b045639d877034c9f6d175b5d80cd.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 02:05, Joe Perches wrote:
> Nice.
> It would miss a few forms like:
> 
> 	typedef struct tagfoo {
> 		...
> 		type t[0];
> 	} foo;
> 
> and
> 
> 	struct {
> 		...
> 		type t[0];
> 	} foo;
> 
> and
> 
> 	struct foo {
> 		...
> 		type t[0];
> 	} *foo;
> 
> etc...
> 
> 

Right! Digging around for some examples on handling typedefs & co I stumbled
on this construct:

T {
   <blah>
};

This matches your typedef case, but none of the other two. I haven't found
a nice way to match them without listing down some special cases, which I
don't really like.

I might dig around sometime to figure out how this should be expressed; in
the meantime a simple 'grep -r "\[0\];"' will most likely yield faster results
(for hunting down ZLAs, that is).

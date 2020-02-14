Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71BDC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72741217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBNAZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:25:10 -0500
Received: from foss.arm.com ([217.140.110.172]:55150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNAZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:25:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 235EE328;
        Thu, 13 Feb 2020 16:25:10 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A57A33F68E;
        Thu, 13 Feb 2020 16:25:08 -0800 (PST)
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1d420ee4-7078-26d9-83ad-eb5f12106116@arm.com>
Date:   Fri, 14 Feb 2020 00:25:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c7df22d3f248c784e8960841c79fe2836d7ea8ab.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2020 22:02, Joe Perches wrote:
> That might be a somewhat difficult thing to add to checkpatch
> as it is effectively a per-line scanner:
> 
> Try something like:
> 
> $ git grep -P -A1 '^\s*(?!return)(\w+\s+){1,3}\w+\[0\];' -- '*.[ch]'
> 
> and look at the results.
> 
> In checkpatch that could be something like:
> 
> 	if ($line =~ /^.\s*$Type\s+$Ident\s*\[\s*0\s*\]\s*;/) {
> 		warn...
> 	}
> 

So FWIW I felt like doing some coccinelle and ended up with this:

This patches up valid ZLAs:
  $ spatch -D patch zero_length_array.cocci kernel/sched/fair.c

This prints out the location of invalid ZLAs:
  $ spatch -D report zero_length_array.cocci kernel/sched/fair.c

---
virtual patch
virtual report

@valid_zla depends on patch@
identifier struct_name;
type T;
identifier zla;
position pos;
@@
struct struct_name {
       ...
       T zla@pos
- [0];
+ [];
};

@invalid_zla depends on report@
identifier struct_name;
type T1;
identifier zla;
type T2;
identifier tail;
position pos;
@@
struct struct_name {
       ...
       T1 zla[0]@pos;
       T2 tail;
       ...
};

@script:python depends on invalid_zla@
pos << invalid_zla.pos;
@@
coccilib.report.print_report(pos[0], "Invalid ZLA!");
---
 

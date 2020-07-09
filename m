Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2013C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B582076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGIMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:43:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIMnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:43:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F386BAC2E;
        Thu,  9 Jul 2020 12:43:38 +0000 (UTC)
Message-ID: <1594298618.15464.147.camel@suse.cz>
Subject: Re: [LKP] [x86, sched] 1567c3e346: vm-scalability.median -15.8%
 regression
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Date:   Thu, 09 Jul 2020 14:43:38 +0200
In-Reply-To: <f8fc9530-432f-0b5d-0109-916a01c65bda@linux.intel.com>
References: <20200306051916.GA23395@xsang-OptiPlex-9020>
         <a5b0b58d-54a9-0f06-c822-3087346a0ae8@linux.intel.com>
         <1587018059.32139.22.camel@suse.cz>
         <fdcab17c-91aa-fba0-65d1-c08af6f50842@linux.intel.com>
         <f8fc9530-432f-0b5d-0109-916a01c65bda@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-07 at 10:58 +0800, Xing Zhengjun wrote:
> 
> On 6/12/2020 4:11 PM, Xing Zhengjun wrote:
> > Hi Giovanni,
> > 
> >     I test the regression, it still existed in v5.7.  Do you have time 
> > to take a look at this? Thanks.
> > 
> 
> Ping...
> 

Hello,

I haven't sat down to reproduce this yet but I've read the benchmark code and
configuration, and this regression seems likely to be more of a benchmarking
artifact than an actual performance bug.

Likely a benchmarking artifact:

First off, the test used the "performance" governor from the "intel_pstate"
cpufreq driver, but points at the patch introducing the "frequency invariance
on x86" feature as the culprit. This is suspicious because "frequency
invariance on x86" influences frequency selection when the "schedutil" governor
is in use (not your case). It may also affect the scheduler load balancing but
here you have $NUM_CPUS processes so there isn't a lot of room for creativity
there, each CPU gets a process.

Some notes on this benchmark for my future reference:

The test in question is "anon-cow-seq" from "vm-scalability", which is based
on the "usemem" program originally written by Andrew Morton and exercises the
memory management subsystem. The invocation is:

    usemem --nproc $NUM_CPUS   \
	   --prealloc          \
	   --prefault          \
	   $SIZE

What this does is to create an anonymous mmap()-ing of $SIZE bytes in the main
process, fork $NUM_CPUS distinct child processes and have all of them scan the
mapping sequentially from byte 0 to byte N, writing 0, 1, 2, ..., N on the
region as they scan it, all together at the same time. So we have the "anon"
part (the mapping isn't file-backed), the "cow" part (the parent process
allocates the region, then each children copy-on-write's to it) and the "seq"
part (memory accesses happen sequentially from low to high address). The test
measures how quick this happens; I believe the regression happens in the
median time it takes a process to finish (or the median throughput, but $SIZE
is fixed so it's equivalent).

The $SIZE parameter is selected so that there is enough space for everybody:
each children plus the parent need a copy of the mapped region, so that makes
$NUM_CPUS+1 instances. The formula for $SIZE adds a factor 2 for good measure:

    SIZE = $MEM_SIZE / ($NUM_CPUS + 1) / 2

So we have a benchmark dominated by page allocation and copying, run with the
"performance" cpufreq governor, and your bisections points to a commit such as
1567c3e3467cddeb019a7b53ec632f834b6a9239 ("x86, sched: Add support for
frequency invariance") which:

* changes how frequency is selected by a governor you're not using
* doesn't touch the memory management subsystem or related functions

I'm not entirely dismissing your finding, just explaining why this analysis
hasn't been in my top priorities lately (plus, I've just returned from a 3
weeks vacation :). I'm curious too about what causes the test to go red, but
I'm not overly worried given the above context.


Thanks,
Giovanni Gherdovich

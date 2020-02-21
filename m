Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A1C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4413C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgBUIDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:03:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:39992 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbgBUIDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:03:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 00:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,467,1574150400"; 
   d="scan'208";a="229139800"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2020 00:03:26 -0800
Date:   Fri, 21 Feb 2020 16:03:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200221080325.GA67807@shbuild999.sh.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205125804.GM14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Feb 05, 2020 at 01:58:04PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 05, 2020 at 08:32:16PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -5.5% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 81ec3f3c4c4d78f2d3b6689c9816bfbdf7417dbb ("perf/x86: Add check_period PMU callback")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> 
> I'm fairly sure this bisect/result is bogus.


Hi Peter,

Some updates:

We checked more on this. We run 14 times test for it, and the
results are consistent about the 5.5% degradation, and we
run the same test on several other platforms, whose test results
are also consistent, though there are no such -5.5% seen.

We are also curious that the commit seems to be completely not
relative to this scalability test of signal, which starts a task
for each online CPU, and keeps calling raise(), and calculating
the run numbers.

One experiment we did is checking which part of the commit
really affects the test, and it turned out to be the change of
"struct pmu". Effectively, applying this patch upon 5.0-rc6 
which triggers the same regression.

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551..e1a0517 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -447,6 +447,11 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
 };

So likely, this commit changes the layout of the kernel text
and data, which may trigger some cacheline level change. From
the system map of the 2 kernels, a big trunk of symbol's address
changes which follow the global "pmu",

5.0-rc6-systemap:

ffffffff8221d000 d pmu
ffffffff8221d100 d pmc_reserve_mutex
ffffffff8221d120 d amd_f15_PMC53
ffffffff8221d160 d amd_f15_PMC50

5.0-rc6+pmu-change-systemap:

ffffffff8221d000 d pmu
ffffffff8221d120 d pmc_reserve_mutex
ffffffff8221d140 d amd_f15_PMC53
ffffffff8221d180 d amd_f15_PMC50

But we can hardly identify which exact symbol is responsible
for the change, as too many symbols are offseted. 

btw, we've seen similar case that an irrelevant commit changes
the benchmark, like a hugetlb patch improves pagefault test on
a platform that never uses hugetlb https://lkml.org/lkml/2020/1/14/150  

Thanks,
Feng

> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

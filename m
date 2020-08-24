Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE77C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87C52078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHXPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:33:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:35414 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgHXPdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:33:04 -0400
IronPort-SDR: +TfmPyKfnLsVBdlZ2mIoKaaNi4FNh123ZPXYVD3Es6Z7nDfljAytBSJXmtptHfE32ag77VLU6Z
 yhLwk9l3qRTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="217461720"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="217461720"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:33:03 -0700
IronPort-SDR: XranTRhlsgif1t8PbWVtUWdDHysa3lN/NNOzmc+ORXTYfgdNHmQT5wZzi3oUlNTzOY15r8ehgH
 GOEwBRyWJCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="443253444"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2020 08:33:01 -0700
Date:   Mon, 24 Aug 2020 23:33:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200824153300.GA56944@shbuild999.sh.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824151425.GF4794@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 05:14:25PM +0200, Borislav Petkov wrote:
> On Fri, Aug 21, 2020 at 10:02:59AM +0800, Feng Tang wrote:
> >   1de08dccd383 x86/mce: Add a struct mce.kflags field
> >   9554bfe403bd x86/mce: Convert the CEC to use the MCE notifier
> > 
> > And strange thing is after using gcc9 and debian10 rootfs, with same commits
> > the regression turns to a improvement,
> 
> How so?
 
My understanding is microbenchmark like will-it-scale is sensitive to the
alignments (text/data), we've found other simliar cases that with this 0day's
update (compiler, kernel config, rootfs), some other reported regression
can not be reproduced.

> > though the trend keeps, that if we
> > changes the kflags from __u64 to __u32, the performance will be no change.
> > 
> > Following is the comparing of regression, I also attached the perf-profile
> > for old and new commit (let me know if you need more data)
> > 
> > 
> > 9554bfe403bdfc08 1de08dccd383482a3e88845d355 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >     192362           -15.1%     163343        will-it-scale.287.processes
> >       0.91            +0.2%       0.92        will-it-scale.287.processes_idle
> >     669.67           -15.1%     568.50        will-it-scale.per_process_ops
> 
> This is the data from your previous measurement:
> 
> 9554bfe403bdfc08 1de08dccd383482a3e88845d355
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     668.00           -14.1%     573.75        will-it-scale.per_process_ops
> 
> If I'm reading it correctly, commit
> 
> 1de08dccd383 ("x86/mce: Add a struct mce.kflags field")
> 
> is still the slower one vs
>
> 9554bfe403bd ("x86/mce: Convert the CEC to use the MCE notifier")
> 
> Or am I misreading it?

Your reading is correct. With the original kernel (built back in April)
and old rootfs, the regression persists, just a small drift between 14.1%
and 15.1% (which is normal for will-it-scale), while the 15.1% was just
retested last week.

> 
> In any case, this really looks like what Tony said: this enlargement of
> struct mce pushes some variable into a cacheline-misaligned placement,
> causing it to bounce.

Yes, that's what we suspected. And I just did another try to force the
percpu mce structure aligned. And the regression seems to be gone (reduced
from 14.1% to 2%), which further proved it.

patch is:

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 43b1519..2c020ef 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -95,7 +95,7 @@ struct mca_config mca_cfg __read_mostly = {
 	.monarch_timeout = -1
 };
 
-static DEFINE_PER_CPU(struct mce, mces_seen);
+static DEFINE_PER_CPU_ALIGNED(struct mce, mces_seen);
 static unsigned long mce_need_notify;
 static int cpu_missing;
 
@@ -148,7 +148,7 @@ void mce_setup(struct mce *m)
 	m->microcode = boot_cpu_data.microcode;
 }
 
-DEFINE_PER_CPU(struct mce, injectm);
+DEFINE_PER_CPU_ALIGNED(struct mce, injectm);
 EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
> The $ 10^6 question is, which variable is that...

:)  Right, this is what I'm doing right now. Some test job is queued on
the test box, and it may needs some iterations of new patch. Hopefully we
can isolate some specific variable given some luck. 

Thanks,
Feng

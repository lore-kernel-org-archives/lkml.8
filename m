Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34652C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 04:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F99D20BED
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 04:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgGEEpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 00:45:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:45544 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgGEEpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 00:45:00 -0400
IronPort-SDR: uABskBoiHJq/qI2i3hpK2oOkQv23u2cxHR+Fzyr1Bbmy7XGDaFPSv/B5Bchqkc8zsFSnG9f2/X
 fTsF01DxGVJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="148798394"
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="scan'208";a="148798394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 21:44:59 -0700
IronPort-SDR: thEVfmRZ3ZZw0liNczR4rMmr918KhYJ2ydGxbvx2t6uPBTXS27XhY7a4El2hMbqJq5AuVd711p
 /MFx54Ixg5qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="scan'208";a="322875762"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2020 21:44:55 -0700
Date:   Sun, 5 Jul 2020 12:44:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cai@lca.pw,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200705044454.GA90533@shbuild999.sh.intel.com>
References: <1592725000-73486-4-git-send-email-feng.tang@intel.com>
 <20200702063201.GG3874@shao2-debian>
 <20200702071230.GA17007@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702071230.GA17007@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:12:30PM +0800, Feng Tang wrote:
> > <<<test_start>>>
> > tag=overcommit_memory01 stime=1593425044
> > cmdline="overcommit_memory"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> > overcommit_memory.c:116: INFO: MemTotal is 16394252 kB
> > overcommit_memory.c:118: INFO: SwapTotal is 268435452 kB
> > overcommit_memory.c:122: INFO: CommitLimit is 276632576 kB
> > mem.c:817: INFO: set overcommit_ratio to 50
> > mem.c:817: INFO: set overcommit_memory to 2
> > overcommit_memory.c:187: INFO: malloc 551061440 kB failed
> > overcommit_memory.c:208: PASS: alloc failed as expected
> > overcommit_memory.c:183: INFO: malloc 276632576 kB successfully
> > overcommit_memory.c:210: FAIL: alloc passed, expected to fail
> 
> Thanks for the report!
> 
> I took a rough look, and it all happens after changing the
> overcommit policy from a looser one to OVERCOMMIT_NEVER. I suspect 
> it is due to the same cause as the previous warning message reported
> by Qian Cai https://lore.kernel.org/lkml/20200526181459.GD991@lca.pw/ 
> 
> Will further check it.

I did reproduce the problem, and from the debugging, this should
be the same root cause as https://lore.kernel.org/lkml/20200526181459.GD991@lca.pw/
that loosing the batch cause some accuracy problem, and the solution of
adding some sync is still needed, which is dicussed in 

First thing I tried a simple patch of using percpucounter_sum_read, and
the problem can't be reproduced:

--- a/mm/util.c
+++ b/mm/util.c
@@ -845,7 +845,7 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 		allowed -= min_t(long, mm->total_vm / 32, reserve);
 	}
 
-	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
+	if (percpu_counter_sum(&vm_committed_as) < allowed)
 		return 0;
 error:
 	vm_unacct_memory(pages);
 

Then, I tried the sync patch we've discussed one month ago
https://lore.kernel.org/lkml/20200529154315.GI93879@shbuild999.sh.intel.com/  
with it, I run the case 200 times and the problem was not reproduced,
can we consider taking this patch?

Thanks,
Feng
 
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 0a4f54d..01861ee 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -44,6 +44,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
+void percpu_counter_sync(struct percpu_counter *fbc);
 
 static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
 {
@@ -172,6 +173,9 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 	return true;
 }
 
+static inline void percpu_counter_sync(struct percpu_counter *fbc)
+{
+}
 #endif	/* CONFIG_SMP */
 
 static inline void percpu_counter_inc(struct percpu_counter *fbc)
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a66595b..d025137 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -98,6 +98,20 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 }
 EXPORT_SYMBOL(percpu_counter_add_batch);
 
+void percpu_counter_sync(struct percpu_counter *fbc)
+{
+       unsigned long flags;
+       s64 count;
+
+       raw_spin_lock_irqsave(&fbc->lock, flags);
+       count = __this_cpu_read(*fbc->counters);
+       fbc->count += count;
+       __this_cpu_sub(*fbc->counters, count);
+       raw_spin_unlock_irqrestore(&fbc->lock, flags);
+}
+EXPORT_SYMBOL(percpu_counter_sync);
+
+
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
diff --git a/mm/util.c b/mm/util.c
index 98813da..8b9664e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -746,14 +746,23 @@ int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
+static  void sync_overcommit_as(struct work_struct *dummy)
+{
+	percpu_counter_sync(&vm_committed_as);
+}
+
 int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
+	if (ret == 0 && write) {
+		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
+			schedule_on_each_cpu(sync_overcommit_as);
+
 		mm_compute_batch();
+	}
 
 	pr_info("ocommit=%lld, real=%lld policy[%d] ratio=%d\n\n\n",
 			percpu_counter_read_positive(&vm_committed_as),



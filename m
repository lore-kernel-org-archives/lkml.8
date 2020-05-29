Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA96EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD81A20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgE2Pnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:43:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:40835 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgE2Pn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:43:29 -0400
IronPort-SDR: Ikx0xDRNK5fGH4BQAkDzcYAE8RwtkqiZbCQ8jw5H2PiLkq68ndeG3uH8Kb8H5ui6b9Dc4b7lUS
 MQoEHs4TnoWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 08:43:19 -0700
IronPort-SDR: srC30ffzLbQ3jwialOtTZE5LfJvYT+sa7fwFqW+TqkE923zTozhYOXCKPlnqUWHo7PZAVYjC+L
 UBQMdWz2sDXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="346301403"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2020 08:43:15 -0700
Date:   Fri, 29 May 2020 23:43:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Kleen, Andi" <andi.kleen@intel.com>, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200529154315.GI93879@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200528141802.GB1810@lca.pw>
 <20200528151020.GF93879@shbuild999.sh.intel.com>
 <E8ECBC65D0B2554DAD44EBE43059B3741A2BFEEC@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8ECBC65D0B2554DAD44EBE43059B3741A2BFEEC@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:21:36PM +0800, Kleen, Andi wrote:
> 
> 
> >If it's true, then there could be 2 solutions, one is to skip the WARN_ONCE as it has no practical value, as the real >check is the following code, the other is to rectify the percpu counter when the policy is changing to >OVERCOMMIT_NEVER.
> 
> I think it's better to fix it up when the policy changes. That's the right place. The WARN_ON might be useful to catch other bugs.

If we keep the WARN_ON, then the draft fix patch I can think of looks like:

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a66595b..02d87fc 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -98,6 +98,20 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 }
 EXPORT_SYMBOL(percpu_counter_add_batch);
 
+void percpu_counter_sync(struct percpu_counter *fbc)
+{
+	unsigned long flags;
+	s64 count;
+
+	raw_spin_lock_irqsave(&fbc->lock, flags);
+	count = __this_cpu_read(*fbc->counters);
+	fbc->count += count;
+	__this_cpu_sub(*fbc->counters, count);
+	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+}
+EXPORT_SYMBOL(percpu_counter_sync);
+
+
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
diff --git a/mm/util.c b/mm/util.c
index 580d268..24322da 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -746,14 +746,24 @@ int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
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
 
 	return ret;
 }

Any comments?

Thanks,
Feng

> -Andi
>  

Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E0C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF145207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgGJOCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:02:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:10795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgGJOCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:02:20 -0400
IronPort-SDR: DY3PjzTLrwg9MacCTDREQmHNLrA1LoU9OCClFPrKsrFeVlGVY8lf5YTcRPzYUfspyH7RsrScLq
 Ipbonaj+w3+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146267641"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="146267641"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 07:02:04 -0700
IronPort-SDR: Qtf614lvHJnTjh0kqbKNTaOneiygxtaXN5BrwNM3mQPllYWJ++pA7e7Yahs31ZT44+BhwyG6xo
 T+L6lyJHrjrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="458287180"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2020 07:02:00 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        Dennis Zhou <dennis@kernel.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v6 3/4] percpu_counter: add percpu_counter_sync()
Date:   Fri, 10 Jul 2020 22:01:47 +0800
Message-Id: <1594389708-60781-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
References: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_counter's accuracy is related to its batch size. For a percpu_counter
with a big batch, its deviation could be big, so when the counter's batch is
runtime changed to a smaller value for better accuracy, there could also be
requirment to reduce the big deviation.

So add a percpu-counter sync function to be run on each CPU.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
---
 include/linux/percpu_counter.h |  4 ++++
 lib/percpu_counter.c           | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index a66595b..a2345de 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -99,6 +99,25 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 EXPORT_SYMBOL(percpu_counter_add_batch);
 
 /*
+ * For percpu_counter with a big batch, the devication of its count could
+ * be big, and there is requirement to reduce the deviation, like when the
+ * counter's batch could be runtime decreased to get a better accuracy,
+ * which can be achieved by running this sync function on each CPU.
+ */
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
+/*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
  */
-- 
2.7.4


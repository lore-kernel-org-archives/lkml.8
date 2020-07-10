Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013D1207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGJOCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:02:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:10795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJOCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:02:19 -0400
IronPort-SDR: q6efxPXTot55FplQ838oBEOLMxrjzlhoCvJO5Ow+TQCfU8NnNHzUjBMhfVOcIbvhtESflKcKOs
 ++mR+AhhF9Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146267631"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="146267631"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 07:02:00 -0700
IronPort-SDR: OTQC5lfVS8VaF2w6vI2VH1bmljaJYefPE78XlTvQ3xquRSU5Kz2DpvaNSN/jZt0WomWhfZIYKA
 vLS/stXmdl3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="458287130"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2020 07:01:56 -0700
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
Cc:     Feng Tang <feng.tang@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH v6 2/4] mm/util.c: make vm_memory_committed() more accurate
Date:   Fri, 10 Jul 2020 22:01:46 +0800
Message-Id: <1594389708-60781-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
References: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_counter_sum_positive() will provide more accurate info.

As with percpu_counter_read_positive(), in worst case the deviation could
be 'batch * nr_cpus', which is totalram_pages/256 for now, and will be
more when the batch gets enlarged.

Its time cost is about 800 nanoseconds on a 2C/4T platform and 2~3
microseconds on a 2S/36C/72T Skylake server in normal case, and in worst
case where vm_committed_as's spinlock is under severe contention, it costs
30~40 microseconds for the 2S/36C/72T Skylake sever, which should be fine
for its only two users: /proc/meminfo and HyperV balloon driver's status
trace per second.

Link: http://lkml.kernel.org/r/1592725000-73486-3-git-send-email-feng.tang@intel.com
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com> # for /proc/meminfo
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Qian Cai <cai@lca.pw>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index c856f5f..d076218 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -787,10 +787,15 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
  * balancing memory across competing virtual machines that are hosted.
  * Several metrics drive this policy engine including the guest reported
  * memory commitment.
+ *
+ * The time cost of this is very low for small platforms, and for big
+ * platform like a 2S/36C/72T Skylake server, in worst case where
+ * vm_committed_as's spinlock is under severe contention, the time cost
+ * could be about 30~40 microseconds.
  */
 unsigned long vm_memory_committed(void)
 {
-	return percpu_counter_read_positive(&vm_committed_as);
+	return percpu_counter_sum_positive(&vm_committed_as);
 }
 EXPORT_SYMBOL_GPL(vm_memory_committed);
 
-- 
2.7.4


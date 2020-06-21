Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED85BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83DF24872
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgFUHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 03:36:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:16490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgFUHgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:36:52 -0400
IronPort-SDR: 4g8fE2HOhrpAmPgP+yQkF7ZaobbxmUAOdDDTIPlNABUmHVnEWlOH8nKLoEhPIosAyCUnJ/UesX
 n0JVlrGBLnsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="204986791"
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="204986791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 00:36:52 -0700
IronPort-SDR: Eoxe27Qgas/5AxcjOz+orM3yoyS4wCnzWFHVAf5HL3mtPx9gks+PcISKWPj172HZBsG/O9VbkT
 H9kkx+X0isFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="478102527"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2020 00:36:48 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH v5 2/3] mm/util.c: make vm_memory_committed() more accurate
Date:   Sun, 21 Jun 2020 15:36:39 +0800
Message-Id: <1592725000-73486-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592725000-73486-1-git-send-email-feng.tang@intel.com>
References: <1592725000-73486-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_counter_sum_positive() will provide more accurate info.

As with percpu_counter_read_positive(), in worst case the deviation
could be 'batch * nr_cpus', which is totalram_pages/256 for now,
and will be more when the batch gets enlarged.

Its time cost is about 800 nanoseconds on a 2C/4T platform and 2~3
microseconds on a 2S/36C/72T Skylake server in normal case, and in
worst case where vm_committed_as's spinlock is under severe
contention, it costs 30~40 microseconds for the 2S/36C/72T Skylake
sever, which should be fine for its only two users: /proc/meminfo
and HyperV balloon driver's status trace per second.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com> # for /proc/meminfo
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>

---
 mm/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index c63c8e4..1c9d097 100644
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


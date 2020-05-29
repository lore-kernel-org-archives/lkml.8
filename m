Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90029C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B242078C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438315AbgE2BG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:06:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:2379 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438304AbgE2BGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:06:22 -0400
IronPort-SDR: W4H08RM+g9uyUieDuJVkzqwtHdGr1yvVrTVfvHWPuu1fSGG+uFpPxzCStXIhd0ZD8FFBu6wpUO
 yzUqfDEKSiMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 18:06:22 -0700
IronPort-SDR: XQoQpnrS+4xFfOoDQX7PM+NvMtEzY0KYWFvbVJVP6f3UZ1aedMbPSk0G7zOAjoXi/aB9lLwgtq
 o6qbvV0VJD8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="443187402"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 18:06:19 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        andi.kleen@intel.com, tim.c.chen@intel.com, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 2/4] mm/util.c: make vm_memory_committed() more accurate
Date:   Fri, 29 May 2020 09:06:08 +0800
Message-Id: <1590714370-67182-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_counter_sum_positive() will provide more accurate info.

As with percpu_counter_read_positive(), in worst case the deviation
could be 'batch * nr_cpus', which is totalram_pages/256 for now,
and will be more when the batch gets enlarged.

Its time cost is about 800 nanoseconds on a 2C/4T platform and
2~3 microseconds on a 2S/36C/72T server in normal case, and in
worst case where vm_committed_as's spinlock is under severe
contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
which should be fine for its only two users: /proc/meminfo and
HyperV balloon driver's status trace per second.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 9b3be03..3c7a08c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -790,7 +790,7 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
  */
 unsigned long vm_memory_committed(void)
 {
-	return percpu_counter_read_positive(&vm_committed_as);
+	return percpu_counter_sum_positive(&vm_committed_as);
 }
 EXPORT_SYMBOL_GPL(vm_memory_committed);
 
-- 
2.7.4


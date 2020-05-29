Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648E7206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438323AbgE2BG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:06:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:2379 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438312AbgE2BG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:06:26 -0400
IronPort-SDR: kEIJMm9qel9FpjkjNRI67hhCsolEkE/+RvGPxcZiWGUB+ae7HndrRjOToI0ftzD6usWzih2Hej
 OwoOf4NitAag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 18:06:26 -0700
IronPort-SDR: t9036NUhHUGwWveLlQIds2EuWb519n1VXvhfA4Y1WdfrsMoWv1eWHhzwMauuq1L5xjXAGhainG
 8jkg7yyatc3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="443187421"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 18:06:22 -0700
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
Cc:     Feng Tang <feng.tang@intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for vm_committed_as underflow check
Date:   Fri, 29 May 2020 09:06:09 +0800
Message-Id: <1590714370-67182-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As is explained by Michal Hocko:

: Looking at the history, this has been added by 82f71ae4a2b8
: ("mm: catch memory commitment underflow") to have a safety check
: for issues which have been fixed. There doesn't seem to be any bug
: reports mentioning this splat since then so it is likely just
: spending cycles for a hot path (yes many people run with DEBUG_VM)
: without a strong reason.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andi Kleen <andi.kleen@intel.com>
---
 mm/util.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 3c7a08c..fe63271 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -814,14 +814,6 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
 
-	/*
-	 * A transient decrease in the value is unlikely, so no need
-	 * READ_ONCE() for vm_committed_as.count.
-	 */
-	VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as) <
-			-(s64)vm_committed_as_batch * num_online_cpus()),
-			"memory commitment underflow");
-
 	vm_acct_memory(pages);
 
 	/*
-- 
2.7.4


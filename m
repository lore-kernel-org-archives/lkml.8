Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC3BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C23E2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f1EejFRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgH0Anf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:43:35 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:46840 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgH0Anb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598489011; x=1630025011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wDxB/VNmRm4ZX9/6Z+F1UfgtAa9IU/DR4ghr8IRJ3PE=;
  b=f1EejFRX2S6NEoXbHezYhw1fzTD3ycXwEylcw1UvDRd+93j9TSMCmFyB
   STiKBuLiLD8t4etZ8kd0AJKvGBCf5rUmSNy00LWxLiPgxVejllB3467zA
   QbZ2xVOBSa5OMS6gt6BAHh4CgY8K1L+5rl2XXFup7YKB6GFNmZtUq9hHN
   4=;
X-IronPort-AV: E=Sophos;i="5.76,357,1592870400"; 
   d="scan'208";a="51670639"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 Aug 2020 00:43:30 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 64BEEA0328;
        Thu, 27 Aug 2020 00:43:22 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:21 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.192) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:15 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <pjt@google.com>,
        <torvalds@linux-foundation.org>, <subhra.mazumdar@oracle.com>,
        <fweisbec@gmail.com>, <keescook@chromium.org>,
        <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, <joel@joelfernandes.org>,
        <vineethrp@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3] sched: Use hrticks even with >sched_nr_latency tasks
Date:   Thu, 27 Aug 2020 02:42:50 +0200
Message-ID: <20200827004250.4853-4-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827004250.4853-1-graf@amazon.com>
References: <20200827004250.4853-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D28UWC002.ant.amazon.com (10.43.162.145) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hrticks are enabled, we configure an hrtimer fire at the exact point
in time when we would like to have a rescheduling event occur.

However, the current code disables that logic when the number of currently
running tasks exceeds sched_nr_latency. sched_nr_latency describes the point
at which CFS resorts to giving each task sched_min_granularity slices.

However, these slices may well be smaller than the HZ tick and we thus may
still want to use hrticks to ensure that we can actually slice the CPU time
at sched_min_granularity.

This patch changes the logic to still enable hrticks if sched_min_granularity
is smaller than the HZ tick would allow us to account with. That way systems
with HZ=1000 will usually resort to the HZ tick while systems at lower HZ values
will keep using hrticks.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 66e7aae8b15e..0092bba52edf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5502,7 +5502,8 @@ static void hrtick_update(struct rq *rq)
 	if (!hrtick_enabled(rq) || curr->sched_class != &fair_sched_class)
 		return;
 
-	if (cfs_rq_of(&curr->se)->nr_running < sched_nr_latency)
+	if ((cfs_rq_of(&curr->se)->nr_running < sched_nr_latency) ||
+	    (sysctl_sched_min_granularity < (HZ * 1000000)))
 		hrtick_start_fair(rq, curr);
 }
 #else /* !CONFIG_SCHED_HRTICK */
-- 
2.26.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




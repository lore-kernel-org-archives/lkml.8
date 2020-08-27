Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEEF2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GkKQF1ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH0AnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:43:25 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:38276 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgH0AnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598489002; x=1630025002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8uPtiPXH/Jgki4atNOdOTtJAaKzwWyAfSqwtuH3gXbM=;
  b=GkKQF1tyG1aSkdEkHZCQ6Pg2ow5s1obBNjbyRfWrT1xGpRnqcWBYDpib
   MN85/Pu+x/F8tvpGqu2oyb1Qse+aqJErnW/w0h2Iux0hGkBzAgZryeukV
   AAGp2XuidM9TuE+U4gfYXCkyIyfII53SWgwSsD0qKIrw2+4s3a5of+/7O
   c=;
X-IronPort-AV: E=Sophos;i="5.76,357,1592870400"; 
   d="scan'208";a="50233984"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Aug 2020 00:43:18 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 26885A1F5E;
        Thu, 27 Aug 2020 00:43:16 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:15 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.192) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:10 +0000
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
Subject: [PATCH 2/3] sched: Trigger new hrtick if timer expires too fast
Date:   Thu, 27 Aug 2020 02:42:49 +0200
Message-ID: <20200827004250.4853-3-graf@amazon.com>
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

When an hrtick timer event occurs too quickly, we just bail out and don't
attempt to set a new hrtick timeout. That means that the time slice for
that particular task grows until the next HZ tick occurs. That again may
create significant jitter for the respective task, as it will not get
scheduled for as long as it executed before, to bring the overall queue's
vruntime into balance again.

With this patch, even a too early hrtick timer event will just reconfigure
the hrtick to when we expected it to fire, removing overall jitter from
the system.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d4ff3ab2572..66e7aae8b15e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -99,6 +99,8 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
+static void hrtick_update(struct rq *rq);
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
@@ -4458,8 +4460,10 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * narrow margin doesn't have to wait for a full slice.
 	 * This also mitigates buddy induced latencies under load.
 	 */
-	if (delta_exec < sysctl_sched_min_granularity)
+	if (delta_exec < sysctl_sched_min_granularity) {
+		hrtick_update(rq_of(cfs_rq));
 		return;
+	}
 
 	se = __pick_first_entity(cfs_rq);
 	delta = curr->vruntime - se->vruntime;
-- 
2.26.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




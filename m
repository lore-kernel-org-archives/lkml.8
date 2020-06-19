Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F31C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E7122256
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFSWCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgFSWCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:02:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B4822255;
        Fri, 19 Jun 2020 22:02:20 +0000 (UTC)
Date:   Fri, 19 Jun 2020 18:02:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, philip.li@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH] sched: Have BUG_ON() check if linker sched classes don't
 line up correctly
Message-ID: <20200619180219.0d558512@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

If the sched_class structures do not match how the compiler thinks they
are in an array, it can cause hard to debug bugs. Change the BUG_ON()
from making sure each of the sched classes are in the proper order, to
also making sure they are off by the proper amount.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7ad864dc3ac5..876d7ecdab52 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6635,12 +6635,13 @@ void __init sched_init(void)
 	unsigned long ptr = 0;
 	int i;
 
-	BUG_ON(&idle_sched_class > &fair_sched_class ||
-		&fair_sched_class > &rt_sched_class ||
-		&rt_sched_class > &dl_sched_class);
+	/* Make sure the linker didn't screw up */
+	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
+		&fair_sched_class + 1 != &rt_sched_class ||
+		&rt_sched_class + 1 != &dl_sched_class);
 
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class > &stop_sched_class);
+	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
 #endif
 
 	wait_bit_init();

Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334A9C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D472076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDHMUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49639 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgDHMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gu-00063o-P4; Wed, 08 Apr 2020 14:20:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 67D161C047B;
        Wed,  8 Apr 2020 14:20:24 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:24 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Remove redundant macro define
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200226124543.31986-2-valentin.schneider@arm.com>
References: <20200226124543.31986-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158634842404.28353.12034753755409518464.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c745a6212c9923eb2253f4229e5d7277ca3d9d8e
Gitweb:        https://git.kernel.org/tip/c745a6212c9923eb2253f4229e5d7277ca3d9d8e
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 26 Feb 2020 12:45:41 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:24 +02:00

sched/debug: Remove redundant macro define

Most printing macros for procfs are defined globally in debug.c, and they
are re-defined (to the exact same thing) within proc_sched_show_task().

Get rid of the duplicate defines.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200226124543.31986-2-valentin.schneider@arm.com
---
 kernel/sched/debug.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8331bc0..4670151 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -868,16 +868,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	SEQ_printf(m,
 		"---------------------------------------------------------"
 		"----------\n");
-#define __P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)F)
-#define P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)p->F)
 #define P_SCHEDSTAT(F) \
 	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)schedstat_val(p->F))
-#define __PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
 #define PN_SCHEDSTAT(F) \
 	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(p->F)))
 
@@ -963,11 +955,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.deadline);
 	}
 #undef PN_SCHEDSTAT
-#undef PN
-#undef __PN
 #undef P_SCHEDSTAT
-#undef P
-#undef __P
 
 	{
 		unsigned int this_cpu = raw_smp_processor_id();

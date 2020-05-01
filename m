Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEC6C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FEC24967
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgEASWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730545AbgEASWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D037CC061A0C;
        Fri,  1 May 2020 11:22:15 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaId-0003ZG-BZ; Fri, 01 May 2020 20:22:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B09481C0085;
        Fri,  1 May 2020 20:22:10 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:10 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Make sd->flags sysctl read-only
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415210512.805-3-valentin.schneider@arm.com>
References: <20200415210512.805-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158835733068.8414.14497697589045052478.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9818427c6270a9ce8c52c8621026fe9cebae0f92
Gitweb:        https://git.kernel.org/tip/9818427c6270a9ce8c52c8621026fe9cebae0f92
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 15 Apr 2020 22:05:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:39 +02:00

sched/debug: Make sd->flags sysctl read-only

Writing to the sysctl of a sched_domain->flags directly updates the value of
the field, and goes nowhere near update_top_cache_domain(). This means that
the cached domain pointers can end up containing stale data (e.g. the
domain pointed to doesn't have the relevant flag set anymore).

Explicit domain walks that check for flags will be affected by
the write, but this won't be in sync with the cached pointers which will
still point to the domains that were cached at the last sched_domain
build.

In other words, writing to this interface is playing a dangerous game. It
could be made to trigger an update of the cached sched_domain pointers when
written to, but this does not seem to be worth the trouble. Make it
read-only.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200415210512.805-3-valentin.schneider@arm.com
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index b3ac1c1..c6cc02a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -258,7 +258,7 @@ sd_alloc_ctl_domain_table(struct sched_domain *sd)
 	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, proc_dointvec_minmax);
 	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
 	/* &table[8] is terminator */

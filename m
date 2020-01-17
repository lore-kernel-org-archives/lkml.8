Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EB4C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BCF2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgAQKJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgAQKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:09:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYY-0005TH-CM; Fri, 17 Jan 2020 11:08:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5EBE41C19D2;
        Fri, 17 Jan 2020 11:08:42 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:42 -0000
From:   "tip-bot2 for Wei Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Reset watchdog on all CPUs while
 processing sysrq-t
Cc:     Wei Li <liwei391@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191226085224.48942-1-liwei391@huawei.com>
References: <20191226085224.48942-1-liwei391@huawei.com>
MIME-Version: 1.0
Message-ID: <157925572220.396.10027500952114963200.tip-bot2@tip-bot2>
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

Commit-ID:     02d4ac5885a18d326b500b94808f0956dcce2832
Gitweb:        https://git.kernel.org/tip/02d4ac5885a18d326b500b94808f0956dcce2832
Author:        Wei Li <liwei391@huawei.com>
AuthorDate:    Thu, 26 Dec 2019 16:52:24 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:20 +01:00

sched/debug: Reset watchdog on all CPUs while processing sysrq-t

Lengthy output of sysrq-t may take a lot of time on slow serial console
with lots of processes and CPUs.

So we need to reset NMI-watchdog to avoid spurious lockup messages, and
we also reset softlockup watchdogs on all other CPUs since another CPU
might be blocked waiting for us to process an IPI or stop_machine.

Add to sysrq_sched_debug_show() as what we did in show_state_filter().

Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20191226085224.48942-1-liwei391@huawei.com
---
 kernel/sched/debug.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579..879d3cc 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -751,9 +751,16 @@ void sysrq_sched_debug_show(void)
 	int cpu;
 
 	sched_debug_header(NULL);
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		/*
+		 * Need to reset softlockup watchdogs on all CPUs, because
+		 * another CPU might be blocked waiting for us to process
+		 * an IPI or stop_machine.
+		 */
+		touch_nmi_watchdog();
+		touch_all_softlockup_watchdogs();
 		print_cpu(NULL, cpu);
-
+	}
 }
 
 /*

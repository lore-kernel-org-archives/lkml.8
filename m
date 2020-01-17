Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02091C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85602467D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgAQKJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgAQKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYb-0005UV-3O; Fri, 17 Jan 2020 11:08:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B83291C19D6;
        Fri, 17 Jan 2020 11:08:43 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:43 -0000
From:   "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] watchdog: Remove soft_lockup_hrtimer_cnt and related code
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191218131720.4146aea2@xhacker.debian>
References: <20191218131720.4146aea2@xhacker.debian>
MIME-Version: 1.0
Message-ID: <157925572357.396.16669974473851122331.tip-bot2@tip-bot2>
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

Commit-ID:     db5793c5993d265fe6644b6638fcb0758f6b5347
Gitweb:        https://git.kernel.org/tip/db5793c5993d265fe6644b6638fcb0758f6b5347
Author:        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
AuthorDate:    Wed, 18 Dec 2019 05:31:25 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:19 +01:00

watchdog: Remove soft_lockup_hrtimer_cnt and related code

After commit 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u"
threads with cpu_stop_work"), the percpu soft_lockup_hrtimer_cnt is
not used any more, so remove it and related code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191218131720.4146aea2@xhacker.debian
---
 kernel/watchdog.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334e..0621301 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -173,7 +173,6 @@ static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
 static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
@@ -350,8 +349,6 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
  */
 static int softlockup_fn(void *data)
 {
-	__this_cpu_write(soft_lockup_hrtimer_cnt,
-			 __this_cpu_read(hrtimer_interrupts));
 	__touch_watchdog();
 	complete(this_cpu_ptr(&softlockup_completion));
 

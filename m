Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECCC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8C2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgATHIa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:08:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATHIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:08:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itRAa-0001vh-8R; Mon, 20 Jan 2020 08:08:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B6D581C19A6;
        Mon, 20 Jan 2020 08:08:19 +0100 (CET)
Date:   Mon, 20 Jan 2020 07:08:19 -0000
From:   "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Define sched_idle_cpu() only for SMP
 configurations
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cf0554f590687478b33914a4aff9f0e6a62886d44=2E15794?=
 =?utf-8?q?99907=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Cf0554f590687478b33914a4aff9f0e6a62886d44=2E157949?=
 =?utf-8?q?9907=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <157950409950.396.10173546303615983871.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     afa70d941f663c69c9a64ec1021bbcfa82f0e54a
Gitweb:        https://git.kernel.org/tip/afa70d941f663c69c9a64ec1021bbcfa82f0e54a
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Mon, 20 Jan 2020 11:29:05 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 20 Jan 2020 08:03:39 +01:00

sched/fair: Define sched_idle_cpu() only for SMP configurations

sched_idle_cpu() isn't used for non SMP configuration and with a recent
change, we have started getting following warning:

  kernel/sched/fair.c:5221:12: warning: ‘sched_idle_cpu’ defined but not used [-Wunused-function]

Fix that by defining sched_idle_cpu() only for SMP configurations.

Fixes: 323af6deaf70 ("sched/fair: Load balance aggressively for SCHED_IDLE CPUs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/f0554f590687478b33914a4aff9f0e6a62886d44.1579499907.git.viresh.kumar@linaro.org
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebf5095..fe4e0d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5218,10 +5218,12 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
+#ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
 	return sched_idle_rq(cpu_rq(cpu));
 }
+#endif
 
 /*
  * The enqueue_task method is called before nr_running is

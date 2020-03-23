Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F73C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A3920774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgCWNvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:51:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgCWNvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5CA8FEC;
        Mon, 23 Mar 2020 06:51:45 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F183C3F52E;
        Mon, 23 Mar 2020 06:51:44 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4 15/17] torture: Replace cpu_up/down with add/remove_cpu
Date:   Mon, 23 Mar 2020 13:51:08 +0000
Message-Id: <20200323135110.30522-16-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: Josh Triplett <josh@joshtriplett.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/torture.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7c13f5558b71..a479689eac73 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -97,7 +97,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_offl_attempts)++;
-	ret = cpu_down(cpu);
+	ret = remove_cpu(cpu);
 	if (ret) {
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
@@ -148,7 +148,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_onl_attempts)++;
-	ret = cpu_up(cpu);
+	ret = add_cpu(cpu);
 	if (ret) {
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
@@ -192,17 +192,18 @@ torture_onoff(void *arg)
 	for_each_online_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
-	if (!IS_MODULE(CONFIG_TORTURE_TEST))
+	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
 		for_each_possible_cpu(cpu) {
 			if (cpu_online(cpu))
 				continue;
-			ret = cpu_up(cpu);
+			ret = add_cpu(cpu);
 			if (ret && verbose) {
 				pr_alert("%s" TORTURE_FLAG
 					 "%s: Initial online %d: errno %d\n",
 					 __func__, torture_type, cpu, ret);
 			}
 		}
+	}
 
 	if (maxcpu == 0) {
 		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
-- 
2.17.1


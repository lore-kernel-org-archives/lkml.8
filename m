Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDD120848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCFOmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgCFOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEBB-0006P7-W6; Fri, 06 Mar 2020 15:42:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 290831C21D7;
        Fri,  6 Mar 2020 15:42:11 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:10 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Add callback to read per CPU
 thermal pressure
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-3-thara.gopinath@linaro.org>
References: <20200222005213.3873-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350573088.28353.8874204927022983561.tip-bot2@tip-bot2>
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

Commit-ID:     36a0df85d2e85e1929e8cd607e19243e5a2754e7
Gitweb:        https://git.kernel.org/tip/36a0df85d2e85e1929e8cd607e19243e5a2754e7
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:06 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:17 +01:00

sched/topology: Add callback to read per CPU thermal pressure

Introduce the arch_scale_thermal_pressure() callback to retrieve per CPU thermal
pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-3-thara.gopinath@linaro.org
---
 include/linux/sched/topology.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f341163..af9319e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
+#ifndef arch_scale_thermal_pressure
+static __always_inline
+unsigned long arch_scale_thermal_pressure(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));

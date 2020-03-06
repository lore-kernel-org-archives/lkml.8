Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70EC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6902084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCFOnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCFOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB8-0006MJ-Dx; Fri, 06 Mar 2020 15:42:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3FD321C21D8;
        Fri,  6 Mar 2020 15:42:09 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:08 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Update cpu_capacity to reflect thermal pressure
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-8-thara.gopinath@linaro.org>
References: <20200222005213.3873-8-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350572893.28353.7818128953864188600.tip-bot2@tip-bot2>
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

Commit-ID:     467b7d01c469dc6aa492c17d1f1d1952632728f1
Gitweb:        https://git.kernel.org/tip/467b7d01c469dc6aa492c17d1f1d1952632728f1
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:11 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:20 +01:00

sched/fair: Update cpu_capacity to reflect thermal pressure

cpu_capacity initially reflects the maximum possible capacity of a CPU.
Thermal pressure on a CPU means this maximum possible capacity is
unavailable due to thermal events. This patch subtracts the average
thermal pressure for a CPU from its maximum possible capacity so that
cpu_capacity reflects the remaining maximum capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-8-thara.gopinath@linaro.org
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11f8488..aa51286 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7984,8 +7984,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 	if (unlikely(irq >= max))
 		return 1;
 
+	/*
+	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
+	 * (running and not running) with weights 0 and 1024 respectively.
+	 * avg_thermal.load_avg tracks thermal pressure and the weighted
+	 * average uses the actual delta max capacity(load).
+	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;

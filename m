Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F37C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9120738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895481;
	bh=iTGNMAJeaE3rGAi/xrgOUiGK6bbyfpqx7R5lRYxfdMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4W1LHhFOiaveYvqh+lHwbHGqOwZsZtcPOKITx4+/svSio3r1s5GLnkqQhMCiSFl4
	 Q75rsbpju2ruKpGfrKlynpM7PHuL5EabdKlpPZ6DEjdWTIBl9Db0E0DkMzpbmYsLNF
	 dIeCIjxKKgXl0ngJ64E+EUp8Dud+svciVyc7rqa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgFWG6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbgFWG57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:57:59 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E7A2077D;
        Tue, 23 Jun 2020 06:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895479;
        bh=iTGNMAJeaE3rGAi/xrgOUiGK6bbyfpqx7R5lRYxfdMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0W7iC/EjQBn4QAZpehUSj63BF9r9/M5JWHFGdKhlW2q+0io1CvNNAf7skW9E7fRo
         MytWcuBzP7Y/vZZPDM9cV591TJkeQELJBMaPQKqkeEMZEu4+47KEQmiWxBvRGcQpKg
         /boRyWOZNf+2gyE29CfSQ/2nDoFG2whfu030oqks=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/8] cpufreq: remove unicore32 driver
Date:   Tue, 23 Jun 2020 09:57:38 +0300
Message-Id: <20200623065744.18393-3-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
References: <20200623065744.18393-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The unicore32 port is removed from the kernel.
There is no point to keep stale cpufreq driver for this architecture.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/cpufreq/Makefile           |  1 -
 drivers/cpufreq/unicore2-cpufreq.c | 76 ------------------------------
 2 files changed, 77 deletions(-)
 delete mode 100644 drivers/cpufreq/unicore2-cpufreq.c

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f6670c4abbb0..089938ead681 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -108,4 +108,3 @@ obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
-obj-$(CONFIG_UNICORE32)			+= unicore2-cpufreq.o
diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
deleted file mode 100644
index 98d392196df2..000000000000
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * clock scaling for the UniCore-II
- *
- * Code specific to PKUnity SoC and UniCore ISA
- *
- *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
- *	Copyright (C) 2001-2010 Guan Xuetao
- */
-
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/cpufreq.h>
-
-#include <mach/hardware.h>
-
-static struct cpufreq_driver ucv2_driver;
-
-/* make sure that only the "userspace" governor is run
- * -- anything else wouldn't make sense on this platform, anyway.
- */
-static int ucv2_verify_speed(struct cpufreq_policy_data *policy)
-{
-	if (policy->cpu)
-		return -EINVAL;
-
-	cpufreq_verify_within_cpu_limits(policy);
-	return 0;
-}
-
-static int ucv2_target(struct cpufreq_policy *policy,
-			 unsigned int target_freq,
-			 unsigned int relation)
-{
-	struct cpufreq_freqs freqs;
-	int ret;
-
-	freqs.old = policy->cur;
-	freqs.new = target_freq;
-
-	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = clk_set_rate(policy->clk, target_freq * 1000);
-	cpufreq_freq_transition_end(policy, &freqs, ret);
-
-	return ret;
-}
-
-static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
-{
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	policy->min = policy->cpuinfo.min_freq = 250000;
-	policy->max = policy->cpuinfo.max_freq = 1000000;
-	policy->clk = clk_get(NULL, "MAIN_CLK");
-	return PTR_ERR_OR_ZERO(policy->clk);
-}
-
-static struct cpufreq_driver ucv2_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
-	.verify		= ucv2_verify_speed,
-	.target		= ucv2_target,
-	.get		= cpufreq_generic_get,
-	.init		= ucv2_cpu_init,
-	.name		= "UniCore-II",
-};
-
-static int __init ucv2_cpufreq_init(void)
-{
-	return cpufreq_register_driver(&ucv2_driver);
-}
-
-arch_initcall(ucv2_cpufreq_init);
-- 
2.26.2


Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EC6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F062075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHYNdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:33:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgHYNcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:32:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F3D731B;
        Tue, 25 Aug 2020 06:32:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8E723F66B;
        Tue, 25 Aug 2020 06:32:23 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH 2/2] sched/topology: Move SD_DEGENERATE_GROUPS_MASK out of linux/sched/topology.h
Date:   Tue, 25 Aug 2020 14:32:16 +0100
Message-Id: <20200825133216.9163-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825133216.9163-1-valentin.schneider@arm.com>
References: <20200825133216.9163-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD_DEGENERATE_GROUPS_MASK is only useful for sched/topology.c, but still
gets defined for anyone who imports topology.h, leading to a flurry of
unused variable warnings.

Move it out of the header and place it next to the SD degeneration
functions in sched/topology.c.

Fixes: 4ee4ea443a5d ("sched/topology: Introduce SD metaflag for flags needing > 1 groups")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/topology.h | 7 -------
 kernel/sched/topology.c        | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index b9b0dab4d067..9ef7bf686a9f 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -25,13 +25,6 @@ enum {
 };
 #undef SD_FLAG
 
-/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
-#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
-static const unsigned int SD_DEGENERATE_GROUPS_MASK =
-#include <linux/sched/sd_flags.h>
-0;
-#undef SD_FLAG
-
 #ifdef CONFIG_SCHED_DEBUG
 
 struct sd_flag_debug {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e1260cb4b44..da3cd60e4b78 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -154,6 +154,13 @@ static inline bool sched_debug(void)
 }
 #endif /* CONFIG_SCHED_DEBUG */
 
+/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
+#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
+static const unsigned int SD_DEGENERATE_GROUPS_MASK =
+#include <linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 static int sd_degenerate(struct sched_domain *sd)
 {
 	if (cpumask_weight(sched_domain_span(sd)) == 1)
-- 
2.27.0


Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0792C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D812076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHYNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:32:43 -0400
Received: from foss.arm.com ([217.140.110.172]:58828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgHYNcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:32:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B53081FB;
        Tue, 25 Aug 2020 06:32:23 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97CDC3F66B;
        Tue, 25 Aug 2020 06:32:22 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH 1/2] sched/topology: Move sd_flag_debug out of linux/sched/topology.h
Date:   Tue, 25 Aug 2020 14:32:15 +0100
Message-Id: <20200825133216.9163-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining an array in a header imported all over the place clearly is a daft
idea, that still didn't stop me from doing it.

Leave a declaration of sd_flag_debug in topology.h and move its definition
to sched/debug.c.

Fixes: b6e862f38672 ("sched/topology: Define and assign sched_domain flag metadata")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/topology.h | 9 ++++-----
 kernel/sched/debug.c           | 6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2d59ca77103e..b9b0dab4d067 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -33,14 +33,13 @@ static const unsigned int SD_DEGENERATE_GROUPS_MASK =
 #undef SD_FLAG
 
 #ifdef CONFIG_SCHED_DEBUG
-#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
-static const struct {
+
+struct sd_flag_debug {
 	unsigned int meta_flags;
 	char *name;
-} sd_flag_debug[] = {
-#include <linux/sched/sd_flags.h>
 };
-#undef SD_FLAG
+extern const struct sd_flag_debug sd_flag_debug[];
+
 #endif
 
 #ifdef CONFIG_SCHED_SMT
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524700d2..0d7896d2a0b2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,6 +245,12 @@ set_table_entry(struct ctl_table *entry,
 	entry->proc_handler = proc_handler;
 }
 
+#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
+const struct sd_flag_debug sd_flag_debug[] = {
+#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
+
 static int sd_ctl_doflags(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-- 
2.27.0


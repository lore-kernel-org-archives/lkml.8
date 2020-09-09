Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A59FC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4DB21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PC3VAOwV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMBqAbWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIII0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:26:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60122 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIII0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:26:16 -0400
Date:   Wed, 09 Sep 2020 08:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599639973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoDD1UDHTlJFMLx9+RNng8Fd9vf19kX3LXI/EPptrC0=;
        b=PC3VAOwVybDTf8GPzx8pjT6Y/hC7lBII2+oTwXXS/3Ehgdj2VOAS203Y0qp18f+uyqD+hS
        /thKbVSHFJ4X5OsTGTlGbZlXYJEC0jXKd+9liwaZ0AFgq+brAkGPVb9/wr1+M9jW+CcPpg
        WXK3W+YA05iI8OoBcbHUB6Wg/e5iq2iTjOq0rJ180pN/LsMbXbAcp/Y9X0V1cKVxEdX7vk
        +vyJIx/v9xT1n5BAbnDml4nNPhuXWaOAZIVlo1XEY7FraaBQvqxOb4NJEuxRdnGBhYzM1C
        +SxLI0epwGnk+RBxSnnpmWcbbzMb8Zdai1x7dFUccF6czktXYZEn8p70gRmk9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599639973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoDD1UDHTlJFMLx9+RNng8Fd9vf19kX3LXI/EPptrC0=;
        b=iMBqAbWC2jRtBf0RHg2K8mr94DRlCVOcQK7RMU+RjhAzyd64Io5HaSCFxS9m0NnGCfbezI
        uvgtqkfj/kqjeWBg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Move sd_flag_debug out of #ifdef
 CONFIG_SYSCTL
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908184956.23369-1-valentin.schneider@arm.com>
References: <20200908184956.23369-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159963997277.20229.10716555225789484968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     848785df48835eefebe0c4eb5da7690690b0a8b7
Gitweb:        https://git.kernel.org/tip/848785df48835eefebe0c4eb5da7690690b0a8b7
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 08 Sep 2020 19:49:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Sep 2020 10:09:03 +02:00

sched/topology: Move sd_flag_debug out of #ifdef CONFIG_SYSCTL

The last sd_flag_debug shuffle inadvertently moved its definition within
an #ifdef CONFIG_SYSCTL region. While CONFIG_SYSCTL is indeed required to
produce the sched domain ctl interface (which uses sd_flag_debug to output
flag names), it isn't required to run any assertion on the sched_domain
hierarchy itself.

Move the definition of sd_flag_debug to a CONFIG_SCHED_DEBUG region of
topology.c.

Now at long last we have:

- sd_flag_debug declared in include/linux/sched/topology.h iff
  CONFIG_SCHED_DEBUG=y
- sd_flag_debug defined in kernel/sched/topology.c, conditioned by:
  - CONFIG_SCHED_DEBUG, with an explicit #ifdef block
  - CONFIG_SMP, as a requirement to compile topology.c

With this change, all symbols pertaining to SD flag metadata (with the
exception of __SD_FLAG_CNT) are now defined exclusively within topology.c

Fixes: 8fca9494d4b4 ("sched/topology: Move sd_flag_debug out of linux/sched/topology.h")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200908184956.23369-1-valentin.schneider@arm.com
---
 kernel/sched/debug.c    | 6 ------
 kernel/sched/topology.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0d7896d..0655524 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,12 +245,6 @@ set_table_entry(struct ctl_table *entry,
 	entry->proc_handler = proc_handler;
 }
 
-#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
-const struct sd_flag_debug sd_flag_debug[] = {
-#include <linux/sched/sd_flags.h>
-};
-#undef SD_FLAG
-
 static int sd_ctl_doflags(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index aa1676a..249bec7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -25,6 +25,12 @@ static inline bool sched_debug(void)
 	return sched_debug_enabled;
 }
 
+#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
+const struct sd_flag_debug sd_flag_debug[] = {
+#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
+
 static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 				  struct cpumask *groupmask)
 {

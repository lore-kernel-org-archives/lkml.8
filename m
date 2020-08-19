Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F9EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EA9204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nclwdakF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGXtKA6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgHSOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:06:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgHSOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:51 -0400
Date:   Wed, 19 Aug 2020 14:02:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCFQCll81+xGY9kK9qg0Qa9r7fDQY1OnzjtSox0/cOk=;
        b=nclwdakFL+x97wq5mmsYuzQl1HVKQXJKYizdYrY61V9NGMWQ+080KD8OewU3iQIqH4+rcR
        kxAOZGU7rwrnjGfqzA2TjtK5CbIGFoKaPhCqSRgyyxjAHCQzodqwWCL6wj4rkWS8W13+/z
        JmW+sN4tLC0GFWqF7TG0GTVsZAOdVGayu42Shvgome931SoXBUGAsdNj3/I/IDydPtL5Ac
        Vj//QNXTQ2uiw76C9jmGIJMHr4rN+koT5DNIAq3wA7KbDOCs+IMKpd4AjHfEV9nJV8Wk2C
        dM0dZE5FrtnTXWTn3pYcLyuNhb78tmRMPcCXYEBeed1kNfhlHIl/lKTEd0ZQ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCFQCll81+xGY9kK9qg0Qa9r7fDQY1OnzjtSox0/cOk=;
        b=HGXtKA6T3tTNeFze0aTL1G16PDYmzGjY+jK80FkE05bSUNEkJdwJMgKCXDCxN8/umDbKRL
        pS2+DGFu2dSZoJCA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Introduce SD metaflag for flags
 needing > 1 groups
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-8-valentin.schneider@arm.com>
References: <20200817113003.20802-8-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576761.3192.1970483124883229508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4ee4ea443a5dc3fc4d8ae338199676eae9d8ef02
Gitweb:        https://git.kernel.org/tip/4ee4ea443a5dc3fc4d8ae338199676eae9d8ef02
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:48 +02:00

sched/topology: Introduce SD metaflag for flags needing > 1 groups

In preparation of cleaning up the sd_degenerate*() functions, mark flags
used in sd_degenerate() with the new SDF_NEEDS_GROUPS flag. With this,
build a compile-time mask of those SD flags.

Note that sd_parent_degenerate() uses an extra flag in its mask,
SD_PREFER_SIBLING, which remains singled out for now.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-8-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 39 +++++++++++++++++++++++----------
 include/linux/sched/topology.h |  7 ++++++-
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index c24a45b..ee5cbfc 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -8,7 +8,7 @@
 #endif
 
 /*
- * Expected flag uses
+ * Hierarchical metaflags
  *
  * SHARED_CHILD: These flags are meant to be set from the base domain upwards.
  * If a domain has this flag set, all of its children should have it set. This
@@ -29,29 +29,42 @@
  * certain level (e.g. domain starts spanning CPUs outside of the base CPU's
  * socket).
  */
-#define SDF_SHARED_CHILD 0x1
-#define SDF_SHARED_PARENT 0x2
+#define SDF_SHARED_CHILD       0x1
+#define SDF_SHARED_PARENT      0x2
+
+/*
+ * Behavioural metaflags
+ *
+ * NEEDS_GROUPS: These flags are only relevant if the domain they are set on has
+ * more than one group. This is usually for balancing flags (load balancing
+ * involves equalizing a metric between groups), or for flags describing some
+ * shared resource (which would be shared between groups).
+ */
+#define SDF_NEEDS_GROUPS       0x4
 
 /*
  * Balance when about to become idle
  *
  * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on exec
  *
  * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on fork, clone
  *
  * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on wakeup
@@ -69,24 +82,28 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
 
 /*
  * Domain members have different CPU capacities
+ *
+ * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
  */
-SD_FLAG(SD_ASYM_CPUCAPACITY, 0)
+SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU capacity (i.e. SMT)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * CPU capacity.
+ *               CPU capacity.
+ * NEEDS_GROUPS: Capacity is shared between groups.
  */
-SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * the same cache(s).
+ *               the same cache(s).
+ * NEEDS_GROUPS: Caches are shared between groups.
  */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Only a single load balancing instance
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 32f602f..2d59ca7 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -25,6 +25,13 @@ enum {
 };
 #undef SD_FLAG
 
+/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
+#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
+static const unsigned int SD_DEGENERATE_GROUPS_MASK =
+#include <linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 #ifdef CONFIG_SCHED_DEBUG
 #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
 static const struct {

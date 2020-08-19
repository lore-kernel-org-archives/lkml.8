Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED7CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F732067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0M8887K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yK2bE2k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgHSOEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgHSODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:03:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245BC061348;
        Wed, 19 Aug 2020 07:02:52 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQZOW0j4/RdzM1divCEavCZuXsVIoOqyikm/qS44wK8=;
        b=x0M8887KRqa+3oZhKLipuAh6YH3dX5AlqUqfhKlDAXh45F+RnAu/712jbFxmzKdOvw4Rvo
        A1+wkBh4kYpUnpk+a3x0feqS7O/9c6vl0wJsKXMFa95e0EaohFZavSTx4w3SRqJ8COm8pQ
        PiGx4DJvRDJrZIAtOukwyiDR4IlL6tXvm98tWQi03gZMP06Lny4/Ixn5rTHbHIrlhdBYTg
        zdCvfxNPl4W1zKX+/BOdV7wxT96cSK2ag0YsUZ+ni6ByhUOcbkyT39PygJEdNFkUwwuS1M
        wkDruf1J1OmC2jST9hMMxUNFbqaBo7YnnY82rVl52/FpCkQfYHhH5YVafc7Udw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQZOW0j4/RdzM1divCEavCZuXsVIoOqyikm/qS44wK8=;
        b=yK2bE2k6WjSPt62Ixp/Gaupoeoxq93rHZcNXRp8w9wtVS5rJzkMMGhAR6Cmm23kaJW4Jmw
        r3/ir2VXcQcYTBAQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Split out SD_* flags declaration to
 its own file
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-4-valentin.schneider@arm.com>
References: <20200817113003.20802-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784577024.3192.10076591546813969390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d54a9658a75633b839af7a2c6c758807678b8064
Gitweb:        https://git.kernel.org/tip/d54a9658a75633b839af7a2c6c758807678b8064
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:47 +02:00

sched/topology: Split out SD_* flags declaration to its own file

To associate the SD flags with some metadata, we need some more structure
in the way they are declared.

Rather than shove that in a free-standing macro list, move the declaration
in a separate file that can be re-imported with different SD_FLAG
definitions. This is inspired by what is done with the syscall
table (see uapi/asm/unistd.h and sys_call_table).

The value assigned to a given SD flag now depends on the order it appears
in sd_flags.h. No change in functionality.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-4-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 35 +++++++++++++++++++++++++++++++++-
 include/linux/sched/topology.h | 26 ++++++++++++-------------
 2 files changed, 48 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
new file mode 100644
index 0000000..373dc45
--- /dev/null
+++ b/include/linux/sched/sd_flags.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * sched-domains (multiprocessor balancing) flag declarations.
+ */
+
+#ifndef SD_FLAG
+# error "Incorrect import of SD flags definitions"
+#endif
+
+/* Balance when about to become idle */
+SD_FLAG(SD_BALANCE_NEWIDLE)
+/* Balance on exec */
+SD_FLAG(SD_BALANCE_EXEC)
+/* Balance on fork, clone */
+SD_FLAG(SD_BALANCE_FORK)
+/* Balance on wakeup */
+SD_FLAG(SD_BALANCE_WAKE)
+/* Wake task to waking CPU */
+SD_FLAG(SD_WAKE_AFFINE)
+/* Domain members have different CPU capacities */
+SD_FLAG(SD_ASYM_CPUCAPACITY)
+/* Domain members share CPU capacity */
+SD_FLAG(SD_SHARE_CPUCAPACITY)
+/* Domain members share CPU pkg resources */
+SD_FLAG(SD_SHARE_PKG_RESOURCES)
+/* Only a single load balancing instance */
+SD_FLAG(SD_SERIALIZE)
+/* Place busy groups earlier in the domain */
+SD_FLAG(SD_ASYM_PACKING)
+/* Prefer to place tasks in a sibling domain */
+SD_FLAG(SD_PREFER_SIBLING)
+/* sched_domains of this level overlap */
+SD_FLAG(SD_OVERLAP)
+/* cross-node balancing */
+SD_FLAG(SD_NUMA)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6ec7d7c..3e41c04 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -11,19 +11,19 @@
  */
 #ifdef CONFIG_SMP
 
-#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
-#define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
-#define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
-#define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
-#define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
-#define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
-#define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
-#define SD_SHARE_PKG_RESOURCES	0x0080	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0100	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0200  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x0400	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x0800	/* sched_domains of this level overlap */
-#define SD_NUMA			0x1000	/* cross-node balancing */
+/* Generate SD flag indexes */
+#define SD_FLAG(name) __##name,
+enum {
+	#include <linux/sched/sd_flags.h>
+	__SD_FLAG_CNT,
+};
+#undef SD_FLAG
+/* Generate SD flag bits */
+#define SD_FLAG(name) name = 1 << __##name,
+enum {
+	#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)

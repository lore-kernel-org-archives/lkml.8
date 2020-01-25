Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750DAC35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B7218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgAYKqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgAYKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItl-0008Ku-Tz; Sat, 25 Jan 2020 11:42:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EDEE81C1A77;
        Sat, 25 Jan 2020 11:42:40 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:40 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Move gp_state_names[] and gp_state_getname() to
 tree_stall.h
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896075.396.16467629081499061048.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e2167b38c87a0c9e85c342a823dae1e6f67b11d9
Gitweb:        https://git.kernel.org/tip/e2167b38c87a0c9e85c342a823dae1e6f67b11d9
Author:        Lai Jiangshan <jiangshanlai@gmail.com>
AuthorDate:    Tue, 15 Oct 2019 10:28:47 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:45 -08:00

rcu: Move gp_state_names[] and gp_state_getname() to tree_stall.h

Only tree_stall.h needs to get name from GP state, so this commit
moves the gp_state_names[] array and the gp_state_getname()
from kernel/rcu/tree.h and kernel/rcu/tree.c, respectively, to
kernel/rcu/tree_stall.h.  While moving gp_state_names[], this commit
uses the GCC syntax to ensure that the right string is associated with
the right CPP macro.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 10 ----------
 kernel/rcu/tree.h       | 12 ------------
 kernel/rcu/tree_stall.h | 22 ++++++++++++++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ba154a3..bbb60ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -529,16 +529,6 @@ static struct rcu_node *rcu_get_root(void)
 }
 
 /*
- * Convert a ->gp_state value to a character string.
- */
-static const char *gp_state_getname(short gs)
-{
-	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
-		return "???";
-	return gp_state_names[gs];
-}
-
-/*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 54ff989..9d5986a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -368,18 +368,6 @@ struct rcu_state {
 #define RCU_GP_CLEANUP   7	/* Grace-period cleanup started. */
 #define RCU_GP_CLEANED   8	/* Grace-period cleanup complete. */
 
-static const char * const gp_state_names[] = {
-	"RCU_GP_IDLE",
-	"RCU_GP_WAIT_GPS",
-	"RCU_GP_DONE_GPS",
-	"RCU_GP_ONOFF",
-	"RCU_GP_INIT",
-	"RCU_GP_WAIT_FQS",
-	"RCU_GP_DOING_FQS",
-	"RCU_GP_CLEANUP",
-	"RCU_GP_CLEANED",
-};
-
 /*
  * In order to export the rcu_state name to the tracing tools, it
  * needs to be added in the __tracepoint_string section.
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c0b8c45..f18adaf 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -279,6 +279,28 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 
 #endif /* #else #ifdef CONFIG_RCU_FAST_NO_HZ */
 
+static const char * const gp_state_names[] = {
+	[RCU_GP_IDLE] = "RCU_GP_IDLE",
+	[RCU_GP_WAIT_GPS] = "RCU_GP_WAIT_GPS",
+	[RCU_GP_DONE_GPS] = "RCU_GP_DONE_GPS",
+	[RCU_GP_ONOFF] = "RCU_GP_ONOFF",
+	[RCU_GP_INIT] = "RCU_GP_INIT",
+	[RCU_GP_WAIT_FQS] = "RCU_GP_WAIT_FQS",
+	[RCU_GP_DOING_FQS] = "RCU_GP_DOING_FQS",
+	[RCU_GP_CLEANUP] = "RCU_GP_CLEANUP",
+	[RCU_GP_CLEANED] = "RCU_GP_CLEANED",
+};
+
+/*
+ * Convert a ->gp_state value to a character string.
+ */
+static const char *gp_state_getname(short gs)
+{
+	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
+		return "???";
+	return gp_state_names[gs];
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *

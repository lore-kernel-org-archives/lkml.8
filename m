Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B51EC35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFDB20801
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAYKmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAYKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItl-0008KI-LB; Sat, 25 Jan 2020 11:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A88B31C1A76;
        Sat, 25 Jan 2020 11:42:40 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:40 -0000
From:   "tip-bot2 for Ben Dooks" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Move rcu_{expedited,normal} definitions into rcupdate.h
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896050.396.10567855356969877929.tip-bot2@tip-bot2>
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

Commit-ID:     e1350e8e0ea5d959c23c5e593ff3026a67dbb049
Gitweb:        https://git.kernel.org/tip/e1350e8e0ea5d959c23c5e593ff3026a67dbb049
Author:        Ben Dooks <ben.dooks@codethink.co.uk>
AuthorDate:    Tue, 15 Oct 2019 14:48:22 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:50 -08:00

rcu: Move rcu_{expedited,normal} definitions into rcupdate.h

This commit moves the rcu_{expedited,normal} definitions from
kernel/rcu/update.c to include/linux/rcupdate.h to make sure they are
in sync, and also to avoid the following warning from sparse:

kernel/ksysfs.c:150:5: warning: symbol 'rcu_expedited' was not declared. Should it be static?
kernel/ksysfs.c:167:5: warning: symbol 'rcu_normal' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 4 ++++
 kernel/rcu/update.c      | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index fe47024..bb36379 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -896,4 +896,8 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 	return false;
 }
 
+/* kernel/ksysfs.c definitions */
+extern int rcu_expedited;
+extern int rcu_normal;
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103..294d357 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -51,9 +51,7 @@
 #define MODULE_PARAM_PREFIX "rcupdate."
 
 #ifndef CONFIG_TINY_RCU
-extern int rcu_expedited; /* from sysctl */
 module_param(rcu_expedited, int, 0);
-extern int rcu_normal; /* from sysctl */
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot;
 module_param(rcu_normal_after_boot, int, 0);

Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BEEC2BB55
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B052206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgDLOTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:19:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41457 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgDLOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:19:32 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jNdSL-0001Wh-TU; Sun, 12 Apr 2020 16:19:30 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 741EB100E35;
        Sun, 12 Apr 2020 16:19:29 +0200 (CEST)
Date:   Sun, 12 Apr 2020 14:18:41 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.7-rc1
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
Message-ID: <158670112139.20085.3639703190488837403.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-12

up to:  0f538e3e712a: ucount: Make sure ucounts in /proc/sys/user don't regress again


Time(keeping) updates:

 - Fix the time_for_children symlink in /proc/$PID/ so it properly reflects
   that it part of the 'time' namespace

 - Add the missing userns limit for the allowed number of time namespaces,
   which was half defined but the actual array member was not added.  This
   went unnoticed as the array has an exessive empty member at the end but
   introduced a user visible regression as the output was corrupted.

 - Prevent further silent ucount corruption by adding a BUILD_BUG_ON() to
   catch half updated data.

Thanks,

	tglx

------------------>
Dmitry Safonov (1):
      time/namespace: Add max_time_namespaces ucount

Jan Kara (1):
      ucount: Make sure ucounts in /proc/sys/user don't regress again

Michael Kerrisk (man-pages) (1):
      time/namespace: Fix time_for_children symlink


 Documentation/admin-guide/sysctl/user.rst | 6 ++++++
 kernel/time/namespace.c                   | 1 +
 kernel/ucount.c                           | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/user.rst b/Documentation/admin-guide/sysctl/user.rst
index 650eaa03f15e..c45824589339 100644
--- a/Documentation/admin-guide/sysctl/user.rst
+++ b/Documentation/admin-guide/sysctl/user.rst
@@ -65,6 +65,12 @@ max_pid_namespaces
   The maximum number of pid namespaces that any user in the current
   user namespace may create.
 
+max_time_namespaces
+===================
+
+  The maximum number of time namespaces that any user in the current
+  user namespace may create.
+
 max_user_namespaces
 ===================
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e6ba064ce773..3b30288793fe 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -447,6 +447,7 @@ const struct proc_ns_operations timens_operations = {
 
 const struct proc_ns_operations timens_for_children_operations = {
 	.name		= "time_for_children",
+	.real_ns_name	= "time",
 	.type		= CLONE_NEWTIME,
 	.get		= timens_for_children_get,
 	.put		= timens_put,
diff --git a/kernel/ucount.c b/kernel/ucount.c
index a53cc2b4179c..11b1596e2542 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -69,6 +69,7 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_net_namespaces"),
 	UCOUNT_ENTRY("max_mnt_namespaces"),
 	UCOUNT_ENTRY("max_cgroup_namespaces"),
+	UCOUNT_ENTRY("max_time_namespaces"),
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
@@ -81,6 +82,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table *tbl;
+
+	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
 	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
 	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
 	if (tbl) {


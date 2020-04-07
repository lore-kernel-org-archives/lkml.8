Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D5C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DC520644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDGKmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:42:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47032 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDGKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:42:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jLlg8-0004LN-Kj; Tue, 07 Apr 2020 12:42:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 277331C0082;
        Tue,  7 Apr 2020 12:42:00 +0200 (CEST)
Date:   Tue, 07 Apr 2020 10:41:59 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time/namespace: Add max_time_namespaces ucount
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        stable@kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200406171342.128733-1-dima@arista.com>
References: <20200406171342.128733-1-dima@arista.com>
MIME-Version: 1.0
Message-ID: <158625611966.28353.8687396873950102990.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     eeec26d5da8248ea4e240b8795bb4364213d3247
Gitweb:        https://git.kernel.org/tip/eeec26d5da8248ea4e240b8795bb4364213d3247
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Mon, 06 Apr 2020 18:13:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 07 Apr 2020 12:37:21 +02:00

time/namespace: Add max_time_namespaces ucount

Michael noticed that userns limit for number of time namespaces is missing.

Furthermore, time namespace introduced UCOUNT_TIME_NAMESPACES, but didn't
introduce an array member in user_table[]. It would make array's
initialisation OOB write, but by luck the user_table array has an excessive
empty member (all accesses to the array are limited with UCOUNT_COUNTS - so
it silently reuses the last free member.

Fixes user-visible regression: max_inotify_instances by reason of the
missing UCOUNT_ENTRY() has limited max number of namespaces instead of the
number of inotify instances.

Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/20200406171342.128733-1-dima@arista.com

---
 Documentation/admin-guide/sysctl/user.rst | 6 ++++++
 kernel/ucount.c                           | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/user.rst b/Documentation/admin-guide/sysctl/user.rst
index 650eaa0..c458245 100644
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
 
diff --git a/kernel/ucount.c b/kernel/ucount.c
index a53cc2b..29c60eb 100644
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

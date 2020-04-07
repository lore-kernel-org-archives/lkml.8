Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C334C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B1820730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDGTye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:54:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48493 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGTye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:54:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jLuIn-0004Fa-SY; Tue, 07 Apr 2020 21:54:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E0C61C0082;
        Tue,  7 Apr 2020 21:54:29 +0200 (CEST)
Date:   Tue, 07 Apr 2020 19:54:28 -0000
From:   "tip-bot2 for Jan Kara" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] ucount: Make sure ucounts in /proc/sys/user
 don't regress again
Cc:     Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200407154643.10102-1-jack@suse.cz>
References: <20200407154643.10102-1-jack@suse.cz>
MIME-Version: 1.0
Message-ID: <158628926863.28353.6820611452673308754.tip-bot2@tip-bot2>
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

Commit-ID:     0f538e3e712a517bd351607de50cd298102c7c08
Gitweb:        https://git.kernel.org/tip/0f538e3e712a517bd351607de50cd298102c7c08
Author:        Jan Kara <jack@suse.cz>
AuthorDate:    Tue, 07 Apr 2020 17:46:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 07 Apr 2020 21:51:27 +02:00

ucount: Make sure ucounts in /proc/sys/user don't regress again

Commit 769071ac9f20 "ns: Introduce Time Namespace" broke reporting of
inotify ucounts (max_inotify_instances, max_inotify_watches) in
/proc/sys/user because it has added UCOUNT_TIME_NAMESPACES into enum
ucount_type but didn't properly update reporting in
kernel/ucount.c:setup_userns_sysctls(). This problem got fixed in commit
eeec26d5da82 "time/namespace: Add max_time_namespaces ucount".

Add BUILD_BUG_ON to catch a similar problem in the future.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrei Vagin <avagin@gmail.com>
Link: https://lkml.kernel.org/r/20200407154643.10102-1-jack@suse.cz

---
 kernel/ucount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 29c60eb..11b1596 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -82,6 +82,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table *tbl;
+
+	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
 	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
 	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
 	if (tbl) {

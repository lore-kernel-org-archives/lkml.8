Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A6C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DF820728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgCCSkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:40:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgCCSko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:40:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9CTA-0003Uu-LP; Tue, 03 Mar 2020 19:40:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F00981C1A9F;
        Tue,  3 Mar 2020 19:40:39 +0100 (CET)
Date:   Tue, 03 Mar 2020 18:40:39 -0000
From:   "tip-bot2 for Cyril Hrubis" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] sys/sysinfo: Respect boottime inside time namespace
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200303150638.7329-1-chrubis@suse.cz>
References: <20200303150638.7329-1-chrubis@suse.cz>
MIME-Version: 1.0
Message-ID: <158326083954.28353.16922158200341050554.tip-bot2@tip-bot2>
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

Commit-ID:     ecc421e05bab97cf3ff4fe456ade47ef84dba8c2
Gitweb:        https://git.kernel.org/tip/ecc421e05bab97cf3ff4fe456ade47ef84dba8c2
Author:        Cyril Hrubis <chrubis@suse.cz>
AuthorDate:    Tue, 03 Mar 2020 16:06:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Mar 2020 19:34:32 +01:00

sys/sysinfo: Respect boottime inside time namespace

The sysinfo() syscall includes uptime in seconds but has no correction for
time namespaces which makes it inconsistent with the /proc/uptime inside of
a time namespace.

Add the missing time namespace adjustment call.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Link: https://lkml.kernel.org/r/20200303150638.7329-1-chrubis@suse.cz

---
 kernel/sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index f9bc5c3..d325f3a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/kprobes.h>
 #include <linux/user_namespace.h>
+#include <linux/time_namespace.h>
 #include <linux/binfmts.h>
 
 #include <linux/sched.h>
@@ -2546,6 +2547,7 @@ static int do_sysinfo(struct sysinfo *info)
 	memset(info, 0, sizeof(struct sysinfo));
 
 	ktime_get_boottime_ts64(&tp);
+	timens_add_boottime(&tp);
 	info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
 	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);

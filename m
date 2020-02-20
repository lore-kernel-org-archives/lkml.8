Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC3BC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8EC20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBTUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:21:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBTUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:20:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4sJd-0006u0-8J; Thu, 20 Feb 2020 21:20:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C97F01C1A4F;
        Thu, 20 Feb 2020 21:20:56 +0100 (CET)
Date:   Thu, 20 Feb 2020 20:20:56 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] sched: Provide cant_migrate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214161503.070487511@linutronix.de>
References: <20200214161503.070487511@linutronix.de>
MIME-Version: 1.0
Message-ID: <158223005640.13786.3830245021041569703.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     4e139c7711633365ebb52fbb63905395522a8413
Gitweb:        https://git.kernel.org/tip/4e139c7711633365ebb52fbb63905395522a8413
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 14 Feb 2020 14:39:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2020 21:17:24 +01:00

sched: Provide cant_migrate()

Some code pathes rely on preempt_disable() to prevent migration on a non RT
enabled kernel. These preempt_disable/enable() pairs are substituted by
migrate_disable/enable() pairs or other forms of RT specific protection. On
RT these protections prevent migration but not preemption. Obviously a
cant_sleep() check in such a section will trigger on RT because preemption
is not disabled.

Provide a cant_migrate() macro which maps to cant_sleep() on a non RT
kernel and an empty placeholder for RT for now. The placeholder will be
changed to a proper debug check along with the RT specific migration
protection mechanism.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200214161503.070487511@linutronix.de
---
 include/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a..9b7a8d7 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -257,6 +257,13 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
+#ifndef CONFIG_PREEMPT_RT
+# define cant_migrate()		cant_sleep()
+#else
+  /* Placeholder for now */
+# define cant_migrate()		do { } while (0)
+#endif
+
 /**
  * abs - return absolute value of an argument
  * @x: the value.  If it is unsigned type, it is converted to signed type first.

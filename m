Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A04C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B11B20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7mEH2Sb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6erkw19o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgGVJMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgGVJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFDC0619DF;
        Wed, 22 Jul 2020 02:12:29 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZV1rLN+O7Y/mLtD/iGbro95tGb6D0qCC29gSnRZcQxQ=;
        b=B7mEH2Sb+U4rR7WNbgWDBrX9/HTbGgmzxhcQ9csyjfU/eb5ddMfTXCc6sn5Cr5aavR852I
        p/cpEaREDKhFxOr1MDRy7nleIPcF84hpi/xQoPVAaDFf3zrfAPAaHVaUo/NvSSM3/E3e4D
        8AX5McUZJDhIgQZaKsonWkqYoJAgu2gGENgVyahs+ZvkQWSHqsq6YX2iP8wp/JK/NH26TS
        XoBO8/oYEq3jIk51YoMKCJ7c8jHM+OzAJ59RszcOlJiDpnqHhalrH423HGR04QXAYI67na
        WwDHfQy20qNEYxrK8TKEdxpm4jfKFjLKA+GV1sgaVtHeD4YCdL0pT1egD3mT5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZV1rLN+O7Y/mLtD/iGbro95tGb6D0qCC29gSnRZcQxQ=;
        b=6erkw19oroGszJ0QMkBlqmpaRylUI9jd/MthON80I8lh8LmABpzjbI/o+CdlQsVEizNsFx
        5C6TJus3IAktgcAw==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: nohz: stop passing around unused "ticks" parameter.
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593628458-32290-1-git-send-email-paul.gortmaker@windriver.com>
References: <1593628458-32290-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Message-ID: <159540914778.4006.10624376544623196907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     46132e3ac58cb2ee48051ed80bffc0070ad59b2e
Gitweb:        https://git.kernel.org/tip/46132e3ac58cb2ee48051ed80bffc0070ad59b2e
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Wed, 01 Jul 2020 14:34:18 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:04 +02:00

sched: nohz: stop passing around unused "ticks" parameter.

The "ticks" parameter was added in commit 0f004f5a696a ("sched: Cure more
NO_HZ load average woes") since calc_global_nohz() was called and needed
the "ticks" argument.

But in commit c308b56b5398 ("sched: Fix nohz load accounting -- again!")
it became unused as the function calc_global_nohz() dropped using "ticks".

Fixes: c308b56b5398 ("sched: Fix nohz load accounting -- again!")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593628458-32290-1-git-send-email-paul.gortmaker@windriver.com
---
 include/linux/sched/loadavg.h | 2 +-
 kernel/sched/loadavg.c        | 2 +-
 kernel/time/timekeeping.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/loadavg.h b/include/linux/sched/loadavg.h
index 4859bea..83ec54b 100644
--- a/include/linux/sched/loadavg.h
+++ b/include/linux/sched/loadavg.h
@@ -43,6 +43,6 @@ extern unsigned long calc_load_n(unsigned long load, unsigned long exp,
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
-extern void calc_global_load(unsigned long ticks);
+extern void calc_global_load(void);
 
 #endif /* _LINUX_SCHED_LOADAVG_H */
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index de22da6..d2a6556 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -347,7 +347,7 @@ static inline void calc_global_nohz(void) { }
  *
  * Called from the global timer code.
  */
-void calc_global_load(unsigned long ticks)
+void calc_global_load(void)
 {
 	unsigned long sample_window;
 	long active, delta;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489..63a632f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2193,7 +2193,7 @@ EXPORT_SYMBOL(ktime_get_coarse_ts64);
 void do_timer(unsigned long ticks)
 {
 	jiffies_64 += ticks;
-	calc_global_load(ticks);
+	calc_global_load();
 }
 
 /**

Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC142208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQh39jre";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qz+82XX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgGaJ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbgGaJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:14 -0400
Date:   Fri, 31 Jul 2020 09:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rcuxnCR6t75oMgdp7UKEk1+CzGCeVu7sWn/l8nMpkbs=;
        b=hQh39jreMCyr02bfFG/0rhXS41kVoyfp4c82rmD7ag9mbTVXbjGTmNFJFVv1hR7RHEvIvc
        W6/JeZlxm5rI4OrCSXPxd8mmVYOEIEX+S7zKwZerrHKIenbrnR2aRlG0s/bHiIlkIvp9p/
        gVB1Zqeg3P94dBP5WSPNrIPkPGrI9Ipgj9W25O/HYpYZ5hYTt9jalE4PzthaG2AbaUOZxt
        nEjIWfjycIOLAzZfhWsh4lZgu4f19YkxnI/OsOmoJxjaq4dNCYa+FiCNBfn7U3KdFTItvT
        VL3+pegJF6efmDE5Z+bk9Q50PHugN7fY8jMv+PXECD+Fbyodls8zdwsBaPfenA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rcuxnCR6t75oMgdp7UKEk1+CzGCeVu7sWn/l8nMpkbs=;
        b=qz+82XX+EpQTW1eW8z9C3zS2sfBSLXCKH6odX9/R7Tm4hp3dSLQ7b+AGPw6YWSXQ4ug+ft
        VlFUlsyiLzDtdZDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Fix code-style issues
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739124.4006.10379288260322787477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     30d8aa5128f12c9d781b67c9694c1abfa4f6ce6a
Gitweb:        https://git.kernel.org/tip/30d8aa5128f12c9d781b67c9694c1abfa4f6ce6a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 09 Jun 2020 09:24:51 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:22 -07:00

rcu-tasks: Fix code-style issues

This commit declares trc_n_readers_need_end and trc_wait static and
replaced a "&" with "&&".  The "&" happened to work because the values
are bool, but accidents waiting to happen and all that...

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5c003c..828f222 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -737,8 +737,8 @@ EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-atomic_t trc_n_readers_need_end;	// Number of waited-for readers.
-DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
+static atomic_t trc_n_readers_need_end;		// Number of waited-for readers.
+static DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
@@ -845,7 +845,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	bool ofl = cpu_is_offline(cpu);
 
 	if (task_curr(t)) {
-		WARN_ON_ONCE(ofl & !is_idle_task(t));
+		WARN_ON_ONCE(ofl && !is_idle_task(t));
 
 		// If no chance of heavyweight readers, do it the hard way.
 		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))

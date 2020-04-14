Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009A3206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436554AbgDNIWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727908AbgDNIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:51 -0400
X-Greylist: delayed 65081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 01:20:51 PDT
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B3C0A3BE2;
        Tue, 14 Apr 2020 01:20:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoK-0006GN-5i; Tue, 14 Apr 2020 10:20:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E7DB1C0086;
        Tue, 14 Apr 2020 10:20:47 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:47 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] rcu: Don't acquire lock in NMI handler in
 rcu_nmi_enter_common()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <stable@vger.kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158685244710.28353.3404230640093238216.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     bf37da98c51825c90432d340e135cced37a7460d
Gitweb:        https://git.kernel.org/tip/bf37da98c51825c90432d340e135cced37a7460d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 12 Mar 2020 16:55:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sun, 05 Apr 2020 14:22:15 -07:00

rcu: Don't acquire lock in NMI handler in rcu_nmi_enter_common()

The rcu_nmi_enter_common() function can be invoked both in interrupt
and NMI handlers.  If it is invoked from process context (as opposed
to userspace or idle context) on a nohz_full CPU, it might acquire the
CPU's leaf rcu_node structure's ->lock.  Because this lock is held only
with interrupts disabled, this is safe from an interrupt handler, but
doing so from an NMI handler can result in self-deadlock.

This commit therefore adds "irq" to the "if" condition so as to only
acquire the ->lock from irq handlers or process context, never from
an NMI handler.

Fixes: 5b14557b073c ("rcu: Avoid tick_dep_set_cpu() misordering")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: <stable@vger.kernel.org> # 5.5.x
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 550193a..2c17859 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -825,7 +825,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 			rcu_cleanup_after_idle();
 
 		incby = 1;
-	} else if (tick_nohz_full_cpu(rdp->cpu) &&
+	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
 		   READ_ONCE(rdp->rcu_urgent_qs) &&
 		   !READ_ONCE(rdp->rcu_forced_tick)) {

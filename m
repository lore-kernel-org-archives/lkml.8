Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A2CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB84022B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jx7zXHnF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="80AbwvsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgGaJYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbgGaJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:40 -0400
Date:   Fri, 31 Jul 2020 09:23:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nu8a6GWtLM55D68PAF38xxUuIlE0aD6ajXRFp5bjZR0=;
        b=Jx7zXHnFoJC04z3F3H/rTXueiji27Aq8sFwhCc7rcu0QeK/aZd2uD4yYh1AVJLJ5w4OOjo
        U/4VNnoJoKkGkejn8vP5izx9TzPWKkZLVJlsCsJAlSajprAp5eW0Z0anWirvjTDR2JKJAu
        HFG31h6+IB9JOMbYwiz+0r55xDLRioDUUQ/sRf+sVloTqYhne43EYllRAMksL0Lqb5INTg
        xWW8uxhYOEB4X4joGpfqq8uO+PJVGvhVuXlszPJeCOurO6rAHsXBI6RcRg7j1L5EII4xLy
        IiBphTmWiRX+/AaBAebvAmEmRciS9bT/8LewJsx4NbfYtW3sSoMWDE9sSO3qwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nu8a6GWtLM55D68PAF38xxUuIlE0aD6ajXRFp5bjZR0=;
        b=80AbwvsNaHLY+xyulOSS8PzFKYfnm9L2nzbkuN1bvnQbPobcDr0qYT2gW448RFxtu6Uxxe
        8NU5QpJHfBZKT2Dw==
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] trace: events: rcu: Change description of rcu_dyntick
 trace event
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741730.4006.4689622767533598458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     88748e330040ecf4681a2c8f344fd386862bf913
Gitweb:        https://git.kernel.org/tip/88748e330040ecf4681a2c8f344fd386862bf913
Author:        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
AuthorDate:    Mon, 04 May 2020 08:05:05 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

trace: events: rcu: Change description of rcu_dyntick trace event

The different strings used for describing the polarity are
Start, End and StillNonIdle. Since StillIdle is not used in any trace
point for rcu_dyntick, it can be removed and StillNonIdle can be added
in the description. Because StillNonIdle is used in a few tracepoints for
rcu_dyntick.

Similarly, USER, IDLE and IRQ are used for describing context in
the rcu_dyntick tracepoints. Since, "KERNEL" is not used for any
of the rcu_dyntick tracepoints, remove it from the description.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811..af274d1 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -435,11 +435,12 @@ TRACE_EVENT_RCU(rcu_fqs,
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
- * Tracepoint for dyntick-idle entry/exit events.  These take a string
- * as argument: "Start" for entering dyntick-idle mode, "Startirq" for
- * entering it from irq/NMI, "End" for leaving it, "Endirq" for leaving it
- * to irq/NMI, "--=" for events moving towards idle, and "++=" for events
- * moving away from idle.
+ * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
+ * as argument:
+ * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
+ *            being in dyntick-idle mode.
+ * context: "USER" or "IDLE" or "IRQ".
+ * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is

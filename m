Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A64C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E03620760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0/cef2T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R7nBJYT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbgF3KXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbgF3KWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:22:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CFC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:22:31 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593512547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3zniW4n/OM8BcIQV/WuVaIYVrbed+4lfR5nYD5oP6E=;
        b=S0/cef2TFCiNN3qU/V5E1x/EVH/3dlrSDft6k0IAh1QeAxyAJk8IR0d+GZBsovVQKl1cuN
        /7IsN5CSI0s8fo0r8qBBb6wSoj2p06ojk9+qVpHNqkFRjTD5hT/SeUgOuqmiyj1VwwQV5Y
        R4WnNsMg2Z1kvV6Jtlk2ulpiynErOKrhQLxxsbplbhRRqeWzmlBz6OcMgLUj1EVtQ2YBt+
        5maGhEILHG2KIYxtA5lWI7X5xIOBaJ8urGUFNKCorr+ON6nxnx5ThOxG5s29wTX7SOOesI
        hRwcTuxArMC85r08Ils4UDsYd5KvSxeGs6ewbYTVpwMv1H81whbfG3OajIRspg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593512547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3zniW4n/OM8BcIQV/WuVaIYVrbed+4lfR5nYD5oP6E=;
        b=R7nBJYT68Z0fRczbNGuE2jlSPOkun5e9dbip66L0of4wWv1VgS++Ns/K/9gwMWqRQNSWZh
        ZwDlYyspyK7KVJCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] x86/entry: Use should_resched() in idtentry_exit_cond_resched()
Date:   Tue, 30 Jun 2020 12:22:08 +0200
Message-Id: <20200630102209.1143072-2-bigeasy@linutronix.de>
In-Reply-To: <20200630102209.1143072-1-bigeasy@linutronix.de>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_NEED_RESCHED bit is inlined on x86 into the preemption counter.
So instead checking the preemption counter against zero via
preempt_count() and later checking the TIF_NEED_RESCHED bit via
need_resched() we could use should_resched() which does both checks in
one go.
The functional difference is that we don't enter the if statement with
preempt_count =3D=3D 0 and TIF_NEED_RESCHED not set.

Use should_resched() instead need_resched() + preempt_count().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/entry/common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193c..212382f61b8e4 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -612,13 +612,12 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *=
regs)
=20
 static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sche=
d)
 {
-	if (may_sched && !preempt_count()) {
+	if (may_sched && should_resched(0)) {
 		/* Sanity check RCU and thread stack */
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
-			preempt_schedule_irq();
+		preempt_schedule_irq();
 	}
 	/* Covers both tracing and lockdep */
 	trace_hardirqs_on();
--=20
2.27.0


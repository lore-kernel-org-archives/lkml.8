Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2539D20771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FH0hDqwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GpTxMCGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgF3KXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732454AbgF3KWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:22:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FAC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:22:31 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593512548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PD3/Q5pS4PjHjN7cONw9bS5FLvbbBNreHs+aIigT4o=;
        b=FH0hDqwJOCG0xQXLYM18qDG1ZINB/BE0C1x+8YIf3I4+RNrVh1L6GoWiZA/7WXPH3iQAOa
        07JRrNNUqH2YC56N9YSt/qUqHYf1e8stKymMO3aTlOk8LNT08Aur2DMvJdgoZDn5Rw1e+W
        x7GRrzp4RTG/bi6rxEt0zw8scAR1VJJXt4/4mlJxZV9RrYMOdnIIAtuF+bYwfFX1dcFCTL
        rJkWmaXBRSasUrsNYdMXdpbf04XsvMPFf9YLjO0tZObeJXrT0+2AcJAwHdIipAUVXCglJK
        nIAPgvVZEx4xHoHouEK92HxN1/AGi7al4FVhJXryKucFnpZ4wSKvtOsMXq+8fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593512548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PD3/Q5pS4PjHjN7cONw9bS5FLvbbBNreHs+aIigT4o=;
        b=GpTxMCGVi3k+BykD+ZVabBhDIrQO5MxlPjybabWdJC1git11KMfT0B/Vbu/pJup6e9gbqv
        YJDaSz95gqmplMCw==
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] x86/entry: Remove `regs' parameter from idtentry_exit_cond_resched()
Date:   Tue, 30 Jun 2020 12:22:09 +0200
Message-Id: <20200630102209.1143072-3-bigeasy@linutronix.de>
In-Reply-To: <20200630102209.1143072-1-bigeasy@linutronix.de>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `regs' parameter is not used in idtentry_exit_cond_resched() and can
be removed.

Remove the `regs' parameter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/entry/common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 212382f61b8e4..652dce37643b4 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -610,7 +610,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *re=
gs)
 	return false;
 }
=20
-static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sche=
d)
+static void idtentry_exit_cond_resched(bool may_sched)
 {
 	if (may_sched && should_resched(0)) {
 		/* Sanity check RCU and thread stack */
@@ -664,7 +664,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *reg=
s, bool rcu_exit)
 		}
=20
 		instrumentation_begin();
-		idtentry_exit_cond_resched(regs, IS_ENABLED(CONFIG_PREEMPTION));
+		idtentry_exit_cond_resched(IS_ENABLED(CONFIG_PREEMPTION));
 		instrumentation_end();
 	} else {
 		/*
@@ -770,7 +770,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct p=
t_regs *regs)
 	inhcall =3D get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(rcu_exit)) {
 		instrumentation_begin();
-		idtentry_exit_cond_resched(regs, true);
+		idtentry_exit_cond_resched(true);
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
--=20
2.27.0


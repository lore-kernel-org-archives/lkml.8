Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CEB22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbJ/hBC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHNOC60t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbgGaJYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732497AbgGaJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:35 -0400
Date:   Fri, 31 Jul 2020 09:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z1rVnTtA4SymR2yHqPSK1nKLuYo6uU7FpL506o58dvY=;
        b=DbJ/hBC/UW2KEysRXRZMuG+MiG7O1x8mmCl8hm8eackCxmkUVZ4EfxTNd1RagV5sPgCI4S
        +muynlMthzOJWkWRcgzX/Ve+W19+gS9uBpyfo3Gp+zzzNl0qacPmr42UTNcBUPWOvjXYio
        P+hpoy78HQx0SqmA4SZPnOcS6E5VMQV7sW9OFRssEuEbpAoZ+oPL3EeLp/KbQ6Dvyg8693
        TCv7cRnD65nYIK+K3DT6I0+e6tm7aF/zR8HCqcFPpLrgMyeRKENRWYmW2XKe5n48P+bCNf
        GlzRloeSP7CvppdFipA6bXHNVT7IGyiwJAVRJDuOQCgnF/K+iMavwsXa8NoAPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z1rVnTtA4SymR2yHqPSK1nKLuYo6uU7FpL506o58dvY=;
        b=iHNOC60tm0ZF3H1lS08LUji3rM+AHNeEnXl/WLMusfsqypoI0ML07Tml1HZ8LdokaWAJhS
        68EGjGEz6KRbJuAQ==
From:   "tip-bot2 for Lihao Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Update comment from rsp->rcu_gp_seq to rsp->gp_seq
Cc:     Lihao Liang <lihaoliang@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741323.4006.542000351134449052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     360fbbb4897c98971e8955b063c01250817a2191
Gitweb:        https://git.kernel.org/tip/360fbbb4897c98971e8955b063c01250817a2191
Author:        Lihao Liang <lihaoliang@google.com>
AuthorDate:    Thu, 14 May 2020 21:34:34 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

rcu: Update comment from rsp->rcu_gp_seq to rsp->gp_seq

Signed-off-by: Lihao Liang <lihaoliang@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9c6f734..575745f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -41,7 +41,7 @@ struct rcu_node {
 	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
 					/*  some rcu_state fields as well as */
 					/*  following. */
-	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
+	unsigned long gp_seq;	/* Track rsp->gp_seq. */
 	unsigned long gp_seq_needed; /* Track furthest future GP request. */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
@@ -149,7 +149,7 @@ union rcu_noqs {
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
-	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
+	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
 	bool		core_needs_qs;	/* Core waits for quiesc state. */

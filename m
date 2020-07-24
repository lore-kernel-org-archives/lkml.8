Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2696C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EDD207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yy8gCai4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="53aniql/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGXIdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGXIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:41 -0400
Date:   Fri, 24 Jul 2020 08:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m6Edkp5FBuAdovy3WyQMTLkLFvlqav69MN4qwipEjBM=;
        b=Yy8gCai44vaBbM1Vz9ZkLYUxyY+jibf8u+G6iT+wkEoic/O3gYvyooeE8iJnYsE/zhIcRT
        GjvnuKZF0ySpvi4KFRnlUG6354aWduzx2sxWJxpG4Ocmk1+N6TlpIxtiVNpB+TMJTT89YE
        /VAS5bRsGzXZaakyQcrbprMdnIpVAvK7zsGtfzXl++dzygsyEKm72s1nthVt2EllgzRFzg
        KDCDioOAEc0NamElx1mNBwmfRxY1P2eybxFJBz1odBkdj+eSl4DR+bUDfT26gUGP79LtHZ
        Gy+/DDpg2we5emNz6Is8M3nh3+O31MPncAoYCGItyONH9aU2JRPMxzRmrm/d7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m6Edkp5FBuAdovy3WyQMTLkLFvlqav69MN4qwipEjBM=;
        b=53aniql/EwpS++1YZE1+OHcu7Iq8X6MjWXYb9tPOzdl/F7ZqGocpd0a8IzpaH131aBK3Vf
        JR9DQVU+kkRNEECg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched: Remove sched_setscheduler*() EXPORTs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557961866.4006.6136834931450240430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     616d91b68cd56bcb1954b6a5af7d542401fde772
Gitweb:        https://git.kernel.org/tip/616d91b68cd56bcb1954b6a5af7d542401fde772
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:25 +02:00

sched: Remove sched_setscheduler*() EXPORTs

Now that nothing (modular) still uses sched_setscheduler(), remove the
exports.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 40d3939..f882d3d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5135,13 +5135,11 @@ int sched_setscheduler(struct task_struct *p, int policy,
 {
 	return _sched_setscheduler(p, policy, param, true);
 }
-EXPORT_SYMBOL_GPL(sched_setscheduler);
 
 int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, true, true);
 }
-EXPORT_SYMBOL_GPL(sched_setattr);
 
 int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
@@ -5166,7 +5164,6 @@ int sched_setscheduler_nocheck(struct task_struct *p, int policy,
 {
 	return _sched_setscheduler(p, policy, param, false);
 }
-EXPORT_SYMBOL_GPL(sched_setscheduler_nocheck);
 
 /*
  * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally

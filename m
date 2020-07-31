Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A420722B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiyb06cZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ua03okQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgGaJYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbgGaJXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:43 -0400
Date:   Fri, 31 Jul 2020 09:23:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K/zzpju3P8JA/mFEV8jhp5vPSWQASn1A1A1+l8sxQGk=;
        b=fiyb06cZCntlwl+GDjvXRv76sDPWHqQCOaD9lM41Zz2QlCkPEUC86RPE3fDscn3B+N2XqT
        pw/vnYhFgLrrxePyG45c1i7FCvCE/dBpX7Fy9ksRPwc429QMJu3q+IAueljhsLJ/27ESlG
        Vv1dyGgKIYNeVi1P0JOgX84PmY1vajfHZireNCGq9jVTrTL168b4hc/M7U4UDAXXOsoY9O
        9JY5HQaQpNHbcZjQHZTOWJCXGiGlcT0lUPFDuJNc4uElqncGbVHn2545KCayurz+HmBKqn
        p5Rds4BwAJhWv//v543u6RZWsYgYnoFn+eoPngMrC64yIvYdEpa/fHIIPPQx+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K/zzpju3P8JA/mFEV8jhp5vPSWQASn1A1A1+l8sxQGk=;
        b=ua03okQbO0HpQGskHb0jgtodJdT9puiDawB+ppkLol5Gu1ja/tsdWVrwhqkN2uYgj6ju2C
        AogVQF+TfuwdkMDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Tasks RCU must protect instructions before trampoline
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618742135.4006.12338361732283890463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d93d97cbe0d4369153fb04954f1481a9f42aa5b6
Gitweb:        https://git.kernel.org/tip/d93d97cbe0d4369153fb04954f1481a9f42aa5b6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 11 May 2020 19:52:34 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:11 -07:00

doc: Tasks RCU must protect instructions before trampoline

Protecting the code in a trampoline can also require protecting a
number of instructions prior to actually entering the trampoline.
For example, these earlier instructions might be computing the address
of the trampoline.  This commit therefore updates RCU's requirements to
record this for posterity.

Link: https://lore.kernel.org/lkml/20200511154824.09a18c46@gandalf.local.home/
Reported-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 75b8ca0..a69b5c4 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2583,7 +2583,12 @@ not work to have these markers in the trampoline itself, because there
 would need to be instructions following ``rcu_read_unlock()``. Although
 ``synchronize_rcu()`` would guarantee that execution reached the
 ``rcu_read_unlock()``, it would not be able to guarantee that execution
-had completely left the trampoline.
+had completely left the trampoline. Worse yet, in some situations
+the trampoline's protection must extend a few instructions *prior* to
+execution reaching the trampoline.  For example, these few instructions
+might calculate the address of the trampoline, so that entering the
+trampoline would be pre-ordained a surprisingly long time before execution
+actually reached the trampoline itself.
 
 The solution, in the form of `Tasks
 RCU <https://lwn.net/Articles/607117/>`__, is to have implicit read-side

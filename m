Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3327820786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/ucfh1a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6TIop5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgH0Hzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:55:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgH0Hye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:34 -0400
Date:   Thu, 27 Aug 2020 07:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHd+FRlojFY64CD/2jb5BePt8oYJ9+8pMzCL6LC1ZaQ=;
        b=x/ucfh1aF9vU3GSWyLh5Xq5NS137p56baxw9wBEGJPk4aRVVQdYddIqgmiHWVL13vt0C0Q
        BNouOL3l/agb3Own7KAVNI2F3Gs5D2waHzPLi0naZtwbwWn+SNNEueZXJbwiGKgwRcZz7M
        rH/U1tYVKYCxutuzXOQENoeYLWqFrAUikS7UDQUcJLxuQAfD4MdwlGrNw2+TuhNY96K2HL
        gNYTfAqv+xcK5P5zeNbeOfOt1waSUSWBqbbJTMS2eT1vZjuEOVAMJiF/+LKZtSdI7GF8jL
        QQEyW6Urce/B82m/UYA/7MwoRqypN0BnS+LHsKHwT9cr7wC5Gv6j4XVyDPOIfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHd+FRlojFY64CD/2jb5BePt8oYJ9+8pMzCL6LC1ZaQ=;
        b=P6TIop5O7Yv22fEEtt9CFTsbEfJkI6PodmEsmHfD/S11zziMwwMXEz1rrP/VVf1lwO2PLo
        pEKyn+1gQmmy6GBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Bring the PF_IO_WORKER and PF_WQ_WORKER bits
 closer together
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819195505.y3fxk72sotnrkczi@linutronix.de>
References: <20200819195505.y3fxk72sotnrkczi@linutronix.de>
MIME-Version: 1.0
Message-ID: <159851487173.20229.8088199313658505193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     01ccf592362a984534371b3596d4c953da6a7bb2
Gitweb:        https://git.kernel.org/tip/01ccf592362a984534371b3596d4c953da6a7bb2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 19 Aug 2020 21:55:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:58 +02:00

sched: Bring the PF_IO_WORKER and PF_WQ_WORKER bits closer together

The bits PF_IO_WORKER and PF_WQ_WORKER are tested together in
sched_submit_work() which is considered to be a hot path.
If the two bits cross the 8 or 16 bit boundary then most architecture
require multiple load instructions in order to create the constant
value. Also, such a value can not be encoded within the compare opcode.

By moving the bit definition within the same block, the compiler can
create/use one immediate value.

For some reason gcc-10 on ARM64 requires both bits to be next to each
other in order to issue "tst reg, val; bne label". Otherwise the result
is "mov reg1, val; tst reg, reg1; bne label".

Move PF_VCPU out of the way so that PF_IO_WORKER can be next to
PF_WQ_WORKER.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200819195505.y3fxk72sotnrkczi@linutronix.de
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd93..2bf0af1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1489,9 +1489,10 @@ extern struct pid *cad_pid;
 /*
  * Per process flags
  */
+#define PF_VCPU			0x00000001	/* I'm a virtual CPU */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
-#define PF_VCPU			0x00000010	/* I'm a virtual CPU */
+#define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
 #define PF_MCE_PROCESS		0x00000080      /* Process policy on mce errors */
@@ -1515,7 +1516,6 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
-#define PF_IO_WORKER		0x20000000	/* Task is an IO worker */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 

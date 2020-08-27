Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A4620786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7r3DsHt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KWJI9gA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgH0H5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:57:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgH0HyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:25 -0400
Date:   Thu, 27 Aug 2020 07:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShlSWZaOU2j0A+6omF/deBC41KyJor1u+W/oZ/wsjm0=;
        b=P7r3DsHtqDNZMutTYe7SvZvSmQX73zY02uauc2fs2aCseg3N/2cKvh0aZ17IO/nD/prW1L
        3Bi9b9WUGh7Z88ZQLn5e6uLZnvW+5SS+jwVucAkzjnD/B2g9YXwv87j1VKxGc/qqazxIjR
        Fnyp0Molxiv/Yr+oQhi9YvzGWMG0c3M02XY+rMxGt5OEAABGD0SAqc45JdngNU5WouAhGP
        dDAMqWjJGFIQf/HCzUqOdKqGwmL8yMmIFF6UK1akslgzaJNRi3JA/dWj84ao99FHUPDQZB
        SexiBmi7bjxZAUzjJgVehLWduO0S7UHNCiygRNt7dLkrdEh8A3cn1NEWfh6w5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShlSWZaOU2j0A+6omF/deBC41KyJor1u+W/oZ/wsjm0=;
        b=0KWJI9gAfnJ6yyALneCFBrpaTPnsGZdRxhZ5vhQBS4WWWJBcvPvgCr9Rw9bOuj5WXiwtv8
        IB4OPvRx7PLjE8Ag==
From:   "tip-bot2 for Marta Rybczynska" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation/locking/locktypes: Fix local_locks
 documentation
Cc:     Marta Rybczynska <rybczynska@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
References: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <159851486278.20229.8569920948831137698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     92b4e9f11a636d1723cc0866bf8b9111b1e24339
Gitweb:        https://git.kernel.org/tip/92b4e9f11a636d1723cc0866bf8b9111b1e24339
Author:        Marta Rybczynska <rybczynska@gmail.com>
AuthorDate:    Sun, 26 Jul 2020 20:54:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:02 +02:00

Documentation/locking/locktypes: Fix local_locks documentation

Fix issues with local_locks documentation:

 - fix function names, local_lock.h has local_unlock_irqrestore(), not
   local_lock_irqrestore()

 - fix mapping table, local_unlock_irqrestore() maps to
   local_irq_restore(), not _save()

Signed-off-by: Marta Rybczynska <rybczynska@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com
---
 Documentation/locking/locktypes.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 4cefed8..ddada4a 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -164,14 +164,14 @@ by disabling preemption or interrupts.
 On non-PREEMPT_RT kernels local_lock operations map to the preemption and
 interrupt disabling and enabling primitives:
 
- =========================== ======================
- local_lock(&llock)          preempt_disable()
- local_unlock(&llock)        preempt_enable()
- local_lock_irq(&llock)      local_irq_disable()
- local_unlock_irq(&llock)    local_irq_enable()
- local_lock_save(&llock)     local_irq_save()
- local_lock_restore(&llock)  local_irq_save()
- =========================== ======================
+ ===============================  ======================
+ local_lock(&llock)               preempt_disable()
+ local_unlock(&llock)             preempt_enable()
+ local_lock_irq(&llock)           local_irq_disable()
+ local_unlock_irq(&llock)         local_irq_enable()
+ local_lock_irqsave(&llock)       local_irq_save()
+ local_unlock_irqrestore(&llock)  local_irq_restore()
+ ===============================  ======================
 
 The named scope of local_lock has two advantages over the regular
 primitives:
@@ -353,14 +353,14 @@ protection scope. So the following substitution is wrong::
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock_1, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_1, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock_1, flags);
   }
 
   func2()
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock_2, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_2, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock_2, flags);
   }
 
   func3()
@@ -379,14 +379,14 @@ PREEMPT_RT-specific semantics of spinlock_t. The correct substitution is::
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock, flags);
   }
 
   func2()
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock, flags);
   }
 
   func3()

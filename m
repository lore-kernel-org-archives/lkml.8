Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CAD2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPrMAdUd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ugEezBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgHZQs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:48:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgHZQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:45 -0400
Date:   Wed, 26 Aug 2020 16:45:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598460341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGR++If+ribQsSohR3lDNpsMbmtIOW7a12l0f+wL3x8=;
        b=pPrMAdUd1HWhSg20H3ldNLIZTsOpMGT2bMfphmdZWq1VrN+LXngA2iSxQyJqg3oLZqQ1iP
        RSvg00C2v1hKYEsG2ABt2m1ysHfQLGC66ogk8cmyKgQyb7NjRiiLGCXTdBVHax7FpQe6uL
        g04BJpSI39IFG0nsQWmSq+NP3V6futr8MkHcS5I59xGX+WOD//GYX/0/fGbPKNR4NdR+FO
        34xWe2cuKBtW0gfvPG2Oa3wRSSvZxURVTSgOq1dURrGqE77BadFkqkVuRfGrueZ9y/o7Wl
        i1/kMJeWmxOgZniQzw3W4HMrb2f7HTodeBTaFQmNwPo4vwwFJtiS0dRH3GyBrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598460341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGR++If+ribQsSohR3lDNpsMbmtIOW7a12l0f+wL3x8=;
        b=4ugEezBHGk5JKZoQWuLSWbPftXQWcYTN3bDcuXHuzpSPxsHjLYbcpo47lSSSiegnYw5KFr
        /XXvBrEL27xhaJCw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Delay clearing IA32_MCG_STATUS to the end of
 do_machine_check()
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200824221237.5397-1-tony.luck@intel.com>
References: <20200824221237.5397-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <159846034062.389.5520610330060261726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1e36d9c6886849c6f3d3c836370563e6bc1a6ddd
Gitweb:        https://git.kernel.org/tip/1e36d9c6886849c6f3d3c836370563e6bc1a6ddd
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 24 Aug 2020 15:12:37 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 26 Aug 2020 18:40:18 +02:00

x86/mce: Delay clearing IA32_MCG_STATUS to the end of do_machine_check()

A long time ago, Linux cleared IA32_MCG_STATUS at the very end of machine
check processing.

Then, some fancy recovery and IST manipulation was added in:

  d4812e169de4 ("x86, mce: Get rid of TIF_MCE_NOTIFY and associated mce tricks")

and clearing IA32_MCG_STATUS was pulled earlier in the function.

Next change moved the actual recovery out of do_machine_check() and
just used task_work_add() to schedule it later (before returning to the
user):

  5567d11c21a1 ("x86/mce: Send #MC singal from task work")

Most recently the fancy IST footwork was removed as no longer needed:

  b052df3da821 ("x86/entry: Get rid of ist_begin/end_non_atomic()")

At this point there is no reason remaining to clear IA32_MCG_STATUS early.
It can move back to the very end of the function.

Also move sync_core(). The comments for this function say that it should
only be called when instructions have been changed/re-mapped. Recovery
for an instruction fetch may change the physical address. But that
doesn't happen until the scheduled work runs (which could be on another
CPU).

 [ bp: Massage commit message. ]

Reported-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200824221237.5397-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78b..0ba24df 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1190,6 +1190,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		sync_core();
 		return;
 	}
 
@@ -1330,12 +1331,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
 
-	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-
-	sync_core();
-
 	if (worst != MCE_AR_SEVERITY && !kill_it)
-		return;
+		goto out;
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
@@ -1364,6 +1361,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
 	}
+out:
+	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 

Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E39C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0010D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594851376;
	bh=AduDpuP4BuNgA0+vcxsVbUCT/F7CI9dj/FjNHV2Uc+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=loJIChbVhuVeLD1lACtW9h1Qdnup/Exd0rVVJxTxGTiIfwWWfiTWkJk7jOWLv5diO
	 HlejWszxlREgkepx2nUEJmOiBqLLzcHbsYKbwN8ILl3DA69hkKsD+HecDacGb21SH8
	 j8K4BA3LgcodMEtk0oJcvKENNBc7KyG/s3638hZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGOWQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgGOWQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:16:14 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4816B2064C;
        Wed, 15 Jul 2020 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594851373;
        bh=AduDpuP4BuNgA0+vcxsVbUCT/F7CI9dj/FjNHV2Uc+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBIPXYF0vN7qpDTm/mSfI5fR9iVNwpI6ea/FEqvK8YNM/M5Ar+GlxMwguV+OUSnD/
         JnqGTsblfMth1GRyguJGjinZNXstKgOE4BmXDV4LKvKys4mgaZrraSWQTzwb/PzCIL
         QDkHkrThhwuiiANvS333UlFcKk1CNj5UeCWuiM/w=
Date:   Thu, 16 Jul 2020 00:16:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] timer: Preserve higher bits of expiration on index
 calculation
Message-ID: <20200715221610.GC16227@lenoir>
References: <20200714072924.6810-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200714072924.6810-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 09:29:24AM +0200, Anna-Maria Behnsen wrote:
> The bucket expiry time is the effective expriy time of timers and is
> greater than or equal to the requested timer expiry time. This is due
> to the guarantee that timers never expire early and the reduced expiry
> granularity in the secondary wheel levels.
> 
> When a timer is enqueued, trigger_dyntick_cpu() checks whether the
> timer is the new first timer. This check compares next_expiry with
> the requested timer expiry value and not with the effective expiry
> value of the bucket into which the timer was queued.
> 
> Storing the requested timer expiry value in base->next_expiry can lead
> to base->clk going backwards if the requested timer expiry value is
> smaller than base->clk. Commit 30c66fc30ee7 ("timer: Prevent base->clk
> from moving backward") worked around this by preventing the store when
> timer->expiry is before base->clk, but did not fix the underlying
> problem.
> 
> Use the expiry value of the bucket into which the timer is queued to
> do the new first timer check. This fixes the base->clk going backward
> problem.
> 
> The workaround of commit 30c66fc30ee7 ("timer: Prevent base->clk from
> moving backward") in trigger_dyntick_cpu() is not longer necessary as the
> timers bucket expiry is guaranteed to be greater than or equal base->clk.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Actually I triggered the nasty warning in forward_timer_base()
with base->next_expiry < base->clk.

You'll need to first apply the following before your patch:


--Dxnq1zWXvFF0Q93v
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-timer-Preserve-higher-bits-of-expiration-on-index-ca.patch"

From 9770c3de69749cc2b8d1f295cecf12848212360e Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 15 Jul 2020 23:49:09 +0200
Subject: [PATCH] timer: Preserve higher bits of expiration on index
 calculation

The higher bits of the timer expiration are cropped while calling
calc_index() due to the implicit cast from unsigned long to unsigned int.

This loss shouldn't have consequences on the current code since all the
computation to calculate the index is done on the lower 32 bits.

However we are preparing to return the actual bucket expiration from
calc_index() in order to properly fix base->next_expiry updates.
Preserving the higher bits is a requirement to achieve that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9a838d38dbe6..95e0b66f81ec 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -487,7 +487,7 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  * Helper function to calculate the array index for a given expiry
  * time.
  */
-static inline unsigned calc_index(unsigned expires, unsigned lvl)
+static inline unsigned calc_index(unsigned long expires, unsigned lvl)
 {
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
-- 
2.26.2


--Dxnq1zWXvFF0Q93v--

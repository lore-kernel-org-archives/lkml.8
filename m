Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC4F20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565859;
	bh=5QnwqZem3Sns7VPQAYf4JdpSiN/3iBgfzyx/I/rIuFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLBCzL7pzFgOjHXQYAueS9aZy/vzhcXs3Rd9cjPm7+Yk0ktsya0XktmoaA0K4Wkwo
	 lPCqR5UOWusTT0Doj0KXRBCpYhAcYqFsgVFIYe56wWABXvglHLs4YiJYKtgHGqmIoR
	 M5SEb2xPL7PndatakFf5KZjeMO7nKu3zCw4huwoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGABK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGABKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:52 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD47E2078B;
        Wed,  1 Jul 2020 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565851;
        bh=5QnwqZem3Sns7VPQAYf4JdpSiN/3iBgfzyx/I/rIuFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5i0zGfMx/F/Tn/zbng8z3I2w6DKkPsyjW1ZyCwsBcn4vIkFDuExomG6rXYZ2Zq8m
         1jnztlAErO6fCBre76IbM5ssV/9aasBEjXdRCX8sBgGAsXs3ODtpAQKHaR+o4Vr4zg
         rR4xi7OT9t21gpgXocy8LHHGpM6I5njW/miIkjjg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
Date:   Wed,  1 Jul 2020 03:10:30 +0200
Message-Id: <20200701011030.14324-11-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no apparent reason for not forwarding base->clk when it's 2
jiffies late, except perhaps for past optimizations. But since forwarding
has to be done at some point now anyway, this doesn't stand anymore.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 439fee098e76..25a55c043297 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -883,7 +883,7 @@ static inline void forward_timer_base(struct timer_base *base)
 	 * Also while executing timers, base->clk is 1 offset ahead
 	 * of jiffies to avoid endless requeuing to current jffies.
 	 */
-	if ((long)(jnow - base->clk) < 2)
+	if ((long)(jnow - base->clk) < 1)
 		return;
 
 	/*
-- 
2.26.2


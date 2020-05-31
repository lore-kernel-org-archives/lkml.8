Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD35C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E2C20723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEaN7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgEaN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 09:59:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4CC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:59:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jfOUO-0004yY-2r; Sun, 31 May 2020 15:59:00 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1D4AC100F9F;
        Sun, 31 May 2020 15:58:59 +0200 (CEST)
Date:   Sun, 31 May 2020 13:58:40 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.7
Message-ID: <159093352092.1582.2279719529823662123.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-05-31

up to:  18f855e574d9: sched/fair: Don't NUMA balance for kthreads


A single scheduler fix preventing a crash in NUMA balancing. The
current->mm check is not reliable as the mm might be temporary
due to use_mm() in a kthread. Check for PF_KTHREAD explictely.

Thanks,

	tglx

------------------>
Jens Axboe (1):
      sched/fair: Don't NUMA balance for kthreads


 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 538ba5d94e99..da3e5b54715b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2908,7 +2908,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
-	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
+	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
 	/*


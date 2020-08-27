Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1742AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E469722CBE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZt5ChX3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ip5T+hPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgH0Hzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgH0Hyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C730EC061234;
        Thu, 27 Aug 2020 00:54:34 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55cGruY+B0dVQV9P4Eow2/bJcYQE5JD3/Wkynw44aVo=;
        b=VZt5ChX397znn35MugUEwYuQYUqEKfpcxfjw1dYEPNRA1BWuMwHVB4Wwn6dHb5FnAqZZMY
        UJu53ba9g6L3p1b9T7RXeY276BT6EPmFGVGoaO7ue7dyZ7mTU/QaUZqloPF2j7CxedJD0A
        M5vC71d3Cw3WL76XqjlClWoLnOzGOR4/g2VOQoPSarHuOAdWTd1U+xr7cgiNA54/6U7O0L
        Kn5dSKFcOKYIaVC4LMSVpw7xR+i5OodaZY7wsYbOBUnVP+B8RQ759BYZ2bxU9P51KWbyoc
        Zw3FhItefaOFlPfqhhlKywhjCTjFHU7gFA9VHAjfYcjNkXVnTlQSIEqVzysh+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55cGruY+B0dVQV9P4Eow2/bJcYQE5JD3/Wkynw44aVo=;
        b=Ip5T+hPFuhpQqJ3b6IowaM1vNt+os1Ac+UqtWbVQZBafrX6gMWZ21RdgLqiV7yrBJHnMYq
        39wiblKayWe9/wDg==
From:   "tip-bot2 for Lukasz Luba" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix wrong negative conversion in
 find_energy_efficient_cpu()
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200810083004.26420-1-lukasz.luba@arm.com>
References: <20200810083004.26420-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <159851487259.20229.13312662198883058860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     da0777d35f47892f359c3f73ea155870bb595700
Gitweb:        https://git.kernel.org/tip/da0777d35f47892f359c3f73ea155870bb595700
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 10 Aug 2020 09:30:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:57 +02:00

sched/fair: Fix wrong negative conversion in find_energy_efficient_cpu()

In find_energy_efficient_cpu() 'cpu_cap' could be less that 'util'.
It might be because of RT, DL (so higher sched class than CFS), irq or
thermal pressure signal, which reduce the capacity value.
In such situation the result of 'cpu_cap - util' might be negative but
stored in the unsigned long. Then it might be compared with other unsigned
long when uclamp_rq_util_with() reduced the 'util' such that is passes the
fits_capacity() check.

Prevent this situation and make the arithmetic more safe.

Fixes: 1d42509e475cd ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20200810083004.26420-1-lukasz.luba@arm.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index abdb54e..90ebaa4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6594,7 +6594,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
-			spare_cap = cpu_cap - util;
+			spare_cap = cpu_cap;
+			lsub_positive(&spare_cap, util);
 
 			/*
 			 * Skip CPUs that cannot satisfy the capacity request.

Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37738C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113BE204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOTe/h3Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ma2XIpCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHSOEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgHSOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5475C061345;
        Wed, 19 Aug 2020 07:02:48 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P91li+w6q2DmV8ltBPTXv4/WUt63XR0Ij39EPr+H7XI=;
        b=wOTe/h3ZboAgnRhGonErZYddA07Spp0OuOtL8j0jpt81q2uxC1g+H0BeOysvxAMSNAZ/DP
        XQttYgXo5QVHB8ubUdXnhQmW5L9ygo+Dt+oRM9cQxOr2Jr9kGIkD/mUcQNKMIXygvsBfAg
        qiyTR2BhdR7u6e0skfWovtH9Bb7DgK2UdwL+mtK7o9ri99emJ538PwdR6hkFGoAdwgKYFH
        YKLWgS7FmS1MkTuTylRo12MinzAkNSC3YIfui2qeSWiypJgXJ6GJ01iFmryYHm3xvotBSK
        laNscncR/dOhiCZtPALR8k6r08cT5oTw1NoPD0BuZPhYbJbsNQzrg/fQ2rXviw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P91li+w6q2DmV8ltBPTXv4/WUt63XR0Ij39EPr+H7XI=;
        b=ma2XIpCP6ITnV+OX1dy+slZYwLaaoqmb2ehBMR/eeDHO2YlqU3980pdFfPTRheinhiYK9W
        tDieF1Ob3xo3hsAQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-11-valentin.schneider@arm.com>
References: <20200817113003.20802-11-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576564.3192.9478277470709214393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c200191d4c2c1aa2ffb62a984b756ac1f02dc55c
Gitweb:        https://git.kernel.org/tip/c200191d4c2c1aa2ffb62a984b756ac1f02dc55c
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:49 +02:00

sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards

We currently set this flag *only* on domains whose topology level exactly
match the level where we detect asymmetry (as returned by
asym_cpu_capacity_level()). This is rather problematic.

Say there are two clusters in the system, one with a lone big CPU and the
other with a mix of big and LITTLE CPUs (as is allowed by DynamIQ):

  DIE [                ]
  MC  [             ][ ]
       0   1   2   3  4
       L   L   B   B  B

asym_cpu_capacity_level() will figure out that the MC level is the one
where all CPUs can see a CPU of max capacity, and we will thus set
SD_ASYM_CPUCAPACITY at MC level for all CPUs.

That lone big CPU will degenerate its MC domain, since it would be alone in
there, and will end up with just a DIE domain. Since the flag was only set
at MC, this CPU ends up not seeing any SD with the flag set, which is
broken.

Rather than clearing dflags at every topology level, clear it before
entering the topology level loop. This will properly propagate upwards
flags that are set starting from a certain level.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-11-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 4 +++-
 kernel/sched/topology.c        | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index ee5cbfc..40ad0d5 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -83,9 +83,11 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
 /*
  * Domain members have different CPU capacities
  *
+ * SHARED_PARENT: Set from the topmost domain down to the first domain where
+ *                asymmetry is detected.
  * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
  */
-SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_NEEDS_GROUPS)
+SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU capacity (i.e. SMT)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c662c53..f36ed96 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1988,11 +1988,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Set up domains for CPUs specified by the cpu_map: */
 	for_each_cpu(i, cpu_map) {
 		struct sched_domain_topology_level *tl;
+		int dflags = 0;
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
-			int dflags = 0;
-
 			if (tl == tl_asym) {
 				dflags |= SD_ASYM_CPUCAPACITY;
 				has_asym = true;

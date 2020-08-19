Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A01C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95BB2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SGf9XniG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfyJji4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHSOGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:06:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgHSOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:53 -0400
Date:   Wed, 19 Aug 2020 14:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0qXOPz6mLQ9JBhFivYYTZiimIEhBmW58IHHR/ei91c=;
        b=SGf9XniGVvKN3uMPK71oNxyEbnIMFQ0v+iKP6r+lGlwvTRkJQBa0NVvL9Ea1vCIdJUbQ6F
        vDvhxItaZATWVkJKWlsIDhhjcu6VPef/sqM+WoJj9B24alm9cr+H+Qv2JgXlqaqQ4PU5Ku
        pxD+W52xIOjS1435VApPprcdgs5YLETN4Q164W466A8tCu+r/tcr/5Owzddut6yYuAMqMp
        EvwiRwDfA+1A4HmdRLbI/IxCw1s7ryN1Iso1Ri56iAJ26UY6ma4fDWbweOuVQYrT/KAn7h
        TGQo56ITQXpMQMtO10eTqKeEAVtcwKLqUEPZPNQnqZtfkWyvdIa0YxkPjSmG+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0qXOPz6mLQ9JBhFivYYTZiimIEhBmW58IHHR/ei91c=;
        b=lfyJji4aPBFqgM7Qm6OQP007WF98W/XeWMkB1AI9mGJdEMTVqeZ6TlVX+6fQayWznpU3oa
        uIIwfigYR7RRnKDg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] ARM, sched/topology: Revert back to default
 scheduler topology
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-3-valentin.schneider@arm.com>
References: <20200817113003.20802-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784577092.3192.9588870511768297238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d23b3bf8e43faa54a6839aafd6fedc15a3c4174f
Gitweb:        https://git.kernel.org/tip/d23b3bf8e43faa54a6839aafd6fedc15a3c4174f
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:48 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:47 +02:00

ARM, sched/topology: Revert back to default scheduler topology

The ARM-specific GMC level is meant to be built using the thread sibling
mask, but no devicetree in arch/arm/boot/dts uses the 'thread' cpu-map
binding. With SD_SHARE_POWERDOMAIN gone, this topology level can be
removed, at which point ARM no longer benefits from having a custom defined
topology table.

Delete the GMC topology level by making ARM use the default scheduler
topology table. This essentially reverts commit:

  fb2aa85564f4 ("sched, ARM: Create a dedicated scheduler topology table")

No change in functionality is expected.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-3-valentin.schneider@arm.com
---
 arch/arm/kernel/topology.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 353f3ee..ef0058d 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -178,15 +178,6 @@ static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
 /*
- * The current assumption is that we can power gate each core independently.
- * This will be superseded by DT binding once available.
- */
-const struct cpumask *cpu_corepower_mask(int cpu)
-{
-	return &cpu_topology[cpu].thread_sibling;
-}
-
-/*
  * store_cpu_topology is called at boot when only one cpu is running
  * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
  * which prevents simultaneous write access to cpu_topology array
@@ -241,20 +232,6 @@ topology_populated:
 	update_siblings_masks(cpuid);
 }
 
-static inline int cpu_corepower_flags(void)
-{
-	return SD_SHARE_PKG_RESOURCES;
-}
-
-static struct sched_domain_topology_level arm_topology[] = {
-#ifdef CONFIG_SCHED_MC
-	{ cpu_corepower_mask, cpu_corepower_flags, SD_INIT_NAME(GMC) },
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-#endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
-
 /*
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
@@ -265,7 +242,4 @@ void __init init_cpu_topology(void)
 	smp_wmb();
 
 	parse_dt_topology();
-
-	/* Set scheduler topology descriptor */
-	set_sched_topology(arm_topology);
 }

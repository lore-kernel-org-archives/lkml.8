Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C406C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3902204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0/DRJCq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wr/iuh4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgHSOFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgHSOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12309C061347;
        Wed, 19 Aug 2020 07:02:52 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6fuaozmURtS2UQqFRVBArpk4tmBTGcUb0cHk2rZVWc=;
        b=f0/DRJCq5/vLdlqOcCu/gB3w57rm+5+6rsEG3JaHGggGzzc62AcRWxd8hpfkuZaNlUv0WY
        w+HAO3vEAFfQ+YUPXaSoKDL6WL3mZZU+7O7tGVIpEzL4ovOsmRbfuwOnV5uQwyDMeSDDOC
        SZPzc7EAVX9JBno6r0TjOENEe5mQ6FcIoXd2ywVE6MloYqNKFHrYRw8GJOCRC10gQRbWYH
        HNSMur5FAFi62niYHZzx++3LGJHR9VPORUhh/dKR8KtRQK6QxQ6b6+WDuqBUuszT/+c8XM
        /yE1YI7q3Jm4TYK2qNIyNrx69Ed7cEajg3Vxt6inRE3yPRWM+0RQuYDLI/8d+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6fuaozmURtS2UQqFRVBArpk4tmBTGcUb0cHk2rZVWc=;
        b=wr/iuh4oW87ZzwHiSFS0ywQf095nPryy7KILt0lsNPFDARrDLiDcovNGn19/2VSiOLqcfY
        yCJVCRRU4ne2UFDQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Verify SD_* flags setup when
 sched_debug is on
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-6-valentin.schneider@arm.com>
References: <20200817113003.20802-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576893.3192.14095927002561810967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     65c5e253168dbbb52c20026b0c5b7a2f344b9197
Gitweb:        https://git.kernel.org/tip/65c5e253168dbbb52c20026b0c5b7a2f344b9197
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:48 +02:00

sched/topology: Verify SD_* flags setup when sched_debug is on

Now that we have some description of what we expect the flags layout to
be, we can use that to assert at runtime that the actual layout is sane.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-6-valentin.schneider@arm.com
---
 kernel/sched/topology.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index fe03969..cbdaf08 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -29,6 +29,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 				  struct cpumask *groupmask)
 {
 	struct sched_group *group = sd->groups;
+	unsigned long flags = sd->flags;
+	unsigned int idx;
 
 	cpumask_clear(groupmask);
 
@@ -43,6 +45,21 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 		printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
 	}
 
+	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
+		unsigned int flag = BIT(idx);
+		unsigned int meta_flags = sd_flag_debug[idx].meta_flags;
+
+		if ((meta_flags & SDF_SHARED_CHILD) && sd->child &&
+		    !(sd->child->flags & flag))
+			printk(KERN_ERR "ERROR: flag %s set here but not in child\n",
+			       sd_flag_debug[idx].name);
+
+		if ((meta_flags & SDF_SHARED_PARENT) && sd->parent &&
+		    !(sd->parent->flags & flag))
+			printk(KERN_ERR "ERROR: flag %s set here but not in parent\n",
+			       sd_flag_debug[idx].name);
+	}
+
 	printk(KERN_DEBUG "%*s groups:", level + 1, "");
 	do {
 		if (!group) {

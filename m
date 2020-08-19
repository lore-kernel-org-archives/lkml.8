Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5088C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779B62067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KN57h8aR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oaAtTNuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHSOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgHSOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C1C061344;
        Wed, 19 Aug 2020 07:02:48 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQKuK7h3OMPbycuwXBR7s2cguCYUy0r+G1mampHm8YY=;
        b=KN57h8aRd4HvFngwNbEJLE0r0gWc/VHGUPxldoRn+EAq9ahl8mqGU1Oj4hwERFfSmw2nl8
        OqmQe9QJcGbi8Aw/q+tw2xQHmpFAir4xHhYax1sSOVsXCg0WPI0ZOFquUgo7+7uNcTawg6
        IwMlPcVIvA3jyqUTc5tPt6BIIYbUYXpfFbnG9qaINurahHhhQQNzzI/WLaxY3L2IkQxdTI
        ijXfIeBYAqZfpgFr++54TAz4BVFwm0OnovWFajReueC+e6Y0og0dUGodm6rl/Zr5cLNOPP
        5smcbauGL+kXCCfCPRd5KobWaFBqRN8nr2Pr9MZxXvulii1s2Gbleuasd3cjng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQKuK7h3OMPbycuwXBR7s2cguCYUy0r+G1mampHm8YY=;
        b=oaAtTNuD7S0RwUx0d9M6FxRz8VlpCZse0anZfzOAY6cnoT4KNllgbl4/rdGhFdaWPPsacV
        kEe/LGovVS3V4LCA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_PREFER_SIBLING as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-12-valentin.schneider@arm.com>
References: <20200817113003.20802-12-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576501.3192.3426239142100126553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3a6712c7685352a5d71eaf459a4fddfc3589f018
Gitweb:        https://git.kernel.org/tip/3a6712c7685352a5d71eaf459a4fddfc3589f018
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:49 +02:00

sched/topology: Mark SD_PREFER_SIBLING as SDF_NEEDS_GROUPS

SD_PREFER_SIBLING is currently considered in sd_parent_degenerate() but not
in sd_degenerate(). It too hinges on load balancing, and thus won't have
any effect when set on a domain with a single group. Add it to
SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-12-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 4 +++-
 kernel/sched/topology.c        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 40ad0d5..d28fe67 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -131,8 +131,10 @@ SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD)
  *
  * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
  * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
+ *
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_PREFER_SIBLING, 0)
+SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
 
 /*
  * sched_groups of this level overlap
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f36ed96..c674aaa 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -184,7 +184,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next)
-		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
+		pflags &= ~SD_DEGENERATE_GROUPS_MASK;
 
 	if (~cflags & pflags)
 		return 0;

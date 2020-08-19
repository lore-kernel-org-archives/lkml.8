Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AD4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2A8204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0g7/SVpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ep91QEHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHSOGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgHSOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E5C061757;
        Wed, 19 Aug 2020 07:02:50 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fduUs2llT1q1Xx3qiiobcLkR9jqkNHnZPxzfLXB5oxw=;
        b=0g7/SVporcjlPY/43UB6iiM7WsMZacKIEkOZB2tRSEsfLhPgpFBYMVmTty94VOsqZEYK0f
        ny9uPVrolykELmYw+kwTprQMcqr14hgC7Q9ew/ECAUD6VUsE2JATn3SMd4++qVO3b7recQ
        xkaiwNojVaTPe5P0lbIJXJkuvA/Vj95ZKGxH4cLX9Ru7BDSjXyAx0X1n37esr6Aj6wP/xi
        rPT0ggQCheRLvvdJLW8hE/o5h/vcjz47nCBmXFlZ8rsCmrfBqAipOxAP5kdu4m/5ZA7mKP
        vS8mN2xK9gTJVX4mbzYotyeEsjdbsHuqfAsvY4xHrb7sH6eOQeJD+U6qursNRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fduUs2llT1q1Xx3qiiobcLkR9jqkNHnZPxzfLXB5oxw=;
        b=Ep91QEHm6JnBtL1sz142ElHWO/aCq/Lr0+5RVHZjOmcaG4hJI0UFhswfzgd/aX2pI1OLKg
        /NKEz2UQTAQL27Ag==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Use prebuilt SD flag degeneration mask
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-9-valentin.schneider@arm.com>
References: <20200817113003.20802-9-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576699.3192.17019412360260680450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6f349818621dff364fc000909135d0065e9756c9
Gitweb:        https://git.kernel.org/tip/6f349818621dff364fc000909135d0065e9756c9
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:48 +02:00

sched/topology: Use prebuilt SD flag degeneration mask

Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
sd_parent_degenerate().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-9-valentin.schneider@arm.com
---
 kernel/sched/topology.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cbdaf08..38e6671 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -160,15 +160,9 @@ static int sd_degenerate(struct sched_domain *sd)
 		return 1;
 
 	/* Following flags need at least 2 groups */
-	if (sd->flags & (SD_BALANCE_NEWIDLE |
-			 SD_BALANCE_FORK |
-			 SD_BALANCE_EXEC |
-			 SD_SHARE_CPUCAPACITY |
-			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES)) {
-		if (sd->groups != sd->groups->next)
-			return 0;
-	}
+	if ((sd->flags & SD_DEGENERATE_GROUPS_MASK) &&
+	    (sd->groups != sd->groups->next))
+		return 0;
 
 	/* Following flags don't use groups */
 	if (sd->flags & (SD_WAKE_AFFINE))
@@ -190,13 +184,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next) {
-		pflags &= ~(SD_BALANCE_NEWIDLE |
-			    SD_BALANCE_FORK |
-			    SD_BALANCE_EXEC |
-			    SD_ASYM_CPUCAPACITY |
-			    SD_SHARE_CPUCAPACITY |
-			    SD_SHARE_PKG_RESOURCES |
-			    SD_PREFER_SIBLING);
+		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}

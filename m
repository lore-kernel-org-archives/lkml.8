Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54792C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BEC20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GOpTIw4W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7c4jKZ9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgH0Hyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgH0Hyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:32 -0400
Date:   Thu, 27 Aug 2020 07:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BInk0uHR7DRXZQUP0QywiS82w6J6yCk+1OCKGg5qNlc=;
        b=GOpTIw4WTxQIz+dxx0KMvi+/ZGTTwyH5emfSrYx+Kmx5IjjneKEJYVb9+GWU70dCYgWbHq
        2mc9BsJbncgDy46SDZoVFLwnZPymAQ0yAzd9iXijJK19//GrMS4+TtJ3R9nYeHC2n6v35C
        htEhzt0H64IrQ67yXFXnr8z0+S0fhAVIiZ+a5IFKvoBfFHd5ugvu/Nx5GmnNUYTPNlLp/a
        rzApxCeakxapKCb1Bb3Kdb9sG3fs8x50QSj4a3HQROZybiLRXzmNLvrp9UolQST+4zCiFr
        LwSspFgfJpK7PZCSXavNXS2pqGX5bn0XeXjIXhgrN2gI37YVs6uXwkmEpBPrNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BInk0uHR7DRXZQUP0QywiS82w6J6yCk+1OCKGg5qNlc=;
        b=7c4jKZ9y6IgPP/J5CMSULjGQbimzZ3irdty9Rx51OUT04XoBWM4fUyQBH8ypbASq4V9D1w
        YUvK4TDeOYzbIWCw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Move SD_DEGENERATE_GROUPS_MASK out
 of linux/sched/topology.h
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200825133216.9163-2-valentin.schneider@arm.com>
References: <20200825133216.9163-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159851487046.20229.3637647119977247598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4fc472f1214ef75e5450f207e23ff13af6eecad4
Gitweb:        https://git.kernel.org/tip/4fc472f1214ef75e5450f207e23ff13af6eecad4
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 25 Aug 2020 14:32:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:59 +02:00

sched/topology: Move SD_DEGENERATE_GROUPS_MASK out of linux/sched/topology.h

SD_DEGENERATE_GROUPS_MASK is only useful for sched/topology.c, but still
gets defined for anyone who imports topology.h, leading to a flurry of
unused variable warnings.

Move it out of the header and place it next to the SD degeneration
functions in sched/topology.c.

Fixes: 4ee4ea443a5d ("sched/topology: Introduce SD metaflag for flags needing > 1 groups")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200825133216.9163-2-valentin.schneider@arm.com
---
 include/linux/sched/topology.h | 7 -------
 kernel/sched/topology.c        | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index b9b0dab..9ef7bf6 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -25,13 +25,6 @@ enum {
 };
 #undef SD_FLAG
 
-/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
-#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
-static const unsigned int SD_DEGENERATE_GROUPS_MASK =
-#include <linux/sched/sd_flags.h>
-0;
-#undef SD_FLAG
-
 #ifdef CONFIG_SCHED_DEBUG
 
 struct sd_flag_debug {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c674aaa..aa1676a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -154,6 +154,13 @@ static inline bool sched_debug(void)
 }
 #endif /* CONFIG_SCHED_DEBUG */
 
+/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
+#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
+static const unsigned int SD_DEGENERATE_GROUPS_MASK =
+#include <linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 static int sd_degenerate(struct sched_domain *sd)
 {
 	if (cpumask_weight(sched_domain_span(sd)) == 1)

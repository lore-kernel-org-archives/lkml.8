Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5914920786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYE7POQD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVHrmND1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgH0Hzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgH0Hyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1FC061235;
        Thu, 27 Aug 2020 00:54:35 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VwYgaI1w5KIG9TIKMB+coCvWg7uRAM5MhyfKNZYobg=;
        b=oYE7POQD8TXKXyayktnlYP7mPHjrO+OAyUmZT2NpByB5Zs2oqmL21ZmxDlEXlkdmZLnn+Z
        IkPVSXzLkyfqf8Hubs05FKGDwENaDInOrklIS+tMEY9ypxi0r9BhzxlQGOaH7KGx9uFLwx
        wSx/8DKa6lx9ehTfdXAyyyujwIFJlackpzqVpq9NzDCD+yFdAGfS3cfx3BLqUqIrp7ZaQt
        DHAO+vxs8hvaRRFrHFv/1BA0taGfSrRQnTbPT/PQgDdn2IXxmx4dPGOixkKArgJUoq0yWX
        Gp/5TUHg4LWkvx2nT7FUXF46r3qmepWO52qB+dGk08s1R/IdUC2Lak9+ztxkQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VwYgaI1w5KIG9TIKMB+coCvWg7uRAM5MhyfKNZYobg=;
        b=KVHrmND1r9ZvEHgmqVv7rJb7kSc11xYrcsBv59Nj3lrOvnu6vc6JnwxEDVxUkn1ejn640F
        j5auGE64UCMRmkAA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Ignore cache hotness for SMT migration
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804193413.510651-1-joshdon@google.com>
References: <20200804193413.510651-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <159851487304.20229.3769539649490715619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ec73240b1627cddfd7cef018c7fa1c32e64a721e
Gitweb:        https://git.kernel.org/tip/ec73240b1627cddfd7cef018c7fa1c32e64a721e
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Tue, 04 Aug 2020 12:34:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:57 +02:00

sched/fair: Ignore cache hotness for SMT migration

SMT siblings share caches, so cache hotness should be irrelevant for
cross-sibling migration.

Signed-off-by: Josh Don <joshdon@google.com>
Proposed-by: Venkatesh Pallipadi <venki@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200804193413.510651-1-joshdon@google.com
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..abdb54e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7402,6 +7402,10 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (unlikely(task_has_idle_policy(p)))
 		return 0;
 
+	/* SMT siblings share cache */
+	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
+		return 0;
+
 	/*
 	 * Buddy candidates are cache hot:
 	 */

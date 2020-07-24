Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA7BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2942074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STiQQZ5l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vog9Butn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGXMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:02:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:02:26 -0400
Date:   Fri, 24 Jul 2020 12:02:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595592144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9/bQiuMXBJXcb9ufzaf/3ECaiQiQB1+J3WjwdA+kc4=;
        b=STiQQZ5lIZpAYf1MN7mjjVUBKq7nC9vgR9kzICLa0hGT38Fs3FocksmL40/fAn/QOMRvTk
        C+ud/F8L4WAhDUzQxpaMDBYWdk8gp4E9CWeLxdIwXPQwsl/A78LEl4ocpyMN0HLupMh61n
        62piRlqZ2VR03uXmUyZ+igQ7hUbxDTmkXdGtZrxO6te1HN6btTLsRxW74r+lpFRwwNHekX
        U7yHLsVizk1xCE+m2VgmbzVo1wLBU5nuyMQs+a8YaDE9s1dYKHaroklgiVWkTSRqZa2PhP
        wqKfCeSl74hew9aY4iPAAsBcYMttL5pBZThauqcZk2DOwfb7gRl6MCjuQlXMMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595592144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9/bQiuMXBJXcb9ufzaf/3ECaiQiQB1+J3WjwdA+kc4=;
        b=vog9Butn+GaeAVwwU7DXySjWclWrM2qkO6z/GKHcwNy8AES8OA4VLHaFdjYrBvYQKUJVIK
        /h4bODmvpgyeXlBQ==
From:   "tip-bot2 for Chris Wilson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Warn if garbage is passed to default_wake_function()
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723201042.18861-1-chris@chris-wilson.co.uk>
References: <20200723201042.18861-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Message-ID: <159559214399.4006.3614094592571422254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     da3520d750e36051ecd5847ef712659b9c68ce20
Gitweb:        https://git.kernel.org/tip/da3520d750e36051ecd5847ef712659b9c68ce20
Author:        Chris Wilson <chris@chris-wilson.co.uk>
AuthorDate:    Thu, 23 Jul 2020 21:10:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 24 Jul 2020 13:47:12 +02:00

sched: Warn if garbage is passed to default_wake_function()

Since the default_wake_function() passes its flags onto
try_to_wake_up(), warn if those flags collide with internal values.

Given that the supplied flags are garbage, no repair can be done but at
least alert the user to the damage they are causing.

In the belief that these errors should be picked up during testing, the
warning is only compiled in under CONFIG_SCHED_DEBUG.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200723201042.18861-1-chris@chris-wilson.co.uk
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bd8e521..637365e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4686,6 +4686,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);

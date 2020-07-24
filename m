Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F0EC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909422074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/LQKHVS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KcT4s2eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGXMoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:44:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:44:13 -0400
Date:   Fri, 24 Jul 2020 12:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595594650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8tcvUPdzu/dpvnVRJ/BNJQURDdRaa7DX0HCJ1EuwlQ=;
        b=O/LQKHVSil0JMFhrSDpMbv/bl0effPMah2m0N5nZJagkn9lCwFzSVGi/0s9JAv6POdci3V
        t2GWTlkqWzd0NIEu9V7BsGImGSzlh8e5Q84R38cuz/PbEVJw0PfQsP6j7ANlYY33nCmSq+
        3DM3sW3vvQ/4t+m92mBV44MUNtcqqpt4zipOZamEwbwwhl9qMJnF5br56an1HuEi5/60zV
        uwU8PGks4YES1AJSEf5uytRCwQU0Bk5wKFidAjfWVbKYmcy9q0VnqncG+aha/GyHItHQXE
        hjDT6sQ5j6JcHxtYCQT/G5LVhC76Mg9sk0me9XgNu7K+0f0cMZ8K1bgGUO8Zkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595594650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8tcvUPdzu/dpvnVRJ/BNJQURDdRaa7DX0HCJ1EuwlQ=;
        b=KcT4s2eZBJpEi4d8u1Iv1f76sGNsbtvEgQaD02sItjwOb6GwT19MihOA9u+Ao+y80/wDAu
        TFhXKybAKHCNrUCQ==
From:   "tip-bot2 for Chris Wilson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Warn if garbage is passed to
 default_wake_function()
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723201042.18861-1-chris@chris-wilson.co.uk>
References: <20200723201042.18861-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Message-ID: <159559464976.4006.16898442338271144341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     062d3f95b630113e1156a31f376ad36e25da29a7
Gitweb:        https://git.kernel.org/tip/062d3f95b630113e1156a31f376ad36e25da29a7
Author:        Chris Wilson <chris@chris-wilson.co.uk>
AuthorDate:    Thu, 23 Jul 2020 21:10:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 24 Jul 2020 14:40:25 +02:00

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
index 5dece9b..2142c67 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4485,6 +4485,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);

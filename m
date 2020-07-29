Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD24EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9022173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbW0rebB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i2lq0PT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgG2MCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:02:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgG2MCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:02:38 -0400
Date:   Wed, 29 Jul 2020 12:02:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596024155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik9bIktF+3Y0ssyu47gm4zZ2Pa9UrhXrt/mdMdRFu/c=;
        b=jbW0rebBFADqGGrALzofCiIhpkY37RMGcLlmahiKr/BJjeR51iTWO0VV7EYA6y7tQ8oo7Y
        JfpQsb6zhO+fqFVsfPoconNozbW/wpuwCBAbyc9nxbLxH0mc92UWmKPwDcicOTCLBOgd+7
        JpYTPJh0hFPz/UYfMTn0plDax6iG4JgYgegpcVLp/SzoFF5Sb1qnYgXpaOY8iQADbAwN1L
        XtDHJY+ApL1eMF9sIbGq0xjvTV6Pt8KusDfrrwcdeBOK9taNcajp2wXiuazPakFz0rne4v
        tELE+Q8fsbQZefzSP90P/cnooFvR5za1CEgOb7qnfISJVhzusB5GLjDqTaxQfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596024155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik9bIktF+3Y0ssyu47gm4zZ2Pa9UrhXrt/mdMdRFu/c=;
        b=i2lq0PT5bm7ZdCHC7pdAWEmqO8gM4BaaFNPUyjAnPFIcKcEeADi9LzAqtpuRDzlSdq/Fhz
        X570J5QlBRLVgaBw==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix a deadlock when enabling uclamp
 static key
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716110347.19553-4-qais.yousef@arm.com>
References: <20200716110347.19553-4-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <159602415518.4006.7694548797042272636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e65855a52b479f98674998cb23b21ef5a8144b04
Gitweb:        https://git.kernel.org/tip/e65855a52b479f98674998cb23b21ef5a8144b04
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 16 Jul 2020 12:03:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 13:51:47 +02:00

sched/uclamp: Fix a deadlock when enabling uclamp static key

The following splat was caught when setting uclamp value of a task:

  BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49

   cpus_read_lock+0x68/0x130
   static_key_enable+0x1c/0x38
   __sched_setscheduler+0x900/0xad8

Fix by ensuring we enable the key outside of the critical section in
__sched_setscheduler()

Fixes: 46609ce22703 ("sched/uclamp: Protect uclamp fast path code with static key")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200716110347.19553-4-qais.yousef@arm.com
---
 kernel/sched/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6782534..e44d83f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1346,6 +1346,15 @@ static int uclamp_validate(struct task_struct *p,
 	if (upper_bound > SCHED_CAPACITY_SCALE)
 		return -EINVAL;
 
+	/*
+	 * We have valid uclamp attributes; make sure uclamp is enabled.
+	 *
+	 * We need to do that here, because enabling static branches is a
+	 * blocking operation which obviously cannot be done while holding
+	 * scheduler locks.
+	 */
+	static_branch_enable(&sched_uclamp_used);
+
 	return 0;
 }
 
@@ -1376,8 +1385,6 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
-	static_branch_enable(&sched_uclamp_used);
-
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);

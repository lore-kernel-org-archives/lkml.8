Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B96E20672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eqP4+yzR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7sPI7QK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgGIIqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:46:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGIIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:46:00 -0400
Date:   Thu, 09 Jul 2020 08:45:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594284357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oGITxDZU1icICDwaIAhgjgS+19Q/8pLZUwDvXlc2wg=;
        b=eqP4+yzRJqzz+IMFdBNnKAS2HvACCA8H1bZC42cvbh7iqFivw6OWdYefEKj67WtV8cJSGI
        L8IfbBSz2VJwzxAxTMQnPhQXjS7+eImB6m2+6dqQE0aG4Y+UIH9A+Bo7uF4EgRNlwjRAPj
        aeoOkJRRVb6S+41f9Fxpep7XOONrDSw2APePtoquA6xuFsHncB1wBiG3oqBZRDVhpGUoDt
        GTWl1kLboIZLa/g3pW7X9Jy9xEP6/ewPUHZNLjJd8cLV2adfyS2+hD0Ugm2lYkgZ0SIVV6
        JNmYxxUmoWcgLn8Cd3bd+pqQw8dIYO09UNX0oQeeUR0RGVudB2VQwGxuR/Zt7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594284357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oGITxDZU1icICDwaIAhgjgS+19Q/8pLZUwDvXlc2wg=;
        b=7sPI7QK62UmyjWtetzGEwBMAwhKbgwIJ8F6CRgGlHbQm7MY4uqg8Fj06nK4IsqhxTlTchM
        70Q+JGpEXulhdJDQ==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix initialization of struct uclamp_rq
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200630112123.12076-2-qais.yousef@arm.com>
References: <20200630112123.12076-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <159428435710.4006.10577558696191415776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d81ae8aac85ca2e307d273f6dc7863a721bf054e
Gitweb:        https://git.kernel.org/tip/d81ae8aac85ca2e307d273f6dc7863a721bf054e
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Tue, 30 Jun 2020 12:21:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:39:01 +02:00

sched/uclamp: Fix initialization of struct uclamp_rq

struct uclamp_rq was zeroed out entirely in assumption that in the first
call to uclamp_rq_inc() they'd be initialized correctly in accordance to
default settings.

But when next patch introduces a static key to skip
uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
will fail to perform any frequency changes because the
rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
means all rqs are capped to 0 by default.

Fix it by making sure we do proper initialization at init without
relying on uclamp_rq_inc() doing it later.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20200630112123.12076-2-qais.yousef@arm.com
---
 kernel/sched/core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15c980a..9605db7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1239,6 +1239,20 @@ static void uclamp_fork(struct task_struct *p)
 	}
 }
 
+static void __init init_uclamp_rq(struct rq *rq)
+{
+	enum uclamp_id clamp_id;
+	struct uclamp_rq *uc_rq = rq->uclamp;
+
+	for_each_clamp_id(clamp_id) {
+		uc_rq[clamp_id] = (struct uclamp_rq) {
+			.value = uclamp_none(clamp_id)
+		};
+	}
+
+	rq->uclamp_flags = 0;
+}
+
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
@@ -1247,11 +1261,8 @@ static void __init init_uclamp(void)
 
 	mutex_init(&uclamp_mutex);
 
-	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0,
-				sizeof(struct uclamp_rq)*UCLAMP_CNT);
-		cpu_rq(cpu)->uclamp_flags = 0;
-	}
+	for_each_possible_cpu(cpu)
+		init_uclamp_rq(cpu_rq(cpu));
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],

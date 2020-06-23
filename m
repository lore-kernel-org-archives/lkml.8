Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5105E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgFWHUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgFWHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:19:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DAAC061795;
        Tue, 23 Jun 2020 00:19:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jndDb-0003C4-QC; Tue, 23 Jun 2020 09:19:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A4BD1C0244;
        Tue, 23 Jun 2020 09:19:43 +0200 (CEST)
Date:   Tue, 23 Jun 2020 07:19:43 -0000
From:   "tip-bot2 for Scott Wood" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: __set_cpus_allowed_ptr(): Check cpus_mask,
 not cpus_ptr
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617121742.cpxppyi7twxmpin7@linutronix.de>
References: <20200617121742.cpxppyi7twxmpin7@linutronix.de>
MIME-Version: 1.0
Message-ID: <159289678305.16989.13003272986115201591.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a51dde512a93959d1df3a915fa3e3df68b1fc94d
Gitweb:        https://git.kernel.org/tip/a51dde512a93959d1df3a915fa3e3df68b1fc94d
Author:        Scott Wood <swood@redhat.com>
AuthorDate:    Wed, 17 Jun 2020 14:17:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Jun 2020 20:51:05 +02:00

sched: __set_cpus_allowed_ptr(): Check cpus_mask, not cpus_ptr

This function is concerned with the long-term cpu mask, not the
transitory mask the task might have while migrate disabled.  Before
this patch, if a task was migrate disabled at the time
__set_cpus_allowed_ptr() was called, and the new mask happened to be
equal to the cpu that the task was running on, then the mask update
would be lost.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200617121742.cpxppyi7twxmpin7@linutronix.de
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8298b2c..9f8aa34 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1637,7 +1637,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	/*

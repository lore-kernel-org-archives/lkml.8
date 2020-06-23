Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02B720724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgFWIst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731909AbgFWIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:48:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8FC061573;
        Tue, 23 Jun 2020 01:48:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jnebS-0005Ry-3J; Tue, 23 Jun 2020 10:48:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0DD91C0470;
        Tue, 23 Jun 2020 10:48:25 +0200 (CEST)
Date:   Tue, 23 Jun 2020 08:48:25 -0000
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Initialize ->dl_boosted
Cc:     syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Wagner <dwagner@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617072919.818409-1-juri.lelli@redhat.com>
References: <20200617072919.818409-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <159290210552.16989.700196687000578235.tip-bot2@tip-bot2>
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

Commit-ID:     1863cc11225e3ea2cd005473f9addc52513ab1bc
Gitweb:        https://git.kernel.org/tip/1863cc11225e3ea2cd005473f9addc52513ab1bc
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Wed, 17 Jun 2020 09:29:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Jun 2020 10:42:39 +02:00

sched/deadline: Initialize ->dl_boosted

syzbot reported the following warning triggered via SYSC_sched_setattr():

  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 setup_new_dl_entity /kernel/sched/deadline.c:594 [inline]
  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 enqueue_dl_entity /kernel/sched/deadline.c:1370 [inline]
  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 enqueue_task_dl+0x1c17/0x2ba0 /kernel/sched/deadline.c:1441

This happens because the ->dl_boosted flag is currently not initialized by
__dl_clear_params() (unlike the other flags) and setup_new_dl_entity()
rightfully complains about it.

Initialize dl_boosted to 0.

Fixes: 2d3d891d3344 ("sched/deadline: Add SCHED_DEADLINE inheritance logic")
Reported-by: syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Daniel Wagner <dwagner@suse.de>
Link: https://lkml.kernel.org/r/20200617072919.818409-1-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f5..f63f337 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2692,6 +2692,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->dl_boosted		= 0;
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;

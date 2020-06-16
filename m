Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0EFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF72820FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgFPMWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgFPMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7610CC08C5C2;
        Tue, 16 Jun 2020 05:21:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbC-0004eT-8x; Tue, 16 Jun 2020 14:21:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 206F51C0095;
        Tue, 16 Jun 2020 14:21:51 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:50 -0000
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix a typo in a comment
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200602195002.677448-1-christophe.jaillet@wanadoo.fr>
References: <20200602195002.677448-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Message-ID: <159231011092.16989.8945571092570940296.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c49694173da004b1b16082f82f28bd625415fbb2
Gitweb:        https://git.kernel.org/tip/c49694173da004b1b16082f82f28bd625415fbb2
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Tue, 02 Jun 2020 21:50:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:06 +02:00

sched/deadline: Fix a typo in a comment

s/deadine/deadline/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200602195002.677448-1-christophe.jaillet@wanadoo.fr
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 84e84ba..d4708e2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1137,7 +1137,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
  * cannot use the runtime, and so it replenishes the task. This rule
  * works fine for implicit deadline tasks (deadline == period), and the
  * CBS was designed for implicit deadline tasks. However, a task with
- * constrained deadline (deadine < period) might be awakened after the
+ * constrained deadline (deadline < period) might be awakened after the
  * deadline, but before the next period. In this case, replenishing the
  * task would allow it to run for runtime / deadline. As in this case
  * deadline < period, CBS enables a task to run for more than the

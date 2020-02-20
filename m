Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEDEC11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB0020722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgBTUJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:09:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgBTUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:09:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4s8I-0006hX-G3; Thu, 20 Feb 2020 21:09:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 17C381C20D8;
        Thu, 20 Feb 2020 21:09:14 +0100 (CET)
Date:   Thu, 20 Feb 2020 20:09:13 -0000
From:   "tip-bot2 for Scott Wood" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove duplicate assignment in
 sched_tick_remote()
Cc:     Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1580776558-12882-1-git-send-email-swood@redhat.com>
References: <1580776558-12882-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Message-ID: <158222935381.13786.9032916402923624715.tip-bot2@tip-bot2>
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

Commit-ID:     82e0516ce3a147365a5dd2a9bedd5ba43a18663d
Gitweb:        https://git.kernel.org/tip/82e0516ce3a147365a5dd2a9bedd5ba43a18663d
Author:        Scott Wood <swood@redhat.com>
AuthorDate:    Mon, 03 Feb 2020 19:35:58 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2020 21:03:13 +01:00

sched/core: Remove duplicate assignment in sched_tick_remote()

A redundant "curr = rq->curr" was added; remove it.

Fixes: ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1580776558-12882-1-git-send-email-swood@redhat.com

---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45f79bc..377ec26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3683,7 +3683,6 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
-	curr = rq->curr;
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {

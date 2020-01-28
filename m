Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B29C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE26924683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgA1Oqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:46:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgA1Oql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:46:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwS8U-0000J1-MK; Tue, 28 Jan 2020 15:46:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 433D91C1B3D;
        Tue, 28 Jan 2020 15:46:38 +0100 (CET)
Date:   Tue, 28 Jan 2020 14:46:38 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] smp: Remove superfluous cond_func check in
 smp_call_function_many_cond()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200127083915.434tdkztorkklpdu@linutronix.de>
References: <20200127083915.434tdkztorkklpdu@linutronix.de>
MIME-Version: 1.0
Message-ID: <158022279803.396.3667557782682322607.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     25a3a15417cf4311f812f5a2b18c5fc2809f66d7
Gitweb:        https://git.kernel.org/tip/25a3a15417cf4311f812f5a2b18c5fc2809f66d7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 27 Jan 2020 09:39:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 28 Jan 2020 15:43:00 +01:00

smp: Remove superfluous cond_func check in smp_call_function_many_cond()

It was requested to remove the cond_func check but the follow up patch was
overlooked. Remove it now.

Fixes: 67719ef25eeb ("smp: Add a smp_cond_func_t argument to smp_call_function_many()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200127083915.434tdkztorkklpdu@linutronix.de

---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 3b7bedc..d0ada39 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -435,7 +435,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >= nr_cpu_ids) {
-		if (!cond_func || (cond_func && cond_func(cpu, info)))
+		if (!cond_func || cond_func(cpu, info))
 			smp_call_function_single(cpu, func, info, wait);
 		return;
 	}

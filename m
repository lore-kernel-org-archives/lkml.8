Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C7C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF1120722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgBTUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:09:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgBTUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:09:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4s8G-0006gj-QQ; Thu, 20 Feb 2020 21:09:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B42D1C20C5;
        Thu, 20 Feb 2020 21:09:12 +0100 (CET)
Date:   Thu, 20 Feb 2020 20:09:12 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove for_each_lower_domain()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Quentin Perret <qperret@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206191957.12325-4-valentin.schneider@arm.com>
References: <20200206191957.12325-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158222935225.13786.10202701060677805234.tip-bot2@tip-bot2>
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

Commit-ID:     f8459197e75b045d8d1d87b9856486b39e375721
Gitweb:        https://git.kernel.org/tip/f8459197e75b045d8d1d87b9856486b39e375721
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 06 Feb 2020 19:19:56 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2020 21:03:15 +01:00

sched/core: Remove for_each_lower_domain()

The last remaining user of this macro has just been removed, get rid of it.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lkml.kernel.org/r/20200206191957.12325-4-valentin.schneider@arm.com

---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0844e81..878910e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1337,8 +1337,6 @@ extern void sched_ttwu_pending(void);
 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
 			__sd; __sd = __sd->parent)
 
-#define for_each_lower_domain(sd) for (; sd; sd = sd->child)
-
 /**
  * highest_flag_domain - Return highest sched_domain containing flag.
  * @cpu:	The CPU whose highest level of sched domain is to

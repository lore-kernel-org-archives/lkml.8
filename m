Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D4C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255524653
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAQKJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgAQKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:09:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYX-0005Qm-Ur; Fri, 17 Jan 2020 11:08:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AEFDD1C19CD;
        Fri, 17 Jan 2020 11:08:40 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:40 -0000
From:   "tip-bot2 for Hewenliang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] idle: fix spelling mistake "iterrupts" -> "interrupts"
Cc:     Hewenliang <hewenliang4@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110025604.34373-1-hewenliang4@huawei.com>
References: <20200110025604.34373-1-hewenliang4@huawei.com>
MIME-Version: 1.0
Message-ID: <157925572055.396.10697981012861050378.tip-bot2@tip-bot2>
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

Commit-ID:     3e0de271fff77abb933f1b69c213854c3eda9125
Gitweb:        https://git.kernel.org/tip/3e0de271fff77abb933f1b69c213854c3eda9125
Author:        Hewenliang <hewenliang4@huawei.com>
AuthorDate:    Thu, 09 Jan 2020 21:56:04 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:22 +01:00

idle: fix spelling mistake "iterrupts" -> "interrupts"

There is a spelling misake in comments of cpuidle_idle_call. Fix it.

Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20200110025604.34373-1-hewenliang4@huawei.com
---
 kernel/sched/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ffa959e..b743bf3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -158,7 +158,7 @@ static void cpuidle_idle_call(void)
 	/*
 	 * Suspend-to-idle ("s2idle") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
-	 * activity happens here and in iterrupts (if any).  In that case bypass
+	 * activity happens here and in interrupts (if any). In that case bypass
 	 * the cpuidle governor and go stratight for the deepest idle state
 	 * available.  Possibly also suspend the local tick and the entire
 	 * timekeeping to prevent timer interrupts from kicking us out of idle

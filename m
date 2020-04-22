Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB12C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2204220787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDVVVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDVVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:20:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA4C03C1AA;
        Wed, 22 Apr 2020 14:20:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRMnZ-0000Oh-DF; Wed, 22 Apr 2020 23:20:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 088811C02FC;
        Wed, 22 Apr 2020 23:20:49 +0200 (CEST)
Date:   Wed, 22 Apr 2020 21:20:48 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86, sched: Account for CPUs with less than 4
 cores in freq. invariance
Cc:     Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416054745.740-3-ggherdovich@suse.cz>
References: <20200416054745.740-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158759044865.28353.8160614260085686915.tip-bot2@tip-bot2>
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

Commit-ID:     23ccee22e834eca236b9a20989caf6905bd6954a
Gitweb:        https://git.kernel.org/tip/23ccee22e834eca236b9a20989caf6905bd6954a
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Thu, 16 Apr 2020 07:47:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:13 +02:00

x86, sched: Account for CPUs with less than 4 cores in freq. invariance

If a CPU has less than 4 physical cores, MSR_TURBO_RATIO_LIMIT will
rightfully report that the 4C turbo ratio is zero. In such cases, use the
1C turbo ratio instead for frequency invariance calculations.

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Reported-by: Like Xu <like.xu@linux.intel.com>
Reported-by: Neil Rickert <nwr10cst-oslnx@yahoo.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Link: https://lkml.kernel.org/r/20200416054745.740-3-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3a318ec..5d346b7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1945,18 +1945,23 @@ static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 
 static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
+	u64 msr;
 	int err;
 
 	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_freq);
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
 	if (err)
 		return false;
 
-	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
-	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
+	*base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
+	*turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
+
+	/* The CPU may have less than 4 cores */
+	if (!*turbo_freq)
+		*turbo_freq = msr & 0xFF;         /* 1C turbo    */
 
 	return true;
 }

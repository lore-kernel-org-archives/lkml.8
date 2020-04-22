Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B61C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0012420787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgDVVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDVVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:20:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A89C03C1A9;
        Wed, 22 Apr 2020 14:20:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRMnY-0000O3-DW; Wed, 22 Apr 2020 23:20:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 11BA01C02FC;
        Wed, 22 Apr 2020 23:20:48 +0200 (CEST)
Date:   Wed, 22 Apr 2020 21:20:47 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86, sched: Move check for CPU type to caller function
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416054745.740-5-ggherdovich@suse.cz>
References: <20200416054745.740-5-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158759044762.28353.12681151703116026868.tip-bot2@tip-bot2>
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

Commit-ID:     db441bd9f630329c402d5cdd319f11bfcf509fb6
Gitweb:        https://git.kernel.org/tip/db441bd9f630329c402d5cdd319f11bfcf509fb6
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Thu, 16 Apr 2020 07:47:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:13 +02:00

x86, sched: Move check for CPU type to caller function

Improve readability of the function intel_set_max_freq_ratio() by moving
the check for KNL CPUs there, together with checks for GLM and SKX.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200416054745.740-5-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index dd8e15f..8c89e4d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1877,9 +1877,6 @@ static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
 	int err, i;
 	u64 msr;
 
-	if (!x86_match_cpu(has_knl_turbo_ratio_limits))
-		return false;
-
 	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
@@ -1977,7 +1974,8 @@ static bool intel_set_max_freq_ratio(void)
 	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
-	if (knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
+	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
 	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&

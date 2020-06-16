Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FA321501
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgFPMWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgFPMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C2C08C5C3;
        Tue, 16 Jun 2020 05:22:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbL-0004kF-OK; Tue, 16 Jun 2020 14:22:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E65ED1C0095;
        Tue, 16 Jun 2020 14:21:54 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:54 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200531182453.15254-3-ggherdovich@suse.cz>
References: <20200531182453.15254-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <159231011472.16989.10542283129872543886.tip-bot2@tip-bot2>
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

Commit-ID:     51beea8862a3095559862df39554f05042e1195b
Gitweb:        https://git.kernel.org/tip/51beea8862a3095559862df39554f05042e1195b
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Sun, 31 May 2020 20:24:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:02 +02:00

x86, sched: Bail out of frequency invariance if turbo frequency is unknown

There may be CPUs that support turbo boost but don't declare any turbo
ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
scale-invariant calculations can't be performed.

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lkml.kernel.org/r/20200531182453.15254-3-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 18d292f..20e1cea 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2002,9 +2002,11 @@ out:
 	/*
 	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
 	 * but then fill all MSR's with zeroes.
+	 * Some CPUs have turbo boost but don't declare any turbo ratio
+	 * in MSR_TURBO_RATIO_LIMIT.
 	 */
-	if (!base_freq) {
-		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
+	if (!base_freq || !turbo_freq) {
+		pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
 		return false;
 	}
 

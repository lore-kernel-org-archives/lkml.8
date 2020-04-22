Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9346BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0A421582
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgDVVU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDVVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:20:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128DC03C1A9;
        Wed, 22 Apr 2020 14:20:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRMnZ-0000Ol-VY; Wed, 22 Apr 2020 23:20:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A1641C0450;
        Wed, 22 Apr 2020 23:20:49 +0200 (CEST)
Date:   Wed, 22 Apr 2020 21:20:49 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86, sched: Bail out of frequency invariance if
 base frequency is unknown
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416054745.740-2-ggherdovich@suse.cz>
References: <20200416054745.740-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <158759044911.28353.2414263048020355766.tip-bot2@tip-bot2>
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

Commit-ID:     9a6c2c3c7a73ce315c57c1b002caad6fcc858d0f
Gitweb:        https://git.kernel.org/tip/9a6c2c3c7a73ce315c57c1b002caad6fcc858d0f
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Thu, 16 Apr 2020 07:47:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:13 +02:00

x86, sched: Bail out of frequency invariance if base frequency is unknown

Some hypervisors such as VMWare ESXi 5.5 advertise support for
X86_FEATURE_APERFMPERF but then fill all MSR's with zeroes. In particular,
MSR_PLATFORM_INFO set to zero tricks the code that wants to know the base
clock frequency of the CPU (highest non-turbo frequency), producing a
division by zero when computing the ratio turbo_freq/base_freq necessary
for frequency invariant accounting.

It is to be noted that even if MSR_PLATFORM_INFO contained the appropriate
data, APERF and MPERF are constantly zero on ESXi 5.5, thus freq-invariance
couldn't be done in principle (not that it would make a lot of sense in a
VM anyway). The real problem is advertising X86_FEATURE_APERFMPERF. This
appears to be fixed in more recent versions: ESXi 6.7 doesn't advertise
that feature.

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200416054745.740-2-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab96..3a318ec 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1985,6 +1985,15 @@ static bool intel_set_max_freq_ratio(void)
 	return false;
 
 out:
+	/*
+	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
+	 * but then fill all MSR's with zeroes.
+	 */
+	if (!base_freq) {
+		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
+		return false;
+	}
+
 	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
 	arch_set_max_freq_ratio(turbo_disabled());

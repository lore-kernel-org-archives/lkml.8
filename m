Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A93D214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgFPMWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgFPMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D5C08C5C3;
        Tue, 16 Jun 2020 05:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbO-0004jC-UJ; Tue, 16 Jun 2020 14:22:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9DDA91C0475;
        Tue, 16 Jun 2020 14:21:54 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:54 -0000
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: Bail out of frequency invariance if
 turbo_freq/base_freq gives 0
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200531182453.15254-4-ggherdovich@suse.cz>
References: <20200531182453.15254-4-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <159231011443.16989.10180990349083727311.tip-bot2@tip-bot2>
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

Commit-ID:     f4291df103315a696f0b8c4f45ca8ae773c17441
Gitweb:        https://git.kernel.org/tip/f4291df103315a696f0b8c4f45ca8ae773c17441
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Sun, 31 May 2020 20:24:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:02 +02:00

x86, sched: Bail out of frequency invariance if turbo_freq/base_freq gives 0

Be defensive against the case where the processor reports a base_freq
larger than turbo_freq (the ratio would be zero).

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200531182453.15254-4-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 20e1cea..518ac6b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1977,6 +1977,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 static bool intel_set_max_freq_ratio(void)
 {
 	u64 base_freq, turbo_freq;
+	u64 turbo_ratio;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
@@ -2010,9 +2011,15 @@ out:
 		return false;
 	}
 
-	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
-					base_freq);
+	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
+	if (!turbo_ratio) {
+		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = turbo_ratio;
 	arch_set_max_freq_ratio(turbo_disabled());
+
 	return true;
 }
 

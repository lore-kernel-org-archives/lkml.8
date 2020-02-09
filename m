Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B0C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95AC20820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBIOG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 09:06:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42464 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgBIOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 09:06:58 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j0nEa-0004VJ-5k; Sun, 09 Feb 2020 15:06:52 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8FACE1017FA;
        Sun,  9 Feb 2020 15:06:51 +0100 (CET)
Date:   Sun, 09 Feb 2020 14:02:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] SMP fixes for 5.6-rc1
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
Message-ID: <158125695732.26104.1145889078762434274.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2020-02-09

up to:  1e474b28e788: smp/up: Make smp_call_function_single() match SMP semantics


Two fixes for the SMP related functionality:

 - Make the UP version of smp_call_function_single() match SMP semantics
   when called for a not available CPU.  Instead of emitting a warning and
   assuming that the function call target is CPU0, return a proper error
   code like the SMP version does.

 - Remove a superfluous check in smp_call_function_many_cond()

Thanks,

	tglx

------------------>
Paul E. McKenney (1):
      smp/up: Make smp_call_function_single() match SMP semantics

Sebastian Andrzej Siewior (1):
      smp: Remove superfluous cond_func check in smp_call_function_many_cond()


 kernel/smp.c | 2 +-
 kernel/up.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 3b7bedc97af3..d0ada39eb4d4 100644
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
diff --git a/kernel/up.c b/kernel/up.c
index 53144d056252..c6f323dcd45b 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -14,7 +14,8 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 {
 	unsigned long flags;
 
-	WARN_ON(cpu != 0);
+	if (cpu != 0)
+		return -ENXIO;
 
 	local_irq_save(flags);
 	func(info);


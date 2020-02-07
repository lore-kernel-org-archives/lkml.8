Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB7BC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E73321741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGOhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:37:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:37:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j04kw-0005HH-Sc; Fri, 07 Feb 2020 15:37:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D4CC1C1A0E;
        Fri,  7 Feb 2020 15:37:18 +0100 (CET)
Date:   Fri, 07 Feb 2020 14:37:17 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] smp/up: Make smp_call_function_single() match SMP semantics
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200205143409.GA7021@paulmck-ThinkPad-P72>
References: <20200205143409.GA7021@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Message-ID: <158108623779.411.17538736321432389803.tip-bot2@tip-bot2>
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

Commit-ID:     1e474b28e78897d0d170fab3b28ba683149cb9ea
Gitweb:        https://git.kernel.org/tip/1e474b28e78897d0d170fab3b28ba683149cb9ea
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 05 Feb 2020 06:34:09 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Feb 2020 15:34:12 +01:00

smp/up: Make smp_call_function_single() match SMP semantics

In CONFIG_SMP=y kernels, smp_call_function_single() returns -ENXIO when
invoked for a non-existent CPU.  In contrast, in CONFIG_SMP=n kernels,
a splat is emitted and smp_call_function_single() otherwise silently
ignores its "cpu" argument, instead pretending that the caller intended
to have something happen on CPU 0.  Given that there is now code that
expects smp_call_function_single() to return an error if a bad CPU was
specified, this difference in semantics needs to be addressed.

Bring the semantics of the CONFIG_SMP=n version of
smp_call_function_single() into alignment with its CONFIG_SMP=y
counterpart.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200205143409.GA7021@paulmck-ThinkPad-P72

---
 kernel/up.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/up.c b/kernel/up.c
index 53144d0..c6f323d 100644
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

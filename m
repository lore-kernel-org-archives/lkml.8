Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63753C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0562076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDVSEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgDVSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:04:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12814C03C1A9;
        Wed, 22 Apr 2020 11:04:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRJjA-0006Gx-Hv; Wed, 22 Apr 2020 20:04:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 004C91C02FC;
        Wed, 22 Apr 2020 20:04:03 +0200 (CEST)
Date:   Wed, 22 Apr 2020 18:04:03 -0000
From:   "tip-bot2 for Mihai Carabas" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Fix return value for microcode
 late loading
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587497318-4438-1-git-send-email-mihai.carabas@oracle.com>
References: <1587497318-4438-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Message-ID: <158757864352.28353.206205836206503586.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9adbf3c609af92a57a73000a3cb8f4c2d307dfa3
Gitweb:        https://git.kernel.org/tip/9adbf3c609af92a57a73000a3cb8f4c2d307dfa3
Author:        Mihai Carabas <mihai.carabas@oracle.com>
AuthorDate:    Tue, 21 Apr 2020 22:28:38 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Apr 2020 19:55:50 +02:00

x86/microcode: Fix return value for microcode late loading

The return value from stop_machine() might not be consistent.

stop_machine_cpuslocked() returns:
- zero if all functions have returned 0.
- a non-zero value if at least one of the functions returned
a non-zero value.

There is no way to know if it is negative or positive. So make
__reload_late() return 0 on success or negative otherwise.

 [ bp: Unify ret val check and touch up. ]

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1587497318-4438-1-git-send-email-mihai.carabas@oracle.com
---
 arch/x86/kernel/cpu/microcode/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b..baec68b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -545,8 +545,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 /*
  * Returns:
  * < 0 - on error
- *   0 - no update done
- *   1 - microcode was updated
+ *   0 - success (no update done or microcode was updated)
  */
 static int __reload_late(void *info)
 {
@@ -573,11 +572,11 @@ static int __reload_late(void *info)
 	else
 		goto wait_for_siblings;
 
-	if (err > UCODE_NFOUND) {
-		pr_warn("Error reloading microcode on CPU %d\n", cpu);
+	if (err >= UCODE_NFOUND) {
+		if (err == UCODE_ERROR)
+			pr_warn("Error reloading microcode on CPU %d\n", cpu);
+
 		ret = -1;
-	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
-		ret = 1;
 	}
 
 wait_for_siblings:
@@ -608,7 +607,7 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret > 0)
+	if (ret == 0)
 		microcode_check();
 
 	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
@@ -649,7 +648,7 @@ static ssize_t reload_store(struct device *dev,
 put:
 	put_online_cpus();
 
-	if (ret >= 0)
+	if (ret == 0)
 		ret = size;
 
 	return ret;

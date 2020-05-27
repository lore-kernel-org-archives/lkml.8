Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3895C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C894E206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbgE0LZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgE0LZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:25:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BFCC03E979;
        Wed, 27 May 2020 04:25:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jduBd-000869-4n; Wed, 27 May 2020 13:25:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B6FAD1C03A9;
        Wed, 27 May 2020 13:25:28 +0200 (CEST)
Date:   Wed, 27 May 2020 11:25:28 -0000
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apb_timer: Drop unused TSC calibration
Cc:     Johan Hovold <johan@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200513100944.9171-1-johan@kernel.org>
References: <20200513100944.9171-1-johan@kernel.org>
MIME-Version: 1.0
Message-ID: <159057872863.17951.8342592736776396338.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     003d80535180f74f262c40462b9fccd7f004901a
Gitweb:        https://git.kernel.org/tip/003d80535180f74f262c40462b9fccd7f004901a
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Wed, 13 May 2020 12:09:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 May 2020 13:05:59 +02:00

x86/apb_timer: Drop unused TSC calibration

Drop the APB-timer TSC calibration, which hasn't been used since the
removal of Moorestown support by commit

  1a8359e411eb ("x86/mid: Remove Intel Moorestown").

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200513100944.9171-1-johan@kernel.org
---
 arch/x86/include/asm/apb_timer.h |  2 +-
 arch/x86/kernel/apb_timer.c      | 53 +-------------------------------
 2 files changed, 55 deletions(-)

diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
index 99bb207..0a9bf8b 100644
--- a/arch/x86/include/asm/apb_timer.h
+++ b/arch/x86/include/asm/apb_timer.h
@@ -28,7 +28,6 @@
 #define APBT_DEV_USED  1
 
 extern void apbt_time_init(void);
-extern unsigned long apbt_quick_calibrate(void);
 extern int arch_setup_apbt_irqs(int irq, int trigger, int mask, int cpu);
 extern void apbt_setup_secondary_clock(void);
 
@@ -38,7 +37,6 @@ extern int sfi_mtimer_num;
 
 #else /* CONFIG_APB_TIMER */
 
-static inline unsigned long apbt_quick_calibrate(void) {return 0; }
 static inline void apbt_time_init(void) { }
 
 #endif
diff --git a/arch/x86/kernel/apb_timer.c b/arch/x86/kernel/apb_timer.c
index fe698f9..263eead 100644
--- a/arch/x86/kernel/apb_timer.c
+++ b/arch/x86/kernel/apb_timer.c
@@ -345,56 +345,3 @@ out_noapbt:
 	apb_timer_block_enabled = 0;
 	panic("failed to enable APB timer\n");
 }
-
-/* called before apb_timer_enable, use early map */
-unsigned long apbt_quick_calibrate(void)
-{
-	int i, scale;
-	u64 old, new;
-	u64 t1, t2;
-	unsigned long khz = 0;
-	u32 loop, shift;
-
-	apbt_set_mapping();
-	dw_apb_clocksource_start(clocksource_apbt);
-
-	/* check if the timer can count down, otherwise return */
-	old = dw_apb_clocksource_read(clocksource_apbt);
-	i = 10000;
-	while (--i) {
-		if (old != dw_apb_clocksource_read(clocksource_apbt))
-			break;
-	}
-	if (!i)
-		goto failed;
-
-	/* count 16 ms */
-	loop = (apbt_freq / 1000) << 4;
-
-	/* restart the timer to ensure it won't get to 0 in the calibration */
-	dw_apb_clocksource_start(clocksource_apbt);
-
-	old = dw_apb_clocksource_read(clocksource_apbt);
-	old += loop;
-
-	t1 = rdtsc();
-
-	do {
-		new = dw_apb_clocksource_read(clocksource_apbt);
-	} while (new < old);
-
-	t2 = rdtsc();
-
-	shift = 5;
-	if (unlikely(loop >> shift == 0)) {
-		printk(KERN_INFO
-		       "APBT TSC calibration failed, not enough resolution\n");
-		return 0;
-	}
-	scale = (int)div_u64((t2 - t1), loop >> shift);
-	khz = (scale * (apbt_freq / 1000)) >> shift;
-	printk(KERN_INFO "TSC freq calculated by APB timer is %lu khz\n", khz);
-	return khz;
-failed:
-	return 0;
-}

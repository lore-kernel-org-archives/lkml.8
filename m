Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D786FC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98EF20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364610;
	bh=KJQHKv3tSWL2Lnc5M6wtATZcfmGm2ng87DC37g5e8BM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gMSvYr7w+vyfnMjWPCF11Qbrzmw2yHku3cHAyP0bPYW9YXXd3RX8Krt0IixF72TZy
	 q3lLg4ycZJy3iGs61kDr/Ho+27hHIMoGz8ILfmWQVyXq6vliohw8GoXurWmyohbmuf
	 aAg6hPvdbDh1SwkKz+nedwDHexBNSvY44yfyxwew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgEMKKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:10:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37496 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbgEMKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:10:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14so16049077ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzp5IbtrCAzdt0LwNub+xTQ1hMXNaNa6YNYdbqve/7U=;
        b=QGuX8IHzVD4xRszgnj8719F2+WcDlbnKIR8FPqvk5B4DvZtRgIw7jwml5vD8RkCP+l
         bJcotDmBsr3i1XcG29UFroLG2hO/IoglOYxTIxol/2RN2cXMjKt/vHgLq5WCBTF4xWrR
         +1c+Qsb5c+EsSffwp82LliU+wFCjRldlFxStHa4xl19Ovy4qNOYFc+Dc8GRDwVRCUACo
         2QFhHamC5rbP1T6Gesyy9MTCmcNc4xN+1LLu7uA9+IIS8HWlLEcL4kacUeS1laJe7b0i
         MflKGldqs3QCCQJ6SLifbLFyIs8m73Y44cfUMQxyCpT1Nd0r6P1YMOOAgj4j5P9344N0
         zcOQ==
X-Gm-Message-State: AOAM5303ik81LA0e1Gq3IqH6OwIl+/7Ygv/Hf7junBTaxsy/ht6q8m2V
        jBguDyrUnA8lfE/w1ZmipLQ=
X-Google-Smtp-Source: ABdhPJymX/6ACRQ5yIcHC/1C3efLayDofSWBKmEnLkMPOMib6CXAiG940OXwqxQdyIXp9jx8C7LAGA==
X-Received: by 2002:a2e:3508:: with SMTP id z8mr15107298ljz.32.1589364605923;
        Wed, 13 May 2020 03:10:05 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i124sm13922764lji.95.2020.05.13.03.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:10:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jYoL0-0002Or-HY; Wed, 13 May 2020 12:10:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] x86/apb_timer: drop unused TSC calibration
Date:   Wed, 13 May 2020 12:09:43 +0200
Message-Id: <20200513100944.9171-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the APB-timer TSC calibration, which hasn't been used since the
removal of Moorestown support by commit 1a8359e411eb ("x86/mid: Remove
Intel Moorestown").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/x86/include/asm/apb_timer.h |  2 --
 arch/x86/kernel/apb_timer.c      | 53 --------------------------------
 2 files changed, 55 deletions(-)

diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
index 99bb207fc04c..0a9bf8b77a28 100644
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
index fe698f96617c..263eeaddb0aa 100644
--- a/arch/x86/kernel/apb_timer.c
+++ b/arch/x86/kernel/apb_timer.c
@@ -345,56 +345,3 @@ void __init apbt_time_init(void)
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
-- 
2.26.2


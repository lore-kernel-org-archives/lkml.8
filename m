Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3960DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82159221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739339;
	bh=apFcycz/O6DDKT5iJ4SnSfgBjc6oT0XDJlH7NQkB7HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=froi77rkt0vjAPwvZgnNB7pvPWtgDBBv7GP4dVZTQ66ERBy2Q9LLanxXI5T8XC6gs
	 Gm0gpf70XnLlPlDTkaMi58UKRMPoji9GtrQz2BSd+Itp498HIAQ7Z46DuhlBSGTdsM
	 WRY8fRo9hpfyiidirBjoTLo0jYUy79bq5JFRU9U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHFSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgHFSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FE022D07;
        Thu,  6 Aug 2020 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738142;
        bh=apFcycz/O6DDKT5iJ4SnSfgBjc6oT0XDJlH7NQkB7HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkd5XZmKI9D0TfLj3IIwE7AoFaSbzXVHqlCJGeuNO1nUNoY7SpZQ1eFehbh1pWTnM
         ryXCTDP13QexBPF9tKlsF4GCLvCK8Y31mKvwJJPqhjcKb5It0oGVlCEkPFcrdTL8dc
         9OE8YCKKrmpGSgj8t4hg8AskNCoVCdrq8EhG4PiI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 11/41] ARM: samsung: remove s3c_pm_debug_init()
Date:   Thu,  6 Aug 2020 20:20:28 +0200
Message-Id: <20200806182059.2431-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On s3c24xx and s3c64xx, this is just a wrapper around
s3c_pm_debug_init_uart(), but this function does not exist on s5pv210,
which always uses an empty stub as CONFIG_SAMSUNG_ATAGS is normally
not set.

In a configuration that supports both s5pv210 and s3c64xx, we would
always call the s3c64xx function, which is probably incorrect when
running on s5pv210.

Remove the function call completely on s5pv210 and skip the wrapper on
s3c as a cleanup.

As a side-effect, the s3c64xx behavior is now always the same, regardless
of whether it is a DT-only configuration or both DT and ATAGS are
supported for booting.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/include/mach/pm-core.h   |  2 ++
 arch/arm/mach-s3c64xx/include/mach/pm-core.h   |  2 ++
 arch/arm/mach-s5pv210/pm.c                     |  2 --
 arch/arm/plat-samsung/include/plat/pm-common.h | 10 ----------
 arch/arm/plat-samsung/pm-debug.c               |  7 -------
 arch/arm/plat-samsung/pm.c                     |  5 ++---
 6 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
index 5e4ce89d0158..cd6406820cb1 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
@@ -15,6 +15,7 @@
 
 static inline void s3c_pm_debug_init_uart(void)
 {
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
 	unsigned long tmp = __raw_readl(S3C2410_CLKCON);
 
 	/* re-start uart clocks */
@@ -24,6 +25,7 @@ static inline void s3c_pm_debug_init_uart(void)
 
 	__raw_writel(tmp, S3C2410_CLKCON);
 	udelay(10);
+#endif
 }
 
 static inline void s3c_pm_arch_prepare_irqs(void)
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index bbf79ed28583..1c7d179a86f3 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -20,6 +20,7 @@
 
 static inline void s3c_pm_debug_init_uart(void)
 {
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
 	u32 tmp = __raw_readl(S3C_PCLK_GATE);
 
 	/* As a note, since the S3C64XX UARTs generally have multiple
@@ -35,6 +36,7 @@ static inline void s3c_pm_debug_init_uart(void)
 
 	__raw_writel(tmp, S3C_PCLK_GATE);
 	udelay(10);
+#endif
 }
 
 static inline void s3c_pm_arch_prepare_irqs(void)
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index b336df0c57f3..725e6746f345 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -99,8 +99,6 @@ static int s5pv210_suspend_enter(suspend_state_t state)
 	u32 eint_wakeup_mask = s5pv210_read_eint_wakeup_mask();
 	int ret;
 
-	s3c_pm_debug_init();
-
 	S3C_PMDBG("%s: suspending the system...\n", __func__);
 
 	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
index 1268bae04234..467e7c867c46 100644
--- a/arch/arm/plat-samsung/include/plat/pm-common.h
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -69,22 +69,12 @@ struct pm_uart_save {
  */
 extern void s3c_pm_dbg(const char *msg, ...);
 
-/**
- * s3c_pm_debug_init() - suspend/resume low level debug initialization.
- * @base: Virtual base of UART to use for suspend/resume debugging.
- *
- * This function needs to be called before S3C_PMDBG() can be used, to set up
- * UART port base address and configuration.
- */
-extern void s3c_pm_debug_init(void);
-
 #define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
 
 extern void s3c_pm_save_uarts(void);
 extern void s3c_pm_restore_uarts(void);
 #else
 #define S3C_PMDBG(fmt...) pr_debug(fmt)
-#define s3c_pm_debug_init() do { } while (0)
 
 static inline void s3c_pm_save_uarts(void) { }
 static inline void s3c_pm_restore_uarts(void) { }
diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
index b76b1e9ba4ae..105b61f3304e 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -22,7 +22,6 @@
 #include <plat/pm.h>
 #include <mach/pm-core.h>
 #else
-static inline void s3c_pm_debug_init_uart(void) {}
 static inline void s3c_pm_arch_update_uart(void __iomem *regs,
 					   struct pm_uart_save *save) {}
 #endif
@@ -43,12 +42,6 @@ void s3c_pm_dbg(const char *fmt, ...)
 	printascii(buff);
 }
 
-void s3c_pm_debug_init(void)
-{
-	/* restart uart clocks so we can use them to output */
-	s3c_pm_debug_init_uart();
-}
-
 static inline void __iomem *s3c_pm_uart_base(void)
 {
 	unsigned long paddr;
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index d6bfd66592b0..b40ab7abe6a9 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -70,8 +70,7 @@ static int s3c_pm_enter(suspend_state_t state)
 {
 	int ret;
 	/* ensure the debug is initialised (if enabled) */
-
-	s3c_pm_debug_init();
+	s3c_pm_debug_init_uart();
 
 	S3C_PMDBG("%s(%d)\n", __func__, state);
 
@@ -144,7 +143,7 @@ static int s3c_pm_enter(suspend_state_t state)
 		s3c_pm_restored_gpios();
 	}
 
-	s3c_pm_debug_init();
+	s3c_pm_debug_init_uart();
 
 	/* check what irq (if any) restored the system */
 
-- 
2.17.1


Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84266C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6582820734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgFAHv5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:51:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F6DC061A0E;
        Mon,  1 Jun 2020 00:51:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jffEe-0001OT-UH; Mon, 01 Jun 2020 09:51:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 289D31C0244;
        Mon,  1 Jun 2020 09:51:52 +0200 (CEST)
Date:   Mon, 01 Jun 2020 07:51:51 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Fix "Loongson HyperTransport Vector support"
 driver build on all non-MIPS platforms
Cc:     Ingo Molnar <mingo@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159099791195.17951.14470094262975748595.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d77aeb5d403d379ff458e04fc07b5b86700270f2
Gitweb:        https://git.kernel.org/tip/d77aeb5d403d379ff458e04fc07b5b86700270f2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 01 Jun 2020 09:45:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Jun 2020 09:48:52 +02:00

irqchip: Fix "Loongson HyperTransport Vector support" driver build on all non-MIPS platforms

This commit:

  818e915fbac5: ("irqchip: Add Loongson HyperTransport Vector support")

Added a MIPS-only driver, but turned on compilation on all other architectures as well:

 config LOONGSON_HTVEC
        bool "Loongson3 HyperTransport Interrupt Vector Controller"
        depends on MACH_LOONGSON64 || COMPILE_TEST

But this driver was never build tested on any other architecture than MIPS:

  drivers/irqchip/irq-loongson-htvec.c: In function ‘htvec_irq_dispatch’:
  drivers/irqchip/irq-loongson-htvec.c:59:3: error: implicit declaration of function ‘spurious_interrupt’; did you mean ‘smp_reboot_interrupt’? [-Werror=implicit-function-declaration]

Because spurious_interrupt() only exists on MIPS.

So make it MIPS-only.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0b6b826..66b9a68 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -534,7 +534,7 @@ config LOONGSON_HTPIC
 
 config LOONGSON_HTVEC
 	bool "Loongson3 HyperTransport Interrupt Vector Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help

Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2612EC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0953524673
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBHO6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:58:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42053 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBHO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:58:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0RYc-0003CF-JU; Sat, 08 Feb 2020 15:58:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3A09B1C1A0D;
        Sat,  8 Feb 2020 15:58:06 +0100 (CET)
Date:   Sat, 08 Feb 2020 14:58:06 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Some Kconfig cleanup for C-SKY
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d44baeee-cceb-7c02-7249-e6b4817f0847@infradead.org>
References: <d44baeee-cceb-7c02-7249-e6b4817f0847@infradead.org>
MIME-Version: 1.0
Message-ID: <158117388600.411.10874687119247493337.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     656b42deddea57e55a570671db9403af0ed3c439
Gitweb:        https://git.kernel.org/tip/656b42deddea57e55a570671db9403af0ed3c439
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 28 Jan 2020 18:25:14 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 29 Jan 2020 12:19:58 

irqchip: Some Kconfig cleanup for C-SKY

Fixes to Kconfig help text:

- spell out "hardware"
- fix verb usage

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/d44baeee-cceb-7c02-7249-e6b4817f0847@infradead.org
---
 drivers/irqchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1006c69..6d39773 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -438,7 +438,7 @@ config CSKY_MPINTC
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
 	  for C-SKY SMP system.
-	  In fact it's not mmio map in hw and it use ld/st to visit the
+	  In fact it's not mmio map in hardware and it uses ld/st to visit the
 	  controller's register inside CPU.
 
 config CSKY_APB_INTC
@@ -446,7 +446,7 @@ config CSKY_APB_INTC
 	depends on CSKY
 	help
 	  Say yes here to enable C-SKY APB interrupt controller driver used
-	  by C-SKY single core SOC system. It use mmio map apb-bus to visit
+	  by C-SKY single core SOC system. It uses mmio map apb-bus to visit
 	  the controller's register.
 
 config IMX_IRQSTEER

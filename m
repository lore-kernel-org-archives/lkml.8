Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7952078D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="218RE5fJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSarBxag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHYXlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53314 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHYXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:40:56 -0400
Date:   Tue, 25 Aug 2020 23:40:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wmgAG5W2pqZeMqd7LjtnFdAGZkv++MtSBjncFs25Kg=;
        b=218RE5fJjak4xqxD8/vygvrv8pWLIRiAxAIwo/jSuJ+XlzUyGUAwl9BH4A+tqEeqTWFt3B
        j9mt+hnLF5sOO3zF6Ug5mMvPOe53RLq0/z7jyR5r6mmhVOAEd+mFRCtelNgc8ByMebfaSR
        2V5gawwYyjU2lY0o35JVq/5DNxLOZvaSrz0r6gpENx7+MhBIHlFGRINmciQUFtAAqdx5Ow
        8ZjEL7sLCynzrTEmNeEnbWbgbVLImbLneOK+Uv1o0izyx5UjYN+lSVVsCkGFoFHUv+03Ta
        oTjb/MCY3vBBrfAURWOmS4a0LgtaYY0kXi6YJzP8HtO8yo5wLvJlv1kxml9i/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wmgAG5W2pqZeMqd7LjtnFdAGZkv++MtSBjncFs25Kg=;
        b=VSarBxagrqAGNeUk5aOg076LS54CMsA9p4xMlcT2wkVuGbJuXtxGa3EIRLW4r97Tx3z1x+
        wzzs11KHy3jOfeDA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Revert modular support for drivers using
 IRQCHIP_PLATFORM_DRIVER helperse
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <93debe6a0308b66d3f307af67ba7ec2c@kernel.org>
References: <93debe6a0308b66d3f307af67ba7ec2c@kernel.org>
MIME-Version: 1.0
Message-ID: <159839885252.389.8655544450744275136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a150dac5a8fb711fdc378c23f44bee4546f04246
Gitweb:        https://git.kernel.org/tip/a150dac5a8fb711fdc378c23f44bee4546f04246
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 25 Aug 2020 10:38:39 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 25 Aug 2020 10:48:54 +01:00

irqchip: Revert modular support for drivers using IRQCHIP_PLATFORM_DRIVER helperse

It has become obvious that switching a number of irqchip drivers
to being platform drivers without considering the platform was a
mistake. We have multiple reports of end-point drivers not
probing because the irqchip driver isn't there yet, breaking
the expectations of the users.

This patch reverts:

920ecb8c35cb ("irqchip/mtk-cirq: Convert to a platform driver")
f97dbf48ca43 ("irqchip/mtk-sysirq: Convert to a platform driver")
5be57099d445 ("irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER helper macros")
95bf9305d2e3 ("irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a permanent module")

and leave QCOM PDC, MTK sysrq and cirq drivers as built-in, special purpose
drivers for the time being until we have worked out a better solution.

Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reported-by: Frank Wunderlich <linux@fw-web.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/93debe6a0308b66d3f307af67ba7ec2c@kernel.org
---
 drivers/irqchip/Kconfig          | 2 +-
 drivers/irqchip/irq-mtk-cirq.c   | 4 +---
 drivers/irqchip/irq-mtk-sysirq.c | 4 +---
 drivers/irqchip/qcom-pdc.c       | 8 +-------
 4 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bb70b71..bfc9719 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	tristate "QCOM PDC"
+	bool "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 62a6127..69ba8ce 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -295,6 +295,4 @@ out_free:
 	return ret;
 }
 
-IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_cirq)
-IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
-IRQCHIP_PLATFORM_DRIVER_END(mtk_cirq)
+IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 7299c5a..6ff98b8 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -231,6 +231,4 @@ out_free_chip:
 	kfree(chip_data);
 	return ret;
 }
-IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
-IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
-IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
+IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index c1c5dfa..6ae9e1f 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,11 +11,9 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -432,8 +430,4 @@ fail:
 	return ret;
 }
 
-IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
-IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
-IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
-MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
-MODULE_LICENSE("GPL v2");
+IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);

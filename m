Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC66C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E4B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqt++gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgEUOmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgEUOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:42:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C6C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:42:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so4578980lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0f/O3Jvsm3O6csBt/1m3GZlLURu8oNsJZqakDLTmCNY=;
        b=jPqt++gmAqGoeMpnUkqKDp2jclje4mtrndExyagaECcGCuE5xDC3xEGQn24SQOMM2v
         6Ng9XhBXZTrsp/CUZ7NcBDGI9ZYfJuv3m3vEJ8pkLeGfU6LxG3tjfZu18Gv9pT3QqJlN
         7g0DQze55Q0eIjX/e/NACZlvAaU7EK7ZE0gM9nOx4b3FxSVZbF4FovnZyimcqtiFZeUt
         KHPNrQbGftnDYBiyRWITDJRPtprnXO2M/ILTKR3jNNR5sRASwRxQaBr/UbCy2oVna5RF
         ruWDfgimM9u+yxyNTwUGkL4AAFBPuUhHlBOzGBiNkVpeiMLDfBp8o1izKlEdhO1w5M0T
         0GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0f/O3Jvsm3O6csBt/1m3GZlLURu8oNsJZqakDLTmCNY=;
        b=ICCXCiU6qFLUwgFjaZCVsxuplVVflqB0nOFn9KfvoaeB0gexQDjMXEKooH+Jsxy0JW
         7IJplRGUa5/Q+zCELujbCg8QeEL1vxUGNTbOjecPsQJUrAH3VFN54JTQGLWAUbuGlMt6
         EQmr1XsTJ32VXOzyfcOCP+Fz4mbKbFbDORug1ib8sI1MGptRF3YIyvCuDIX+A9r6ZR0Q
         Lz4Pz4QmQMsf6A1KBwQQ/FL9F3aZJLk8/VJIzhjv4cuUyf8OQBT4H1yPaUGkUzRU5BXc
         Q4b6pn0k4i06l/VOZ5IaIsZJ2m0cm4/ms/zAwIY4jOL5byRgSTeW2EjvJCP9mf/nWtWC
         vkZQ==
X-Gm-Message-State: AOAM533m2qttoNAS0eTnTFSfg16KeHXm45CyrAuW2y3klc9Rgitw+OVO
        DmUAzVA04pWuU5+HJJQwrv8=
X-Google-Smtp-Source: ABdhPJywJa24CTN5SH9PqmXMFjYaY6xB5cRus3zmr4uC5QAvl4157peHJFRhsuie7HcdON7Xggp61A==
X-Received: by 2002:a19:5f4e:: with SMTP id a14mr5232403lfj.57.1590072165163;
        Thu, 21 May 2020 07:42:45 -0700 (PDT)
Received: from natalie.tramplemo.net (2.64.211.114.mobile.tre.se. [2.64.211.114])
        by smtp.googlemail.com with ESMTPSA id h2sm2004303ljb.45.2020.05.21.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:42:44 -0700 (PDT)
From:   Thommy Jakobsson <thommyj@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Thommy Jakobsson <thommyj@gmail.com>
Subject: [PATCH] uio: disable lazy irq disable to avoid double fire
Date:   Thu, 21 May 2020 16:42:09 +0200
Message-Id: <20200521144209.19413-1-thommyj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uio_pdrv_genirq and uio_dmem_genirq interrupts are handled in
userspace. So the condition for the interrupt hasn't normally not been
cleared when top half returns. disable_irq_nosync is called in top half,
but since that normally is lazy the irq isn't actually disabled.

For level triggered interrupts this will always result in a spurious
additional fire since the level in to the interrupt controller still is
active. The actual interrupt handler isn't run though since this
spurious irq is just recorded, and later on discared (for level).

This commit disables lazy masking for level triggered interrupts. It
leaves edge triggered interrupts as before, because they work with the
lazy scheme.

All other UIO drivers already seem to clear the interrupt cause at
driver levels.

Example of double fire. First goes all the way up to
uio_pdrv_genirq_handler, second is terminated in handle_fasteoi_irq and
marked as pending.

<idle>-0 [000] d... 8.245870: gic_handle_irq: irq 29
<idle>-0 [000] d.h. 8.245873: uio_pdrv_genirq_handler: disable irq 29
<idle>-0 [000] d... 8.245878: gic_handle_irq: irq 29
<idle>-0 [000] d.h. 8.245880: handle_fasteoi_irq: irq 29 PENDING
HInt-34  [001] d... 8.245897: uio_pdrv_genirq_irqcontrol: enable irq 29

Tested on 5.7rc2 using uio_pdrv_genirq and a custom Xilinx MPSoC board.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
---
 drivers/uio/uio_dmem_genirq.c | 24 ++++++++++++++++++++++++
 drivers/uio/uio_pdrv_genirq.c | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index f6ab3f28c838..14899ed19143 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -200,6 +201,29 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 			goto bad1;
 		uioinfo->irq = ret;
 	}
+
+	if (uioinfo->irq) {
+		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
+
+		/*
+		 * If a level interrupt, dont do lazy disable. Otherwise the
+		 * irq will fire again since clearing of the actual cause, on
+		 * device level, is done in userspace
+		 */
+		if (!irq_data) {
+			dev_err(&pdev->dev, "unable to get irq data\n");
+			ret = -ENXIO;
+			goto bad1;
+		}
+		/*
+		 * irqd_is_level_type() isn't used since isn't valid unitil
+		 * irq is configured.
+		 */
+		if (irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
+			dev_info(&pdev->dev, "disable lazy unmask\n");
+			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
+		}
+	}
 	uiomem = &uioinfo->mem[0];
 
 	for (i = 0; i < pdev->num_resources; ++i) {
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index ae319ef3a832..abf8e21d7158 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -20,6 +20,7 @@
 #include <linux/stringify.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -171,6 +172,29 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (uioinfo->irq) {
+		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
+
+		/*
+		 * If a level interrupt, dont do lazy disable. Otherwise the
+		 * irq will fire again since clearing of the actual cause, on
+		 * device level, is done in userspace
+		 */
+		if (!irq_data) {
+			dev_err(&pdev->dev, "unable to get irq data\n");
+			kfree(priv);
+			return -ENXIO;
+		}
+		/*
+		 * irqd_is_level_type() isn't used since isn't valid unitil
+		 * irq is configured.
+		 */
+		if (irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
+			dev_info(&pdev->dev, "disable lazy unmask\n");
+			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
+		}
+	}
+
 	uiomem = &uioinfo->mem[0];
 
 	for (i = 0; i < pdev->num_resources; ++i) {
-- 
2.17.1


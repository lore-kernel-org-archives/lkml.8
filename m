Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E772DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EB720738
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYPrOcU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgF1OMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgF1OMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:12:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55D2C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:12:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f8so2982906ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKCD7ZTYxhamcNuQn211J6fwI1SYysOc9utHpbcTC/Q=;
        b=SYPrOcU6E/TtpD8R3UTy33dOKJDaVtNkHq0DybfwWKCNpwKP44bpfSE+N4e3K8rt6S
         zhQIZHjMT1fvyzpvwXNKdarqoW9vwswPjdSnWlTt7l4Oqae+Bls2hwjT+E541eMguKFe
         lbPcfGi0lzO9Yyp0BMRyHJpjiHEinLc5GmBUXer9lhHwa/CNHvPCoibA5wUzgCwlBp3n
         TOVExQZG7+K42txmGZW6s1AQm6O1vDKkF/XsXky+0+RBAZUQYKKvHI6BIjnERBg6OE3f
         0MlTouSBEC3i2Gj6RyGitmRXGHFJItDGNBCn7H1UnhQ8HlBJZfsjKJw4N04niqv8Anvg
         h8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKCD7ZTYxhamcNuQn211J6fwI1SYysOc9utHpbcTC/Q=;
        b=XUKfrujcd27tpissGHlvLu0/NkTHj/rlhmzz3AEbkF7YAQM89gsOP/F3M/kX/p2KBX
         p9oPlNEiZq848z0LrXGNkaGts3vS5troXtAOmMz5tyGMFDobB5FOoxSPTcglY8IYsCAp
         1xz0chww0vGQaEiKXllIbP5AhWTLETy/TDvJ8qlj8CAr/ykfQjFpKvCVhv/wR4GLxaTz
         sqtC2LHt1mQLYOFXr7ihgSfNlyBrA3qpuvmWEY69vu4hV+GhBDa+RH7vWGXsLjMJ9e+m
         PSWKxvhKs5uZTNusDIFCjJuCA9hF9DULWmqn0c9rnF2qKB/uEy5RN1DCi/L3u5EG+a4q
         LhZg==
X-Gm-Message-State: AOAM532KHVLyjOZ/BLTvxQukO0JEqhuoyB1Gk6njP2ozN7c1atLkerv+
        sMXAxazQ9oiCRNZbqDOapNOjbqYomGu5iQ==
X-Google-Smtp-Source: ABdhPJzwV5gNJ8TwE6cqWuqfCKCFvZjXBmeJK2qOi/qRgeSSR3hFRFZV1pc8wkGNb/iwMwJ24U9jIg==
X-Received: by 2002:a2e:8346:: with SMTP id l6mr5623825ljh.209.1593353558808;
        Sun, 28 Jun 2020 07:12:38 -0700 (PDT)
Received: from natalie.tramplemo.net (2.65.45.120.mobile.tre.se. [2.65.45.120])
        by smtp.googlemail.com with ESMTPSA id q13sm8390625lfb.55.2020.06.28.07.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 07:12:38 -0700 (PDT)
From:   Thommy Jakobsson <thommyj@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        Thommy Jakobsson <thommyj@gmail.com>
Subject: [PATCH v2] uio: disable lazy irq disable to avoid double fire
Date:   Sun, 28 Jun 2020 16:12:29 +0200
Message-Id: <20200628141229.16121-1-thommyj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521144209.19413-1-thommyj@gmail.com>
References: <20200521144209.19413-1-thommyj@gmail.com>
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
New in v2:
- use dev_dbg instead of dev_info
- make sure not to change current behaviour. If irq_data doesn't exists
  for some reasone, just skip doing disabling unlazy altogether
- with above also the wrongly added kfree is removed (found by kbuild
  test robot)

I did not add the Reported-by tag for the kbuild test robot finding.
Not sure about the correct procedure here, but since it found the error
in a patch not merged, my reasoning was that it would look wrong in the
git log later on. Please advice if this is customary anyway.

 drivers/uio/uio_dmem_genirq.c | 19 +++++++++++++++++++
 drivers/uio/uio_pdrv_genirq.c | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 6e27fe4fcca3..ec7f66f4555a 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -199,6 +200,24 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
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
+		 * irqd_is_level_type() isn't used since isn't valid until
+		 * irq is configured.
+		 */
+		if (irq_data &&
+		    irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
+			dev_dbg(&pdev->dev, "disable lazy unmask\n");
+			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
+		}
+	}
+
 	uiomem = &uioinfo->mem[0];
 
 	for (i = 0; i < pdev->num_resources; ++i) {
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index ae319ef3a832..6de0b115c2da 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -20,6 +20,7 @@
 #include <linux/stringify.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -171,6 +172,23 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (uioinfo->irq) {
+		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
+
+		/*
+		 * If a level interrupt, dont do lazy disable. Otherwise the
+		 * irq will fire again since clearing of the actual cause, on
+		 * device level, is done in userspace
+		 * irqd_is_level_type() isn't used since isn't valid until
+		 * irq is configured.
+		 */
+		if (irq_data &&
+		    irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
+			dev_dbg(&pdev->dev, "disable lazy unmask\n");
+			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
+		}
+	}
+
 	uiomem = &uioinfo->mem[0];
 
 	for (i = 0; i < pdev->num_resources; ++i) {
-- 
2.17.1


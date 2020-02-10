Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F6C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F0920715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCq6Jrhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBJRSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:18:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40299 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgBJRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:18:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3068785plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tE+MK64Kb4S3iWhgyUci9Ix04DLPDsynAI698KMWsBs=;
        b=FCq6JrheYHUsn5AhNDYGJ//y4lzqUmzLBWtb2L5FW1jywKPfBRWVcKDA4bzO2wYUck
         tAdEMk12ts+jcDqnqHBugUMXj1wm7I1s8aDXzkdxP+TUgZfzAREBuQ5ugXMyQYdZDNx2
         0ohAewc6Y38sXhU2N97Q8MLTOHCsbh6EmdaNdbmQ0UoNx3PeUodGtnogRLwNN6b0ARG+
         WdTU785d1uopWfZgVsXLghxr/20P2LmFUfYjESBjOnOOytd7fYBE2IoGWE0QObqunDYq
         fdcKhaVNdea1k+ulOuBaQ8KdA/F1NxVWNFAt078lYViGGC36TWTDs90ehtz+afSBr/H0
         1Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tE+MK64Kb4S3iWhgyUci9Ix04DLPDsynAI698KMWsBs=;
        b=XiCUp6BrDjKh7h04/wYNuSbkq9nw7Ii1a5AdaJjtAau65+A3s3TIovP6X23ZToHlkk
         VPnRljYDenUbQzJSWPLI7V9g5tbOy6bKpqUYp0OB4gWBFp8MjqCBqIeW8SAMFC4fWXSq
         4x0tK42nlQ3QYIokbVdgJD/HxbGgEwySH2PjTT4T3rS6YkdJEd1PfpWnoH2UviOsmU1k
         krupnCj+dim4+C2MAB8iRmTmKHGxr+szvBb2cVV6F4BGmL6GheIF4LoE8mbjq4XWlsdd
         KxaSATJoAzB19Yst+0iYh3Ki5vuGUltPBdAMXwwd+i7Ej7myW81Lkie0qumLx/wONbDa
         n+DQ==
X-Gm-Message-State: APjAAAW7WwRecnM4zPCJuz2aTNktXcyaROZ1V7ix474MLshI3tGo5rnT
        6ZADfpMzADVhDUbGlCNo3a8pXaCs/p4=
X-Google-Smtp-Source: APXvYqzQapuGJj2OMsGXrJm7w2Fm9RIfcn81es9LeBl633U9ZmLV1Z69a0Yn8Ct35+W6GLetZQ3vUg==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr14171239plb.171.1581355111061;
        Mon, 10 Feb 2020 09:18:31 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u12sm927912pfm.165.2020.02.10.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:18:30 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [stable 4.19][PATCH 2/3] gpio: zynq: Report gpio direction at boot
Date:   Mon, 10 Feb 2020 10:18:26 -0700
Message-Id: <20200210171827.29693-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210171827.29693-1-mathieu.poirier@linaro.org>
References: <20200210171827.29693-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <Brandon.Maier@collins.com>

commit 6169005ceb8c715582eca70df3912cd2b351ede2 upstream

The Zynq's gpios can be configured by the bootloader. But Linux will
erroneously report all gpios as inputs unless we implement
get_direction().

Signed-off-by: Brandon Maier <Brandon.Maier@collins.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/gpio/gpio-zynq.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index a9238fb15013..5dec96155814 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -357,6 +357,28 @@ static int zynq_gpio_dir_out(struct gpio_chip *chip, unsigned int pin,
 	return 0;
 }
 
+/**
+ * zynq_gpio_get_direction - Read the direction of the specified GPIO pin
+ * @chip:	gpio_chip instance to be worked on
+ * @pin:	gpio pin number within the device
+ *
+ * This function returns the direction of the specified GPIO.
+ *
+ * Return: 0 for output, 1 for input
+ */
+static int zynq_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
+{
+	u32 reg;
+	unsigned int bank_num, bank_pin_num;
+	struct zynq_gpio *gpio = gpiochip_get_data(chip);
+
+	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
+
+	reg = readl_relaxed(gpio->base_addr + ZYNQ_GPIO_DIRM_OFFSET(bank_num));
+
+	return !(reg & BIT(bank_pin_num));
+}
+
 /**
  * zynq_gpio_irq_mask - Disable the interrupts for a gpio pin
  * @irq_data:	per irq and chip data passed down to chip functions
@@ -829,6 +851,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->free = zynq_gpio_free;
 	chip->direction_input = zynq_gpio_dir_in;
 	chip->direction_output = zynq_gpio_dir_out;
+	chip->get_direction = zynq_gpio_get_direction;
 	chip->base = of_alias_get_id(pdev->dev.of_node, "gpio");
 	chip->ngpio = gpio->p_data->ngpio;
 
-- 
2.20.1


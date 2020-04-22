Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A9C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B8420775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gz85oKII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgDVKKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgDVKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD8C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:10:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so1605355ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVpuV9906kTdH8kjynNF6G4cMp3xW329yIZR2pMpgr4=;
        b=gz85oKIIWH5onOAX7yHN644ZgaDeGOH22z4QW3dFCjsQm4l+4JWTJo7PfmpPjDGFft
         XxBdaYeN7nKECc8t3WmGqFz9zW/uu77kGEPXIXhk0gE8OGEr3yOg7k2tIG7VHqppeC0z
         dHqFUUbvhKyF4nocekpBRtF9JXkOquUcuduNq/gUnjyNc9NYUb2P7lBZJQNoMuUijcTA
         piOcMylf1fKLEnNbPRvbYVUxvcQ58xJqizUGxJ6eTO5JPsQWZqYBk+gmA21gbh8J3Fys
         r0+fdE782jU5LP9EtKfg3RXEWGWp8RrxcyqN1KHxk+RmZ0rKSpm1/5LITPymBGkcKBFb
         U+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVpuV9906kTdH8kjynNF6G4cMp3xW329yIZR2pMpgr4=;
        b=UZ4yvP7Gn/QOS9FfznZ+9A/AwxeDcCpxC+xpy0eLzPEzd4xlnJsBxdy+xVaWDY0EtX
         QsLMyZGC5TJybbB3Zps6UJODWvR9pdJ/I65p8xV1HlzjgYZB+WnvdezTFDH75Ubsi45f
         A4MnT03/AMNZ/DwZ+52UhSwRH5Z+RCi1R6Mz7pNz6p8sb/sGFMAlMXJimyVpfSdcEdd3
         wDP309KEwsgR/BkqpCla1IDOByEHHjUHaOsppE0KqKhGdpFjrDfiJB4zXPz6a+4T76TF
         IVfythRe7ed6Z37P6LckPJwQsvJX4G/29cfZgt0s6Nt+kVaTQnZQr9gF6m510cCHZbWs
         rsRA==
X-Gm-Message-State: AGi0PuYA8Xy0+QqEbqPG3gyEGKGG92n6RCl/uDfBEG4pLMxHvJks+wEQ
        3S5HjVM7WDRr7H0BdsetZ6ekDA==
X-Google-Smtp-Source: APiQypLzg0y5Fg8LOd4XLWjOORnygZbpUDG7xZWJc87sQhB/LR5OrVVWb/3kGnX6Jb5WRwXKr//wGQ==
X-Received: by 2002:a2e:5746:: with SMTP id r6mr15361642ljd.15.1587550208106;
        Wed, 22 Apr 2020 03:10:08 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id v18sm4649962lfd.0.2020.04.22.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:10:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: [RESEND PATCH v2 1/2] driver core: platform: Initialize dma_parms for platform devices
Date:   Wed, 22 Apr 2020 12:09:54 +0200
Message-Id: <20200422100954.31211-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently the platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with
this approach allows us to avoid the initialization and to not waste memory
for the struct device_dma_parameters, as this can be decided on a case by
case basis.

However, it has turned out that this approach is not very practical.  Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common platform bus
at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Tested-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/platform.c         | 2 ++
 include/linux/platform_device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 5255550b7c34..b27d0f6c18c9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -380,6 +380,8 @@ struct platform_object {
  */
 static void setup_pdev_dma_masks(struct platform_device *pdev)
 {
+	pdev->dev.dma_parms = &pdev->dma_parms;
+
 	if (!pdev->dev.coherent_dma_mask)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	if (!pdev->dev.dma_mask) {
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index bdc35753ef7c..77a2aada106d 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	bool		id_auto;
 	struct device	dev;
 	u64		platform_dma_mask;
+	struct device_dma_parameters dma_parms;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.20.1


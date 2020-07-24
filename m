Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3865C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9A5206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="M3fN3srJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXV3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXV3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:29:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5245C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:29:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so4762143qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IwUFhaabh/nXh3QEUZEDpYs1syuDyPDgcXgIKM8icc=;
        b=M3fN3srJWK4wZCZQQtn7XxJP42rIvQg08x8E33MCjq7j9nhRRdCy8t5nlIcD+KSIjq
         AI1ytt8VTE7Ip0c4gvu9reBmAa4My6LSkAQII1gJR9TwnfSTABvAKkLLbILh8iCQ12BW
         AAJdy5ppk44j/FUobN7U2GscswkShLiuBleIJtiywE96IOzLknpDNMSJrF6h+0Z1c+K0
         LsQ1WNswd7r9pigvQSg1k25lmK2pxThZ6cYPBhYCnz1dYDd4Q/7oqfQ7x43olx0PcwVM
         cs2zvOR2gk6RIpmRfCgw8DY3TsczcO5riQFtWWdGARWG/KudN0Sugk4IxUtZyXfgsxRe
         RL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IwUFhaabh/nXh3QEUZEDpYs1syuDyPDgcXgIKM8icc=;
        b=eXJ5TYNwzKTOfnQvBDAeLzBVjzNZ/ZXEqwjSO702oLbQwGhwiiLcwZNkPYmSJo18iX
         MAt/89Dci6XAR/1FjEH2rw9PxHR5dg56PY+XT3xQ/nTSKgI2Q4bwbHwg3dYsdXCL3/v9
         YHY9OI+e0yIZa/0cZBrDN4VjLV6vl7OQQ+CsQcuiGyQKTi5BgdKqJFZ0xZcMvyaiPvpm
         r2HdjIYmgBNFytfEy8prvjmIwAB1I3H6O/qUMk3s8n5IGvm8SQJo30JbZJRY/Gj8+Gea
         zgV0+wqaOCPvReyNXNs9mEyHn1ukZGMQgiPm937oRCVXoNL8C12QOL32fiLR8pLdUzme
         p+vA==
X-Gm-Message-State: AOAM532LKIeLnV2zKnZUpzq2px8CrWdchfekJiLXdtvQ1DNQTYwCB88G
        C+TjvLFf1liwUvM2CXbms1zm+w==
X-Google-Smtp-Source: ABdhPJyNdEPcfYzQHlPqEuCVHXHTCMhlXskpv805tJl0l+zUNf5Xt0TaQfFkQT307jEtgWwPUdclqQ==
X-Received: by 2002:ad4:5042:: with SMTP id m2mr11509729qvq.225.1595626152945;
        Fri, 24 Jul 2020 14:29:12 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id p202sm5224758qke.97.2020.07.24.14.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:29:12 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Daniel Gutson <daniel.gutson@eclypsium.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Module argument to control whether intel-spi-pci attempts to turn the SPI flash chip writeable
Date:   Fri, 24 Jul 2020 18:28:53 -0300
Message-Id: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, intel-spi has a module argument that controls whether the driver
attempts to turn the SPI flash chip writeable. The default value
is FALSE (don't try to make it writeable).
However, this flag applies only for a number of devices, coming from the
platform driver, whereas the devices detected through the PCI driver
(intel-spi-pci) are not subject to this check since the configuration
takes place in intel-spi-pci which doesn't have an argument.

That's why I propose this patch to add such argument to intel-spi-pci,
so the user can control whether the driver tries to make the chip
writeable or not, being the default FALSE as is the argument of
intel-spi.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 81329f680bec..77e57450f166 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -24,6 +24,10 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+static bool writeable;
+module_param(writeable, bool, 0);
+MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -41,12 +45,14 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	/* Try to make the chip read/write */
-	pci_read_config_dword(pdev, BCR, &bcr);
-	if (!(bcr & BCR_WPD)) {
-		bcr |= BCR_WPD;
-		pci_write_config_dword(pdev, BCR, bcr);
+	if (writeable) {
+		/* Try to make the chip read/write */
 		pci_read_config_dword(pdev, BCR, &bcr);
+		if (!(bcr & BCR_WPD)) {
+			bcr |= BCR_WPD;
+			pci_write_config_dword(pdev, BCR, bcr);
+			pci_read_config_dword(pdev, BCR, &bcr);
+		}
 	}
 	info->writeable = !!(bcr & BCR_WPD);
 
-- 
2.25.1


Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F43AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDC720775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="BRxWYRrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHCNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgHCNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:45:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 06:45:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so35091572qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jZpyOsHwlMwVkwX/UG+yhCnHasbRZdF2QEv3wd8FYg=;
        b=BRxWYRrrGBIwd61roJhGedBKxiROX9FIdXtsSlHnnRy//E0ye8dDxT9fgkxfU3CbwO
         NED8qQKFG7oRyGcjviIr24/E0oXZ31UA8WCDvQhkyQ0jy4nVjn5UZHH4654gMhaFYeuj
         u2v5h0cKqCxdHwkbAckMgLOY+hcMV34hxzYNghB0LJx0wevTaJ7tRs5zi5RUU5zjMcpu
         AYhugN2Pk3PIfd9YEZJQmaUf1gGd1gQrkWmUle26CPFJPoY3Jgw3WeBH/EWD/OhdIulp
         frJwg2uy3YYLzGMsDHo1GRpBTxSvcjcMpMCL0ZPkeQTA5dpa4+APPDTuKYHPrL1XbYGe
         c2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jZpyOsHwlMwVkwX/UG+yhCnHasbRZdF2QEv3wd8FYg=;
        b=j+ootxHYdP0gOa0NVtvZ7Li5N/R1CtmvPgtAmyjjxEZudNlRHeeiChX0rudboaICIx
         REoJxpWywLvwkoa3M6+6bpIde+3JdT3Xhesp5rqyjsNMeoJ18lNYpBZ3vZ2JeotcsuRr
         rrq1jt7eYQ5bH3ItA543VK5z7Y6a7bt9eku68q5wGzv20HrD0r1XTZNhhi/RT7j2fENf
         QYHzLsmGFMbiFZxNjbkekJAm5DnCu7lFh5j0WExdhN7CQwWhY4/olMnUsaN8O15WGf7B
         CqGIJYThGwGil1RJt3giNuEBFlBRV9P+vRa4emUFe0nKUObxwmnRiZeww4iQ+APXJFLr
         lBGw==
X-Gm-Message-State: AOAM530f/Ci8IgVnlq0KPtQf1JFVXBnWmA4OhO85239Z+ZKqkAuSSZkt
        WBrJf9K45TVrto9t61IDXUycvg==
X-Google-Smtp-Source: ABdhPJzeQaFTlpvYXYws/wBRMz1IvaAHL6jQqA1oSXICoac3JwjCsMaaUfpn4WOcucvP48rWnKtNug==
X-Received: by 2002:a37:9c7:: with SMTP id 190mr12769774qkj.303.1596462318338;
        Mon, 03 Aug 2020 06:45:18 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id g4sm20078538qtp.89.2020.08.03.06.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 06:45:17 -0700 (PDT)
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
Subject: [PATCH] Remove attempt by intel-spi-pci to turn the SPI flash chip writeable
Date:   Mon,  3 Aug 2020 10:44:49 -0300
Message-Id: <20200803134449.72502-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the intel-spi-pci driver tries to unconditionally set
the SPI chip writeable. After discussing in the LKML, the original
author decided that it was better  to remove the attempt.

Context, the intel-spi has a module argument that controls
whether the driver attempts to turn the SPI flash chip writeable.
The default value is FALSE (don't try to make it writeable).
However, this flag applies only for a number of devices, coming from the
platform driver, whereas the devices detected through the PCI driver
(intel-spi-pci) are not subject to this check since the configuration
takes place in intel-spi-pci which doesn't have an argument.

This patch removes the code that attempts to turn the SPI chip writeable.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 81329f680bec..d721ba4e8b41 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -41,13 +41,7 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	if (!info)
 		return -ENOMEM;
 
-	/* Try to make the chip read/write */
 	pci_read_config_dword(pdev, BCR, &bcr);
-	if (!(bcr & BCR_WPD)) {
-		bcr |= BCR_WPD;
-		pci_write_config_dword(pdev, BCR, bcr);
-		pci_read_config_dword(pdev, BCR, &bcr);
-	}
 	info->writeable = !!(bcr & BCR_WPD);
 
 	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
-- 
2.25.1


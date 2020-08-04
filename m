Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FFD2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="NmSO8dxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgHDN7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgHDN6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:58:41 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FBC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:58:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j10so12336155qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v//52S0oWqF0q/pvhHFNNBHFoWzKUF/wuj38r6SqPoQ=;
        b=NmSO8dxBPaU+APGuwDQiFe+kBY/TLdbQbVnSiP6W1ot8o8tXBd0uEtKb9uokPDMqXB
         hDUtallKiMZmQmSe2lSKO/mNUkeE9HnCX6yLVClEhifcAH7MqyfLD1LCnDRPcILxQneN
         PeUUNfy4LZBd27L/d0sL4vC9RShHYsZUilMaslQTQ3Qy22c3M/VYscd6D2tnIgvBHclM
         J0v4CNKmpgd1Qu6nqLHEXMGP518uEiVqnrlGxm2eAKrwsd7nNL8xX5YJG5qf8EBdVfxb
         rB0Ykb/cd/vaceNna27I3VGMIO7EplBiUZnrUsT/lMZmCkrFE8euWUr+zhTRgFoS+MR6
         2C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v//52S0oWqF0q/pvhHFNNBHFoWzKUF/wuj38r6SqPoQ=;
        b=Tigxe+M3uheLjiGJ2h8tkqjZxxjEpGVid80sK7o8GJK1SMSo8MZZYOl7D+ItWbUVSr
         0QK7idRmV055aS2x4vwL8UxXDQ2XzIrJSR7h1YcDsgMfhJBwqalu2Js7EjROqoTm1S/K
         3KCN+uSl3mTVb6wlD3udGFKHlyirS+pGLoWcaMN/lnSX2r8TgSMZVFJoO2HBXRnZtzZs
         BMMSi+2mTTdvYR8ceA4w1N5bzDBxRRIvSavepcQaziFRSOx4Oo3/cHGAYip61CosXIfw
         mRx3nmbcriCsMFpJ9JDY5ygZcb00kpJvndYctBROAGp4/h8KoL8iiHjq5P/p4SqcotsI
         Zl7w==
X-Gm-Message-State: AOAM5310mwfyL4XCiL74G1LI20/6ShqS8GnQ9NLnKaW1zY7HIVZe958J
        VbXHVZLsOpwMiDioZ+Ac2ROq4w==
X-Google-Smtp-Source: ABdhPJxQ0oF4/D4p6FW7hD76hNivUtUBUtuUhxt3B5tN5owha1nvT9xeuaSSq8pj5PtFqI/A8uA4pg==
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr22039852qve.71.1596549505898;
        Tue, 04 Aug 2020 06:58:25 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id c7sm20637736qkd.92.2020.08.04.06.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:58:25 -0700 (PDT)
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
Subject: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash chip writable
Date:   Tue,  4 Aug 2020 10:58:17 -0300
Message-Id: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
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
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 81329f680bec..2b071da804e7 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -41,14 +41,9 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
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
+	dev_dbg(&pdev->dev, "device is writeable: %d\n", (int)info->writeable);
 
 	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
 	if (IS_ERR(ispi))
-- 
2.25.1


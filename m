Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25284C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E976421974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A43rT2CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgEHWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgEHWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:54:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 15:54:29 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so2923289ile.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ar+jxDTcpLEv8tEr/MZanQKb1HM+/Rmmbfp3a+f6rg=;
        b=A43rT2CQpvS/I2YQGCd8mvnKkWXTua/JCmh9wM0YZNBNugebJfmZDPmkHbQQOIDpPV
         h/u8rtIzxQLfsSFTAhJ4hjA/xNE/W/AoQYnlacitpLF9OixvYOLm1t7CBwaOUQbLCc6t
         2cKSZjLouM5XVjMODIIo+lCU/wcDstG0y5P/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ar+jxDTcpLEv8tEr/MZanQKb1HM+/Rmmbfp3a+f6rg=;
        b=Dqs2pCN9khNadHyec2QYs9B7gqTKPoC+dICoyr7+5pAIEKIq7j7GC4erT9Z5QKKBY4
         OEAEMxQ5GQAn88Pn/Sh17isAgZZkLXmaQcqIif263YSE//nbnUgIFzcYVYv6nV+3WI58
         HYFlmgZsyKyvGWv0PN/LIghfP65ijv5vYkmSSS4v1XlYpO6t5K+qLKa02jLLxbJLQ8gx
         R484R4XI9CyD6McDleIgDAJLHb/2oI7F7oStGqs8m2kwln0sD9JivrSaF+I3PukaUlVi
         apXri2zqkyJXqMxy/9uLqhTAskxv4roMdwRrEApa9JDudnmHmBAakxS22UjXviDyUOEW
         cECw==
X-Gm-Message-State: AGi0Puavb8ftreE1E60/hJo/X25hRYeriugq2PWr/gINMuNbjG8TVVDL
        Q3ZMB1lz9GsDARXL1eVrcrQsfg==
X-Google-Smtp-Source: APiQypIQp7u1rzpjZ3TyYuYao2FlF6IdLRxccWx7owHBi88z3X0TnKAlTEnkdskyHhMv9oGrMTEUjQ==
X-Received: by 2002:a92:8c48:: with SMTP id o69mr4705493ild.253.1588978468885;
        Fri, 08 May 2020 15:54:28 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id q29sm1418621ill.65.2020.05.08.15.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:54:28 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        linux-mmc@vger.kernel.org
Cc:     evgreen@chromium.org, Joerg Roedel <jroedel@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, dianders@chromium.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-acpi: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA for AMDI0040
Date:   Fri,  8 May 2020 16:54:21 -0600
Message-Id: <20200508165344.1.Id5bb8b1ae7ea576f26f9d91c761df7ccffbf58c5@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD eMMC 5.0 controller does not support 64 bit DMA.

See the discussion here: https://marc.info/?l=linux-mmc&m=158879884514552&w=2

Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/sdhci-acpi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index faba53cf139b..d8b76cb8698a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -605,10 +605,12 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 }
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
-	.chip   = &sdhci_acpi_chip_amd,
-	.caps   = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
-	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE |
-			SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.chip		= &sdhci_acpi_chip_amd,
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
+			  SDHCI_QUIRK_32BIT_DMA_SIZE |
+			  SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
 	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
 };
 
-- 
2.26.2.645.ge9eca65c58-goog


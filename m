Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16FAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75C324699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOxgWJ8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCBAUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 19:20:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCBAUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:20:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so10373641wrt.3;
        Sun, 01 Mar 2020 16:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XwflzW73qPOe/GTQwpcOAM7KQXM3qVC8t1TrgTjVHHc=;
        b=aOxgWJ8mTfaIRVcpC1itBRUKh01kGUyqzp5M7fP5fK2xssn7ysN26LLER/EMNzDS4u
         K5dkYmZmPAL+Tfjmzc7dwJ/yv8EupAjBHxcRf5OrEsDoXap7hDWtt14DPAiuLR6/E2ZR
         EZhqyKab3y/acB+b8rdSMDY4HIwJAwvj4NYcovKQqg6j093ItmG5AHIDpqcAEOJbko0A
         htLrlQqxdHK8SwdXU+EjPYPsPtM6UGNCo7BUpEzZKm/8VOb52jlQMteika7Fp+6H2Mtq
         TmsW6xAqwyfebMcMy8Eq4PtbrUS5Tly1+Y20886qfJAdG+uCk5lVCD8gK8Ckqq2jyQoj
         VR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XwflzW73qPOe/GTQwpcOAM7KQXM3qVC8t1TrgTjVHHc=;
        b=KwaDJ6JV2+agr0xhdbJrL94euczB1poNWZOfeBeqa7stzuSlFRKf/6lFKurBiYF/nL
         +x2LS44Uxhd10ytI6IG2DHez/ItJ2MBNYJl3jOU70KfkhDun2i/NZzQ3O4bJbLVs/iYT
         xNOKs5w+YyAGmcqT5iqOaWKGBG7UMxsBDaa3kgDcmn1oMrxFpLsvEXswWy+x+0SfVeCi
         Cb8MRQ+rHZj/BcJvDIEUMHepAxQAGEKEAygmJslB5/7IojYedECl+KVPAqP55KDoriQu
         6uspYlb8W+FMauVYrfWNnKqBTuXWP7Xyn/Z3KihhYzRUjRxg31DRO7yL7sFyN5Ajk+aG
         7yBQ==
X-Gm-Message-State: APjAAAV+ag6vL72OWokn9fxxW6dsTKyH2+lE85B7Y4OEU6xrwN9/vBZe
        jo3iiAmimjLqYqC5BeElh/k=
X-Google-Smtp-Source: APXvYqymqA/RB6sE4CysvUiIUuKxrT81mIHqBRFBWPQ30CrkRgQ03AJFoViOTZJv0Hh8kRwrwoZGkA==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr18595761wrq.206.1583108414631;
        Sun, 01 Mar 2020 16:20:14 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:14 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA modes
Date:   Mon,  2 Mar 2020 02:19:57 +0200
Message-Id: <20200302001958.11105-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

There's no reason to keep this .ptp_sts_supported property explicitly in
devtype_data, since it can be deduced from the operating mode alone.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d21cc5cdc8a4..c26a42f8ecbc 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -122,7 +122,6 @@ enum dspi_trans_mode {
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
-	bool			ptp_sts_supported;
 	bool			xspi_mode;
 	int			fifo_size;
 	int			dma_bufsize;
@@ -150,48 +149,41 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[LS1021A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
@@ -1246,7 +1238,8 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
 
-	ctlr->ptp_sts_supported = dspi->devtype_data->ptp_sts_supported;
+	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
+		ctlr->ptp_sts_supported = true;
 
 	platform_set_drvdata(pdev, ctlr);
 
-- 
2.17.1


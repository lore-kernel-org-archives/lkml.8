Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02CFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D1920671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aFCsAMhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgETPMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:12:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19943 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:12:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec548bf0000>; Wed, 20 May 2020 08:11:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 May 2020 08:12:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 May 2020 08:12:11 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 15:12:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 20 May 2020 15:12:10 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.44]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec548c90000>; Wed, 20 May 2020 08:12:09 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] firmware: tegra: Defer BPMP probe if shared memory not available
Date:   Wed, 20 May 2020 16:12:06 +0100
Message-ID: <20200520151206.15253-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589987519; bh=F7hvT2hG6fOGVSVaRQDr8+JP8MjnrkNvzh0h68pPxoo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=aFCsAMhdTklDBDBpY/DNcsgc61NF+gUwy2Jam9df7p6IVWding6xw1LETUsISY6YE
         BpAZ9NZ1igW67SW/3WOoD2T9zO+T6U7AEkZbvvRMmgo5r/Hl8Tj66HYHURbuf7GCGI
         5gvCkcrCIPxq1JgDxOar0ESGMJT7LMq5mpJ8uRlw2rmuSJdDD6B4J2DqGa8EoLDQ+O
         xq6Z9O84J3Xoxuj/MWGejkuvFGvIQmmXsegSy4KkjXs01ifViSTFR1fBscWJr5n1KS
         xubCbfINvJSj/5Fz4goVtwS5TZ/y6XqvnI6n6Ztc+6JNjLlX5LuTWVLEf0N4YjHhBa
         v15zVfST1ml9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
adding all top level devices") was added, the probing of the Tegra
SRAM device has occurred later in the boot sequence, after the BPMP
has been probed. The BPMP uses sections of the SRAM for shared memory
and if the BPMP is probed before the SRAM then it fails to probe and
never tries again. This is causing a boot failure on Tegra186 and
Tegra194. Fix this by allowing the probe of the BPMP to be deferred if
the SRAM is not available yet.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/firmware/tegra/bpmp-tegra186.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
index ea308751635f..63ab21d89c2c 100644
--- a/drivers/firmware/tegra/bpmp-tegra186.c
+++ b/drivers/firmware/tegra/bpmp-tegra186.c
@@ -176,7 +176,7 @@ static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
 	priv->tx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
 	if (!priv->tx.pool) {
 		dev_err(bpmp->dev, "TX shmem pool not found\n");
-		return -ENOMEM;
+		return -EPROBE_DEFER;
 	}
 
 	priv->tx.virt = gen_pool_dma_alloc(priv->tx.pool, 4096, &priv->tx.phys);
@@ -188,7 +188,7 @@ static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
 	priv->rx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
 	if (!priv->rx.pool) {
 		dev_err(bpmp->dev, "RX shmem pool not found\n");
-		err = -ENOMEM;
+		err = -EPROBE_DEFER;
 		goto free_tx;
 	}
 
-- 
2.17.1


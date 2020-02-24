Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C4C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A025B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rBecrUjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgBXOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:36:46 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6173 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:36:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e53df310000>; Mon, 24 Feb 2020 06:35:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Feb 2020 06:36:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Feb 2020 06:36:44 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 14:36:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Feb 2020 14:36:44 +0000
Received: from thunderball.nvidia.com (Not Verified[10.21.140.91]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e53df7b0004>; Mon, 24 Feb 2020 06:36:44 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] phy: tegra: xusb: Don't warn on probe defer
Date:   Mon, 24 Feb 2020 14:36:41 +0000
Message-ID: <20200224143641.5851-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582554929; bh=7eSa8a0agYCbWAIxk42o+yuK3shTCcRTRyAk6dMsAug=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=rBecrUjl2b6n1qUygD3eKvgy3FSwjZ6zW3n0v3VktUgfGznyP4H90ASFPWzBHPTGp
         5ojWmky9cSOtFuYcaeo6OAV8UBq/VnOevh90f3bdRIFzsrjL2nf78HCjyU1RheeazY
         sQ34iSVLS8ac9ThHS7HhyiXz4z5TeNGXZcXVcMT8Di/cjfrpOpWk6PP7wDMjr4osjm
         vQGoY2tKBWTVZBz3Ti7pHrxlAQiWqNfTfPK2Qz/0euYc2uT6KVVeu+5rI6hZq9uimh
         VLm7yGEaGDi1i1nneJmv95ii7M6EtSy/LFlDxR3opyIQgSucHxFfvYzZkYqZyvgBjT
         I7xRJTklarPzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value for tegra_fuse_readl().
Given that the driver deals with it properly, there's no need to
output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 84c27394c181..12d0f3e30dbc 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -802,7 +802,9 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	err = tegra_fuse_readl(TEGRA_FUSE_SKU_CALIB_0, &value);
 	if (err) {
-		dev_err(dev, "failed to read calibration fuse: %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "failed to read calibration fuse: %d\n",
+				err);
 		return err;
 	}
 
-- 
2.17.1


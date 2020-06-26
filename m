Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56852C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F162070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VMOueHwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFZKVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:21:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6143 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgFZKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:20:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5cb750001>; Fri, 26 Jun 2020 03:18:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 03:20:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 03:20:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 10:19:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 10:19:44 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef5cbbe0001>; Fri, 26 Jun 2020 03:19:44 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V4 6/7] phy: tegra: xusb: Enable charger detect for Tegra186
Date:   Fri, 26 Jun 2020 15:49:01 +0530
Message-ID: <1593166742-23592-7-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
References: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593166710; bh=x47uUA2erMJqHZh90xukqCmrz3bYIJ6P1NkUWnlpVUo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VMOueHwSTzSdUUW0hRuttFCzvdXZ8aKXFF0A4bT/7glKtbc68x1xs3oCLfH9++gIH
         mp9eTYuJMCtNea/cVDlP7TKotqDV+ywGeVEbZbsgNDNXhIl6fwGjCD81r3+mDuK7pK
         8EZIsJuNhLejBPukAq6Sh4Hjo90V2HXF3OARILqv8ZoUuI0h0gHpm1NbhaB7kP1N2L
         yYQoeAJV4ckYUIJTSlEOc9oI6+N4EoaGTW0IP+vDSIQcK7891O08DlFV2wFfTRX1h/
         a5v2jFgl2mTRnO9QY+8DkYYI0GUQyzDxaloc4eWRPMllWPVcP9IvTc40LLoBhVhy2c
         nP9J9uSnSvM3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 SoC supports charger detect, set corresponding soc flag.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4:
 - No changes
---
V3:
 - Used supports_charger_detect name instead of charger_detect.
 - Added Acked-by updates to commit message.
---
V2:
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 59b78a7..da61721 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -1041,6 +1041,7 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc = {
 	.ops = &tegra186_xusb_padctl_ops,
 	.supply_names = tegra186_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra186_xusb_padctl_supply_names),
+	.supports_charger_detect = true,
 };
 EXPORT_SYMBOL_GPL(tegra186_xusb_padctl_soc);
 #endif
-- 
2.7.4


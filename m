Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7809DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E58E20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FUAKwx99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgENGXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:23:19 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7056 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:23:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebce34b0001>; Wed, 13 May 2020 23:20:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 23:23:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 May 2020 23:23:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 06:23:16 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 14 May 2020 06:23:15 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ebce3d00001>; Wed, 13 May 2020 23:23:15 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V3 7/8] phy: tegra: xusb: Enable charger detect for Tegra186
Date:   Thu, 14 May 2020 11:52:42 +0530
Message-ID: <1589437363-16727-8-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589437259; bh=zG5lXq8lmjrxi5qalRjGpZR68Sy4qnUWY8RAdnQ/+Gg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FUAKwx99CJwoabk4OwvGw4Fj9Zt1DhYBq93s2X1QMXlm/vRaPNxr5KbfAP9KljcKi
         D8zA5IOYQYILzN/K55PD+unlaIWYTOmU6VZjGLqLe4UQWl4gl71ndgM3VfBfjaTJ7+
         Ran9W2brT3T1JVxEoIgFgJO29oUOMpeV/IjlljkEmbs+uAyWjWjBvGoD2fodpbcLuz
         yCNHpwGXTxGC9rAEgiK52P0gvVBlX5YXW7eOIvkwfP1ZCuqhjDIcKnDw4KRZkp+sqn
         ft6ZSeFsSmZovKgRRJNg99Irhbuw5Gaamfwngwtjlrwt2xXUfhuYdcWqw2DzUxrQAY
         hU9Qbj6vL9gxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 SoC supports charger detect, set corresponding soc flag.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
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


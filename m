Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43552076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nlt9uEKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCRKcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:32:14 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7107 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgCRKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:32:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e71f89d0000>; Wed, 18 Mar 2020 03:31:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Mar 2020 03:32:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Mar 2020 03:32:10 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 10:32:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Mar 2020 10:32:10 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e71f8a60007>; Wed, 18 Mar 2020 03:32:09 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jckuo@nvidia.com>, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V1 8/8] phy: tegra: xusb: Enable charger detect for Tegra210
Date:   Wed, 18 Mar 2020 16:01:07 +0530
Message-ID: <1584527467-8058-9-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584527517; bh=uv1fkuSad4kBCRwzQTXQF9RBAm7wcOWJwqJqYeh9Dgk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nlt9uEKHAIpz95lJP5LapcrgBgt5MBTTN31/B/CCweamN7BYeJg/1YQjP7JCYAh5Y
         2debWzIoQcLnjabTZ2I6ojb/mckNczHj0CevzfXvM3qP6P9C8oZrZ80JdIjiYCBTcC
         lehWiEekdhTX0y5KOV4IjSCm/QSTZ4ZXDNT5z6+ulN9+V995YBDfLSWpoGLkYFi2hx
         IhiQJj+Y4fK858j0g0bJ74UYf7FEMBuT0OYefiO46tKfmnVIyt8tyfhRJrOHWrM/zO
         7UIu0yDPg7sgSu6kYUi9y8PVkhhVGYRWAX7jzVM3ZypC+dExD1eCby9lV4B6DC8YOT
         qUr3iAfDx9Dww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 SoC supports charger detect, set corresponding soc flag.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 93517b1..4c8cb0a 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -2347,6 +2347,7 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 	.supply_names = tegra210_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
 	.need_fake_usb3_port = true,
+	.charger_detect = true,
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
-- 
2.7.4


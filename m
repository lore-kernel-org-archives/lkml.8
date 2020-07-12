Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F5BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71A720725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WIFfdiO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgGLK2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:28:53 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6759 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGLK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:28:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ae5ab0000>; Sun, 12 Jul 2020 03:27:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:28:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 Jul 2020 03:28:52 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:28:47 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:28:47 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0ae5dd0001>; Sun, 12 Jul 2020 03:28:46 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] usb: tegra: Fix allocation for the FPCI context
Date:   Sun, 12 Jul 2020 11:28:36 +0100
Message-ID: <20200712102837.24340-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594549675; bh=HueIEpf3LB7+Uj4bZJ8I5wIkAbrkHVxNkCa0Lx8Mdtw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=WIFfdiO+ODPanyz/TA8x1jpv4gkh85h07ufOiQcJF1wEDwdwZ78eVa5iLRj/xRHMl
         8k8pC1Qp/P4ktin+Fb8GDriH9vuj2Pkucwx1OwYqXjDYzvG3qON9cJdb21UFCWPtgH
         18mdTUgklWL5vGL0hIvJLdgu+ZFuB82DesB5BIBvlpExW6BN1NCX3WaVkQQsP1SMjQ
         rELeS5o98CRwoYLUK7tnmqoevSvX6Kd1htrYnzXzyiuUbpboPuTUguZOOuLgmxewAD
         8Q3jvqphgRljoq0jVxujrxMeKY7Ed1b/Yzc44dMk+riqGWUoAilmZb/QG0AXpvTawi
         mAq2rugrpSKtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB
context save/restore") is using the IPFS 'num_offsets' value when
allocating memory for FPCI context instead of the FPCI 'num_offsets'.
We have not observed any specific issues because of this, but could
cause too much memory or too little memory to be allocated. Fix this
by using the FPCI 'num_offsets' for allocating the FPCI memory for
storing the FPCI state.

Cc: stable@vger.kernel.org

Fixes: 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB context save/restore")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 9ce28ab47f4b..014d79334f50 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -856,7 +856,7 @@ static int tegra_xusb_init_context(struct tegra_xusb *tegra)
 	if (!tegra->context.ipfs)
 		return -ENOMEM;
 
-	tegra->context.fpci = devm_kcalloc(tegra->dev, soc->ipfs.num_offsets,
+	tegra->context.fpci = devm_kcalloc(tegra->dev, soc->fpci.num_offsets,
 					   sizeof(u32), GFP_KERNEL);
 	if (!tegra->context.fpci)
 		return -ENOMEM;
-- 
2.17.1


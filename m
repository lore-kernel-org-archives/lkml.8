Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FFC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D20B21582
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731086;
	bh=8cD1OddezbZiSb0fP44H5RhMKRNa676XV1toZF2upiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CD80WolzeIv6ZfHhR/On+wc7IdBjdAhvuKNHRHSQjO/CSmiXMtXOEj6PNjuwv566C
	 fM2mAcjgRB3Sm2RLd0msLoqUb/iqhRyS3RTJGeUT1/YYvVV8USREak91cABwTGVG2K
	 Y6eB9JBprXya1fsA2JSJ1WZ9glMLZA/qo+sCUosY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgDXMYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgDXMYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E8A21582;
        Fri, 24 Apr 2020 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731080;
        bh=8cD1OddezbZiSb0fP44H5RhMKRNa676XV1toZF2upiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaTWhBDbk7tmdlVo9a/yaBHFscL4ypva08V9i7VG7goPhIZsR5BOtgHCYdtPN30mk
         jQP5bQnq02lTeZJaEihbaF2R+S73Gm5b+w2uhjKJ+YlrWHzu1TlynjgfuxMPmqcyxd
         tGkZS2ZO5Or55yiaEvkMWueEzp90jATeibV+5FfY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 17/21] net: stmmac: dwmac-sunxi: Provide TX and RX fifo sizes
Date:   Fri, 24 Apr 2020 08:24:15 -0400
Message-Id: <20200424122419.10648-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122419.10648-1-sashal@kernel.org>
References: <20200424122419.10648-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 806fd188ce2a4f8b587e83e73c478e6484fbfa55 ]

After commit bfcb813203e619a8960a819bf533ad2a108d8105 ("net: dsa:
configure the MTU for switch ports") my Lamobo R1 platform which uses
an allwinner,sun7i-a20-gmac compatible Ethernet MAC started to fail
by rejecting a MTU of 1536. The reason for that is that the DMA
capabilities are not readable on this version of the IP, and there
is also no 'tx-fifo-depth' property being provided in Device Tree. The
property is documented as optional, and is not provided.

Chen-Yu indicated that the FIFO sizes are 4KB for TX and 16KB for RX, so
provide these values through platform data as an immediate fix until
various Device Tree sources get updated accordingly.

Fixes: eaf4fac47807 ("net: stmmac: Do not accept invalid MTU values")
Suggested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index fc1fa0f9f3387..57694eada9955 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -155,6 +155,8 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	plat_dat->init = sun7i_gmac_init;
 	plat_dat->exit = sun7i_gmac_exit;
 	plat_dat->fix_mac_speed = sun7i_fix_speed;
+	plat_dat->tx_fifo_size = 4096;
+	plat_dat->rx_fifo_size = 16384;
 
 	ret = sun7i_gmac_init(pdev, plat_dat->bsp_priv);
 	if (ret)
-- 
2.20.1


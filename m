Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D56C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08E7206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387303;
	bh=A9Tv8u29FsawK3F2if2yrPSaS5hKZ42lX00SUwbB9H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1W1MhbZIrHAobQ44Y/X5IyEUgQzfRNjuqHjgV9re7Xo3YL3lXi3gTc6uaESOHsrue
	 yFJf+9PFtTAuOH7VYRQeqBMS+VBrZMIayejT2Ub+b7s+DcbEYlI64IXBD0tz9tgcN0
	 zMKF0TIHGbfFAp9x4PJsAAw42CVaEQltREfE6Z3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgDTMzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgDTMqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B174206DD;
        Mon, 20 Apr 2020 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386763;
        bh=A9Tv8u29FsawK3F2if2yrPSaS5hKZ42lX00SUwbB9H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2fyJWCJXTqii201eTF6DmBXad1an6P6hOpLItS/BTckiVPV2HKMSLkmn2bSH3DJr
         7V6TlNbcdjTjwuPZxAHe8K2sT9lkGlfW5V80TgLvjSlpzBR2yXq2Uki03H0NUM8KhG
         n0IVjvuv3v29AfLXAxcFr5ibje98cBMSdPNhBVJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 17/60] net: stmmac: dwmac-sunxi: Provide TX and RX fifo sizes
Date:   Mon, 20 Apr 2020 14:38:55 +0200
Message-Id: <20200420121506.210368835@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -146,6 +146,8 @@ static int sun7i_gmac_probe(struct platf
 	plat_dat->init = sun7i_gmac_init;
 	plat_dat->exit = sun7i_gmac_exit;
 	plat_dat->fix_mac_speed = sun7i_fix_speed;
+	plat_dat->tx_fifo_size = 4096;
+	plat_dat->rx_fifo_size = 16384;
 
 	ret = sun7i_gmac_init(pdev, plat_dat->bsp_priv);
 	if (ret)



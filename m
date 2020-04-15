Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B5C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04CD20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954594;
	bh=evbnZiIFrAsIYXcCSJ9OBMYr3dZ/O+8OKQb8KFPAPjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSW0GwINqSGMQOwXN5cBATlUh2ixndekuWdBM6+fvtdSpa+kG1IHAf5jq5B2Z+sOT
	 qa5dswRxQhQFoGSlLk3NCArhnb0tku4p0o4uR0M+fcqjoTb2wQE+ZjjEeZ+RstfNa9
	 9aXnd80nVyU5aqDCKmZyg0Ejf/LN0RaeWhy91DEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370094AbgDOMnM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409025AbgDOLnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:43:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625A520737;
        Wed, 15 Apr 2020 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951019;
        bh=evbnZiIFrAsIYXcCSJ9OBMYr3dZ/O+8OKQb8KFPAPjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r17acMCGaANieS7CM0ePZPJFuuCkG17zsLrjjYDr3cO1XVayLC+FQ5ZwZgEPK5TYx
         Y2qBoEjAqI4dRfZgV5DqF0CIHaBvcRFfQ8kB1MMY76I39fwvQ4w4xs+mFXW3p3Logb
         myAq2MAIrmctM5BAQ4R7HEs1Z8KKN/iLcTSvFTnE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 060/106] net: stmmac: dwmac1000: fix out-of-bounds mac address reg setting
Date:   Wed, 15 Apr 2020 07:41:40 -0400
Message-Id: <20200415114226.13103-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 3e1221acf6a8f8595b5ce354bab4327a69d54d18 ]

Commit 9463c4455900 ("net: stmmac: dwmac1000: Clear unused address
entries") cleared the unused mac address entries, but introduced an
out-of bounds mac address register programming bug -- After setting
the secondary unicast mac addresses, the "reg" value has reached
netdev_uc_count() + 1, thus we should only clear address entries
if (addr < perfect_addr_number)

Fixes: 9463c4455900 ("net: stmmac: dwmac1000: Clear unused address entries")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 542784300620f..efc6ec1b8027c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -207,7 +207,7 @@ static void dwmac1000_set_filter(struct mac_device_info *hw,
 			reg++;
 		}
 
-		while (reg <= perfect_addr_number) {
+		while (reg < perfect_addr_number) {
 			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
 			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
 			reg++;
-- 
2.20.1


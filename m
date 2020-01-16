Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43DC24727
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196495;
	bh=sqN9Ia28wx00eEWZy/Rnbw2Pe3jh79jsaCmiTr1yRgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVEbbSo+C5CmChhizf7YFB6yD3eNlCZrPhNndNdFRiT3aRqIB5L/zFAHDYA/ldu85
	 TIV/LhJF8cwA/TJ7/owMfVEvX1stbmeRnMpPtdpTC84O6KLlRd++f44X0tXO8mhA47
	 tF0b+/cdrBS23CfMLPKnNkqUeicOQjpLJkcjYZs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405733AbgAPRle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393674AbgAPRkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C99C420684;
        Thu, 16 Jan 2020 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196444;
        bh=sqN9Ia28wx00eEWZy/Rnbw2Pe3jh79jsaCmiTr1yRgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fe+1XHfvoYKzPge4CU59RyEbdjgA/zw81HBzv/THFfB0swNARKsuAuDS6CfkiRosu
         oPb+dC6otTDYqWdqAn1vTAYffnnFrsOO9muOIYIeprAbpRNEuLz9TtIZl4CzDWYEIk
         EovAZujRvOJo4UI44AYbVesQziQPNAZbuNX60eJM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 207/251] net: ethernet: stmmac: Fix signedness bug in ipq806x_gmac_of_parse()
Date:   Thu, 16 Jan 2020 12:35:56 -0500
Message-Id: <20200116173641.22137-167-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 231042181dc9d6122c6faba64e99ccb25f13cc6c ]

The "gmac->phy_mode" variable is an enum and in this context GCC will
treat it as an unsigned int so the error handling will never be
triggered.

Fixes: b1c17215d718 ("stmmac: add ipq806x glue layer")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 866444b6c82f..11a4a81b0397 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -203,7 +203,7 @@ static int ipq806x_gmac_of_parse(struct ipq806x_gmac *gmac)
 	struct device *dev = &gmac->pdev->dev;
 
 	gmac->phy_mode = of_get_phy_mode(dev->of_node);
-	if (gmac->phy_mode < 0) {
+	if ((int)gmac->phy_mode < 0) {
 		dev_err(dev, "missing phy mode property\n");
 		return -EINVAL;
 	}
-- 
2.20.1


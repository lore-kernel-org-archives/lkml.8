Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4077AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A20621739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221403;
	bh=UiW39lYgdoZFJAbb1FpAYzUdP5r50q48I0pq1VDKp70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SnQ5b+f1QYD3L6MO1XjmhiWdvHzCC/nosi8AoH3bQqpO0j47ZM9WDckIAa9jz1ksF
	 t7zIqF5TBUORKTD1z8sHK7fuf25B9TjAux/XO/QLg5QfcfsG4tRWqJ5jZjCzNcBrlD
	 6XVtM/rvtYMhwVHUfRUPirvJSq9V3qjKlDmGAAgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgA1OXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgA1OXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C50C21739;
        Tue, 28 Jan 2020 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221395;
        bh=UiW39lYgdoZFJAbb1FpAYzUdP5r50q48I0pq1VDKp70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6RCkiMzwQtdPHi54ihiidCOOYTwfR/Xs8darqAqJ1xmB6sZGlLwqBq3ob5vo+b7g
         N0PFnPwdwH5iaZ0KUgj/JatE9PYoao7ZN43tFOt7IhxJ+RM2CIEt2q93gz29tecwbr
         zRLEfnvuVsLrZ0DUA6gfpVqCvUUudtXY+CjT1Pz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 207/271] net: ethernet: stmmac: Fix signedness bug in ipq806x_gmac_of_parse()
Date:   Tue, 28 Jan 2020 15:05:56 +0100
Message-Id: <20200128135907.958181762@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 866444b6c82fa..11a4a81b0397c 100644
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




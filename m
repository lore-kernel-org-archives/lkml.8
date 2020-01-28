Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02495C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C387521739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222114;
	bh=ZKlPAfO3zRjg3UAkTcvMoEsUrSwlOG/1XdwucKB2Sb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1soo6/l6SseFlDxNfMo7ZWFtTlXoYahxDBPOXtWK3Gr7D2ZWsxFi6jY22TYhLHo/s
	 TpyWWBrKi6pA7qRkfpB3d6oeWiBlogmrMg/mOtDNKmodEjx7WLEZOyzET7tDp+MUEV
	 /LRPTTcsmopwO/21Gk5FLyalYftm1DJE70qnN3LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA1OXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbgA1OXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B6221739;
        Tue, 28 Jan 2020 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221388;
        bh=ZKlPAfO3zRjg3UAkTcvMoEsUrSwlOG/1XdwucKB2Sb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X44YEhg5MV5GKdRBSWK+3XrC7yqGP1/j6D3PUX7EkR1OWamA7Co006GMmvHmwthsb
         hn/YSx421zPN5Zd7N3QSEp3X9ofZIOHPuDP3eQ8rW0boNb/JcFSRKjAmbvogjXkpaT
         PBjHuCM05lpSy0it88m/pqHsHOwcQQEyzb/3LR+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 205/271] net: stmmac: dwmac-meson8b: Fix signedness bug in probe
Date:   Tue, 28 Jan 2020 15:05:54 +0100
Message-Id: <20200128135907.815677243@linuxfoundation.org>
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

[ Upstream commit f10210517a2f37feea2edf85eb34c98977265c16 ]

The "dwmac->phy_mode" is an enum and in this context GCC treats it as
an unsigned int so the error handling is never triggered.

Fixes: 566e82516253 ("net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index f356a44bcb811..6704d3e0392dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -280,7 +280,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 
 	dwmac->pdev = pdev;
 	dwmac->phy_mode = of_get_phy_mode(pdev->dev.of_node);
-	if (dwmac->phy_mode < 0) {
+	if ((int)dwmac->phy_mode < 0) {
 		dev_err(&pdev->dev, "missing phy-mode property\n");
 		ret = -EINVAL;
 		goto err_remove_config_dt;
-- 
2.20.1




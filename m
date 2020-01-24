Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7604C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E7420709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860431;
	bh=hK+nGvHcKmIsVY5DsWGt2bj6J52pSTH0xYz9n7o4Fgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iYGEbSAlWhUb5kr7/DdM2WqmYkA+BbFLmbay1/AnngB7K7L62rA4c2VW3W4k1QncD
	 nRhrCsetOgxQSJkPZz0b5Cqp/4HobETfXBOHfNpLQWsTeJ2XA1108CP7LfxlF76v5A
	 4/EJyW59cFYOK8xCvOxa5UWePZO7gueVV+fFsw6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbgAXKHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgAXKHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:07:10 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FA7206F0;
        Fri, 24 Jan 2020 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860429;
        bh=hK+nGvHcKmIsVY5DsWGt2bj6J52pSTH0xYz9n7o4Fgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J97WIBCRYtKWFGGkVo8B7Ft34DchSBNrTKNSihg1Jf3Si+yWQ/ZX7lFGlx3LoLyUa
         /jK35fzbZ6QTo1z7sZYxF5CfMpwKcuR1RT/wjdFBCNe6rlueNPuHg23QMmLtPjPIQ0
         8vcPHYQLdS6GP5EpneC64EnCcMncG9R66TCWnHRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 311/343] net: stmmac: dwmac-meson8b: Fix signedness bug in probe
Date:   Fri, 24 Jan 2020 10:32:09 +0100
Message-Id: <20200124093000.801235812@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index 8be4b32544ef8..d71d3c1c85eed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -285,7 +285,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 
 	dwmac->pdev = pdev;
 	dwmac->phy_mode = of_get_phy_mode(pdev->dev.of_node);
-	if (dwmac->phy_mode < 0) {
+	if ((int)dwmac->phy_mode < 0) {
 		dev_err(&pdev->dev, "missing phy-mode property\n");
 		ret = -EINVAL;
 		goto err_remove_config_dt;
-- 
2.20.1




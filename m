Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0150C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF03322D0B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259872;
	bh=CkMZrcI/01t0Lt8pc/TKDR1bKE2fZRxd58+lX9RTrBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hY1Jeir1P7oLos8jDgcOwn61efyu4EIRNR8o7vggUAXVuiSdCZ1LgWqhWDOMpPAE
	 WpBKms1Pj1AQ6ot+tn3h4QUt72H0UYyr3eIiKaZJEmUtdCKAzS9Wq/nVHWWm2X+dmF
	 ruhJwLdoJFIaUc76Evps93cH4CHEvelJEU+JwW7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgGTPob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgGTPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:44:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD7C22CB3;
        Mon, 20 Jul 2020 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259866;
        bh=CkMZrcI/01t0Lt8pc/TKDR1bKE2fZRxd58+lX9RTrBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+eGuWAMGO3t+D1vVXKiHepikf/rD6u+vTrtjghd6JuYNMOebSwHHeaRuodpZxwAq
         U/atkyjaaFa93LBevjmI9YsixOpyNDKm90jFoT60EiU1N/2mBRmCbkjtH7+1OT5LEK
         nsR0m1rwZU+H92F8lnOfUt4Tk0nWKxI/ZeDYGqiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuanhua Han <chuanhua.han@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 004/125] spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ
Date:   Mon, 20 Jul 2020 17:35:43 +0200
Message-Id: <20200720152803.146031768@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhua Han <chuanhua.han@nxp.com>

[ Upstream commit 13aed23927414137a017ac2f7d567001f714293f ]

Some SoC share one irq number between DSPI controllers.
For example, on the LX2160 board, DSPI0 and DSPI1 share one irq number.
In this case, only one DSPI controller can register successfully,
and others will fail.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index baf5274485004..4402e531b1bfd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1027,8 +1027,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt, 0,
-			pdev->name, dspi);
+	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt,
+			       IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
 		goto out_clk_put;
-- 
2.25.1




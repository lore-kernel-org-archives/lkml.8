Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF4CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CE02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942971;
	bh=tPyHfWl8BlLb4l2Uoibi73YHYqzH6WdcwDwj4n4OQ5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HFgCTWIj/uZwceXmjQ5YXnEVhi3yZe7Y9bSX/SZBDrL21qwyqDlw4B8LDv+JbAv79
	 XvyK2oLsrHzuaApfvvoFOwJhjid41sEfEqiQeLC+mftg0AL9aFGITTO8VZ6Izv7BLp
	 WuAHVKc9wcFns0unKc2A+4BI8eZ6vuEqUG/j6ezU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbgFWUJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388282AbgFWUIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:08:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898112078A;
        Tue, 23 Jun 2020 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942933;
        bh=tPyHfWl8BlLb4l2Uoibi73YHYqzH6WdcwDwj4n4OQ5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVajWki2aVAeahwwuPjGlptCcC3QnOgXQM988/E/N5ijyuUhtD8Qck5QdH8w9Ps/a
         qwpNacuIm5NCUjJ7r1gpsWYmBVzU90Zlj7qUvmbxqwXjrSz8U88oqndRBxlCnqH+3S
         1cX9XtB/sYnx5imix8xaWUL3lJYTvGf30g/BQN3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Ujfalusi <peter.ujflausi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 192/477] ASoC: ti: omap-mcbsp: Fix an error handling path in asoc_mcbsp_probe()
Date:   Tue, 23 Jun 2020 21:53:09 +0200
Message-Id: <20200623195416.665149657@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 03990fd58d2b7c8f7d53e514ba9b8749fac260f9 ]

If an error occurs after the call to 'omap_mcbsp_init()', the reference to
'mcbsp->fclk' must be decremented, as already done in the remove function.

This can be achieved easily by using the devm_ variant of 'clk_get()'
when the reference is taken in 'omap_mcbsp_init()'

This fixes the leak in the probe and has the side effect to simplify both
the error handling path of 'omap_mcbsp_init()' and the remove function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Peter Ujfalusi <peter.ujflausi@ti.com>
Link: https://lore.kernel.org/r/20200512134325.252073-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/omap-mcbsp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 3d41ca2238d48..4f33ddb7b4419 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -686,7 +686,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp,
 						SNDRV_PCM_STREAM_CAPTURE);
 
-	mcbsp->fclk = clk_get(&pdev->dev, "fck");
+	mcbsp->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
 		ret = PTR_ERR(mcbsp->fclk);
 		dev_err(mcbsp->dev, "unable to get fck: %d\n", ret);
@@ -711,7 +711,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 		if (ret) {
 			dev_err(mcbsp->dev,
 				"Unable to create additional controls\n");
-			goto err_thres;
+			return ret;
 		}
 	}
 
@@ -724,8 +724,6 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 err_st:
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
-err_thres:
-	clk_put(mcbsp->fclk);
 	return ret;
 }
 
@@ -1442,8 +1440,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 
 	omap_mcbsp_st_cleanup(pdev);
 
-	clk_put(mcbsp->fclk);
-
 	return 0;
 }
 
-- 
2.25.1




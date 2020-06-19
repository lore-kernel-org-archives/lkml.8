Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D599C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F10921707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584064;
	bh=sEyPBX/2ABg1iOUO8DjDGTuDa2o2eCIGcPiRsVtlttI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sxk39PnVCd5cdLVxRlXu4kU3fiedZVtR81nX2d+wGw0P0ttqz3jqOo/BijbTUpdY0
	 enIWzPouyQj/cvzttwlY2FrUT9i1Ij3FlhAndJCVn063UJFckzgKYRFbFIMULyObtJ
	 alIZO7+/J7KzehUSyzI/s452G713buEWr1uSmdZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394899AbgFSQ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbgFSOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C68206F7;
        Fri, 19 Jun 2020 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578541;
        bh=sEyPBX/2ABg1iOUO8DjDGTuDa2o2eCIGcPiRsVtlttI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBGlovdBSBoMPSpovWTP92NtIl6jEVzb3OTYjf7Xp7x9D2Emo2RApxEmbCtVxpTXj
         BbsECMDY3aOPjocsn5NE6fk3CBlEqwKG80f/aXqUqvFKKTfyl6EfY6HhLWP4jyAjmS
         +Kouc8nizD2WVKA06k/eWoP3PINT6CtxdoM3X/48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/267] spi: pxa2xx: Balance runtime PM enable/disable on error
Date:   Fri, 19 Jun 2020 16:30:47 +0200
Message-Id: <20200619141651.852981946@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 1274204542f683e1d8491ebe9cc86284d5a8ebcc ]

Don't undo the PM initialization if we error out before we managed to
initialize it. The call to pm_runtime_disable() without being preceded
by pm_runtime_enable() would disturb the balance of the Force.

In practice, this happens if we fail to allocate any of the GPIOS ("cs",
"ready") due to -EPROBE_DEFER because we're getting probled before the
GPIO driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Link: https://lore.kernel.org/r/20190719122713.3444318-1-lkundrak@v3.sk
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d6c30bd1583f..6551188fea23 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1742,14 +1742,16 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	status = spi_register_controller(master);
 	if (status != 0) {
 		dev_err(&pdev->dev, "problem registering spi master\n");
-		goto out_error_clock_enabled;
+		goto out_error_pm_runtime_enabled;
 	}
 
 	return status;
 
-out_error_clock_enabled:
+out_error_pm_runtime_enabled:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
 
 out_error_dma_irq_alloc:
-- 
2.25.1




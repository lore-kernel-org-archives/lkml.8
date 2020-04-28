Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468EC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E5D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098954;
	bh=PMTvBFQ0x9YqKY+5Qb8S07kDaFrBmGmU4R7NP/CG0k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLA4kh8/tXfVnUdYGxqbvkoG1BvR9pQhYVAJRSYpg0VRL2mvfuHCFHBTC6t3ChqQU
	 ZaUYtUBPw1Xq3qJMS/rgUwlz1XMmSCGAPSov+S64TRKKlCHkfR5awdfJxf8RvRVv38
	 rmA0xCzaZ7pt+IA7x/zAn+EP7bBMCqrjhd0t50dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgD1Sfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbgD1Sfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BCB208E0;
        Tue, 28 Apr 2020 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098949;
        bh=PMTvBFQ0x9YqKY+5Qb8S07kDaFrBmGmU4R7NP/CG0k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySz8PgIs9jpmBVFXwQNSMKLk1tAO7tl32LrNl43L/ljcPayXKueWFE7DeD2WIjZJw
         OyliSnVj3vvT9eNXe6nOVjp/YWN79Xa5JZdo6UWfX9fwiVro6Odp23/k2K03JTId6C
         C+pM0czU1xTve28U5Iyn+TZB8qpJfmDZZp3rHW+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/168] pwm: renesas-tpu: Fix late Runtime PM enablement
Date:   Tue, 28 Apr 2020 20:23:29 +0200
Message-Id: <20200428182236.151002597@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d5a3c7a4536e1329a758e14340efd0e65252bd3d ]

Runtime PM should be enabled before calling pwmchip_add(), as PWM users
can appear immediately after the PWM chip has been added.
Likewise, Runtime PM should always be disabled after the removal of the
PWM chip, even if the latter failed.

Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4a855a21b782d..8032acc84161a 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -415,16 +415,17 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->chip.base = -1;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = pwmchip_add(&tpu->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip\n");
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 
 	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
 
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
@@ -434,12 +435,10 @@ static int tpu_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pwmchip_remove(&tpu->chip);
-	if (ret)
-		return ret;
 
 	pm_runtime_disable(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.20.1




Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EFC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949D2208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339921;
	bh=S5579T0/eEWJ0+afvsFWAkNck1Ara5B0uHZdI68kixg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmmPDJsfjk5+/iJgNmAbU9oPc1/DwUvpJ+eSbw66ewW6SuPKCcqvvkwmLIAzAV/bG
	 OxsSd/nTWbyXrgBg+WlNbXVKkcCCFqgNYUZsKrJKxmvWXsuG26THYVBxeWldYBwAyB
	 7poUODF9o/Fiykc5VgdqBQwNna6Qrk/mV3zk0QR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgEANcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgEANb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:31:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3755208C3;
        Fri,  1 May 2020 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339918;
        bh=S5579T0/eEWJ0+afvsFWAkNck1Ara5B0uHZdI68kixg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krVMtoko2xBRh0Vc+NvZRmmYot6k1GmyTiVo/IuLy5cz6gTrCWQ5bfEH0k6a0R9IX
         sbWCIYNEO9Axfve76s2ryIgbo4+Zmqs1BnrkaUfAUMZL3nYlU+fWV/EtqY0CcdIFgG
         H9PxZbXUKzVszC+aR88ODKyEecVFMTpYVirlOHxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 019/117] pwm: renesas-tpu: Fix late Runtime PM enablement
Date:   Fri,  1 May 2020 15:20:55 +0200
Message-Id: <20200501131547.328623167@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
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
index 29267d12fb4c9..9c7962f2f0aa4 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -423,16 +423,17 @@ static int tpu_probe(struct platform_device *pdev)
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
 
@@ -442,12 +443,10 @@ static int tpu_remove(struct platform_device *pdev)
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




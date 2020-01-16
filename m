Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC872051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195015;
	bh=QFwPIGYW7jqbTdUHd0X1/G46FyHGNJE8eX12vRwYplU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mi5TNYorn8bwB4a1k+ppPaO3nmxtcvo1a8dfHCuAmlWa9TOujD2k56Ul9Co+4l7Ep
	 1Tt+kf6IvjLDKvLsVakJfe62x87SEok0nEzCzVMdPLlRvFGCGs34LvvE5nWe18Ey1x
	 tgFrdLlx9B5HkLZ5Va7kW4QAWXWKB7Y7jsCjM8Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391129AbgAPRQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390904AbgAPROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1522469F;
        Thu, 16 Jan 2020 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194841;
        bh=QFwPIGYW7jqbTdUHd0X1/G46FyHGNJE8eX12vRwYplU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMxqmjVU/4EW5t0dMOS2Vs5ovOoFPMKs93vNP7afFqQ8gziQvn7oT84Xz9o/pww+t
         WbmuQobw+zxTlusflu7ZkIET7aDqh2MQiQPUZ9TH+JAq+GXCOkfwW0G5Pojr76/LSI
         u1RZ0I6TcdlZSKmiBKQ69Rwi6eYXWjV29PPHuYFg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 640/671] rtc: brcmstb-waketimer: add missed clk_disable_unprepare
Date:   Thu, 16 Jan 2020 12:04:38 -0500
Message-Id: <20200116170509.12787-377-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 94303f8930ed78aea0f189b703c9d79fff9555d7 ]

This driver forgets to disable and unprepare clock when remove.
Add a call to clk_disable_unprepare to fix it.

Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20191105160043.20018-1-hslester96@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index f4010a75f2be..1abc8397850a 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -287,6 +287,7 @@ static int brcmstb_waketmr_remove(struct platform_device *pdev)
 	struct brcmstb_waketmr *timer = dev_get_drvdata(&pdev->dev);
 
 	unregister_reboot_notifier(&timer->reboot_notifier);
+	clk_disable_unprepare(timer->clk);
 
 	return 0;
 }
-- 
2.20.1


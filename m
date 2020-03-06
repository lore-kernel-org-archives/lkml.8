Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E2EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2421739
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCFNQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:16:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43101 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCFNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:16:36 -0500
Received: from localhost (lfbn-lyo-1-16-97.w86-202.abo.wanadoo.fr [86.202.111.97])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 721D124000D;
        Fri,  6 Mar 2020 13:16:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] rtc: fsl-ftm-alarm: allow COMPILE_TEST
Date:   Fri,  6 Mar 2020 14:16:28 +0100
Message-Id: <20200306131629.18837-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building building the driver with COMPILE_TEST.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index acaf6f98b54e..777047620ec7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1334,7 +1334,7 @@ config RTC_DRV_IMXDI
 
 config RTC_DRV_FSL_FTM_ALARM
 	tristate "Freescale FlexTimer alarm timer"
-	depends on ARCH_LAYERSCAPE || SOC_LS1021A
+	depends on ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST
 	help
 	   For the FlexTimer in LS1012A, LS1021A, LS1028A, LS1043A, LS1046A,
 	   LS1088A, LS208xA, we can use FTM as the wakeup source.
-- 
2.24.1


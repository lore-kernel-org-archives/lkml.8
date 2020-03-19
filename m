Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26354C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C0320BED
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCSOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:37:21 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:54503 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbgCSOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:37:21 -0400
X-Greylist: delayed 1677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 10:37:20 EDT
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:40148 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1jEvrM-0004AC-Nt; Thu, 19 Mar 2020 15:09:20 +0100
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     heiko.stuebner@theobroma-systems.com,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: rk-inno-usb2: Decrease verbosity of repeating log.
Date:   Thu, 19 Mar 2020 15:08:52 +0100
Message-Id: <20200319140852.27636-1-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy-rockchip-inno-usb2 logs the message

  "phy-ff2c0000.syscon:usb2-phy@100.2: charger = INVALID_CHARGER"

constantly with a frequency of about 1 Hz and a verbosity level
of INFO. As this is clearly annoying, this patch decreases
the log level to DEBUG.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 680cc0c8825c..a84e9f027fc4 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -763,7 +763,7 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		/* put the controller in normal mode */
 		property_enable(base, &rphy->phy_cfg->chg_det.opmode, true);
 		rockchip_usb2phy_otg_sm_work(&rport->otg_sm_work.work);
-		dev_info(&rport->phy->dev, "charger = %s\n",
+		dev_dbg(&rport->phy->dev, "charger = %s\n",
 			 chg_to_string(rphy->chg_type));
 		return;
 	default:
-- 
2.20.1


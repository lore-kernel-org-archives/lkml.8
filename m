Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E5C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B0B2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409867;
	bh=bzJX7PYVkASWHqjAYN30b4sZoLH8MdDr3I91jheyyO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rdnQm9qXJGq2W9dDiY/e94RT46ZrH0z6fYgLkWxVCTfM5VgwjRs2yz3pVmxCVW7zi
	 3TEBiT0jR+GXPRxHy/VvKfTRSpo2Bzmb5hkHOG6jqbDGep4yew87TeAgjJ1DiHgqN2
	 ivn1OnLfoJhrzwZzmuoYfoNHOeH9OXxzgiCHxjQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgA3So0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730532AbgA3SoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:44:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7D2214DB;
        Thu, 30 Jan 2020 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409861;
        bh=bzJX7PYVkASWHqjAYN30b4sZoLH8MdDr3I91jheyyO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D54IlUGM+2uF0EGWFzJwJpaj5D57LmlBAZTNy4bDQ7n3GAo7rsoq234DqdMFktb9l
         GWuKodKM6ci7DXLpX06tFHp/vc+SIoLH2tXb+H2c/u9n2EvzgqaoKtNPCRjpPifcNi
         zufIoDb8UfM6ZGGCwF4Z/bmZv8hdE2URHI+C4BO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Bin Liu <b-liu@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/110] usb: musb: jz4740: Silence error if code is -EPROBE_DEFER
Date:   Thu, 30 Jan 2020 19:38:39 +0100
Message-Id: <20200130183622.317918205@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit ce03cbcb4b4fd2a3817f32366001f1ca45d213b8 ]

Avoid printing any error message if the error code is -EPROBE_DEFER.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20191216162432.1256-1-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/jz4740.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 5261f8dfedecd..e3b8c84ccdb80 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -75,14 +75,17 @@ static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
 static int jz4740_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller->parent;
+	int err;
 
 	if (dev->of_node)
 		musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
 	else
 		musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(musb->xceiv)) {
-		dev_err(dev, "No transceiver configured\n");
-		return PTR_ERR(musb->xceiv);
+		err = PTR_ERR(musb->xceiv);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "No transceiver configured: %d", err);
+		return err;
 	}
 
 	/* Silicon does not implement ConfigData register.
-- 
2.20.1




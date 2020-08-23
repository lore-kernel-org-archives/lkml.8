Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF8AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA16206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8gVKich"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHWWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgHWWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3860C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so7469708ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kGnLJUNpBPhiaEEabiVCH173KisHHa7nsUJuR5EZNc=;
        b=d8gVKichS3uwl07tQAk/PML88vkECqchouuvxyA8D45XvBAk5IiBWuiw+9TIN04y0d
         eHsIrDKRgMOZWV+9agzRPk5OlWGG0ChDLdD6vhRpHC8nVesofwo6TCa5Oez8Eosbs+Vg
         vrLstumMPI29BhFU2iv29NVY9sf2hs7S/OjOEHncS2LZlxtMws02rM7c6VQzSbJoOTqY
         mPt3O04PVBgT0YhXnrUnCDhJmavmw4h4wDC4QbE9TyyMGWrcddhqBKWoFyP1H/mSRUuz
         ZHfgQx1zoRA1GMxr8iZeJ9zB8XJKTYjEkcjqou0QmyVMZG62sdXSXLbyxP3HD2ph+t5g
         9H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kGnLJUNpBPhiaEEabiVCH173KisHHa7nsUJuR5EZNc=;
        b=FQrSUXI+uJR57DDNFUkLNHOx1ElPBZ2PxSCPho/sT3mBZg1uvr401tgJrPiG/m9wrF
         b2J1e1hyCsVcEAQiRGdVfAME6/S6TP7ykXueaMs9igk5xStLYB4CrbSt3ksFRW1wC2q3
         68gHSiWbjf8+8+OODQGtkZX8iZCpT0PaS6xksDTQICXZzeHy3MOViP7ss9gSr6PSgtPD
         J5nrlNjRcikmF2oWvRW4vMVq/8RKtMlml4k+xsWtr3VA/+VECJeNhUNjcScWENKCp19T
         AOo9dQt3nbn1BuIpFplzO9HcURJpYOzyC62j3SRE2ZeIg99UONNgJZpIULPNbY150cGD
         aJgw==
X-Gm-Message-State: AOAM531KVwRcNsLwa0mFIM1N0pHKgbyLQAiFFWBMBt2c4w8E82Zg9uDV
        59W64mKypPbvLToYSVZxjYQ=
X-Google-Smtp-Source: ABdhPJx6ZZrN5Zo7rxiLLQUeYK8np3Dcd3lxRmGN0M9+Aa67NisEkYUYHCgkxmg5yZxq3kAimGgUsg==
X-Received: by 2002:a2e:9057:: with SMTP id n23mr1209425ljg.445.1598220038364;
        Sun, 23 Aug 2020 15:00:38 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:37 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/8] phy: fsl-imx8mq-usb: Constify imx8mq_usb_phy_ops
Date:   Mon, 24 Aug 2020 00:00:19 +0200
Message-Id: <20200823220025.17588-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
References: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage is to pass its address to devm_phy_create() which takes a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index 0c4833da7be0..0dcca39649d2 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -76,7 +76,7 @@ static int imx8mq_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static struct phy_ops imx8mq_usb_phy_ops = {
+static const struct phy_ops imx8mq_usb_phy_ops = {
 	.init		= imx8mq_usb_phy_init,
 	.power_on	= imx8mq_phy_power_on,
 	.power_off	= imx8mq_phy_power_off,
-- 
2.28.0


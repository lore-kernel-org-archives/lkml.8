Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB8AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692AF24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220944;
	bh=0oVP3Gtxn56bkWF/CM3qCTUFDAt16nb1JTB61t2pP9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BgXYKlA/T4BF0L1cGF4cWap4FQIwdfeTM72aFXPAoIhE5dU+FUfqQT9mYmWwyigR+
	 K+wI28pIdFaDwycb7DiyitF7+jErqJiPVEBS6RQ1H7t4lBmTrB7IrTaLdXS4nVbP13
	 r7o5T7/Vsih9PioOBiO7aJ13+JTe9AgVSz0WADLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgA1OPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbgA1OPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:15:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82732468D;
        Tue, 28 Jan 2020 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220940;
        bh=0oVP3Gtxn56bkWF/CM3qCTUFDAt16nb1JTB61t2pP9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAUNogBBBKNVRrS2b/R2vJnNneZNc+ADJoUws5REaKcdiB2a7lhQKDtwILZKvyFiW
         udGBV7pkEZJkzRKNHfMlhZb374s8tELNlbZSq7oYwEX7KZ+ck0Mof6gNDIcWOXLWsg
         MKdu2W+XWuMiaS5iEFhegyQZwNf3P13axxFlztzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 024/271] pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
Date:   Tue, 28 Jan 2020 15:02:53 +0100
Message-Id: <20200128135854.470438944@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 4d374bacd7c9665179f9752a52d5d602c45d8190 ]

The IP10[5:3] field in Peripheral Function Select Register 10 has a
width of 3 bits, i.e. it allows programming one out of 8 different
configurations.
However, 9 values are provided instead of 8, overflowing into the
subsequent field in the register, and thus breaking the configuration of
the latter.

Fix this by dropping a bogus zero value.

Fixes: ac1ebc2190f575fc ("sh-pfc: Add sh7734 pinmux support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 05ccb27f77818..c691e5e9d9dea 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2231,7 +2231,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_LCD_CL1_B, 0, 0,
 	    /* IP10_5_3 [3] */
 		FN_SSI_WS23, FN_VI1_5_B, FN_TX1_D, FN_HSCK0_C, FN_FALE_B,
-		FN_LCD_DON_B, 0, 0, 0,
+		FN_LCD_DON_B, 0, 0,
 	    /* IP10_2_0 [3] */
 		FN_SSI_SCK23, FN_VI1_4_B, FN_RX1_D, FN_FCLE_B,
 		FN_LCD_DATA15_B, 0, 0, 0 }
-- 
2.20.1




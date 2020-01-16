Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30A206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202004;
	bh=rTDm/veJoLoQMJHrPCBBDxWNnrNUsb4DdzTNHkeOL3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2T6BDsI3z+ioc+ZDeTsLVOB6L1YMCutaL5WRrTDSUPmD/FfudDJa+FS+m5zQTTgi
	 p9MGK3l2twD2Swdopgw5pv8WMcOyYuHbrJv1Kw2HVRWp8cEbz3MK8m7LUjjC8szDd+
	 /ZkT1bSccW+zO4XjgrzZXrkEUi3A/EN+Q7lXF93c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437425AbgAPTNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgAPQ5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE2721D56;
        Thu, 16 Jan 2020 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193819;
        bh=rTDm/veJoLoQMJHrPCBBDxWNnrNUsb4DdzTNHkeOL3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNJ/nwXwffK5/nq8vtxUXBVk8UK/BW2J2WUgXTOxoe1N6d+qCPyKypVnpepXR1qM7
         iCm8mL3gU6wQzuYK4qTPS3mbiHbdpdDu7ZOJ4Oy/MekDLkKRFOyIj/FbhZPWAziFrb
         2zUejo8wDkRtwFM/nwMmYH20P8YhIWceehariz7Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 079/671] pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
Date:   Thu, 16 Jan 2020 11:45:10 -0500
Message-Id: <20200116165502.8838-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 05ccb27f7781..c691e5e9d9de 100644
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


Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEF9C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A40624683
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272247;
	bh=uTLnBEJERTGry/cuDv6VzwuoL0a2YHXZt5HbDHNk0wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLayeo2UxAalmlEye/lK8detyqOGiPP4+sAZu3V4x2tvTxz6LeE/NxghZ5m6lntRb
	 pj1g/jUpWUHfXNr0m4Jmdu31ELjTSNjetDsu4cex57BJwsnfb7okHRVqj1lvBa/ZhP
	 +iFfaLJcLG+EA+gVIA6oUmZiS1C5zcz8LbFTtrlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgBUIEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731578AbgBUIEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:04:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C410C20801;
        Fri, 21 Feb 2020 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272243;
        bh=uTLnBEJERTGry/cuDv6VzwuoL0a2YHXZt5HbDHNk0wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNVdrYtAZh7R9w7UVFTPg0RqyMY2wfH7kY6eoweFNRf1hJ3qndW9NCKIcKdsMOxKQ
         kidg2cDOD4rt/YILJf2c2yL42miKTTd/x5cGhkCdeGJfDO2Nr+NsPwMdg011Lj+OYf
         SbxWT19yfW6c+XI8iNill9K8327f5lZLJPWfHFtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/344] media: sun4i-csi: Fix data sampling polarity handling
Date:   Fri, 21 Feb 2020 08:37:16 +0100
Message-Id: <20200221072352.510854002@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit cf9e6d5dbdd56ef2aa72f28c806711c4293c8848 ]

The CLK_POL field specifies whether data is sampled on the falling or
rising edge of PCLK, not whether the data lines are active high or low.
Evidence of this can be found in the timing diagram labeled "horizontal
size setting and pixel clock timing".

Fix the setting by checking the correct flag, V4L2_MBUS_PCLK_SAMPLE_RISING.
While at it, reorder the three polarity flag checks so HSYNC and VSYNC
are grouped together.

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
index d6979e11a67b2..8b567d0f019bf 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
@@ -279,8 +279,8 @@ static int sun4i_csi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	       csi->regs + CSI_WIN_CTRL_H_REG);
 
 	hsync_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH);
-	pclk_pol = !!(bus->flags & V4L2_MBUS_DATA_ACTIVE_HIGH);
 	vsync_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH);
+	pclk_pol = !!(bus->flags & V4L2_MBUS_PCLK_SAMPLE_RISING);
 	writel(CSI_CFG_INPUT_FMT(csi_fmt->input) |
 	       CSI_CFG_OUTPUT_FMT(csi_fmt->output) |
 	       CSI_CFG_VSYNC_POL(vsync_pol) |
-- 
2.20.1




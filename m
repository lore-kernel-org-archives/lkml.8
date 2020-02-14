Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1AFC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79120873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704451;
	bh=uTLnBEJERTGry/cuDv6VzwuoL0a2YHXZt5HbDHNk0wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/1q1cpP8Hl5GQ6zlkKnvA0puPLOweowvRz/sTuZl4cCgSZ+EsVeG2VIjaAk/vr1Q
	 Nimx0Bjm3sMtvHVz155UhnpINaCzgq/NfrlQ9mQZWKraxWsvXDYurmW1Jl4hdRAcHm
	 YjsOgn7yr1mtKpiNQ3kqikrC/CxK4L5qoH4uuMQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgBNPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbgBNPtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D845024688;
        Fri, 14 Feb 2020 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695391;
        bh=uTLnBEJERTGry/cuDv6VzwuoL0a2YHXZt5HbDHNk0wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGG9NRVdZc1Cw6KDvKcnb2hVoAmgJeuGNkjJbf4YtW75YztctrtC9JpiNSW1xEOUi
         EcOJVYYxSANU+MBwWHK28gvAnm9QVgzNB+NMQouy3qrD07l9ik4RPq3GjnmCNca53o
         AHwxoCiq50DPWy11JXYON44+a3TBWR/8fGR6PRg0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 044/542] media: sun4i-csi: Fix data sampling polarity handling
Date:   Fri, 14 Feb 2020 10:40:36 -0500
Message-Id: <20200214154854.6746-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


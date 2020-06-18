Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B68CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0F62222A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445290;
	bh=+bbfq/lOHEvGvceV96zCfrP87tJ+zhiGJCMnu/R7Jj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K6oxHlfEEchL4AqvqbU+f7QEpPQDqi/bicOSD6GchjXncgDMD63xiLQm8tYJfBgpV
	 rfGgSS5fnAauIHjA7gDPcDZgd/T92SMiiJltNxHzX5w9Oe2613eAnWdNq0/cg77rg2
	 YLp9qojjy9tNEq8Q4sho/jtFK54djABu56QNwjZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbgFRByt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbgFRBZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A462088E;
        Thu, 18 Jun 2020 01:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443553;
        bh=+bbfq/lOHEvGvceV96zCfrP87tJ+zhiGJCMnu/R7Jj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlxnjJrl3bjircbiSOcl3cxwp4kDodipNAf+jROLhfVdov3If8QX+xmuqqxqCYKJx
         sqewsxJwEUUDGXI7GKXruf9j8hKPqfSdrQ+PnTh/G7iuPB363AaFDwIxb+xN+Rx1SY
         +77Pg00vHSgBdZaT6j/ILAi0DnwS59lhxbaqe82g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 168/172] drm/sun4i: hdmi ddc clk: Fix size of m divider
Date:   Wed, 17 Jun 2020 21:22:14 -0400
Message-Id: <20200618012218.607130-168-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit 54e1e06bcf1cf6e7ac3f86daa5f7454add24b494 ]

m divider in DDC clock register is 4 bits wide. Fix that.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200413095457.1176754-1-jernej.skrabec@siol.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h         | 2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index b685ee11623d..a13e14dd7746 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -152,7 +152,7 @@
 #define SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE	3
 
 #define SUN4I_HDMI_DDC_CLK_REG		0x528
-#define SUN4I_HDMI_DDC_CLK_M(m)			(((m) & 0x7) << 3)
+#define SUN4I_HDMI_DDC_CLK_M(m)			(((m) & 0xf) << 3)
 #define SUN4I_HDMI_DDC_CLK_N(n)			((n) & 0x7)
 
 #define SUN4I_HDMI_DDC_LINE_CTRL_REG	0x540
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index e826da34e919..14b6762567fb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -37,7 +37,7 @@ static unsigned long sun4i_ddc_calc_divider(unsigned long rate,
 	unsigned long best_rate = 0;
 	u8 best_m = 0, best_n = 0, _m, _n;
 
-	for (_m = 0; _m < 8; _m++) {
+	for (_m = 0; _m < 16; _m++) {
 		for (_n = 0; _n < 8; _n++) {
 			unsigned long tmp_rate;
 
-- 
2.25.1


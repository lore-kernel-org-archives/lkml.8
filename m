Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DADC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA64E24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222540;
	bh=3FfHFvlKqbufPIlxQrPOqxE8ndyp//Hc9cm6l61ka98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvmFRghaOtm8qbHxhyL0LHcMDaqf2h1Hk4OwpXiKdKHJI+8Sox3LXFo98N1Bzv2R0
	 CaWc7Cnvx1IRFtd4GI0MkzV4kRy/mMkOsAWz30DkQsz27acpkahnde9/0D8bVaODLt
	 s0+nqLmjo80NRp1Nr2wREbj8YhAwRpGWc+XulSoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgA1ONV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgA1ONM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:13:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E9F24688;
        Tue, 28 Jan 2020 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220791;
        bh=3FfHFvlKqbufPIlxQrPOqxE8ndyp//Hc9cm6l61ka98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSMnOtbpbMKwC+WoFuTVOMFVMOlSr6v3vjErIDqjcIbXLJrFlGaE3plF04Np0WMlj
         T2nEhM1NF6T7xbFZwzB++lS+pIa9siA5Fyllpd4OZqlZls/Nb41RA5vUMMMU7nBtSF
         eZGdnNaObqs5Mdp969F+qrrgGmk+uWuOEObcuAp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hai Li <hali@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sean Paul <sean@poorly.run>, Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 147/183] drm/msm/dsi: Implement reset correctly
Date:   Tue, 28 Jan 2020 15:06:06 +0100
Message-Id: <20200128135844.431777653@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit 78e31c42261779a01bc73472d0f65f15378e9de3 ]

On msm8998, vblank timeouts are observed because the DSI controller is not
reset properly, which ends up stalling the MDP.  This is because the reset
logic is not correct per the hardware documentation.

The documentation states that after asserting reset, software should wait
some time (no indication of how long), or poll the status register until it
returns 0 before deasserting reset.

wmb() is insufficient for this purpose since it just ensures ordering, not
timing between writes.  Since asserting and deasserting reset occurs on the
same register, ordering is already guaranteed by the architecture, making
the wmb extraneous.

Since we would define a timeout for polling the status register to avoid a
possible infinite loop, lets just use a static delay of 20 ms, since 16.666
ms is the time available to process one frame at 60 fps.

Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")
Cc: Hai Li <hali@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Reviewed-by: Sean Paul <sean@poorly.run>
[seanpaul renamed RESET_DELAY to DSI_RESET_TOGGLE_DELAY_MS]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20191011133939.16551-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 4c49868efcda2..12ddbbb531077 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -30,6 +30,8 @@
 #include "dsi.xml.h"
 #include "dsi_cfg.h"
 
+#define DSI_RESET_TOGGLE_DELAY_MS 20
+
 static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
 {
 	u32 ver;
@@ -764,7 +766,7 @@ static void dsi_sw_reset(struct msm_dsi_host *msm_host)
 	wmb(); /* clocks need to be enabled before reset */
 
 	dsi_write(msm_host, REG_DSI_RESET, 1);
-	wmb(); /* make sure reset happen */
+	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
 	dsi_write(msm_host, REG_DSI_RESET, 0);
 }
 
@@ -1111,7 +1113,7 @@ static void dsi_sw_reset_restore(struct msm_dsi_host *msm_host)
 
 	/* dsi controller can only be reset while clocks are running */
 	dsi_write(msm_host, REG_DSI_RESET, 1);
-	wmb();	/* make sure reset happen */
+	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
 	dsi_write(msm_host, REG_DSI_RESET, 0);
 	wmb();	/* controller out of reset */
 	dsi_write(msm_host, REG_DSI_CTRL, data0);
-- 
2.20.1




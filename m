Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F115020709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860388;
	bh=HtL+lCOZsA0ZW34FVazRHijkWwrTjCjjW+sTlvrtEko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RIMAgeKjia4NzxReJGWGxXDLU9MOWsYYrjsN7YLoZQOtttOyCv70PYIZsv3J1R7JJ
	 g/EA2aROwlDTgoLmFasX5MXxf/06UoWrUMvvWgkm1C9bLnF8OVwXbNUUO0Nowf1hEW
	 yUMSolf8yMVqfDvRXx1I/h6Uc/+9+ZiBvFjho0Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbgAXKG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388684AbgAXKG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:06:26 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A8720709;
        Fri, 24 Jan 2020 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860385;
        bh=HtL+lCOZsA0ZW34FVazRHijkWwrTjCjjW+sTlvrtEko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+kLQhx6ASpFoVSPDB6GsgK1mfaEIL9PHSdOGoeHcteXCS9qOxnDcBOh6gDX5IqKa
         ZJ+hYUVtGW0V920jH0LjZmoly8HwSaKN0+I4z+Z1Pb39YmjhdL7AYBZLEEb2FCIQxu
         OGUWEEboycOXyIrXx6d07zW1LwSTeScOs+Dh9eyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hai Li <hali@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sean Paul <sean@poorly.run>, Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 325/343] drm/msm/dsi: Implement reset correctly
Date:   Fri, 24 Jan 2020 10:32:23 +0100
Message-Id: <20200124093002.523935510@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index a9a0b56f1fbc5..b9cb7c09e05a6 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -34,6 +34,8 @@
 #include "dsi_cfg.h"
 #include "msm_kms.h"
 
+#define DSI_RESET_TOGGLE_DELAY_MS 20
+
 static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
 {
 	u32 ver;
@@ -906,7 +908,7 @@ static void dsi_sw_reset(struct msm_dsi_host *msm_host)
 	wmb(); /* clocks need to be enabled before reset */
 
 	dsi_write(msm_host, REG_DSI_RESET, 1);
-	wmb(); /* make sure reset happen */
+	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
 	dsi_write(msm_host, REG_DSI_RESET, 0);
 }
 
@@ -1288,7 +1290,7 @@ static void dsi_sw_reset_restore(struct msm_dsi_host *msm_host)
 
 	/* dsi controller can only be reset while clocks are running */
 	dsi_write(msm_host, REG_DSI_RESET, 1);
-	wmb();	/* make sure reset happen */
+	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
 	dsi_write(msm_host, REG_DSI_RESET, 0);
 	wmb();	/* controller out of reset */
 	dsi_write(msm_host, REG_DSI_CTRL, data0);
-- 
2.20.1




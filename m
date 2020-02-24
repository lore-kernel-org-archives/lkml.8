Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA72084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBXRmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:42:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57708 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:42:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j6HkQ-0005M9-Pc; Mon, 24 Feb 2020 17:42:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] drm/tidss: fix spelling mistakes "bufer" and "requsted"
Date:   Mon, 24 Feb 2020 17:42:26 +0000
Message-Id: <20200224174226.387874-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in warning and debug messages.
Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Add spelling mistake fix for "requsted"

---
 drivers/gpu/drm/tidss/tidss_dispc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index eeb160dc047b..b3dc83d2f668 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1235,7 +1235,7 @@ int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 
 	if (dispc_pclk_diff(rate, new_rate) > 5)
 		dev_warn(dispc->dev,
-			 "vp%d: Clock rate %lu differs over 5%% from requsted %lu\n",
+			 "vp%d: Clock rate %lu differs over 5%% from requested %lu\n",
 			 hw_videoport, new_rate, rate);
 
 	dev_dbg(dispc->dev, "vp%d: new rate %lu Hz (requested %lu Hz)\n",
@@ -1699,7 +1699,7 @@ static int dispc_vid_calc_scaling(struct dispc_device *dispc,
 
 		if (sp->xinc > f->xinc_max) {
 			dev_dbg(dispc->dev,
-				"%s: Too wide input bufer %u > %u\n", __func__,
+				"%s: Too wide input buffer %u > %u\n", __func__,
 				state->src_w >> 16, in_width_max * f->xinc_max);
 			return -EINVAL;
 		}
-- 
2.25.0


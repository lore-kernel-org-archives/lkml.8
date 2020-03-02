Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D89C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B75321775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCBTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:13:51 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50580 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbgCBTNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:13:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 26E61FB06;
        Mon,  2 Mar 2020 20:13:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5R7glgRisUUl; Mon,  2 Mar 2020 20:13:40 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 930F04048D; Mon,  2 Mar 2020 20:13:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/etnaviv: Fix typo in comment
Date:   Mon,  2 Mar 2020 20:13:32 +0100
Message-Id: <a2f36aa20e749316d41303ddcabef064b035f99b.1583176306.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1583176306.git.agx@sigxcpu.org>
References: <cover.1583176306.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'is' instead of 'it' so it becomes a valid sentence and
spell 'resetting' correctly.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 80b99acea1c4..873d9103164d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -506,7 +506,7 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
 		/* read idle register. */
 		idle = gpu_read(gpu, VIVS_HI_IDLE_STATE);
 
-		/* try reseting again if FE it not idle */
+		/* try resetting again if FE is not idle */
 		if ((idle & VIVS_HI_IDLE_STATE_FE) == 0) {
 			dev_dbg(gpu->dev, "FE is not idle\n");
 			continue;
-- 
2.23.0


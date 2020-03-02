Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2038FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F5A20842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCBTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:13:55 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50568 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgCBTNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:13:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id ED0D5FB04;
        Mon,  2 Mar 2020 20:13:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OoMrX3WfUypl; Mon,  2 Mar 2020 20:13:41 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B2AE54048F; Mon,  2 Mar 2020 20:13:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/etnaviv: Warn when GPU doesn't idle fast enough
Date:   Mon,  2 Mar 2020 20:13:36 +0100
Message-Id: <d30bd6f4e063bc0df1fc6d608ea93c6e08f58104.1583176306.git.agx@sigxcpu.org>
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

If the GPU isn't idle after signalling pm_runtime_mark_last_busy() plus
waiting for the autosuspend delay there's likely something wrong with
the way we check idleness so warn about that.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index da24e433f82a..4fd16b8f8a7a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1824,8 +1824,11 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 	mask = gpu->idle_mask & ~(VIVS_HI_IDLE_STATE_FE |
 				  VIVS_HI_IDLE_STATE_MC);
 	idle = gpu_read(gpu, VIVS_HI_IDLE_STATE) & mask;
-	if (idle != mask)
+	if (idle != mask) {
+		dev_warn_ratelimited(dev, "GPU not yet idle, mask: 0x%08x\n",
+				     idle);
 		return -EBUSY;
+	}
 
 	return etnaviv_gpu_hw_suspend(gpu);
 }
-- 
2.23.0


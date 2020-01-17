Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C9C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15552072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbgAQCBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:01:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgAQCBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:01:14 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 26CDE1C1F5589BC9F48E;
        Fri, 17 Jan 2020 10:01:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 10:01:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <wambui.karugax@gmail.com>, <yuehaibing@huawei.com>,
        <sam@ravnborg.org>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/nv04/disp: remove set but not used variable 'width'
Date:   Fri, 17 Jan 2020 10:01:02 +0800
Message-ID: <20200117020102.56636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/nouveau/dispnv04/arb.c: In function nv04_calc_arb:
drivers/gpu/drm/nouveau/dispnv04/arb.c:56:21: warning:
 variable width set but not used [-Wunused-but-set-variable]

'width' is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
index f607a04..9d4a2d9 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
@@ -53,7 +53,7 @@ struct nv_sim_state {
 static void
 nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
 {
-	int pagemiss, cas, width, bpp;
+	int pagemiss, cas, bpp;
 	int nvclks, mclks, crtpagemiss;
 	int found, mclk_extra, mclk_loop, cbs, m1, p1;
 	int mclk_freq, pclk_freq, nvclk_freq;
@@ -65,7 +65,6 @@ nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
 	nvclk_freq = arb->nvclk_khz;
 	pagemiss = arb->mem_page_miss;
 	cas = arb->mem_latency;
-	width = arb->memory_width >> 6;
 	bpp = arb->bpp;
 	cbs = 128;
 
-- 
2.7.4



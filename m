Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5834C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938D521924
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646364;
	bh=q2qqNMSeIsDYPPv4a+c6GwdkoZeZjwHQHCscdU8oKUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LYK8jmTwZDJO9NCACN2Oh8AjxPJP0LRtAd2FjADywLm7haQf2NhlAxvn/uuWohSvU
	 DcDRxfrJkJZPjeCRoDloXdtTaUT3ZZfQ/5csUkFbuM+Dz45aHO5vPgklud805jcRCh
	 2UFhRlP1utEJbrCG1biDN6GQAAawIF+mdelHlKDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgDKXGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgDKXF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEEB215A4;
        Sat, 11 Apr 2020 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646359;
        bh=q2qqNMSeIsDYPPv4a+c6GwdkoZeZjwHQHCscdU8oKUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgPRGAfCEUi4HTTb4cHmm63qdODuoLqLy5RMgmDTKOsZYHItnfc1PX0WbeW5MlReJ
         xGI5q/14AaW4vSf65HrMarIGgLGFG8SDJdZ8z7fe8w8hLezGGCti/eHX9czRBp1IbJ
         RQOHI4vSCvtlnW4cxfltZfvNrtUQw3OYnA4NNdkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Machek <pavel@denx.de>, Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 105/149] drm/msm: fix leaks if initialization fails
Date:   Sat, 11 Apr 2020 19:03:02 -0400
Message-Id: <20200411230347.22371-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@denx.de>

[ Upstream commit 66be340f827554cb1c8a1ed7dea97920b4085af2 ]

We should free resources in unlikely case of allocation failure.

Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e4b750b0c2d3f..7d985f8865bef 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -444,8 +444,10 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	if (!dev->dma_parms) {
 		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
 					      GFP_KERNEL);
-		if (!dev->dma_parms)
-			return -ENOMEM;
+		if (!dev->dma_parms) {
+			ret = -ENOMEM;
+			goto err_msm_uninit;
+		}
 	}
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
-- 
2.20.1


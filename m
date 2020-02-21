Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0F4C35644
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6224656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271599;
	bh=uyTSEKzssiXTjw2/MDuQphK+UDTxkooeOKp7U8Y6QyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ql2sY8l3icPtyrQ8pbg0k9sEIIxBomgQtbKcMTf15LaJ9zPMVY92pa5r5dQwWAsv6
	 1UfT7ycyFmNMJf6pnEWNgx4dbz7EmsC5lr5B4848oOTM2oUPbreb4dIVmzzRUIqApA
	 uNW+f2vAs+YU2FBuo/7CGDA6Av8nScsbS5T0/ASc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgBUHxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbgBUHxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:53:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F92D24672;
        Fri, 21 Feb 2020 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271593;
        bh=uyTSEKzssiXTjw2/MDuQphK+UDTxkooeOKp7U8Y6QyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYV3ypphApIfE3voPqFeD9YDtOIA2sqPY06+eFjX2yWMeVd6MKwre2Ey9GE+WylCz
         xScNDKEzc3ywKgKtvcItuZoNeXC8JZigWtM4usDfgRLRap5Lu7snMhY8Z7hAIYHRVl
         AX1tW9jjU0tTi7n+f5FVfa5c/qxNeVOiW72+VVlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 224/399] drm/mediatek: Add gamma property according to hardware capability
Date:   Fri, 21 Feb 2020 08:39:09 +0100
Message-Id: <20200221072424.720313608@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

[ Upstream commit 4cebc1de506fa753301266a5a23bb21bca52ad3a ]

If there is no gamma function in the crtc
display path, don't add gamma property
for crtc

Fixes: 2f3f4dda747c ("drm/mediatek: Add gamma correction.")
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 4132cd114a037..c3f5111fd563f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -641,6 +641,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	int pipe = priv->num_pipes;
 	int ret;
 	int i;
+	uint gamma_lut_size = 0;
 
 	if (!path)
 		return 0;
@@ -691,6 +692,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		}
 
 		mtk_crtc->ddp_comp[i] = comp;
+
+		if (comp->funcs && comp->funcs->gamma_set)
+			gamma_lut_size = MTK_LUT_SIZE;
 	}
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
@@ -711,8 +715,10 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 				NULL, pipe);
 	if (ret < 0)
 		return ret;
-	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
-	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, false, MTK_LUT_SIZE);
+
+	if (gamma_lut_size)
+		drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
+	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, false, gamma_lut_size);
 	priv->num_pipes++;
 
 	return 0;
-- 
2.20.1




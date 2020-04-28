Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA17C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AD2206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgD1NR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:17:58 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:58153 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgD1NR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:17:58 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 8F1184829C3;
        Tue, 28 Apr 2020 21:17:55 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/meson: pm resume add return errno branch
Date:   Tue, 28 Apr 2020 06:17:47 -0700
Message-Id: <20200428131747.2099-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVMSU5CQkJDSElKTkhISVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSo6Kio*DDgrLE4BVk83MQgt
        KzYwCzpVSlVKTkNDS0xCQ0xOQ0lOVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUpKSjcG
X-HM-Tid: 0a71c0efd6a593bakuws8f1184829c3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_resump api did not handle drm_mode_config_helper_resume error.
This change add handle to return drm_mode_config_helper_resume`s
error number. This code logic is aligned with api pm_suspend.
After this change, the code maybe a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index b5f5eb7b4bb9..8c2e1b47e81a 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -412,9 +412,7 @@ static int __maybe_unused meson_drv_pm_resume(struct device *dev)
 	if (priv->afbcd.ops)
 		priv->afbcd.ops->init(priv);
 
-	drm_mode_config_helper_resume(priv->drm);
-
-	return 0;
+	return drm_mode_config_helper_resume(priv->drm);
 }
 
 static int compare_of(struct device *dev, void *data)
-- 
2.26.2


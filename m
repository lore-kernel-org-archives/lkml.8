Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B08206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200941;
	bh=2rpy/MMMrn6+0nPuWAz83Vpo/mL3rkWiZmO0V/DJzLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xiw3EVBeLAswn+qOQeJ1dv86IIzz1wj4O7u3mOvdGr5wde93vspuLUT/6o+XzOLZh
	 0QjO7RR8FsFviamwQ8Bc/yLPQsPpy7H8VuKc4sw9bEegksCNnrtGTtOhLfJ4JFqizR
	 KvghAsYxljeWtYxPO6cWIKYJusB3btm6dNNQ33hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbgAPRHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388691AbgAPRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F3D2087E;
        Thu, 16 Jan 2020 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194327;
        bh=2rpy/MMMrn6+0nPuWAz83Vpo/mL3rkWiZmO0V/DJzLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kG9O+YWIRmv+3gx+YVhUqsd/GVpBSZhg+RDoL1dglH9+OafK61gBiTaKM+lqHwQQA
         ROhzvS1/zRwDyCi+/Z5kTgD4V81qSJpw3twIqy915XGoYBUduJIvRvzHgIkZuJqLtT
         LPp79en7GBiU1ewtZYavS6to/ih6lcTVQPGhr73w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 275/671] drm/fb-helper: generic: Call drm_client_add() after setup is done
Date:   Thu, 16 Jan 2020 11:58:33 -0500
Message-Id: <20200116170509.12787-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noralf Trønnes <noralf@tronnes.org>

[ Upstream commit 6e3f17ee73f7e3c2ef0e2c8fd8624b2ece8ef2c9 ]

Hotplug can happen while drm_fbdev_generic_setup() is running so move
drm_client_add() call after setup is done to avoid
drm_fbdev_client_hotplug() running in two threads at the same time.

Fixes: 9060d7f49376 ("drm/fb-helper: Finish the generic fbdev emulation")
Cc: stable@vger.kernel.org
Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190401141358.25309-1-noralf@tronnes.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 1c87ad6667e7..da9a381d6b57 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3257,8 +3257,6 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 		return ret;
 	}
 
-	drm_client_add(&fb_helper->client);
-
 	if (!preferred_bpp)
 		preferred_bpp = dev->mode_config.preferred_depth;
 	if (!preferred_bpp)
@@ -3267,6 +3265,8 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 
 	drm_fbdev_client_hotplug(&fb_helper->client);
 
+	drm_client_add(&fb_helper->client);
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_fbdev_generic_setup);
-- 
2.20.1


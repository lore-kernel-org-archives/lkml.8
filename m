Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047D7C352B6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9985206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648786;
	bh=JVCRg00qyN38+Kp/WP5eK6VO6v1UbC+S0gqc9TyclDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PeQeo78a/vFNzCzl9e1cuiAFnXUmhpD1o796ugWVBRKNGUr9xsa0MsRhguUWRHCll
	 Bfl0yRfldA7QuluYI/2p5Yb9/Srbtjm32jJQ8RKwHyQJsW9ltMA6ifCK21OC3YWQU+
	 WZLaBFa3yysCJZdunVoBQL07pWp1CE8wwdOQ9KG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDKXFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgDKXFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B1D20708;
        Sat, 11 Apr 2020 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646319;
        bh=JVCRg00qyN38+Kp/WP5eK6VO6v1UbC+S0gqc9TyclDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONt+Lv5oCvVpUBj7Q6hLfeHCwk2nAhhUYfXx+/BVqJbZDixcxwI+PTW/Eecc4Cy/s
         /Slq8C08PxFjTmujUpmN8w3wiVnLPHPqHRUSYBOHCXraVOBAb6F/Q9tuMw2YL/i/VM
         zJlQ/eSiwvoVZ+FRWvPNw4kHitVSF/C3aTOQtmBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 074/149] drm/crc: Actually allow to change the crc source
Date:   Sat, 11 Apr 2020 19:02:31 -0400
Message-Id: <20200411230347.22371-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit 3cb6d8e5cf9811a62e27f366fd1c05f90310a8fd ]

Oops.

Fixes: 9edbf1fa600a ("drm: Add API for capturing frame CRCs")
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Emil Velikov <emil.velikov@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190821203835.18314-1-daniel.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index e22b812c4b802..5d67a41f7c3a8 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -372,7 +372,7 @@ void drm_debugfs_crtc_crc_add(struct drm_crtc *crtc)
 
 	crc_ent = debugfs_create_dir("crc", crtc->debugfs_entry);
 
-	debugfs_create_file("control", S_IRUGO, crc_ent, crtc,
+	debugfs_create_file("control", S_IRUGO | S_IWUSR, crc_ent, crtc,
 			    &drm_crtc_crc_control_fops);
 	debugfs_create_file("data", S_IRUGO, crc_ent, crtc,
 			    &drm_crtc_crc_data_fops);
-- 
2.20.1


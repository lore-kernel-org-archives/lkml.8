Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950E7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E092072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598028232;
	bh=RPyEA/kI9KUS4oMh1ysf1Jx+oNDxSmtIr2+ySLYBTQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDVei5PF37X2aK0AAcv1g7VsQQp/eeqp8OjtyrqKj8jlkfyBbMdnH+nmzbEj3/OQ5
	 kSpaxmPOY8BcwJdI1FnOGbCRX+yd7ZEBwTMXd1az+bselmlrpaYdY83PEbSmlLbCYw
	 BfZaHd4/aecVRvEgg7SmAq+f0MopZiLBrJwGQXlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHUQnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbgHUQUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4D322D00;
        Fri, 21 Aug 2020 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026789;
        bh=RPyEA/kI9KUS4oMh1ysf1Jx+oNDxSmtIr2+ySLYBTQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOvneARCpE1oR1gpiiW6p4LRYSrfcFXIMhXLOdLhJlYxMPNw0vWTTqsPYtcLJejA6
         l3KLdEDSgBhj4LD8bkZ4DYfKzGLMVZxJWOweqAQmjp+XbReOlNl41MzZm3kN27LsSq
         qXEnyKBlb4smwEB365Uc3MEcfln8RjpHk+aF7tmY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 08/26] drm/radeon: fix multiple reference count leak
Date:   Fri, 21 Aug 2020 12:19:19 -0400
Message-Id: <20200821161938.349246-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161938.349246-1-sashal@kernel.org>
References: <20200821161938.349246-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 6f2e8acdb48ed166b65d47837c31b177460491ec ]

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index efa875120071a..9e6c2be0cc7d4 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -892,8 +892,10 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (encoder) {
@@ -1038,8 +1040,10 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1176,8 +1180,10 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1260,8 +1266,10 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (radeon_connector->detected_hpd_without_ddc) {
@@ -1701,8 +1709,10 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
-- 
2.25.1


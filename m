Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E9720855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922192;
	bh=o4l7/CzR2RC+FJbDc3/jPbOByK3INs3SyymKtf/GbjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pL9korezoRG8TTQAqBGY2ApKf7z57eCaS+auHqY7VFdbCxT7FtkB9xmT3qXhuhnuy
	 oPlwM46dBxxieUPHa5M3tcRCw0Q9MFt36KZcwKp2fXZdLOW5FgtlPhOHML9k7xnWhq
	 hytGv8acvTxPY0sPWpwuZ9KpKsIRY1gpDgcSR2Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgHTLQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbgHTKIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:08:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4FF2075E;
        Thu, 20 Aug 2020 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918127;
        bh=o4l7/CzR2RC+FJbDc3/jPbOByK3INs3SyymKtf/GbjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQtjgoeqmGvcfNLxEeTcvYSe8oYdDZKR80I+4mdtGYbMrLxYCjkRGbqf43dslk5Ud
         /fsyRu7jexKBOmMGgJmaXpng5Y7ifcQvXrgjC8KrEdKMo0ZDs4zWmjiA9UPpNfHfUV
         KQZnPlFGoblA7qpaFLDdwgw6JICpxsysIX5dTLA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/228] drm/radeon: Fix reference count leaks caused by pm_runtime_get_sync
Date:   Thu, 20 Aug 2020 11:20:38 +0200
Message-Id: <20200820091610.755420696@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 9fb10671011143d15b6b40d6d5fa9c52c57e9d63 ]

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 4 +++-
 drivers/gpu/drm/radeon/radeon_drv.c     | 4 +++-
 drivers/gpu/drm/radeon/radeon_kms.c     | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index d86110cdf0852..b2334349799d1 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -627,8 +627,10 @@ radeon_crtc_set_config(struct drm_mode_set *set,
 	dev = set->crtc->dev;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index f6908e2f9e55a..41e8abd099784 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -496,8 +496,10 @@ long radeon_drm_ioctl(struct file *filp,
 	long ret;
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 	
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index dfee8f7d94ae5..2e28cf8118404 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -659,8 +659,10 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	file_priv->driver_priv = NULL;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-- 
2.25.1




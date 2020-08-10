Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3916C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46BF22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087706;
	bh=xHoZ26XpZm8YKg2WP2lG/V4YkxGbw+Wx0QIbUw7sdH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNsCX/c8qCV62f0xe4OkC+jSKgDBlpyRRNdVTENEWqrsPtTwQSDVqkh3xMrshZF3a
	 EPxJNqYjGlNcWiVvWE2kovCcb4PSfROmZU65rF7O7MrR0SySloS6g/7FUFGFopEnxu
	 CwW8tsBBqVhbsT7aMrvDSGfmqhGpL4G9S2brm+VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgHJTLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbgHJTK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:10:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E2F2078D;
        Mon, 10 Aug 2020 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086657;
        bh=xHoZ26XpZm8YKg2WP2lG/V4YkxGbw+Wx0QIbUw7sdH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuF87xAveKw2+/YFWkxrhRRXKppJGtKZnxZu77Todb3auxCD22ZGRgYjR6Y5kGbBN
         RYU4Rj3sds40FWdRCK9Sca6kn1R5kj7gNAZynOS1upd6laY8nlVuO7tACudBwhnVWb
         EX+RDgsEhpY/nN030u6k38ZDAw9nJ9Uia2hI/sqA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 21/60] drm/nouveau: fix multiple instances of reference count leaks
Date:   Mon, 10 Aug 2020 15:09:49 -0400
Message-Id: <20200810191028.3793884-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191028.3793884-1-sashal@kernel.org>
References: <20200810191028.3793884-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 659fb5f154c3434c90a34586f3b7aa1c39cf6062 ]

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 8 ++++++--
 drivers/gpu/drm/nouveau/nouveau_gem.c | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ca4087f5a15b6..c484d21820c9b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1051,8 +1051,10 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 
 	/* need to bring up power immediately if opening device */
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	get_task_comm(tmpname, current);
 	snprintf(name, sizeof(name), "%s[%d]", tmpname, pid_nr(fpriv->pid));
@@ -1134,8 +1136,10 @@ nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long ret;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	switch (_IOC_NR(cmd) - DRM_COMMAND_BASE) {
 	case DRM_NOUVEAU_NVIF:
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index f5ece1f949734..f941ce8f81e3a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -45,8 +45,10 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (WARN_ON(ret < 0 && ret != -EACCES))
+	if (WARN_ON(ret < 0 && ret != -EACCES)) {
+		pm_runtime_put_autosuspend(dev);
 		return;
+	}
 
 	if (gem->import_attach)
 		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-- 
2.25.1


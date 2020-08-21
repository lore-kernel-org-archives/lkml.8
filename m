Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0C6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B5D207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029671;
	bh=hSBUZge40dg1LImC6rZrm90prsOMoG2RLyHf5VjnIOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wd+Rmlm4yt1W2z7erAvtD4Z07dOLyANAnRICsoCAy5MYcMTT+LnrbTk74uc14K87u
	 JRvmB5gAqBxCxr37ks4GSngT0kwD1rjVwdN/Dsn7tSnnjXXOoR+RQ7qzLKOV36Altu
	 27B5NOLGwrTPmjNg6ehm9o52u0DTBNobCVmOPLrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHURHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgHUQSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:18:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82B222B40;
        Fri, 21 Aug 2020 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026670;
        bh=hSBUZge40dg1LImC6rZrm90prsOMoG2RLyHf5VjnIOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHGCRPust98yTT7Dn6RM1sqFOVRHtrnx/g9jW9vC4wcxJME6VuAP0+UjQlLGnZ7Oy
         8fmsdmt/xQ7DBeXOh685C9KfENiXZk1ENE0ydgXtKh7j+vwghZKY8vMTUskR+AjcVy
         hZ+/pO0JsHysTTSLRYhIjmRrHRQl4sQOLerxvrXk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 36/48] drm/nouveau/drm/noveau: fix reference count leak in nouveau_fbcon_open
Date:   Fri, 21 Aug 2020 12:16:52 -0400
Message-Id: <20200821161704.348164-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit bfad51c7633325b5d4b32444efe04329d53297b2 ]

nouveau_fbcon_open() calls calls pm_runtime_get_sync() that
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 5cf2381f667e2..c09ea357e88f0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -189,8 +189,10 @@ nouveau_fbcon_open(struct fb_info *info, int user)
 	struct nouveau_fbdev *fbcon = info->par;
 	struct nouveau_drm *drm = nouveau_drm(fbcon->helper.dev);
 	int ret = pm_runtime_get_sync(drm->dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put(drm->dev->dev);
 		return ret;
+	}
 	return 0;
 }
 
-- 
2.25.1


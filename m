Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99396C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C367206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973617;
	bh=lGnFVNogcwK2R3awunYTUFbCd5LOFn/2/DNqbrRJYP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ldwHfGInYVB550GxKT0NsY7dh9jGwex54JlIDMNpLld6yAvr+LniwyzZyLkMzZi5t
	 GMeBAWDeyfT0pXAO9+j5A2Jgj8neiGzQ9MM22WL7kmROeebwoePSKvHCPjb9q9+SOF
	 R+UORHUuCi3/QR8Xvtd8pH/E4TZtfSN7hz2YTtJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgIAPUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729448AbgIAPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:18:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340ED206FA;
        Tue,  1 Sep 2020 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973482;
        bh=lGnFVNogcwK2R3awunYTUFbCd5LOFn/2/DNqbrRJYP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKB3h7c/7PvltZRprXwQq9+YRu/je8zIdS/BenLjQVDuGthp6u5ZJmPSsy/KEuBxi
         DUUPs+d4WHZYqy27wbbQKsCDf6kQyt52hdAqYsuFY5LI9yGFGrpUDm8owOM982Xx8+
         mw+a43o8jj0ufRpcV7r+qylHu34n4phKxBOWWmQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/91] drm/amdgpu: fix ref count leak in amdgpu_driver_open_kms
Date:   Tue,  1 Sep 2020 17:09:51 +0200
Message-Id: <20200901150928.970600746@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 9ba8923cbbe11564dd1bf9f3602add9a9cfbb5c6 ]

in amdgpu_driver_open_kms the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 22d9ec80a2ffd..b7ee5008b8a2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -785,7 +785,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0)
-		return r;
+		goto pm_put;
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -824,6 +824,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
+pm_put:
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return r;
-- 
2.25.1




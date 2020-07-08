Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEAAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4F72078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222880;
	bh=jWTJMZSpFMXv1eN4iBy7F5NdaPw4rqs4cZcmn3E18Tk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TbRUKWWlkBoAJWJ/hUoiAxjNkVRVqQm27t7uvHzKdBZuIFA4povbBH/uxGE+YiRiw
	 3sZ8qq0QlXhUUAmbtR61/WYvOKBlQM5b5/0Bxb6giMsRSS+2yM7TiTxXrX4Rf1b0Uf
	 1ET7ZBhFY9UDet+UIavbR5c7QLEL74GhCTtEMiYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgGHPlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgGHPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF399206DF;
        Wed,  8 Jul 2020 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222878;
        bh=jWTJMZSpFMXv1eN4iBy7F5NdaPw4rqs4cZcmn3E18Tk=;
        h=From:To:Cc:Subject:Date:From;
        b=ywlgMjIZIfbK8x6qVWUDDKaSMLzbqJX32SB0BeBhYW7KwLntTVbbsIgftAB9/Elrn
         88oq14MhXs7HeuPNHZcpTkZco4hpYWGOglNfzSFm/dYx7kn+IOYLJd2cM2f3NyoBdG
         X92c60LOpMW/IQfF7B9ANvOjjwkqHzf7deITdjhE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 01/30] drm/msm: fix potential memleak in error branch
Date:   Wed,  8 Jul 2020 11:40:47 -0400
Message-Id: <20200708154116.3199728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Zhao <bernard@vivo.com>

[ Upstream commit 177d3819633cd520e3f95df541a04644aab4c657 ]

In function msm_submitqueue_create, the queue is a local
variable, in return -EINVAL branch, queue didn`t add to ctx`s
list yet, and also didn`t kfree, this maybe bring in potential
memleak.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
[trivial commit msg fixup]
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 001fbf537440a..a1d94be7883a0 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -71,8 +71,10 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 	queue->flags = flags;
 
 	if (priv->gpu) {
-		if (prio >= priv->gpu->nr_rings)
+		if (prio >= priv->gpu->nr_rings) {
+			kfree(queue);
 			return -EINVAL;
+		}
 
 		queue->prio = prio;
 	}
-- 
2.25.1


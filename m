Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB2EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653D220836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFLFGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:06:44 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:60604 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgFLFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:06:43 -0400
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id D641E2614DE;
        Fri, 12 Jun 2020 13:06:39 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/msm: fix potential memleak issue
Date:   Fri, 12 Jun 2020 13:06:32 +0800
Message-Id: <20200612050633.3441-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUIfT0tKHR4ZSUhCVkpOQkpCSENPS0tLSEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6Ghw*Tzg2GQszOC0WNjA3
        PToKCh1VSlVKTkJKQkhDT0tLT01CVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUtKQzcG
X-HM-Tid: 0a72a6ec3f229375kuwsd641e2614de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function msm_gpu_crashstate_capture maybe called for several
times, and then the state->bos is a potential memleak. Also
the state->pos maybe alloc failed, but now without any handle.
This change is to fix some potential memleak and add error
handle when alloc failed.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index a22d30622306..d67a9933f3ce 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -366,8 +366,11 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 			if (!should_dump(submit, submit->cmd[i].idx))
 				nr++;
 
+		kfree(state->bos);
 		state->bos = kcalloc(nr,
 			sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
+		if (!state->bos)
+			return;
 
 		for (i = 0; i < submit->nr_bos; i++) {
 			if (should_dump(submit, i)) {
-- 
2.17.1


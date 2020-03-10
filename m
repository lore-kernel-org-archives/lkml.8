Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957CFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E802468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844994;
	bh=xbprZq1vSIfI+nurrzi56EZK4Gvb28onAXYXGcf0sAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0lT9Voyt6O0e9Sgaxc0meJQz9KwMB02GiAWV49p2cXJWATHci8xVFLgh2uWunkSk
	 fIt019nPqytP9LBQe1upSogdGbm9OHI5dOhaLFlfSnWM/dUbpUoV++Sa9KxsGK+xWJ
	 tfDLpmOf0Dqq9mVkvjxbaeeW27T3C4quMpaDxgPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgCJM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgCJM43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:56:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A10C20674;
        Tue, 10 Mar 2020 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844989;
        bh=xbprZq1vSIfI+nurrzi56EZK4Gvb28onAXYXGcf0sAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xVFDKBXUZncJe15V2ryEHyfzgEWAJCo3OonkBGmReo9HAf+Aovpg0c2KqzGVYL54P
         ecjhAl5PAbshTmjrZ4FB/HDscBleGPt9s8xLpaqkOq2MISpoUcBLdIPM0ARQZzaxil
         Aq+n9E59/+NyVVKkYgT0XAqNn9yeV3gdr3odNtE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 022/189] drm/msm/mdp5: rate limit pp done timeout warnings
Date:   Tue, 10 Mar 2020 13:37:39 +0100
Message-Id: <20200310123641.693818539@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Masney <masneyb@onstation.org>

[ Upstream commit ef8c9809acb0805c991bba8bdd4749fc46d44a98 ]

Add rate limiting of the 'pp done time out' warnings since these
warnings can quickly fill the dmesg buffer.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 05cc04f729d63..e1cc541e0ef2e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -1109,8 +1109,8 @@ static void mdp5_crtc_wait_for_pp_done(struct drm_crtc *crtc)
 	ret = wait_for_completion_timeout(&mdp5_crtc->pp_completion,
 						msecs_to_jiffies(50));
 	if (ret == 0)
-		dev_warn(dev->dev, "pp done time out, lm=%d\n",
-			 mdp5_cstate->pipeline.mixer->lm);
+		dev_warn_ratelimited(dev->dev, "pp done time out, lm=%d\n",
+				     mdp5_cstate->pipeline.mixer->lm);
 }
 
 static void mdp5_crtc_wait_for_flush_done(struct drm_crtc *crtc)
-- 
2.20.1




Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137B8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F1520674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844526;
	bh=poU2yKYx8uqXY9anobZDWyRSFMcqkk2DwmXd8rSwxoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KZLchXOgA/fYAT95fXwHBleLGykx/2GOgSOmD5rB+HSwTQW7O3KsiOH7yHBMK3nlT
	 ijs/YGGrRtf68N88CCeFsxggSkgE2MSiDZgRjfidheGqDGmvkb4KaC1xe1t15NR9ei
	 EEgm7g0HVlkoxlQPobVqnrDW/axJCb6U2V8jTk1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCJMsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgCJMsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:48:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0132467D;
        Tue, 10 Mar 2020 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844521;
        bh=poU2yKYx8uqXY9anobZDWyRSFMcqkk2DwmXd8rSwxoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aV+iZC7bGu2FXxfCyR+MwWI1dyaNoOu7xa96qgstkYFgIMPzacyUbd8eYGxb/CEEU
         Kq1c3c96fQBIYTE0yDqI5aFlVJrj/iDUYluhmDJ2uxnQgmjdw3ckJIRFYZswJJC7QU
         mwb6IOAq0el05Vxop7LDBk6YNNNEH2Ve4A/xs9Z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 022/168] drm/msm/mdp5: rate limit pp done timeout warnings
Date:   Tue, 10 Mar 2020 13:37:48 +0100
Message-Id: <20200310123637.891054313@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
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
index eb0b4b7dc7cc7..03c6d6157e4d0 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -1112,8 +1112,8 @@ static void mdp5_crtc_wait_for_pp_done(struct drm_crtc *crtc)
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




Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625DC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE526206E5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgDLOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:35:14 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:52388 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDLOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:35:14 -0400
Received: from localhost.localdomain ([93.22.37.28])
        by mwinf5d36 with ME
        id RqbA2200b0cS4cl03qbBFc; Sun, 12 Apr 2020 16:35:12 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Apr 2020 16:35:12 +0200
X-ME-IP: 93.22.37.28
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/msm: Fix typo
Date:   Sun, 12 Apr 2020 16:35:09 +0200
Message-Id: <20200412143509.11353-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicated 'we'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 998bef1190a3..b5fed67c4651 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -959,7 +959,7 @@ static int mdp5_crtc_cursor_set(struct drm_crtc *crtc,
 	if (!ctl)
 		return -EINVAL;
 
-	/* don't support LM cursors when we we have source split enabled */
+	/* don't support LM cursors when we have source split enabled */
 	if (mdp5_cstate->pipeline.r_mixer)
 		return -EINVAL;
 
@@ -1030,7 +1030,7 @@ static int mdp5_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
 		return -EINVAL;
 	}
 
-	/* don't support LM cursors when we we have source split enabled */
+	/* don't support LM cursors when we have source split enabled */
 	if (mdp5_cstate->pipeline.r_mixer)
 		return -EINVAL;
 
-- 
2.20.1


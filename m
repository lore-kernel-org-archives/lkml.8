Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D97EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE8C20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693178;
	bh=O+1b+vEjsXVxEumzY+m/5Vsy4jq3RV1jYyMovHaZPuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A++7Lhh0a09LxsfpcCL/Pv/vAxpkyNsk1FZOtlDDBCs+LTTA5LS26GrlxseFuTrMX
	 d0KdVetQ15i5ZNdy/2KnWU10yKs7qPqS0U7DMklTq+oXSP92eM5v6nW6oTriYHWLdM
	 bHom/k3CfhxfKA9SCSGdpMhoZeZtbPW1iSYnUipU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgHQP0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbgHQPYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:24:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7B72388E;
        Mon, 17 Aug 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677874;
        bh=O+1b+vEjsXVxEumzY+m/5Vsy4jq3RV1jYyMovHaZPuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGjAaYMvACMu5lWrWYykAsiSeYahuZyiLr1Jk6JsD8NrbwZbJdZn77MZAi+PzYF9t
         gXfuytwA3IsAbTGDxHYuypuW9JADwyxlW48Uqv220Mlo9lsBFLxQJiSTBKHMdAsobD
         LW0yuyulJsDkm+OF83+Y9jOwQoGajvNYPAfL4c40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 139/464] drm/msm: ratelimit crtc event overflow error
Date:   Mon, 17 Aug 2020 17:11:32 +0200
Message-Id: <20200817143840.474175227@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 5e16372b5940b1fecc3cc887fc02a50ba148d373 ]

This can happen a lot when things go pear shaped.  Lets not flood dmesg
when this happens.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index e15b42a780e04..969d95aa873c4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -389,7 +389,7 @@ static void dpu_crtc_frame_event_cb(void *data, u32 event)
 	spin_unlock_irqrestore(&dpu_crtc->spin_lock, flags);
 
 	if (!fevent) {
-		DRM_ERROR("crtc%d event %d overflow\n", crtc->base.id, event);
+		DRM_ERROR_RATELIMITED("crtc%d event %d overflow\n", crtc->base.id, event);
 		return;
 	}
 
-- 
2.25.1




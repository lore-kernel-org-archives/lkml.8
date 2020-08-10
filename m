Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD53FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8590C22D2B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597086726;
	bh=deoFFvs+lYOA3NhbnLW7aKfmT9nZI/YTcIyEDI6w7XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjbAh12TXmyHSpaSHsUgyuOBnyvCxrEQmET+r31EfSo6h3i0gBLMCCRUohFDm37mA
	 lOqJSrznCOmMp/7I6m3PPA1f67kIFIPxHKKGdO8EQz80VtH7axhspm8oOmYZrOOu1y
	 zSxMu7Mgl1b9avrdLDZBsXcud8SpguaCESNBBs2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgHJTMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbgHJTLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:11:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771F4207FF;
        Mon, 10 Aug 2020 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086711;
        bh=deoFFvs+lYOA3NhbnLW7aKfmT9nZI/YTcIyEDI6w7XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zqe7Jc+XdrquCBQhYeAl5iqOtX4XoQM2BzZpbh8hUn19KklvCkpRi8X5d0uJWQBy2
         4DhqJuJNQxNhLEobRimCdr2Ilm9RO6mGIaV9fkZNnw9ncvdQ/DAGbCqdvRQP7tlrkk
         NHJ0Na4jomG2/LQeI70ynHMKijBE9pngBA04/FC0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 60/60] drm/msm: ratelimit crtc event overflow error
Date:   Mon, 10 Aug 2020 15:10:28 -0400
Message-Id: <20200810191028.3793884-60-sashal@kernel.org>
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
index 17448505a9b5f..d263d6e69bf12 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -386,7 +386,7 @@ static void dpu_crtc_frame_event_cb(void *data, u32 event)
 	spin_unlock_irqrestore(&dpu_crtc->spin_lock, flags);
 
 	if (!fevent) {
-		DRM_ERROR("crtc%d event %d overflow\n", crtc->base.id, event);
+		DRM_ERROR_RATELIMITED("crtc%d event %d overflow\n", crtc->base.id, event);
 		return;
 	}
 
-- 
2.25.1


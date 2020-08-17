Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258AE20760
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686532;
	bh=5SdRxwewqwZ7KrqOvfnH5u5FxN5Aybc+C9XT0SFfjLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUP2oUX5NUrYzmBAKYqK7WOfN9bVy8Sf3yj61qHMzQx7UlhDY2pMUGcRlUp+lXcKD
	 x2Z0yoUl4PsagN7TGja1IjMwp+Jc7pcCqf5V+e0o/IIcrViXZevGpfvTNwTCGdcuWV
	 TtkCYba1BbC6L6GoJmgU03CHuovMIMQ3CAt5fFBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgHQRsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbgHQQNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:13:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5636720658;
        Mon, 17 Aug 2020 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680781;
        bh=5SdRxwewqwZ7KrqOvfnH5u5FxN5Aybc+C9XT0SFfjLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2BWb/Os53+eengOIit/IpcURRU5QEgtm7so4sIWOx/yTr+2B+4GGAMPUxV/01Ttm
         EA8S0bPlmmfJ5Kc6jEU/O1LYW9nC2sUUHIMc1M7WGJcZz8zwdE524+4rErSeWCpgcT
         0eps7aEdB7MlCzPlnGYX8/Wwj/AHFq9GiGP/Vbqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/168] drm/msm: ratelimit crtc event overflow error
Date:   Mon, 17 Aug 2020 17:16:25 +0200
Message-Id: <20200817143736.449384458@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
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
index 4752f08f0884c..3c3b7f7013e87 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -659,7 +659,7 @@ static void dpu_crtc_frame_event_cb(void *data, u32 event)
 	spin_unlock_irqrestore(&dpu_crtc->spin_lock, flags);
 
 	if (!fevent) {
-		DRM_ERROR("crtc%d event %d overflow\n", crtc->base.id, event);
+		DRM_ERROR_RATELIMITED("crtc%d event %d overflow\n", crtc->base.id, event);
 		return;
 	}
 
-- 
2.25.1




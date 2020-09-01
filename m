Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F014C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AB9206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977682;
	bh=5XX2RQWMOIbfRSpMJZfRbIyQh6vvoUtfX87JlCCnWUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEm7R+cjEBTrvEwkXZoav+JhXtavvcOh2Qpz3l+SC1toU/4UP5lqvwlB4xOSmcJSx
	 ruTxWdqJ65n3uQX+PXWyR4p7RnAA09g4y7CZJ5i6zKeQ38VfvTTOzFY64gXzybu6wG
	 Pye8eYrJqs54FZNnb11VFUGV2xKAqPmxC2ccspk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgIAQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730854AbgIAPcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6200520866;
        Tue,  1 Sep 2020 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974322;
        bh=5XX2RQWMOIbfRSpMJZfRbIyQh6vvoUtfX87JlCCnWUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0xnwLj6eu9utdbM30aBW3PaJqgR+lWq9mlkclwJYEmpu30TxXTDq7CGkPtrzdkWNZ
         zfiRf4VAgvK0/98gad5NRfxvXAUWi0Z8cXIY+s5hDAf0kLunmisElbeoobixs8et3U
         sFPtZw+oBA6IU56TCy7i/KlWAANuIjoV9oYxgrX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 101/214] drm/msm/adreno: fix updating ring fence
Date:   Tue,  1 Sep 2020 17:09:41 +0200
Message-Id: <20200901150957.837252422@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit f228af11dfa1d1616bc67f3a4119ab77c36181f1 ]

We need to set it to the most recent completed fence, not the most
recent submitted.  Otherwise we have races where we think we can retire
submits that the GPU is not finished with, if the GPU doesn't manage to
overwrite the seqno before we look at it.

This can show up with hang recovery if one of the submits after the
crashing submit also hangs after it is replayed.

Fixes: f97decac5f4c ("drm/msm: Support multiple ringbuffers")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 048c8be426f32..053da39da1cc0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -350,7 +350,7 @@ int adreno_hw_init(struct msm_gpu *gpu)
 		ring->next = ring->start;
 
 		/* reset completed fence seqno: */
-		ring->memptrs->fence = ring->seqno;
+		ring->memptrs->fence = ring->fctx->completed_fence;
 		ring->memptrs->rptr = 0;
 	}
 
-- 
2.25.1




Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D61C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4113A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552224;
	bh=5awcBRC1vnFsSufAGrSrHlTj08tl0RW0fzavbHxoj8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BiHEI0xoHDyIQE3upOYx2xbn4YTT4SVWlB53+ImzSXXMvK+qTVB15FvI8YnivPLiw
	 0QdLhs60mD0NhoglOEDbqmqamC91Nq2GyBXPHT9N0jnf5kZFaMFjXI3puJL37KPZrb
	 Vtp0yKIGLyrrrpNy/hwpD5IagKHnr6mR+ukLrgJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgDVKnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbgDVKTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE8E2076B;
        Wed, 22 Apr 2020 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550775;
        bh=5awcBRC1vnFsSufAGrSrHlTj08tl0RW0fzavbHxoj8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhODb7AQHCuilWz9HBS6GUxC+b5O9t1/yJZd1NFhaJLqCvm977L5WXmEbC6BsBQoQ
         yYzMOXzhbXPb7xUA5qjc27+ucnWbiLAIOlDxCSqNbbzEwcUydkBtdoQQ56AQI+kJ83
         kxKM8Qx8U3iSrGjY4AKlyehkg1iADOIAXuEkvIYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, xinhui pan <xinhui.pan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/118] drm/ttm: flush the fence on the bo after we individualize the reservation object
Date:   Wed, 22 Apr 2020 11:56:36 +0200
Message-Id: <20200422095037.659318325@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xinhui pan <xinhui.pan@amd.com>

[ Upstream commit 1bbcf69e42fe7fd49b6f4339c970729d0e343753 ]

As we move the ttm_bo_individualize_resv() upwards, we need flush the
copied fence too. Otherwise the driver keeps waiting for fence.

run&Kill kfdtest, then perf top.

  25.53%  [ttm]                     [k] ttm_bo_delayed_delete
  24.29%  [kernel]                  [k] dma_resv_test_signaled_rcu
  19.72%  [kernel]                  [k] ww_mutex_lock

Fix: 378e2d5b("drm/ttm: fix ttm_bo_cleanup_refs_or_queue once more")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/series/72339/
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f078036998092..abf165b2f64fc 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -517,8 +517,10 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 
 		dma_resv_unlock(bo->base.resv);
 	}
-	if (bo->base.resv != &bo->base._resv)
+	if (bo->base.resv != &bo->base._resv) {
+		ttm_bo_flush_all_fences(bo);
 		dma_resv_unlock(&bo->base._resv);
+	}
 
 error:
 	kref_get(&bo->list_kref);
-- 
2.20.1




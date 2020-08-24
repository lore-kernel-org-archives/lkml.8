Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A208DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CC32067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289342;
	bh=yM0adv38uo+NQx7so3B98b2SMvGI1C8RiqcPnmX6+rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SqST7l/8YsPRXxYCuYI3S9kA4f72BgV06YCzSZn2Q9H5VZzPxpk7xsg8uo5T8hiQ1
	 8Y+cIjJ5Je69rWEZXBuevHKIuY15VDjrNncpKpLilH1SMuWkHoCfx/kbcdtrcjne11
	 /keMy6zEhjPAHqZ+zV0v4nsBqXKGakCiaHbktCR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHXRPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgHXQhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:37:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DBC522DA9;
        Mon, 24 Aug 2020 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287001;
        bh=yM0adv38uo+NQx7so3B98b2SMvGI1C8RiqcPnmX6+rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXUzDAG5QriYH/XVwMMT+nWzkvQnbQPyYVFFJ/KDRNYvpHF22vlxWkj+SCtRmNIva
         KT8DFW33xKGI8b5cGM0JUr1CSXnN504MNXB0Y0II82gBAnzoOYqB6zVtj93GJvvHOz
         zwxdoJ/yhBckxozHJy7lMMvxu0E4JbguPI3uw6R0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xin He <hexin.op@bytedance.com>, Qi Liu <liuqi.16@bytedance.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.7 05/54] drm/virtio: fix memory leak in virtio_gpu_cleanup_object()
Date:   Mon, 24 Aug 2020 12:35:44 -0400
Message-Id: <20200824163634.606093-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin He <hexin.op@bytedance.com>

[ Upstream commit 836b194d65782aaec4485a07d2aab52d3f698505 ]

Before setting shmem->pages to NULL, kfree() should
be called.

Signed-off-by: Xin He <hexin.op@bytedance.com>
Reviewed-by: Qi Liu <liuqi.16@bytedance.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20200722051851.72662-1-hexin.op@bytedance.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d9039bb7c5e37..1e65c5ac573b1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -79,6 +79,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 			}
 
 			sg_free_table(shmem->pages);
+			kfree(shmem->pages);
 			shmem->pages = NULL;
 			drm_gem_shmem_unpin(&bo->base.base);
 		}
-- 
2.25.1


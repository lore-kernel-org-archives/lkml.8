Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AEC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2483124670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698810;
	bh=IJrHykFkCkyR23gfxYuRwcxF8VQP6BEXnlSz/yBVNzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vbxn5NRWg7V2Vz5O+QHXq+/At61GWr0FKm5uX2prSDA0Zqea3zaUq79Koh24Hl1Eo
	 RTwcPmgvIz2i2w9BMf53P4JE5hYdU875Zf33xVGi1BA3U2uiYT0pKWFpAM3xK0KGsi
	 IshiJ4CKXPy/v/z4rwrPRf9TAhtIeaylaQITkznM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392931AbgBNQVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392834AbgBNQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:19:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6B72472E;
        Fri, 14 Feb 2020 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697199;
        bh=IJrHykFkCkyR23gfxYuRwcxF8VQP6BEXnlSz/yBVNzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lrj+3xUD4ARrpsByz5SzQqojbgDlxOR/m6drfAXTC4DgJ2gTAxZmI17ITlAqb4/DA
         Rol0T7ur5TlHxlds7VyQMEvtYKZjyA5sXEtebvIg1rAPs/t2eYHxDurm2SpC4Iqhkh
         M6iVZIg7eC235WRXAq6DdHo1JJ175dTEUuhKXgek=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 127/186] drm/nouveau: Fix copy-paste error in nouveau_fence_wait_uevent_handler
Date:   Fri, 14 Feb 2020 11:16:16 -0500
Message-Id: <20200214161715.18113-127-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 1eb013473bff5f95b6fe1ca4dd7deda47257b9c2 ]

Like other cases, it should use rcu protected 'chan' rather
than 'fence->channel' in nouveau_fence_wait_uevent_handler.

Fixes: 0ec5f02f0e2c ("drm/nouveau: prevent stale fence->channel pointers, and protect with rcu")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 99e14e3e0fe4d..72532539369fb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -158,7 +158,7 @@ nouveau_fence_wait_uevent_handler(struct nvif_notify *notify)
 
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 		chan = rcu_dereference_protected(fence->channel, lockdep_is_held(&fctx->lock));
-		if (nouveau_fence_update(fence->channel, fctx))
+		if (nouveau_fence_update(chan, fctx))
 			ret = NVIF_NOTIFY_DROP;
 	}
 	spin_unlock_irqrestore(&fctx->lock, flags);
-- 
2.20.1


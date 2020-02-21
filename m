Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8FC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364BC20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274570;
	bh=jJmGbjrMcrnfyaWkDHs+k6NYLdiYkzr+UWsEzaleZVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Miu2alwRcRNGIZjlSogD74YV57uluGyEe9XE1sP7GhIClkdnCVQYalVgfo8sIcDhk
	 W3JQaoWI8bdU1yeXc2eGDXFHPqQGTY7r/FPDiDVZJ9zZhwnQ0tXRAP9BSy8HXuz6hM
	 qzg6nBGmgvc3qZFkLn3v5d0div+24yi9XV7cNjVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgBUIms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbgBUHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D4220801;
        Fri, 21 Feb 2020 07:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271681;
        bh=jJmGbjrMcrnfyaWkDHs+k6NYLdiYkzr+UWsEzaleZVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCasjLZjtkfJXP/Oz9z2BD9EG5eRdRhYBD6cBFSnf7ZnMg60vho5QxjD+FG8gfBHs
         xf+/PFwKLgWuk/H7d0+99KlbyD0uZji2WkzNkdNtAhhtRktDBowWy+TBy3y+GKrF+B
         HLnhS+Kbn/YXN28crNowQJ1HJwC95iO+jTo4K0hU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 258/399] drm/nouveau: Fix copy-paste error in nouveau_fence_wait_uevent_handler
Date:   Fri, 21 Feb 2020 08:39:43 +0100
Message-Id: <20200221072427.503030406@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 9118df035b28d..70bb6bb97af87 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -156,7 +156,7 @@ nouveau_fence_wait_uevent_handler(struct nvif_notify *notify)
 
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 		chan = rcu_dereference_protected(fence->channel, lockdep_is_held(&fctx->lock));
-		if (nouveau_fence_update(fence->channel, fctx))
+		if (nouveau_fence_update(chan, fctx))
 			ret = NVIF_NOTIFY_DROP;
 	}
 	spin_unlock_irqrestore(&fctx->lock, flags);
-- 
2.20.1




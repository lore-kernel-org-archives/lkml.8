Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C79C20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693317;
	bh=k0AAVlIdFxxPOjKzHe5fG2GOOoYHzTyXq4uUWXtFjUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e3Ng1HKJp8zoI3PaGD9Lgav1AsYsPp5qDkUmQjPPnHhjI0zH7uxC7VCxorpPAaxy8
	 loc3HxnNQ8GILMKsQ8uhNcs0VAbW0W2PL8npcKvPI77GosuU2GrIkz5LAZaWuTiAlE
	 bk1k8+vP5nxTc1nthfdNUjWuhWle+3x960VUVFAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgHQTl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbgHQPYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:24:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5311523444;
        Mon, 17 Aug 2020 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677884;
        bh=k0AAVlIdFxxPOjKzHe5fG2GOOoYHzTyXq4uUWXtFjUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQic9FLu+Px6ZvJPd++eXw64WnKZ79YVAu8pdWW+lwdma1br2687VfShHOn3XS+gC
         4E8kGvJiA1HOG0IAKR8es8hGNU8zJfzhhNA9uw1j5ybpOqtDsGBWrrSVe62A6iEKBK
         bXZevZErxBbFNj4quckIMR2wwR/oT+gf+Dsedepo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 143/464] drm/amdgpu: use the unlocked drm_gem_object_put
Date:   Mon, 17 Aug 2020 17:11:36 +0200
Message-Id: <20200817143840.663904894@linuxfoundation.org>
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

From: Emil Velikov <emil.velikov@collabora.com>

[ Upstream commit 1a87f67a66de4ad0c0d79fd86b6c5273143387c3 ]

The driver does not hold struct_mutex, thus using the locked version of
the helper is incorrect.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Fixes: a39414716ca0 ("drm/amdgpu: add independent DMA-buf import v9")
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20200515095118.2743122-8-emil.l.velikov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 43d8ed7dbd001..652c57a3b8478 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -587,7 +587,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
 					&amdgpu_dma_buf_attach_ops, obj);
 	if (IS_ERR(attach)) {
-		drm_gem_object_put(obj);
+		drm_gem_object_put_unlocked(obj);
 		return ERR_CAST(attach);
 	}
 
-- 
2.25.1




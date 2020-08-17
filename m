Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73172063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597685875;
	bh=0twkCdG4JqCbSm6fsCcGK0oLqz8tjy0hd07lO6A9CZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPVS/gSAB+25ghPy918AYu8zfWhagkFdCZp9wCxROL2hl7sXyLzjiS5ZKBNpWOk0A
	 TJdXiOrlPk2VkHv1e6AuI8239lj/AbU1Pd+Nsp1AwD6Y466hjJoobuEoNG8MhKBaJi
	 /CNMn8O1dM5NPfC0ROB8rETjbG5jRZg9kz5dhuCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbgHQRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbgHQQRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:17:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9840220658;
        Mon, 17 Aug 2020 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597681031;
        bh=0twkCdG4JqCbSm6fsCcGK0oLqz8tjy0hd07lO6A9CZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTtgPmYoUJiBAu2xYVHwjOZgGaoFtHG2X6cP5kWswNymSBxBRJ1X02aUbcChgQHpL
         WRlAivTA1doB9N+X/caV10rpdKeyDGKhRHvsxVqpxb7z5bHq4y4QLZyI5AuchF286V
         8R8iXC8OdptY34pH3oupfxcMC6ncxWMRgs1K8CAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.19 155/168] drm/ttm/nouveau: dont call tt destroy callback on alloc failure.
Date:   Mon, 17 Aug 2020 17:18:06 +0200
Message-Id: <20200817143741.411673981@linuxfoundation.org>
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

From: Dave Airlie <airlied@redhat.com>

commit 5de5b6ecf97a021f29403aa272cb4e03318ef586 upstream.

This is confusing, and from my reading of all the drivers only
nouveau got this right.

Just make the API act under driver control of it's own allocation
failing, and don't call destroy, if the page table fails to
create there is nothing to cleanup here.

(I'm willing to believe I've missed something here, so please
review deeply).

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200728041736.20689-1-airlied@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_sgdma.c |    9 +++------
 drivers/gpu/drm/ttm/ttm_tt.c            |    3 ---
 2 files changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_sgdma.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
@@ -96,12 +96,9 @@ nouveau_sgdma_create_ttm(struct ttm_buff
 	else
 		nvbe->ttm.ttm.func = &nv50_sgdma_backend;
 
-	if (ttm_dma_tt_init(&nvbe->ttm, bo, page_flags))
-		/*
-		 * A failing ttm_dma_tt_init() will call ttm_tt_destroy()
-		 * and thus our nouveau_sgdma_destroy() hook, so we don't need
-		 * to free nvbe here.
-		 */
+	if (ttm_dma_tt_init(&nvbe->ttm, bo, page_flags)) {
+		kfree(nvbe);
 		return NULL;
+	}
 	return &nvbe->ttm.ttm;
 }
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -241,7 +241,6 @@ int ttm_tt_init(struct ttm_tt *ttm, stru
 	ttm_tt_init_fields(ttm, bo, page_flags);
 
 	if (ttm_tt_alloc_page_directory(ttm)) {
-		ttm_tt_destroy(ttm);
 		pr_err("Failed allocating page table\n");
 		return -ENOMEM;
 	}
@@ -265,7 +264,6 @@ int ttm_dma_tt_init(struct ttm_dma_tt *t
 
 	INIT_LIST_HEAD(&ttm_dma->pages_list);
 	if (ttm_dma_tt_alloc_page_directory(ttm_dma)) {
-		ttm_tt_destroy(ttm);
 		pr_err("Failed allocating page table\n");
 		return -ENOMEM;
 	}
@@ -287,7 +285,6 @@ int ttm_sg_tt_init(struct ttm_dma_tt *tt
 	else
 		ret = ttm_dma_tt_alloc_page_directory(ttm_dma);
 	if (ret) {
-		ttm_tt_destroy(ttm);
 		pr_err("Failed allocating page table\n");
 		return -ENOMEM;
 	}



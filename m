Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C8EC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB71206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262659;
	bh=B4KbhpoltGExd208/4xHgN1aUeY0aanpA2UIDqaA8Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wiievGKo6q9qUg1uQ07VBCWgX6NBSblQCgzkHmpFqGjfkj7a2nHa6xNAsZzejzDn0
	 JcKOsUgeuZqgC9/f45GEIUdoRENbRtC3V9tNSYhA8CCvLx/w73+RnaRnvnaUqF+pTb
	 vFI5PMUN9Sk0YENSNDysXRQ5WK42TPDlqrJwAhtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbgGTQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbgGTP5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5955B20773;
        Mon, 20 Jul 2020 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260663;
        bh=B4KbhpoltGExd208/4xHgN1aUeY0aanpA2UIDqaA8Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRD2vhhZgl+U7SxuaH/SwIom4LjERtjr8wCYMkeNJNosfN/CVqjHjTANt17kH9H0d
         8sA0S2zty5SGlpIaDFCc0twZxc5U9MngFw0KeZU87ZGFGurGeen3jsUXkKlYjKCRCg
         UOHfhuekHzhfA3jfVemDXocZbvKI5zev43dasico=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 032/215] drm/exynos: Properly propagate return value in drm_iommu_attach_device()
Date:   Mon, 20 Jul 2020 17:35:14 +0200
Message-Id: <20200720152821.713321911@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit b9c633882de4601015625f9136f248e9abca8a7a ]

Propagate the proper error codes from the called functions instead of
unconditionally returning 0.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Merge conflict so merged it manually.
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index 619f81435c1b2..58b89ec11b0eb 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -61,7 +61,7 @@ static int drm_iommu_attach_device(struct drm_device *drm_dev,
 				struct device *subdrv_dev, void **dma_priv)
 {
 	struct exynos_drm_private *priv = drm_dev->dev_private;
-	int ret;
+	int ret = 0;
 
 	if (get_dma_ops(priv->dma_dev) != get_dma_ops(subdrv_dev)) {
 		DRM_DEV_ERROR(subdrv_dev, "Device %s lacks support for IOMMU\n",
@@ -92,7 +92,7 @@ static int drm_iommu_attach_device(struct drm_device *drm_dev,
 	if (ret)
 		clear_dma_max_seg_size(subdrv_dev);
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.25.1




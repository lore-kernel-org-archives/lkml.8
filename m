Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89AEC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C457F22D06
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260011;
	bh=C7+GofNjhe+jY5AW/vb6dlbgYoHYz4aFI8DtT5Jram4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZZaDvVMcIsrYGJEcRMfX2P79i4Agvztte5Sk4HebGmBpRnnCu9Szl3+oKiARkDFh
	 Zhdg6BpK/D+G/MRJP6DcJkz2S8ZfSx95uTPb0Cx89OZ+AJFM4+7hf9mc/fYuaVCpV7
	 Q5FIuHHiwC4LRZTW/bHDWuro27UNkMmfVN7nyYao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgGTPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbgGTPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DE72064B;
        Mon, 20 Jul 2020 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260006;
        bh=C7+GofNjhe+jY5AW/vb6dlbgYoHYz4aFI8DtT5Jram4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxkDUgrfIqHdTWQe4KiVTTp0j23rBVLXoTT8oF7XyL7CVjkX9ZRJIFxzR0Zu0jncA
         UZl9gQW9ZV7FueEctCuu24PtQOf0mVztkfZXgVCEzQbRKGzJlsxJxI4tfdWTBvHW9a
         pf4QG6gdhlI78zW4guFLXCPpV0gC52a6d9CRndAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/125] drm/exynos: fix ref count leak in mic_pre_enable
Date:   Mon, 20 Jul 2020 17:36:34 +0200
Message-Id: <20200720152805.688289459@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit d4f5a095daf0d25f0b385e1ef26338608433a4c5 ]

in mic_pre_enable, pm_runtime_get_sync is called which
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index ba4a32b132baa..59ce068b152f5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -267,8 +267,10 @@ static void mic_pre_enable(struct drm_bridge *bridge)
 		goto unlock;
 
 	ret = pm_runtime_get_sync(mic->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(mic->dev);
 		goto unlock;
+	}
 
 	mic_set_path(mic, 1);
 
-- 
2.25.1




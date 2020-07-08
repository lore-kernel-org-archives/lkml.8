Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56322C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262A020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222967;
	bh=e6MJ1jDkNLcWDBG1X6jjVt05hEmPTtGNPap9XM5tuuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8J+LtBRt6dd6ASFD70gh0C2zIdGv33pQMjBlpQzdFW5aY6RFZE54hYQJjnLNrpM6
	 G1eFcVRSbSL+uzwHfCKezTFL9nFNrJnIeOzYlSvIcoBuf2TV8v+4dtXqa/G6XsXt1v
	 HzK2DuKc7WXWtVWeqawoT41sVfN3gn1OOFl8Udug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgGHPmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbgGHPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:42:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668E4206DF;
        Wed,  8 Jul 2020 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222920;
        bh=e6MJ1jDkNLcWDBG1X6jjVt05hEmPTtGNPap9XM5tuuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FO3sQ50kPt51+hCGPWyPEH4dADSAa6Akjl+tyGhYL6X79uRbrsCP1hujklXTCZ/Vk
         sTGL6Sd8D3OLovWfEgOBPjQGvHqbybw+kKAq9z4fiJyp/AeK+kg4ne/QE6xve2w5PD
         pZBioUijgl2iV7TRx9BdmrzbSo6GEUb4AMM5P22Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/8] drm/exynos: fix ref count leak in mic_pre_enable
Date:   Wed,  8 Jul 2020 11:41:50 -0400
Message-Id: <20200708154157.3200116-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154157.3200116-1-sashal@kernel.org>
References: <20200708154157.3200116-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 2fd299a58297e..cd5530bbfe2e6 100644
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


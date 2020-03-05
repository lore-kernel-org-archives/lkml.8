Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A6C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829862187F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428449;
	bh=qWd20iwAOFru1dkdrmNhZZetuO5TaElp0urtUJVUjOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pReSLhunG0dKNshRq7DeCsWYmN60gVrmXA+smnnWO6nIo6nOuXO/4+AyQyvFpqSz7
	 u42V+QLgHpcGpTy/3bxTtTgmvBmblknxhSl7QGcGJHyAws6spmnMM0H7LcHM5xCLs0
	 0r9ptZ2pKLB5y0qWiJ5xEEpY/KZuGSKSTzZA0z5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCEROI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:14:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCEROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D379220870;
        Thu,  5 Mar 2020 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428445;
        bh=qWd20iwAOFru1dkdrmNhZZetuO5TaElp0urtUJVUjOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QW/vC0i71QL21BPfYO4tDVPWr4eSznLYsDGhGDmoSJdUj5+4ckzte+j1wrGIJpvXN
         5SKa+rwfFqa6GCoq8hsgzs5oY26Bn8mY5E++nZdlEHWnVwOT8ZHz7Ro2YQGlYBE/Me
         fD2BqX8sjHd1lvTOnN8NhgCNF/2XCJ/7ogjPEF7Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 41/67] drm/amdgpu: fix memory leak during TDR test(v2)
Date:   Thu,  5 Mar 2020 12:12:42 -0500
Message-Id: <20200305171309.29118-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monk Liu <Monk.Liu@amd.com>

[ Upstream commit 4829f89855f1d3a3d8014e74cceab51b421503db ]

fix system memory leak

v2:
fix coding style

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 8b13d18c6414c..e4149e6b68b39 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -948,8 +948,12 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks;
 	int ret = 0;
 
-	max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
+	if (!smu->smu_table.max_sustainable_clocks)
+		max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
 					 GFP_KERNEL);
+	else
+		max_sustainable_clocks = smu->smu_table.max_sustainable_clocks;
+
 	smu->smu_table.max_sustainable_clocks = (void *)max_sustainable_clocks;
 
 	max_sustainable_clocks->uclock = smu->smu_table.boot_values.uclk / 100;
-- 
2.20.1


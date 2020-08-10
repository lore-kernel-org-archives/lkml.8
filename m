Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40741C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1650622C9E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597086808;
	bh=gGyiXxopYlQbJ6AbtM9O7utJiQiofQ+CDLgnBBOTWdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=05OxJ3KscQpHVfWdsRSH/jDIfbifv4IXvrU2Soe4XQgW9vjGIhDBnBY3hjo57/e9g
	 IpJZuekco7b3/THBkOjPb6m/5hTJ3oIsNfygD/0gL7c1KSAN07QX77z09fAxI+Ipw8
	 AKs0fs1vfCsq6MbiL57hcn4sqmv7a21jPxS/PjzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgHJTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbgHJTNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:13:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301C622BEB;
        Mon, 10 Aug 2020 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086803;
        bh=gGyiXxopYlQbJ6AbtM9O7utJiQiofQ+CDLgnBBOTWdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2SO/fnYmDK5OhRpw9AlDZddzAYgE5wa0UoTcQfteCfKSybKWP/MQPzz+E0mC+HZp
         HgT/sw741M4TwpJYnsRd+FYFacXf4oa1TfWCJA/DQE1Zj4SXpEsk+Fyjdm4U+DHwmD
         V+PBnZceVvU11kBG7I3E9B/IA80oA+nR31q4C+xY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 16/31] drm/radeon: disable AGP by default
Date:   Mon, 10 Aug 2020 15:12:44 -0400
Message-Id: <20200810191259.3794858-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191259.3794858-1-sashal@kernel.org>
References: <20200810191259.3794858-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit ba806f98f868ce107aa9c453fef751de9980e4af ]

Always use the PCI GART instead. We just have to many cases
where AGP still causes problems. This means a performance
regression for some GPUs, but also a bug fix for some others.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 54729acd0d4af..0cd33289c2b63 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -168,12 +168,7 @@ int radeon_no_wb;
 int radeon_modeset = -1;
 int radeon_dynclks = -1;
 int radeon_r4xx_atom = 0;
-#ifdef __powerpc__
-/* Default to PCI on PowerPC (fdo #95017) */
 int radeon_agpmode = -1;
-#else
-int radeon_agpmode = 0;
-#endif
 int radeon_vram_limit = 0;
 int radeon_gart_size = -1; /* auto */
 int radeon_benchmarking = 0;
-- 
2.25.1


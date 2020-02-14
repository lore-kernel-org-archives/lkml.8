Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF55C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85AB2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698536;
	bh=6dD2KXOc0Xmxs4S5JjvOxNo7mg3BfFEJegbzPuFt1bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqTV6NrK8D+35SfyQgcxmefj4NFyz14Q3ig9v4s2BCfYg2H0ZLyGKzwNcfyAeWEwF
	 DnLbUup/Sdgk9/MmvEePId4QVwvHmx6TypPF/xSvlxwJhfmiXmu9vAVPriTXSC9/bd
	 U3emexySMhwy7fQ5msKDeQOg58heCb/qRbOprRDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405600AbgBNQmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393185AbgBNQWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D897424746;
        Fri, 14 Feb 2020 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697339;
        bh=6dD2KXOc0Xmxs4S5JjvOxNo7mg3BfFEJegbzPuFt1bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVYbYxeWQ84FT4quiUApuIl98PAkRKKX/0s/1bF+mq97sNnI26Ahu6Jo7QFekuu9x
         C4N6nf0o0YuGQhKEKKW9yflQp1envMRWykddy9FHUSFGoDQ9ZU9/NRKsZLBwIw2JBZ
         ixawxHheFvBmKAEkftg6oWcEwlt+bh4daj9dpF4U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 045/141] drm/radeon: remove set but not used variable 'radeon_connector'
Date:   Fri, 14 Feb 2020 11:19:45 -0500
Message-Id: <20200214162122.19794-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 5952c48993375a9da2de39be30df475cf590b0ce ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/radeon_display.c: In function radeon_crtc_scaling_mode_fixup:
drivers/gpu/drm/radeon/radeon_display.c:1685:27: warning: variable radeon_connector set but not used [-Wunused-but-set-variable]

It is not used since commit 377bd8a98d7d ("drm/radeon:
use a fetch function to get the edid")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 8b6f8aa238063..59d62275a659d 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1719,7 +1719,6 @@ bool radeon_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	struct radeon_encoder *radeon_encoder;
 	struct drm_connector *connector;
-	struct radeon_connector *radeon_connector;
 	bool first = true;
 	u32 src_v = 1, dst_v = 1;
 	u32 src_h = 1, dst_h = 1;
@@ -1732,7 +1731,6 @@ bool radeon_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 			continue;
 		radeon_encoder = to_radeon_encoder(encoder);
 		connector = radeon_get_connector_for_encoder(encoder);
-		radeon_connector = to_radeon_connector(connector);
 
 		if (first) {
 			/* set scaling */
-- 
2.20.1


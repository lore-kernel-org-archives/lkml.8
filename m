Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39000C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023972064B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888215;
	bh=r5cRSKBQIhNHoIQhIfZua12ERWVZevFIYQnYN1GlsEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xtdl46vTqGhPXz3GFiCkxLwAHZNQdhRzyobek3HspFxIUwpqmqrZUsk1ieWNu6Mxr
	 xWROBvNFpdTtTd5X4nvi6taTOnAvnmtR/mfVMaBYEOO6s/M0Wom3xWrtaejnMt57lf
	 DM/BplI2X6J+6S0xcWJhbZIS1bJL7ME3JV/AUZ4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgHaPgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbgHaPaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030DB206F0;
        Mon, 31 Aug 2020 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887834;
        bh=r5cRSKBQIhNHoIQhIfZua12ERWVZevFIYQnYN1GlsEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HphBn4hErUKQFq02FjwnJjW2Eg0WOJ3NhHcZS3EVKv/brHqAuKWo46FPtArk1BXmI
         pXVWpxqnokQfeD6SkVL7VDdDPDNnvDpWhxwEaIOHJdRTBOiy+k/fTtZJH8fFyD2qvg
         IAru+w4Bk5l5IDqbnVY5YIoAmNEskl72B9cIRdUU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 40/42] drm/amd/display: Fix memleak in amdgpu_dm_mode_config_init
Date:   Mon, 31 Aug 2020 11:29:32 -0400
Message-Id: <20200831152934.1023912-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831152934.1023912-1-sashal@kernel.org>
References: <20200831152934.1023912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit b67a468a4ccef593cd8df6a02ba3d167b77f0c81 ]

When amdgpu_display_modeset_create_props() fails, state and
state->context should be freed to prevent memleak. It's the
same when amdgpu_dm_audio_init() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0682fd363cb50..580c17c95a1d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2822,12 +2822,18 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 				    &dm_atomic_state_funcs);
 
 	r = amdgpu_display_modeset_create_props(adev);
-	if (r)
+	if (r) {
+		dc_release_state(state->context);
+		kfree(state);
 		return r;
+	}
 
 	r = amdgpu_dm_audio_init(adev);
-	if (r)
+	if (r) {
+		dc_release_state(state->context);
+		kfree(state);
 		return r;
+	}
 
 	return 0;
 }
-- 
2.25.1


Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C61C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DA52064B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888136;
	bh=huelgF8JzQ81vNIaCdGm2nn+1vKAlvrXCvum3Q88YJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e25k/vtMwiQWhqqTn1SL43TWWR6AEeDo0yKQmukfZJc+26gFF6pZyKS392flFa3sp
	 Chxr65Cg0NlLE2GN9Efui0+E6/4kLOHD6m7x44qTNkLkOVNm23wmbjqfHW7cIf2Rva
	 aHSr4N9IIzOH3SuVEJVb3qhJyD1ARjkFyrYFFjAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgHaPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgHaPbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:31:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35067214D8;
        Mon, 31 Aug 2020 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887870;
        bh=huelgF8JzQ81vNIaCdGm2nn+1vKAlvrXCvum3Q88YJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkGRhuKxb8lxV/UfU0eM9DT9ScrOTqoWY20GRVdPlZLL3S52vCX73WgF/8f2LgVpZ
         FdSe91pIk2QCATRSKPUAr2gEngHgSoXN+2gs+3EUM3U5DwbVc9Z8pq1YhPnujiuxd5
         jMmvngVwePUSc3nYt25NslwLHSXWbc3fRVw3s5fo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Furquan Shaikh <furquan@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 19/23] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object to 0 in amdgpu_dm_update_backlight_caps
Date:   Mon, 31 Aug 2020 11:30:35 -0400
Message-Id: <20200831153039.1024302-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153039.1024302-1-sashal@kernel.org>
References: <20200831153039.1024302-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Furquan Shaikh <furquan@google.com>

[ Upstream commit 5896585512e5156482335e902f7c7393b940da51 ]

In `amdgpu_dm_update_backlight_caps()`, there is a local
`amdgpu_dm_backlight_caps` object that is filled in by
`amdgpu_acpi_get_backlight_caps()`. However, this object is
uninitialized before the call and hence the subsequent check for
aux_support can fail since it is not initialized by
`amdgpu_acpi_get_backlight_caps()` as well. This change initializes
this local `amdgpu_dm_backlight_caps` object to 0.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2c0eb7140ca0e..526e4161df454 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2064,6 +2064,8 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 #if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps;
 
+	memset(&caps, 0, sizeof(caps));
+
 	if (dm->backlight_caps.caps_valid)
 		return;
 
-- 
2.25.1


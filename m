Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15772C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3A520775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860278;
	bh=uHBTrMrYml8VaPhAjZRyOEWnDq3qelk0BaB3G42UzUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vi+1YXRg3fOzOcSOOYWrhhlFeoHZ8+1JwWtA9QfLcRO2dqK6wAtzI+7pLMKwLv2dY
	 aJRn1cgw2mMs5gKvnd+DlpzMZktcLsRxsxvsEtcHwNb0rjWfbPZ/JXLTq+9xr3OiHi
	 bYOVrYH3rIjxt67SxKzBUBmzAO69XfwxaOXhSv7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgG0ObQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731626AbgG0OUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:20:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAD22070B;
        Mon, 27 Jul 2020 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859653;
        bh=uHBTrMrYml8VaPhAjZRyOEWnDq3qelk0BaB3G42UzUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFc1VBzKXTnZXoVBBFlMC8KhviQ+uWLtRa5Juibcxmdjv+5x/kgHpJ0iIR8J+28fR
         N9DhnPZH0crGzYiwK4YwoqeafRHOAJfZCwSEi3I1E0pUPGLVa1JXq+XDDFI47ynAEM
         DSSEHGHIVUQMxRm9+BWQe9gu7IoL5NMkVk6z47XU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 023/179] drm/amd/display: add dmcub check on RENOIR
Date:   Mon, 27 Jul 2020 16:03:18 +0200
Message-Id: <20200727134933.798087986@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit 3b2e973dff59d88bee1d814ddf8762a24fc02b60 ]

RENOIR loads dmub fw not dmcu, check dmcu only will prevent loading iram,
it breaks backlight control.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208277
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7da2a22dbde7e..837a286469ecf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1345,7 +1345,7 @@ static int dm_late_init(void *handle)
 	struct dmcu *dmcu = NULL;
 	bool ret;
 
-	if (!adev->dm.fw_dmcu)
+	if (!adev->dm.fw_dmcu && !adev->dm.dmub_fw)
 		return detect_mst_link_for_all_connectors(adev->ddev);
 
 	dmcu = adev->dm.dc->res_pool->dmcu;
-- 
2.25.1




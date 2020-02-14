Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC28EC3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0522187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696311;
	bh=HpiIeod6sqqqok91ZLMDjz0W7nDlJkN/pEmAn0kleNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpv9Z4N964CuX+5AWxWq/HpzJSw2kc3GDdQree7+TI1xRo8tfbu0b8+kdOmjPAqrM
	 RGlybmPF18TMJobJmGsHQmeXNZqQ0wm5ZFMsaMdh9UXTBiQ+AgRC7Tr3jmAfnr1sP9
	 KFyGJuNBOTk2SfW2QsByxtgR2OJJmjCkcNG37JP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbgBNQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389499AbgBNQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:04:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6483124676;
        Fri, 14 Feb 2020 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696275;
        bh=HpiIeod6sqqqok91ZLMDjz0W7nDlJkN/pEmAn0kleNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+EsdO0h04L06q93O9MxpBLqmhNXvv7Ivw1FEk35MO6ZAenriQtqnZRezYryQJr/g
         OLSb1NLRjdZ3VANjpURbfrH8o2ewAC4ptY0DvhaAVObVzqK5PYOW+kEEHRWTWnNUgM
         YAv3ghhxJ7jkZ8RSa5XQ36sYgCZkqRrufNerCtjc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Evan Quan <evan.quan@amd.com>,
        Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 125/459] drm/amd/powerplay: remove set but not used variable 'data'
Date:   Fri, 14 Feb 2020 10:56:15 -0500
Message-Id: <20200214160149.11681-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 4bf321c177c74f7d834956387cd74805c3098322 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c: In function vega10_get_performance_level:
drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c:5217:23: warning: variable data set but not used [-Wunused-but-set-variable]

'data' is introduced by commit f688b614b643 ("drm/amd/pp:
Implement get_performance_level for legacy dgpu"), but never used,
so remove it.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index beacfffbdc3eb..a3d9d612af1be 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -5247,13 +5247,11 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 				PHM_PerformanceLevel *level)
 {
 	const struct vega10_power_state *ps;
-	struct vega10_hwmgr *data;
 	uint32_t i;
 
 	if (level == NULL || hwmgr == NULL || state == NULL)
 		return -EINVAL;
 
-	data = hwmgr->backend;
 	ps = cast_const_phw_vega10_power_state(state);
 
 	i = index > ps->performance_level_count - 1 ?
-- 
2.20.1


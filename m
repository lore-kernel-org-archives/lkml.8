Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BD2C3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DE224681
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696020;
	bh=Vu3XjvYbCgw86NCz8BhfJsyxkHdSDYwpHnwGfWUj6ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRdZ7LFMKrQHXTyCjl9Gpfr3f55tLfLcgE/lZgQzDLkZli/KRB0wvqXxPTMaLTwRK
	 OcWPNShyQNIada90GCm2uYxxyzMbruFOMEYPCdENwKceWBnylADW+vqP1ebpmhknN4
	 RSGuAu7A/Ctfvzk9ZPa0IaIohHiRtGn6hdYtXrOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbgBNQAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389091AbgBNQAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:00:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FC524676;
        Fri, 14 Feb 2020 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696013;
        bh=Vu3XjvYbCgw86NCz8BhfJsyxkHdSDYwpHnwGfWUj6ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwfKHBvdUzAcwqzWxKfulrh6zG+sLG/AEBZymi9/z+QoEcx3TEAGH/wmcozmklKFi
         Oyljqv/IYz9gPUD1VHdgB640SwP6Qh6d40PWs1xeWXvH1kq/tuqzGWQBqcpvJRqcBH
         N0IxiKGbQef7/v29uCZdG9/cVzw2sbcPzdZsSJmg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 530/542] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_voltage
Date:   Fri, 14 Feb 2020 10:48:42 -0500
Message-Id: <20200214154854.6746-530-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1064ad4aeef94f51ca230ac639a9e996fb7867a0 ]

Cull out 0 clocks to avoid a warning in DC.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 627a42e8fd318..fed3fc4bb57a9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1080,9 +1080,11 @@ static int smu10_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
-		clocks->data[i].voltage_in_mv = pclk_vol_table->entries[i].vol;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
+			clocks->data[clocks->num_levels].voltage_in_mv = pclk_vol_table->entries[i].vol;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
-- 
2.20.1


Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF445C35643
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDFC2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273566;
	bh=6uuL2kpSArz8OwtyYslYE7k2qCheH7HvEGUTMDexYsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kLDEx3zGOmrzUJb0dIv3HC+nRIpxpcL8C0KYL7VH+cNCQWeOiwKS1AXWoQUywXrTH
	 rn85r+8bl4pswykoAHqjrO1El1L8WYvLPgCsGAIccRmvVcVgxMwmOjCdcnH/AjPrzA
	 BHAyA4cMipndMsskByph/cqpn8rJu7q5p1I+zIG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbgBUIYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388391AbgBUIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1B3246A9;
        Fri, 21 Feb 2020 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273476;
        bh=6uuL2kpSArz8OwtyYslYE7k2qCheH7HvEGUTMDexYsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFl6EAomVZOM9MnLrcwbaetsiHfNE1VL95YjzNN5h2ZCIb967318g8t3muCe753H9
         lW0mdUaTaIdwdlEKQIsUud42Jpp+J6l4An19XuFRc2kn3NWb+hYkkvzLZRhowHZZyQ
         rStLjQWSQoz0t7iW+O5Pnuowxzm1M+lUG3OnTcRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 185/191] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_voltage
Date:   Fri, 21 Feb 2020 08:42:38 +0100
Message-Id: <20200221072312.966159239@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3fa6e8123b8eb..48e31711bc68f 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1048,9 +1048,11 @@ static int smu10_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
 
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




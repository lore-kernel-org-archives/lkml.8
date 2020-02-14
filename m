Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879D3246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696750;
	bh=z45Deq5jpfh5BBTwJ6zU+HtvdTraWuKGso37UKduEvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9fo5QO6MJAmQ9R+G7udRKw0HGpJWLnhNJjcm2AZyAzBKm9x6XLMUu7ihtCSk67HX
	 6udXK5O/g9fcza3efa4WqqultjrosqgBRWoT6aoLsFYoDsP31biZ+2kGGeCD4s6DZK
	 J4LWgQCH4yKHLS573yi+PE3XfWTxAvrGIt/tBTE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391622AbgBNQM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390977AbgBNQLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A815524680;
        Fri, 14 Feb 2020 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696681;
        bh=z45Deq5jpfh5BBTwJ6zU+HtvdTraWuKGso37UKduEvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIHwb2WHQ9Q9JO18f0AB1ihuAzdjuDOJrBbGtpGCPaZog/LF+e38LZ0sEtHpmo4IS
         5e1ytJabteoPUenYXlKnpdMbA4teKZX5tsrGKC7VM/KcfYHne7/8M2C/uZZCjh9nD2
         MYHEzCjd8JiclDeIoeWnpkX7NR2PYqEcstjFrmhM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 449/459] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_latency
Date:   Fri, 14 Feb 2020 11:01:39 -0500
Message-Id: <20200214160149.11681-449-sashal@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 4d0a72b66065dd7e274bad6aa450196d42fd8f84 ]

Only send non-0 clocks to DC for validation.  This mirrors
what the windows driver does.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 1115761982a78..627a42e8fd318 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1026,12 +1026,15 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk * 10;
-		clocks->data[i].latency_in_us = latency_required ?
-						smu10_get_mem_latency(hwmgr,
-						pclk_vol_table->entries[i].clk) :
-						0;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+				pclk_vol_table->entries[i].clk * 10;
+			clocks->data[clocks->num_levels].latency_in_us = latency_required ?
+				smu10_get_mem_latency(hwmgr,
+						      pclk_vol_table->entries[i].clk) :
+				0;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
-- 
2.20.1


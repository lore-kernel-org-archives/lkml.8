Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DBAC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8EE20882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578693943;
	bh=NFxnKCjBfr6dkSPF25OUS484+i8f0PDBqaTCmWfvZms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HEGkmQYP9VJlkPCCMIcQWqRfdp+LW+kkUo+DmsSdrCqrw1feXi6cYBnhQq/5w2m+g
	 dAoQYQZsKbp78lUuwKBlQTeRDMhvS17yV/of//cumAjefJw7nzDrgt2TsIJNYxXMT+
	 yYVMdgBJG4LOGVyQLQFJPnvIOqrgh5kELzO4rafA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgAJWFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgAJWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:05:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96BBE20721;
        Fri, 10 Jan 2020 22:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693938;
        bh=NFxnKCjBfr6dkSPF25OUS484+i8f0PDBqaTCmWfvZms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4QuiagtMJttk9Qs6gQcAAmgjDsOvoIuELMOtfXKbKbt2toPBTPFZ7SmvYg5ku7Oj
         6EPegODyv53pgOp+68hShFtQ+YCxa/V7lf8WFZTk0ABdA9St8IwunguX6KABPSaGVT
         9/SFwHlQpWsWGM1mEk2IQ/OqMKWTCQEzNkDgpFpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     changzhu <Changfeng.Zhu@amd.com>, Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 20/26] drm/amdgpu: enable gfxoff for raven1 refresh
Date:   Fri, 10 Jan 2020 17:05:13 -0500
Message-Id: <20200110220519.28250-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220519.28250-1-sashal@kernel.org>
References: <20200110220519.28250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: changzhu <Changfeng.Zhu@amd.com>

[ Upstream commit e0c63812352298efbce2a71483c1dab627d0c288 ]

When smu version is larger than 0x41e2b, it will load
raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it
needs to avoid adev->pm.pp_feature &= ~PP_GFXOFF_MASK when it loads
raven_kicker_rlc.bin.

Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c9ba2ec6d038..ab4a0d8545dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1038,17 +1038,10 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		break;
 	case CHIP_RAVEN:
-		/* Disable GFXOFF on original raven.  There are combinations
-		 * of sbios and platforms that are not stable.
-		 */
-		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8))
-			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		else if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
-			 &&((adev->gfx.rlc_fw_version != 106 &&
-			     adev->gfx.rlc_fw_version < 531) ||
-			    (adev->gfx.rlc_fw_version == 53815) ||
-			    (adev->gfx.rlc_feature_version < 1) ||
-			    !adev->gfx.rlc.is_rlc_v2_1))
+		if (!(adev->rev_id >= 0x8 ||
+		      adev->pdev->device == 0x15d8) &&
+		    (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
+		     !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 
 		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-- 
2.20.1


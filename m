Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14145C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA2D20801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271171;
	bh=I3GG6lSlT9TzpTOQSFRaoFpe2xLdXe/3lR+hI2etkKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4OQ6nu9JcTBdoNp1YV+H06yvlTBM7VRxmF3wTVJKFx+2Tmj+atxAnOLEDKwEem1n
	 N0IqJ6pbVbWl1EqPoC2G9wu7NcGUMvr/fTO7Biq8miVEyb/3S1TJjVibvQ9kxOz+zC
	 p3N2WsBCjLOKKl4JBP6rRTFovFU3gZPeeDFFeHoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgBUHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbgBUHqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:46:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2048F24672;
        Fri, 21 Feb 2020 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271167;
        bh=I3GG6lSlT9TzpTOQSFRaoFpe2xLdXe/3lR+hI2etkKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2rB9QXHqfrUlkRZhmXg68kWHpMKBoKPcejTHfoWNu4P7sdmT5rrh17x851nc24Lp
         Cz/qcfPp9BCcqHKKyAh6gCuHdQJOimEJT+0bIjA4sycGvaj/HPVV4bE7MV12Js8ZtG
         klVMfkVLbAmOFI58dVoX4zJMK17MS1xD6b8P5K1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiecheng Zhou <Tiecheng.Zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 063/399] drm/amdgpu/sriov: workaround on rev_id for Navi12 under sriov
Date:   Fri, 21 Feb 2020 08:36:28 +0100
Message-Id: <20200221072408.516417950@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>

[ Upstream commit df5e984c8bd414561c320d6cbbb66d53abf4c7e2 ]

guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
as a consequence, the rev_id and external_rev_id are wrong.

workaround it by hardcoding the rev_id to 0, which is the default value.

v2. add comment in the code

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0ba66bef57468..de40bf12c4a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -701,6 +701,12 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_ATHUB;
+		/* guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
+		 * as a consequence, the rev_id and external_rev_id are wrong.
+		 * workaround it by hardcoding rev_id to 0 (default value).
+		 */
+		if (amdgpu_sriov_vf(adev))
+			adev->rev_id = 0;
 		adev->external_rev_id = adev->rev_id + 0xa;
 		break;
 	default:
-- 
2.20.1




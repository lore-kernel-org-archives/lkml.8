Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E5C3B1A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE18A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696214;
	bh=zHTUh5PHMgFWU1edZPn6wQntKg1Dv1p7HKF4+eFYTeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMsEYx3hsahiJYN7DH1fDZeipbA/Z73oxlA3B2uwPPr9posqEhzv46yhqtFg7lul/
	 D1BB6heiEKNxkgJQ9jpJnhiUCRKQzG1QagqrhgE+8wg4OspDBEPuj6mq5ttkNsnQP2
	 /XO6BvN3TzA9+BS1CD7j2TbD7FCILxuNjNviSgn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbgBNQDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbgBNQDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722362187F;
        Fri, 14 Feb 2020 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696193;
        bh=zHTUh5PHMgFWU1edZPn6wQntKg1Dv1p7HKF4+eFYTeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCt7zg7gbabT+7dCl4yHESp/yhNmyTmrcLXj/MC6lWvIma9ofastbsWl9oHVPyda6
         t8+Iiiee7BXHTrHOWOxdBCAAZXuV6k2Zz7sYJWHw2A1YqhuQ0K+GAi4VlHU+HGXeVP
         mSBsrAlVA6/3HmAe3oqHO4RSfdiQwEajoa9TjE4U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiecheng Zhou <Tiecheng.Zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 061/459] drm/amdgpu/sriov: workaround on rev_id for Navi12 under sriov
Date:   Fri, 14 Feb 2020 10:55:11 -0500
Message-Id: <20200214160149.11681-61-sashal@kernel.org>
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
index de9b995b65b1a..2d780820ba00e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -660,6 +660,12 @@ static int nv_common_early_init(void *handle)
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


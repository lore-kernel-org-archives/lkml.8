Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA50C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0643120578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274282;
	bh=zHTUh5PHMgFWU1edZPn6wQntKg1Dv1p7HKF4+eFYTeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mXkJgTmDv6yHhsRpxzdE/rskgQrUih43dqH3tfiPxbAUm00BYr1/UYJN2YWMCcVl9
	 wvsW+F9D5M0403lmxQ9vbnn08XzsWC3Doxwb8f09ICqxGCcmEy90qOCeKaQ34t4B8S
	 JaGPAkOtte8eWIZL/wj8+AgzPGs6Coa3jgnTZglk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgBUIDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731469AbgBUID3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:03:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF906222C4;
        Fri, 21 Feb 2020 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272209;
        bh=zHTUh5PHMgFWU1edZPn6wQntKg1Dv1p7HKF4+eFYTeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlChRam1iI5epj+4gs6+Cyx/SDW/elb7LsCFZj44zdF61qZDs4kwQpzkSZeLlGtiO
         fenbpLwTK6ydUoWFH4YIGD2lUHX5mJwbMJJdHRYqDPBKG6JpXLFlI22gZY64ueR1Dq
         lzVXCaUUkuxIPFGbAJ7RsuVH2VHjPJ1JTWxX+wPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiecheng Zhou <Tiecheng.Zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/344] drm/amdgpu/sriov: workaround on rev_id for Navi12 under sriov
Date:   Fri, 21 Feb 2020 08:37:35 +0100
Message-Id: <20200221072354.149936285@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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




Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3765C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01EA20644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255346;
	bh=Uqu9T6znjX1+39KqQvn1WXb9FvYPbQ02CpAtw+3Q5ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nH8/ZpLCl/d3papgcCFbcl9WRw718Ysucs6mkPCRbeW5bbPCFxEOiNcFOk/fOLNe5
	 u1odnlwXQd2yEnn504GXTe520wRUyD4Gym5FeDM9ii2hMticlCSCPTbDBAA9aZXTYt
	 iu188c/kKpO0llgaJA/C2Rv9qpxjSAJFkvveJY7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgDGKYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgDGKYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:24:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC2C20692;
        Tue,  7 Apr 2020 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255057;
        bh=Uqu9T6znjX1+39KqQvn1WXb9FvYPbQ02CpAtw+3Q5ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnD+vPES3okOvTccv4J3AIbLih27uMbW4rQ9pTF/IHClL3sGkKRFowpkeYUmXeB57
         ytSnobo3p1nYQ3EuqGeBcrIkMOSr/rJrKyTj0Ko0UI3Kme8dlEDIUNK98mFvaR2shd
         dXNafR3rPGNf2JjyuKHwMjqfEnQrExvX8rZIhzYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Zhu <James.Zhu@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 13/46] drm/amdgpu: fix typo for vcn1 idle check
Date:   Tue,  7 Apr 2020 12:21:44 +0200
Message-Id: <20200407101500.936760620@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Zhu <James.Zhu@amd.com>

[ Upstream commit acfc62dc68770aa665cc606891f6df7d6d1e52c0 ]

fix typo for vcn1 idle check

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index b4f84a820a448..654912402a851 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1374,7 +1374,7 @@ static int vcn_v1_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(handle))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
-- 
2.20.1




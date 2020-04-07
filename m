Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122FBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8B12074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255396;
	bh=gmDm55ev+jBU5e+PcU2wskqxgzx4vGLTtfMr1tuFboE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJ+XksZ03eOVLtYjTbop8JrZp01sDqaJJ1FeN/550hsptIMTg9mHViqgFWcCv3sn6
	 4yVDN6CdeD8c4lrQ41vLNFOxdmV7XJvIzoY9EoDl/rsLiFRWmkmW3R/EIiZ9nH9U9e
	 qolBQbTT0bB/WPmlenHId8Xg3sgFTsLi3zCeafOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgDGK3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgDGKWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:22:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D3D20801;
        Tue,  7 Apr 2020 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586254969;
        bh=gmDm55ev+jBU5e+PcU2wskqxgzx4vGLTtfMr1tuFboE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpLV1SJstrYZCBU77h5lHsqIsrqV5Lef5S0tRkHHuFKpD4pSudUC5C1yNFXltXlK+
         sesClGHdNkS5SC6XfFzpOdtgB5hkFnUhAKbc+HifpSboE6nsDQNRXmjNedrQu0Za+U
         sffCLkys3NSeL9SNgUuTHhlV7lAj7fWRG/K2xnBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Zhu <James.Zhu@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 06/36] drm/amdgpu: fix typo for vcn1 idle check
Date:   Tue,  7 Apr 2020 12:21:39 +0200
Message-Id: <20200407101455.080556646@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101454.281052964@linuxfoundation.org>
References: <20200407101454.281052964@linuxfoundation.org>
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
index 93b3500e522b8..4f0f0de832937 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1375,7 +1375,7 @@ static int vcn_v1_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(handle))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
-- 
2.20.1




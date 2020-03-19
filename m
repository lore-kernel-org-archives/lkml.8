Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ECCC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC4020724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624182;
	bh=5+O+YWwnsvBINmW4iAXC6psifakgha+pK7uZe9OAMiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v7ul1bF+zpbz+Xt1LDTgavdweXfgCHh5GbnB2iIGwbb738NhgnJAQrIYYwpTTK004
	 ABfeMh5b4amnXCvLYq3lskgaCCM6AmsmIK0/9cqRrN06u+yZiw1vff+XkdVsRa+jfL
	 bGLgISyeD4Kx4jqLZMtAb/SRGIunolNk3KeswjnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCSNXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730280AbgCSNW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:22:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8A620724;
        Thu, 19 Mar 2020 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624177;
        bh=5+O+YWwnsvBINmW4iAXC6psifakgha+pK7uZe9OAMiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEEh5t1JO4eeIZXlWSAgduH9jg1F1QqN3R4/4IG91gdLoykOMgsjql0BZiVSR8EiK
         17hT2RxutE/cD768r9avsKa0n/AheVbt9+c0tNMbFnoPpyrfbrgMXCCgESozNTelHf
         vaFm5AQUzgyeCLnn+wtlN3DoMHWRs/8zGqlh7Ipw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Monk Liu <Monk.Liu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 33/60] drm/amdgpu: fix memory leak during TDR test(v2)
Date:   Thu, 19 Mar 2020 14:04:11 +0100
Message-Id: <20200319123930.165729165@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123919.441695203@linuxfoundation.org>
References: <20200319123919.441695203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monk Liu <Monk.Liu@amd.com>

[ Upstream commit 4829f89855f1d3a3d8014e74cceab51b421503db ]

fix system memory leak

v2:
fix coding style

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c5257ae3188a3..0922d9cd858a0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -988,8 +988,12 @@ static int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks;
 	int ret = 0;
 
-	max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
+	if (!smu->smu_table.max_sustainable_clocks)
+		max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
 					 GFP_KERNEL);
+	else
+		max_sustainable_clocks = smu->smu_table.max_sustainable_clocks;
+
 	smu->smu_table.max_sustainable_clocks = (void *)max_sustainable_clocks;
 
 	max_sustainable_clocks->uclock = smu->smu_table.boot_values.uclk / 100;
-- 
2.20.1




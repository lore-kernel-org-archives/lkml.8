Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F931218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942586;
	bh=1LZPEe39UMnjvcdUsIgtXXcaZV3h47Euw7lnX/jEmRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCmmWEP8Oj72qV99Rn+NN6PruCEbbcKRl9AldkAimCcOQWXuWgqC6QEyF/o9w0N3w
	 y7HqX33d4yhz0OFPAgObVo4jWvXNazOqEecDIHEIbv9NAE/NltygZazXzWJ/P7m9c6
	 xbewiS7v7NQ3g0JxU2TyuyeWMZrosdXT4ngKPuic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgEHM4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbgEHM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:56:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5CF2496A;
        Fri,  8 May 2020 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942579;
        bh=1LZPEe39UMnjvcdUsIgtXXcaZV3h47Euw7lnX/jEmRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bpc+iqwBXEZSmiZUFeyInUAFJ2ZogFx9YmxeMtJUJJ9XxwHxia1dfX506JyBJ+nzr
         lpwBY2ONIzL+NILQ7YN1V1oatlishoixa2M9uwhao4cH34YRcQI17ZoZgVWEJNx6Ly
         D4CHCn5UkTTqvJIxl3a20KsOcZOfqrRlCYQQ5/NI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>,
        Mengbing Wang <Mengbing.Wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 23/49] drm/amd/powerplay: fix resume failed as smu table initialize early exit
Date:   Fri,  8 May 2020 14:35:40 +0200
Message-Id: <20200508123046.228896380@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 45a5e639548c459a5accebad340078e4e6e0e512 ]

When the amdgpu in the suspend/resume loop need notify the dpm disabled,
otherwise the smu table will be uninitialize and result in resume failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index f7a1ce37227cd..4a52c310058d1 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -889,12 +889,17 @@ static int renoir_read_sensor(struct smu_context *smu,
 
 static bool renoir_is_dpm_running(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	/*
 	 * Util now, the pmfw hasn't exported the interface of SMU
 	 * feature mask to APU SKU so just force on all the feature
 	 * at early initial stage.
 	 */
-	return true;
+	if (adev->in_suspend)
+		return false;
+	else
+		return true;
 
 }
 
-- 
2.20.1




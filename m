Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE8AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BFA20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919879;
	bh=dEDmkRG7YeHU1IZmCwE7m7T5vhaWdxv/IdSIN41lr+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDMVkEDoccrQ25DPY5XiVq4lhsilgjNBtF9xLxa2PPCk5wV6+8sDkkv62gk20npoD
	 TJ4tdX6HgjlNT7ATv4sNQ2TsWMXoIMq6+2FyEvo1VyeVFAdcsN/mKardVW3BKR2f8Y
	 MTBoOTSl0Rf/Ek14UzawllJhYEi7gbtI5RlPyZfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgHTKht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbgHTKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A0620738;
        Thu, 20 Aug 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918709;
        bh=dEDmkRG7YeHU1IZmCwE7m7T5vhaWdxv/IdSIN41lr+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gamUFoQ4cbau2JHPRM3ey4CfGY5Ib1jxRKM7YtW1e+UzU1FaxAWo/afj/3tYwIVK3
         /Xj7m8Oq/oUZmXyeiZ5QRA/1EfvTuO91m1bRTbn/FvFGw6DmmTyb6M107Misl5yubB
         EuX/AyxkE/yNh/Io1VO4LXzZhjSLLMxoGl6wNlyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 008/149] drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()
Date:   Thu, 20 Aug 2020 11:21:25 +0200
Message-Id: <20200820092126.097749742@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

commit 543e8669ed9bfb30545fd52bc0e047ca4df7fb31 upstream.

Compiler leaves a 4-byte hole near the end of `dev_info`, causing
amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
when `size` is greater than 356.

In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
unfortunately does not initialize that 4-byte hole. Fix it by using
memset() instead.

Cc: stable@vger.kernel.org
Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -428,9 +428,10 @@ static int amdgpu_info_ioctl(struct drm_
 		return n ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
-		struct drm_amdgpu_info_device dev_info = {};
+		struct drm_amdgpu_info_device dev_info;
 		struct amdgpu_cu_info cu_info;
 
+		memset(&dev_info, 0, sizeof(dev_info));
 		dev_info.device_id = dev->pdev->device;
 		dev_info.chip_rev = adev->rev_id;
 		dev_info.external_rev = adev->external_rev_id;



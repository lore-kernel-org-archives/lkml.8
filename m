Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1495C3F37D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFFF24690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812964;
	bh=VmyJoJtm/AzdS0db36pkNph7dHXRyE9znS2N+yd5QIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TnovHaw1t9vUecF5u9/wCx3LUVlHFPYhGjTo1qwgs9jRMK3rGR/0JJVdXiiKX8ppQ
	 HwWMooBzeJKyhHx5l6hP9AfW71Akv2udteKQ+8eVPnlyAAQ+alVOt5ktWQ0B6+iA6w
	 TfkK/1Riz4WwKZJlvfu6Jg63JSTpdgclXQ4rVfGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbgB0OQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389389AbgB0OP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:15:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402072468F;
        Thu, 27 Feb 2020 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812957;
        bh=VmyJoJtm/AzdS0db36pkNph7dHXRyE9znS2N+yd5QIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4vSVQGTrqo4VqCo5ZTJNCF3bHhxzDl3b8C9g+4EPl66NIuB7K25By5TrIzoiMQce
         QIpqe3elJ+xJG+JA0ugijHoDgq3LcGQCJxrGVSr7LvxorFlQyptkpotsY9V5iDT/9w
         8xeLBHHx9gaWmFtlMibDXOCfHg/jO9y7LkkXp3Qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 081/150] drm/amdgpu/gfx9: disable gfxoff when reading rlc clock
Date:   Thu, 27 Feb 2020 14:36:58 +0100
Message-Id: <20200227132244.804644646@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 120cf959308e1bda984e40a9edd25ee2d6262efd upstream.

Otherwise we readback all ones.  Fixes rlc counter
readback while gfxoff is active.

Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3852,6 +3852,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_c
 {
 	uint64_t clock;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	if (adev->asic_type == CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
 		uint32_t tmp, lsb, msb, i = 0;
@@ -3870,6 +3871,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_c
 			((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
 	}
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
 }
 



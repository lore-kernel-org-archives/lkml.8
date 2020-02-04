Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA58A20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YiYceiTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBDRmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:42:39 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:15058 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbgBDRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:42:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580838158; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lamwbTdrVAFepeQwkgLRLZ0iEFybtVZEKB4EDxho6/w=; b=YiYceiTclNUeFpM42LxTpPXoxZ4zysqY4bMKCY3Qpp2rKJ6Q1Cr6R8w13JrgHUuFZnTVG8Sv
 up8ajrWnzGakdQ0aE0M9SY9tCQOBr/m9iNSnoqE9aRS/XWbjErTn9kAmB/EbHdWSMgbtYb0p
 e59SUeSk+mFV579becvKziPrsUA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e39ad0d.7f4d0d489d50-smtp-out-n01;
 Tue, 04 Feb 2020 17:42:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E7A7C447A0; Tue,  4 Feb 2020 17:42:36 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EB26C447A9;
        Tue,  4 Feb 2020 17:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EB26C447A9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm/a6xx: Remove unneeded GBIF unhalt
Date:   Tue,  4 Feb 2020 10:42:28 -0700
Message-Id: <1580838148-2981-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e812744c5f95 ("drm: msm: a6xx: Add support for A618") added a
universal GBIF un-halt into a6xx_start(). This can cause problems for
a630 targets which do not use GBIF and might have access protection
enabled on the region now occupied by the GBIF registers.

But it turns out that we didn't need to unhalt the GBIF in this path
since the stop function already takes care of that after executing a flush
but before turning off the headswitch. We should be confident that the
GBIF is open for business when we restart the hardware.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index daf0780..e51c723 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -378,18 +378,6 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	int ret;
 
-	/*
-	 * During a previous slumber, GBIF halt is asserted to ensure
-	 * no further transaction can go through GPU before GPU
-	 * headswitch is turned off.
-	 *
-	 * This halt is deasserted once headswitch goes off but
-	 * incase headswitch doesn't goes off clear GBIF halt
-	 * here to ensure GPU wake-up doesn't fail because of
-	 * halted GPU transactions.
-	 */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
-
 	/* Make sure the GMU keeps the GPU on while we set it up */
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-- 
2.7.4

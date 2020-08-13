Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00512C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1A720774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="K5ZUHZoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHMSzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgHMSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:55:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9FDC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:55:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o22so5145272qtt.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Jgraj+114QRBzFXPeF3FuYfVHOWKZNgIZ9aTNenrPE=;
        b=K5ZUHZoTVkZ0tY5PKep0FfWqPe292MdYUK7XrGfQT5bPLzimznrpCsHYK7epjlHC1i
         xXd7fNIrqvF8K/M1sfQ6jyqPzwslt0B3Bhwb3q3FK+qBiYQjOk/3kdnaLrq5qlsdroFs
         fWiJWg9CRP/lrcvc4QOg8w5q5NCJzb1qqdFsgGhM3jmgGBMWerAeW8B+uXBhXF3qHHn5
         Vcr0kS3wh8MN9ZCjiI+FPVOtUIcllhV4748X8W50DajAZ5duXbgS1buXOExgWl8aY9eQ
         lOj5Y5M+FGSlVFkyntXue9hSAx9OlmmTv8dHjt1lUn8MHgV7guNNProl0yGA34GMCbGP
         30Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Jgraj+114QRBzFXPeF3FuYfVHOWKZNgIZ9aTNenrPE=;
        b=tB+dSauKmC41nwbizrB8rEQWLCzgiBEOvi0xY/HBbVY2rH6WVU7TMdhQJ7sBwGeTxx
         8CpOxzYl2JfGvPp+JbmN9Gkr5EK42BympVRCG9/6RgvELfaWiuzSenptH1QW4ZgziZoY
         hwvMU8NnMsQV4MBdCE6rUsW1Ck7NIWY6nKXOZb3G9dabnZuyaYryrxpwrT2AlJgKEwUb
         znbzHXa/MjVPlPT7Q4bact08lcJ2VksUqUiCYee3aHNszl4ePzH9oyWkh23Nlo4VtV0d
         kbrDzOKd1i9lH+MnSMN+8lhX1txq2/4Jpl+slOZ5MwgKSGE9TKjqnpBZtMpMUKljCi79
         kTLA==
X-Gm-Message-State: AOAM532Afomw3FBHvnpcxbG1aha6Lsws4bZmlCfChAhWxqzuadM5KHtl
        ydPHKpESIctrqRH+cUde25brPg==
X-Google-Smtp-Source: ABdhPJzq+Dlcltn9G2WI66j6mqaoOepwS8++0OsOncRBWUC+uPv29ltLhNqGOeIkEg8DOqa3CRYt/g==
X-Received: by 2002:ac8:4e51:: with SMTP id e17mr6954689qtw.173.1597344910414;
        Thu, 13 Aug 2020 11:55:10 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l64sm5816733qkc.21.2020.08.13.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:55:09 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH] drm/msm/a6xx: fix frequency not always being restored on GMU resume
Date:   Thu, 13 Aug 2020 14:54:48 -0400
Message-Id: <20200813185450.19387-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch reorganizing the set_freq function made it so the gmu resume
doesn't always set the frequency, because a6xx_gmu_set_freq() exits early
when the frequency hasn't been changed. Note this always happens when
resuming GMU after recovering from a hang.

Use a simple workaround to prevent this from happening.

Fixes: 1f60d11423db ("drm: msm: a6xx: send opp instead of a frequency")

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index b67b38c8fadf..bbbd00020f92 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -845,6 +845,7 @@ static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 	if (IS_ERR_OR_NULL(gpu_opp))
 		return;
 
+	gmu->freq = 0; /* so a6xx_gmu_set_freq() doesn't exit early */
 	a6xx_gmu_set_freq(gpu, gpu_opp);
 	dev_pm_opp_put(gpu_opp);
 }
-- 
2.26.1


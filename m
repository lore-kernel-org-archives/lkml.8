Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B201C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 04:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA892071A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 04:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1owtPTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgFMEWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 00:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgFMEWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 00:22:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC82C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 21:22:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so4108134pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=anOI65EuGWufQe95q4AY1YNBWRNaLqr1EwULyx7eqPc=;
        b=n1owtPTKXLSYWZxpOAfJLYBTnLB49amE5hE4rZuOb3sNSj3Vtf9fJSnLkcorKmdM8e
         1/WOfSp3udzaw7KbAmuaBZVnRtXTgdIJjnVwHpTveQphcOeiYFBboLV7OQ7q94XSrcZ2
         SkPvn10qiyTOizb+NS5awrsoIME5Uw3o5oxwgDL007hfH9Voi25MxOm4w9hfy749uxZ5
         9fV8ilJ5Rsd08uR1PWNXqcf9kxE+y2z/HuihWy1H00fq8vP7YB4mxKUyreThFOZcNegb
         vxYNb/t3mFbAVtygQljAVLvx5E7Jsupe6f9UO0jaTLqU7HVjQRAbC/raMfoqyTG/Kslp
         nzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=anOI65EuGWufQe95q4AY1YNBWRNaLqr1EwULyx7eqPc=;
        b=f7OCvMGOiOkHM2LvPZc0EzJ5sxtfdCdLIeCALgcf3pgAW3+Smhv0HepwyFtzy6J88e
         hDKvp3waSgygXzKbOncF6I6frHuHBxYcjU/E8QLXCj6YBfrsXiII0VrE2myZtk84Syue
         v8dxf9dj5xMkBLapxCobD/rr3QRrQQOTwPQvNLEuctd9/Gnm4X8doDjpUty8iGYIa7lf
         7Rz3I0pLXM/mzECgdxbnP49tWg2Ub0ufLHZgUvCgEKvwy+PjmXjOY+FQ58Oxf9NOoVjp
         V5/ludM9ScRmpYaM4q8UKu2Z+zV4MMqrfCGOtyqj2o0ZcosxVdLhHZUDGJfzs+EhK+oV
         Mi0g==
X-Gm-Message-State: AOAM530xelYFCf3O1k6M+X8cjGiak3xlBAAW6J8/3Ya5Gd7hJJuS5oOu
        uToAUdYDqvckAO8HTgUhObJ+pVLiCmc=
X-Google-Smtp-Source: ABdhPJzGMYCuY/za9R4qBuLeNIZHTPqJUnxWWu/ioBkOIdb8ujHo7WIYreHD+62yjKltYbY+atjfWg==
X-Received: by 2002:a62:7705:: with SMTP id s5mr14024168pfc.325.1592022123264;
        Fri, 12 Jun 2020 21:22:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w5sm7414719pfn.22.2020.06.12.21.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 21:22:02 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm: Fix 0xfffflub in "Refactor address space initialization"
Date:   Sat, 13 Jun 2020 04:21:59 +0000
Message-Id: <20200613042159.109511-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This week I started seeing GPU crashes on my DragonBoard 845c
which I narrowed down to being caused by commit ccac7ce373c1
("drm/msm: Refactor address space initialization").

Looking through the patch, Jordan and I couldn't find anything
obviously wrong, so I ended up breaking that change up into a
number of smaller logical steps so I could figure out which part
was causing the trouble.

Ends up, visually counting 'f's is hard, esp across a number
of lines:
  0xfffffff != 0xffffffff

This patch corrects the end value we pass in to
msm_gem_address_space_create() in
adreno_iommu_create_address_space() so that it matches the value
used before the problematic patch landed.

With this change, I no longer see the GPU crashes that were
affecting me.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: freedreno@lists.freedesktop.org
Fixes: ccac7ce373c1 ("drm/msm: Refactor address space initialization")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 89673c7ed473..3d4efe684a98 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -194,7 +194,7 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
 	struct msm_gem_address_space *aspace;
 
 	aspace = msm_gem_address_space_create(mmu, "gpu", SZ_16M,
-		0xfffffff);
+		0xffffffff);
 
 	if (IS_ERR(aspace) && !IS_ERR(mmu))
 		mmu->funcs->destroy(mmu);
-- 
2.17.1


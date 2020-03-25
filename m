Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F61C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5B6207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tItHUlXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCYJIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:08:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33866 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgCYJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:08:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 26so4414399wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLkRr9j1+t7kkMw2Ku/7MnvEj1jxos3vANcsR2A+POs=;
        b=tItHUlXC1+dfULZj1LhOU5NDx3F9h/M/Ae+O3kMnVbgtAsdvT2ghQImi0NoPV8ldYI
         8GaZtaL4VnqLR4oMrFkvItwsYw7cJKeIrKcyQfKWK6tf2RhjiYrreUBRr/2fCdDbjXKT
         3BYngDUrgZV4/43KdBii77JRucqGFUjtik85FPE67ce5c6hnB898jDOBVZfnKm5pxiAH
         hk+QX8F83j54OcYIqCop2qgnskqWTGYNi2hm6xTOXihX/NMSg9wjpPY9qnW8jBmJSaST
         XcZFNCTzLHphjahSUA5EBejR9NCMy7C6mOoclZxiGkRX/9smMlqy/43m2uR0gW3JzfDL
         82xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLkRr9j1+t7kkMw2Ku/7MnvEj1jxos3vANcsR2A+POs=;
        b=AG0FA88Usxcj2KTgCIPrM+MEN9BqF45HOcw/YvwZvrB73mmLt8Uv9GCutepIXAC3gG
         Ag92DMDZoT/Nd1qA2LLACEen0QqrgfhHbBiDS3sxysQsbj+A99dKma//J719pwBj3WPC
         o90ki6xJjmAsB8PxiJhurN7aY/dkZmwRr7PdBeUJ/aGHlsm3xRwA43SsdGCpsj/Ve9RI
         0E6J9zPV2RVOiyTdZGF0ae0+LOBGAdX2JGgHgyk95w5OwGYRqfXv/8llQBxzKBC2dlf9
         Vtf8xLEvN9fg2tua83sWcSfCjU0ZaFEdsODGufJxBS2mrj3fHMHX05K41BhNRlHSBxS4
         J56w==
X-Gm-Message-State: ANhLgQ3x4abdYDW9clcOYMDWILrcRjJSHQ+Jol1oG1FNAXRUlfgCD0s1
        1E0+ewcF2Vb5qzdqD6WmVjQ=
X-Google-Smtp-Source: ADFU+vtCdXyuM3ib6Qu85alvpqv8QAZxNBaQDg0ws8lu5V1fIrbVncSd7PIi8RVD8WbB/nlDK0aGUg==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr2380279wma.36.1585127321046;
        Wed, 25 Mar 2020 02:08:41 -0700 (PDT)
Received: from wasp.lan (250.128.208.46.dyn.plus.net. [46.208.128.250])
        by smtp.googlemail.com with ESMTPSA id 127sm8565048wmd.38.2020.03.25.02.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:08:40 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx-request@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bigbeeshane@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        mripard@kernel.org, airlied@linux.ie, David1.Zhou@amd.com
Subject: [PATCH v4 2/3] drm/amdgpu: fix scatter-gather mapping with user pages
Date:   Wed, 25 Mar 2020 09:07:40 +0000
Message-Id: <20200325090741.21957-3-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200325090741.21957-1-bigbeeshane@gmail.com>
References: <20200325090741.21957-1-bigbeeshane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to dma_map_sg may return segments / entries than requested
if they fall on page bounderies. The old implementation did not
support this use case.

Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dee446278417..c6e9885c071f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -974,7 +974,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	/* Map SG to device */
 	r = -ENOMEM;
 	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents != ttm->sg->nents)
+	if (nents == 0)
 		goto release_sg;
 
 	/* convert SG to linear array of pages and dma addresses */
-- 
2.26.0


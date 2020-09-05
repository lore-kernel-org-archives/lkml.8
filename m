Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1BCC2BBD0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1142074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8rJD/Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgIEUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIEUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:03:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75AC061244;
        Sat,  5 Sep 2020 13:03:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so1342729pjr.3;
        Sat, 05 Sep 2020 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KAgNczSpcXSENE7I7HLjPQLwLd/js6kuYT9gLzGMrc=;
        b=d8rJD/QaZSXKizO3GCu5CUpq+J4GmCJOqoR6otYkXn4kfaTkDvF+aBrkXOkT90Bahe
         ZbSkOQYq6ZHt/jSYiZ3sGkQoW5r8GXsXdrGnCpbeysVp5AkpCCH551tyZmse+AvyT80S
         CmH4MZF7sbeFiju6CPJrRnVWMfaBmOqcbDc66p6h+K6tCGvUGf/2pnZnvEJMjJhAKKI7
         UB3wdYStymMuX8KI39J4cj34r4fdCQ8rfL5aWLan9YNvn+yNYLhdNg0gWNkyIXBTWIDH
         r2ZxKWbLIg6aZAupdgaPn0TSs+gHDOfgVGHaUkRcGdCeOhyXiOtqGmK65todtAXFGtJd
         CuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KAgNczSpcXSENE7I7HLjPQLwLd/js6kuYT9gLzGMrc=;
        b=cC3xs6X9GZID19I7W5oE9MiRJwoE7Hn0GEyKHGZ9VqLdN9ZdOYxFk4RpihgqUsK252
         N20KBAJz76qdA+xALJemPUsCm14jL2xvtN6AD4tZnrI+DtvJQCprdq6y9fnQwz4JOap0
         tnVDIGebK5Ecx4ko8ttrnRznxEWHrcfKqoZHjOsPCR7oZV8seZOlYSg+tSnohNpr5Sxe
         MkoAvRcLmfmYbwe9paXgOnlsCRfyZmH/U1F4gLepYvuPHomAS/dDmJthKJCY9sgbeKYE
         ySvJ1lRoAC7JbonkmPe9kJ3RzF+TIbQC6hhILKGQe6bdYCUvZ1iOQG9Dl2z2OAkLfR9D
         yx5w==
X-Gm-Message-State: AOAM530UqVA/vRZRYmLya1ToJfkCiPveu27JAcpsXbhvKyMWgUMvWRNX
        2VliEAb2aySiQpLPePHYyOs=
X-Google-Smtp-Source: ABdhPJxokmd9eJn1r0GSTZtkg2Dhgd5Wg4QvyB1tZpQEqAEv9hOMzQ9O0ygy2PRwuew2h0245PkdCg==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr13380689pjj.6.1599336238220;
        Sat, 05 Sep 2020 13:03:58 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id k4sm11254400pfp.189.2020.09.05.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 13:03:57 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v17 01/20] drm/msm: Remove dangling submitqueue references
Date:   Sat,  5 Sep 2020 13:04:07 -0700
Message-Id: <20200905200454.240929-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Currently it doesn't matter, since we free the ctx immediately.  But
when we start refcnt'ing the ctx, we don't want old dangling list
entries to hang around.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index a1d94be7883a..90c9d84e6155 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
 	 * No lock needed in close and there won't
 	 * be any more user ioctls coming our way
 	 */
-	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
+	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
+		list_del(&entry->node);
 		msm_submitqueue_put(entry);
+	}
 }
 
 int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
-- 
2.26.2


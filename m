Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA006206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFERiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:38:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44461 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFERiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:38:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id c17so12709371lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 10:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arv2xjh9BIH+SPIN4Yj/Lki3GqizeEVvxEcRGCN4wkw=;
        b=G2EieGm+EuMMSwy9D2koVme7QMxJCgOKGc169GwA+EcskoGpdRYHmOtEf2HzjGpI4T
         H2pNeZ1Uu6Udf7BDSBmKX84aze80Y14OPG/ZhRea7wH//4j6kohgEYWpUfsariwwdPRd
         6fiqO/upIelEYRsOV9anBvbqGY52tg9DRadtNfgrVCWZ5hnqlkoLkGqm2h/El8oS4Aw4
         qSxgFp9EubT6kCqNup4fSV5KPF2yN2TC04/jPNdoTFp7ld5rkig2WotoA+C2zJKLzHRa
         0amwBFqkQZgS1DXRWT2/RWfcH/fNPQi2Rjwd1+aaXJzeQmwnSgASrBxbMuy2ReihPE96
         PT/A==
X-Gm-Message-State: AOAM531VGuiF1mb4d2tP28awrv2eC6T6k3so+tWCm5RWTzoKDqG7ZiE2
        awULywy6ZZ/UlfkpRvlBbKQ=
X-Google-Smtp-Source: ABdhPJyKUQu6CenJtrzDcfzmjM64mHti4oGYXRkw64f4WchZmMA6w4xfxmQOf3/jZuyMazvLMzH6cA==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr5404553lji.75.1591378689131;
        Fri, 05 Jun 2020 10:38:09 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id w1sm1049514ljo.80.2020.06.05.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:38:08 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Leo Li <sunpeng.li@amd.com>
Cc:     Denis Efremov <efremov@linux.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: Use kfree() to free rgb_user in calculate_user_regamma_ramp()
Date:   Fri,  5 Jun 2020 20:37:44 +0300
Message-Id: <20200605173744.68500-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605173744.68500-1-efremov@linux.com>
References: <20200605173744.68500-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree() instead of kvfree() to free rgb_user in
calculate_user_regamma_ramp() because the memory is allocated with
kcalloc().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Looks like this kvfree is from merge conflict between 
1fafef9dfe12 ("Merge drm-fixes-for-v4.17-rc6-urgent into drm-next")
and 6396bb221514 ("treewide: kzalloc() -> kcalloc()").
I'm not adding cc to stable because the bug looks harmless. You can
squash the commits if you want.
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 56bb1f9f77ce..bcfe34ef8c28 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1777,7 +1777,7 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 
 	kfree(rgb_regamma);
 rgb_regamma_alloc_fail:
-	kvfree(rgb_user);
+	kfree(rgb_user);
 rgb_user_alloc_fail:
 	return ret;
 }
-- 
2.26.2


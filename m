Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95463C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9E320679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuqE19CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFOML5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:11:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:11:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so6754157pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmNwY1vIJ7/djpVmsAk2hr/MwPcap1XkQT7uL/1tT8E=;
        b=HuqE19COYpuNHIT3UuvzszzPtqj4W0LsknbEekTvPgJlMPNIZj1fNd7zfyWtZqXij2
         CviajApjQz0WEM274stGdYidx4ME6ESiI9td5CCzkZLn6CsbeucVBJiKqv1cqzf3KjRW
         W0u2VD0JLhSAZoi2JAQ8WIvyw58nbrARQ8ocWStC2QZNOqbWFq4Gwy5we3ldARe0MfYT
         Z4enFVTXme6cj5Xb7n6vHSD5kMdVx0mzRbAhiO2BDi16JWREF/WAd24XYa5tC1jhfZbb
         gIjL88D6VjUK9hdKvbmRCao6+4FcmN7UV3ZlHXF9vMCQleeye4WI4ObmYssNLeqIMCpn
         r7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmNwY1vIJ7/djpVmsAk2hr/MwPcap1XkQT7uL/1tT8E=;
        b=h4Wfvh+jRIfDaJbQi3NrU6B3EvYxhZv0UZsNBGieCQeu8t+upVZDTN7sKdGhwu8nJO
         3W1iEFsnOatI8k9BeIBDgF/PHIpGmOAJ7XTZcYdWI8LTOSDE8Di+aOYbKjUJ1GiTbsI6
         tg2qQXa2mESdsvl9RJ9ubMfhNHHDBnH1ge122Y/hsqJnK/fMaZrVsGK7DzktoYyVtCJl
         uSmt2HuJJfRiwn9Rf03rl0TiUV2mQv6ZpUyNoM5AAaJ+Ss4S9ctoHXoRywF4KKfzIwNC
         O8ZvO0ozd6o29nrRxfRy8u8QAhWGCi7ov0Z6kN7abMLnZVfEaAZCw2T+IUbWPxL5PUsx
         CZNQ==
X-Gm-Message-State: AOAM532vPy3iSd4wkdL0k8nJavomMBuwOusAQ8yonWKew2CZngEUyIKo
        Z83KwwzlooQQ84VBRDAJzOs=
X-Google-Smtp-Source: ABdhPJxGY2bfusF5uLULG7HQhQQNx6pScSfHbK6VJCc8lradSg9bAHRHfa7bUhuLBCUZG6LzyV+d5Q==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr10968050pjb.63.1592223115715;
        Mon, 15 Jun 2020 05:11:55 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id q186sm13905972pfc.166.2020.06.15.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:11:55 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id AE02D23603D8; Mon, 15 Jun 2020 21:11:53 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch, chris@chris-wilson.co.uk
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] drm/kselftest: fix spellint typo in test-drm_mm.c
Date:   Mon, 15 Jun 2020 21:11:51 +0900
Message-Id: <20200615121151.1557985-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36c6ebe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in test-drm_mm.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 9aabe82dcd3a..31602134c515 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -2359,7 +2359,7 @@ static int __init test_drm_mm_init(void)
 	while (!random_seed)
 		random_seed = get_random_int();
 
-	pr_info("Testing DRM range manger (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
+	pr_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
 		random_seed, max_iterations, max_prime);
 	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
 
-- 
2.27.0.83.g0313f36c6ebe


Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C82FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DE920767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkFT/OKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJJ0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgGJJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:25:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BDC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so5179178wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wIuyTvTvTJehZ+ep4u+btSK7FBgl8Se97pFISO/LVI=;
        b=hkFT/OKKaCVHN11jflC/fdm+RLpdfEW5QzjKHoRIV83mbHg0kxzBgflvSleihR1y3C
         IL77si70ouX8ODvCbisl4SEzwfXpAbk5C37LoWPUSGT52UzRQfnpiI2funI5ZDtgLxl+
         qfSE1wpoO3i5thBjaC1/rh5xZ39v1P/yRWx1PaQhggyZMpVyLD/DpeFqZAzVpUDNMIPx
         gwBaYwV6Ti3xpX5DTmnppuh+8T4HgrYnz56IL48KE6/0uY5nA8Tc54jsl1f+Wa2yalQD
         00RZwn6eESTl/qmuF2Bc3TmceHPg/zFr2GGwdbKNHat5ymFfYLm0l8wB3LziB0utQBsc
         f1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wIuyTvTvTJehZ+ep4u+btSK7FBgl8Se97pFISO/LVI=;
        b=CLP6EglCPjX3El3hH7xdS3ezYfEJ29+VZCyeu6fjbUWXakfh1YMrRlwoAFaL7r0fze
         GGisWUBYN6PDK2/yCPMohdcx5Lc7dJZx0gfSxIDJRV+Omoj5LBpVWtAIRKBTmHyM2nJz
         wAvD1KnQGNtRm3A8Pqls2BuPapX+3YGC4/ZPo08bVHrqtno1J93CbegmxpAutTYMP5x2
         RnBXnv4/bolnm83y3dZCy9aEi+91WJfJ59y6sKfTlbEc5KQLD96veY6cEyoAUArTi0dJ
         IMxxCVmuYIz4HR/CcFwuAAJe1k/lLUVf+WAEXkJPHUikPPH4G6PguQbARiaFNg/Fz3Qb
         t2ww==
X-Gm-Message-State: AOAM530mkX+IQYDKYf7dW+Frxlu9a6w2FrPwl5+uJln4vfmhXnZGG/mI
        M/qHpGfhOSsZut21PkU0IWQ=
X-Google-Smtp-Source: ABdhPJyGC3VRr1XqdZe9/UFYTPcwbWdNcHpTpKQDrfBZtF31oThwz+2jQt6IrAk+oh/6dpsYTbhH8Q==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr67154778wrm.193.1594373155819;
        Fri, 10 Jul 2020 02:25:55 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:25:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 03/14] drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
Date:   Fri, 10 Jul 2020 11:25:37 +0200
Message-Id: <20200710092548.316054-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use devfreq variable that will be lock with spinlock in future
patches. We should either introduce a function to access this one
but as devfreq is optional let's just remove it.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 360146f6f3d9..4c13dbae68fb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -581,10 +581,6 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
 	struct panfrost_job_slot *js = pfdev->js;
 	int i;
 
-	/* Check whether the hardware is idle */
-	if (atomic_read(&pfdev->devfreq.busy_count))
-		return false;
-
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* If there are any jobs in the HW queue, we're not idle */
 		if (atomic_read(&js->queue[i].sched.hw_rq_count))
-- 
2.25.1


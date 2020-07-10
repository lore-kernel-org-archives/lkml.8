Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9877B20725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS12xL4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJJ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgGJJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:25:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6F2C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so5350682wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ciy3HDqvKk5PARaiKZGCtCw2SjWa+ryFuI+p7pTDJCM=;
        b=CS12xL4MC/BksNlaIwRvyjwByz6TExJ0myJwWurq4UfyGNLpbsSrkuNF/quq0IrCw0
         xRCpPjeHPg0vcncegyAUUCeWP1J4CIVCXwsjxoz6JtF1zhhsm+hCrJZhqUuMRR9bBhJX
         ba0Syb94q0gwzHGWJqAhCZbu1t67N7v6rFtiCR/o5Q7YANVO2fl0VjnrV/qewiMGABS2
         LC4Qu0DHz1muygT+uGpJrxahKYbuNbb8UT39MeH0vK+DpFcSG0CxtR+f3pfyxtCr2Wp6
         lbHyuEEI0ttwpwZSc8PYtlgzBElPlte8lwG9OfuL4QJnZBSV7p6DaSoWuIB2DrSAhe7u
         sBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ciy3HDqvKk5PARaiKZGCtCw2SjWa+ryFuI+p7pTDJCM=;
        b=F4ZGGzV/x0Q7GVc+ijxyyWMfx1mDJnVLHvMEtTx8YzZTEIX4lZq68Bh1nHo8mgODTJ
         WGV8Of182h4xcpFuiHi1xSHXzmlWZDFlUaVZedZiqOK74c8XFlQHVD3WysymLAxDT2i5
         v89PAPEjwDiLgogPITRztxjGUDxfvTkm8mzCRq7PK2B+zNxQTx494UVBhNcYttbanXJv
         Ch8hBGP+q9Ej3Lji5T0nur18NMT7QS+OxYzcDor86ZPr6xaSSsxfk0rjIAWzXZ3QDBpd
         PSPFZX5pAeu6eWHuiWB7rxjW4x97U3Jh/qgP1qVw1LlTBlnKkb3XXuPaGdrcVJ/suUzu
         lfwA==
X-Gm-Message-State: AOAM531O8xcAZ9x6tPWlgF0lRqjF1XDFf7J6BODTriAYC5QUJ+XmeE3/
        megD88cTcRGNuyMWSPp6wtY=
X-Google-Smtp-Source: ABdhPJwyGsfKRK2ok2A3GZOj8rkfOYAVuUfKijampNPqAXAT3B9HhIiWfpDKg6V5bv2Bk2P0wHopUw==
X-Received: by 2002:a05:600c:2511:: with SMTP id d17mr4368631wma.127.1594373154688;
        Fri, 10 Jul 2020 02:25:54 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:25:54 -0700 (PDT)
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
Subject: [PATCH v4 02/14] drm/panfrost: clean headers in devfreq
Date:   Fri, 10 Jul 2020 11:25:36 +0200
Message-Id: <20200710092548.316054-3-peron.clem@gmail.com>
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

Don't include not required headers and sort them.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 1b560b903ea6..df7b71da9a84 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -1,18 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2019 Collabora ltd. */
+
+#include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
-#include <linux/clk.h>
-#include <linux/regulator/consumer.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
-#include "panfrost_features.h"
-#include "panfrost_issues.h"
-#include "panfrost_gpu.h"
-#include "panfrost_regs.h"
 
 static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
 {
-- 
2.25.1


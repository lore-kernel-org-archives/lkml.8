Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F18C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B90B208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS2gSZNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGDK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgGDKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2802C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so35270857wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uyp/MfaDITohcGBEN+pDw23B/gCn7tCuAyxbyBm56M=;
        b=hS2gSZNYwy/ZY2DBi6VycIP0XgCiAQvLzQbonhggp0zl69dzXQxeTngj314MAY2pBO
         YVyBsVuJg/sTryjpXZHBKHVES/nVJgsiPhRuN4LxZJSOQDPLjuyR9fPyn1LxXxjnXfTS
         yaTJh/daGv7gV/5UmAfQYI/c/gMep45swriGx6RKB5S0axtuK6JXWfve3XrS1s/xYc+Y
         gEWA5yxWrgxL1a0KHfyJQUNllGNjmtbr+WGwQ6Wivy56IMl4I9NPFnms/ksB8xWO0Kpe
         wc+IcTtXVvg++aoFbv8Fw807+90zvO50EtDWCZr4phVpt0Y7ARzG+jE/xYNDrRQHBUh9
         MAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uyp/MfaDITohcGBEN+pDw23B/gCn7tCuAyxbyBm56M=;
        b=qlanNuBp2WSonvCyduxrkp1ux3KOqK63qAPhZRzcQFkw4IGwEvJETTskWdHGfTznl0
         Ob0FWF11IRKoM4gILqGeGeZ8u/FAIQxYCGQl6FT6v4gW4YFhfXKBkT/I+ha/kxrJu2sI
         wledEengJ8kWCUREPz2kBa6SLdqnsyuv3j7YXha5AuzOK2ViPUXlaytfhgpm+54qET8+
         yzDmi3LsyhNrhjEqhYE6/DID+l14flerbQ0ozFopd4An9aR4hiQRQfsdYLPmkmd1RKOf
         mP9tOTCvS93QK0bXYeDaXLTlGa0RFadKO2hZVloIrnHfF28c22QcfMzepvT2TTeaTA5R
         GMtQ==
X-Gm-Message-State: AOAM532Sm0pvIF0qC2ls/CLCjsfEi46Iyk+qbPFKBl09ipRb3wc8vQtI
        yjMjIPAz5G1PhZ+z0U3L5Lo=
X-Google-Smtp-Source: ABdhPJwDC6OrmJ3KyitbYyv9GGaSuSJ8BHvwjptu2GIXtAgJx6HO9WktHkuYPp8IujxLo+KSXAhw0g==
X-Received: by 2002:adf:8091:: with SMTP id 17mr28205914wrl.13.1593858344483;
        Sat, 04 Jul 2020 03:25:44 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:43 -0700 (PDT)
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
Subject: [PATCH v2 02/14] drm/panfrost: clean headers in devfreq
Date:   Sat,  4 Jul 2020 12:25:23 +0200
Message-Id: <20200704102535.189647-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't include not required headers and sort them.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE860C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D30E20786
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6ZLdbzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGJJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgGJJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8CEC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so5290264wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ciy3HDqvKk5PARaiKZGCtCw2SjWa+ryFuI+p7pTDJCM=;
        b=E6ZLdbzEcVMkO+y+P9AnK26+CL9Gii7HowUb0y8r871JmlAOtpsmlg4q3u3RWYvJBz
         Q952Bfv3QVNsjwHmqNLgsp0zBkj/wAEIswxRb8szToMHEwMJWEzSajuvPrXMjyJAbC6l
         2jhisYIBYvelO7bWNmvBhf75KQTxFa2xP0baS4elXjau8Ju9MImntLZJSB4NtvUl7XOf
         24nTmYHNG2sC4aQdoUoz6vm9kKytPw1+Fd2FzGw9VqE/1MyypSXx7wWSs8KmbAn+FA23
         IzXT2tJKkvkNf8SpWQqlClpjMum4AoHDeFGTbeEsMjqDu3BwqocRat4DXYPd2kHZjbUt
         nplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ciy3HDqvKk5PARaiKZGCtCw2SjWa+ryFuI+p7pTDJCM=;
        b=CH/26illGvYGK/R2jwE8bd3jfHtDcBAq5trjkjPOyvViB9Sb3pnr4oOu0NR7JibGDv
         sdJVAhfau4Ci/aX07QzuFZ/nlvijCLQpT/ykFABOJUnO+cveUf3JMcTdiBBabIH0zICL
         M+Qc01T4orOt/lnO6VBgcNMzvIIdsNm2j3pHfdvC+Q7Yu5ge8hNBT2+kd5cpxB5z4kA5
         yvx22fIYnYV5VMTIJlq1pAcC1k1I8AhsWnpONj300kmKN1K4uRmxBafoet/8A47yz+v9
         obbUWsYWDI0mBTzQ2qJq4396iHssCT0GSOcy1GXaA/Daj930OrPpRBGgWRZ4nhVRMX4q
         xiDQ==
X-Gm-Message-State: AOAM532TO6N1L+M0LwMObOqto7jMV78VCeMFRB6zHDwSdHF1+x5IW/Vx
        knOnbJCURm2m8/mQQcLQSMo=
X-Google-Smtp-Source: ABdhPJxydbxqntuMQsGKoGZGdLY0/lHB7ypQPuA+b6q6L1xs17oMsk0rnQUbeamN86SZTzmI5d1HCw==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr65977070wrq.407.1594374854728;
        Fri, 10 Jul 2020 02:54:14 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:13 -0700 (PDT)
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
Subject: [PATCH v5 02/14] drm/panfrost: clean headers in devfreq
Date:   Fri, 10 Jul 2020 11:53:57 +0200
Message-Id: <20200710095409.407087-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
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


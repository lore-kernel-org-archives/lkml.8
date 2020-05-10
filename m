Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF618C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D2C20820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDkMYRXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgEJQzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728849AbgEJQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C246C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so1443533wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8UE18pCOZAfJo/w5THwQJ6FMg6LICrZ1Evr9g3xVdI=;
        b=EDkMYRXi7wtLjEhK2L0/ce9M37GzwRQ+JciCHsBHDqE8BSg395qaMTKehVjyf3wERr
         lHpTMZpUeL7LiZMTKM23Q6B9IxKp/OjcOamFqu/FTiAIvIgHKSi7ZDAyI2gNwhqyEjQv
         3KNolQxMevQ7uSA/y/XtAU/pDqsY4xetoZEySMxoZ0sszpktEn+vBcLM+EsIbo8mPcIb
         LbjWBB7Kqv0+AFyVwIJRM/y7KvUMeScFkmF/hq3XQzrS1wt7vqhAlzMZZitbR0X6tlaz
         +lgdw3cO8PZVFimCOHSTMxVQNDe+YLumbioRF+i6XkvkJjwvmhGZ9o8+8cQUU9S6PW+E
         rpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8UE18pCOZAfJo/w5THwQJ6FMg6LICrZ1Evr9g3xVdI=;
        b=fiSgy4R10j/LX2k9bJHJ0azUttLt2gdEtRH+odk/ME7fOW/qC4obNrjEFQ53JKCC8U
         fB47rH16gN+pWFU9wnxAiBeztresrDPgMHDy6DOzr8sw5zYR72vjC3TsKyxmHdg/aucW
         ifCNlnbprLInokeUYwZrpT8wlSM4SGx8v8vqkjWFIAhe2zN9NjUaUL27kEgHaB0PTLaW
         0Zuc6agGc22LtHm1kCWW8didBvn77gpqT7mULSY+2CBwrletQA+jclGz+1nDv7A4td0d
         6tu2gyUKRc5LDCLPH3WVB4G+OgWm8WCVyQQrlq4KE040J0Nd/FAfXPT0LkRN61MO1f8d
         w6rw==
X-Gm-Message-State: AGi0PuZ5oN8JnQrpi4f7SrwLcZ4i+nIASpSXchykgU1ZnhyMJpTrSqNG
        tiZ+IrL1PUdwjKXojy52mJmFgF4pC/M=
X-Google-Smtp-Source: APiQypJJwRD+VbQWR/BDoQEXOHxwwcjQSwAjkeW+rRkHkwxah1eAHal5gfV7ivYVJ81DX7eY5fpRIg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr27009245wma.32.1589129744055;
        Sun, 10 May 2020 09:55:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:43 -0700 (PDT)
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
Subject: [PATCH 02/15] drm/panfrost: clean headers in devfreq
Date:   Sun, 10 May 2020 18:55:25 +0200
Message-Id: <20200510165538.19720-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't include not required headers and sort them.

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
2.20.1


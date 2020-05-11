Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB7C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5779120801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5REeB1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgEKM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729956AbgEKM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so4479633pgr.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAOdTLiRF08BUGeoQQ1jSCIZohHvIFy/T0eMMRKNkxU=;
        b=v5REeB1awFWWiZJIHs+HLAiK9bYOBbBuQpiUTIqqwxpvkMO1MgmR+4SKDJVW76qhSx
         K7eSzt4rGMus/hn4a+7NbaOPBUksJyD7ZbjD7ZCJFUX11tiYXVxXWv2Uxa1Mm8BpjrQq
         /1CchWZ5kwaGLYxmr4QJwnHnE4raFD+NWF2U4FTCwMz3aquotGpzaCwzn9Q6Uvn4hRUy
         7mZGfJzCO8Pb5ndWrTC6Z6adunwD+43NALhyA7MHb+yYGsIBFTE1dDbR5xVO9zRbZqb1
         naGbX8HAylwK2maSE9h79X+9DEnUhCUPw7XxNfYMieYaXeukN6Ob2Q+rXavCwcBp5G1d
         vEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAOdTLiRF08BUGeoQQ1jSCIZohHvIFy/T0eMMRKNkxU=;
        b=X2oWqPJpzX1GP9xSgURpcrO1cUKHwC6ixN39iNu5tZE8st3YC19+8faqGy9PlIS0Ck
         bFeSWWIUncvb4j39zKByhQ7EXxDuPKQ/xftr9jFGxqpUYAA0DP62wJWvVRqeYNgmau0l
         b2FbNvJzwJ2QsOGp6aL0QDex5t+9dQEgcpLA4WD33cfRB60fQlaa4UCY/hr9TSz55eIi
         zE3ZkOSkRKG17itnDXM2fb5NibAhiZO8l1Q+SlObOfiI7lm3ba5T/eRK8G9iW0HO8woy
         7LLO2GrphsxmMrmVb2H1YqhZGIu51kX0C8HeEPKWcOZYtFwRmRKUFfIlSSn/wy7Rvd5M
         uanQ==
X-Gm-Message-State: AGi0PuZxHacLRzhHix6QnosiNA8WA3hX+PDxNIar6xDN3k6YGqd4+Kvu
        Mu8Fg9kRIebSgfrjW9KPAF1ChctET0c=
X-Google-Smtp-Source: APiQypKSroADbKGwHiCUkmx+QfJra7jTrOyksev3CxoHSSW87/DHYXa1AdvxPdBZTV2QARSMXREDPg==
X-Received: by 2002:a62:6807:: with SMTP id d7mr16211381pfc.296.1589199964522;
        Mon, 11 May 2020 05:26:04 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id 78sm4687636pgd.33.2020.05.11.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:03 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 08/14] thermal/drivers/clock_cooling: Include export.h
Date:   Mon, 11 May 2020 17:54:56 +0530
Message-Id: <25f16415ab7b7587a052f1bce4133da318d58192.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferrable to include export.h when you are using EXPORT_SYMBOL
family of macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/clock_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
index fd6bc6eefc88..56cb1f46a428 100644
--- a/drivers/thermal/clock_cooling.c
+++ b/drivers/thermal/clock_cooling.c
@@ -16,6 +16,7 @@
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/mutex.h>
 #include <linux/pm_opp.h>
-- 
2.20.1


Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD70C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410E6207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJUWfTi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgEKMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729728AbgEKMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:25:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B317FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so3867551pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLCRFYTzZLs87148l1yniv86hl5UQjMO56irWxi7zno=;
        b=fJUWfTi+qjf0FA2vuOSnTB0kWzbREj9eSNDAzVs5d927tPPCjePaekBQZBD85KG3F5
         VED09Zw9mO6pK3PzOrC53yjo0W0be0i+lTottKW2/2Fg9uYNKryVuZNqeIaoNFTXCRG0
         mT/ztpancw2WtnOgZ3uWRikTIwKOlWXkuSh91mPYIS8GqEsj3wgVImPOKrMXT6F1MB4r
         hJmh63wUvsY8p1sRYQULAt3IAY5Toywe/F34PL9BilNxjlw2v2K70baqsl9bx+Sr140+
         7LLC16fOi5LV9JDjFENTNTiv9WCLaYx9KB8KliZ7oK46glMCLvA0+w88QSlaz+ZlD56u
         d/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLCRFYTzZLs87148l1yniv86hl5UQjMO56irWxi7zno=;
        b=JjagJDMi7VKy5CtbLr6UK0Jb9eK4Jy80COng45vqWAXt3F5evxZnRKfE6JTgMP7bbv
         W9yLLFEa6+GAN+m8GLfTqHmtrZoc1cMEUfsrqWPp53N63dJm96CdfbLkjx5ehmMQpYKg
         Kfzjet4+L4/d5TRTrDp772iUCvnfsPBjZ+RI2mYcJcXVkT2eh4osRWCOitS2wl+THw0H
         3QK4t3+xA2lDe/kb5Ghn+0qV/TVrTO2M3x0sTjhMkNvsqvTEfOc3p7p9MEP5d8cSbkiY
         Jai4lSWX6QuRZ1d2LMWP/vKnstLE/ddq9ijPgLFnSHrCd8ZGki0Sxj6ZYXH4gHA7IOBt
         OrCg==
X-Gm-Message-State: AGi0Pubb3AA64ATXRrdlt/uYXi4Ll0oBetzhZk4tnQ+5cc5+Dfrow+Ef
        Gk6UpK8h11I5+CJ73NGs23QHOk6u7Sg=
X-Google-Smtp-Source: APiQypL4e2jZtE6SohQMnQNdslV/ugdx7IF6yNh08RpdGCBWZWJA/HkPdZcOy2ptOK+0q4I15bUFVQ==
X-Received: by 2002:a17:902:9049:: with SMTP id w9mr15139757plz.27.1589199943796;
        Mon, 11 May 2020 05:25:43 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id a196sm9240989pfd.184.2020.05.11.05.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:43 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 03/14] thermal/drivers/thermal_helpers: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:51 +0530
Message-Id: <133db154796f354e6c51e6310095f679e1f45441.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers to make it easier to read and find duplicate headers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756af76b7..8ea0a05404f7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -12,11 +12,11 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 
 #include <trace/events/thermal.h>
 
-- 
2.20.1


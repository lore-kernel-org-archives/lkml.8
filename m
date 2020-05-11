Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CCC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F0E207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msnddFvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEKMZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729563AbgEKMZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:25:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60ACC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f7so4669057pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdgxJAfo8UlOucy5NbULhDRr0uCqBFbRyMqqRo+7u8o=;
        b=msnddFvTNtREqRm1El3S+W4nTTsmznmrMM8BRZnGmgRRKKCpgTeN+txsF0X/hMWJX/
         UqTVTj5Pef0yCJ3QfSE1xhvLaHRTrNwVQU6N6VbVqj8shMvwdYqlNGPCCRgZc3IS8oby
         xpeF7qKWEwPHKMNpFwfPDmuL5H1ylxizE6U8NyipfpXoO8xKcCFAjyqD4iRriULgLxJV
         uOiJu/bPq34/DiTf6IR34VkDxUGnUovvj7Y8zLKdkkQPlTGJzZEWvJCfRfoGeRIGq+Im
         PBs4nWgbVC+wspgBwfuxwB6lV5oiftjrnnViI8EbunEnXvsp59JcpOlrbqcCtqGJHCRK
         6qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdgxJAfo8UlOucy5NbULhDRr0uCqBFbRyMqqRo+7u8o=;
        b=a0B5ODW44cpqKOkaLX5PoBRAg5m8CbNP1+rqOSN50MNBT1hB4u9RpBa4S0IoFb4+ES
         9F/d0LgHb7VHC29HHGGgwpaQyr5t3XDNDhtAVSXrhM74NDcCefrJKhRzEGi0KiOifc9y
         I2xQ9YxJLXT4r34WWdCd3fDz3xqS3J662Vv9fL1hfTy/ap1l7X9kiHUz8lKXvR575hZW
         /8wj7yMbgdoOB3Y3HSkaOk9l2Zx5jaNWLdMtsYcN2JQeIBlOC/1DiC1QgKBzCuEbkiWd
         z2zylkBt7MZDuYXWF7EeNtBG4X8y66L8m+Tc5gdn4isN7/N2au901UV5J9b5fKDjSops
         kI0w==
X-Gm-Message-State: AGi0PuY71TdIveUHyxhNnO6DcY8qhLBpJD0g7/E34gCTBVKt0MBJmT5T
        wj5UODfinZG+cX3J9h5JdTzENn4gAn0=
X-Google-Smtp-Source: APiQypIK/SJv2BvkXBQiXCCg/PqqSZRvMjBVTYP8zmpY8DlH8pIJgGgLmuJJ3RVi1ndH5W+cXRRa0g==
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr14019205pga.243.1589199939763;
        Mon, 11 May 2020 05:25:39 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id s136sm9344242pfc.29.2020.05.11.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:39 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 02/14] thermal/core: Replace module.h with export.h
Date:   Mon, 11 May 2020 17:54:50 +0530
Message-Id: <33af23406dcdb0c62dae1e6401446b997ccb449f.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal core cannot be modular, remove the unnecessary module.h include
and replace with export.h to handle EXPORT_SYMBOL family of macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 286920e06277..bed4a7bea7bb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -9,9 +9,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
-- 
2.20.1


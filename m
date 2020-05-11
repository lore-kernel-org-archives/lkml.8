Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9791C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88841207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euAP57wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgEKMZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729563AbgEKMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:25:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BFEC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so3861250plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8aLBVF/jCNJkdmjTC/dudzjrY2tWkvRd1FtJjGwyUk=;
        b=euAP57wveF2y86MHZ6NV58TG0vSv9YKmBb6lQBV0IXubepFm2dNRippIbx93bponZ/
         5wu/RJRdOf1qM2bbmrGpSz6ojY2+0ae6Qi4gMb85pkSOp3p5T8376FlCZC/M5FXpk4hx
         T/CG2lZEw/CxOK3WQJXCioactq2A219Yv7f39F7U1X06RdQKm2O0Tcq9G7B+DEFMpvre
         GOUC/s4gXAOPn04Knsz2blgFHT8mZH61ngqCNUywerOsLd4Dd7ttlBYrsWsIFdMTSZID
         5AuWs8pFndMg5h1/INazI5Eygmo5OCwm53sWmj7im2uP1zvY/+pyW4Ie2fzgz1l8KdY7
         s3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8aLBVF/jCNJkdmjTC/dudzjrY2tWkvRd1FtJjGwyUk=;
        b=GaacplfdqOSiiFY35kNbQZgnxWH7YfQN32TUD6/btxOK3Q/GpBV8eRQPojB02xQEzm
         KHYWwj+7T53l6WytfSJqkhMPSOhuPlcoP/uDUPEsh7y0y+ZPmDYRkCfitD0hUFZaE6xR
         MRVl8BE+Fdb1xdyG4uR5A/yC0515ne56VlhxIVlRF1f0ffhzPzhNhYmxYZWPEvfx4iST
         /4wCUaH50eLkfx3u97kotASA0LKWelvLAutJkWZEMUk7H9OreVCTApOlivzajitCqH4i
         goKLTo9yZciLt9onxOIObgeov37hjppu2prnkvqNYQkpYXv94tJq7GXqG7pUIg4D8/Pu
         RlMg==
X-Gm-Message-State: AGi0PuaE00MkGW+HVqWzumtl4x65jerZ6PwDOTZYb2DpVKD0Y4nqVdSN
        qbEmMr7K/QII74MjhQ+LB9s7Ja2EaK4=
X-Google-Smtp-Source: APiQypJ4qBRsFtSTkkiLyjxDBfw6clVcHL7/Oi64wn/3ZpAx5AIZwfiiazyOlZANpe6NwClLBYs2lA==
X-Received: by 2002:a17:90a:1501:: with SMTP id l1mr22882557pja.82.1589199935696;
        Mon, 11 May 2020 05:25:35 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id q6sm9049534pfh.193.2020.05.11.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:34 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 01/14] thermal/core: Get rid of MODULE_* tags
Date:   Mon, 11 May 2020 17:54:49 +0530
Message-Id: <74339a09a55f8f3d86c4074fc2bf853a302d6186.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework can no longer be compiled as a module as of
commit 554b3529fe01 ("thermal/drivers/core: Remove the module Kconfig's
option"). Remove the MODULE_* tags.

Rui is mentioned in the copyright line at the top of the file and the
license is mentioned in the SPDX tags. So no loss of information.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..286920e06277 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -27,10 +27,6 @@
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
-MODULE_AUTHOR("Zhang Rui");
-MODULE_DESCRIPTION("Generic thermal management sysfs support");
-MODULE_LICENSE("GPL v2");
-
 static DEFINE_IDA(thermal_tz_ida);
 static DEFINE_IDA(thermal_cdev_ida);
 
-- 
2.20.1


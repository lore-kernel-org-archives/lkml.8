Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F60C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B3C20801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwhHoSUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgEKM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729978AbgEKM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF3C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so1957121plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOzb3IhTI9yPWNl3XI2lYK3qvd7pN2r4jllGR7pHWUQ=;
        b=pwhHoSUCVHs+05wGk4aMRqL1g9yeGAnLqwAgGUoSMQJ0rc7mu49oBcm9LjSVrbFYZQ
         t8Xvu3w3mIEtvn8POrFFF4fBtnl5XqCOZTO6CZ0tE57miFK5qYk64oC4SpZzNnQ5hlhK
         JNMsaI4WqG0kAe0ql2N3FSfvRtcBG3byYgGV1o/GR6F3gwnDSJdsX3GOrgU8z3S0R2U2
         x8hTwg9E6VxijuJydfTP+Nt8OK03Qk9t6cMuu9hSEAj8J0iZ+WJ3UYmUZ5elnhJHN9UJ
         Md6pZGWSMG/GjmxQOFdcq4oGCcQXmBlDLKggHQ02Vo2gx3VHutK/phHRuGIiPP9/26pX
         pzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOzb3IhTI9yPWNl3XI2lYK3qvd7pN2r4jllGR7pHWUQ=;
        b=VSBoXF4gXzd67KxvhAyhBAJwj2DkunDaDRBDZ4SgbcnxhV6igINwDL+E1KVaa6d1AX
         njnKfhCY/iP8/dc4SWZ2r+OpKVCVOzamuY/MXAGGuoh3X9rp+qfmHZ1GHpbIwwY6C8Al
         M9qIlhbb13EEhciCyYLv4d5OKIZgXa3+gW5qvZtUzItWEuI+MF4Hr/UuylGbELFIK7Mx
         vlIgygO5KMro1FsPHRhs/G0veQZ0VzPUrdUiFzlCVz7Ik//OkrcIpAuPDJvZ7BMmGtTa
         zwYosucfa6pCvLcBP0agm1gyuuyBbtpU84z2Mpg3zNQzUNQAxJs70WbmJ8qKLFEUNFWq
         SPLA==
X-Gm-Message-State: AGi0PuaxWhdwQXB0cz51Taxdn42c1Edmps3cyfpH+q0avfi1EnhNbLKu
        jGl1oTam+Ax7TKKSYVMf7hYFg1LeHBc=
X-Google-Smtp-Source: APiQypII8GF6w8vhEPnDEzE0HX6p4o0aWnNJi62GTULFdKWxm4PZwjkfcd95O3F+qhRPvFrwVWV1pw==
X-Received: by 2002:a17:90a:748:: with SMTP id s8mr21384120pje.221.1589199968762;
        Mon, 11 May 2020 05:26:08 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id 1sm9253822pff.180.2020.05.11.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:08 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 09/14] thermal/drivers/cpufreq_cooling: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:57 +0530
Message-Id: <4231f5dfe758b9bf716981be71cadf9642c83528.1589199124.git.amit.kucheria@linaro.org>
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
 drivers/thermal/cpufreq_cooling.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e297e135c031..1b5a63b4763d 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -11,16 +11,16 @@
  *
  */
 #include <linux/module.h>
-#include <linux/thermal.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
-#include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
-#include <linux/energy_model.h>
+#include <linux/thermal.h>
 
 #include <trace/events/thermal.h>
 
-- 
2.20.1


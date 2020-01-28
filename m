Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9001C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C53214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmaI5cMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgA1WgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45492 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA1WgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so15106788qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YJHWah+Fmu6VB7l8k5EqA83O5eUGrSI3jHksR1KtXQQ=;
        b=XmaI5cMcHYY17M8XnRh24LRsGFvd4mB9lTrWmU6hds4+MUtCB1X3kGbJWz+npkyC8+
         nfNI0wyOB7uACWKKc66XDCbeZVO95QXleW4Y43WGT1JZvm1Ew6/0GLWcwYWmp7AMECw6
         +hWE6e4OVK+jQrEFYdfMHtD46GcNWBK1fQ1myhJR/ygvKxF88T+ENvRYxTSjD2XWfVgk
         j+bCcu4YQg7karjvnLJnxb1teWP/+DMXhFYKAyi7peBfpbTHxLWAiilSwMy8ixTkEw+d
         CU+QSTzwPKu0hYI7yJ8oT+cTabvtL0Ab+Vci8NAjngiwakuEXJ+r1TdQRhr/lzbIds1T
         FLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YJHWah+Fmu6VB7l8k5EqA83O5eUGrSI3jHksR1KtXQQ=;
        b=Fo9hxjMfT5rnoA7leEOujLR130PF5zJBL1p9sTnTtgEdug0CdDJGVbGYZhUDr1U7US
         K6VJw+k0D0znZqgYQAhNC8TQOzOYYbghpyVJJ086TiZYffpyEbVfxxF5eUOP40QiaepD
         O8n21OjDhrngn187HNxziiHidNpJD/LpNKHjE9wo5ZY2DYO4Yp6YwOeQMMMbg3bDiWwR
         1jln7qeHWz5yX0z7E4tVaIgFuB2ju7waRuOl8l85GdFkOICwKTiR1PndkryDANRJrrJ1
         4pChBaezvpOY/SodZvxatErrNVE8Ctab+DZfGj5nkcsrEwRgPNGjlPzteYqd/8yx+rUU
         V7/A==
X-Gm-Message-State: APjAAAUdu60puRepo2oRnCl17xNv9JCocpCWNZhcbOFlmgOi0CFKxp3v
        i6Q5U1hLc/mqeqrHPseJaIXk8Q==
X-Google-Smtp-Source: APXvYqwFbdMGJW7S1EOnEkuedwALEyLHObRbDc7PLKf0GKrL04UVIEsEssZZc8ZyPUtg4QbMbJ89cw==
X-Received: by 2002:a05:620a:13e3:: with SMTP id h3mr24325310qkl.319.1580250978395;
        Tue, 28 Jan 2020 14:36:18 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:17 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 5/8] sched/fair: update cpu_capacity to reflect thermal pressure
Date:   Tue, 28 Jan 2020 17:36:04 -0500
Message-Id: <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity initially reflects the maximum possible capacity of a cpu.
Thermal pressure on a cpu means this maximum possible capacity is
unavailable due to thermal events. This patch subtracts the average thermal
pressure for a cpu from its maximum possible capacity so that cpu_capacity
reflects the actual maximum currently available capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v8->v9:
	- Use thermal_load_avg to read rq->avg_thermal.load_avg.

 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5f58c03..d879077 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7753,8 +7753,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 	if (unlikely(irq >= max))
 		return 1;
 
+	/*
+	 * avg_rt.util avg and avg_dl.util track binary signals
+	 * (running and not running) with weights 0 and 1024 respectively.
+	 * avg_thermal.load_avg tracks thermal pressure and the weighted
+	 * average uses the actual delta max capacity(load).
+	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4


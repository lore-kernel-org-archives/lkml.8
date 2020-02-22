Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AECC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08386206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1rvCpaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBVAwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39291 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBVAw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id p34so2648651qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eU/3FEEqMRCv+cqTDac/hC8UNjSgSvHFY09GS+uFIIU=;
        b=a1rvCpaYYbKr/Cb2GJymSSjj5ZybcUDGEmuy7iWbSm9scU559QF5yyGJ5JwcZuuZxP
         3qHASBQJnAcA4gpH5Uf6YsrrefNIz3ZlJb9/HKDiFlzLuNpkSZN10KOrv3sHkZv5FhlX
         LWusTxxQWuaAq1MmUvHuK7BAuaPQ1MtblZi6bZ2PJJq/qOrXir1U9GJmYUIWJTc6kzLx
         GJu8qcBbIUVaCVx4CmTOhTl9yQ65/TQuli8gDRrtv19l0JNbTT/XjaVtT3mZ6dlv6Pc7
         WDrdhdB+y5Tx6tb+cBuUJpojl9MWd2vj0Wg8T/FCZ8lGsSMJfTpA+VQ8+mHteh8xGEvF
         0FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU/3FEEqMRCv+cqTDac/hC8UNjSgSvHFY09GS+uFIIU=;
        b=HhBBaIh4hxgawedFmPBtqqRT61nNDwrh5U2lX4vGQp23FiwQN1VksWvos2nAVHk5r6
         YjVTXVfBJmjwOrluhy6vS13gXCreSz7njSBAIyezp0rSbivi04jSWMk+k9cZtmLZPrBo
         jZ5eMFhwGLY5YJRyL5hecuFLnKGBBbHaq9nUs5RNADhdbhImrdk9oGJjgVrc6LbcvE9S
         84d4zh2NX91CbIaymIS/ngimJ8mCcWNsTO8KflDjF1Cn7+bxwJjpRooPJKZtPifIaP8w
         LvITfHxovOvllObJNqULU/JI+Vr2+O2s5gNNo6vLRo4XLcxXlS0WxVLcnbqiULCV+yXE
         SKNA==
X-Gm-Message-State: APjAAAW16S68/S5icTM6cn+JcLPF9d5o17hvJVv26XKBhIprsen4yIu6
        zvrJ6LX/FMlwmekYeeNwF4RexA==
X-Google-Smtp-Source: APXvYqzMgbKpqWat8p0UjFXMCANYvwfjjH0hGxpz4x9GA43GRmxxGUy5l6dHrPbGKVv4HKYq18ijUw==
X-Received: by 2002:ac8:83d:: with SMTP id u58mr33792975qth.60.1582332745304;
        Fri, 21 Feb 2020 16:52:25 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:24 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 7/9] sched/fair: update cpu_capacity to reflect thermal pressure
Date:   Fri, 21 Feb 2020 19:52:11 -0500
Message-Id: <20200222005213.3873-8-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity initially reflects the maximum possible capacity of a cpu.
Thermal pressure on a cpu means this maximum possible capacity is
unavailable due to thermal events. This patch subtracts the average
thermal pressure for a cpu from its maximum possible capacity so that
cpu_capacity reflects the remaining maximum capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v8->v9:
	- Use thermal_load_avg to read rq->avg_thermal.load_avg.

 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00b21a5b71f0..10e867e540ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7800,8 +7800,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 	if (unlikely(irq >= max))
 		return 1;
 
+	/*
+	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
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
2.20.1


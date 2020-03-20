Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAFCC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9C720409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMiqKpov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTJg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:36:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:36:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so2938757pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6OV3MJtnwHmBj9IvKnU2jj48Eg9Ml8gSZFTsDf/nk+o=;
        b=WMiqKpovon8ayUXjyLEzv+OwMEUBJuBJ9hMuktNFhY48Izr1idFbw/MfFmkPOhcj+v
         9xrTbQVEe8K8ivSs5OdJjDBT0a6OKM6QijTie2/86RINbmZPPsZVfOSqmleNzQinxJYM
         doma38WDeC+P0oQdXIaTsD73zWM3+4WL1V616nq8+Uylhqt+oIO/mU5AgZkvm1/6VOsL
         NPLWitsRMMhYzSR1scFRab3D3WAYBssMMfcVEaIkExqRk+W+pDWTb4aE0qGpAbam0yHx
         QFGz7DKIgtXlWY5ysY8OoqQqp95tCHEO7MfsI8+vV8eRzJEahvt40VrH0lAjvloN2rgR
         +caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6OV3MJtnwHmBj9IvKnU2jj48Eg9Ml8gSZFTsDf/nk+o=;
        b=ZeapaqhuveOlTXUhyH/re+LhOMyAihkynQVy/7DMmO8TeZGbZchP9nx2knHAtjI+tA
         GNxI8YQU6oLKs1zVt6Hw7/eLuz9t6nBOIj0Ro3/PN3mKpKTVFErjV2az7ldaop+GOY+3
         q9sjW8/GHof9LJZtmtNr9R5vRLuIsqEaufEaQv3Xzk+P0AbZ5Vg8DV2/fup8Cs4FiYaD
         80riV/FumZ37i5Q1bhoE2cGh4QbPkzQtAgFc3Yje8mXuSQDLQP9aQtiANDQLtH+Pvdms
         b1js3Xt2ixFqSqOEoVFZ+Qy5KecPlUe+IefjrIay//nY/L2jzvi/hO0vdhd8xzSyB1HM
         JNfg==
X-Gm-Message-State: ANhLgQ1Sfg2j01QPKSH07xISll6UA34ODUa3apdiSSINj4GCwx0YGR0M
        yHwrarVv4JamvCyb/bj9q6BGqw==
X-Google-Smtp-Source: ADFU+vu96g4sr+58Bfq6iUmA7kCu4qTiGLNvmkhrbuyuayATxiGwtwonY7BFIsC+CTiPCHCvDNHBhQ==
X-Received: by 2002:a63:68a:: with SMTP id 132mr7844539pgg.12.1584696982648;
        Fri, 20 Mar 2020 02:36:22 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id g11sm4868415pfm.4.2020.03.20.02.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Mar 2020 02:36:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Date:   Fri, 20 Mar 2020 17:35:45 +0800
Message-Id: <20200320093545.28227-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between the system powering on and kernel's sched clock registration,
the arch timer usually has been enabled at the early time and its
counter is incremented during the period of the booting up.  Thus the
arch timer's counter is not completely accounted into the sched clock,
and has a delta between the arch timer's counter and sched clock.  This
delta value should be stored into userpg->time_offset, which later can
be retrieved by Perf tool in the user space for sample timestamp
calculation.

Now userpg->time_offset is assigned to the negative sched clock with
'-now', this value cannot reflect the delta between arch timer's counter
and sched clock, so Perf cannot use it to calculate the sample time.

To fix this issue, this patch calculate the delta between the arch
timer's and sched clock and assign the delta to userpg->time_offset.
The detailed steps are firstly to convert counter to nanoseconds 'ns',
then the offset is calculated as 'now' minus 'ns'.

        |<------------------- 'ns' ---------------------->|
                                |<-------- 'now' -------->|
        |<---- time_offset ---->|
        |-----------------------|-------------------------|
        ^                       ^                         ^
  Power on system     sched clock registration      Perf starts

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index e40b65645c86..226d25d77072 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1143,6 +1143,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 {
 	u32 freq;
 	u32 shift;
+	u64 count, ns, quot, rem;
 
 	/*
 	 * Internal timekeeping for enabled/running/stopped times
@@ -1164,5 +1165,21 @@ void arch_perf_update_userpage(struct perf_event *event,
 		userpg->time_mult >>= 1;
 	}
 	userpg->time_shift = (u16)shift;
-	userpg->time_offset = -now;
+
+	/*
+	 * Since arch timer is enabled ealier than sched clock registration,
+	 * compuate the delta (in nanosecond unit) between the arch timer
+	 * counter and sched clock, assign the delta to time_offset and
+	 * perf tool can use it for timestamp calculation.
+	 *
+	 * The formula for conversion arch timer cycle to ns is:
+	 *   quot = (cyc >> time_shift);
+	 *   rem  = cyc & ((1 << time_shift) - 1);
+	 *   ns   = quot * time_mult + ((rem * time_mult) >> time_shift);
+	 */
+	count = arch_timer_read_counter();
+	quot = count >> shift;
+	rem = count & ((1 << shift) - 1);
+	ns = quot * userpg->time_mult + ((rem * userpg->time_mult) >> shift);
+	userpg->time_offset = now - ns;
 }
-- 
2.17.1


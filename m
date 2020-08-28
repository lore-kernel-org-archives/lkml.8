Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA8C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A28A2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648201;
	bh=dIv1ceqeNhOt7tRLZtHMTPoYPJq6N69lxO1FEip8Mns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zun7iXDLl7SPbigYANJFbJq9Wn/QJKNKq0psbnbAa0mhMw6vwxE+k/m3p6+UQc1FR
	 mEf5hpIsZcRaNLiT7Gy5Va7nnOQBjYJoU9n4mHbTgHHdq6oy5rBv+ri9A5JOJOBKCB
	 FAuQW+X3pzEIQufVrt7rDAU97yKxPFRG0TEDEd1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgH1U4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35928 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgH1U4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:23 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so426798iow.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evx4ES4Aelq1S/aOsFR1P9EyHf1WVald+woJD7LPgyY=;
        b=lc+KPO6lgi1hWWSshEM3ugjEAMMGpOvFIt9zFc0fmGh3KzHDA8iFcKpWHX/7r04f6k
         9eClExpxnBJSYGv7R9eAOs2wPkWTCd6s26B6x60H1qu8eAavmr/qa8IjU1kqXOHDHz6g
         iJXZGKhToFZalurjP6vTH+nwdIn6T4yf3V6m4yUZwdAYjtqPt5eDyHJ94MegeiJqUSn0
         awtDkZFnPfU63nQ8LjFAXzGy8Vdb2UA80iiRs3ATsl63WZ2kdIGMVslkoArnzcaC1g2V
         MUIzxsEsB7bTi2u96YpWVSpoCDfkY1tHXg85eZp9EPAyRrfyQT1e5bm6PxO+bFOlmy0L
         ZDaQ==
X-Gm-Message-State: AOAM533G41wlSw4iqfnZgvNrBj8qMBd7QhbOnYo/Kqy7p308fMqXkOTa
        Sk828ktvE3HM9Ehxg4eguzW+oXXR6Sjr
X-Google-Smtp-Source: ABdhPJypI31ImBS1JmU/eH+7KFMncrMHvRX9icJjvWxAYvi0V7t78i7lRsf3xVi38t2egWOebYJwVA==
X-Received: by 2002:a05:6602:2c03:: with SMTP id w3mr475639iov.39.1598648182743;
        Fri, 28 Aug 2020 13:56:22 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 2/9] arm64: pmu: Add function implementation to update event index in userpage
Date:   Fri, 28 Aug 2020 14:56:07 -0600
Message-Id: <20200828205614.3391252-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

In order to be able to access the counter directly for userspace,
we need to provide the index of the counter using the userpage.
We thus need to override the event_idx function to retrieve and
convert the perf_event index to armv8 hardware index.

Since the arm_pmu driver can be used by any implementation, even
if not armv8, two components play a role into making sure the
behaviour is correct and consistent with the PMU capabilities:

* the ARMPMU_EL0_RD_CNTR flag which denotes the capability to access
counter from userspace.
* the event_idx call back, which is implemented and initialized by
the PMU implementation: if no callback is provided, the default
behaviour applies, returning 0 as index value.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 21 +++++++++++++++++++++
 include/linux/perf/arm_pmu.h   |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 70538ae684da..2727d126cecd 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -820,6 +820,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 		clear_bit(idx - 1, cpuc->used_mask);
 }
 
+static int armv8pmu_access_event_idx(struct perf_event *event)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return 0;
+
+	/*
+	 * We remap the cycle counter index to 32 to
+	 * match the offset applied to the rest of
+	 * the counter indices.
+	 */
+	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
+		return 32;
+
+	return event->hw.idx;
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -916,6 +932,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	if (!armv8pmu_event_is_chained(event))
+		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1092,6 +1111,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 5b616dde9a4c..74fbbbd29dc7 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -26,6 +26,8 @@
  */
 /* Event uses a 64bit counter */
 #define ARMPMU_EVT_64BIT		1
+/* Allow access to hardware counter from userspace */
+#define ARMPMU_EL0_RD_CNTR		2
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
-- 
2.25.1


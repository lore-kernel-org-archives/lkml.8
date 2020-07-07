Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CA6206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155226;
	bh=TjuiSNQ/S1+HAtOktq25UWZCS6KVqNl53nLxfjgvEnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yN7f1pBREygoLHe14y7sed1fYXFhBDTG9EZGOvUACto8Ay6JqBi6oSx8A6oRptdD4
	 I/7cWKdTS0ZoWNYKgLTOH5lNYp9ZpTZ7xINVVwxGcFHPtPj/QMo4DE7N964XY6W/oK
	 Rx39l1PsuAcGtwTdP1cGWJy2s0Sh4ur/fVP9J7gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgGGUxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:53:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36799 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgGGUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:53:40 -0400
Received: by mail-io1-f65.google.com with SMTP id y2so44697065ioy.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhfRFaZ90G0JMwxeaYoDicB01Rayzt9DHGWdTJ6hTJk=;
        b=rXce85+SvcFTPCikuyS7hiheFWfios3t3Zwr378ArYPNCyF/4j4Ty/GEHtvwHTrzcw
         lxGKgpJjkhXrVdsDmmArxdQzEFkpgzTxdHETk6BDChI9nYr9UC0XhPFrm8fXsslq9rR9
         A75jzed3EgErkbXatHFZGEiLB0V/mNaxzkuUIA+aB2hcD8l9CVchSeEe3SvX7xaptR+g
         16mUD8IKzYAy4Ii0dwDeuYr+yCtNtLTGQmJgDa/msp6LoHBRE4tR74MZ11hZGcIRABMR
         f0IFEANPw1Tq4oQg4x5ukO5mzeitBvp0W7fk28aWa6WPK8UcX4ITGJAGegDQV2LWhCcX
         fQIQ==
X-Gm-Message-State: AOAM531V7bpUkRnH4o/z3OMHvBcWbgeN4tXJjEdSaFfoaCeWstp8ktcJ
        JmHrDMsQQBSjQwF0SCqSvg==
X-Google-Smtp-Source: ABdhPJy7I2LPyEAyTZpdH0SmzmLPUX63mNolI2dvixJEtMp/CvGtaOWX4x+HOgYECpSZmcbbLr3ccA==
X-Received: by 2002:a02:1784:: with SMTP id 126mr63647056jah.53.1594155219446;
        Tue, 07 Jul 2020 13:53:39 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id y6sm13110712ila.74.2020.07.07.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:53:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/5] arm64: pmu: Add function implementation to update event index in userpage
Date:   Tue,  7 Jul 2020 14:53:31 -0600
Message-Id: <20200707205333.624938-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707205333.624938-1-robh@kernel.org>
References: <20200707205333.624938-1-robh@kernel.org>
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
index d4b4fe69fe2c..6c12a6ad36f5 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -795,6 +795,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
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
@@ -891,6 +907,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;

+	if (!armv8pmu_event_is_chained(event))
+		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1068,6 +1087,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
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

Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476A1C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D8E24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707554;
	bh=6QVl2Y6AQgc438oMSLIit47nbEPKECWEiKiMG+7af9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLAm1sKm6aluwU6P/J/dQH19nkMQqgpUpprWCULdi6Sf9H2OhE58uyjjBUizxX/NZ
	 rZlNQTi5iwdtuAgFfVsasmU5clzojTsd0E2c9/7VISYL9Bg2D8EnXcRSObs/orPFfs
	 NNV8CYnD+s5257Lk+tXhp4G2UFinUe+6QVmiSm2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbgBNTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbgBNTMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:30 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2A224654;
        Fri, 14 Feb 2020 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707549;
        bh=6QVl2Y6AQgc438oMSLIit47nbEPKECWEiKiMG+7af9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bk6Uf7KC22XYeh+HLkJbPBRnc7nkJ95dqM9HBdABCiraYQL1oLNNactuXYO0JcZ2V
         aeBXRBLwVj1kyx9oKcyvC+OvYk+m2oiuioaOQT1zQE9sMiE318Ho17hjsuO83d/Koz
         GaAlQyjHZ5BdvA1L06ZuZ+1JXtSkNTArUXNlmmSs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/23] perf tools: Add arm64 version of get_cpuid()
Date:   Fri, 14 Feb 2020 16:10:50 -0300
Message-Id: <20200214191057.26266-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add an arm64 version of get_cpuid(), which is used for various annotation
and headers - for example, I now get the CPUID in "perf report --header",
as shown in this snippet:

  # hostname : ubuntu
  # os release : 5.5.0-rc1-dirty
  # perf version : 5.5.rc1.gbf8a13dc9851
  # arch : aarch64
  # nrcpus online : 96
  # nrcpus avail : 96
  # cpuid : 0x00000000480fd010

Since much of the code to read the MIDR is already in get_cpuid_str(),
factor out this code.

Tester notes:

I tested this patch on my new ARM64 Kunpeng 920 server.
[root@node1 zsk]# ./perf --version
perf version 5.6.rc1.g2cdb955b7252

Both perf list and perf stat can work.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1576245255-210926-1-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/header.c | 63 ++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index a32e4b72a98f..d730666ab95d 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,8 +1,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
+#include <util/cpumap.h>
 #include <internal/cpumap.h>
 #include <api/fs/fs.h>
+#include <errno.h>
 #include "debug.h"
 #include "header.h"
 
@@ -12,26 +14,21 @@
 #define MIDR_VARIANT_SHIFT      20
 #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
 
-char *get_cpuid_str(struct perf_pmu *pmu)
+static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 {
-	char *buf = NULL;
-	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
-	int cpu;
 	u64 midr = 0;
-	struct perf_cpu_map *cpus;
-	FILE *file;
+	int cpu;
 
-	if (!sysfs || !pmu || !pmu->cpus)
-		return NULL;
+	if (!sysfs || sz < MIDR_SIZE)
+		return EINVAL;
 
-	buf = malloc(MIDR_SIZE);
-	if (!buf)
-		return NULL;
+	cpus = perf_cpu_map__get(cpus);
 
-	/* read midr from list of cpus mapped to this pmu */
-	cpus = perf_cpu_map__get(pmu->cpus);
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
+		char path[PATH_MAX];
+		FILE *file;
+
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
 				sysfs, cpus->map[cpu]);
 
@@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		break;
 	}
 
-	if (!midr) {
+	perf_cpu_map__put(cpus);
+
+	if (!midr)
+		return EINVAL;
+
+	return 0;
+}
+
+int get_cpuid(char *buf, size_t sz)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
+	int ret;
+
+	if (!cpus)
+		return EINVAL;
+
+	ret = _get_cpuid(buf, sz, cpus);
+
+	perf_cpu_map__put(cpus);
+
+	return ret;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	int res;
+
+	if (!pmu || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
+	if (res) {
 		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
 		free(buf);
 		buf = NULL;
 	}
 
-	perf_cpu_map__put(cpus);
 	return buf;
 }
-- 
2.21.1


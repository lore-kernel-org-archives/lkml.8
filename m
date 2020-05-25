Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39374C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3F0206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbgEYIGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:06:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:29983 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387807AbgEYIGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:06:03 -0400
IronPort-SDR: mZBqJjr+pTtMzuBovhiIYsA/+dATOIhAgmruR1N+rU+Hw6yMs6KDMuvjnJQ67GyKsOS5zqczQN
 jMu4F9iusErA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 01:06:02 -0700
IronPort-SDR: LPVC6ACfZ09obxnET5c66MzJSph5uZ69GXGD5/VjZVlB+fTHRM4vaicVZUG1dtA5ufmCU0JZfx
 Ms8myRIlkSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="441658131"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2020 01:05:58 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@linux.intel.com
Subject: [RESEND PATCH v9 1/3] perf/x86/intel/uncore: Expose an Uncore unit to PMON mapping
Date:   Mon, 25 May 2020 11:05:52 +0300
Message-Id: <20200525080554.21313-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200525080554.21313-1-alexander.antonov@linux.intel.com>
References: <20200525080554.21313-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Each Uncore unit type, by its nature, can be mapped to its own context -
which platform component each PMON block of that type is supposed to
monitor.

Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
significant changes in the integrated I/O (IIO) architecture. The new
solution introduces IIO stacks which are responsible for managing traffic
between the PCIe domain and the Mesh domain. Each IIO stack has its own
PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
or various built-in accelerators. IIO PMON blocks allow concurrent
monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.

Software is supposed to program required perf counters within each IIO
stack and gather performance data. The tricky thing here is that IIO PMON
reports data per IIO stack but users have no idea what IIO stacks are -
they only know devices which are connected to the platform.

Understanding IIO stack concept to find which IIO stack that particular
IO device is connected to, or to identify an IIO PMON block to program
for monitoring specific IIO stack assumes a lot of implicit knowledge
about given Intel server platform architecture.

Usage example:
    ls /sys/devices/uncore_<type>_<pmu_idx>/die*

Co-developed-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/uncore.c |  8 ++++++++
 arch/x86/events/intel/uncore.h | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cf76d6631afa..b71e8f7529a4 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -843,10 +843,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 			.read		= uncore_pmu_event_read,
 			.module		= THIS_MODULE,
 			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			.attr_update	= pmu->type->attr_update,
 		};
 	} else {
 		pmu->pmu = *pmu->type->pmu;
 		pmu->pmu.attr_groups = pmu->type->attr_groups;
+		pmu->pmu.attr_update = pmu->type->attr_update;
 	}
 
 	if (pmu->type->num_boxes == 1) {
@@ -887,6 +889,9 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 	struct intel_uncore_pmu *pmu = type->pmus;
 	int i;
 
+	if (type->cleanup_mapping)
+		type->cleanup_mapping(type);
+
 	if (pmu) {
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			uncore_pmu_unregister(pmu);
@@ -954,6 +959,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	type->pmu_group = &uncore_pmu_attr_group;
 
+	if (type->set_mapping)
+		type->set_mapping(type);
+
 	return 0;
 
 err:
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 0da4a4605536..8f2b77d27513 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -72,7 +72,19 @@ struct intel_uncore_type {
 	struct uncore_event_desc *event_descs;
 	struct freerunning_counters *freerunning;
 	const struct attribute_group *attr_groups[4];
+	const struct attribute_group **attr_update;
 	struct pmu *pmu; /* for custom pmu ops */
+	/*
+	 * Uncore PMU would store relevant platform topology configuration here
+	 * to identify which platform component each PMON block of that type is
+	 * supposed to monitor.
+	 */
+	u64 *topology;
+	/*
+	 * Optional callbacks for managing mapping of Uncore units to PMONs
+	 */
+	int (*set_mapping)(struct intel_uncore_type *type);
+	void (*cleanup_mapping)(struct intel_uncore_type *type);
 };
 
 #define pmu_group attr_groups[0]
-- 
2.19.1


Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C47FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AAA20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgFPMYV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgFPMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD75C08C5C6;
        Tue, 16 Jun 2020 05:21:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb4-0004aR-OY; Tue, 16 Jun 2020 14:21:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 444A91C0478;
        Tue, 16 Jun 2020 14:21:46 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:46 -0000
From:   "tip-bot2 for Roman Sudarikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Expose an Uncore unit to PMON mapping
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        Roman Sudarikov <roman.sudarikov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200601083543.30011-2-alexander.antonov@linux.intel.com>
References: <20200601083543.30011-2-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159231010609.16989.6525389884153038879.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     19a39819818dee57e363bd44bd096e2e940a456b
Gitweb:        https://git.kernel.org/tip/19a39819818dee57e363bd44bd096e2e940a456b
Author:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
AuthorDate:    Mon, 01 Jun 2020 11:35:41 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:51 +02:00

perf/x86/intel/uncore: Expose an Uncore unit to PMON mapping

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

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20200601083543.30011-2-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore.c |  8 ++++++++
 arch/x86/events/intel/uncore.h | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cbe32d5..49255e6 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -846,10 +846,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
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
@@ -890,6 +892,9 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 	struct intel_uncore_pmu *pmu = type->pmus;
 	int i;
 
+	if (type->cleanup_mapping)
+		type->cleanup_mapping(type);
+
 	if (pmu) {
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			uncore_pmu_unregister(pmu);
@@ -957,6 +962,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	type->pmu_group = &uncore_pmu_attr_group;
 
+	if (type->set_mapping)
+		type->set_mapping(type);
+
 	return 0;
 
 err:
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 7859ac0..7caba06 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -73,7 +73,19 @@ struct intel_uncore_type {
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

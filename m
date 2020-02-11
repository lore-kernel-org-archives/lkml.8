Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A0FC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84B92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgBKQQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:16:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:16669 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbgBKQQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:16:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="266309611"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2020 08:15:55 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH v5 1/3] perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
Date:   Tue, 11 Feb 2020 19:15:47 +0300
Message-Id: <20200211161549.19828-2-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

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
    ls /sys/devices/uncore_<type>_<pmu_idx>/node*

Each Uncore unit type, by its nature, can be mapped to its own context,
for example:
1. CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice
   of LLC capacity;
2. UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel
   UPI Subsystem;
3. IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the
   IIO module;
4. IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of
   Memory Controller.

Implementation details:
Optional callback added to struct intel_uncore_type to discover and map
Uncore units to PMONs:
    int (*set_mapping)(struct intel_uncore_type *type)

Details of IIO Uncore unit mapping to IIO PMON:
Each IIO stack is either DMI port, x16 PCIe root port, MCP-Link or various
built-in accelerators. For Uncore IIO Unit type, the mapping file
holds bus numbers of devices, which can be monitored by that IIO PMON block
on each die.

Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 5 +++++
 arch/x86/events/intel/uncore.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86467f85c383..98ab8539f126 100644
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
@@ -954,6 +956,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	type->pmu_group = &uncore_pmu_attr_group;
 
+	if (type->set_mapping)
+		type->set_mapping(type);
+
 	return 0;
 
 err:
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index bbfdaa720b45..8821f35e32f0 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -72,7 +72,12 @@ struct intel_uncore_type {
 	struct uncore_event_desc *event_descs;
 	struct freerunning_counters *freerunning;
 	const struct attribute_group *attr_groups[4];
+	const struct attribute_group **attr_update;
 	struct pmu *pmu; /* for custom pmu ops */
+	/* PMON's topologies */
+	u64 *topology;
+	/* mapping Uncore units to PMON ranges */
+	int (*set_mapping)(struct intel_uncore_type *type);
 };
 
 #define pmu_group attr_groups[0]
-- 
2.19.1


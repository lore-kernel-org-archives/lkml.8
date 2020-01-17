Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE62C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0504520728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAQNiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:38:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:44152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgAQNiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:38:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 05:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="373653195"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2020 05:38:04 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH v4 1/2] perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
Date:   Fri, 17 Jan 2020 16:37:58 +0300
Message-Id: <20200117133759.5729-2-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
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
    /sys/devices/uncore_<type>_<pmu_idx>/mapping

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
Two callbacks added to struct intel_uncore_type to discover and map Uncore
units to PMONs:
    int (*get_topology)(struct intel_uncore_type *type, int max_dies)
    int (*set_mapping)(struct intel_uncore_type *type, int max_dies)

Details of IIO Uncore unit mapping to IIO PMON:
Each IIO stack is either DMI port, x16 PCIe root port, MCP-Link or various
built-in accelerators. For Uncore IIO Unit type, the mapping file
holds bus numbers of devices, which can be monitored by that IIO PMON block
on each die.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 46 ++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore.h |  6 +++++
 2 files changed, 52 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86467f85c383..55201bfde2c8 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -825,6 +825,44 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static ssize_t mapping_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_uncore_pmu *pmu = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%s\n", pmu->mapping);
+}
+static DEVICE_ATTR_RO(mapping);
+
+static struct attribute *mapping_attrs[] = {
+	&dev_attr_mapping.attr,
+	NULL,
+};
+
+static struct attribute_group mapping_group = {
+	.attrs = mapping_attrs,
+};
+
+static umode_t
+not_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return 0;
+}
+
+static const struct attribute_group *attr_update[] = {
+	&mapping_group,
+	NULL,
+};
+
+static void uncore_platform_mapping(struct intel_uncore_type *t)
+{
+	if (t->get_topology && t->set_mapping &&
+	    !t->get_topology(t, max_dies) && !t->set_mapping(t, max_dies))
+		mapping_group.is_visible = NULL;
+	else
+		mapping_group.is_visible = not_visible;
+}
+
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 {
 	int ret;
@@ -849,6 +887,8 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		pmu->pmu.attr_groups = pmu->type->attr_groups;
 	}
 
+	pmu->pmu.attr_update = attr_update;
+
 	if (pmu->type->num_boxes == 1) {
 		if (strlen(pmu->type->name) > 0)
 			sprintf(pmu->name, "uncore_%s", pmu->type->name);
@@ -859,6 +899,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 			pmu->pmu_idx);
 	}
 
+	/*
+	 * Exposing mapping of Uncore units to corresponding Uncore PMUs
+	 * through /sys/devices/uncore_<type>_<idx>/mapping
+	 */
+	uncore_platform_mapping(pmu->type);
+
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (!ret)
 		pmu->registered = true;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index bbfdaa720b45..1b3891302f6d 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -73,6 +73,11 @@ struct intel_uncore_type {
 	struct freerunning_counters *freerunning;
 	const struct attribute_group *attr_groups[4];
 	struct pmu *pmu; /* for custom pmu ops */
+	u64 *topology;
+	/* finding Uncore units */
+	int (*get_topology)(struct intel_uncore_type *type, int max_dies);
+	/* mapping Uncore units to PMON ranges */
+	int (*set_mapping)(struct intel_uncore_type *type, int max_dies);
 };
 
 #define pmu_group attr_groups[0]
@@ -99,6 +104,7 @@ struct intel_uncore_pmu {
 	int				pmu_idx;
 	int				func_id;
 	bool				registered;
+	char				*mapping;
 	atomic_t			activeboxes;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
-- 
2.19.1


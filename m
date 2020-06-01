Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BEBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816D22076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgFAIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:35:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:62255 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgFAIfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:35:55 -0400
IronPort-SDR: DO1PGqAJi3fjFNoz78y8pFoovKHaipclTHNhE6DQ/dx38Mm0OFrdxYRh26C7SLOjUXh75rL4r+
 +nJpoMT76U8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 01:35:54 -0700
IronPort-SDR: Kpmy5UPE2fTyrv8lCYcrigXA9+kB1sRZXtqSfrfoM82Iio9Waq524ZtaoMJMne6x3felYSGNv6
 E/7vOHJRcuwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,460,1583222400"; 
   d="scan'208";a="303565680"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2020 01:35:51 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        lkp@intel.com
Cc:     alexander.antonov@linux.intel.com
Subject: [PATCH v10 2/3] perf/x86/intel/uncore: Wrap the max dies calculation into an accessor
Date:   Mon,  1 Jun 2020 11:35:42 +0300
Message-Id: <20200601083543.30011-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200601083543.30011-1-alexander.antonov@linux.intel.com>
References: <20200601083543.30011-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

The accessor to return number of dies on the platform.

Co-developed-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 13 +++++++------
 arch/x86/events/intel/uncore.h |  3 +++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b71e8f7529a4..e4f37dc83cf0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -16,7 +16,7 @@ struct pci_driver *uncore_pci_driver;
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
 struct pci_extra_dev *uncore_extra_pci_dev;
-static int max_dies;
+int __uncore_max_dies;
 
 /* mask of cpus that collect uncore events */
 static cpumask_t uncore_cpu_mask;
@@ -108,7 +108,7 @@ struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return dieid < max_dies ? pmu->boxes[dieid] : NULL;
+	return dieid < uncore_max_dies() ? pmu->boxes[dieid] : NULL;
 }
 
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event)
@@ -879,7 +879,7 @@ static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
 {
 	int die;
 
-	for (die = 0; die < max_dies; die++)
+	for (die = 0; die < uncore_max_dies(); die++)
 		kfree(pmu->boxes[die]);
 	kfree(pmu->boxes);
 }
@@ -920,7 +920,7 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 	if (!pmus)
 		return -ENOMEM;
 
-	size = max_dies * sizeof(struct intel_uncore_box *);
+	size = uncore_max_dies() * sizeof(struct intel_uncore_box *);
 
 	for (i = 0; i < type->num_boxes; i++) {
 		pmus[i].func_id	= setid ? i : -1;
@@ -1120,7 +1120,7 @@ static int __init uncore_pci_init(void)
 	size_t size;
 	int ret;
 
-	size = max_dies * sizeof(struct pci_extra_dev);
+	size = uncore_max_dies() * sizeof(struct pci_extra_dev);
 	uncore_extra_pci_dev = kzalloc(size, GFP_KERNEL);
 	if (!uncore_extra_pci_dev) {
 		ret = -ENOMEM;
@@ -1547,7 +1547,8 @@ static int __init intel_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return -ENODEV;
 
-	max_dies = topology_max_packages() * topology_max_die_per_package();
+	__uncore_max_dies =
+		topology_max_packages() * topology_max_die_per_package();
 
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 	if (uncore_init->pci_init) {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 8f2b77d27513..8621b66c49ef 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -181,6 +181,9 @@ int uncore_pcibus_to_physid(struct pci_bus *bus);
 ssize_t uncore_event_show(struct kobject *kobj,
 			  struct kobj_attribute *attr, char *buf);
 
+extern int __uncore_max_dies;
+#define uncore_max_dies()	(__uncore_max_dies)
+
 #define INTEL_UNCORE_EVENT_DESC(_name, _config)			\
 {								\
 	.attr	= __ATTR(_name, 0444, uncore_event_show, NULL),	\
-- 
2.19.1


Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C28C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A536E20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBPUQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:16:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:39788 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPUQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:16:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:16:52 -0800
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400"; 
   d="scan'208";a="235038158"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:16:52 -0800
Subject: [PATCH v5 1/6] ACPI: NUMA: Up-level "map to online node"
 functionality
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@kernel.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 16 Feb 2020 12:00:48 -0800
Message-ID: <158188324802.894464.13128795207831894206.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_map_pxm_to_online_node() helper is used to find the closest
online node to a given proximity domain. This is used to map devices in
a proximity domain with no online memory or cpus to the closest online
node and populate a device's 'numa_node' property. The numa_node
property allows applications to be migrated "close" to a resource.

In preparation for providing a generic facility to optionally map an
address range to its closest online node, or the node the range would
represent were it to be onlined (target_node), up-level the core of
acpi_map_pxm_to_online_node() to a generic mm/numa helper.

Cc: Michal Hocko <mhocko@suse.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/srat.c |   41 -----------------------------------------
 include/linux/acpi.h     |   23 ++++++++++++++++++++++-
 include/linux/numa.h     |    9 +++++++++
 mm/mempolicy.c           |   30 ++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index eadbf90e65d1..47b4969d9b93 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
 }
 EXPORT_SYMBOL(acpi_map_pxm_to_node);
 
-/**
- * acpi_map_pxm_to_online_node - Map proximity ID to online node
- * @pxm: ACPI proximity ID
- *
- * This is similar to acpi_map_pxm_to_node(), but always returns an online
- * node.  When the mapped node from a given proximity ID is offline, it
- * looks up the node distance table and returns the nearest online node.
- *
- * ACPI device drivers, which are called after the NUMA initialization has
- * completed in the kernel, can call this interface to obtain their device
- * NUMA topology from ACPI tables.  Such drivers do not have to deal with
- * offline nodes.  A node may be offline when a device proximity ID is
- * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
- * "numa=off" on x86.
- */
-int acpi_map_pxm_to_online_node(int pxm)
-{
-	int node, min_node;
-
-	node = acpi_map_pxm_to_node(pxm);
-
-	if (node == NUMA_NO_NODE)
-		node = 0;
-
-	min_node = node;
-	if (!node_online(node)) {
-		int min_dist = INT_MAX, dist, n;
-
-		for_each_online_node(n) {
-			dist = node_distance(node, n);
-			if (dist < min_dist) {
-				min_dist = dist;
-				min_node = n;
-			}
-		}
-	}
-
-	return min_node;
-}
-EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
-
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0f24d701fbdc..3839363081f3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -416,9 +416,30 @@ extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
 #ifdef CONFIG_ACPI_NUMA
-int acpi_map_pxm_to_online_node(int pxm);
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
+
+/**
+ * acpi_map_pxm_to_online_node - Map proximity ID to online node
+ * @pxm: ACPI proximity ID
+ *
+ * This is similar to acpi_map_pxm_to_node(), but always returns an online
+ * node.  When the mapped node from a given proximity ID is offline, it
+ * looks up the node distance table and returns the nearest online node.
+ *
+ * ACPI device drivers, which are called after the NUMA initialization has
+ * completed in the kernel, can call this interface to obtain their device
+ * NUMA topology from ACPI tables.  Such drivers do not have to deal with
+ * offline nodes.  A node may be offline when a device proximity ID is
+ * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
+ * "numa=off" on x86.
+ */
+static inline int acpi_map_pxm_to_online_node(int pxm)
+{
+	int node = acpi_map_pxm_to_node(pxm);
+
+	return numa_map_to_online_node(node);
+}
 #else
 static inline int acpi_map_pxm_to_online_node(int pxm)
 {
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 110b0e5d0fb0..20f4e44b186c 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,4 +13,13 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+#ifdef CONFIG_NUMA
+int numa_map_to_online_node(int node);
+#else
+static inline int numa_map_to_online_node(int node)
+{
+	return NUMA_NO_NODE;
+}
+#endif
+
 #endif /* _LINUX_NUMA_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 977c641f78cf..756d6e5bb59f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+/**
+ * numa_map_to_online_node - Find closest online node
+ * @nid: Node id to start the search
+ *
+ * Lookup the next closest node by distance if @nid is not online.
+ */
+int numa_map_to_online_node(int node)
+{
+	int min_node;
+
+	if (node == NUMA_NO_NODE)
+		node = 0;
+
+	min_node = node;
+	if (!node_online(node)) {
+		int min_dist = INT_MAX, dist, n;
+
+		for_each_online_node(n) {
+			dist = node_distance(node, n);
+			if (dist < min_dist) {
+				min_dist = dist;
+				min_node = n;
+			}
+		}
+	}
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(numa_map_to_online_node);
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
 	struct mempolicy *pol = p->mempolicy;


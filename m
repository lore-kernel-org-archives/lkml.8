Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7516C7619C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADC52084E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBPURK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:17:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:18172 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPURJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:17:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:17:08 -0800
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400"; 
   d="scan'208";a="227868330"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:17:08 -0800
Subject: [PATCH v5 4/6] x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        vishal.l.verma@intel.com, hch@lst.de, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date:   Sun, 16 Feb 2020 12:01:04 -0800
Message-ID: <158188326422.894464.15742054998046628934.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Currently x86 numa_meminfo is marked __initdata in the
CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
drivers to map reserved memory to a 'target_node'
(phys_to_target_node()), add support for removing the __initdata
designation for those users. Both memory hotplug and
phys_to_target_node() users select CONFIG_NUMA_KEEP_MEMINFO to tell the
arch to maintain its physical address to NUMA mapping infrastructure
post init.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c   |    6 +-----
 include/linux/numa.h |    7 +++++++
 mm/Kconfig           |    5 +++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 99f7a68738f0..2450b21cc28a 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -25,11 +25,7 @@ nodemask_t numa_nodes_parsed __initdata;
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
 
-static struct numa_meminfo numa_meminfo
-#ifndef CONFIG_MEMORY_HOTPLUG
-__initdata
-#endif
-;
+static struct numa_meminfo numa_meminfo __initdata_or_meminfo;
 
 static int numa_distance_cnt;
 static u8 *numa_distance;
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 20f4e44b186c..5773cd2613fc 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,6 +13,13 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+/* optionally keep NUMA memory info available post init */
+#ifdef CONFIG_NUMA_KEEP_MEMINFO
+#define __initdata_or_meminfo
+#else
+#define __initdata_or_meminfo __initdata
+#endif
+
 #ifdef CONFIG_NUMA
 int numa_map_to_online_node(int node);
 #else
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..328268473fec 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -139,6 +139,10 @@ config HAVE_FAST_GUP
 config ARCH_KEEP_MEMBLOCK
 	bool
 
+# Keep arch NUMA mapping infrastructure post-init.
+config NUMA_KEEP_MEMINFO
+	bool
+
 config MEMORY_ISOLATION
 	bool
 
@@ -154,6 +158,7 @@ config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
+	select NUMA_KEEP_MEMINFO if NUMA
 
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y


Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161FC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33832253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgATTTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:19:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:8088 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgATTTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:19:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400"; 
   d="scan'208";a="276230181"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:14 -0800
Subject: [PATCH v3 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, x86@kernel.org
Date:   Mon, 20 Jan 2020 11:03:11 -0800
Message-ID: <157954699175.2239526.11943452958490066628.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
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
phys_to_target_node() users select CONFIG_KEEP_NUMA to tell the arch to
maintain its physical address to numa mapping infrastructure post init.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c   |    6 +-----
 include/linux/numa.h |    6 ++++++
 mm/Kconfig           |    5 +++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 99f7a68738f0..5289d9d6799a 100644
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
+static struct numa_meminfo numa_meminfo __initdata_numa;
 
 static int numa_distance_cnt;
 static u8 *numa_distance;
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 20f4e44b186c..c005ed6b807b 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,6 +13,12 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+#ifdef CONFIG_KEEP_NUMA
+#define __initdata_numa
+#else
+#define __initdata_numa __initdata
+#endif
+
 #ifdef CONFIG_NUMA
 int numa_map_to_online_node(int node);
 #else
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..001f1185eadf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -139,6 +139,10 @@ config HAVE_FAST_GUP
 config ARCH_KEEP_MEMBLOCK
 	bool
 
+# Keep arch numa mapping infrastructure post-init.
+config KEEP_NUMA
+	bool
+
 config MEMORY_ISOLATION
 	bool
 
@@ -154,6 +158,7 @@ config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
+	select KEEP_NUMA if NUMA
 
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y


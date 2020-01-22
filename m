Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD0EC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB4924673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgAVDUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:20:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:64748 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgAVDUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:20:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:20:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="229133166"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:20:38 -0800
Subject: [PATCH v4 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Oliver O'Halloran <oohall@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        x86@kernel.org
Date:   Tue, 21 Jan 2020 19:04:35 -0800
Message-ID: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3 [1]:
- Cleanup numa_map_to_online_node() to remove redundant "if
  (!node_online(node))" (Aneesh)

[1]: http://lore.kernel.org/r/157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com

---

Merge notes:

x86 folks: This has an ack from Rafael for ACPI, and Michael for Power.
With an x86 ack I plan to take this through the libnvdimm tree provided
the x86 touches look ok to you.

---

Cover:

Arrange for platform numa info to be preserved for determining
'target_node' data. Where a 'target_node' is the node a reserved memory
range will become when it is onlined.

This new infrastructure is expected to be more valuable over time for
Memory Tiers / Hierarchy management as more platforms (via the ACPI HMAT
and EFI Specific Purpose Memory) publish reserved or "soft-reserved"
ranges to Linux. Linux system administrators will expect to be able to
interact with those ranges with a unique numa node number when/if that
memory is onlined via the dax_kmem driver [2].

One configuration that currently fails to properly convey the target
node for the resulting memory hotplug operation is persistent memory
defined by the memmap=nn!ss parameter. For example, today if node1 is a
memory only node, and all the memory from node1 is specified to
memmap=nn!ss and subsequently onlined, it will end up being onlined as
node0 memory. As it stands, memory_add_physaddr_to_nid() can only
identify online nodes and since node1 in this example has no online cpus
/ memory the target node is initialized node0.

The fix is to preserve rather than discard the numa_meminfo entries that
are relevant for reserved memory ranges, and to uplevel the node
distance helper for determining the "local" (closest) node relative to
an initiator node.

[2]: https://pmem.io/ndctl/daxctl-reconfigure-device.html

---

Dan Williams (6):
      ACPI: NUMA: Up-level "map to online node" functionality
      mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
      powerpc/papr_scm: Switch to numa_map_to_online_node()
      x86/mm: Introduce CONFIG_KEEP_NUMA
      x86/numa: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   21 --------
 arch/x86/Kconfig                          |    1 
 arch/x86/mm/numa.c                        |   74 +++++++++++++++++++++++------
 drivers/acpi/numa/srat.c                  |   41 ----------------
 drivers/nvdimm/e820.c                     |   18 ++-----
 include/linux/acpi.h                      |   23 +++++++++
 include/linux/numa.h                      |   23 +++++++++
 mm/Kconfig                                |    5 ++
 mm/mempolicy.c                            |   31 ++++++++++++
 9 files changed, 145 insertions(+), 92 deletions(-)

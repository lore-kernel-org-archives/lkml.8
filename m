Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E4C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9121120801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBTGLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:11:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:62141 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBTGLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:11:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 22:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="434727879"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2020 22:11:51 -0800
Date:   Thu, 20 Feb 2020 14:11:51 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        mhocko@suse.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200220061151.GA32521@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-2-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:33:10PM +0800, Baoquan He wrote:
>In section_deactivate(), pfn_to_page() doesn't work any more after
>ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
>It caused hot remove failure:
>
>kernel BUG at mm/page_alloc.c:4806!
>invalid opcode: 0000 [#1] SMP PTI
>CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>Workqueue: kacpi_hotplug acpi_hotplug_work_fn
>RIP: 0010:free_pages+0x85/0xa0
>Call Trace:
> __remove_pages+0x99/0xc0
> arch_remove_memory+0x23/0x4d
> try_remove_memory+0xc8/0x130
> ? walk_memory_blocks+0x72/0xa0
> __remove_memory+0xa/0x11
> acpi_memory_device_remove+0x72/0x100
> acpi_bus_trim+0x55/0x90
> acpi_device_hotplug+0x2eb/0x3d0
> acpi_hotplug_work_fn+0x1a/0x30
> process_one_work+0x1a7/0x370
> worker_thread+0x30/0x380
> ? flush_rcu_work+0x30/0x30
> kthread+0x112/0x130
> ? kthread_create_on_node+0x60/0x60
> ret_from_fork+0x35/0x40
>
>Let's move the ->section_mem_map resetting after depopulate_section_memmap()
>to fix it.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/sparse.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 596b2a45b100..b8e52c8fed7f 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -779,13 +779,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 			ms->usage = NULL;
> 		}
> 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
>-		ms->section_mem_map = (unsigned long)NULL;
> 	}
> 
> 	if (section_is_early && memmap)
> 		free_map_bootmem(memmap);
> 	else
> 		depopulate_section_memmap(pfn, nr_pages, altmap);
>+
>+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>+		ms->section_mem_map = (unsigned long)NULL;
> }
> 
> static struct page * __meminit section_activate(int nid, unsigned long pfn,
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me

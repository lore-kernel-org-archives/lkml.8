Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39623C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B38D2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgBSVpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:45:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:58803 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgBSVpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:45:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 13:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="236022531"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2020 13:45:14 -0800
Date:   Thu, 20 Feb 2020 05:45:33 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        mhocko@suse.com
Subject: Re: [PATCH v2 RESEND] mm/sparsemem: pfn_to_page is not valid yet on
 SPARSEMEM
Message-ID: <20200219214533.GA20781@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200219030454.4844-1-bhe@redhat.com>
 <20200219115042.e8738272455292d3a6a6e498@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219115042.e8738272455292d3a6a6e498@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:50:42AM -0800, Andrew Morton wrote:
>On Wed, 19 Feb 2020 11:04:54 +0800 Baoquan He <bhe@redhat.com> wrote:
>
>> From: Wei Yang <richardw.yang@linux.intel.com>
>> 
>> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
>> doesn't work before sparse_init_one_section() is called. This leads to a
>> crash when hotplug memory:
>> 
>> [   41.839170] BUG: unable to handle page fault for address: 0000000006400000
>> [   41.840663] #PF: supervisor write access in kernel mode
>> [   41.841822] #PF: error_code(0x0002) - not-present page
>> [   41.842970] PGD 0 P4D 0
>> [   41.843538] Oops: 0002 [#1] SMP PTI
>> [   41.844125] CPU: 3 PID: 221 Comm: kworker/u16:1 Tainted: G        W         5.5.0-next-20200205+ #343
>> [   41.845659] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>> [   41.846977] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
>> [   41.847904] RIP: 0010:__memset+0x24/0x30
>> [   41.848660] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
>> [   41.851836] RSP: 0018:ffffb43ac0373c80 EFLAGS: 00010a87
>> [   41.852686] RAX: ffffffffffffffff RBX: ffff8a1518800000 RCX: 0000000000050000
>> [   41.853824] RDX: 0000000000000000 RSI: 00000000000000ff RDI: 0000000006400000
>> [   41.854967] RBP: 0000000000140000 R08: 0000000000100000 R09: 0000000006400000
>> [   41.856107] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
>> [   41.857255] R13: 0000000000000028 R14: 0000000000000000 R15: ffff8a153ffd9280
>> [   41.858414] FS:  0000000000000000(0000) GS:ffff8a153ab00000(0000) knlGS:0000000000000000
>> [   41.859703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   41.860627] CR2: 0000000006400000 CR3: 0000000136fca000 CR4: 00000000000006e0
>> [   41.861716] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   41.862680] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   41.863628] Call Trace:
>> [   41.863983]  sparse_add_section+0x1c9/0x26a
>> [   41.864570]  __add_pages+0xbf/0x150
>> [   41.865057]  add_pages+0x12/0x60
>> [   41.865489]  add_memory_resource+0xc8/0x210
>> [   41.866017]  ? wake_up_q+0xa0/0xa0
>> [   41.866416]  __add_memory+0x62/0xb0
>> [   41.866825]  acpi_memory_device_add+0x13f/0x300
>> [   41.867410]  acpi_bus_attach+0xf6/0x200
>> [   41.867890]  acpi_bus_scan+0x43/0x90
>> [   41.868448]  acpi_device_hotplug+0x275/0x3d0
>> [   41.868972]  acpi_hotplug_work_fn+0x1a/0x30
>> [   41.869473]  process_one_work+0x1a7/0x370
>> [   41.869953]  worker_thread+0x30/0x380
>> [   41.870396]  ? flush_rcu_work+0x30/0x30
>> [   41.870846]  kthread+0x112/0x130
>> [   41.871236]  ? kthread_create_on_node+0x60/0x60
>> [   41.871770]  ret_from_fork+0x35/0x40
>> 
>> We should use memmap as it did.
>> 
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Baoquan He <bhe@redhat.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>
>This should have included your signed-off-by, as you were on the patch
>delivery path.  I have made that change to my copy of the patch - is
>that OK?
>
>I also added a cc:stable.  Do we agree this is appropriate?

Agree with this.

>
>I added Dan's "On x86 the impact is limited to x86_32 builds, or x86_64
>configurations that override the default setting for
>SPARSEMEM_VMEMMAP." to the changelog.

-- 
Wei Yang
Help you, Help me

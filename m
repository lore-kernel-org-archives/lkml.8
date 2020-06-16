Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE985C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1965206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgFPL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:57:21 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:51200 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFPL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:57:20 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 07:57:18 EDT
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 05GBpxUA091422;
        Tue, 16 Jun 2020 14:51:59 +0300 (EEST)
X-AuditID: 8b5b014d-257ff700000045c5-06-5ee8b2592d99
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id B8.3F.17861.952B8EE5; Tue, 16 Jun 2020 14:51:53 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 16 Jun 2020 14:51:53 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Zong Li <zong.li@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Register System RAM as iomem resources
Organization: FORTH
In-Reply-To: <063fab26f4c15bf5b833b57fa818749afa7811d4.1592292685.git.zong.li@sifive.com>
References: <cover.1592292685.git.zong.li@sifive.com>
 <063fab26f4c15bf5b833b57fa818749afa7811d4.1592292685.git.zong.li@sifive.com>
Message-ID: <0e1d7a917332b90666417ac0508f8a6d@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.9
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXSHT1dWTdy04s4g6cPrC0u75rDZrHtcwub
        xcvLPcwWbbP4LT7cnc3mwOrx5uVLFo/NS+o9LjVfZ/f4vEkugCWKyyYlNSezLLVI3y6BK+Pw
        lnlsBRMFK068WsDYwPiSt4uRk0NCwETi8ZZpbF2MXBxCAkcZJd5enscGkTCVmL23kxHE5hUQ
        lDg58wkLiM0sYCEx9cp+RghbXqJ562xmEJtFQFViSksPWC+bgKbE/EsHwepFBBQkrizZCNVb
        IbH1328mEFtYwE3i1b+9YHF+AWGJT3cvsoLYnAKREl/WfGWBOKiFUWL13VnMEEe4SLw6e4IJ
        4jgViQ+/H7CD2KICyhI3Dz9nn8AoOAvJrbOQ3DoLya0LGJlXMQoklhnrZSYX66XlF5Vk6KUX
        bWIEhzSj7w7G25vf6h1iZOJgPMQowcGsJMIbbfsiTog3JbGyKrUoP76oNCe1+BCjNAeLkjhv
        HvfyWCGB9MSS1OzU1ILUIpgsEwenVAPTvsAL86VXMDKpWP2VKE3M7/Q0+rWmcHLW8verdTjs
        TqX/3bw264e+IuvESV+exUU0cNfpa7GtveKyYycD865vk1zFGC6puelut66f4aG1oaShNDtP
        KLxH1uhPU9S0x4FnRLjvT02bJ9tyJGO1zeudKw7MeOg947eZy4Fb4V0r01ibN/T39Mzmm3rM
        f01dxpncVSe+Ckzj/10S0iF5PjHAwFdVwCdl87bG9YI7z5Qt4DXaIL/j53Q7MxuriVXGi9ZN
        TDhtF2F9bLFF8D9FzqPZ7o85jlhaF3qWiz3lSHjincLqbniraoFQhOv9l/OCrBNmbl50ZF7D
        YoPf0pqe/0X1eLuUz73J7oxtzBB4qK3EUpyRaKjFXFScCAA6b2Qy2AIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2020-06-16 10:45, Zong Li έγραψε:
> Add System RAM to /proc/iomem, various tools expect it such as kdump.
> It is also needed for page_is_ram API which checks the specified 
> address
> whether registered as System RAM in iomem_resource list.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/mm/init.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f4adb3684f3d..bbe816e03b2f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -517,6 +517,27 @@ void mark_rodata_ro(void)
>  }
>  #endif
> 
> +void __init resource_init(void)
> +{
> +	struct memblock_region *region;
> +
> +	for_each_memblock(memory, region) {
> +		struct resource *res;
> +
> +		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
> +		if (!res)
> +			panic("%s: Failed to allocate %zu bytes\n", __func__,
> +			      sizeof(struct resource));
> +
> +		res->name = "System RAM";
> +		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
> +		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 
> 1;
> +		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +		request_resource(&iomem_resource, res);
> +	}
> +}
> +
>  void __init paging_init(void)
>  {
>  	setup_vm_final();
> @@ -524,6 +545,7 @@ void __init paging_init(void)
>  	sparse_init();
>  	setup_zero_page();
>  	zone_sizes_init();
> +	resource_init();
>  }
> 
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP


I already have a patch for registering System RAM as an iomem resource 
on my kexec/kdump series. Since I don't care about System RAM regions 
being accurately exposed to userspace (I parse the current device tree 
instead) I just use memblock_start_of_DRAM/end_of_DRAM. This approach 
from arm64 codebase is better since it also handles the case of sparse 
memory regions but in order to be useful for kdump we need to add the 
various segments of the kernel image as child nodes to their respective 
region for kexec-tools. I'll re-spin my patchset anyway so I'll extend 
it to better handle System RAM regions.

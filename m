Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C08A2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGJCGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:06:02 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:47454 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJCGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:06:02 -0400
Received: from av3.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id 06A25UB9024578;
        Fri, 10 Jul 2020 02:05:32 GMT
X-AuditID: 8b5b014d-241ff700000045c5-78-5f07ccea105d
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id DC.64.17861.AECC70F5; Fri, 10 Jul 2020 05:05:30 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 10 Jul 2020 05:05:30 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/2] riscv: Register System RAM as iomem resources
Organization: FORTH
In-Reply-To: <mhng-cd7e19bb-859a-45a4-90e8-7851c4fb3083@palmerdabbelt-glaptop1>
References: <mhng-cd7e19bb-859a-45a4-90e8-7851c4fb3083@palmerdabbelt-glaptop1>
Message-ID: <6d5006efde7affcb3307f5dcb85af7aa@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.9
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXSHT1dWffVGfZ4g5U3DSwu75rDZrHtcwub
        xcvLPcwWbbP4LT7cnc3mwOrx5uVLFo/NS+o9LjVfZ/f4vEkugCWKyyYlNSezLLVI3y6BK+PN
        tKeMBReUKnY9vczYwHhbuouRk0NCwETiwPQG5i5GLg4hgaOMEg86V7JCJEwlZu/tZASxeQUE
        JU7OfMICYjMLWEhMvbKfEcKWl2jeOpsZxGYRUJX4OvMImM0moCkx/9JBsHoRAXWJA6/vgC1g
        FuhglDj/FSIhLOAm8erfXjCbX0BY4tPdi2CLOQX8JXpfvARawAF0kZ9E84YSiBtcJG5Oes0M
        cZuKxIffD9hBbFEBZYmbh5+zT2AUnIXk1FlITp2F5NQFjMyrGAUSy4z1MpOL9dLyi0oy9NKL
        NjGCA5rRdwfj7c1v9Q4xMnEwHmKU4GBWEuE1UGSNF+JNSaysSi3Kjy8qzUktPsQozcGiJM6b
        x708VkggPbEkNTs1tSC1CCbLxMEp1cBUUWS2PnpWA1so06GYmJO2r23CN05eFjX7mkFd2OGc
        Y9Gmh4r8+1oC/yetfx6xQp1xaWSBxPfYsxXLT1Zejt8d657keNff+Ia2cQeD3Wn3a6xrdvFx
        6722Vjw9T3DjhYJPdTlCNb8lfj8I13KxL/wjynTqxvOyR0UuBZ2OS2fsLL84uyzuW0lUq9h+
        EZk696iTjNkHTinX9v+YfMK6WW3fKnfrBaHN7xjvyfxnsUvy5pP8VVgievKM9dJKm3Unvth3
        iFS1z+7YvELtrKOQ6DymEGmzgjs2r13jb7bOszHa51g7N7PxxiL7By2LzsmmrVvx4di/jdIv
        7shNMq5MSUhxyrvk9WCxpfHX0H6neUosxRmJhlrMRcWJAAkiNnXXAgAA
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 10 Jul 2020 02:05:32 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av3.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 10 Jul 2020 02:05:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2020-07-09 21:27, Palmer Dabbelt έγραψε:
> On Tue, 16 Jun 2020 00:45:46 PDT (-0700), zong.li@sifive.com wrote:
>> Add System RAM to /proc/iomem, various tools expect it such as kdump.
>> It is also needed for page_is_ram API which checks the specified 
>> address
>> whether registered as System RAM in iomem_resource list.
>> 
>> Signed-off-by: Zong Li <zong.li@sifive.com>
>> ---
>>  arch/riscv/mm/init.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index f4adb3684f3d..bbe816e03b2f 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -517,6 +517,27 @@ void mark_rodata_ro(void)
>>  }
>>  #endif
>> 
>> +void __init resource_init(void)
>> +{
>> +	struct memblock_region *region;
>> +
>> +	for_each_memblock(memory, region) {
>> +		struct resource *res;
>> +
>> +		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
>> +		if (!res)
>> +			panic("%s: Failed to allocate %zu bytes\n", __func__,
>> +			      sizeof(struct resource));
>> +
>> +		res->name = "System RAM";
>> +		res->start = 
>> __pfn_to_phys(memblock_region_memory_base_pfn(region));
>> +		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 
>> 1;
>> +		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> 
> Looks like everyone else is checking MEMBLOCK_NOMAP before registering 
> memory
> regions.  I've added that and put this on for-next.  Thanks!
> 
> commit 11dc632bf515874c84887727614e8044452f1f28
> gpg: Signature made Thu 09 Jul 2020 11:24:08 AM PDT
> gpg:                using RSA key 
> 2B3C3747446843B24A943A7A2E1319F35FBB1889
> gpg:                issuer "palmer@dabbelt.com"
> gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" 
> [ultimate]
> gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" 
> [ultimate]
> Author: Zong Li <zong.li@sifive.com>
> Date:   Tue Jun 16 15:45:46 2020 +0800
> 
>    riscv: Register System RAM as iomem resources
>       Add System RAM to /proc/iomem, various tools expect it such as 
> kdump.
>    It is also needed for page_is_ram API which checks the specified 
> address
>    whether registered as System RAM in iomem_resource list.
>       Signed-off-by: Zong Li <zong.li@sifive.com>
>    [Palmer: check MEMBLOCK_NOMAP]
>    Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f4adb3684f3d..8b78fd23713e 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -517,6 +517,32 @@ void mark_rodata_ro(void)
> }
> #endif
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
> +		if (memblock_is_nomap(region) {
> +			res->name = "reserved";
> +			res->flags = IORESOURCE_MEM;
> +		} else {
> +			res->name = "System RAM";
> +			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +		}
> +		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
> +		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 
> 1;
> +
> +		request_resource(&iomem_resource, res);
> +	}
> +}
> +
> void __init paging_init(void)
> {
> 	setup_vm_final();
> @@ -524,6 +550,7 @@ void __init paging_init(void)
> 	sparse_init();
> 	setup_zero_page();
> 	zone_sizes_init();
> +	resource_init();
> }
> 
> #ifdef CONFIG_SPARSEMEM_VMEMMAP
> 
> 
>> +
>> +		request_resource(&iomem_resource, res);
>> +	}
>> +}
>> +
>>  void __init paging_init(void)
>>  {
>>  	setup_vm_final();
>> @@ -524,6 +545,7 @@ void __init paging_init(void)
>>  	sparse_init();
>>  	setup_zero_page();
>>  	zone_sizes_init();
>> +	resource_init();
>>  }
>> 
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Zong Li sent a newer version of this series without this patch, since 
I'm handling this on the kexec/kdump series as well where other sections 
needed for kdump are also registered.

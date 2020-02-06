Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040420838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iiZGxzok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBFExf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:53:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6943 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBFExe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:53:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b9bc00000>; Wed, 05 Feb 2020 20:53:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 20:53:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Feb 2020 20:53:34 -0800
Received: from [10.2.168.158] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 04:53:34 +0000
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
To:     Qian Cai <cai@lca.pw>, <akpm@linux-foundation.org>
CC:     <ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jack@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200206035235.2537-1-cai@lca.pw>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
Date:   Wed, 5 Feb 2020 20:50:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206035235.2537-1-cai@lca.pw>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580964800; bh=xAf0FzCgCZHzZBkZwyyUZaACb8F7IA6ZF9/a+cOMFxI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iiZGxzokIV7dKwk6orbh4Tjn8nC+D33QxqoUVsITyYoSSxF5mhX/T7W8eMjYYs6hn
         x64npC1JSBOvWe4AnCkEoZposuV8JiGphnHJbLPPafWCuJ10+iBR0zjjvNnRlbgmSW
         TOvlSZdyh2wFhoV42fmwn3uvxScnqFx+vtq9+1rALq0366RB0e2QZ6Bh45jI2i9ptG
         5epxWT5W2AGT+z3IjCzXuoGsHxNjPH737YJN+2uFm+QkoSWg0pR99spBxVxmS1vBwh
         PUpweoGCLjsaySHVedk+T0egYyRE1kTDF+LeDb283491HlZKcSax7uxFezMSWoLswS
         q/5tBsLKWnbSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 7:52 PM, Qian Cai wrote:
> The commit 07d802699528 ("mm: devmap: refactor 1-based refcounting for
> ZONE_DEVICE pages") introduced a data race as page->flags could be

Hi,

I really don't think so. This "race" was there long before that commit.
Anyway, more below:

> accessed concurrently as noticied by KCSAN,
> 
>   BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> 
>   write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
>    page_cpupid_xchg_last+0x51/0x80
>    page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
>    wp_page_reuse+0x3e/0xc0
>    wp_page_reuse at mm/memory.c:2453
>    do_wp_page+0x472/0x7b0
>    do_wp_page at mm/memory.c:2798
>    __handle_mm_fault+0xcb0/0xd00
>    handle_pte_fault at mm/memory.c:4049
>    (inlined by) __handle_mm_fault at mm/memory.c:4163
>    handle_mm_fault+0xfc/0x2f0
>    handle_mm_fault at mm/memory.c:4200
>    do_page_fault+0x263/0x6f9
>    do_user_addr_fault at arch/x86/mm/fault.c:1465
>    (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
>    page_fault+0x34/0x40
> 
>   read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
>    put_page+0x15a/0x1f0
>    page_zonenum at include/linux/mm.h:923
>    (inlined by) is_zone_device_page at include/linux/mm.h:929
>    (inlined by) page_is_devmap_managed at include/linux/mm.h:948
>    (inlined by) put_page at include/linux/mm.h:1023
>    wp_page_copy+0x571/0x930
>    wp_page_copy at mm/memory.c:2615
>    do_wp_page+0x107/0x7b0
>    __handle_mm_fault+0xcb0/0xd00
>    handle_mm_fault+0xfc/0x2f0
>    do_page_fault+0x263/0x6f9
>    page_fault+0x34/0x40
> 
>   Reported by Kernel Concurrency Sanitizer on:
>   CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
>   Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> 
> Both the read and write are done only with the non-exclusive mmap_sem
> held. Since the read only check for a specific bit in the flag, even if


Perhaps a clearer explanation is that the read of the page flags is always
looking at a bit range (zone number: up to 3 bits) that is not being written to by
the writer.


> load tearing happens, it will be harmless, so just mark it as an
> intentional data races using the data_race() macro.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   include/linux/mm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..cafccad584c2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -920,7 +920,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>   
>   static inline enum zone_type page_zonenum(const struct page *page)
>   {
> -	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> +	return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);


I don't know about this. Lots of the kernel is written to do this sort
of thing, and adding a load of "data_race()" everywhere is...well, I'm not
sure if it's really the best way.  I wonder: could we maybe teach this
kcsan thing to understand a few of the key idioms, particularly about page
flags, instead of annotating all over the place?



thanks,
-- 
John Hubbard
NVIDIA


>   }
>   
>   #ifdef CONFIG_ZONE_DEVICE
> 



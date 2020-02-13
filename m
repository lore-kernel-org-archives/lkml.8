Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B79C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D90218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GuiQ4sZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBMVUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:20:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1868 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgBMVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:20:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e45bd730000>; Thu, 13 Feb 2020 13:19:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Feb 2020 13:20:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Feb 2020 13:20:16 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 21:20:16 +0000
Subject: Re: [PATCH -next v2] mm: annotate a data race in page_zonenum()
To:     Qian Cai <cai@lca.pw>, <paulmck@kernel.org>
CC:     <akpm@linux-foundation.org>, <elver@google.com>,
        <david@redhat.com>, <jack@suse.cz>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1581619089-14472-1-git-send-email-cai@lca.pw>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <c1b1b448-ec64-c245-896c-462c55d94b3b@nvidia.com>
Date:   Thu, 13 Feb 2020 13:20:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1581619089-14472-1-git-send-email-cai@lca.pw>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581628787; bh=HGGswWKrncPRu93Zq0PyM9U46WDVJ12jUnjbh/MB+io=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GuiQ4sZ7GN6uyStZwg8bulXkQ+p9vDBfhMfkLVSOQ1eB7OYDPPbgMOBMWE6OfHD9z
         VylC9wTfTi82BTV8wqrfA+EEH+LGjCnZ9EwIwIY0qOTfluBB9529SzUgsyZXI0tRxl
         eWH/dxWUxgc9AC2oTHW+6na2CCTbxgUdhKXQyo61NytOjKrIJRWt3qFHgQ15+u7YeM
         /hDwdfToc9qj82HnGlukqlL3yLEuxkDbf1rV3ms5PqaNHhwiTRe0unZV2Dazu+iLnC
         fjWQSHyoKHSI3/F/+JnlXq3ozaxbofZhNnUpIZf1oePhfd9T+8cKvvXUNl7vz6Zjca
         cTTo3payr8upQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 10:38 AM, Qian Cai wrote:
>  BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> 
>  write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
>   page_cpupid_xchg_last+0x51/0x80
>   page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
>   wp_page_reuse+0x3e/0xc0
>   wp_page_reuse at mm/memory.c:2453
>   do_wp_page+0x472/0x7b0
>   do_wp_page at mm/memory.c:2798
>   __handle_mm_fault+0xcb0/0xd00
>   handle_pte_fault at mm/memory.c:4049
>   (inlined by) __handle_mm_fault at mm/memory.c:4163
>   handle_mm_fault+0xfc/0x2f0
>   handle_mm_fault at mm/memory.c:4200
>   do_page_fault+0x263/0x6f9
>   do_user_addr_fault at arch/x86/mm/fault.c:1465
>   (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
>   page_fault+0x34/0x40
> 
>  read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
>   put_page+0x15a/0x1f0
>   page_zonenum at include/linux/mm.h:923
>   (inlined by) is_zone_device_page at include/linux/mm.h:929
>   (inlined by) page_is_devmap_managed at include/linux/mm.h:948
>   (inlined by) put_page at include/linux/mm.h:1023
>   wp_page_copy+0x571/0x930
>   wp_page_copy at mm/memory.c:2615
>   do_wp_page+0x107/0x7b0
>   __handle_mm_fault+0xcb0/0xd00
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> 
> A page never changes its zone number. The zone number happens to be
> stored in the same word as other bits which are modified, but the zone
> number bits will never be modified by any other write, so it can accept
> a reload of the zone bits after an intervening write and it don't need
> to use READ_ONCE(). Thus, annotate this data race using
> ASSERT_EXCLUSIVE_BITS() to also assert that there are no concurrent
> writes to it.
> 
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: use ASSERT_EXCLUSIVE_BITS().


Much cleaner, thanks to this new macro. You can add:


    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> BTW, not sure if it is easier for Andrew with Paul to pick this up (with
> Andrew's ACK), since ASSERT_EXCLUSIVE_BITS() is in -rcu tree only (or likely
> tomorrow's -next tree).
> 
>  include/linux/mm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..0d70fafd055c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -920,6 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>  
>  static inline enum zone_type page_zonenum(const struct page *page)
>  {
> +	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
>  	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
>  }
>  
> 

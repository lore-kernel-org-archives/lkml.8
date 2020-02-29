Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7873C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96181222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CqI85+c/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgB2Woc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:44:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38212 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgB2Wob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:44:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id 2so6666779oiz.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fImmI76PTkUm0FnhIT75xAfAmVx1VzhBKKsN9mVGyw=;
        b=CqI85+c/yRtEkfdvKZhyimiv+7VpsWo116oMWIFfgpozuKdLs8C42nteZDsX5BGC18
         YFA3FIVS39K+jrHV363NgaZbyyIgxeUDc50ebfZEV6Dg195VTUcmJ5ks4GK7LLMTfdRG
         eyz/jrExrPaaWO449Bs08Z5ZvCBAF8pQBclZvBaZdySo4pDGyePu6OJWj4OeXrvOl5KY
         ro66cJo/Qcj1ASkeP0uL8RRPE1gEVH5S6C3g2weZyNNFDalPOuYmVgtTK4js076KGUP1
         sjl87SdTRjtqnsitz4qtdRmuFsvpmQAbp/SMu5PjS/fDvEIs6oFk7/24LGUbW+6A+6f/
         UVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fImmI76PTkUm0FnhIT75xAfAmVx1VzhBKKsN9mVGyw=;
        b=lHMZNY32CS3cvkjvElFD5DKy34W4wtfM8ObKU7SNlRN7dbtjK4LHxlOkvplst/H63i
         ZkD19gtZeDW7m0S/v7QiDfnwN589d3/AN5YSDB7UpnN74C8xBmmsf49Yda783ksqUAU5
         DKU8Cgc7V70GWMH7FvsChiWCM8h7rhOL5hKrBCWn7Ex96Oh6FvFicJpt9ho/un8RNEst
         OtE/Xe3YYi4KDfVs0kD4A+7yiURUjLTn9hA29GncTfArrWKFH5PBKxhYkb8E8rCzCebY
         hstEpySuCCjpXdo1orBlUd6GR891JS/zX6LvtGWn9sMuR2FQDBgqcCx7lhk6TqGUA3iT
         fqxg==
X-Gm-Message-State: APjAAAXkAHiD3EdaMc7F/hdmDW2a5zmktv+aUlhTV3una27oA2xPQRAa
        ZVQkoRdm2jx27WSgc/SAykLoVdDTyVo8pT7RK4YdSg==
X-Google-Smtp-Source: APXvYqyGByPH6pnWrwmTwQrskzg89P8NSyX2Okxw9rUGjppQ4dvnm0/DLDGVxjpQFnKlb3H7KIX7HBwNZb3emn/5hZY=
X-Received: by 2002:aca:ec02:: with SMTP id k2mr7594496oih.105.1583016270294;
 Sat, 29 Feb 2020 14:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200221182503.28317-7-logang@deltatee.com>
In-Reply-To: <20200221182503.28317-7-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 29 Feb 2020 14:44:19 -0800
Message-ID: <CAPcyv4gR1+NaWzteqNKip=cYk89oEVW18HNao7Xv=JipzzDagw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mm/memory_hotplug: Add pgprot_t to mhp_params
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:25 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
> struct page mappings for IO memory. At present, these mappings are created
> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
> x86, an mtrr register will typically override this and force the cache
> type to be UC-. In the case firmware doesn't set this register it is
> effectively WB and will typically result in a machine check exception
> when it's accessed.
>
> Other arches are not currently likely to function correctly seeing they
> don't have any MTRR registers to fall back on.
>
> To solve this, provide a way to specify the pgprot value explicitly to
> arch_add_memory().
>
> Of the arches that support MEMORY_HOTPLUG: x86_64, and arm64 need a simple
> change to pass the pgprot_t down to their respective functions which set
> up the page tables. For x86_32, set the page tables explicitly using
> _set_memory_prot() (seeing they are already mapped). For ia64, s390 and
> sh, reject anything but PAGE_KERNEL settings -- this should be fine,
> for now, seeing these architectures don't support ZONE_DEVICE.
>
> A check in __add_pages() is also added to ensure the pgprot parameter was
> set for all arches.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/arm64/mm/mmu.c            | 3 ++-
>  arch/ia64/mm/init.c            | 3 +++
>  arch/powerpc/mm/mem.c          | 3 ++-
>  arch/s390/mm/init.c            | 3 +++
>  arch/sh/mm/init.c              | 3 +++
>  arch/x86/mm/init_32.c          | 5 +++++
>  arch/x86/mm/init_64.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 ++
>  mm/memory_hotplug.c            | 5 ++++-
>  mm/memremap.c                  | 6 +++---
>  10 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ee37bca8aba8..ea3fa844a8a2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1058,7 +1058,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>                 flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -                            size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
> +                            size, params->pgprot, __pgd_pgtable_alloc,
> +                            flags);
>
>         memblock_clear_nomap(start, size);
>
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 97bbc23ea1e3..d637b4ea3147 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -676,6 +676,9 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         unsigned long nr_pages = size >> PAGE_SHIFT;
>         int ret;
>
> +       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
> +               return -EINVAL;
> +
>         ret = __add_pages(nid, start_pfn, nr_pages, params);
>         if (ret)
>                 printk("%s: Problem encountered in __add_pages() as ret=%d\n",
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 19b1da5d7eca..832412bc7fad 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -138,7 +138,8 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>         resize_hpt_for_hotplug(memblock_phys_mem_size());
>
>         start = (unsigned long)__va(start);
> -       rc = create_section_mapping(start, start + size, nid, PAGE_KERNEL);
> +       rc = create_section_mapping(start, start + size, nid,
> +                                   params->pgprot);
>         if (rc) {
>                 pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
>                         start, start + size, rc);
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index e9e4a7abd0cc..87b2d024e75a 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -277,6 +277,9 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         if (WARN_ON_ONCE(params->altmap))
>                 return -EINVAL;
>
> +       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
> +               return -EINVAL;
> +
>         rc = vmem_add_mapping(start, size);
>         if (rc)
>                 return rc;
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index e5114c053364..b9de2d4fa57e 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,6 +412,9 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         unsigned long nr_pages = size >> PAGE_SHIFT;
>         int ret;
>
> +       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
> +               return -EINVAL;
> +
>         /* We only have ZONE_NORMAL, so this is easy.. */
>         ret = __add_pages(nid, start_pfn, nr_pages, params);
>         if (unlikely(ret))
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index e25a4218e6ff..96d8e4fb1cc8 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -858,6 +858,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> +       int ret;
> +
> +       ret = _set_memory_prot(start, nr_pages, params->pgprot);

Perhaps a comment since it's not immediately obvious where the
PAGE_KERNEL prot was established, and perhaps add a conditional to
skip this call in the param->pgprot == PAGE_KERNEL case?

Other than that looks good to me, but only an ack since I'm only
testing the x86 changes.

Acked-by: Dan Williams <dan.j.williams@intel.com>

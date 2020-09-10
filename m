Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF52C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0172076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lCpV9kgG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="m7pI+RmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgIJI1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:27:24 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:54144
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730412AbgIJI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599726429;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=D2ssaXm4U+FhgxNRcddPn25diMTWcisTarP4AFGrj68=;
        b=lCpV9kgGlJ6juF6PJDVYbfawDSnM4mSioqw93h8nUB5LS24FB2/XPrxTQXv1zR1v
        pY4HiqJBBN3KPewcGyC3wpC1sXUi3KsO27Y9jdgY7d/ZR42uAkRGlRuLbuciKO47ije
        EWB0995AO3iRxayR+yYtJmg9C9ypBEt+xXXlOs70=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599726429;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=D2ssaXm4U+FhgxNRcddPn25diMTWcisTarP4AFGrj68=;
        b=m7pI+RmVu5cAKHjeRbAPzNPjRkASNCmRFCCwKFQjgayDQiFiYCRwAuoGxgzJG3lK
        JzhppvT/2IlVtqNs77ShMu+phKJj5xodjUFXTmzwhsJ2O/BYVf3moJtCfJJFM6kSTLT
        d9pcyGaWQpL7IGVrc57viKzcjnZBgFwep1VLzva0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17174C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   <sudaraja@codeaurora.org>
To:     "'Anshuman Khandual'" <anshuman.khandual@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Logan Gunthorpe'" <logang@deltatee.com>,
        "'David Hildenbrand'" <david@redhat.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Steven Price'" <steven.price@arm.com>, <pratikp@codeaurora.org>
References: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com> <0475e813-cb95-0992-39e4-593bfd5cdbf8@arm.com>
In-Reply-To: <0475e813-cb95-0992-39e4-593bfd5cdbf8@arm.com>
Subject: RE: [PATCH] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Thu, 10 Sep 2020 08:27:09 +0000
Message-ID: <010101747720234c-888d2c62-ffef-4364-b428-03e0bb424303-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIU0NxhPrp6drl9b/ISIjKhXIbxxAEQJFsYqNx0IaA=
X-SES-Outgoing: 2020.09.10-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anshuman,

>On 09/10/2020 11:35 AM, Sudarshan Rajagopalan wrote:
>> When section mappings are enabled, we allocate vmemmap pages from=20
>> physically continuous memory of size PMD_SZIE using=20
>> vmemmap_alloc_block_buf(). Section> mappings are good to reduce TLB=20
>> pressure. But when system is highly fragmented and memory blocks are=20
>> being hot-added at runtime, its possible that such physically=20
>> continuous memory allocations can fail. Rather than failing the
>
>Did you really see this happen on a system ?

Thanks for the response.

Yes, this happened on a system with very low RAM (size ~120MB) where no =
free order-9 pages were present. Pasting below few kernel logs. On =
systems with low RAM, its high probability where memory is fragmented =
and no higher order pages are free. On such scenarios, vmemmap alloc =
would fail for PMD_SIZE of contiguous memory.

We have a usecase for memory sharing between VMs where one of the VM =
uses add_memory() to add the memory that was donated by the other VM. =
This uses something similar to VirtIO-Mem. And this requires memory to =
be _guaranteed_ to be added in the VM so that the usecase can run =
without any failure.

vmemmap alloc failure: order:9, =
mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL), =
nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
CPU: 1 PID: 294 Comm: -------- Tainted: G S                5.4.50 #1
Call trace:
 dump_stack+0xa4/0xdc
 warn_alloc+0x104/0x160
 vmemmap_alloc_block+0xe4/0xf4
 vmemmap_alloc_block_buf+0x34/0x38
 vmemmap_populate+0xc8/0x224
 __populate_section_memmap+0x34/0x54
 sparse_add_section+0x16c/0x254
 __add_pages+0xd0/0x138
 arch_add_memory+0x114/0x1a8

DMA32: 2627*4kB (UMC) 23*8kB (UME) 6*16kB (UM) 8*32kB (UME) 2*64kB (ME) =
2*128kB (UE) 1*256kB (M) 2*512kB (ME) 1*1024kB (M) 0*2048kB 0*4096kB =3D =
13732kB
30455 pages RAM

But keeping this usecase aside, won=E2=80=99t this be problematic on any =
systems with low RAM where order-9 alloc would fail on a fragmented =
system, and any memory hot-adding would fail? Or other similar users of =
VirtIO-Mem which uses arch_add_memory.

>
>> memory hot-add procedure, add a fallback option to allocate vmemmap=20
>> pages from discontinuous pages using vmemmap_populate_basepages().
>
>Which could lead to a mixed page size mapping in the VMEMMAP area.

Would this be problematic? We would only lose one section mapping per =
failure and increases slight TLB pressure. Also, we would anyway do =
discontinuous pages alloc for systems having non-4K pages =
(ARM64_SWAPPER_USES_SECTION_MAPS will be 0). I only see a small cost to =
performance due to slight TLB pressure.

>Allocation failure in vmemmap_populate() should just cleanly fail the =
memory hot add operation, which can then be retried. Why the retry has =
to be offloaded to kernel ?

While a retry can attempted again, but it won=E2=80=99t help in cases =
where there are no order-9 pages available and any retry would just not =
succeed again until a order-9 page gets free'ed. Here we are just =
falling back to use discontinuous pages allocation to help succeed =
memory hot-add as best as possible.

Thanks and Regards,
Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a =
Linux Foundation Collaborative Project

-----Original Message-----
From: Anshuman Khandual <anshuman.khandual@arm.com>=20
Sent: Wednesday, September 9, 2020 11:45 PM
To: Sudarshan Rajagopalan <sudaraja@codeaurora.org>; =
linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon =
<will@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Logan Gunthorpe =
<logang@deltatee.com>; David Hildenbrand <david@redhat.com>; Andrew =
Morton <akpm@linux-foundation.org>; Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually =
contiguous memory

Hello Sudarshan,

On 09/10/2020 11:35 AM, Sudarshan Rajagopalan wrote:
> When section mappings are enabled, we allocate vmemmap pages from=20
> physically continuous memory of size PMD_SZIE using=20
> vmemmap_alloc_block_buf(). Section> mappings are good to reduce TLB=20
> pressure. But when system is highly fragmented and memory blocks are=20
> being hot-added at runtime, its possible that such physically=20
> continuous memory allocations can fail. Rather than failing the

Did you really see this happen on a system ?

> memory hot-add procedure, add a fallback option to allocate vmemmap=20
> pages from discontinuous pages using vmemmap_populate_basepages().

Which could lead to a mixed page size mapping in the VMEMMAP area.
Allocation failure in vmemmap_populate() should just cleanly fail the =
memory hot add operation, which can then be retried. Why the retry has =
to be offloaded to kernel ?

>=20
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index=20
> 75df62f..a46c7d4 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1100,6 +1100,7 @@ int __meminit vmemmap_populate(unsigned long =
start, unsigned long end, int node,
>  	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
> +	int ret =3D 0;
> =20
>  	do {
>  		next =3D pmd_addr_end(addr, end);
> @@ -1121,15 +1122,23 @@ int __meminit vmemmap_populate(unsigned long =
start, unsigned long end, int node,
>  			void *p =3D NULL;
> =20
>  			p =3D vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p)
> -				return -ENOMEM;
> +			if (!p) {
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +				vmemmap_free(start, end, altmap); #endif

The mapping was never created in the first place, as the allocation =
failed. vmemmap_free() here will free an unmapped area !

> +				ret =3D -ENOMEM;
> +				break;
> +			}
> =20
>  			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>  		} else
>  			vmemmap_verify((pte_t *)pmdp, node, addr, next);
>  	} while (addr =3D next, addr !=3D end);
> =20
> -	return 0;
> +	if (ret)
> +		return vmemmap_populate_basepages(start, end, node, altmap);
> +	else
> +		return ret;
>  }
>  #endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
>  void vmemmap_free(unsigned long start, unsigned long end,
>=20


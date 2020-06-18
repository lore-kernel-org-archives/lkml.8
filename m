Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A3E20897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFRFhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:37:18 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:11153 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRFhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:37:18 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.14] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F4009240002;
        Thu, 18 Jun 2020 05:37:14 +0000 (UTC)
Subject: Re: [PATCH v2 0/8] Introduce sv48 support
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200603081104.14004-1-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <0fbb7c9b-d221-5bf8-ddc0-3938066a09d0@ghiti.fr>
Date:   Thu, 18 Jun 2020 01:37:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200603081104.14004-1-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Le 6/3/20 à 4:10 AM, Alexandre Ghiti a écrit :
> This patchset implements sv48 support at runtime. The kernel will try to
> boot with 4-level page table and will fallback to 3-level if the HW does not
> support it.
>                                                                                   
> The biggest advantage is that we only have one kernel for 64bit, which
> is way easier to maintain.
>                                                                                   
> Folding the 4th level into a 3-level page table has almost no cost at
> runtime. But as mentioned Palmer, the relocatable code generated is less
> performant.
>                                                                                   
> At the moment, there is no way to build a 3-level page table non-relocatable
> 64bit kernel. We agreed that distributions will use this runtime configuration
> anyway, but Palmer proposed to introduce a new Kconfig, which I will do later
> as sv48 support was asked for 5.8.
>                                                                                   
> Finally, the user can now ask for sv39 explicitly by using the device-tree
> which will reduce memory footprint and reduce the number of memory accesses
> in case of TLB miss.
>
> Changes in v2:
>    * Move variable declarations to pgtable.h in patch 5/7 as suggested by Anup
>    * Restore mmu-type properties in patch 6 as suggested by Anup
>    * Fix unused variable in patch 5 that was used in patch 6
>    * Fix SPARSEMEM build (patch 2 was modified so I dropped the Reviewed-by)
>    * Applied various Reviewed-by
>
> Alexandre Ghiti (8):
>    riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
>    riscv: Allow to dynamically define VA_BITS
>    riscv: Simplify MAXPHYSMEM config
>    riscv: Prepare ptdump for vm layout dynamic addresses
>    riscv: Implement sv48 support
>    riscv: Allow user to downgrade to sv39 when hw supports sv48
>    riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
>    riscv: Explicit comment about user virtual address space size
>
>   arch/riscv/Kconfig                  |  34 ++---
>   arch/riscv/include/asm/csr.h        |   3 +-
>   arch/riscv/include/asm/fixmap.h     |   1 +
>   arch/riscv/include/asm/page.h       |  15 +++
>   arch/riscv/include/asm/pgalloc.h    |  36 ++++++
>   arch/riscv/include/asm/pgtable-64.h |  97 +++++++++++++-
>   arch/riscv/include/asm/pgtable.h    |  31 ++++-
>   arch/riscv/include/asm/sparsemem.h  |   6 +-
>   arch/riscv/kernel/cpu.c             |  23 ++--
>   arch/riscv/kernel/head.S            |   3 +-
>   arch/riscv/mm/context.c             |   2 +-
>   arch/riscv/mm/init.c                | 194 ++++++++++++++++++++++++----
>   arch/riscv/mm/ptdump.c              |  49 +++++--
>   13 files changed, 412 insertions(+), 82 deletions(-)
>

Do you any remark regarding this patchset and the others ?

Thanks,

Alex


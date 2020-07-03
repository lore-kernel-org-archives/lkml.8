Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD21C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA7206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGCFWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:22:38 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45091 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCFWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:22:38 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.11] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6C99860002;
        Fri,  3 Jul 2020 05:22:34 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 0/8] Introduce sv48 support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-718df9bf-f140-4343-80a1-402f89c0c5ba@palmerdabbelt-glaptop1>
Message-ID: <3a3a95ad-dddc-6246-6ec9-bea61f0e1766@ghiti.fr>
Date:   Fri, 3 Jul 2020 01:22:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-718df9bf-f140-4343-80a1-402f89c0c5ba@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Le 7/1/20 à 2:27 PM, Palmer Dabbelt a écrit :
> On Wed, 03 Jun 2020 01:10:56 PDT (-0700), alex@ghiti.fr wrote:
>> This patchset implements sv48 support at runtime. The kernel will try to
>> boot with 4-level page table and will fallback to 3-level if the HW 
>> does not
>> support it.
>>
>> The biggest advantage is that we only have one kernel for 64bit, which
>> is way easier to maintain.
>>
>> Folding the 4th level into a 3-level page table has almost no cost at
>> runtime. But as mentioned Palmer, the relocatable code generated is less
>> performant.
>>
>> At the moment, there is no way to build a 3-level page table 
>> non-relocatable
>> 64bit kernel. We agreed that distributions will use this runtime 
>> configuration
>> anyway, but Palmer proposed to introduce a new Kconfig, which I will 
>> do later
>> as sv48 support was asked for 5.8.
> 
> Sorry I wasn't clear last time, but this still has the same fundamental 
> issue:
> it forces 64-bit kernels to be relocatable, which imposes a performance
> penalty.  We don't have any hardware that can actually take advantage of 
> sv48,
> so I don't want to take anything that penalizes what people are actually 
> using
> in order to add a feature people can't use.
> 
> I'd be OK taking this if sv48 support simply depended on a relocatable 
> kernel,
> as then users who want the faster kernel could still build one.  I don't 
> want
> to take something that forces all 64-bit kernels to be relocatable.

Indeed, I had not understood that this was a requirement. I will add a 
patch on top of this one introducing a new config, I have to think about it.

But even if I understand that the new level of indirection coming with 
PIE will be slower, is this new config worth it ? Can we benchmark 
somehow the performance loss ? IMHO I think that this config will get 
broken over time by lack of testing because I believe distributions will 
go for KASLR kernel which requires the relocatability property anyway.

Alex

> 
>> Finally, the user can now ask for sv39 explicitly by using the 
>> device-tree
>> which will reduce memory footprint and reduce the number of memory 
>> accesses
>> in case of TLB miss.
>>
>> Changes in v2:
>>   * Move variable declarations to pgtable.h in patch 5/7 as suggested 
>> by Anup
>>   * Restore mmu-type properties in patch 6 as suggested by Anup
>>   * Fix unused variable in patch 5 that was used in patch 6
>>   * Fix SPARSEMEM build (patch 2 was modified so I dropped the 
>> Reviewed-by)
>>   * Applied various Reviewed-by
>>
>> Alexandre Ghiti (8):
>>   riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
>>   riscv: Allow to dynamically define VA_BITS
>>   riscv: Simplify MAXPHYSMEM config
>>   riscv: Prepare ptdump for vm layout dynamic addresses
>>   riscv: Implement sv48 support
>>   riscv: Allow user to downgrade to sv39 when hw supports sv48
>>   riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
>>   riscv: Explicit comment about user virtual address space size
>>
>>  arch/riscv/Kconfig                  |  34 ++---
>>  arch/riscv/include/asm/csr.h        |   3 +-
>>  arch/riscv/include/asm/fixmap.h     |   1 +
>>  arch/riscv/include/asm/page.h       |  15 +++
>>  arch/riscv/include/asm/pgalloc.h    |  36 ++++++
>>  arch/riscv/include/asm/pgtable-64.h |  97 +++++++++++++-
>>  arch/riscv/include/asm/pgtable.h    |  31 ++++-
>>  arch/riscv/include/asm/sparsemem.h  |   6 +-
>>  arch/riscv/kernel/cpu.c             |  23 ++--
>>  arch/riscv/kernel/head.S            |   3 +-
>>  arch/riscv/mm/context.c             |   2 +-
>>  arch/riscv/mm/init.c                | 194 ++++++++++++++++++++++++----
>>  arch/riscv/mm/ptdump.c              |  49 +++++--
>>  13 files changed, 412 insertions(+), 82 deletions(-)

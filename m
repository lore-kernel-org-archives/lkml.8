Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C46B206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgF2TTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:19:50 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58746 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbgF2TTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:43 -0400
X-Greylist: delayed 2332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 15:19:42 EDT
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 09BF23A4382
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:47:10 +0000 (UTC)
Received: from [192.168.1.11] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id EEEC7240007;
        Mon, 29 Jun 2020 14:46:47 +0000 (UTC)
Subject: Re: [PATCH 0/2] PUD/PGDIR entries for linear mapping
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200603153608.30056-1-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <452647fc-bcfc-c47c-50eb-cb06a94f6d38@ghiti.fr>
Date:   Mon, 29 Jun 2020 10:46:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200603153608.30056-1-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 6/3/20 à 11:36 AM, Alexandre Ghiti a écrit :
> This small patchset intends to use PUD/PGDIR entries for linear mapping
> in order to better utilize TLB.
> 
> At the moment, only PMD entries can be used since on common platforms
> (qemu/unleashed), the kernel is loaded at DRAM + 2MB which dealigns virtual
> and physical addresses and then prevents the use of PUD/PGDIR entries.
> So the kernel must be able to get those 2MB for PAGE_OFFSET to map the
> beginning of the DRAM: this is achieved in patch 1.
> 
> But furthermore, at the moment, the firmware (opensbi) explicitly asks the
> kernel not to map the region it occupies, which is on those common
> platforms at the very beginning of the DRAM and then it also dealigns
> virtual and physical addresses. I proposed a patch here:
> 
> https://github.com/riscv/opensbi/pull/167
> 
> that removes this 'constraint' but *not* all the time as it offers some
> kind of protection in case PMP is not available. So sometimes, we may
> have a part of the memory below the kernel that is removed creating a
> misalignment between virtual and physical addresses. So for performance
> reasons, we must at least make sure that PMD entries can be used: that
> is guaranteed by patch 1 too.
> 
> Finally the second patch simply improves best_map_size so that whenever
> possible, PUD/PGDIR entries are used.
> 
> Below is the kernel page table without this patch on a 6G platform:
> 
> ---[ Linear mapping ]---
> 0xffffc00000000000-0xffffc00176e00000    0x0000000080200000 5998M PMD     D A . . . W R V
> 
> And with this patchset + opensbi patch:
> 
> ---[ Linear mapping ]---
> 0xffffc00000000000-0xffffc00140000000 0x0000000080000000         5G PUD     D A . . . W R V
> 0xffffc00140000000-0xffffc00177000000    0x00000001c0000000 880M PMD     D A . . . W R V
> 
> Alexandre Ghiti (2):
>    riscv: Get memory below load_pa while ensuring linear mapping is PMD
>      aligned
>    riscv: Use PUD/PGDIR entries for linear mapping when possible
> 
>   arch/riscv/include/asm/page.h |  8 ++++
>   arch/riscv/mm/init.c          | 69 +++++++++++++++++++++++++++++------
>   2 files changed, 65 insertions(+), 12 deletions(-)
> 

The way to handle the remapping of the first 2MB is incorrect: Atish has 
issues while using an initrd because the initrd_start variable is 
defined using __va between setup_vm and setup_vm_final and then its 
value is inconsistent after setup_vm_final since virtual addressing was 
modified with the remapping of the first 2MB.

I will come with another solution to this problem since the way I handle 
it for now is not correct.

Thanks,

Alex

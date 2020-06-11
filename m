Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8242C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68D72072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFKGvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:51:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59635 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFKGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:51:22 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.142] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A5406E0007;
        Thu, 11 Jun 2020 06:51:18 +0000 (UTC)
Subject: Re: [PATCH 0/2] PUD/PGDIR entries for linear mapping
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20200603153608.30056-1-alex@ghiti.fr>
 <CAOnJCUJSKvLDsXC8+wyO1xsZDzLJmjY2kwMKhjz0t+uS8h0pDw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <7ad7057e-fdab-14ef-9bdb-c77ccefd208a@ghiti.fr>
Date:   Thu, 11 Jun 2020 02:51:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCUJSKvLDsXC8+wyO1xsZDzLJmjY2kwMKhjz0t+uS8h0pDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Le 6/10/20 à 2:32 PM, Atish Patra a écrit :
> On Wed, Jun 3, 2020 at 8:36 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> This small patchset intends to use PUD/PGDIR entries for linear mapping
>> in order to better utilize TLB.
>>
>> At the moment, only PMD entries can be used since on common platforms
>> (qemu/unleashed), the kernel is loaded at DRAM + 2MB which dealigns virtual
>> and physical addresses and then prevents the use of PUD/PGDIR entries.
>> So the kernel must be able to get those 2MB for PAGE_OFFSET to map the
>> beginning of the DRAM: this is achieved in patch 1.
>>
> I don't have in depth knowledge of how mm code works so this question
> may be a completely
> stupid one :). Just for my understanding,
> As per my understanding, kernel will map those 2MB of memory but never use it.
> How does the kernel ensure that it doesn't allocate any memory from those 2MB
> memory if it is not marked as reserved?

Yes, a 1GB hugepage will cover those 2MB: I rely on the previous boot 
stage to mark this region
as reserved if there is something there (like opensbi). Otherwise, the 
kernel will indeed try to
allocate memory from there :)

Alex


>> But furthermore, at the moment, the firmware (opensbi) explicitly asks the
>> kernel not to map the region it occupies, which is on those common
>> platforms at the very beginning of the DRAM and then it also dealigns
>> virtual and physical addresses. I proposed a patch here:
>>
>> https://github.com/riscv/opensbi/pull/167
>>
>> that removes this 'constraint' but *not* all the time as it offers some
>> kind of protection in case PMP is not available. So sometimes, we may
>> have a part of the memory below the kernel that is removed creating a
>> misalignment between virtual and physical addresses. So for performance
>> reasons, we must at least make sure that PMD entries can be used: that
>> is guaranteed by patch 1 too.
>>
>> Finally the second patch simply improves best_map_size so that whenever
>> possible, PUD/PGDIR entries are used.
>>
>> Below is the kernel page table without this patch on a 6G platform:
>>
>> ---[ Linear mapping ]---
>> 0xffffc00000000000-0xffffc00176e00000    0x0000000080200000 5998M PMD     D A . . . W R V
>>
>> And with this patchset + opensbi patch:
>>
>> ---[ Linear mapping ]---
>> 0xffffc00000000000-0xffffc00140000000 0x0000000080000000         5G PUD     D A . . . W R V
>> 0xffffc00140000000-0xffffc00177000000    0x00000001c0000000 880M PMD     D A . . . W R V
>>
>> Alexandre Ghiti (2):
>>    riscv: Get memory below load_pa while ensuring linear mapping is PMD
>>      aligned
>>    riscv: Use PUD/PGDIR entries for linear mapping when possible
>>
>>   arch/riscv/include/asm/page.h |  8 ++++
>>   arch/riscv/mm/init.c          | 69 +++++++++++++++++++++++++++++------
>>   2 files changed, 65 insertions(+), 12 deletions(-)
>>
>> --
>> 2.20.1
>>
>>
>

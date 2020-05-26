Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60931C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D532073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgEZQ0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:26:52 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49819 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEZQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:26:52 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.14] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 85E5020010;
        Tue, 26 May 2020 16:26:48 +0000 (UTC)
Subject: Re: [PATCH 7/8] riscv: Use pgtable_l4_enabled to output mmu type in
 cpuinfo
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20200524091008.25587-1-alex@ghiti.fr>
 <20200524091008.25587-8-alex@ghiti.fr>
 <CAAhSdy3JU8ae8Gx-4iNiOKbC027-Cgjc_8=BYEp1sO3pW6D5XA@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <e27f85e4-14d8-e5d8-3e52-f4bc0c34d760@ghiti.fr>
Date:   Tue, 26 May 2020 12:26:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy3JU8ae8Gx-4iNiOKbC027-Cgjc_8=BYEp1sO3pW6D5XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

Le 5/25/20 à 2:21 AM, Anup Patel a écrit :
> On Sun, May 24, 2020 at 2:47 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Now that the mmu type is determined at runtime using SATP
>> characteristic, use the global variable pgtable_l4_enabled to output
>> mmu type of the processor through /proc/cpuinfo instead of relying on
>> device tree infos.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> ---
>>   arch/riscv/boot/dts/sifive/fu540-c000.dtsi |  4 ----
>>   arch/riscv/kernel/cpu.c                    | 24 ++++++++++++----------
>>   2 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> index 7db861053483..6138590a2229 100644
>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> @@ -50,7 +50,6 @@
>>                          i-cache-size = <32768>;
>>                          i-tlb-sets = <1>;
>>                          i-tlb-size = <32>;
>> -                       mmu-type = "riscv,sv39";
>>                          reg = <1>;
>>                          riscv,isa = "rv64imafdc";
>>                          tlb-split;
>> @@ -74,7 +73,6 @@
>>                          i-cache-size = <32768>;
>>                          i-tlb-sets = <1>;
>>                          i-tlb-size = <32>;
>> -                       mmu-type = "riscv,sv39";
>>                          reg = <2>;
>>                          riscv,isa = "rv64imafdc";
>>                          tlb-split;
>> @@ -98,7 +96,6 @@
>>                          i-cache-size = <32768>;
>>                          i-tlb-sets = <1>;
>>                          i-tlb-size = <32>;
>> -                       mmu-type = "riscv,sv39";
>>                          reg = <3>;
>>                          riscv,isa = "rv64imafdc";
>>                          tlb-split;
>> @@ -122,7 +119,6 @@
>>                          i-cache-size = <32768>;
>>                          i-tlb-sets = <1>;
>>                          i-tlb-size = <32>;
>> -                       mmu-type = "riscv,sv39";
>>                          reg = <4>;
>>                          riscv,isa = "rv64imafdc";
>>                          tlb-split;
> Your PATCH6 is already doing the right thing by skipping CPU DT
> nodes that don't have "mmu-type" DT property.
>
> The "mmu-type" DT property is very critical for RUNTIME M-mode
> firmware (OpenSBI) because it tells whether a given CPU has MMU
> (or not). This is also in agreement with the current DT bindings
> document for RISC-V CPUs.
>
> I suggest to drop the change in sifive/fu540-c000.dtsi and rest of
> the patch is fine so my Reviewed-by still holds.


Ok I'll do that in v2, thanks.


Alex


> Regards,
> Anup
>
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index 40a3c442ac5f..38a699b997a8 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/of.h>
>>   #include <asm/smp.h>
>>
>> +extern bool pgtable_l4_enabled;
>> +
>>   /*
>>    * Returns the hart ID of the given device tree node, or -ENODEV if the node
>>    * isn't an enabled and valid RISC-V hart node.
>> @@ -54,18 +56,19 @@ static void print_isa(struct seq_file *f, const char *isa)
>>          seq_puts(f, "\n");
>>   }
>>
>> -static void print_mmu(struct seq_file *f, const char *mmu_type)
>> +static void print_mmu(struct seq_file *f)
>>   {
>> +       char sv_type[16];
>> +
>>   #if defined(CONFIG_32BIT)
>> -       if (strcmp(mmu_type, "riscv,sv32") != 0)
>> -               return;
>> +       strncpy(sv_type, "sv32", 5);
>>   #elif defined(CONFIG_64BIT)
>> -       if (strcmp(mmu_type, "riscv,sv39") != 0 &&
>> -           strcmp(mmu_type, "riscv,sv48") != 0)
>> -               return;
>> +       if (pgtable_l4_enabled)
>> +               strncpy(sv_type, "sv48", 5);
>> +       else
>> +               strncpy(sv_type, "sv39", 5);
>>   #endif
>> -
>> -       seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
>> +       seq_printf(f, "mmu\t\t: %s\n", sv_type);
>>   }
>>
>>   static void *c_start(struct seq_file *m, loff_t *pos)
>> @@ -90,14 +93,13 @@ static int c_show(struct seq_file *m, void *v)
>>   {
>>          unsigned long cpu_id = (unsigned long)v - 1;
>>          struct device_node *node = of_get_cpu_node(cpu_id, NULL);
>> -       const char *compat, *isa, *mmu;
>> +       const char *compat, *isa;
>>
>>          seq_printf(m, "processor\t: %lu\n", cpu_id);
>>          seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>>          if (!of_property_read_string(node, "riscv,isa", &isa))
>>                  print_isa(m, isa);
>> -       if (!of_property_read_string(node, "mmu-type", &mmu))
>> -               print_mmu(m, mmu);
>> +       print_mmu(m);
>>          if (!of_property_read_string(node, "compatible", &compat)
>>              && strcmp(compat, "riscv"))
>>                  seq_printf(m, "uarch\t\t: %s\n", compat);
>> --
>> 2.20.1
>>

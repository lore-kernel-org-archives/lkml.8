Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5247DC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324C220730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgDGFOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:14:33 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54591 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgDGFOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:14:32 -0400
X-Originating-IP: 2.7.45.25
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8E1DDFF805;
        Tue,  7 Apr 2020 05:14:28 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [RFC PATCH 5/7] riscv: Use pgtable_l4_enabled to output mmu type
 in cpuinfo
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-a151714b-ba54-41dc-bbc6-e215c9594e59@palmerdabbelt-glaptop1>
Message-ID: <eb30b9db-00c7-6f06-f276-0e8e9be4d7df@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:14:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-a151714b-ba54-41dc-bbc6-e215c9594e59@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 11:53 AM, Palmer Dabbelt wrote:
> On Sun, 22 Mar 2020 04:00:26 PDT (-0700), alex@ghiti.fr wrote:
>> Now that the mmu type is determined at runtime using SATP
>> characteristic, use the global variable pgtable_l4_enabled to output
>> mmu type of the processor through /proc/cpuinfo instead of relying on
>> device tree infos.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi |  4 ----
>>  arch/riscv/kernel/cpu.c                    | 24 ++++++++++++----------
>>  2 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi 
>> b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> index 7db861053483..6138590a2229 100644
>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> @@ -50,7 +50,6 @@
>>              i-cache-size = <32768>;
>>              i-tlb-sets = <1>;
>>              i-tlb-size = <32>;
>> -            mmu-type = "riscv,sv39";
>>              reg = <1>;
>>              riscv,isa = "rv64imafdc";
>>              tlb-split;
>> @@ -74,7 +73,6 @@
>>              i-cache-size = <32768>;
>>              i-tlb-sets = <1>;
>>              i-tlb-size = <32>;
>> -            mmu-type = "riscv,sv39";
>>              reg = <2>;
>>              riscv,isa = "rv64imafdc";
>>              tlb-split;
>> @@ -98,7 +96,6 @@
>>              i-cache-size = <32768>;
>>              i-tlb-sets = <1>;
>>              i-tlb-size = <32>;
>> -            mmu-type = "riscv,sv39";
>>              reg = <3>;
>>              riscv,isa = "rv64imafdc";
>>              tlb-split;
>> @@ -122,7 +119,6 @@
>>              i-cache-size = <32768>;
>>              i-tlb-sets = <1>;
>>              i-tlb-size = <32>;
>> -            mmu-type = "riscv,sv39";
>>              reg = <4>;
>>              riscv,isa = "rv64imafdc";
>>              tlb-split;
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index 40a3c442ac5f..38a699b997a8 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -8,6 +8,8 @@
>>  #include <linux/of.h>
>>  #include <asm/smp.h>
>>
>> +extern bool pgtable_l4_enabled;
>> +
>>  /*
>>   * Returns the hart ID of the given device tree node, or -ENODEV if 
>> the node
>>   * isn't an enabled and valid RISC-V hart node.
>> @@ -54,18 +56,19 @@ static void print_isa(struct seq_file *f, const 
>> char *isa)
>>      seq_puts(f, "\n");
>>  }
>>
>> -static void print_mmu(struct seq_file *f, const char *mmu_type)
>> +static void print_mmu(struct seq_file *f)
>>  {
>> +    char sv_type[16];
>> +
>>  #if defined(CONFIG_32BIT)
>> -    if (strcmp(mmu_type, "riscv,sv32") != 0)
>> -        return;
>> +    strncpy(sv_type, "sv32", 5);
>>  #elif defined(CONFIG_64BIT)
>> -    if (strcmp(mmu_type, "riscv,sv39") != 0 &&
>> -        strcmp(mmu_type, "riscv,sv48") != 0)
>> -        return;
>> +    if (pgtable_l4_enabled)
>> +        strncpy(sv_type, "sv48", 5);
>> +    else
>> +        strncpy(sv_type, "sv39", 5);
>>  #endif
>> -
>> -    seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
>> +    seq_printf(f, "mmu\t\t: %s\n", sv_type);
>>  }
>>
>>  static void *c_start(struct seq_file *m, loff_t *pos)
>> @@ -90,14 +93,13 @@ static int c_show(struct seq_file *m, void *v)
>>  {
>>      unsigned long cpu_id = (unsigned long)v - 1;
>>      struct device_node *node = of_get_cpu_node(cpu_id, NULL);
>> -    const char *compat, *isa, *mmu;
>> +    const char *compat, *isa;
>>
>>      seq_printf(m, "processor\t: %lu\n", cpu_id);
>>      seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>>      if (!of_property_read_string(node, "riscv,isa", &isa))
>>          print_isa(m, isa);
>> -    if (!of_property_read_string(node, "mmu-type", &mmu))
>> -        print_mmu(m, mmu);
>> +    print_mmu(m);
>>      if (!of_property_read_string(node, "compatible", &compat)
>>          && strcmp(compat, "riscv"))
>>          seq_printf(m, "uarch\t\t: %s\n", compat);
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks,

Alex

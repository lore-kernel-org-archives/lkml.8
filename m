Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1484BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54F92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:36:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:49662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgBRKgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:36:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DFEDBD96;
        Tue, 18 Feb 2020 10:36:43 +0000 (UTC)
Subject: Re: RPI4: fail too boot with an initrd
To:     LABBE Corentin <clabbe@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, James Morse <james.morse@arm.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20200214132748.GA23276@Red>
 <b726290c-1038-3771-5187-6ac370bc92c9@arm.com> <20200217103733.GA11379@Red>
 <c5a959d7-44b2-fab9-8269-d8e858790925@gmail.com> <20200217125301.GA31847@Red>
 <982c710c-d606-2c04-03ee-604626230bbc@gmail.com> <20200218100128.GB10369@Red>
From:   Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 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
 HxUCQ9Y1Y/Ct
Message-ID: <d9727fac-e7fd-7dfb-ce39-da0c5b0d12a2@suse.com>
Date:   Tue, 18 Feb 2020 11:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218100128.GB10369@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2020 11:01, LABBE Corentin wrote:
> On Mon, Feb 17, 2020 at 02:07:09PM +0100, Matthias Brugger wrote:
>>
>>
>> On 17/02/2020 13:53, LABBE Corentin wrote:
>>> On Mon, Feb 17, 2020 at 11:50:04AM +0100, Matthias Brugger wrote:
>>>>
>>>>
>>>> On 17/02/2020 11:37, LABBE Corentin wrote:
>>>>> On Fri, Feb 14, 2020 at 06:15:27PM +0000, James Morse wrote:
>>>>>> Hi Corentin,
>>>>>>
>>>>>> On 14/02/2020 13:27, LABBE Corentin wrote:
>>>>>>> Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I
>>>>>>> have started to work on adding the rpi4 in kernelCI.
>>>>>>> But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.
>>>>>>>
>>>>>>> Using booti I hit:
>>>>>>> [    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
>>>>>>> [    0.000000] Machine model: Raspberry Pi 4 Model B
>>>>>>> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
>>>>>>> [    0.000000] printk: bootconsole [uart0] enabled
>>>>>>> [    0.000000] efi: Getting EFI parameters from FDT:
>>>>>>> [    0.000000] efi: UEFI not found.
>>>>>>
>>>>>> So no EFI,
>>>>>>
>>>>>>> [    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'
>>>>>>
>>>>>> Out of memory.
>>>>>>
>>>>>>> [    0.000000] cma: Failed to reserve 32 MiB
>>>>>>> [    0.000000] Kernel panic - not syncing: Failed to allocate page table page
>>>>>>
>>>>>> Out of memory...
>>>>>>
>>>>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
>>>>>>> [    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
>>>>>>> [    0.000000] Call trace:
>>>>>>> [    0.000000]  dump_backtrace+0x0/0x1a0
>>>>>>> [    0.000000]  show_stack+0x14/0x20
>>>>>>> [    0.000000]  dump_stack+0xbc/0x104
>>>>>>> [    0.000000]  panic+0x16c/0x37c
>>>>>>> [    0.000000]  early_pgtable_alloc+0x30/0xa0
>>>>>>
>>>>>> ... really early!
>>>>>>
>>>>>>> [    0.000000]  __create_pgd_mapping+0x36c/0x588
>>>>>>> [    0.000000]  map_kernel_segment+0x70/0xa4
>>>>>>> [    0.000000]  paging_init+0xf4/0x528
>>>>>>> [    0.000000]  setup_arch+0x250/0x5d8
>>>>>>> [    0.000000]  start_kernel+0x90/0x6d8
>>>>>>>
>>>>>>>  
>>>>>>> Since the same kernel boot with bootefi and that bootefi lack ramdisk address,
>>>>>>
>>>>>> Booting with EFI will cause linux to use the EFI memory map.
>>>>>>
>>>>>> Does your DT have a memory node? (or does it expect EFI to provide the information)
>>>>>>
>>>>>>
>>>>>>> I tried to add the address in the dtb via:
>>>>>>> fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
>>>>>>> But with that, I get:
>>>>>>> initrd not fully accessible via the linear mapping -- please check your bootloader ...
>>>>>>
>>>>>> So this one is an EFI boot, but you can't find where to put the initramfs such that the
>>>>>> kernel agrees its in memory.
>>>>>>
>>>>>> If you boot with 'efi=debug', linux will print the EFI memory map. Could you compare that
>>>>>> to where U-Boot thinks memory is?
>>>>>>
>>>>>> (it sounds like your DT memory node is missing, and your EFI memory map is surprisingly small)
>>>>>
>>>>> Hello
>>>>>
>>>>> Thanks for your advices.
>>>>>
>>>>> In the dtb of mainline linux:
>>>>> 	/* Will be filled by the bootloader */
>>>>> 	memory@0 {
>>>>> 		device_type = "memory";
>>>>> 		reg = <0 0 0>;
>>>>> 	};
>>>>>
>>>>> In uboot I have:
>>>>> static struct mm_region bcm2711_mem_map[] = {
>>>>>         {
>>>>>                 .virt = 0x00000000UL,
>>>>>                 .phys = 0x00000000UL,
>>>>>                 .size = 0xfe000000UL,
>>>>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>>>                          PTE_BLOCK_INNER_SHARE
>>>>>         }, {
>>>>>                 .virt = 0xfc000000UL,
>>>>>                 .phys = 0xfc000000UL,
>>>>>                 .size = 0x03800000UL,
>>>>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>>                          PTE_BLOCK_NON_SHARE |
>>>>>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>>>         }, {
>>>>>                 /* List terminator */
>>>>>                 0,
>>>>>         }
>>>>> };
>>>>> But I dont know if uboot use that for filling the memory node.
>>>>
>>>> No it doesn't. U-Boot uses the DT from the firmware and passes this to the
>>>> kernel. But it seems you pass instead your own device-tree to the kernel, so you
>>>> will need to update the memory node to show the available memory on you board.
>>>>
>>>
>>> I dont understand, in the Linux commit "ARM: dts: Add minimal Raspberry Pi 4 support" I read:
>>> The RPi 4 is available in 3 different variants (1, 2 and 4 GB RAM), so leave the memory size to zero and let the bootloader take care of it.
>>> But if uboot dont fill that...
>>> So the DTB in mainline is wrong, right ?
>>>
>>
>> How do you pass your DTB to the kernel? Does the FW uses your DTB by putting it
>> as bcm2711-rpi-4-b.dtb in the first FAT partition? Or do you load it from U-Boot
>> afterwards? In the latter case you have to take care to add the needed size of
>> memory. In the first case you use what is the default behavior for U-Boot; the
>> RPi FW updates the node and then passes it to U-Boot then it get's passed to the
>> kernel.
>>
> 
> Hello
> 
> I load the dtb via uboot/tftp.
> On another thread, I got the hint to enable CONFIG_ARCH_FIXUP_FDT_MEMORY and it made my problem solved.

Hm, so should we enable that for all RPi3/4/arm64 configs then?

Regards,
Matthias


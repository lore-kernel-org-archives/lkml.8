Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1CAC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7606206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI+QxzEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBQNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:07:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41272 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgBQNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:07:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so19673613wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=10XW9PRXsoICm6M8PBtfupebYXFVngMlEEz/rUZDsRc=;
        b=BI+QxzEeHyTjTDKpVx1X8sll+Q/Py8kQA2fcBCKUX931Nog7LrAOM5fJhpJO8GVrNp
         sd2uAYy1CmY2xkxlRU9n+ul5sEqeJgU8Y3P0WK3AGuvNUEh3UoXpvVX6nOUafTQd0ht6
         b50xdt8OZPnQmhzDh73XZaAg1bS8NmIjGFjtxWZeQ2z7Gei0cF6o/jNpMOUehDt1Hrxe
         +jwF6DMgYf5FancdxBqAgbv25p9brecjRYgBL8UrhQurvMkQ+y+rWhKq+uHbKdnASEjB
         JtOpJsFdew+1Dk3Knq4lC0UHR+6z1j166FtOqFDSZcNACy3fmbOIe/Iavq/mMKxpYHua
         vj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=10XW9PRXsoICm6M8PBtfupebYXFVngMlEEz/rUZDsRc=;
        b=RnXO9pqli/jb7+xhbCNsqx+ybbsuDXfRB1aTFkHd58GP+hepdZaGjfga2OU8LFRKAw
         hcOoHxOICWOgPJ1QyRcKYFXLyM6TvVwuDsP8glBbdjzR9cIqgx3eTnM+7h7RLjz9mGKI
         jJqv/g2Zn4JeovlA2LzXRnz3BlZusS26BozF18hcQToT0xULfQtVczoUjcdB5cGgr3gi
         kTit61GrqerJhZev7tiqg+BlC0GSzsJDSKFagqkCHxMwCgjigH7p+NM5i0tgxqc8B9lG
         U/GB3M1frAAlpnsXdB0TZtQhgbwRt3lMzNiaoqgESgRLrhz52xiBWOQCZHbFgP8UWq+I
         0yaw==
X-Gm-Message-State: APjAAAUEhZr8rseQ1lOLRwTPkljK+FBh/O32FHawJ/YKthBqCawhp12n
        fXDITlcGtbFFbzVQP1fkMOw=
X-Google-Smtp-Source: APXvYqx1qti7tVyNw0CMWGVPqkwOIq9iMniV8D3qdLEhx9MqdGH3XWZHI8yHHIBm1c0oJniHW4c93g==
X-Received: by 2002:adf:f606:: with SMTP id t6mr22148913wrp.304.1581944831405;
        Mon, 17 Feb 2020 05:07:11 -0800 (PST)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id x6sm967599wrr.6.2020.02.17.05.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 05:07:10 -0800 (PST)
Subject: Re: RPI4: fail too boot with an initrd
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     James Morse <james.morse@arm.com>, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200214132748.GA23276@Red>
 <b726290c-1038-3771-5187-6ac370bc92c9@arm.com> <20200217103733.GA11379@Red>
 <c5a959d7-44b2-fab9-8269-d8e858790925@gmail.com> <20200217125301.GA31847@Red>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <982c710c-d606-2c04-03ee-604626230bbc@gmail.com>
Date:   Mon, 17 Feb 2020 14:07:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217125301.GA31847@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/2020 13:53, LABBE Corentin wrote:
> On Mon, Feb 17, 2020 at 11:50:04AM +0100, Matthias Brugger wrote:
>>
>>
>> On 17/02/2020 11:37, LABBE Corentin wrote:
>>> On Fri, Feb 14, 2020 at 06:15:27PM +0000, James Morse wrote:
>>>> Hi Corentin,
>>>>
>>>> On 14/02/2020 13:27, LABBE Corentin wrote:
>>>>> Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I
>>>>> have started to work on adding the rpi4 in kernelCI.
>>>>> But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.
>>>>>
>>>>> Using booti I hit:
>>>>> [    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
>>>>> [    0.000000] Machine model: Raspberry Pi 4 Model B
>>>>> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
>>>>> [    0.000000] printk: bootconsole [uart0] enabled
>>>>> [    0.000000] efi: Getting EFI parameters from FDT:
>>>>> [    0.000000] efi: UEFI not found.
>>>>
>>>> So no EFI,
>>>>
>>>>> [    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'
>>>>
>>>> Out of memory.
>>>>
>>>>> [    0.000000] cma: Failed to reserve 32 MiB
>>>>> [    0.000000] Kernel panic - not syncing: Failed to allocate page table page
>>>>
>>>> Out of memory...
>>>>
>>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
>>>>> [    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
>>>>> [    0.000000] Call trace:
>>>>> [    0.000000]  dump_backtrace+0x0/0x1a0
>>>>> [    0.000000]  show_stack+0x14/0x20
>>>>> [    0.000000]  dump_stack+0xbc/0x104
>>>>> [    0.000000]  panic+0x16c/0x37c
>>>>> [    0.000000]  early_pgtable_alloc+0x30/0xa0
>>>>
>>>> ... really early!
>>>>
>>>>> [    0.000000]  __create_pgd_mapping+0x36c/0x588
>>>>> [    0.000000]  map_kernel_segment+0x70/0xa4
>>>>> [    0.000000]  paging_init+0xf4/0x528
>>>>> [    0.000000]  setup_arch+0x250/0x5d8
>>>>> [    0.000000]  start_kernel+0x90/0x6d8
>>>>>
>>>>>  
>>>>> Since the same kernel boot with bootefi and that bootefi lack ramdisk address,
>>>>
>>>> Booting with EFI will cause linux to use the EFI memory map.
>>>>
>>>> Does your DT have a memory node? (or does it expect EFI to provide the information)
>>>>
>>>>
>>>>> I tried to add the address in the dtb via:
>>>>> fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
>>>>> But with that, I get:
>>>>> initrd not fully accessible via the linear mapping -- please check your bootloader ...
>>>>
>>>> So this one is an EFI boot, but you can't find where to put the initramfs such that the
>>>> kernel agrees its in memory.
>>>>
>>>> If you boot with 'efi=debug', linux will print the EFI memory map. Could you compare that
>>>> to where U-Boot thinks memory is?
>>>>
>>>> (it sounds like your DT memory node is missing, and your EFI memory map is surprisingly small)
>>>
>>> Hello
>>>
>>> Thanks for your advices.
>>>
>>> In the dtb of mainline linux:
>>> 	/* Will be filled by the bootloader */
>>> 	memory@0 {
>>> 		device_type = "memory";
>>> 		reg = <0 0 0>;
>>> 	};
>>>
>>> In uboot I have:
>>> static struct mm_region bcm2711_mem_map[] = {
>>>         {
>>>                 .virt = 0x00000000UL,
>>>                 .phys = 0x00000000UL,
>>>                 .size = 0xfe000000UL,
>>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>                          PTE_BLOCK_INNER_SHARE
>>>         }, {
>>>                 .virt = 0xfc000000UL,
>>>                 .phys = 0xfc000000UL,
>>>                 .size = 0x03800000UL,
>>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>                          PTE_BLOCK_NON_SHARE |
>>>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>         }, {
>>>                 /* List terminator */
>>>                 0,
>>>         }
>>> };
>>> But I dont know if uboot use that for filling the memory node.
>>
>> No it doesn't. U-Boot uses the DT from the firmware and passes this to the
>> kernel. But it seems you pass instead your own device-tree to the kernel, so you
>> will need to update the memory node to show the available memory on you board.
>>
> 
> I dont understand, in the Linux commit "ARM: dts: Add minimal Raspberry Pi 4 support" I read:
> The RPi 4 is available in 3 different variants (1, 2 and 4 GB RAM), so leave the memory size to zero and let the bootloader take care of it.
> But if uboot dont fill that...
> So the DTB in mainline is wrong, right ?
> 

How do you pass your DTB to the kernel? Does the FW uses your DTB by putting it
as bcm2711-rpi-4-b.dtb in the first FAT partition? Or do you load it from U-Boot
afterwards? In the latter case you have to take care to add the needed size of
memory. In the first case you use what is the default behavior for U-Boot; the
RPi FW updates the node and then passes it to U-Boot then it get's passed to the
kernel.

Regards,
Matthias

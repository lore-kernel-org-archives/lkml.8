Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F8C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30FC206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tvR9YJxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBQKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:37:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54312 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:37:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so16590572wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x83o5K4H6p4Txvf+BbyKgySTjH0wJwSg0fvGXhsTofs=;
        b=tvR9YJxTrg99hkhnZGl1sMuhy3QeyXAh6Bv8GcwN9v9nu0rL/mN6CohWX0bdidFO/9
         guQV8ywdbzRosjv1bTxhkqTk9nHfQVdQnpzGKdEqBtv8ORjIlH69KJyHx0vBHcG3jpAW
         eK4bj5CXtRb0Rj9mJq8RhAP6FKHC/zIoyzIgFz7GG6NIAZCZBM1GEB4Ti7gCJS5e//N2
         ZKHocQsqFCYCcxywSt6UH22cm5O+whiyj3XPUVs/LCYQOk682HB+/hpsWbiWzhEyOdmn
         gEvxN13qqTEfXz6nELHwPrMG62rdEgo3GAYuKEIOR8d9QPNZ9RH6p2NAt6z2O29rdhOT
         j/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x83o5K4H6p4Txvf+BbyKgySTjH0wJwSg0fvGXhsTofs=;
        b=YQhflHFMf624POpqegr739PUQX22iQoAmj4iPkqA2M/E600Sw1FQY8Is9o+LdY//Yc
         2a+8FShMsozKtzIys6acodSdHVzcVsNg0PC6wQeKjZvTiFkcfJpC9QcJvx0fBV3jDkX6
         BPTRc5mXNBFU7ObYv4KTOBhWd3B6WV91Qq3GI3sBwOYJGRCbcxlLoqBZKJ1QqqW3bQO8
         sDnytfkde918HwGOxlyFBfa/oM9CR2aQmwMzFp1UPvBUQziEPI3ClfNGrKvUEzekggWh
         C7ykS5YNZngO545AE3K7Z5SsvOdEmONTAf68FTWKBro/e/IrhcX6eQ3NJuqBasFBnUwU
         /0UA==
X-Gm-Message-State: APjAAAUm7pND2e+Dpf2h4VnuN19fo7H134ZFrUsjyI0DYiAZzv0p7hxB
        XBqIHZYnK7JzUEEkS9d90B7ApA==
X-Google-Smtp-Source: APXvYqxP5y0YSdC1YVMxY92WB7hnIFD3rx/SAWTNQpCjT0PW+oVaZHureZypI7UkkJClVDgwF1sa3w==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr21335773wme.82.1581935856168;
        Mon, 17 Feb 2020 02:37:36 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v14sm368024wrm.28.2020.02.17.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 02:37:35 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:37:33 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     James Morse <james.morse@arm.com>
Cc:     u-boot@lists.denx.de, nsaenzjulienne@suse.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RPI4: fail too boot with an initrd
Message-ID: <20200217103733.GA11379@Red>
References: <20200214132748.GA23276@Red>
 <b726290c-1038-3771-5187-6ac370bc92c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b726290c-1038-3771-5187-6ac370bc92c9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 06:15:27PM +0000, James Morse wrote:
> Hi Corentin,
> 
> On 14/02/2020 13:27, LABBE Corentin wrote:
> > Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I
> > have started to work on adding the rpi4 in kernelCI.
> > But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.
> > 
> > Using booti I hit:
> > [    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
> > [    0.000000] Machine model: Raspberry Pi 4 Model B
> > [    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
> > [    0.000000] printk: bootconsole [uart0] enabled
> > [    0.000000] efi: Getting EFI parameters from FDT:
> > [    0.000000] efi: UEFI not found.
> 
> So no EFI,
> 
> > [    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'
> 
> Out of memory.
> 
> > [    0.000000] cma: Failed to reserve 32 MiB
> > [    0.000000] Kernel panic - not syncing: Failed to allocate page table page
> 
> Out of memory...
> 
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
> > [    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
> > [    0.000000] Call trace:
> > [    0.000000]  dump_backtrace+0x0/0x1a0
> > [    0.000000]  show_stack+0x14/0x20
> > [    0.000000]  dump_stack+0xbc/0x104
> > [    0.000000]  panic+0x16c/0x37c
> > [    0.000000]  early_pgtable_alloc+0x30/0xa0
> 
> ... really early!
> 
> > [    0.000000]  __create_pgd_mapping+0x36c/0x588
> > [    0.000000]  map_kernel_segment+0x70/0xa4
> > [    0.000000]  paging_init+0xf4/0x528
> > [    0.000000]  setup_arch+0x250/0x5d8
> > [    0.000000]  start_kernel+0x90/0x6d8
> > 
> >  
> > Since the same kernel boot with bootefi and that bootefi lack ramdisk address,
> 
> Booting with EFI will cause linux to use the EFI memory map.
> 
> Does your DT have a memory node? (or does it expect EFI to provide the information)
> 
> 
> > I tried to add the address in the dtb via:
> > fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
> > But with that, I get:
> > initrd not fully accessible via the linear mapping -- please check your bootloader ...
> 
> So this one is an EFI boot, but you can't find where to put the initramfs such that the
> kernel agrees its in memory.
> 
> If you boot with 'efi=debug', linux will print the EFI memory map. Could you compare that
> to where U-Boot thinks memory is?
> 
> (it sounds like your DT memory node is missing, and your EFI memory map is surprisingly small)

Hello

Thanks for your advices.

In the dtb of mainline linux:
	/* Will be filled by the bootloader */
	memory@0 {
		device_type = "memory";
		reg = <0 0 0>;
	};

In uboot I have:
static struct mm_region bcm2711_mem_map[] = {
        {
                .virt = 0x00000000UL,
                .phys = 0x00000000UL,
                .size = 0xfe000000UL,
                .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
                         PTE_BLOCK_INNER_SHARE
        }, {
                .virt = 0xfc000000UL,
                .phys = 0xfc000000UL,
                .size = 0x03800000UL,
                .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
                         PTE_BLOCK_NON_SHARE |
                         PTE_BLOCK_PXN | PTE_BLOCK_UXN
        }, {
                /* List terminator */
                0,
        }
};
But I dont know if uboot use that for filling the memory node.


Booting the rpi4 with efi=debug give:
EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable, no randomness supplied
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 5.6.0-rc1-next-20200214 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro GCC 7.4-2019.02)) #70 SMP PREEMPT Fri Feb 14 10:54:54 UTC 2020
[    0.000000] Machine model: Raspberry Pi 4 Model B
[    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi:   System Table: 0x000000003b365590
[    0.000000] efi:   MemMap Address: 0x0000000038484040
[    0.000000] efi:   MemMap Size: 0x00000410
[    0.000000] efi:   MemMap Desc. Size: 0x00000028
[    0.000000] efi:   MemMap Desc. Version: 0x00000001
[    0.000000] efi: EFI v2.80 by Das U-Boot
[    0.000000] efi:  SMBIOS=0x39f46000  MEMRESERVE=0x38487040 
[    0.000000] efi: Processing EFI memory map:
[    0.000000] efi:   0x000000000000-0x000000000fff [Reserved           |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000000001000-0x00000007ffff [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000000080000-0x000001b3ffff [Loader Data        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000001b40000-0x000007efffff [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000007f00000-0x000007f08fff [Boot Data          |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000007f09000-0x0000381fffff [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000038200000-0x0000383fffff [Loader Data        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000038400000-0x00003846ffff [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000038470000-0x00003847ffff [Loader Data        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000038480000-0x000038483fff [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000038484000-0x000038487fff [Loader Data        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000038488000-0x000039f40fff [Loader Code        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f41000-0x000039f44fff [Reserved           |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f45000-0x000039f45fff [Boot Data          |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f46000-0x000039f46fff [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f47000-0x000039f48fff [Boot Data          |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f49000-0x000039f4cfff [Reserved           |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f4d000-0x000039f4efff [Boot Data          |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f4f000-0x000039f52fff [Reserved           |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f53000-0x000039f53fff [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f54000-0x000039f54fff [Reserved           |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000039f55000-0x00003b35ffff [Loader Data        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x00003b360000-0x00003b36ffff [Runtime Code       |RUN|  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x00003b370000-0x00003b3fffff [Loader Data        |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x000040000000-0x0000fbffffff [Boot Data          |   |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x0000fe100000-0x0000fe100fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |  ]
[    0.000000] ------------[ cut here ]------------
[    0.000000] initrd not fully accessible via the linear mapping -- please check your bootloader ...

Regards

Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F758C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0981B20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="il+X/6zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgBQMxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:53:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgBQMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:53:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so19583716wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7R3FILuhN3p+BWRLtBUphGrRXpUsVgK4QWh6n4wz7vw=;
        b=il+X/6zFWwdWFU3GQKLEpKcseKN2qM3E2084edwN17B85FuunBp2lxJhWag48GRblK
         940c3HGHFlq1jcKqiSn8/uURdeuljU2YFjF+Sz2O2jL1jeMSLU89MvA/nut5hDK5HAV2
         hprFcLRI6WKiAhbAO9oEdStZUeIqv9HgyAi5AXGo1clb2kJVzdEyTVXQ+iG+7A1euEBc
         la8FKNxub7fRXIi28kmOTKAcBob/UiRdy21pcJK3KiuInP9AnzjrQ5KHofSRab7UpkUo
         0urdQB9Hzht7pWLYyXRkJXJdRjP06ms2rsnyDxEj7tOzg4rhKfJWyRnTPbuYikDTGpsK
         tTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7R3FILuhN3p+BWRLtBUphGrRXpUsVgK4QWh6n4wz7vw=;
        b=VXY1ryJX37yuBvspZzehdEIQBRejDAg2jqY5YpZFg4j2+2Qa7BJhF+I8+D0PFwpYPM
         Yb6H9JFgrsFrP8xMahZo4eb3hRtYM7VYaHmqYoHBLL41imdbhmcfVGy5tezGZz927GBA
         sOMV/iWgAu/rrb5GenEAqORuLnyae14LROEco27J+Fc75eZd3nVGTyjY7Rp5K9e8lgje
         4nCJ679rZtLQyfRAlLkpuSOU3RyEUy1FMrUbzEZKiUSgsjCPm0dcJpAbf9dO0Y/Qaqjf
         MSGT3FwT4WamHUEWF1q2ATiBLx6ySQmTyMFzzMshR7utKJ5zlL2iep+OTCHZ78G5CJFn
         KXfg==
X-Gm-Message-State: APjAAAUwmdxM1QseVNO7PdVLQKWN4qsCCTOBE1JRDt5RP09V/m8PbEp5
        FhTcnAdQixO6KdjnjqoCqNomDQ==
X-Google-Smtp-Source: APXvYqzVuuAh0xeYF6cOBMa65EbD6xNASq5s4P4o8y3g+Sr134xF2ST8a695PSriNM9d2l7k1jFAvQ==
X-Received: by 2002:adf:f103:: with SMTP id r3mr22193162wro.295.1581943984139;
        Mon, 17 Feb 2020 04:53:04 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j14sm845668wrn.32.2020.02.17.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:53:03 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:53:01 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     James Morse <james.morse@arm.com>, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RPI4: fail too boot with an initrd
Message-ID: <20200217125301.GA31847@Red>
References: <20200214132748.GA23276@Red>
 <b726290c-1038-3771-5187-6ac370bc92c9@arm.com>
 <20200217103733.GA11379@Red>
 <c5a959d7-44b2-fab9-8269-d8e858790925@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a959d7-44b2-fab9-8269-d8e858790925@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:50:04AM +0100, Matthias Brugger wrote:
> 
> 
> On 17/02/2020 11:37, LABBE Corentin wrote:
> > On Fri, Feb 14, 2020 at 06:15:27PM +0000, James Morse wrote:
> >> Hi Corentin,
> >>
> >> On 14/02/2020 13:27, LABBE Corentin wrote:
> >>> Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I
> >>> have started to work on adding the rpi4 in kernelCI.
> >>> But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.
> >>>
> >>> Using booti I hit:
> >>> [    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
> >>> [    0.000000] Machine model: Raspberry Pi 4 Model B
> >>> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
> >>> [    0.000000] printk: bootconsole [uart0] enabled
> >>> [    0.000000] efi: Getting EFI parameters from FDT:
> >>> [    0.000000] efi: UEFI not found.
> >>
> >> So no EFI,
> >>
> >>> [    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'
> >>
> >> Out of memory.
> >>
> >>> [    0.000000] cma: Failed to reserve 32 MiB
> >>> [    0.000000] Kernel panic - not syncing: Failed to allocate page table page
> >>
> >> Out of memory...
> >>
> >>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
> >>> [    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
> >>> [    0.000000] Call trace:
> >>> [    0.000000]  dump_backtrace+0x0/0x1a0
> >>> [    0.000000]  show_stack+0x14/0x20
> >>> [    0.000000]  dump_stack+0xbc/0x104
> >>> [    0.000000]  panic+0x16c/0x37c
> >>> [    0.000000]  early_pgtable_alloc+0x30/0xa0
> >>
> >> ... really early!
> >>
> >>> [    0.000000]  __create_pgd_mapping+0x36c/0x588
> >>> [    0.000000]  map_kernel_segment+0x70/0xa4
> >>> [    0.000000]  paging_init+0xf4/0x528
> >>> [    0.000000]  setup_arch+0x250/0x5d8
> >>> [    0.000000]  start_kernel+0x90/0x6d8
> >>>
> >>>  
> >>> Since the same kernel boot with bootefi and that bootefi lack ramdisk address,
> >>
> >> Booting with EFI will cause linux to use the EFI memory map.
> >>
> >> Does your DT have a memory node? (or does it expect EFI to provide the information)
> >>
> >>
> >>> I tried to add the address in the dtb via:
> >>> fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
> >>> But with that, I get:
> >>> initrd not fully accessible via the linear mapping -- please check your bootloader ...
> >>
> >> So this one is an EFI boot, but you can't find where to put the initramfs such that the
> >> kernel agrees its in memory.
> >>
> >> If you boot with 'efi=debug', linux will print the EFI memory map. Could you compare that
> >> to where U-Boot thinks memory is?
> >>
> >> (it sounds like your DT memory node is missing, and your EFI memory map is surprisingly small)
> > 
> > Hello
> > 
> > Thanks for your advices.
> > 
> > In the dtb of mainline linux:
> > 	/* Will be filled by the bootloader */
> > 	memory@0 {
> > 		device_type = "memory";
> > 		reg = <0 0 0>;
> > 	};
> > 
> > In uboot I have:
> > static struct mm_region bcm2711_mem_map[] = {
> >         {
> >                 .virt = 0x00000000UL,
> >                 .phys = 0x00000000UL,
> >                 .size = 0xfe000000UL,
> >                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> >                          PTE_BLOCK_INNER_SHARE
> >         }, {
> >                 .virt = 0xfc000000UL,
> >                 .phys = 0xfc000000UL,
> >                 .size = 0x03800000UL,
> >                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> >                          PTE_BLOCK_NON_SHARE |
> >                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> >         }, {
> >                 /* List terminator */
> >                 0,
> >         }
> > };
> > But I dont know if uboot use that for filling the memory node.
> 
> No it doesn't. U-Boot uses the DT from the firmware and passes this to the
> kernel. But it seems you pass instead your own device-tree to the kernel, so you
> will need to update the memory node to show the available memory on you board.
> 

I dont understand, in the Linux commit "ARM: dts: Add minimal Raspberry Pi 4 support" I read:
The RPi 4 is available in 3 different variants (1, 2 and 4 GB RAM), so leave the memory size to zero and let the bootloader take care of it.
But if uboot dont fill that...
So the DTB in mainline is wrong, right ?

Regards

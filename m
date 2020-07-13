Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551C2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C120663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594660120;
	bh=yibX3lCVyZboz8BBL2v4pUuz8g18MY1hh+HWQ621WhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o/xvTS+uXiLJ4F9cqilefSuPTef7/L3N3YPBpWCew77GeWmFTFD++T8DitB+ddjcK
	 aha+VUWpjI8Vxq5ut86ik/T5bzjTvMI8GhLTLlRVZLmx27J8pksebegOIbfmij/HtQ
	 bO5bAGDE89OtEPi+f8PC84uh+U3BgC7IOk0kqZ9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgGMRIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMRIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:08:37 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58FF20663;
        Mon, 13 Jul 2020 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594660116;
        bh=yibX3lCVyZboz8BBL2v4pUuz8g18MY1hh+HWQ621WhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APzTr5rHkUQ+w3NEqrW/KjU9tM/7oGArrrYGxiGmtTgqKKkRlhsmXbpIwvr4H+Wpn
         VIeP7n6s1JTgTaYBBFPU1Msnbh/e25J6Gdyri1sGlSuseAQHtz9BHsDpU64QTFAXR0
         /Bdr6sj7wo365quu9JzWx6oCAzp+d/5ySjmn/4h4=
Date:   Mon, 13 Jul 2020 20:08:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: remove it8152 PCI controller driver
Message-ID: <20200713170828.GA832959@kernel.org>
References: <20200708183059.32352-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708183059.32352-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?

Shall I put it into the patch system or will it go via arm-soc tree?

On Wed, Jul 08, 2020 at 09:30:59PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The it8152 PCI host controller was only used by cm-x2xx platforms.
> Since these platforms were removed, there is no point to keep it8152
> driver.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/Kconfig                       |   6 -
>  arch/arm/common/Makefile               |   1 -
>  arch/arm/common/it8152.c               | 352 -------------------------
>  arch/arm/include/asm/hardware/it8152.h | 116 --------
>  arch/arm/kernel/bios32.c               |  17 --
>  5 files changed, 492 deletions(-)
>  delete mode 100644 arch/arm/common/it8152.c
>  delete mode 100644 arch/arm/include/asm/hardware/it8152.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2ac74904a3ce..fa1d1f36937a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1148,12 +1148,6 @@ config PCI_NANOENGINE
>  	help
>  	  Enable PCI on the BSE nanoEngine board.
>  
> -config PCI_HOST_ITE8152
> -	bool
> -	depends on PCI && MACH_ARMCORE
> -	default y
> -	select DMABOUNCE
> -
>  config ARM_ERRATA_814220
>  	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
>  	depends on CPU_V7
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 219a260bbe5f..8cd574be94cf 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -12,7 +12,6 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
>  obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>  obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>  obj-$(CONFIG_CPU_V7)		+= secure_cntvoff.o
> -obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>  obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
>  CFLAGS_REMOVE_mcpm_entry.o	= -pg
>  AFLAGS_mcpm_head.o		:= -march=armv7-a
> diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
> deleted file mode 100644
> index 9ec740cac469..000000000000
> --- a/arch/arm/common/it8152.c
> +++ /dev/null
> @@ -1,352 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/common/it8152.c
> - *
> - * Copyright Compulab Ltd, 2002-2007
> - * Mike Rapoport <mike@compulab.co.il>
> - *
> - * The DMA bouncing part is taken from arch/arm/mach-ixp4xx/common-pci.c
> - * (see this file for respective copyrights)
> - *
> - * Thanks to Guennadi Liakhovetski <gl@dsa-ac.de> for IRQ enumberation
> - * and demux code.
> - */
> -
> -#include <linux/sched.h>
> -#include <linux/kernel.h>
> -#include <linux/pci.h>
> -#include <linux/ptrace.h>
> -#include <linux/interrupt.h>
> -#include <linux/mm.h>
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -#include <linux/export.h>
> -
> -#include <asm/mach/pci.h>
> -#include <asm/hardware/it8152.h>
> -
> -#define MAX_SLOTS		21
> -
> -static void it8152_mask_irq(struct irq_data *d)
> -{
> -	unsigned int irq = d->irq;
> -
> -       if (irq >= IT8152_LD_IRQ(0)) {
> -	       __raw_writel((__raw_readl(IT8152_INTC_LDCNIMR) |
> -			    (1 << (irq - IT8152_LD_IRQ(0)))),
> -			    IT8152_INTC_LDCNIMR);
> -       } else if (irq >= IT8152_LP_IRQ(0)) {
> -	       __raw_writel((__raw_readl(IT8152_INTC_LPCNIMR) |
> -			    (1 << (irq - IT8152_LP_IRQ(0)))),
> -			    IT8152_INTC_LPCNIMR);
> -       } else if (irq >= IT8152_PD_IRQ(0)) {
> -	       __raw_writel((__raw_readl(IT8152_INTC_PDCNIMR) |
> -			    (1 << (irq - IT8152_PD_IRQ(0)))),
> -			    IT8152_INTC_PDCNIMR);
> -       }
> -}
> -
> -static void it8152_unmask_irq(struct irq_data *d)
> -{
> -	unsigned int irq = d->irq;
> -
> -       if (irq >= IT8152_LD_IRQ(0)) {
> -	       __raw_writel((__raw_readl(IT8152_INTC_LDCNIMR) &
> -			     ~(1 << (irq - IT8152_LD_IRQ(0)))),
> -			    IT8152_INTC_LDCNIMR);
> -       } else if (irq >= IT8152_LP_IRQ(0)) {
> -	       __raw_writel((__raw_readl(IT8152_INTC_LPCNIMR) &
> -			     ~(1 << (irq - IT8152_LP_IRQ(0)))),
> -			    IT8152_INTC_LPCNIMR);
> -       } else if (irq >= IT8152_PD_IRQ(0)) {
> -	       __raw_writel((__raw_readl(IT8152_INTC_PDCNIMR) &
> -			     ~(1 << (irq - IT8152_PD_IRQ(0)))),
> -			    IT8152_INTC_PDCNIMR);
> -       }
> -}
> -
> -static struct irq_chip it8152_irq_chip = {
> -	.name		= "it8152",
> -	.irq_ack	= it8152_mask_irq,
> -	.irq_mask	= it8152_mask_irq,
> -	.irq_unmask	= it8152_unmask_irq,
> -};
> -
> -void it8152_init_irq(void)
> -{
> -	int irq;
> -
> -	__raw_writel((0xffff), IT8152_INTC_PDCNIMR);
> -	__raw_writel((0), IT8152_INTC_PDCNIRR);
> -	__raw_writel((0xffff), IT8152_INTC_LPCNIMR);
> -	__raw_writel((0), IT8152_INTC_LPCNIRR);
> -	__raw_writel((0xffff), IT8152_INTC_LDCNIMR);
> -	__raw_writel((0), IT8152_INTC_LDCNIRR);
> -
> -	for (irq = IT8152_IRQ(0); irq <= IT8152_LAST_IRQ; irq++) {
> -		irq_set_chip_and_handler(irq, &it8152_irq_chip,
> -					 handle_level_irq);
> -		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
> -	}
> -}
> -
> -void it8152_irq_demux(struct irq_desc *desc)
> -{
> -       int bits_pd, bits_lp, bits_ld;
> -       int i;
> -
> -       while (1) {
> -	       /* Read all */
> -	       bits_pd = __raw_readl(IT8152_INTC_PDCNIRR);
> -	       bits_lp = __raw_readl(IT8152_INTC_LPCNIRR);
> -	       bits_ld = __raw_readl(IT8152_INTC_LDCNIRR);
> -
> -	       /* Ack */
> -	       __raw_writel((~bits_pd), IT8152_INTC_PDCNIRR);
> -	       __raw_writel((~bits_lp), IT8152_INTC_LPCNIRR);
> -	       __raw_writel((~bits_ld), IT8152_INTC_LDCNIRR);
> -
> -	       if (!(bits_ld | bits_lp | bits_pd)) {
> -		       /* Re-read to guarantee, that there was a moment of
> -			  time, when they all three were 0. */
> -		       bits_pd = __raw_readl(IT8152_INTC_PDCNIRR);
> -		       bits_lp = __raw_readl(IT8152_INTC_LPCNIRR);
> -		       bits_ld = __raw_readl(IT8152_INTC_LDCNIRR);
> -		       if (!(bits_ld | bits_lp | bits_pd))
> -			       return;
> -	       }
> -
> -	       bits_pd &= ((1 << IT8152_PD_IRQ_COUNT) - 1);
> -	       while (bits_pd) {
> -		       i = __ffs(bits_pd);
> -		       generic_handle_irq(IT8152_PD_IRQ(i));
> -		       bits_pd &= ~(1 << i);
> -	       }
> -
> -	       bits_lp &= ((1 << IT8152_LP_IRQ_COUNT) - 1);
> -	       while (bits_lp) {
> -		       i = __ffs(bits_lp);
> -		       generic_handle_irq(IT8152_LP_IRQ(i));
> -		       bits_lp &= ~(1 << i);
> -	       }
> -
> -	       bits_ld &= ((1 << IT8152_LD_IRQ_COUNT) - 1);
> -	       while (bits_ld) {
> -		       i = __ffs(bits_ld);
> -		       generic_handle_irq(IT8152_LD_IRQ(i));
> -		       bits_ld &= ~(1 << i);
> -	       }
> -       }
> -}
> -
> -/* mapping for on-chip devices */
> -int __init it8152_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -	if ((dev->vendor == PCI_VENDOR_ID_ITE) &&
> -	    (dev->device == PCI_DEVICE_ID_ITE_8152)) {
> -		if ((dev->class >> 8) == PCI_CLASS_MULTIMEDIA_AUDIO)
> -			return IT8152_AUDIO_INT;
> -		if ((dev->class >> 8) == PCI_CLASS_SERIAL_USB)
> -			return IT8152_USB_INT;
> -		if ((dev->class >> 8) == PCI_CLASS_SYSTEM_DMA)
> -			return IT8152_CDMA_INT;
> -	}
> -
> -	return 0;
> -}
> -
> -static unsigned long it8152_pci_dev_base_address(struct pci_bus *bus,
> -						 unsigned int devfn)
> -{
> -	unsigned long addr = 0;
> -
> -	if (bus->number == 0) {
> -			if (devfn < PCI_DEVFN(MAX_SLOTS, 0))
> -				addr = (devfn << 8);
> -	} else
> -		addr = (bus->number << 16) | (devfn << 8);
> -
> -	return addr;
> -}
> -
> -static int it8152_pci_read_config(struct pci_bus *bus,
> -				  unsigned int devfn, int where,
> -				  int size, u32 *value)
> -{
> -	unsigned long addr = it8152_pci_dev_base_address(bus, devfn);
> -	u32 v;
> -	int shift;
> -
> -	shift = (where & 3);
> -
> -	__raw_writel((addr + where), IT8152_PCI_CFG_ADDR);
> -	v = (__raw_readl(IT8152_PCI_CFG_DATA)  >> (8 * (shift)));
> -
> -	*value = v;
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int it8152_pci_write_config(struct pci_bus *bus,
> -				   unsigned int devfn, int where,
> -				   int size, u32 value)
> -{
> -	unsigned long addr = it8152_pci_dev_base_address(bus, devfn);
> -	u32 v, vtemp, mask = 0;
> -	int shift;
> -
> -	if (size == 1)
> -		mask = 0xff;
> -	if (size == 2)
> -		mask = 0xffff;
> -
> -	shift = (where & 3);
> -
> -	__raw_writel((addr + where), IT8152_PCI_CFG_ADDR);
> -	vtemp = __raw_readl(IT8152_PCI_CFG_DATA);
> -
> -	if (mask)
> -		vtemp &= ~(mask << (8 * shift));
> -	else
> -		vtemp = 0;
> -
> -	v = (value << (8 * shift));
> -	__raw_writel((addr + where), IT8152_PCI_CFG_ADDR);
> -	__raw_writel((v | vtemp), IT8152_PCI_CFG_DATA);
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -struct pci_ops it8152_ops = {
> -	.read = it8152_pci_read_config,
> -	.write = it8152_pci_write_config,
> -};
> -
> -static struct resource it8152_io = {
> -	.name	= "IT8152 PCI I/O region",
> -	.flags	= IORESOURCE_IO,
> -};
> -
> -static struct resource it8152_mem = {
> -	.name	= "IT8152 PCI memory region",
> -	.start	= 0x10000000,
> -	.end	= 0x13e00000,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -/*
> - * The following functions are needed for DMA bouncing.
> - * ITE8152 chip can address up to 64MByte, so all the devices
> - * connected to ITE8152 (PCI and USB) should have limited DMA window
> - */
> -static int it8152_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
> -{
> -	dev_dbg(dev, "%s: dma_addr %08x, size %08x\n",
> -		__func__, dma_addr, size);
> -	return (dma_addr + size - PHYS_OFFSET) >= SZ_64M;
> -}
> -
> -/*
> - * Setup DMA mask to 64MB on devices connected to ITE8152. Ignore all
> - * other devices.
> - */
> -static int it8152_pci_platform_notify(struct device *dev)
> -{
> -	if (dev_is_pci(dev)) {
> -		if (dev->dma_mask)
> -			*dev->dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
> -		dev->coherent_dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
> -		dmabounce_register_dev(dev, 2048, 4096, it8152_needs_bounce);
> -	}
> -	return 0;
> -}
> -
> -static int it8152_pci_platform_notify_remove(struct device *dev)
> -{
> -	if (dev_is_pci(dev))
> -		dmabounce_unregister_dev(dev);
> -
> -	return 0;
> -}
> -
> -int dma_set_coherent_mask(struct device *dev, u64 mask)
> -{
> -	if (mask >= PHYS_OFFSET + SZ_64M - 1)
> -		return 0;
> -
> -	return -EIO;
> -}
> -
> -int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
> -{
> -	/*
> -	 * FIXME: use pci_ioremap_io to remap the IO space here and
> -	 * move over to the generic io.h implementation.
> -	 * This requires solving the same problem for PXA PCMCIA
> -	 * support.
> -	 */
> -	it8152_io.start = (unsigned long)IT8152_IO_BASE + 0x12000;
> -	it8152_io.end	= (unsigned long)IT8152_IO_BASE + 0x12000 + 0x100000;
> -
> -	sys->mem_offset = 0x10000000;
> -	sys->io_offset  = (unsigned long)IT8152_IO_BASE;
> -
> -	if (request_resource(&ioport_resource, &it8152_io)) {
> -		printk(KERN_ERR "PCI: unable to allocate IO region\n");
> -		goto err0;
> -	}
> -	if (request_resource(&iomem_resource, &it8152_mem)) {
> -		printk(KERN_ERR "PCI: unable to allocate memory region\n");
> -		goto err1;
> -	}
> -
> -	pci_add_resource_offset(&sys->resources, &it8152_io, sys->io_offset);
> -	pci_add_resource_offset(&sys->resources, &it8152_mem, sys->mem_offset);
> -
> -	if (platform_notify || platform_notify_remove) {
> -		printk(KERN_ERR "PCI: Can't use platform_notify\n");
> -		goto err2;
> -	}
> -
> -	platform_notify = it8152_pci_platform_notify;
> -	platform_notify_remove = it8152_pci_platform_notify_remove;
> -
> -	return 1;
> -
> -err2:
> -	release_resource(&it8152_io);
> -err1:
> -	release_resource(&it8152_mem);
> -err0:
> -	return -EBUSY;
> -}
> -
> -/* ITE bridge requires setting latency timer to avoid early bus access
> -   termination by PCI bus master devices
> -*/
> -void pcibios_set_master(struct pci_dev *dev)
> -{
> -	u8 lat;
> -
> -	/* no need to update on-chip OHCI controller */
> -	if ((dev->vendor == PCI_VENDOR_ID_ITE) &&
> -	    (dev->device == PCI_DEVICE_ID_ITE_8152) &&
> -	    ((dev->class >> 8) == PCI_CLASS_SERIAL_USB))
> -		return;
> -
> -	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
> -	if (lat < 16)
> -		lat = (64 <= pcibios_max_latency) ? 64 : pcibios_max_latency;
> -	else if (lat > pcibios_max_latency)
> -		lat = pcibios_max_latency;
> -	else
> -		return;
> -	printk(KERN_DEBUG "PCI: Setting latency timer of device %s to %d\n",
> -	       pci_name(dev), lat);
> -	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
> -}
> -
> -
> -EXPORT_SYMBOL(dma_set_coherent_mask);
> diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
> deleted file mode 100644
> index e175c2384f28..000000000000
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * linux/include/arm/hardware/it8152.h
> - *
> - * Copyright Compulab Ltd., 2006,2007
> - * Mike Rapoport <mike@compulab.co.il>
> - *
> - * ITE 8152 companion chip register definitions
> - */
> -
> -#ifndef __ASM_HARDWARE_IT8152_H
> -#define __ASM_HARDWARE_IT8152_H
> -
> -#include <mach/irqs.h>
> -
> -extern void __iomem *it8152_base_address;
> -
> -#define IT8152_IO_BASE			(it8152_base_address + 0x03e00000)
> -#define IT8152_CFGREG_BASE		(it8152_base_address + 0x03f00000)
> -
> -#define __REG_IT8152(x)			(it8152_base_address + (x))
> -
> -#define IT8152_PCI_CFG_ADDR		__REG_IT8152(0x3f00800)
> -#define IT8152_PCI_CFG_DATA		__REG_IT8152(0x3f00804)
> -
> -#define IT8152_INTC_LDCNIRR		__REG_IT8152(0x3f00300)
> -#define IT8152_INTC_LDPNIRR		__REG_IT8152(0x3f00304)
> -#define IT8152_INTC_LDCNIMR		__REG_IT8152(0x3f00308)
> -#define IT8152_INTC_LDPNIMR		__REG_IT8152(0x3f0030C)
> -#define IT8152_INTC_LDNITR		__REG_IT8152(0x3f00310)
> -#define IT8152_INTC_LDNIAR		__REG_IT8152(0x3f00314)
> -#define IT8152_INTC_LPCNIRR		__REG_IT8152(0x3f00320)
> -#define IT8152_INTC_LPPNIRR		__REG_IT8152(0x3f00324)
> -#define IT8152_INTC_LPCNIMR		__REG_IT8152(0x3f00328)
> -#define IT8152_INTC_LPPNIMR		__REG_IT8152(0x3f0032C)
> -#define IT8152_INTC_LPNITR		__REG_IT8152(0x3f00330)
> -#define IT8152_INTC_LPNIAR		__REG_IT8152(0x3f00334)
> -#define IT8152_INTC_PDCNIRR		__REG_IT8152(0x3f00340)
> -#define IT8152_INTC_PDPNIRR		__REG_IT8152(0x3f00344)
> -#define IT8152_INTC_PDCNIMR		__REG_IT8152(0x3f00348)
> -#define IT8152_INTC_PDPNIMR		__REG_IT8152(0x3f0034C)
> -#define IT8152_INTC_PDNITR		__REG_IT8152(0x3f00350)
> -#define IT8152_INTC_PDNIAR		__REG_IT8152(0x3f00354)
> -#define IT8152_INTC_INTC_TYPER		__REG_IT8152(0x3f003FC)
> -
> -#define IT8152_GPIO_GPDR		__REG_IT8152(0x3f00500)
> -
> -/*
> -  Interrupt controller per register summary:
> -  ---------------------------------------
> -  LCDNIRR:
> -  IT8152_LD_IRQ(8) PCICLK stop
> -  IT8152_LD_IRQ(7) MCLK ready
> -  IT8152_LD_IRQ(6) s/w
> -  IT8152_LD_IRQ(5) UART
> -  IT8152_LD_IRQ(4) GPIO
> -  IT8152_LD_IRQ(3) TIMER 4
> -  IT8152_LD_IRQ(2) TIMER 3
> -  IT8152_LD_IRQ(1) TIMER 2
> -  IT8152_LD_IRQ(0) TIMER 1
> -
> -  LPCNIRR:
> -  IT8152_LP_IRQ(x) serial IRQ x
> -
> -  PCIDNIRR:
> -  IT8152_PD_IRQ(14) PCISERR
> -  IT8152_PD_IRQ(13) CPU/PCI bridge target abort (h2pTADR)
> -  IT8152_PD_IRQ(12) CPU/PCI bridge master abort (h2pMADR)
> -  IT8152_PD_IRQ(11) PCI INTD
> -  IT8152_PD_IRQ(10) PCI INTC
> -  IT8152_PD_IRQ(9)  PCI INTB
> -  IT8152_PD_IRQ(8)  PCI INTA
> -  IT8152_PD_IRQ(7)  serial INTD
> -  IT8152_PD_IRQ(6)  serial INTC
> -  IT8152_PD_IRQ(5)  serial INTB
> -  IT8152_PD_IRQ(4)  serial INTA
> -  IT8152_PD_IRQ(3)  serial IRQ IOCHK (IOCHKR)
> -  IT8152_PD_IRQ(2)  chaining DMA (CDMAR)
> -  IT8152_PD_IRQ(1)  USB (USBR)
> -  IT8152_PD_IRQ(0)  Audio controller (ACR)
> - */
> -#define IT8152_IRQ(x)   (IRQ_BOARD_START + (x))
> -#define IT8152_LAST_IRQ	(IRQ_BOARD_START + 40)
> -
> -/* IRQ-sources in 3 groups - local devices, LPC (serial), and external PCI */
> -#define IT8152_LD_IRQ_COUNT     9
> -#define IT8152_LP_IRQ_COUNT     16
> -#define IT8152_PD_IRQ_COUNT     15
> -
> -/* Priorities: */
> -#define IT8152_PD_IRQ(i)        IT8152_IRQ(i)
> -#define IT8152_LP_IRQ(i)        (IT8152_IRQ(i) + IT8152_PD_IRQ_COUNT)
> -#define IT8152_LD_IRQ(i)        (IT8152_IRQ(i) + IT8152_PD_IRQ_COUNT + IT8152_LP_IRQ_COUNT)
> -
> -/* frequently used interrupts */
> -#define IT8152_PCISERR		IT8152_PD_IRQ(14)
> -#define IT8152_H2PTADR		IT8152_PD_IRQ(13)
> -#define IT8152_H2PMAR		IT8152_PD_IRQ(12)
> -#define IT8152_PCI_INTD		IT8152_PD_IRQ(11)
> -#define IT8152_PCI_INTC		IT8152_PD_IRQ(10)
> -#define IT8152_PCI_INTB		IT8152_PD_IRQ(9)
> -#define IT8152_PCI_INTA		IT8152_PD_IRQ(8)
> -#define IT8152_CDMA_INT		IT8152_PD_IRQ(2)
> -#define IT8152_USB_INT		IT8152_PD_IRQ(1)
> -#define IT8152_AUDIO_INT	IT8152_PD_IRQ(0)
> -
> -struct pci_dev;
> -struct pci_sys_data;
> -
> -extern void it8152_irq_demux(struct irq_desc *desc);
> -extern void it8152_init_irq(void);
> -extern int it8152_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> -extern int it8152_pci_setup(int nr, struct pci_sys_data *sys);
> -extern struct pci_ops it8152_ops;
> -
> -#endif /* __ASM_HARDWARE_IT8152_H */
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ed46ca69813d..eecec16aa708 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -252,23 +252,6 @@ static void pci_fixup_cy82c693(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, pci_fixup_cy82c693);
>  
> -static void pci_fixup_it8152(struct pci_dev *dev)
> -{
> -	int i;
> -	/* fixup for ITE 8152 devices */
> -	/* FIXME: add defines for class 0x68000 and 0x80103 */
> -	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
> -	    dev->class == 0x68000 ||
> -	    dev->class == 0x80103) {
> -		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> -			dev->resource[i].start = 0;
> -			dev->resource[i].end   = 0;
> -			dev->resource[i].flags = 0;
> -		}
> -	}
> -}
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8152, pci_fixup_it8152);
> -
>  /*
>   * If the bus contains any of these devices, then we must not turn on
>   * parity checking of any kind.  Currently this is CyberPro 20x0 only.
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.

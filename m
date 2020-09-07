Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D4C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6060F21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599483381;
	bh=r8XwLOT+Fl8GjUGOIWlzqJipDEUOQcYrqvqD7Z/xYoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qu+VRYha9wTgqHSHX5lwT+3iF6glvsurdMY+1OJQZGtFnIxXLIlQihTLp7JnMBDQg
	 bjZfcepe1XcGISr5Czu1reU1OL6wM7uvut+V2hiBAGKnWEq2wvjz3J95+Ov3FGO/7p
	 BsJANrp+9dcsYmqQxAbXbRRNMOaTftXku+gibWmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgIGM4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgIGMzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:55:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4CD21481;
        Mon,  7 Sep 2020 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599483322;
        bh=r8XwLOT+Fl8GjUGOIWlzqJipDEUOQcYrqvqD7Z/xYoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzEe41B6Cw6b/aVYDrCUxrwIfinEQPc4BIdNz62rXyRyh/rR2VexN2Wb++9KNYnw0
         1sm7cVt52uySUo+VwqEE3vGKUiMbJfDyX9Qpr6qreBk+R5il8kFAl6TgLTmS4WdZgH
         uAlFwsE0SWuZmZH6g8H4zHNIbr6YjlutbPerfcbI=
Date:   Mon, 7 Sep 2020 14:55:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v3 2/3] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200907125530.GC2371705@kroah.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825194400.28960-3-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 12:43:59PM -0700, Scott Branden wrote:
> Add Broadcom VK driver offload engine.
> This driver interfaces to the VK PCIe offload engine to perform
> should offload functions as video transcoding on multiple streams
> in parallel.  VK device is booted from files loaded using
> request_firmware_into_buf mechanism.  After booted card status is updated
> and messages can then be sent to the card.
> Such messages contain scatter gather list of addresses
> to pull data from the host to perform operations on.
> 
> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> Co-developed-by: James Hu <james.hu@broadcom.com>
> Signed-off-by: James Hu <james.hu@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/misc/Kconfig             |    1 +
>  drivers/misc/Makefile            |    1 +
>  drivers/misc/bcm-vk/Kconfig      |   29 +
>  drivers/misc/bcm-vk/Makefile     |   11 +
>  drivers/misc/bcm-vk/bcm_vk.h     |  430 +++++++++
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 1475 +++++++++++++++++++++++++++++
>  drivers/misc/bcm-vk/bcm_vk_msg.c | 1523 ++++++++++++++++++++++++++++++
>  drivers/misc/bcm-vk/bcm_vk_msg.h |  211 +++++
>  drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 ++++++
>  drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
>  drivers/misc/bcm-vk/bcm_vk_tty.c |  365 +++++++
>  11 files changed, 4382 insertions(+)
>  create mode 100644 drivers/misc/bcm-vk/Kconfig
>  create mode 100644 drivers/misc/bcm-vk/Makefile
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ce136d685d14..9d42b5def81b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -469,6 +469,7 @@ source "drivers/misc/genwqe/Kconfig"
>  source "drivers/misc/echo/Kconfig"
>  source "drivers/misc/cxl/Kconfig"
>  source "drivers/misc/ocxl/Kconfig"
> +source "drivers/misc/bcm-vk/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c7bd01ac6291..766837e4b961 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_ECHO)		+= echo/
>  obj-$(CONFIG_CXL_BASE)		+= cxl/
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
> +obj-$(CONFIG_BCM_VK)		+= bcm-vk/
>  obj-y				+= cardreader/
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> new file mode 100644
> index 000000000000..a3a020b19e3b
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/Kconfig
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Broadcom VK device
> +#
> +config BCM_VK
> +	tristate "Support for Broadcom VK Accelerators"
> +	depends on PCI_MSI
> +	help
> +	  Select this option to enable support for Broadcom
> +	  VK Accelerators.  VK is used for performing
> +	  specific offload processing.
> +	  This driver enables userspace programs to access these
> +	  accelerators via /dev/bcm-vk.N devices.
> +
> +	  If unsure, say N.
> +
> +if BCM_VK
> +
> +config BCM_VK_QSTATS
> +	bool "VK Queue Statistics"
> +	help
> +	  Turn on to enable Queue Statistics.
> +	  These are useful for debugging purposes.
> +	  Some performance loss by enabling this debug config.
> +	  For properly operating PCIe hardware no need to enable this.
> +
> +	  If unsure, say N.
> +
> +endif
> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
> new file mode 100644
> index 000000000000..05cb213ee826
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for Broadcom VK driver
> +#
> +
> +obj-$(CONFIG_BCM_VK) += bcm_vk.o
> +bcm_vk-objs := \
> +	bcm_vk_dev.o \
> +	bcm_vk_msg.o \
> +	bcm_vk_sg.o \
> +	bcm_vk_tty.o
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> new file mode 100644
> index 000000000000..33478ccc1be3
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -0,0 +1,430 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#ifndef BCM_VK_H
> +#define BCM_VK_H
> +
> +#include <linux/atomic.h>
> +#include <linux/firmware.h>
> +#include <linux/irq.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/poll.h>
> +#include <linux/sched/signal.h>
> +#include <linux/tty.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/misc/bcm_vk.h>
> +
> +#include "bcm_vk_msg.h"
> +
> +#define DRV_MODULE_NAME		"bcm-vk"
> +
> +/*
> + * Load Image is completed in two stages:
> + *
> + * 1) When the VK device boot-up, M7 CPU runs and executes the BootROM.
> + * The Secure Boot Loader (SBL) as part of the BootROM will run
> + * to open up ITCM for host to push BOOT1 image.
> + * SBL will authenticate the image before jumping to BOOT1 image.
> + *
> + * 2) Because BOOT1 image is a secured image, we also called it the
> + * Secure Boot Image (SBI). At second stage, SBI will initialize DDR
> + * and wait for host to push BOOT2 image to DDR.
> + * SBI will authenticate the image before jumping to BOOT2 image.
> + *
> + */
> +/* Location of registers of interest in BAR0 */
> +
> +/* Request register for Secure Boot Loader (SBL) download */
> +#define BAR_CODEPUSH_SBL		0x400
> +/* Start of ITCM */
> +#define CODEPUSH_BOOT1_ENTRY		0x00400000
> +#define CODEPUSH_MASK		        0xfffff000
> +#define CODEPUSH_BOOTSTART		BIT(0)
> +
> +/* Boot Status register */
> +#define BAR_BOOT_STATUS			0x404
> +
> +#define SRAM_OPEN			BIT(16)
> +#define DDR_OPEN			BIT(17)
> +
> +/* Firmware loader progress status definitions */
> +#define FW_LOADER_ACK_SEND_MORE_DATA	BIT(18)
> +#define FW_LOADER_ACK_IN_PROGRESS	BIT(19)
> +#define FW_LOADER_ACK_RCVD_ALL_DATA	BIT(20)
> +
> +/* Boot1/2 is running in standalone mode */
> +#define BOOT_STDALONE_RUNNING		BIT(21)
> +
> +/* definitions for boot status register */
> +#define BOOT_STATE_MASK			(0xffffffff & \
> +					 ~(FW_LOADER_ACK_SEND_MORE_DATA | \
> +					   FW_LOADER_ACK_IN_PROGRESS | \
> +					   BOOT_STDALONE_RUNNING))
> +
> +#define BOOT_ERR_SHIFT			4
> +#define BOOT_ERR_MASK			(0xf << BOOT_ERR_SHIFT)
> +#define BOOT_PROG_MASK			0xf
> +
> +#define BROM_STATUS_NOT_RUN		0x2
> +#define BROM_NOT_RUN			(SRAM_OPEN | BROM_STATUS_NOT_RUN)
> +#define BROM_STATUS_COMPLETE		0x6
> +#define BROM_RUNNING			(SRAM_OPEN | BROM_STATUS_COMPLETE)
> +#define BOOT1_STATUS_COMPLETE		0x6
> +#define BOOT1_RUNNING			(DDR_OPEN | BOOT1_STATUS_COMPLETE)
> +#define BOOT2_STATUS_COMPLETE		0x6
> +#define BOOT2_RUNNING			(FW_LOADER_ACK_RCVD_ALL_DATA | \
> +					 BOOT2_STATUS_COMPLETE)
> +
> +/* Boot request for Secure Boot Image (SBI) */
> +#define BAR_CODEPUSH_SBI		0x408
> +/* 64M mapped to BAR2 */
> +#define CODEPUSH_BOOT2_ENTRY		0x60000000
> +
> +#define BAR_CARD_STATUS			0x410
> +/* CARD_STATUS definitions */
> +#define CARD_STATUS_TTYVK0_READY	BIT(0)
> +#define CARD_STATUS_TTYVK1_READY	BIT(1)
> +
> +#define BAR_BOOT1_STDALONE_PROGRESS	0x420
> +#define BOOT1_STDALONE_SUCCESS		(BIT(13) | BIT(14))
> +#define BOOT1_STDALONE_PROGRESS_MASK	BOOT1_STDALONE_SUCCESS
> +
> +#define BAR_METADATA_VERSION		0x440
> +#define BAR_OS_UPTIME			0x444
> +#define BAR_CHIP_ID			0x448
> +#define MAJOR_SOC_REV(_chip_id)		(((_chip_id) >> 20) & 0xf)
> +
> +#define BAR_CARD_TEMPERATURE		0x45c
> +/* defines for all temperature sensor */
> +#define BCM_VK_TEMP_FIELD_MASK		0xff
> +#define BCM_VK_CPU_TEMP_SHIFT		0
> +#define BCM_VK_DDR0_TEMP_SHIFT		8
> +#define BCM_VK_DDR1_TEMP_SHIFT		16
> +
> +#define BAR_CARD_VOLTAGE		0x460
> +/* defines for voltage rail conversion */
> +#define BCM_VK_VOLT_RAIL_MASK		0xffff
> +#define BCM_VK_3P3_VOLT_REG_SHIFT	16
> +
> +#define BAR_CARD_ERR_LOG		0x464
> +/* Error log register bit definition - register for error alerts */
> +#define ERR_LOG_UECC			BIT(0)
> +#define ERR_LOG_SSIM_BUSY		BIT(1)
> +#define ERR_LOG_AFBC_BUSY		BIT(2)
> +#define ERR_LOG_HIGH_TEMP_ERR		BIT(3)
> +#define ERR_LOG_WDOG_TIMEOUT		BIT(4)
> +#define ERR_LOG_SYS_FAULT		BIT(5)
> +#define ERR_LOG_RAMDUMP			BIT(6)
> +#define ERR_LOG_MEM_ALLOC_FAIL		BIT(8)
> +#define ERR_LOG_LOW_TEMP_WARN		BIT(9)
> +#define ERR_LOG_ECC			BIT(10)
> +/* Alert bit definitions detectd on host */
> +#define ERR_LOG_HOST_INTF_V_FAIL	BIT(13)
> +#define ERR_LOG_HOST_HB_FAIL		BIT(14)
> +#define ERR_LOG_HOST_PCIE_DWN		BIT(15)
> +
> +#define BAR_CARD_ERR_MEM		0x468
> +/* defines for mem err, all fields have same width */
> +#define BCM_VK_MEM_ERR_FIELD_MASK	0xff
> +#define BCM_VK_ECC_MEM_ERR_SHIFT	0
> +#define BCM_VK_UECC_MEM_ERR_SHIFT	8
> +/* threshold of event occurrence and logs start to come out */
> +#define BCM_VK_ECC_THRESHOLD		10
> +#define BCM_VK_UECC_THRESHOLD		1
> +
> +#define BAR_CARD_PWR_AND_THRE		0x46c
> +/* defines for power and temp threshold, all fields have same width */
> +#define BCM_VK_PWR_AND_THRE_FIELD_MASK	0xff
> +#define BCM_VK_LOW_TEMP_THRE_SHIFT	0
> +#define BCM_VK_HIGH_TEMP_THRE_SHIFT	8
> +#define BCM_VK_PWR_STATE_SHIFT		16
> +
> +#define BAR_CARD_STATIC_INFO		0x470
> +
> +#define BAR_INTF_VER			0x47c
> +#define BAR_INTF_VER_MAJOR_SHIFT	16
> +#define BAR_INTF_VER_MASK		0xffff
> +/*
> + * major and minor semantic version numbers supported
> + * Please update as required on interface changes
> + */
> +#define SEMANTIC_MAJOR			1
> +#define SEMANTIC_MINOR			0
> +
> +#define BAR_BOOTSRC_SELECT		0xc78
> +/* BOOTSRC definitions */
> +#define BOOTSRC_SOFT_ENABLE		BIT(14)
> +
> +/* Card OS Firmware version size */
> +#define BAR_FIRMWARE_TAG_SIZE		50
> +#define FIRMWARE_STATUS_PRE_INIT_DONE	0x1f
> +
> +/* VK MSG_ID defines */
> +#define VK_MSG_ID_BITMAP_SIZE		4096
> +#define VK_MSG_ID_BITMAP_MASK		(VK_MSG_ID_BITMAP_SIZE - 1)
> +#define VK_MSG_ID_OVERFLOW		0xffff
> +
> +/* VK device supports a maximum of 3 bars */
> +#define MAX_BAR	3
> +
> +/* default number of msg blk for inband SGL */
> +#define BCM_VK_DEF_IB_SGL_BLK_LEN	 16
> +#define BCM_VK_IB_SGL_BLK_MAX		 24
> +
> +enum pci_barno {
> +	BAR_0 = 0,
> +	BAR_1,
> +	BAR_2
> +};
> +
> +#define BCM_VK_NUM_TTY 2
> +
> +struct bcm_vk_tty {
> +	struct tty_port port;
> +	uint32_t to_offset;	/* bar offset to use */
> +	uint32_t to_size;	/* to VK buffer size */
> +	uint32_t wr;		/* write offset shadow */
> +	uint32_t from_offset;	/* bar offset to use */
> +	uint32_t from_size;	/* from VK buffer size */
> +	uint32_t rd;		/* read offset shadow */

nit, these "unit32_t" stuff really doesn't matter in the kernel, 'u32'
is a better choice overall.  Same for u8 and others, for this whole
driver.

> +	pid_t pid;
> +	bool irq_enabled;
> +	bool is_opened;		/* tracks tty open/close */

Why do you need to track this?  Doesn't the tty core handle this for
you?

> +};
> +
> +/* VK device max power state, supports 3, full, reduced and low */
> +#define MAX_OPP 3
> +#define MAX_CARD_INFO_TAG_SIZE 64
> +
> +struct bcm_vk_card_info {
> +	uint32_t version;
> +	char os_tag[MAX_CARD_INFO_TAG_SIZE];
> +	char cmpt_tag[MAX_CARD_INFO_TAG_SIZE];
> +	uint32_t cpu_freq_mhz;
> +	uint32_t cpu_scale[MAX_OPP];
> +	uint32_t ddr_freq_mhz;
> +	uint32_t ddr_size_MB;
> +	uint32_t video_core_freq_mhz;
> +};
> +
> +/* DAUTH related info */
> +struct bcm_vk_dauth_key {
> +	char store[VK_BAR1_DAUTH_STORE_SIZE];
> +	char valid[VK_BAR1_DAUTH_VALID_SIZE];
> +};
> +
> +struct bcm_vk_dauth_info {
> +	struct bcm_vk_dauth_key keys[VK_BAR1_DAUTH_MAX];
> +};
> +
> +/*
> + * Control structure of logging messages from the card.  This
> + * buffer is for logmsg that comes from vk
> + */
> +struct bcm_vk_peer_log {
> +	uint32_t rd_idx;
> +	uint32_t wr_idx;
> +	uint32_t buf_size;
> +	uint32_t mask;
> +	char data[0];
> +};
> +
> +/* max size per line of peer log */
> +#define BCM_VK_PEER_LOG_LINE_MAX  256
> +
> +/*
> + * single entry for processing type + utilization
> + */
> +#define BCM_VK_PROC_TYPE_TAG_LEN 8
> +struct bcm_vk_proc_mon_entry_t {
> +	char tag[BCM_VK_PROC_TYPE_TAG_LEN];
> +	uint32_t used;
> +	uint32_t max; /**< max capacity */
> +};
> +
> +/**
> + * Structure for run time utilization
> + */
> +#define BCM_VK_PROC_MON_MAX 8 /* max entries supported */
> +struct bcm_vk_proc_mon_info {
> +	uint32_t num; /**< no of entries */
> +	uint32_t entry_size; /**< per entry size */
> +	struct bcm_vk_proc_mon_entry_t entries[BCM_VK_PROC_MON_MAX];
> +};
> +
> +struct bcm_vk_hb_ctrl {
> +	struct timer_list timer;
> +	uint32_t last_uptime;
> +	uint32_t lost_cnt;
> +};
> +
> +struct bcm_vk_alert {
> +	uint16_t flags;
> +	uint16_t notfs;
> +};
> +
> +/* some alert counters that the driver will keep track */
> +struct bcm_vk_alert_cnts {
> +	uint16_t ecc;
> +	uint16_t uecc;
> +};
> +
> +struct bcm_vk {
> +	struct pci_dev *pdev;

So you have a pointer to your parent pci device, and...

> +	void __iomem *bar[MAX_BAR];
> +	int num_irqs;
> +
> +	struct bcm_vk_card_info card_info;
> +	struct bcm_vk_proc_mon_info proc_mon_info;
> +	struct bcm_vk_dauth_info dauth_info;
> +
> +#if defined(BCM_VK_LEGACY_API)
> +	struct msix_entry msix[32];
> +#endif
> +	/* mutex to protect the ioctls */
> +	struct mutex mutex;
> +	struct miscdevice miscdev;
> +	int misc_devid; /* dev id allocated */

a misc device, and...

> +
> +	struct tty_driver *tty_drv;
> +	struct timer_list serial_timer;
> +	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];

A number of tty ports?

> +	struct workqueue_struct *tty_wq_thread;
> +	struct work_struct tty_wq_work;
> +
> +	/* Reference-counting to handle file operations */
> +	struct kref kref;

And a kref?

What is controlling the lifetime rules of your structure?

Why a kref?

Why the tty ports?

Why the misc device?

This feels really crazy to me...

> +
> +	spinlock_t msg_id_lock; /* Spinlock for msg_id */
> +	uint16_t msg_id;
> +	DECLARE_BITMAP(bmap, VK_MSG_ID_BITMAP_SIZE);
> +	spinlock_t ctx_lock; /* Spinlock for component context */
> +	struct bcm_vk_ctx ctx[VK_CMPT_CTX_MAX];
> +	struct bcm_vk_ht_entry pid_ht[VK_PID_HT_SZ];
> +	pid_t reset_pid; /* process that issue reset */
> +
> +	atomic_t msgq_inited; /* indicate if info has been synced with vk */
> +	struct bcm_vk_msg_chan to_v_msg_chan;
> +	struct bcm_vk_msg_chan to_h_msg_chan;
> +
> +	struct workqueue_struct *wq_thread;
> +	struct work_struct wq_work; /* work queue for deferred job */
> +	unsigned long wq_offload[1]; /* various flags on wq requested */
> +	void *tdma_vaddr; /* test dma segment virtual addr */
> +	dma_addr_t tdma_addr; /* test dma segment bus addr */
> +
> +	struct notifier_block panic_nb;
> +	uint32_t ib_sgl_size; /* size allocated for inband sgl insertion */
> +
> +	/* heart beat mechanism control structure */
> +	struct bcm_vk_hb_ctrl hb_ctrl;
> +	/* house-keeping variable of error logs */
> +	spinlock_t host_alert_lock; /* protection to access host_alert struct */
> +	struct bcm_vk_alert host_alert;
> +	struct bcm_vk_alert peer_alert; /* bits set by the card */
> +	struct bcm_vk_alert_cnts alert_cnts;
> +
> +	/* offset of the peer log control in BAR2 */
> +	uint32_t peerlog_off;
> +	struct bcm_vk_peer_log peerlog_info; /* record of peer log info */
> +	/* offset of processing monitoring info in BAR2 */
> +	uint32_t proc_mon_off;
> +};
> +
> +/* wq offload work items bits definitions */
> +enum bcm_vk_wq_offload_flags {
> +	BCM_VK_WQ_DWNLD_PEND = 0,
> +	BCM_VK_WQ_DWNLD_AUTO = 1,
> +	BCM_VK_WQ_NOTF_PEND  = 2,
> +};
> +
> +/* a macro to get an individual field with mask and shift */
> +#define BCM_VK_EXTRACT_FIELD(_field, _reg, _mask, _shift) \
> +		(_field = (((_reg) >> (_shift)) & (_mask)))
> +
> +/* structure that is used to faciliate displaying of register content */
> +struct bcm_vk_entry {
> +	const uint32_t mask;
> +	const uint32_t exp_val;
> +	const char *str;
> +};
> +
> +/* alerts that could be generated from peer */
> +#define BCM_VK_PEER_ERR_NUM 10
> +extern struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM];
> +/* alerts detected by the host */
> +#define BCM_VK_HOST_ERR_NUM 3
> +extern struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM];
> +
> +/*
> + * check if PCIe interface is down on read.  Use it when it is
> + * certain that _val should never be all ones.
> + */
> +#define BCM_VK_INTF_IS_DOWN(val) ((val) == 0xffffffff)
> +
> +static inline uint32_t vkread32(struct bcm_vk *vk,
> +				enum pci_barno bar,
> +				uint64_t offset)
> +{
> +	return readl(vk->bar[bar] + offset);
> +}


"vk"?  What is that prefix for?

> +
> +static inline void vkwrite32(struct bcm_vk *vk,
> +			     uint32_t value,
> +			     enum pci_barno bar,
> +			     uint64_t offset)
> +{
> +	writel(value, vk->bar[bar] + offset);
> +}
> +
> +static inline uint8_t vkread8(struct bcm_vk *vk,
> +			      enum pci_barno bar,
> +			      uint64_t offset)
> +{
> +	return readb(vk->bar[bar] + offset);
> +}
> +
> +static inline void vkwrite8(struct bcm_vk *vk,
> +			    uint8_t value,
> +			    enum pci_barno bar,
> +			    uint64_t offset)
> +{
> +	writeb(value, vk->bar[bar] + offset);
> +}
> +
> +int bcm_vk_open(struct inode *inode, struct file *p_file);
> +ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
> +		    loff_t *f_pos);
> +ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
> +		     size_t count, loff_t *f_pos);
> +__poll_t bcm_vk_poll(struct file *p_file, struct poll_table_struct *wait);
> +int bcm_vk_release(struct inode *inode, struct file *p_file);
> +void bcm_vk_release_data(struct kref *kref);
> +irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
> +irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
> +irqreturn_t bcm_vk_tty_irqhandler(int irq, void *dev_id);
> +int bcm_vk_msg_init(struct bcm_vk *vk);
> +void bcm_vk_msg_remove(struct bcm_vk *vk);
> +int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync);
> +bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk);
> +void bcm_vk_blk_drv_access(struct bcm_vk *vk);
> +int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, uint32_t shut_type,
> +			     const pid_t pid, const uint32_t q_num);
> +int bcm_vk_trigger_reset(struct bcm_vk *vk);
> +void bcm_to_v_q_doorbell(struct bcm_vk *vk, uint32_t q_num, uint32_t db_val);
> +void bcm_to_v_reset_doorbell(struct bcm_vk *vk, uint32_t db_val);
> +int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
> +int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
> +void bcm_vk_tty_exit(struct bcm_vk *vk);
> +void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
> +void bcm_vk_hb_init(struct bcm_vk *vk);
> +void bcm_vk_hb_deinit(struct bcm_vk *vk);
> +void bcm_vk_handle_notf(struct bcm_vk *vk);
> +bool bcm_vk_drv_access_ok(struct bcm_vk *vk);
> +void bcm_vk_set_host_alert(struct bcm_vk *vk, uint32_t bit_mask);

Are all of these prototypes really needed as they are global?

At quick glance, it really looks like most of them, if not all, do not
need to be here and can be made static to the local .c file.

> +
> +#endif
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> new file mode 100644
> index 000000000000..4ce0dc0263ea
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -0,0 +1,1475 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/fs.h>
> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/poll.h>
> +#include <uapi/linux/misc/bcm_vk.h>
> +
> +#include "bcm_vk.h"
> +
> +#define PCI_DEVICE_ID_VALKYRIE	0x5e87
> +#define PCI_DEVICE_ID_VIPER	0x5e88
> +
> +static DEFINE_IDA(bcm_vk_ida);
> +
> +enum soc_idx {
> +	VALKYRIE_A0 = 0,
> +	VALKYRIE_B0,
> +	VIPER,
> +	VK_IDX_INVALID
> +};
> +
> +enum img_idx {
> +	IMG_PRI = 0,
> +	IMG_SEC,
> +	IMG_PER_TYPE_MAX
> +};
> +
> +struct load_image_entry {
> +	const uint32_t image_type;
> +	const char *image_name[IMG_PER_TYPE_MAX];
> +};
> +
> +#define NUM_BOOT_STAGES 2
> +/* default firmware images names */
> +static const struct load_image_entry image_tab[][NUM_BOOT_STAGES] = {
> +	[VALKYRIE_A0] = {
> +		{VK_IMAGE_TYPE_BOOT1, {"vk_a0-boot1.bin", "vk-boot1.bin"}},
> +		{VK_IMAGE_TYPE_BOOT2, {"vk_a0-boot2.bin", "vk-boot2.bin"}}
> +	},
> +	[VALKYRIE_B0] = {
> +		{VK_IMAGE_TYPE_BOOT1, {"vk_b0-boot1.bin", "vk-boot1.bin"}},
> +		{VK_IMAGE_TYPE_BOOT2, {"vk_b0-boot2.bin", "vk-boot2.bin"}}
> +	},
> +
> +	[VIPER] = {
> +		{VK_IMAGE_TYPE_BOOT1, {"vp-boot1.bin", ""}},
> +		{VK_IMAGE_TYPE_BOOT2, {"vp-boot2.bin", ""}}
> +	},
> +};
> +
> +/* Location of memory base addresses of interest in BAR1 */
> +/* Load Boot1 to start of ITCM */
> +#define BAR1_CODEPUSH_BASE_BOOT1	0x100000
> +
> +/* Allow minimum 1s for Load Image timeout responses */
> +#define LOAD_IMAGE_TIMEOUT_MS		(1 * MSEC_PER_SEC)
> +
> +/* Image startup timeouts */
> +#define BOOT1_STARTUP_TIMEOUT_MS	(5 * MSEC_PER_SEC)
> +#define BOOT2_STARTUP_TIMEOUT_MS	(10 * MSEC_PER_SEC)
> +
> +/* 1ms wait for checking the transfer complete status */
> +#define TXFR_COMPLETE_TIMEOUT_MS	1
> +
> +/* MSIX usages */
> +#define VK_MSIX_MSGQ_MAX		3
> +#define VK_MSIX_NOTF_MAX		1
> +#define VK_MSIX_TTY_MAX			BCM_VK_NUM_TTY
> +#define VK_MSIX_IRQ_MAX			(VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX + \
> +					 VK_MSIX_TTY_MAX)
> +#define VK_MSIX_IRQ_MIN_REQ             (VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX)
> +
> +/* Number of bits set in DMA mask*/
> +#define BCM_VK_DMA_BITS			64
> +
> +/* Ucode boot wait time */
> +#define BCM_VK_UCODE_BOOT_US            (100 * USEC_PER_MSEC)
> +/* 50% margin */
> +#define BCM_VK_UCODE_BOOT_MAX_US        ((BCM_VK_UCODE_BOOT_US * 3) >> 1)
> +
> +/* deinit time for the card os after receiving doorbell */
> +#define BCM_VK_DEINIT_TIME_MS		(2 * MSEC_PER_SEC)
> +
> +/*
> + * module parameters
> + */
> +static bool auto_load = true;
> +module_param(auto_load, bool, 0444);
> +MODULE_PARM_DESC(auto_load,
> +		 "Load images automatically at PCIe probe time.\n");
> +static uint nr_scratch_pages = VK_BAR1_SCRATCH_DEF_NR_PAGES;
> +module_param(nr_scratch_pages, uint, 0444);
> +MODULE_PARM_DESC(nr_scratch_pages,
> +		 "Number of pre allocated DMAable coherent pages.\n");
> +static uint nr_ib_sgl_blk = BCM_VK_DEF_IB_SGL_BLK_LEN;
> +module_param(nr_ib_sgl_blk, uint, 0444);
> +MODULE_PARM_DESC(nr_ib_sgl_blk,
> +		 "Number of in-band msg blks for short SGL.\n");

Please do not use module parameters, this isn't the 1990's.  We have
real ways to configure drivers now that is per-device, which module
parameters are not at all.

And why are any of these needed at all?  Ideally a driver would "just
work" and not need to be tuned at all.  Who would ever modify these?

> +
> +/*
> + * alerts that could be generated from peer
> + */
> +struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM] = {
> +	{ERR_LOG_UECC, ERR_LOG_UECC, "uecc"},
> +	{ERR_LOG_SSIM_BUSY, ERR_LOG_SSIM_BUSY, "ssim_busy"},
> +	{ERR_LOG_AFBC_BUSY, ERR_LOG_AFBC_BUSY, "afbc_busy"},
> +	{ERR_LOG_HIGH_TEMP_ERR, ERR_LOG_HIGH_TEMP_ERR, "high_temp"},
> +	{ERR_LOG_WDOG_TIMEOUT, ERR_LOG_WDOG_TIMEOUT, "wdog_timeout"},
> +	{ERR_LOG_SYS_FAULT, ERR_LOG_SYS_FAULT, "sys_fault"},
> +	{ERR_LOG_RAMDUMP, ERR_LOG_RAMDUMP, "ramdump"},
> +	{ERR_LOG_MEM_ALLOC_FAIL, ERR_LOG_MEM_ALLOC_FAIL, "malloc_fail warn"},
> +	{ERR_LOG_LOW_TEMP_WARN, ERR_LOG_LOW_TEMP_WARN, "low_temp warn"},
> +	{ERR_LOG_ECC, ERR_LOG_ECC, "ecc"},
> +};
> +
> +/* alerts detected by the host */
> +struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM] = {
> +	{ERR_LOG_HOST_PCIE_DWN, ERR_LOG_HOST_PCIE_DWN, "PCIe_down"},
> +	{ERR_LOG_HOST_HB_FAIL, ERR_LOG_HOST_HB_FAIL, "hb_fail"},
> +	{ERR_LOG_HOST_INTF_V_FAIL, ERR_LOG_HOST_INTF_V_FAIL, "intf_ver_fail"},
> +};
> +
> +irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id)

global function?

> +{
> +	struct bcm_vk *vk = dev_id;
> +
> +	if (!bcm_vk_drv_access_ok(vk)) {
> +		dev_err(&vk->pdev->dev,
> +			"Interrupt %d received when msgq not inited\n", irq);
> +		goto skip_schedule_work;
> +	}
> +
> +	/* if notification is not pending, set bit and schedule work */
> +	if (test_and_set_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload) == 0)
> +		queue_work(vk->wq_thread, &vk->wq_work);
> +
> +skip_schedule_work:
> +	return IRQ_HANDLED;
> +}
> +
> +static int bcm_vk_intf_ver_chk(struct bcm_vk *vk)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	uint32_t reg;
> +	uint16_t major, minor;
> +	int ret = 0;
> +
> +	/* read interface register */
> +	reg = vkread32(vk, BAR_0, BAR_INTF_VER);
> +	major = (reg >> BAR_INTF_VER_MAJOR_SHIFT) & BAR_INTF_VER_MASK;
> +	minor = reg & BAR_INTF_VER_MASK;

You are reading a major/minor device number from the hardware?  Are
these not the same thing as what we normally call a major/minor device
node information in Linux?

If not, what are they?

If so, why does the hardware care?

> +
> +	/*
> +	 * if major number is 0, it is pre-release and it would be allowed
> +	 * to continue, else, check versions accordingly
> +	 */
> +	if (!major) {
> +		dev_warn(dev, "Pre-release major.minor=%d.%d - drv %d.%d\n",
> +			 major, minor, SEMANTIC_MAJOR, SEMANTIC_MINOR);
> +	} else if ((major != SEMANTIC_MAJOR) || (minor > SEMANTIC_MINOR)) {
> +		dev_err(dev,
> +			"Intf major.minor=%d.%d rejected - drv %d.%d\n",
> +			major, minor, SEMANTIC_MAJOR, SEMANTIC_MINOR);
> +		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_INTF_V_FAIL);
> +		ret = -EIO;

An I/O error did not just happen :(

> +	} else {
> +		dev_dbg(dev,
> +			"Intf major.minor=%d.%d passed - drv %d.%d\n",
> +			major, minor, SEMANTIC_MAJOR, SEMANTIC_MINOR);
> +	}
> +	return ret;
> +}
> +
> +static void bcm_vk_log_notf(struct bcm_vk *vk,
> +			    struct bcm_vk_alert *alert,
> +			    struct bcm_vk_entry const *entry_tab,
> +			    const uint32_t table_size)
> +{
> +	uint32_t i;
> +	uint32_t masked_val, latched_val;
> +	struct bcm_vk_entry const *entry;
> +	uint32_t reg;
> +	uint16_t ecc_mem_err, uecc_mem_err;
> +	struct device *dev = &vk->pdev->dev;
> +
> +	for (i = 0; i < table_size; i++) {
> +		entry = &entry_tab[i];
> +		masked_val = entry->mask & alert->notfs;
> +		latched_val = entry->mask & alert->flags;
> +
> +		if (masked_val == ERR_LOG_UECC) {
> +			/*
> +			 * if there is difference between stored cnt and it
> +			 * is greater than threshold, log it.
> +			 */
> +			reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
> +			BCM_VK_EXTRACT_FIELD(uecc_mem_err, reg,
> +					     BCM_VK_MEM_ERR_FIELD_MASK,
> +					     BCM_VK_UECC_MEM_ERR_SHIFT);
> +			if ((uecc_mem_err != vk->alert_cnts.uecc) &&
> +			    (uecc_mem_err >= BCM_VK_UECC_THRESHOLD))
> +				dev_info(dev,
> +					 "ALERT! %s.%d uecc RAISED - ErrCnt %d\n",
> +					 DRV_MODULE_NAME, vk->misc_devid,
> +					 uecc_mem_err);
> +			vk->alert_cnts.uecc = uecc_mem_err;
> +		} else if (masked_val == ERR_LOG_ECC) {
> +			reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
> +			BCM_VK_EXTRACT_FIELD(ecc_mem_err, reg,
> +					     BCM_VK_MEM_ERR_FIELD_MASK,
> +					     BCM_VK_ECC_MEM_ERR_SHIFT);
> +			if ((ecc_mem_err != vk->alert_cnts.ecc) &&
> +			    (ecc_mem_err >= BCM_VK_ECC_THRESHOLD))
> +				dev_info(dev, "ALERT! %s.%d ecc RAISED - ErrCnt %d\n",
> +					 DRV_MODULE_NAME, vk->misc_devid,
> +					 ecc_mem_err);
> +			vk->alert_cnts.ecc = ecc_mem_err;
> +		} else if (masked_val != latched_val) {
> +			/* print a log as info */
> +			dev_info(dev, "ALERT! %s.%d %s %s\n",
> +				 DRV_MODULE_NAME, vk->misc_devid, entry->str,
> +				 masked_val ? "RAISED" : "CLEARED");
> +		}
> +	}
> +}
> +
> +static void bcm_vk_dump_peer_log(struct bcm_vk *vk)
> +{
> +	struct bcm_vk_peer_log log;
> +	struct bcm_vk_peer_log *log_info = &vk->peerlog_info;
> +	char loc_buf[BCM_VK_PEER_LOG_LINE_MAX];
> +	int cnt;
> +	struct device *dev = &vk->pdev->dev;
> +	uint data_offset;
> +
> +	memcpy_fromio(&log, vk->bar[BAR_2] + vk->peerlog_off, sizeof(log));
> +
> +	dev_dbg(dev, "Peer PANIC: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
> +		log.buf_size, log.mask, log.rd_idx, log.wr_idx);
> +
> +	/* perform range checking for rd/wr idx */
> +	if ((log.rd_idx > log_info->mask) ||
> +	    (log.wr_idx > log_info->mask) ||
> +	    (log.buf_size != log_info->buf_size) ||
> +	    (log.mask != log_info->mask)) {
> +		dev_err(dev,
> +			"Corrupted Ptrs: Size 0x%x(0x%x) Mask 0x%x(0x%x) [Rd Wr] = [%d %d], skip log dump.\n",
> +			log_info->buf_size, log.buf_size,
> +			log_info->mask, log.mask,
> +			log.rd_idx, log.wr_idx);
> +		return;
> +	}
> +
> +	cnt = 0;
> +	data_offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log);
> +	loc_buf[BCM_VK_PEER_LOG_LINE_MAX - 1] = '\0';
> +	while (log.rd_idx != log.wr_idx) {
> +		loc_buf[cnt] = vkread8(vk, BAR_2, data_offset + log.rd_idx);
> +
> +		if ((loc_buf[cnt] == '\0') ||
> +		    (cnt == (BCM_VK_PEER_LOG_LINE_MAX - 1))) {
> +			dev_err(dev, "%s", loc_buf);
> +			cnt = 0;
> +		} else {
> +			cnt++;
> +		}
> +		log.rd_idx = (log.rd_idx + 1) & log.mask;
> +	}
> +	/* update rd idx at the end */
> +	vkwrite32(vk, log.rd_idx, BAR_2,
> +		  vk->peerlog_off + offsetof(struct bcm_vk_peer_log, rd_idx));
> +}
> +
> +void bcm_vk_handle_notf(struct bcm_vk *vk)
> +{
> +	uint32_t reg;
> +	struct bcm_vk_alert alert;
> +	bool intf_down;
> +	unsigned long flags;
> +
> +	/* handle peer alerts and then locally detected ones */
> +	reg = vkread32(vk, BAR_0, BAR_CARD_ERR_LOG);
> +	intf_down = BCM_VK_INTF_IS_DOWN(reg);
> +	if (!intf_down) {
> +		vk->peer_alert.notfs = reg;
> +		bcm_vk_log_notf(vk, &vk->peer_alert, bcm_vk_peer_err,
> +				ARRAY_SIZE(bcm_vk_peer_err));
> +		vk->peer_alert.flags = vk->peer_alert.notfs;
> +	} else {
> +		/* turn off access */
> +		bcm_vk_blk_drv_access(vk);
> +	}
> +
> +	/* check and make copy of alert with lock and then free lock */
> +	spin_lock_irqsave(&vk->host_alert_lock, flags);
> +	if (intf_down)
> +		vk->host_alert.notfs |= ERR_LOG_HOST_PCIE_DWN;
> +
> +	alert = vk->host_alert;
> +	vk->host_alert.flags = vk->host_alert.notfs;
> +	spin_unlock_irqrestore(&vk->host_alert_lock, flags);
> +
> +	/* call display with copy */
> +	bcm_vk_log_notf(vk, &alert, bcm_vk_host_err,
> +			ARRAY_SIZE(bcm_vk_host_err));
> +
> +	/*
> +	 * If it is a sys fault or heartbeat timeout, we would like extract
> +	 * log msg from the card so that we would know what is the last fault
> +	 */
> +	if (!intf_down &&
> +	    ((vk->host_alert.flags & ERR_LOG_HOST_HB_FAIL) ||
> +	     (vk->peer_alert.flags & ERR_LOG_SYS_FAULT)))
> +		bcm_vk_dump_peer_log(vk);
> +}
> +
> +static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
> +			      uint64_t offset, uint32_t mask, uint32_t value,
> +			      unsigned long timeout_ms)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	unsigned long start_time;
> +	unsigned long timeout;
> +	uint32_t rd_val, boot_status;
> +
> +	start_time = jiffies;
> +	timeout = start_time + msecs_to_jiffies(timeout_ms);
> +
> +	do {
> +		rd_val = vkread32(vk, bar, offset);
> +		dev_dbg(dev, "BAR%d Offset=0x%llx: 0x%x\n",
> +			bar, offset, rd_val);
> +
> +		/* check for any boot err condition */
> +		boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
> +		if (boot_status & BOOT_ERR_MASK) {
> +			dev_err(dev, "Boot Err 0x%x, progress 0x%x after %d ms\n",
> +				(boot_status & BOOT_ERR_MASK) >> BOOT_ERR_SHIFT,
> +				boot_status & BOOT_PROG_MASK,
> +				jiffies_to_msecs(jiffies - start_time));
> +			return -EFAULT;
> +		}
> +
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +
> +		cpu_relax();
> +		cond_resched();

Why call both?

And sitting and spinning like this feels odd, but ok...

> +	} while ((rd_val & mask) != value);
> +
> +	return 0;
> +}
> +
> +static void bcm_vk_get_card_info(struct bcm_vk *vk)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	uint32_t offset;
> +	int i;
> +	uint8_t *dst;
> +	struct bcm_vk_card_info *info = &vk->card_info;
> +
> +	/* first read the offset from spare register */
> +	offset = vkread32(vk, BAR_0, BAR_CARD_STATIC_INFO);
> +	offset &= (pci_resource_len(vk->pdev, BAR_2 * 2) - 1);
> +
> +	/* based on the offset, read info to internal card info structure */
> +	dst = (uint8_t *)info;
> +	for (i = 0; i < sizeof(*info); i++)
> +		*dst++ = vkread8(vk, BAR_2, offset++);
> +
> +#define CARD_INFO_LOG_FMT "version   : %x\n" \
> +			  "os_tag    : %s\n" \
> +			  "cmpt_tag  : %s\n" \
> +			  "cpu_freq  : %d MHz\n" \
> +			  "cpu_scale : %d full, %d lowest\n" \
> +			  "ddr_freq  : %d MHz\n" \
> +			  "ddr_size  : %d MB\n" \
> +			  "video_freq: %d MHz\n"
> +	dev_dbg(dev, CARD_INFO_LOG_FMT, info->version, info->os_tag,
> +		info->cmpt_tag, info->cpu_freq_mhz, info->cpu_scale[0],
> +		info->cpu_scale[MAX_OPP - 1], info->ddr_freq_mhz,
> +		info->ddr_size_MB, info->video_core_freq_mhz);
> +
> +	/*
> +	 * get the peer log pointer, only need the offset, and get record
> +	 * of the log buffer information which would be used for checking
> +	 * before dump, in case the BAR2 memory has been corrupted.
> +	 */
> +	vk->peerlog_off = offset;
> +	memcpy_fromio(&vk->peerlog_info, vk->bar[BAR_2] + vk->peerlog_off,
> +		      sizeof(vk->peerlog_info));
> +	dev_dbg(dev, "Peer log: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
> +		vk->peerlog_info.buf_size,
> +		vk->peerlog_info.mask,
> +		vk->peerlog_info.rd_idx,
> +		vk->peerlog_info.wr_idx);
> +}
> +
> +static void bcm_vk_get_proc_mon_info(struct bcm_vk *vk)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	struct bcm_vk_proc_mon_info *mon = &vk->proc_mon_info;
> +	uint32_t num, entry_size, offset, buf_size;
> +	uint8_t *dst;
> +
> +	/* calculate offset which is based on peerlog offset */
> +	buf_size = vkread32(vk, BAR_2,
> +			    vk->peerlog_off
> +			    + offsetof(struct bcm_vk_peer_log, buf_size));
> +	offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log)
> +		 + buf_size;
> +
> +	/* first read the num and entry size */
> +	num = vkread32(vk, BAR_2, offset);
> +	entry_size = vkread32(vk, BAR_2, offset + sizeof(num));
> +
> +	/* check for max allowed */
> +	if (num > BCM_VK_PROC_MON_MAX) {
> +		dev_err(dev, "Processing monitoring entry %d exceeds max %d\n",
> +			num, BCM_VK_PROC_MON_MAX);
> +		return;
> +	}
> +	mon->num = num;
> +	mon->entry_size = entry_size;
> +
> +	vk->proc_mon_off = offset;
> +
> +	/* read it once that will capture those static info */
> +	dst = (uint8_t *)&mon->entries[0];
> +	offset += sizeof(num) + sizeof(entry_size);
> +	memcpy_fromio(dst, vk->bar[BAR_2] + offset, num * entry_size);
> +}
> +
> +static int bcm_vk_sync_card_info(struct bcm_vk *vk)
> +{
> +	uint32_t rdy_marker = vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
> +
> +	/* check for marker, but allow diags mode to skip sync */
> +	if (!bcm_vk_msgq_marker_valid(vk))
> +		return (rdy_marker == VK_BAR1_DIAG_RDY_MARKER ? 0 : -EINVAL);
> +
> +	/*
> +	 * Write down scratch addr which is used for DMA. For
> +	 * signed part, BAR1 is accessible only after boot2 has come
> +	 * up
> +	 */
> +	if (vk->tdma_addr) {
> +		vkwrite32(vk, (uint64_t)vk->tdma_addr >> 32, BAR_1,
> +			  VK_BAR1_SCRATCH_OFF_HI);
> +		vkwrite32(vk, (uint32_t)vk->tdma_addr, BAR_1,
> +			  VK_BAR1_SCRATCH_OFF_LO);
> +		vkwrite32(vk, nr_scratch_pages * PAGE_SIZE, BAR_1,
> +			  VK_BAR1_SCRATCH_SZ_ADDR);
> +	}
> +
> +	/* get static card info, only need to read once */
> +	bcm_vk_get_card_info(vk);
> +
> +	/* get the proc mon info once */
> +	bcm_vk_get_proc_mon_info(vk);
> +
> +	return 0;
> +}
> +
> +void bcm_vk_blk_drv_access(struct bcm_vk *vk)
> +{
> +	int i;
> +
> +	/*
> +	 * kill all the apps except for the process that is resetting.
> +	 * If not called during reset, reset_pid will be 0, and all will be
> +	 * killed.
> +	 */
> +	spin_lock(&vk->ctx_lock);
> +
> +	/* set msgq_inited to 0 so that all rd/wr will be blocked */
> +	atomic_set(&vk->msgq_inited, 0);
> +
> +	for (i = 0; i < VK_PID_HT_SZ; i++) {
> +		struct bcm_vk_ctx *ctx;
> +
> +		list_for_each_entry(ctx, &vk->pid_ht[i].head, node) {
> +			if (ctx->pid != vk->reset_pid) {
> +				dev_dbg(&vk->pdev->dev,
> +					"Send kill signal to pid %d\n",
> +					ctx->pid);
> +				kill_pid(find_vpid(ctx->pid), SIGKILL, 1);
> +			}
> +		}
> +	}
> +	bcm_vk_tty_terminate_tty_user(vk);
> +	spin_unlock(&vk->ctx_lock);
> +}
> +
> +static void bcm_vk_buf_notify(struct bcm_vk *vk, void *bufp,
> +			      dma_addr_t host_buf_addr, uint32_t buf_size)
> +{
> +	/* update the dma address to the card */
> +	vkwrite32(vk, (uint64_t)host_buf_addr >> 32, BAR_1,
> +		  VK_BAR1_DMA_BUF_OFF_HI);
> +	vkwrite32(vk, (uint32_t)host_buf_addr, BAR_1,
> +		  VK_BAR1_DMA_BUF_OFF_LO);
> +	vkwrite32(vk, buf_size, BAR_1, VK_BAR1_DMA_BUF_SZ);
> +}
> +
> +static int bcm_vk_load_image_by_type(struct bcm_vk *vk, uint32_t load_type,
> +				     const char *filename)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	const struct firmware *fw = NULL;
> +	void *bufp = NULL;
> +	size_t max_buf, offset;
> +	int ret;
> +	uint64_t offset_codepush;
> +	uint32_t codepush;
> +	uint32_t value;
> +	dma_addr_t boot_dma_addr;
> +	bool is_stdalone;
> +
> +	if (load_type == VK_IMAGE_TYPE_BOOT1) {
> +		/*
> +		 * After POR, enable VK soft BOOTSRC so bootrom do not clear
> +		 * the pushed image (the TCM memories).
> +		 */
> +		value = vkread32(vk, BAR_0, BAR_BOOTSRC_SELECT);
> +		value |= BOOTSRC_SOFT_ENABLE;
> +		vkwrite32(vk, value, BAR_0, BAR_BOOTSRC_SELECT);
> +
> +		codepush = CODEPUSH_BOOTSTART + CODEPUSH_BOOT1_ENTRY;
> +		offset_codepush = BAR_CODEPUSH_SBL;
> +
> +		/* Write a 1 to request SRAM open bit */
> +		vkwrite32(vk, CODEPUSH_BOOTSTART, BAR_0, offset_codepush);
> +
> +		/* Wait for VK to respond */
> +		ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, SRAM_OPEN,
> +				  SRAM_OPEN, LOAD_IMAGE_TIMEOUT_MS);
> +		if (ret < 0) {
> +			dev_err(dev, "boot1 wait SRAM err - ret(%d)\n", ret);
> +			goto err_buf_out;
> +		}
> +
> +		max_buf = SZ_256K;
> +		bufp = dma_alloc_coherent(dev,
> +					  max_buf,
> +					  &boot_dma_addr, GFP_KERNEL);
> +		if (!bufp) {
> +			dev_err(dev, "Error allocating 0x%zx\n", max_buf);
> +			ret = -ENOMEM;
> +			goto err_buf_out;
> +		}
> +	} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
> +		codepush = CODEPUSH_BOOT2_ENTRY;
> +		offset_codepush = BAR_CODEPUSH_SBI;
> +
> +		/* Wait for VK to respond */
> +		ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, DDR_OPEN,
> +				  DDR_OPEN, LOAD_IMAGE_TIMEOUT_MS);
> +		if (ret < 0) {
> +			dev_err(dev, "boot2 wait DDR open error - ret(%d)\n",
> +				ret);
> +			goto err_buf_out;
> +		}
> +
> +		max_buf = SZ_4M;
> +		bufp = dma_alloc_coherent(dev,
> +					  max_buf,
> +					  &boot_dma_addr, GFP_KERNEL);
> +		if (!bufp) {
> +			dev_err(dev, "Error allocating 0x%zx\n", max_buf);
> +			ret = -ENOMEM;
> +			goto err_buf_out;
> +		}
> +
> +		bcm_vk_buf_notify(vk, bufp, boot_dma_addr, max_buf);
> +	} else {
> +		dev_err(dev, "Error invalid image type 0x%x\n", load_type);
> +		ret = -EINVAL;
> +		goto err_buf_out;
> +	}
> +
> +	offset = 0;
> +	ret = request_partial_firmware_into_buf(&fw, filename, dev,
> +						bufp, max_buf, offset);
> +	if (ret) {
> +		dev_err(dev, "Error %d requesting firmware file: %s\n",
> +			ret, filename);
> +		goto err_firmware_out;
> +	}
> +	dev_dbg(dev, "size=0x%zx\n", fw->size);
> +	if (load_type == VK_IMAGE_TYPE_BOOT1)
> +		memcpy_toio(vk->bar[BAR_1] + BAR1_CODEPUSH_BASE_BOOT1,
> +			    bufp,
> +			    fw->size);
> +
> +	dev_dbg(dev, "Signaling 0x%x to 0x%llx\n", codepush, offset_codepush);
> +	vkwrite32(vk, codepush, BAR_0, offset_codepush);
> +
> +	if (load_type == VK_IMAGE_TYPE_BOOT1) {
> +		/* wait until done */
> +		ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
> +				  BOOT1_RUNNING,
> +				  BOOT1_RUNNING,
> +				  BOOT1_STARTUP_TIMEOUT_MS);
> +
> +		is_stdalone = vkread32(vk, BAR_0, BAR_BOOT_STATUS) &
> +			      BOOT_STDALONE_RUNNING;
> +		if (ret && !is_stdalone) {
> +			dev_err(dev,
> +				"Timeout %ld ms waiting for boot1 to come up - ret(%d)\n",
> +				BOOT1_STARTUP_TIMEOUT_MS, ret);
> +			goto err_firmware_out;
> +		} else if (is_stdalone) {
> +			uint32_t reg;
> +
> +			reg = vkread32(vk, BAR_0, BAR_BOOT1_STDALONE_PROGRESS);
> +			if ((reg & BOOT1_STDALONE_PROGRESS_MASK) ==
> +				     BOOT1_STDALONE_SUCCESS) {
> +				dev_info(dev, "Boot1 standalone success\n");
> +				ret = 0;
> +			} else {
> +				dev_err(dev, "Timeout %ld ms - Boot1 standalone failure\n",
> +					BOOT1_STARTUP_TIMEOUT_MS);
> +				ret = -EINVAL;
> +				goto err_firmware_out;
> +			}
> +		}
> +	} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
> +		unsigned long timeout;
> +
> +		timeout = jiffies + msecs_to_jiffies(LOAD_IMAGE_TIMEOUT_MS);
> +
> +		/* To send more data to VK than max_buf allowed at a time */
> +		do {
> +			/*
> +			 * Check for ack from card. when Ack is received,
> +			 * it means all the data is received by card.
> +			 * Exit the loop after ack is received.
> +			 */
> +			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
> +					  FW_LOADER_ACK_RCVD_ALL_DATA,
> +					  FW_LOADER_ACK_RCVD_ALL_DATA,
> +					  TXFR_COMPLETE_TIMEOUT_MS);
> +			if (ret == 0) {
> +				dev_info(dev, "Exit boot2 download\n");
> +				break;
> +			} else if (ret == -EFAULT) {
> +				dev_err(dev, "Error detected during ACK waiting");
> +				goto err_firmware_out;
> +			}
> +
> +			/* exit the loop, if there is no response from card */
> +			if (time_after(jiffies, timeout)) {
> +				dev_err(dev, "Error. No reply from card\n");
> +				ret = -ETIMEDOUT;
> +				goto err_firmware_out;
> +			}
> +
> +			/* Wait for VK to open BAR space to copy new data */
> +			ret = bcm_vk_wait(vk, BAR_0, offset_codepush,
> +					  codepush, 0,
> +					  TXFR_COMPLETE_TIMEOUT_MS);
> +			if (ret == 0) {
> +				offset += max_buf;
> +				ret = request_partial_firmware_into_buf
> +						(&fw,
> +						 filename,
> +						 dev, bufp,
> +						 max_buf,
> +						 offset);
> +				if (ret) {
> +					dev_err(dev,
> +						"Error %d requesting firmware file: %s offset: 0x%zx\n",
> +						ret, filename, offset);
> +					goto err_firmware_out;
> +				}
> +				dev_dbg(dev, "size=0x%zx\n", fw->size);
> +				dev_dbg(dev, "Signaling 0x%x to 0x%llx\n",
> +					codepush, offset_codepush);
> +				vkwrite32(vk, codepush, BAR_0, offset_codepush);
> +				/* reload timeout after every codepush */
> +				timeout = jiffies +
> +				    msecs_to_jiffies(LOAD_IMAGE_TIMEOUT_MS);
> +			} else if (ret == -EFAULT) {
> +				dev_err(dev, "Error detected waiting for transfer\n");
> +				goto err_firmware_out;
> +			}
> +		} while (1);
> +
> +		/* wait for fw status bits to indicate app ready */
> +		ret = bcm_vk_wait(vk, BAR_0, VK_BAR_FWSTS,
> +				  VK_FWSTS_READY,
> +				  VK_FWSTS_READY,
> +				  BOOT2_STARTUP_TIMEOUT_MS);
> +		if (ret < 0) {
> +			dev_err(dev, "Boot2 not ready - ret(%d)\n", ret);
> +			goto err_firmware_out;
> +		}
> +
> +		is_stdalone = vkread32(vk, BAR_0, BAR_BOOT_STATUS) &
> +			      BOOT_STDALONE_RUNNING;
> +		if (!is_stdalone) {
> +			ret = bcm_vk_intf_ver_chk(vk);
> +			if (ret) {
> +				dev_err(dev, "failure in intf version check\n");
> +				goto err_firmware_out;
> +			}
> +
> +			/*
> +			 * Next, initialize Message Q if we are loading boot2.
> +			 * Do a force sync
> +			 */
> +			ret = bcm_vk_sync_msgq(vk, true);
> +			if (ret) {
> +				dev_err(dev, "Boot2 Error reading comm msg Q info\n");
> +				ret = -EIO;
> +				goto err_firmware_out;
> +			}
> +
> +			/* sync & channel other info */
> +			ret = bcm_vk_sync_card_info(vk);
> +			if (ret) {
> +				dev_err(dev, "Syncing Card Info failure\n");
> +				goto err_firmware_out;
> +			}
> +		}
> +	}
> +
> +err_firmware_out:
> +	release_firmware(fw);
> +
> +err_buf_out:
> +	if (bufp)
> +		dma_free_coherent(dev, max_buf, bufp, boot_dma_addr);
> +
> +	return ret;
> +}
> +
> +static uint32_t bcm_vk_next_boot_image(struct bcm_vk *vk)
> +{
> +	uint32_t boot_status;
> +	uint32_t fw_status;
> +	uint32_t load_type = 0;  /* default for unknown */
> +
> +	boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
> +	fw_status = vkread32(vk, BAR_0, VK_BAR_FWSTS);
> +
> +	if (!BCM_VK_INTF_IS_DOWN(boot_status) && (boot_status & SRAM_OPEN))
> +		load_type = VK_IMAGE_TYPE_BOOT1;
> +	else if (boot_status == BOOT1_RUNNING)
> +		load_type = VK_IMAGE_TYPE_BOOT2;
> +
> +	/*
> +	 * TO_FIX: For now, like to know what value we get everytime
> +	 *         for debugging.
> +	 */
> +	dev_info(&vk->pdev->dev,
> +		 "boot-status value for next image: 0x%x : fw-status 0x%x\n",
> +		 boot_status, fw_status);
> +
> +	return load_type;
> +}
> +
> +static enum soc_idx get_soc_idx(struct bcm_vk *vk)
> +{
> +	struct pci_dev *pdev = vk->pdev;
> +	enum soc_idx idx = VK_IDX_INVALID;
> +	uint32_t rev;
> +	static enum soc_idx const vk_soc_tab[] = { VALKYRIE_A0, VALKYRIE_B0 };
> +
> +	switch (pdev->device) {
> +	case PCI_DEVICE_ID_VALKYRIE:
> +		/* get the chip id to decide sub-class */
> +		rev = MAJOR_SOC_REV(vkread32(vk, BAR_0, BAR_CHIP_ID));
> +		if (rev < ARRAY_SIZE(vk_soc_tab)) {
> +			idx = vk_soc_tab[rev];
> +		} else {
> +			/* Default to A0 firmware for all other chip revs */
> +			idx = VALKYRIE_A0;
> +			dev_warn(&pdev->dev,
> +				 "Rev %d not in image lookup table, default to idx=%d\n",
> +				 rev, idx);
> +		}
> +		break;
> +
> +	case PCI_DEVICE_ID_VIPER:
> +		idx = VIPER;
> +		break;
> +
> +	default:
> +		dev_err(&pdev->dev, "no images for 0x%x\n", pdev->device);
> +	}
> +	return idx;
> +}
> +
> +static const char *get_load_fw_name(struct bcm_vk *vk,
> +				    const struct load_image_entry *entry)
> +{
> +	const struct firmware *fw;
> +	struct device *dev = &vk->pdev->dev;
> +	int ret;
> +	unsigned long dummy;
> +	int i;
> +
> +	for (i = 0; i < IMG_PER_TYPE_MAX; i++) {
> +		fw = NULL;
> +		ret = request_partial_firmware_into_buf(&fw,
> +							entry->image_name[i],
> +							dev, &dummy,
> +							sizeof(dummy),
> +							0);
> +		release_firmware(fw);
> +		if (!ret)
> +			return entry->image_name[i];
> +	}
> +	return NULL;
> +}
> +
> +int bcm_vk_auto_load_all_images(struct bcm_vk *vk)
> +{
> +	int i, ret = -1;
> +	enum soc_idx idx;
> +	struct device *dev = &vk->pdev->dev;
> +	uint32_t curr_type;
> +	const char *curr_name;
> +
> +	idx = get_soc_idx(vk);
> +	if (idx == VK_IDX_INVALID)
> +		goto auto_load_all_exit;
> +
> +	/* log a message to know the relative loading order */
> +	dev_info(dev, "Load All for device %d\n", vk->misc_devid);

No need to be noise if all is going well, a driver should be quiet only
if something goes wrong, then print out a message.  No one wants to see
this :)

dev_dbg()?

> +
> +	for (i = 0; i < NUM_BOOT_STAGES; i++) {
> +		curr_type = image_tab[idx][i].image_type;
> +		if (bcm_vk_next_boot_image(vk) == curr_type) {
> +			curr_name = get_load_fw_name(vk, &image_tab[idx][i]);
> +			if (!curr_name) {
> +				dev_err(dev, "No suitable firmware exists for type %d",
> +					curr_type);
> +				ret = -ENOENT;
> +				goto auto_load_all_exit;
> +			}
> +			ret = bcm_vk_load_image_by_type(vk, curr_type,
> +							curr_name);
> +			dev_info(dev, "Auto load %s, ret %d\n",
> +				 curr_name, ret);

Same here.

dev_dbg()?

> +
> +			if (ret) {
> +				dev_err(dev, "Error loading default %s\n",
> +					curr_name);
> +				goto auto_load_all_exit;
> +			}
> +		}
> +	}
> +
> +auto_load_all_exit:
> +	return ret;
> +}
> +
> +static int bcm_vk_trigger_autoload(struct bcm_vk *vk)
> +{
> +	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0)
> +		return -EPERM;
> +
> +	set_bit(BCM_VK_WQ_DWNLD_AUTO, vk->wq_offload);
> +	queue_work(vk->wq_thread, &vk->wq_work);
> +
> +	return 0;
> +}
> +
> +static long bcm_vk_load_image(struct bcm_vk *vk,
> +			      const struct vk_image __user *arg)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	const char *image_name;
> +	struct vk_image image;
> +	uint32_t next_loadable;
> +	enum soc_idx idx;
> +	int image_idx;
> +	int ret = -EPERM;
> +
> +	if (copy_from_user(&image, arg, sizeof(image)))
> +		return -EACCES;
> +
> +	if ((image.type != VK_IMAGE_TYPE_BOOT1) &&
> +	    (image.type != VK_IMAGE_TYPE_BOOT2)) {
> +		dev_err(dev, "invalid image.type %u\n", image.type);
> +		return ret;
> +	}
> +
> +	next_loadable = bcm_vk_next_boot_image(vk);
> +	if (next_loadable != image.type) {
> +		dev_err(dev, "Next expected image %u, Loading %u\n",
> +			next_loadable, image.type);
> +		return ret;
> +	}
> +
> +	/*
> +	 * if something is pending download already.  This could only happen
> +	 * for now when the driver is being loaded, or if someone has issued
> +	 * another download command in another shell.
> +	 */
> +	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0) {
> +		dev_err(dev, "Download operation already pending.\n");
> +		return ret;
> +	}
> +
> +	image_name = image.filename;
> +	if (image_name[0] == '\0') {
> +		/* Use default image name if NULL */
> +		idx = get_soc_idx(vk);
> +		if (idx == VK_IDX_INVALID)
> +			goto err_idx;
> +
> +		/* Image idx starts with boot1 */
> +		image_idx = image.type - VK_IMAGE_TYPE_BOOT1;
> +		image_name = get_load_fw_name(vk, &image_tab[idx][image_idx]);
> +		if (!image_name) {
> +			dev_err(dev, "No suitable image found for type %d",
> +				image.type);
> +			ret = -ENOENT;
> +			goto err_idx;
> +		}
> +	} else {
> +		/* Ensure filename is NULL terminated */
> +		image.filename[sizeof(image.filename) - 1] = '\0';
> +	}
> +	ret = bcm_vk_load_image_by_type(vk, image.type, image_name);
> +	dev_info(dev, "Load %s, ret %d\n", image_name, ret);

dev_dbg()?

> +err_idx:
> +	clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
> +
> +	return ret;
> +}
> +
> +static int bcm_vk_reset_successful(struct bcm_vk *vk)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	uint32_t fw_status, reset_reason;
> +	int ret = -EAGAIN;
> +
> +	/*
> +	 * Reset could be triggered when the card in several state:
> +	 *   i)   in bootROM
> +	 *   ii)  after boot1
> +	 *   iii) boot2 running
> +	 *
> +	 * i) & ii) - no status bits will be updated.  If vkboot1
> +	 * runs automatically after reset, it  will update the reason
> +	 * to be unknown reason
> +	 * iii) - reboot reason match + deinit done.
> +	 */
> +	fw_status = vkread32(vk, BAR_0, VK_BAR_FWSTS);
> +	/* immediate exit if interface goes down */
> +	if (BCM_VK_INTF_IS_DOWN(fw_status)) {
> +		dev_err(dev, "PCIe Intf Down!\n");
> +		goto reset_exit;
> +	}
> +
> +	reset_reason = (fw_status & VK_FWSTS_RESET_REASON_MASK);
> +	if ((reset_reason == VK_FWSTS_RESET_MBOX_DB) ||
> +	    (reset_reason == VK_FWSTS_RESET_UNKNOWN))
> +		ret = 0;
> +
> +	/*
> +	 * if some of the deinit bits are set, but done
> +	 * bit is not, this is a failure if triggered while boot2 is running
> +	 */
> +	if ((fw_status & VK_FWSTS_DEINIT_TRIGGERED) &&
> +	    !(fw_status & VK_FWSTS_RESET_DONE))
> +		ret = -EAGAIN;
> +
> +reset_exit:
> +	dev_dbg(dev, "FW status = 0x%x ret %d\n", fw_status, ret);
> +
> +	return ret;
> +}
> +
> +static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
> +{
> +	struct device *dev = &vk->pdev->dev;
> +	struct vk_reset reset;
> +	int ret = 0;
> +	uint32_t ramdump_reset;
> +	int special_reset;
> +
> +	if (copy_from_user(&reset, arg, sizeof(struct vk_reset)))
> +		return -EFAULT;
> +

No validation of user data here?  Not nice...


> +	/* check if any download is in-progress, if so return error */
> +	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0) {
> +		dev_err(dev, "Download operation pending - skip reset.\n");
> +		return -EPERM;
> +	}
> +
> +	ramdump_reset = vk->peer_alert.flags & ERR_LOG_RAMDUMP;
> +	dev_info(dev, "Issue Reset %s\n",
> +		 ramdump_reset ? "in ramdump mode" : "");
> +
> +	/*
> +	 * The following is the sequence of reset:
> +	 * - send card level graceful shut down
> +	 * - wait enough time for VK to handle its business, stopping DMA etc
> +	 * - kill host apps
> +	 * - Trigger interrupt with DB
> +	 */
> +	bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_GRACEFUL, 0, 0);
> +
> +	spin_lock(&vk->ctx_lock);
> +	if (!vk->reset_pid) {
> +		vk->reset_pid = task_pid_nr(current);
> +	} else {
> +		dev_err(dev, "Reset already launched by process pid %d\n",
> +			vk->reset_pid);
> +		ret = -EACCES;
> +	}
> +	spin_unlock(&vk->ctx_lock);
> +	if (ret)
> +		goto err_exit;
> +
> +	bcm_vk_blk_drv_access(vk);
> +	special_reset = bcm_vk_trigger_reset(vk);
> +
> +	/*
> +	 * Wait enough time for card os to deinit
> +	 * and populate the reset reason.
> +	 */
> +	msleep(BCM_VK_DEINIT_TIME_MS);
> +
> +	if (special_reset) {
> +		/* if it is special ramdump reset, return the type to user */
> +		reset.arg2 = special_reset;
> +		if (copy_to_user(arg, &reset, sizeof(reset)))
> +			ret = -EFAULT;
> +	} else {
> +		ret = bcm_vk_reset_successful(vk);
> +	}
> +
> +err_exit:
> +	clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
> +	return ret;
> +}
> +
> +static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct bcm_vk_ctx *ctx = file->private_data;
> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
> +	unsigned long pg_size;
> +
> +	/* only BAR2 is mmap possible, which is bar num 4 due to 64bit */
> +#define VK_MMAPABLE_BAR 4
> +
> +	pg_size = ((pci_resource_len(vk->pdev, VK_MMAPABLE_BAR) - 1)
> +		    >> PAGE_SHIFT) + 1;
> +	if (vma->vm_pgoff + vma_pages(vma) > pg_size)
> +		return -EINVAL;
> +
> +	vma->vm_pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
> +			  >> PAGE_SHIFT);
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +				  vma->vm_end - vma->vm_start,
> +				  vma->vm_page_prot);
> +}
> +
> +static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	long ret = -EINVAL;
> +	struct bcm_vk_ctx *ctx = file->private_data;
> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
> +	void __user *argp = (void __user *)arg;
> +
> +	dev_dbg(&vk->pdev->dev,
> +		"ioctl, cmd=0x%02x, arg=0x%02lx\n",
> +		cmd, arg);
> +
> +	mutex_lock(&vk->mutex);
> +
> +	switch (cmd) {
> +	case VK_IOCTL_LOAD_IMAGE:
> +		ret = bcm_vk_load_image(vk, argp);
> +		break;
> +
> +	case VK_IOCTL_RESET:
> +		ret = bcm_vk_reset(vk, argp);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&vk->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations bcm_vk_fops = {
> +	.owner = THIS_MODULE,
> +	.open = bcm_vk_open,
> +	.read = bcm_vk_read,
> +	.write = bcm_vk_write,
> +	.poll = bcm_vk_poll,
> +	.release = bcm_vk_release,
> +	.mmap = bcm_vk_mmap,
> +	.unlocked_ioctl = bcm_vk_ioctl,
> +};
> +
> +static int bcm_vk_on_panic(struct notifier_block *nb,
> +			   unsigned long e, void *p)
> +{
> +	struct bcm_vk *vk = container_of(nb, struct bcm_vk, panic_nb);
> +
> +	bcm_to_v_reset_doorbell(vk, VK_BAR0_RESET_DB_HARD);
> +
> +	return 0;
> +}
> +
> +static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	int err;
> +	int i;
> +	int id;
> +	int irq;
> +	char name[20];
> +	struct bcm_vk *vk;
> +	struct device *dev = &pdev->dev;
> +	struct miscdevice *misc_device;
> +	uint32_t boot_status;
> +
> +	/* allocate vk structure which is tied to kref for freeing */
> +	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
> +	if (!vk)
> +		return -ENOMEM;
> +
> +	kref_init(&vk->kref);

What does this kref manage?  You have a char device, and a pci device,
which one is "controlling the lifespan" of this structure?

> +	if (nr_ib_sgl_blk > BCM_VK_IB_SGL_BLK_MAX) {
> +		dev_warn(dev, "Inband SGL blk %d limited to max %d\n",
> +			 nr_ib_sgl_blk, BCM_VK_IB_SGL_BLK_MAX);
> +		nr_ib_sgl_blk = BCM_VK_IB_SGL_BLK_MAX;
> +	}
> +	vk->ib_sgl_size = nr_ib_sgl_blk * VK_MSGQ_BLK_SIZE;
> +	vk->pdev = pdev;

No reference counting of this?  Brave...

> +	mutex_init(&vk->mutex);
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "Cannot enable PCI device\n");
> +		return err;
> +	}
> +
> +	err = pci_request_regions(pdev, DRV_MODULE_NAME);
> +	if (err) {
> +		dev_err(dev, "Cannot obtain PCI resources\n");
> +		goto err_disable_pdev;
> +	}
> +
> +	/* make sure DMA is good */
> +	err = dma_set_mask_and_coherent(&pdev->dev,
> +					DMA_BIT_MASK(BCM_VK_DMA_BITS));
> +	if (err) {
> +		dev_err(dev, "failed to set DMA mask\n");
> +		goto err_disable_pdev;
> +	}
> +
> +	/* The tdma is a scratch area for some DMA testings. */
> +	if (nr_scratch_pages) {
> +		vk->tdma_vaddr = dma_alloc_coherent
> +					(dev,
> +					 nr_scratch_pages * PAGE_SIZE,
> +					 &vk->tdma_addr, GFP_KERNEL);
> +		if (!vk->tdma_vaddr) {
> +			err = -ENOMEM;
> +			goto err_disable_pdev;
> +		}
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, vk);
> +
> +	irq = pci_alloc_irq_vectors(pdev,
> +				    1,
> +				    VK_MSIX_IRQ_MAX,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +
> +	if (irq < VK_MSIX_IRQ_MIN_REQ) {
> +		dev_err(dev, "failed to get min %d MSIX interrupts, irq(%d)\n",
> +			VK_MSIX_IRQ_MIN_REQ, irq);
> +		err = (irq >= 0) ? -EINVAL : irq;
> +		goto err_disable_pdev;
> +	}
> +
> +	dev_info(dev, "Number of IRQs %d allocated - requested(%d).\n",
> +		 irq, VK_MSIX_IRQ_MAX);

Again, please be quiet.  Same for all dev_info() calls...

> +
> +	for (i = 0; i < MAX_BAR; i++) {
> +		/* multiple by 2 for 64 bit BAR mapping */
> +		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
> +		if (!vk->bar[i]) {
> +			dev_err(dev, "failed to remap BAR%d\n", i);
> +			goto err_iounmap;
> +		}
> +	}
> +
> +	for (vk->num_irqs = 0;
> +	     vk->num_irqs < VK_MSIX_MSGQ_MAX;
> +	     vk->num_irqs++) {
> +		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
> +				       bcm_vk_msgq_irqhandler,
> +				       IRQF_SHARED, DRV_MODULE_NAME, vk);
> +		if (err) {
> +			dev_err(dev, "failed to request msgq IRQ %d for MSIX %d\n",
> +				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
> +			goto err_irq;
> +		}
> +	}
> +	/* one irq for notification from VK */
> +	err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
> +			       bcm_vk_notf_irqhandler,
> +			       IRQF_SHARED, DRV_MODULE_NAME, vk);
> +	if (err) {
> +		dev_err(dev, "failed to request notf IRQ %d for MSIX %d\n",
> +			pdev->irq + vk->num_irqs, vk->num_irqs + 1);
> +		goto err_irq;
> +	}
> +	vk->num_irqs++;
> +
> +	for (i = 0;
> +	     (i < VK_MSIX_TTY_MAX) && (vk->num_irqs < irq);
> +	     i++, vk->num_irqs++) {
> +		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
> +				       bcm_vk_tty_irqhandler,
> +				       IRQF_SHARED, DRV_MODULE_NAME, vk);
> +		if (err) {
> +			dev_err(dev, "failed request tty IRQ %d for MSIX %d\n",
> +				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
> +			goto err_irq;
> +		}
> +		vk->tty[i].irq_enabled = true;
> +	}
> +
> +	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);

No locking needed?  I can't remember, sorry, this might be ok...

> +	if (id < 0) {
> +		err = id;
> +		dev_err(dev, "unable to get id\n");
> +		goto err_irq;
> +	}
> +
> +	vk->misc_devid = id;
> +	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
> +	misc_device = &vk->miscdev;
> +	misc_device->minor = MISC_DYNAMIC_MINOR;
> +	misc_device->name = kstrdup(name, GFP_KERNEL);
> +	if (!misc_device->name) {
> +		err = -ENOMEM;
> +		goto err_ida_remove;
> +	}
> +	misc_device->fops = &bcm_vk_fops,
> +
> +	err = misc_register(misc_device);
> +	if (err) {
> +		dev_err(dev, "failed to register device\n");
> +		goto err_kfree_name;
> +	}
> +
> +	err = bcm_vk_msg_init(vk);
> +	if (err) {
> +		dev_err(dev, "failed to init msg queue info\n");
> +		goto err_misc_deregister;
> +	}
> +
> +	/* sync other info */
> +	bcm_vk_sync_card_info(vk);
> +
> +	/* register for panic notifier */
> +	vk->panic_nb.notifier_call = bcm_vk_on_panic;
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &vk->panic_nb);
> +
> +	snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
> +	err = bcm_vk_tty_init(vk, name);
> +	if (err)
> +		goto err_unregister_panic_notifier;
> +
> +	/*
> +	 * lets trigger an auto download.  We don't want to do it serially here
> +	 * because at probing time, it is not supposed to block for a long time.
> +	 */
> +	boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
> +	if (auto_load) {
> +		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
> +			if (bcm_vk_trigger_autoload(vk))
> +				goto err_bcm_vk_tty_exit;
> +		} else {
> +			dev_info(dev,
> +				 "Auto-load skipped - BROM not in proper state (0x%x)\n",
> +				 boot_status);

dev_err()?  What can someone do about this?  If nothing, make it
dev_dbg() please.

> +		}
> +	}
> +
> +	/* enable hb */
> +	bcm_vk_hb_init(vk);
> +
> +	dev_info(dev, "BCM-VK:%u created, 0x%p\n", id, vk);

Again, {shh}, good code runs quiet...


> +
> +	return 0;
> +
> +err_bcm_vk_tty_exit:
> +	bcm_vk_tty_exit(vk);
> +
> +err_unregister_panic_notifier:
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &vk->panic_nb);
> +
> +err_misc_deregister:
> +	misc_deregister(misc_device);
> +
> +err_kfree_name:
> +	kfree(misc_device->name);
> +	misc_device->name = NULL;
> +
> +err_ida_remove:
> +	ida_simple_remove(&bcm_vk_ida, id);
> +
> +err_irq:
> +	for (i = 0; i < vk->num_irqs; i++)
> +		devm_free_irq(dev, pci_irq_vector(pdev, i), vk);
> +
> +	pci_disable_msix(pdev);
> +	pci_disable_msi(pdev);
> +
> +err_iounmap:
> +	for (i = 0; i < MAX_BAR; i++) {
> +		if (vk->bar[i])
> +			pci_iounmap(pdev, vk->bar[i]);
> +	}
> +	pci_release_regions(pdev);
> +
> +err_disable_pdev:
> +	pci_free_irq_vectors(pdev);
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}
> +
> +void bcm_vk_release_data(struct kref *kref)
> +{
> +	struct bcm_vk *vk = container_of(kref, struct bcm_vk, kref);
> +
> +	/* use raw print, as dev is gone */
> +	pr_info("BCM-VK:%d release data 0x%p\n", vk->misc_devid, vk);

Don't be noisy, this is debugging code, right?

> +	kfree(vk);
> +}
> +
> +static void bcm_vk_remove(struct pci_dev *pdev)
> +{
> +	int i;
> +	struct bcm_vk *vk = pci_get_drvdata(pdev);
> +	struct miscdevice *misc_device = &vk->miscdev;
> +
> +	bcm_vk_hb_deinit(vk);
> +
> +	/*
> +	 * Trigger a reset to card and wait enough time for UCODE to rerun,
> +	 * which re-initialize the card into its default state.
> +	 * This ensures when driver is re-enumerated it will start from
> +	 * a completely clean state.
> +	 */
> +	bcm_vk_trigger_reset(vk);
> +	usleep_range(BCM_VK_UCODE_BOOT_US, BCM_VK_UCODE_BOOT_MAX_US);
> +
> +	/* unregister panic notifier */
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &vk->panic_nb);
> +
> +	bcm_vk_msg_remove(vk);
> +	bcm_vk_tty_exit(vk);
> +
> +	if (vk->tdma_vaddr)
> +		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
> +				  vk->tdma_vaddr, vk->tdma_addr);
> +
> +	/* remove if name is set which means misc dev registered */
> +	if (misc_device->name) {
> +		misc_deregister(misc_device);
> +		kfree(misc_device->name);
> +		ida_simple_remove(&bcm_vk_ida, vk->misc_devid);
> +	}
> +	for (i = 0; i < vk->num_irqs; i++)
> +		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
> +
> +	pci_disable_msix(pdev);
> +	pci_disable_msi(pdev);
> +
> +	cancel_work_sync(&vk->wq_work);
> +	destroy_workqueue(vk->wq_thread);
> +	cancel_work_sync(&vk->tty_wq_work);
> +	destroy_workqueue(vk->tty_wq_thread);
> +
> +	for (i = 0; i < MAX_BAR; i++) {
> +		if (vk->bar[i])
> +			pci_iounmap(pdev, vk->bar[i]);
> +	}
> +
> +	dev_info(&pdev->dev, "BCM-VK:%d released\n", vk->misc_devid);
> +
> +	pci_release_regions(pdev);
> +	pci_free_irq_vectors(pdev);
> +	pci_disable_device(pdev);
> +
> +	kref_put(&vk->kref, bcm_vk_release_data);
> +}
> +
> +static void bcm_vk_shutdown(struct pci_dev *pdev)
> +{
> +	struct bcm_vk *vk = pci_get_drvdata(pdev);
> +	uint32_t reg, boot_stat;
> +
> +	reg = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
> +	boot_stat = reg & BOOT_STATE_MASK;
> +
> +	if (boot_stat == BOOT1_RUNNING) {
> +		/* simply trigger a reset interrupt to park it */
> +		bcm_vk_trigger_reset(vk);
> +	} else if (boot_stat == BROM_NOT_RUN) {
> +		int err;
> +		uint16_t lnksta;
> +
> +		/*
> +		 * The boot status only reflects boot condition since last reset
> +		 * As ucode will run only once to configure pcie, if multiple
> +		 * resets happen, we lost track if ucode has run or not.
> +		 * Here, read the current link speed and use that to
> +		 * sync up the bootstatus properly so that on reboot-back-up,
> +		 * it has the proper state to start with autoload
> +		 */
> +		err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		if (!err &&
> +		    (lnksta & PCI_EXP_LNKSTA_CLS) != PCI_EXP_LNKSTA_CLS_2_5GB) {
> +			reg |= BROM_STATUS_COMPLETE;
> +			vkwrite32(vk, reg, BAR_0, BAR_BOOT_STATUS);
> +		}
> +	}
> +}
> +
> +static const struct pci_device_id bcm_vk_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
> +
> +static struct pci_driver pci_driver = {
> +	.name     = DRV_MODULE_NAME,
> +	.id_table = bcm_vk_ids,
> +	.probe    = bcm_vk_probe,
> +	.remove   = bcm_vk_remove,
> +	.shutdown = bcm_vk_shutdown,
> +};
> +module_pci_driver(pci_driver);
> +
> +MODULE_DESCRIPTION("Broadcom VK Host Driver");
> +MODULE_AUTHOR("Scott Branden <scott.branden@broadcom.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION("1.0");
> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
> new file mode 100644
> index 000000000000..02ae35d42653
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
> @@ -0,0 +1,1523 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/hash.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/sizes.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer.h>
> +
> +#include "bcm_vk.h"
> +#include "bcm_vk_msg.h"
> +#include "bcm_vk_sg.h"
> +
> +/* functions to manipulate the transport id in msg block */
> +#define BCM_VK_MSG_Q_SHIFT	 4
> +#define BCM_VK_MSG_Q_MASK	 0xF
> +#define BCM_VK_MSG_ID_MASK	 0xFFF
> +
> +#define BCM_VK_DMA_DRAIN_MAX_MS	  2000
> +
> +/* number x q_size will be the max number of msg processed per loop */
> +#define BCM_VK_MSG_PROC_MAX_LOOP 2
> +
> +/* module parameter */
> +static bool hb_mon = true;
> +module_param(hb_mon, bool, 0444);
> +MODULE_PARM_DESC(hb_mon, "Monitoring heartbeat continuously.\n");
> +static int batch_log = 1;
> +module_param(batch_log, int, 0444);
> +MODULE_PARM_DESC(batch_log, "Max num of logs per batch operation.\n");
> +
> +static bool hb_mon_is_on(void)
> +{
> +	return hb_mon;
> +}
> +
> +static uint32_t get_q_num(const struct vk_msg_blk *msg)
> +{
> +	return (msg->trans_id & BCM_VK_MSG_Q_MASK);
> +}
> +
> +static void set_q_num(struct vk_msg_blk *msg, uint32_t val)
> +{
> +	msg->trans_id = (msg->trans_id & ~BCM_VK_MSG_Q_MASK) | val;
> +}
> +
> +static uint32_t get_msg_id(const struct vk_msg_blk *msg)
> +{
> +	return ((msg->trans_id >> BCM_VK_MSG_Q_SHIFT) & BCM_VK_MSG_ID_MASK);
> +}
> +
> +static void set_msg_id(struct vk_msg_blk *msg, uint32_t val)
> +{
> +	msg->trans_id = (val << BCM_VK_MSG_Q_SHIFT) | get_q_num(msg);
> +}
> +
> +static uint32_t msgq_inc(const struct bcm_vk_sync_qinfo *qinfo,
> +			 uint32_t idx,
> +			 uint32_t inc)
> +{
> +	return ((idx + inc) & qinfo->q_mask);
> +}
> +
> +static
> +struct vk_msg_blk __iomem *msgq_blk_addr(const struct bcm_vk_sync_qinfo *qinfo,
> +					 uint32_t idx)
> +{
> +	return qinfo->q_start + (VK_MSGQ_BLK_SIZE * idx);
> +}
> +
> +static uint32_t msgq_occupied(const struct bcm_vk_msgq __iomem *msgq,
> +			      const struct bcm_vk_sync_qinfo *qinfo)
> +{
> +	uint32_t wr_idx, rd_idx;
> +
> +	wr_idx = readl_relaxed(&msgq->wr_idx);
> +	rd_idx = readl_relaxed(&msgq->rd_idx);
> +
> +	return ((wr_idx - rd_idx) & qinfo->q_mask);
> +}
> +
> +static
> +uint32_t msgq_avail_space(const struct bcm_vk_msgq __iomem *msgq,
> +			  const struct bcm_vk_sync_qinfo *qinfo)
> +{
> +	return (qinfo->q_size - msgq_occupied(msgq, qinfo) - 1);
> +}
> +
> +#if defined(CONFIG_BCM_VK_QSTATS)
> +
> +/* Use default value of 20000 rd/wr per update */
> +#if !defined(BCM_VK_QSTATS_ACC_CNT)
> +#define BCM_VK_QSTATS_ACC_CNT 20000
> +#endif
> +
> +static void bcm_vk_update_qstats(struct bcm_vk *vk,
> +				 const char *tag,
> +				 struct bcm_vk_qstats *qstats,
> +				 uint32_t occupancy)
> +{
> +	struct bcm_vk_qs_cnts *qcnts = &qstats->qcnts;
> +
> +	if (occupancy > qcnts->max_occ) {
> +		qcnts->max_occ = occupancy;
> +		if (occupancy > qcnts->max_abs)
> +			qcnts->max_abs = occupancy;
> +	}
> +
> +	qcnts->acc_sum += occupancy;
> +	if (++qcnts->cnt >= BCM_VK_QSTATS_ACC_CNT) {
> +		/* log average and clear counters */
> +		dev_info(&vk->pdev->dev,
> +			 "%s[%d]: Max: [%3d/%3d] Acc %d num %d, Aver %d\n",
> +			 tag, qstats->q_num,
> +			 qcnts->max_occ, qcnts->max_abs,
> +			 qcnts->acc_sum,
> +			 qcnts->cnt,
> +			 qcnts->acc_sum / qcnts->cnt);

again, quiet...

> +
> +		qcnts->cnt = 0;
> +		qcnts->max_occ = 0;
> +		qcnts->acc_sum = 0;
> +	}
> +}
> +#endif
> +
> +/* number of retries when enqueue message fails before returning EAGAIN */
> +#define BCM_VK_H2VK_ENQ_RETRY 10
> +#define BCM_VK_H2VK_ENQ_RETRY_DELAY_MS 50
> +
> +bool bcm_vk_drv_access_ok(struct bcm_vk *vk)
> +{
> +	return (!!atomic_read(&vk->msgq_inited));

So, what happens _right_ after this call?  Does it become "not ok"?  Are
you sure you can do this?

And why an atomic variable, why do you need that?

> +}
> +
> +void bcm_vk_set_host_alert(struct bcm_vk *vk, uint32_t bit_mask)
> +{
> +	struct bcm_vk_alert *alert = &vk->host_alert;
> +	unsigned long flags;
> +
> +	/* use irqsave version as this maybe called inside timer interrupt */
> +	spin_lock_irqsave(&vk->host_alert_lock, flags);
> +	alert->notfs |= bit_mask;
> +	spin_unlock_irqrestore(&vk->host_alert_lock, flags);
> +
> +	if (test_and_set_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload) == 0)
> +		queue_work(vk->wq_thread, &vk->wq_work);
> +}
> +
> +#if defined(BCM_VK_LEGACY_API)
> +/*
> + * legacy does not support heartbeat mechanism
> + */
> +void bcm_vk_hb_init(struct bcm_vk *vk)
> +{
> +	dev_info(&vk->pdev->dev, "skipped\n");

I'll just let you fix the rest of these...

I've given up now, this is a huge driver and I haven't even found the
tty portions, which I have no idea why it is needed.

So can you please split this up into reviewable parts?  Like add the pci
device handling, then the firmware, then the misc device, and then
whatever else is remaining (tty?)

It should be easy to review, as it is, this isn't at all...

thanks,

greg k-h

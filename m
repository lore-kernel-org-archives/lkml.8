Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B269DC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2765C206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IFgaahn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBUS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:29:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53676 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgBUS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:29:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so2776063wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oiAHMNswk4nIEgIslTXPq3J7NpQ52OJxwEqPYX/ddD4=;
        b=IFgaahn4rWJ4iQJJIO6N798jNIGqZdRDsahykAFsnWPK7WbMiFQ5NkPNaEGluzSIK3
         9qvDOzl6MMWYjN/vyeKXPlnudDeX9h9FIWca5Y+P0ZP2ygbgTcqdyaGvZirisClTeGbF
         PgNYuloiJr7ZkvUH07pp0XxWJqSWy55ysPzgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oiAHMNswk4nIEgIslTXPq3J7NpQ52OJxwEqPYX/ddD4=;
        b=REl/L+UO9vi2n7buUeXImRpFSqBRRHLrhwxGPs7TjDzWI1q0JPbM8ddGFCAf9SuBZD
         REn0ZA4lngufg5eAlvIuZKyq67PoSexE0LsQze0t/pJWyFruvIRhZpQiwsfWU0BXgnI4
         1pCw9mt45YA1m+y2tFc3a+U19W/D9uNie0LaYLfumZbeaOzF6hSOmoAL0xGSmgAJasN4
         Ak66ygzdMrkNXzf3h56femxlNt0ZFi+PxccpTSM3k8Fr1kTnjepy/pwGp0rfQXjsZX2d
         7WZ/qfE8tdI888ejdGETujODDkZY9x30QSp+OTTOExF+ASrvmJvrLv2upc4RwRWCLskv
         8FJQ==
X-Gm-Message-State: APjAAAXRaYCRF29sO2QUFiPsVFnM/t3jxcdv4q8EEBeQJEhe82LwJ0KG
        3b1OGrXz5SdmZ+nmpFuzJiEZkQ==
X-Google-Smtp-Source: APXvYqyRZGUiIEhnYY8RcMmnBL7YDHF/M0VUZQejx+4TzlWwN0Sr58h8rRS0E1kuu5dSepZ1mBEo/g==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr5134662wmf.63.1582309770854;
        Fri, 21 Feb 2020 10:29:30 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b13sm5310200wrq.48.2020.02.21.10.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:29:29 -0800 (PST)
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220104321.GX7838@kadam>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <51b84f03-9f37-7fd3-5456-3cd00e7f596d@broadcom.com>
Date:   Fri, 21 Feb 2020 10:29:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220104321.GX7838@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-20 2:43 a.m., Dan Carpenter wrote:
> I'm not sure what git tree you're building on top of.  This patchset
> doesn't apply to linux-next which is the only thing I tested...
I am building against master branch.
Will look at differences with linux-next once comments addressed.
> On Wed, Feb 19, 2020 at 04:48:24PM -0800, Scott Branden wrote:
>> Add Broadcom VK driver offload engine.
>> This driver interfaces to the VK PCIe offload engine to perform
>> should offload functions as video transcoding on multiple streams
>> in parallel.  VK device is booted from files loaded using
>> request_firmware_into_buf mechanism.  After booted card status is updated
>> and messages can then be sent to the card.
>> Such messages contain scatter gather list of addresses
>> to pull data from the host to perform operations on.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
>> Signed-off-by: James Hu <james.hu@broadcom.com>
>> ---
>>   drivers/misc/Kconfig             |    1 +
>>   drivers/misc/Makefile            |    1 +
>>   drivers/misc/bcm-vk/Kconfig      |   42 +
>>   drivers/misc/bcm-vk/Makefile     |   11 +
>>   drivers/misc/bcm-vk/bcm_vk.h     |  357 ++++++++
>>   drivers/misc/bcm-vk/bcm_vk_dev.c | 1197 ++++++++++++++++++++++++++
>>   drivers/misc/bcm-vk/bcm_vk_msg.c | 1359 ++++++++++++++++++++++++++++++
>>   drivers/misc/bcm-vk/bcm_vk_msg.h |  210 +++++
>>   drivers/misc/bcm-vk/bcm_vk_sg.c  |  273 ++++++
>>   drivers/misc/bcm-vk/bcm_vk_sg.h  |   60 ++
>>   drivers/misc/bcm-vk/bcm_vk_tty.c |  327 +++++++
>>   11 files changed, 3838 insertions(+)
>>   create mode 100644 drivers/misc/bcm-vk/Kconfig
>>   create mode 100644 drivers/misc/bcm-vk/Makefile
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
>>   create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 7f0d48f406e3..39c74ed6a846 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -478,6 +478,7 @@ source "drivers/misc/genwqe/Kconfig"
>>   source "drivers/misc/echo/Kconfig"
>>   source "drivers/misc/cxl/Kconfig"
>>   source "drivers/misc/ocxl/Kconfig"
>> +source "drivers/misc/bcm-vk/Kconfig"
>>   source "drivers/misc/cardreader/Kconfig"
>>   source "drivers/misc/habanalabs/Kconfig"
>>   endmenu
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index c1860d35dc7e..d9a3b2791560 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
>>   obj-$(CONFIG_CXL_BASE)		+= cxl/
>>   obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>>   obj-$(CONFIG_OCXL)		+= ocxl/
>> +obj-$(CONFIG_BCM_VK)		+= bcm-vk/
>>   obj-y				+= cardreader/
>>   obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>>   obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
>> new file mode 100644
>> index 000000000000..c75dfb89a38d
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/Kconfig
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Broadcom VK device
>> +#
>> +config BCM_VK
>> +	tristate "Support for Broadcom VK Accelerators"
>> +	depends on PCI_MSI
>> +	default m
>> +	help
>> +	  Select this option to enable support for Broadcom
>> +	  VK Accelerators.  VK is used for performing
>> +	  specific video offload processing.  This driver enables
>> +	  userspace programs to access these accelerators via /dev/bcm-vk.N
>> +	  devices.
>> +
>> +	  If unsure, say N.
>> +
>> +if BCM_VK
>> +
>> +config BCM_VK_H2VK_VERIFY_AND_RETRY
>> +	bool "Host To VK Verifiy Data and Retry"
>> +	help
>> +	  Turn on to verify the data passed down to VK is good,
>> +	  and if not, do a retry until it succeeds.
>> +	  This is a debug/workaround on FPGA PCIe timing issues
>> +	  but may be found useful for debugging other PCIe hardware issues.
>> +	  Small performance loss by enabling this debug config.
>> +	  For properly operating PCIe hardware no need to enable this.
>> +
>> +	  If unsure, say N.
>> +
>> +config BCM_VK_QSTATS
>> +	bool "VK Queue Statistics"
>> +	help
>> +	  Turn on to enable Queue Statistics.
>> +	  These are useful for debugging purposes.
>> +	  Some performance loss by enabling this debug config.
>> +	  For properly operating PCIe hardware no need to enable this.
>> +
>> +	  If unsure, say N.
>> +
>> +endif
>> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
>> new file mode 100644
>> index 000000000000..05cb213ee826
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/Makefile
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for Broadcom VK driver
>> +#
>> +
>> +obj-$(CONFIG_BCM_VK) += bcm_vk.o
>> +bcm_vk-objs := \
>> +	bcm_vk_dev.o \
>> +	bcm_vk_msg.o \
>> +	bcm_vk_sg.o \
>> +	bcm_vk_tty.o
>> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
>> new file mode 100644
>> index 000000000000..203ca741bf88
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk.h
>> @@ -0,0 +1,357 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef BCM_VK_H
>> +#define BCM_VK_H
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/pci.h>
>> +#include <linux/irq.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mutex.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/tty.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/version.h>
>> +#include <uapi/linux/misc/bcm_vk.h>
>> +
>> +#include "bcm_vk_msg.h"
>> +
>> +#define DRV_MODULE_NAME		"bcm-vk"
>> +
>> +/*
>> + * Load Image is completed in two stages:
>> + *
>> + * 1) When the VK device boot-up, M7 CPU runs and executes the BootROM.
>> + * The Secure Boot Loader (SBL) as part of the BootROM will run
>> + * to open up ITCM for host to push BOOT1 image.
>> + * SBL will authenticate the image before jumping to BOOT1 image.
>> + *
>> + * 2) Because BOOT1 image is a secured image, we also called it the
>> + * Secure Boot Image (SBI). At second stage, SBI will initialize DDR
>> + * and wait for host to push BOOT2 image to DDR.
>> + * SBI will authenticate the image before jumping to BOOT2 image.
>> + *
>> + */
>> +/* Location of registers of interest in BAR0 */
>> +
>> +/* Request register for Secure Boot Loader (SBL) download */
>> +#define BAR_CODEPUSH_SBL		0x400
>> +/* Start of ITCM */
>> +#define CODEPUSH_BOOT1_ENTRY		0x00400000
>> +#define CODEPUSH_MASK		        0xFFFFF000
>> +#define CODEPUSH_BOOTSTART		BIT(0)
>> +
>> +/* Boot Status register */
>> +#define BAR_BOOT_STATUS			0x404
>> +
>> +#define SRAM_OPEN			BIT(16)
>> +#define DDR_OPEN			BIT(17)
>> +
>> +/* Firmware loader progress status definitions */
>> +#define FW_LOADER_ACK_SEND_MORE_DATA	BIT(18)
>> +#define FW_LOADER_ACK_IN_PROGRESS	BIT(19)
>> +#define FW_LOADER_ACK_RCVD_ALL_DATA	BIT(20)
>> +
>> +/* definitions for boot status register */
>> +#define BOOT_STATE_MASK			0xFFF3FFFF
>> +#define BROM_STATUS_NOT_RUN		0x2
>> +#define BROM_NOT_RUN			(SRAM_OPEN | BROM_STATUS_NOT_RUN)
>> +#define BROM_STATUS_COMPLETE		0x6
>> +#define BROM_RUNNING			(SRAM_OPEN | BROM_STATUS_COMPLETE)
>> +#define BOOT1_STATUS_COMPLETE		0x6
>> +#define BOOT1_RUNNING			(DDR_OPEN | BOOT1_STATUS_COMPLETE)
>> +#define BOOT2_STATUS_COMPLETE		0x6
>> +#define BOOT2_RUNNING			(FW_LOADER_ACK_RCVD_ALL_DATA | \
>> +					 BOOT2_STATUS_COMPLETE)
>> +
>> +/* Boot request for Secure Boot Image (SBI) */
>> +#define BAR_CODEPUSH_SBI		0x408
>> +/* 64M mapped to BAR2 */
>> +#define CODEPUSH_BOOT2_ENTRY		0x60000000
>> +
>> +#define BAR_CARD_STATUS			0x410
>> +/* CARD_STATUS definitions */
>> +#define CARD_STATUS_TTYVK0_READY	BIT(0)
>> +#define CARD_STATUS_TTYVK1_READY	BIT(1)
>> +
>> +#define BAR_METADATA_VERSION		0x440
>> +#define BAR_OS_UPTIME			0x444
>> +#define BAR_CHIP_ID			0x448
>> +
>> +#define BAR_CARD_TEMPERATURE		0x45C
>> +/* defines for all temperature sensor */
>> +#define BCM_VK_TEMP_FIELD_MASK		0xFF
>> +#define BCM_VK_CPU_TEMP_SHIFT		0
>> +#define BCM_VK_DDR0_TEMP_SHIFT		8
>> +#define BCM_VK_DDR1_TEMP_SHIFT		16
>> +
>> +#define BAR_CARD_VOLTAGE		0x460
>> +/* defines for voltage rail conversion */
>> +#define BCM_VK_VOLT_RAIL_MASK		0xFFFF
>> +#define BCM_VK_3P3_VOLT_REG_SHIFT	16
>> +
>> +#define BAR_CARD_ERR_LOG		0x464
>> +/* Error log register bit definition - register for error alerts */
>> +#define ERR_LOG_UECC			BIT(0)
>> +#define ERR_LOG_SSIM_BUSY		BIT(1)
>> +#define ERR_LOG_AFBC_BUSY		BIT(2)
>> +#define ERR_LOG_HIGH_TEMP_ERR		BIT(3)
>> +#define ERR_LOG_WDOG_TIMEOUT		BIT(4)
>> +#define ERR_LOG_SYS_FAULT		BIT(5)
>> +#define ERR_LOG_MEM_ALLOC_FAIL		BIT(8)
>> +#define ERR_LOG_LOW_TEMP_WARN		BIT(9)
>> +#define ERR_LOG_ECC			BIT(10)
>> +/* Alert bit definitions detectd on host */
>> +#define ERR_LOG_HOST_HB_FAIL		BIT(14)
>> +#define ERR_LOG_HOST_PCIE_DWN		BIT(15)
>> +
>> +#define BAR_CARD_ERR_MEM		0x468
>> +/* defines for mem err, all fields have same width */
>> +#define BCM_VK_MEM_ERR_FIELD_MASK	0xFF
>> +#define BCM_VK_ECC_MEM_ERR_SHIFT	0
>> +#define BCM_VK_UECC_MEM_ERR_SHIFT	8
>> +/* threshold of event occurrence and logs start to come out */
>> +#define BCM_VK_ECC_THRESHOLD		10
>> +#define BCM_VK_UECC_THRESHOLD		1
>> +
>> +#define BAR_CARD_PWR_AND_THRE		0x46C
>> +/* defines for power and temp threshold, all fields have same width */
>> +#define BCM_VK_PWR_AND_THRE_FIELD_MASK	0xFF
>> +#define BCM_VK_LOW_TEMP_THRE_SHIFT	0
>> +#define BCM_VK_HIGH_TEMP_THRE_SHIFT	8
>> +#define BCM_VK_PWR_STATE_SHIFT		16
>> +
>> +#define BAR_CARD_STATIC_INFO		0x470
>> +
>> +#define BAR_BOOTSRC_SELECT		0xC78
>> +/* BOOTSRC definitions */
>> +#define BOOTSRC_SOFT_ENABLE		BIT(14)
>> +
>> +/* Card OS Firmware version size */
>> +#define BAR_FIRMWARE_TAG_SIZE		50
>> +#define FIRMWARE_STATUS_PRE_INIT_DONE	0x1F
>> +
>> +/* VK MSG_ID defines */
>> +#define VK_MSG_ID_BITMAP_SIZE		4096
>> +#define VK_MSG_ID_BITMAP_MASK		(VK_MSG_ID_BITMAP_SIZE - 1)
>> +#define VK_MSG_ID_OVERFLOW		0xFFFF
>> +
>> +/* VK device supports a maximum of 3 bars */
>> +#define MAX_BAR	3
>> +
>> +/* default number of msg blk for inband SGL */
>> +#define BCM_VK_DEF_IB_SGL_BLK_LEN	 16
>> +#define BCM_VK_IB_SGL_BLK_MAX		 24
>> +
>> +enum pci_barno {
>> +	BAR_0 = 0,
>> +	BAR_1,
>> +	BAR_2
>> +};
>> +
>> +#define BCM_VK_NUM_TTY 2
>> +
>> +struct bcm_vk_tty {
>> +	struct tty_port port;
>> +	uint32_t to_offset;	/* bar offset to use */
>> +	uint32_t to_size;	/* to VK buffer size */
>> +	uint32_t wr;		/* write offset shadow */
>> +	uint32_t from_offset;	/* bar offset to use */
>> +	uint32_t from_size;	/* from VK buffer size */
>> +	uint32_t rd;		/* read offset shadow */
>> +};
>> +
>> +/* VK device max power state, supports 3, full, reduced and low */
>> +#define MAX_OPP 3
>> +#define MAX_CARD_INFO_TAG_SIZE 64
>> +
>> +struct bcm_vk_card_info {
>> +	uint32_t version;
>> +	char os_tag[MAX_CARD_INFO_TAG_SIZE];
>> +	char cmpt_tag[MAX_CARD_INFO_TAG_SIZE];
>> +	uint32_t cpu_freq_mhz;
>> +	uint32_t cpu_scale[MAX_OPP];
>> +	uint32_t ddr_freq_mhz;
>> +	uint32_t ddr_size_MB;
>> +	uint32_t video_core_freq_mhz;
>> +};
>> +
>> +/*
>> + * Control structure of logging messages from the card.  This
>> + * buffer is for logmsg that comes from vk
>> + */
>> +struct bcm_vk_peer_log {
>> +	uint32_t rd_idx;
>> +	uint32_t wr_idx;
>> +	uint32_t buf_size;
>> +	uint32_t mask;
>> +	char data[0];
>> +};
>> +/* max size per line of peer log */
>> +#define BCM_VK_PEER_LOG_LINE_MAX  256
>> +
>> +struct bcm_vk_hb_ctrl {
>> +	struct timer_list timer;
>> +	uint32_t last_uptime;
>> +	uint32_t lost_cnt;
>> +};
>> +
>> +struct bcm_vk_alert {
>> +	uint16_t flags;
>> +	uint16_t notfs;
>> +};
>> +
>> +/* some alert counters that the driver will keep track */
>> +struct bcm_vk_alert_cnts {
>> +	uint16_t ecc;
>> +	uint16_t uecc;
>> +};
>> +
>> +struct bcm_vk {
>> +	struct pci_dev *pdev;
>> +	void __iomem *bar[MAX_BAR];
>> +	int num_irqs;
>> +
>> +	struct bcm_vk_card_info card_info;
>> +
>> +	/* mutex to protect the ioctls */
>> +	struct mutex mutex;
>> +	struct miscdevice miscdev;
>> +	int misc_devid; /* dev id allocated */
>> +
>> +	struct tty_driver *tty_drv;
>> +	struct timer_list serial_timer;
>> +	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
>> +
>> +	/* Reference-counting to handle file operations */
>> +	struct kref kref;
>> +
>> +	spinlock_t msg_id_lock;
>> +	uint16_t msg_id;
>> +	DECLARE_BITMAP(bmap, VK_MSG_ID_BITMAP_SIZE);
>> +	spinlock_t ctx_lock;
>> +	struct bcm_vk_ctx ctx[VK_CMPT_CTX_MAX];
>> +	struct bcm_vk_ht_entry pid_ht[VK_PID_HT_SZ];
>> +	struct task_struct *reset_ppid; /* process that issue reset */
>> +
>> +	atomic_t msgq_inited; /* indicate if info has been synced with vk */
>> +	struct bcm_vk_msg_chan h2vk_msg_chan;
>> +	struct bcm_vk_msg_chan vk2h_msg_chan;
> These two names are almost the same except the letters are jumbled up.
> Please, figure out better names because the human mind sees them as
> exactly the same at first glance.
>
> https://www.mnn.com/lifestyle/arts-culture/stories/why-your-brain-can-read-jumbled-letters
>
>
>> +
>> +	struct workqueue_struct *wq_thread;
>> +	struct work_struct wq_work; /* work queue for deferred job */
>> +	unsigned long wq_offload[1]; /* various flags on wq requested */
>> +	void *tdma_vaddr; /* test dma segment virtual addr */
>> +	dma_addr_t tdma_addr; /* test dma segment bus addr */
>> +
>> +	struct notifier_block panic_nb;
>> +	uint32_t ib_sgl_size; /* size allocated for inband sgl insertion */
>> +
>> +	/* heart beat mechanism control structure */
>> +	struct bcm_vk_hb_ctrl hb_ctrl;
>> +	/* house-keeping variable of error logs */
>> +	spinlock_t host_alert_lock; /* protection to access host_alert struct */
>> +	struct bcm_vk_alert host_alert;
>> +	struct bcm_vk_alert peer_alert; /* bits set by the card */
>> +	struct bcm_vk_alert_cnts alert_cnts;
>> +
>> +	/* offset of the peer log control in BAR2 */
>> +	uint32_t peerlog_off;
>> +};
>> +
>> +/* wq offload work items bits definitions */
>> +enum bcm_vk_wq_offload_flags {
>> +	BCM_VK_WQ_DWNLD_PEND = 0,
>> +	BCM_VK_WQ_DWNLD_AUTO = 1,
>> +	BCM_VK_WQ_NOTF_PEND  = 2,
>> +};
>> +
>> +/* a macro to get an individual field with mask and shift */
>> +#define BCM_VK_EXTRACT_FIELD(_field, _reg, _mask, _shift) \
>> +		(_field = (((_reg) >> (_shift)) & (_mask)))
>> +
>> +/* structure that is used to faciliate displaying of register content */
>> +struct bcm_vk_entry {
>> +	const uint32_t mask;
>> +	const uint32_t exp_val;
>> +	const char *str;
>> +};
>> +
>> +/* alerts that could be generated from peer */
>> +#define BCM_VK_PEER_ERR_NUM 9
>> +extern struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM];
>> +/* alerts detected by the host */
>> +#define BCM_VK_HOST_ERR_NUM 2
>> +extern struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM];
>> +
>> +/*
>> + * check if PCIe interface is down on read.  Use it when it is
>> + * certain that _val should never be all ones.
>> + */
>> +#define BCM_VK_INTF_IS_DOWN(val) ((val) == 0xFFFFFFFF)
>> +
>> +static inline u32 vkread32(struct bcm_vk *vk,
>> +			   enum pci_barno bar,
>> +			   uint64_t offset)
>> +{
>> +	u32 value;
>> +
>> +	value = ioread32(vk->bar[bar] + offset);
>> +	return value;
>
> 	return ioread32(vk->bar[bar] + offset);
>
>> +}
>> +
>> +static inline void vkwrite32(struct bcm_vk *vk,
>> +			     u32 value,
>> +			     enum pci_barno bar,
>> +			     uint64_t offset)
>> +{
>> +	iowrite32(value, vk->bar[bar] + offset);
>> +}
>> +
>> +static inline u8 vkread8(struct bcm_vk *vk,
>> +			 enum pci_barno bar,
>> +			 uint64_t offset)
>> +{
>> +	u8 value;
>> +
>> +	value = ioread8(vk->bar[bar] + offset);
>> +	return value;
> 	return ioread8(vk->bar[bar] + offset);
>
>> +}
>> +
>> +static inline void vkwrite8(struct bcm_vk *vk,
>> +			    u8 value,
>> +			    enum pci_barno bar,
>> +			    uint64_t offset)
>> +{
>> +	iowrite8(value, vk->bar[bar] + offset);
>> +}
>> +
>> +int bcm_vk_open(struct inode *inode, struct file *p_file);
>> +ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
>> +		    loff_t *f_pos);
>> +ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
>> +		     size_t count, loff_t *f_pos);
>> +int bcm_vk_release(struct inode *inode, struct file *p_file);
>> +void bcm_vk_release_data(struct kref *kref);
>> +irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
>> +irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
>> +int bcm_vk_msg_init(struct bcm_vk *vk);
>> +void bcm_vk_msg_remove(struct bcm_vk *vk);
>> +int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync);
>> +bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk);
>> +void bcm_vk_blk_drv_access(struct bcm_vk *vk);
>> +int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, uint32_t shut_type, pid_t pid);
>> +void bcm_vk_trigger_reset(struct bcm_vk *vk);
>> +void bcm_h2vk_doorbell(struct bcm_vk *vk, uint32_t q_num, uint32_t db_val);
>> +int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
>> +int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
>> +void bcm_vk_tty_exit(struct bcm_vk *vk);
>> +void bcm_vk_hb_init(struct bcm_vk *vk);
>> +void bcm_vk_hb_deinit(struct bcm_vk *vk);
>> +void bcm_vk_handle_notf(struct bcm_vk *vk);
>> +bool bcm_vk_drv_access_ok(struct bcm_vk *vk);
>> +
>> +#endif
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
>> new file mode 100644
>> index 000000000000..d8f59e898ca8
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
>> @@ -0,0 +1,1197 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/firmware.h>
>> +#include <linux/fs.h>
>> +#include <linux/idr.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci_regs.h>
>> +#include <uapi/linux/misc/bcm_vk.h>
>> +
>> +#include "bcm_vk.h"
>> +
>> +#define PCI_DEVICE_ID_VALKYRIE	0x5E87
>> +#define PCI_DEVICE_ID_VIPER	0x5E88
>> +
>> +static DEFINE_IDA(bcm_vk_ida);
>> +
>> +struct load_image_tab {
>> +		const uint32_t image_type;
>> +		const char *image_name;
> Indented too far.
>
>> +};
>> +
>> +enum soc_idx {
>> +	VALKYRIE = 0,
>> +	VIPER
>> +};
>> +
>> +#define NUM_BOOT_STAGES 2
>> +const struct load_image_tab image_tab[][NUM_BOOT_STAGES] = {
>> +	[VALKYRIE] = {
>> +		{VK_IMAGE_TYPE_BOOT1, VK_BOOT1_DEF_VALKYRIE_FILENAME},
>> +		{VK_IMAGE_TYPE_BOOT2, VK_BOOT2_DEF_VALKYRIE_FILENAME}
>> +	},
>> +	[VIPER] = {
>> +		{VK_IMAGE_TYPE_BOOT1, VK_BOOT1_DEF_VIPER_FILENAME},
>> +		{VK_IMAGE_TYPE_BOOT2, VK_BOOT2_DEF_VIPER_FILENAME}
>> +	}
>> +};
>> +
>> +/* Location of memory base addresses of interest in BAR1 */
>> +/* Load Boot1 to start of ITCM */
>> +#define BAR1_CODEPUSH_BASE_BOOT1	0x100000
>> +
>> +/* Allow minimum 1s for Load Image timeout responses */
>> +#define LOAD_IMAGE_TIMEOUT_MS		(1 * MSEC_PER_SEC)
>> +
>> +/* Image startup timeouts */
>> +#define BOOT1_STARTUP_TIMEOUT_MS	(5 * MSEC_PER_SEC)
>> +#define BOOT2_STARTUP_TIMEOUT_MS	(10 * MSEC_PER_SEC)
>> +
>> +/* 1ms wait for checking the transfer complete status */
>> +#define TXFR_COMPLETE_TIMEOUT_MS	1
>> +
>> +/* MSIX usages */
>> +#define VK_MSIX_MSGQ_MAX		3
>> +#define VK_MSIX_NOTF_MAX		1
>> +#define VK_MSIX_IRQ_MAX			(VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX)
>> +
>> +/* Number of bits set in DMA mask*/
>> +#define BCM_VK_DMA_BITS			64
>> +
>> +/* deinit time for the card os after receiving doorbell */
>> +#define BCM_VK_DEINIT_TIME_MS		(2 * MSEC_PER_SEC)
>> +
>> +/*
>> + * module parameters
>> + */
>> +static bool auto_load = true;
>> +module_param(auto_load, bool, 0444);
>> +MODULE_PARM_DESC(auto_load,
>> +		 "Load images automatically at PCIe probe time.\n");
>> +static uint nr_scratch_pages = VK_BAR1_SCRATCH_DEF_NR_PAGES;
>> +module_param(nr_scratch_pages, uint, 0444);
>> +MODULE_PARM_DESC(nr_scratch_pages,
>> +		 "Number of pre allocated DMAable coherent pages.\n");
>> +static uint nr_ib_sgl_blk = BCM_VK_DEF_IB_SGL_BLK_LEN;
>> +module_param(nr_ib_sgl_blk, uint, 0444);
>> +MODULE_PARM_DESC(nr_ib_sgl_blk,
>> +		 "Number of in-band msg blks for short SGL.\n");
>> +
>> +/*
>> + * alerts that could be generated from peer
>> + */
>> +struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM] = {
>> +	{ERR_LOG_UECC, ERR_LOG_UECC, "uecc"},
>> +	{ERR_LOG_SSIM_BUSY, ERR_LOG_SSIM_BUSY, "ssim_busy"},
>> +	{ERR_LOG_AFBC_BUSY, ERR_LOG_AFBC_BUSY, "afbc_busy"},
>> +	{ERR_LOG_HIGH_TEMP_ERR, ERR_LOG_HIGH_TEMP_ERR, "high_temp"},
>> +	{ERR_LOG_WDOG_TIMEOUT, ERR_LOG_WDOG_TIMEOUT, "wdog_timeout"},
>> +	{ERR_LOG_SYS_FAULT, ERR_LOG_SYS_FAULT, "sys_fault"},
>> +	{ERR_LOG_MEM_ALLOC_FAIL, ERR_LOG_MEM_ALLOC_FAIL, "malloc_fail warn"},
>> +	{ERR_LOG_LOW_TEMP_WARN, ERR_LOG_LOW_TEMP_WARN, "low_temp warn"},
>> +	{ERR_LOG_ECC, ERR_LOG_ECC, "ecc"},
>> +};
>> +/* alerts detected by the host */
>> +struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM] = {
>> +	{ERR_LOG_HOST_PCIE_DWN, ERR_LOG_HOST_PCIE_DWN, "PCIe_down"},
>> +	{ERR_LOG_HOST_HB_FAIL, ERR_LOG_HOST_HB_FAIL, "hb_fail"},
>> +};
>> +
>> +irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id)
>> +{
>> +	struct bcm_vk *vk = dev_id;
>> +
>> +	if (!bcm_vk_drv_access_ok(vk)) {
>> +		dev_err(&vk->pdev->dev,
>> +			"Interrupt %d received when msgq not inited\n", irq);
>> +		goto skip_schedule_work;
>> +	}
>> +
>> +	/* if notification is not pending, set bit and schedule work */
>> +	if (test_and_set_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload) == 0)
>> +		queue_work(vk->wq_thread, &vk->wq_work);
>> +
>> +skip_schedule_work:
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void bcm_vk_log_notf(struct bcm_vk *vk,
>> +			    struct bcm_vk_alert *alert,
>> +			    struct bcm_vk_entry const *entry_tab,
>> +			    const uint32_t table_size)
>> +{
>> +	uint32_t i;
>> +	uint32_t masked_val, latched_val;
>> +	struct bcm_vk_entry const *entry;
>> +	uint32_t reg;
>> +	uint16_t ecc_mem_err, uecc_mem_err;
>> +	struct device *dev = &vk->pdev->dev;
>> +
>> +	for (i = 0; i < table_size; i++) {
>> +		entry = &entry_tab[i];
>> +		masked_val = entry->mask & alert->notfs;
>> +		latched_val = entry->mask & alert->flags;
>> +
>> +		if (masked_val == ERR_LOG_UECC) {
>> +			/*
>> +			 * if there is difference between stored cnt and it
>> +			 * is greater than threshold, log it.
>> +			 */
>> +			reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
>> +			BCM_VK_EXTRACT_FIELD(uecc_mem_err, reg,
>> +					     BCM_VK_MEM_ERR_FIELD_MASK,
>> +					     BCM_VK_UECC_MEM_ERR_SHIFT);
>> +			if ((uecc_mem_err != vk->alert_cnts.uecc) &&
>> +			    (uecc_mem_err >= BCM_VK_UECC_THRESHOLD))
>> +				dev_info(dev,
>> +					 "ALERT! %s.%d uecc RAISED - ErrCnt %d\n",
>> +					 DRV_MODULE_NAME, vk->misc_devid,
>> +					 uecc_mem_err);
>> +			vk->alert_cnts.uecc = uecc_mem_err;
>> +		} else if (masked_val == ERR_LOG_ECC) {
>> +			reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
>> +			BCM_VK_EXTRACT_FIELD(ecc_mem_err, reg,
>> +					     BCM_VK_MEM_ERR_FIELD_MASK,
>> +					     BCM_VK_ECC_MEM_ERR_SHIFT);
>> +			if ((ecc_mem_err != vk->alert_cnts.ecc) &&
>> +			    (ecc_mem_err >= BCM_VK_ECC_THRESHOLD))
>> +				dev_info(dev, "ALERT! %s.%d ecc RAISED - ErrCnt %d\n",
>> +					 DRV_MODULE_NAME, vk->misc_devid,
>> +					 ecc_mem_err);
>> +			vk->alert_cnts.ecc = ecc_mem_err;
>> +		} else if (masked_val != latched_val) {
>> +			/* print a log as info */
>> +			dev_info(dev, "ALERT! %s.%d %s %s\n",
>> +				 DRV_MODULE_NAME, vk->misc_devid, entry->str,
>> +				 masked_val ? "RAISED" : "CLEARED");
>> +		}
>> +	}
>> +}
>> +
>> +static void bcm_vk_dump_peer_log(struct bcm_vk *vk)
>> +{
>> +	struct bcm_vk_peer_log log, *p_ctl;
>> +	char loc_buf[BCM_VK_PEER_LOG_LINE_MAX];
>> +	int cnt;
>> +	struct device *dev = &vk->pdev->dev;
>> +	uint data_offset;
>> +
>> +	p_ctl = vk->bar[BAR_2] + vk->peerlog_off;
> Have you tried running Sparse on this driver?
>
>> +	log = *p_ctl;
>> +	/* do a rmb() to make sure log is updated */
>> +	rmb();
>> +
>> +	dev_dbg(dev, "Peer PANIC: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
>> +		log.buf_size, log.mask, log.rd_idx, log.wr_idx);
>> +
>> +	cnt = 0;
>> +	data_offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log);
>> +	while (log.rd_idx != log.wr_idx) {
>> +		loc_buf[cnt] = vkread8(vk, BAR_2, data_offset + log.rd_idx);
>> +
>> +		if ((loc_buf[cnt] == '\0') ||
>> +		    (cnt == (BCM_VK_PEER_LOG_LINE_MAX - 1))) {
>> +			dev_err(dev, "%s", loc_buf);
>> +			cnt = 0;
>> +		} else {
>> +			cnt++;
>> +		}
>> +		log.rd_idx = (log.rd_idx + 1) & log.mask;
>> +	}
>> +	/* update rd idx at the end */
>> +	vkwrite32(vk, log.rd_idx, BAR_2, vk->peerlog_off);
>> +}
>> +
>> +void bcm_vk_handle_notf(struct bcm_vk *vk)
>> +{
>> +	uint32_t reg;
>> +	struct bcm_vk_alert alert;
>> +	bool intf_down;
>> +	unsigned long flags;
>> +
>> +	/* handle peer alerts and then locally detected ones */
>> +	reg = vkread32(vk, BAR_0, BAR_CARD_ERR_LOG);
>> +	intf_down = BCM_VK_INTF_IS_DOWN(reg);
>> +	if (!intf_down) {
>> +		vk->peer_alert.notfs = reg;
>> +		bcm_vk_log_notf(vk, &vk->peer_alert, bcm_vk_peer_err,
>> +				ARRAY_SIZE(bcm_vk_peer_err));
>> +		vk->peer_alert.flags = vk->peer_alert.notfs;
>> +	} else {
>> +		/* turn off access */
>> +		bcm_vk_blk_drv_access(vk);
>> +	}
>> +
>> +	/* check and make copy of alert with lock and then free lock */
>> +	spin_lock_irqsave(&vk->host_alert_lock, flags);
>> +	if (intf_down)
>> +		vk->host_alert.notfs |= ERR_LOG_HOST_PCIE_DWN;
>> +
>> +	alert = vk->host_alert;
>> +	vk->host_alert.flags = vk->host_alert.notfs;
>> +	spin_unlock_irqrestore(&vk->host_alert_lock, flags);
>> +
>> +	/* call display with copy */
>> +	bcm_vk_log_notf(vk, &alert, bcm_vk_host_err,
>> +			ARRAY_SIZE(bcm_vk_host_err));
>> +
>> +	/*
>> +	 * If it is a sys fault or heartbeat timeout, we would like extract
>> +	 * log msg from the card so that we would know what is the last fault
>> +	 */
>> +	if ((!intf_down) &&
>> +	    ((vk->host_alert.flags & ERR_LOG_HOST_HB_FAIL) ||
>> +	     (vk->peer_alert.flags & ERR_LOG_SYS_FAULT)))
>> +		bcm_vk_dump_peer_log(vk);
>> +}
>> +
>> +static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
>> +			      uint64_t offset, u32 mask, u32 value,
>> +			      unsigned long timeout_ms)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
>> +	u32 rd_val;
>> +
>> +	do {
>> +		rd_val = vkread32(vk, bar, offset);
>> +		dev_dbg(dev, "BAR%d Offset=0x%llx: 0x%x\n",
>> +			bar, offset, rd_val);
>> +
>> +		if (time_after(jiffies, timeout))
>> +			return -ETIMEDOUT;
>> +
>> +		cpu_relax();
>> +		cond_resched();
>> +	} while ((rd_val & mask) != value);
>> +
>> +	return 0;
>> +}
>> +
>> +static void bcm_vk_get_card_info(struct bcm_vk *vk)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	uint32_t offset;
>> +	int i;
>> +	uint8_t *dst;
>> +	struct bcm_vk_card_info *info = &vk->card_info;
>> +
>> +	/* first read the offset from spare register */
>> +	offset = vkread32(vk, BAR_0, BAR_CARD_STATIC_INFO);
>> +	offset &= (pci_resource_len(vk->pdev, BAR_2 * 2) - 1);
>> +
>> +	/* based on the offset, read info to internal card info structure */
>> +	dst = (uint8_t *)info;
>> +	for (i = 0; i < sizeof(*info); i++)
>> +		*dst++ = vkread8(vk, BAR_2, offset++);
>> +
>> +#define CARD_INFO_LOG_FMT "version   : %x\n" \
>> +			  "os_tag    : %s\n" \
>> +			  "cmpt_tag  : %s\n" \
>> +			  "cpu_freq  : %d MHz\n" \
>> +			  "cpu_scale : %d full, %d lowest\n" \
>> +			  "ddr_freq  : %d MHz\n" \
>> +			  "ddr_size  : %d MB\n" \
>> +			  "video_freq: %d MHz\n"
>> +	dev_dbg(dev, CARD_INFO_LOG_FMT, info->version, info->os_tag,
>> +		info->cmpt_tag, info->cpu_freq_mhz, info->cpu_scale[0],
>> +		info->cpu_scale[MAX_OPP - 1], info->ddr_freq_mhz,
>> +		info->ddr_size_MB, info->video_core_freq_mhz);
>> +
>> +	/* get the peer log pointer, only need the offset */
>> +	vk->peerlog_off = offset;
>> +}
>> +
>> +static int bcm_vk_sync_card_info(struct bcm_vk *vk)
>> +{
>> +	uint32_t rdy_marker = vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
>> +
>> +	/* check for marker, but allow diags mode to skip sync */
>> +	if (!bcm_vk_msgq_marker_valid(vk))
>> +		return (rdy_marker == VK_BAR1_DIAG_RDY_MARKER ? 0 : -EINVAL);
>> +
>> +	/*
>> +	 * Write down scratch addr which is used for DMA. For
>> +	 * signed part, BAR1 is accessible only after boot2 has come
>> +	 * up
>> +	 */
>> +	if (vk->tdma_addr) {
>> +		vkwrite32(vk, vk->tdma_addr >> 32, BAR_1,
>> +			  VK_BAR1_SCRATCH_OFF_LO);
>> +		vkwrite32(vk, (uint32_t)vk->tdma_addr, BAR_1,
>> +			  VK_BAR1_SCRATCH_OFF_HI);
>> +		vkwrite32(vk, nr_scratch_pages * PAGE_SIZE, BAR_1,
>> +			  VK_BAR1_SCRATCH_SZ_ADDR);
>> +	}
>> +
>> +	/* get static card info, only need to read once */
>> +	bcm_vk_get_card_info(vk);
>> +
>> +	return 0;
>> +}
>> +
>> +void bcm_vk_blk_drv_access(struct bcm_vk *vk)
>> +{
>> +	int i;
>> +
>> +	/*
>> +	 * kill all the apps except for the process that is resetting.
>> +	 * If not called during reset, reset_ppid == NULL, and all will be
>> +	 * killed.
>> +	 */
>> +	spin_lock(&vk->ctx_lock);
>> +
>> +	/* set msgq_inited to 0 so that all rd/wr will be blocked */
>> +	atomic_set(&vk->msgq_inited, 0);
>> +
>> +	for (i = 0; i < VK_PID_HT_SZ; i++) {
>> +		struct bcm_vk_ctx *ctx;
>> +
>> +		list_for_each_entry(ctx, &vk->pid_ht[i].head, node) {
>> +			if (ctx->ppid != vk->reset_ppid) {
>> +				dev_dbg(&vk->pdev->dev,
>> +					"Send kill signal to pid %d\n",
>> +					task_pid_nr(ctx->ppid));
>> +				kill_pid(task_pid(ctx->ppid), SIGKILL, 1);
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&vk->ctx_lock);
>> +}
>> +
>> +static void bcm_vk_buf_notify(struct bcm_vk *vk, void *bufp,
>> +			      dma_addr_t host_buf_addr, uint32_t buf_size)
>> +{
>> +	/* update the dma address to the card */
>> +	vkwrite32(vk, host_buf_addr >> 32, BAR_1,
>> +		  VK_BAR1_DMA_BUF_OFF_HI);
>> +	vkwrite32(vk, (uint32_t)host_buf_addr, BAR_1,
>> +		  VK_BAR1_DMA_BUF_OFF_LO);
>> +	vkwrite32(vk, buf_size, BAR_1, VK_BAR1_DMA_BUF_SZ);
>> +}
>> +
>> +static int bcm_vk_load_image_by_type(struct bcm_vk *vk, u32 load_type,
>> +				     const char *filename)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	const struct firmware *fw;
>> +	void *bufp;
>> +	size_t max_buf;
>> +	int ret;
>> +	uint64_t offset_codepush;
>> +	u32 codepush;
>> +	u32 value;
>> +	dma_addr_t boot2_dma_addr;
>> +
>> +	if (load_type == VK_IMAGE_TYPE_BOOT1) {
>> +		/*
>> +		 * After POR, enable VK soft BOOTSRC so bootrom do not clear
>> +		 * the pushed image (the TCM memories).
>> +		 */
>> +		value = vkread32(vk, BAR_0, BAR_BOOTSRC_SELECT);
>> +		value |= BOOTSRC_SOFT_ENABLE;
>> +		vkwrite32(vk, value, BAR_0, BAR_BOOTSRC_SELECT);
>> +
>> +		codepush = CODEPUSH_BOOTSTART + CODEPUSH_BOOT1_ENTRY;
>> +		offset_codepush = BAR_CODEPUSH_SBL;
>> +
>> +		/* Write a 1 to request SRAM open bit */
>> +		vkwrite32(vk, CODEPUSH_BOOTSTART, BAR_0, offset_codepush);
>> +
>> +		/* Wait for VK to respond */
>> +		ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, SRAM_OPEN,
>> +				  SRAM_OPEN, LOAD_IMAGE_TIMEOUT_MS);
>> +		if (ret < 0) {
>> +			dev_err(dev, "boot1 timeout\n");
>> +			goto err_out;
>> +		}
>> +
>> +		bufp = vk->bar[BAR_1] + BAR1_CODEPUSH_BASE_BOOT1;
>> +		max_buf = SZ_256K;
>> +	} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
>> +		codepush = CODEPUSH_BOOT2_ENTRY;
>> +		offset_codepush = BAR_CODEPUSH_SBI;
>> +
>> +		/* Wait for VK to respond */
>> +		ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, DDR_OPEN,
>> +				  DDR_OPEN, LOAD_IMAGE_TIMEOUT_MS);
>> +		if (ret < 0) {
>> +			dev_err(dev, "boot2 timeout\n");
>> +			goto err_out;
>> +		}
>> +
>> +		max_buf = SZ_4M;
>> +		bufp = dma_alloc_coherent(dev,
>> +					  max_buf,
>> +					  &boot2_dma_addr, GFP_KERNEL);
>> +		if (!bufp) {
>> +			dev_err(dev, "Error allocating 0x%zx\n", max_buf);
>> +			ret = -ENOMEM;
>> +			goto err_out;
>> +		}
>> +
>> +		bcm_vk_buf_notify(vk, bufp, boot2_dma_addr, max_buf);
>> +	} else {
>> +		dev_err(dev, "Error invalid image type 0x%x\n", load_type);
>> +		ret = -EINVAL;
>> +		goto err_out;
>> +	}
>> +
>> +	ret = request_firmware_into_buf(&fw, filename, dev,
>> +					bufp, max_buf, 0,
>> +					KERNEL_PREAD_FLAG_PART);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d requesting firmware file: %s\n",
>> +			ret, filename);
>> +		goto err_out;
>> +	}
>> +	dev_dbg(dev, "size=0x%zx\n", fw->size);
>> +
>> +	dev_dbg(dev, "Signaling 0x%x to 0x%llx\n", codepush, offset_codepush);
>> +	vkwrite32(vk, codepush, BAR_0, offset_codepush);
>> +
>> +	if (load_type == VK_IMAGE_TYPE_BOOT1) {
>> +		/* wait until done */
>> +		ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
>> +				  BOOT1_RUNNING,
>> +				  BOOT1_RUNNING,
>> +				  BOOT1_STARTUP_TIMEOUT_MS);
>> +		if (ret) {
>> +			dev_err(dev,
>> +				"Timeout %ld ms waiting for boot1 to come up\n",
>> +				BOOT1_STARTUP_TIMEOUT_MS);
>> +			goto err_firmware_out;
>> +		}
>> +	} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
>> +		unsigned long timeout = jiffies + msecs_to_jiffies(
>> +					LOAD_IMAGE_TIMEOUT_MS);
>> +
>> +		/* To send more data to VK than max_buf allowed at a time */
>> +		do {
>> +			/*
>> +			 * Check for ack from card. when Ack is received,
>> +			 * it means all the data is received by card.
>> +			 * Exit the loop after ack is received.
>> +			 */
>> +			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
>> +					  FW_LOADER_ACK_RCVD_ALL_DATA,
>> +					  FW_LOADER_ACK_RCVD_ALL_DATA,
>> +					  TXFR_COMPLETE_TIMEOUT_MS);
>> +			if (ret == 0) {
>> +				dev_info(dev, "Exit boot2 download\n");
>> +				break;
>> +			}
>> +
>> +			/* exit the loop, if there is no response from card */
>> +			if (time_after(jiffies, timeout)) {
>> +				dev_err(dev, "Error. No reply from card\n");
>> +				ret = -ETIMEDOUT;
>> +				goto err_firmware_out;
>> +			}
>> +
>> +			/* Wait for VK to open BAR space to copy new data */
>> +			ret = bcm_vk_wait(vk, BAR_0, offset_codepush,
>> +					  codepush, 0,
>> +					  TXFR_COMPLETE_TIMEOUT_MS);
>> +			if (ret == 0) {
>> +				ret = request_firmware_into_buf(
>> +							&fw,
>> +							filename,
>> +							dev, bufp,
>> +							max_buf,
>> +							fw->size,
>> +							KERNEL_PREAD_FLAG_PART);
>> +				if (ret) {
>> +					dev_err(dev, "Error %d requesting firmware file: %s offset: 0x%zx\n",
>> +						ret, filename,
>> +						fw->size);
>> +					goto err_firmware_out;
>> +				}
>> +				dev_dbg(dev, "size=0x%zx\n", fw->size);
>> +				dev_dbg(dev, "Signaling 0x%x to 0x%llx\n",
>> +					codepush, offset_codepush);
>> +				vkwrite32(vk, codepush, BAR_0, offset_codepush);
>> +				/* reload timeout after every codepush */
>> +				timeout = jiffies + msecs_to_jiffies(
>> +					  LOAD_IMAGE_TIMEOUT_MS);
>> +			}
>> +		} while (1);
>> +
>> +		/* wait for fw status bits to indicate app ready */
>> +		ret = bcm_vk_wait(vk, BAR_0, VK_BAR_FWSTS,
>> +				  VK_FWSTS_READY,
>> +				  VK_FWSTS_READY,
>> +				  BOOT2_STARTUP_TIMEOUT_MS);
>> +		if (ret < 0) {
>> +			dev_err(dev, "Boot2 not ready - timeout\n");
>> +			goto err_firmware_out;
>> +		}
>> +
>> +		/*
>> +		 * Next, initialize Message Q if we are loading boot2.
>> +		 * Do a force sync
>> +		 */
>> +		ret = bcm_vk_sync_msgq(vk, true);
>> +		if (ret) {
>> +			dev_err(dev, "Boot2 Error reading comm msg Q info\n");
>> +			ret = -EIO;
>> +			goto err_firmware_out;
>> +		}
>> +
>> +		/* sync & channel other info */
>> +		ret = bcm_vk_sync_card_info(vk);
>> +		if (ret) {
>> +			dev_err(dev, "Syncing Card Info failure\n");
>> +			goto err_firmware_out;
>> +		}
>> +	}
>> +
>> +err_firmware_out:
>> +	release_firmware(fw);
>> +
>> +err_out:
>> +	if (load_type == VK_IMAGE_TYPE_BOOT2)
>> +		dma_free_coherent(dev, max_buf, bufp, boot2_dma_addr);
> bufp is uninitialized.  Never use the label name "err" or "out" because
> it's always wrong.  This is just a combination of the two.
>
>> +
>> +	return ret;
>> +}
>> +
>> +static u32 bcm_vk_next_boot_image(struct bcm_vk *vk)
>> +{
>> +	uint32_t boot_status;
>> +	uint32_t fw_status;
>> +	u32 load_type = 0;  /* default for unknown */
>> +
>> +	boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
>> +	fw_status = vkread32(vk, BAR_0, VK_BAR_FWSTS);
>> +
>> +	if (!BCM_VK_INTF_IS_DOWN(boot_status) && (boot_status & SRAM_OPEN))
>> +		load_type = VK_IMAGE_TYPE_BOOT1;
>> +	else if (boot_status == BOOT1_RUNNING)
>> +		load_type = VK_IMAGE_TYPE_BOOT2;
>> +
>> +	/*
>> +	 * TO_FIX: For now, like to know what value we get everytime
>> +	 *         for debugging.
>> +	 */
>> +	dev_info(&vk->pdev->dev,
>> +		 "boot-status value for next image: 0x%x : fw-status 0x%x\n",
>> +		 boot_status, fw_status);
>> +
>> +	return load_type;
>> +}
>> +
>> +int bcm_vk_auto_load_all_images(struct bcm_vk *vk)
>> +{
>> +	int i, id, ret = -1;
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	uint32_t curr_type;
>> +	const char *curr_name;
>> +
>> +	switch (pdev->device) {
>> +	case PCI_DEVICE_ID_VALKYRIE:
>> +		id = VALKYRIE;
>> +		break;
>> +
>> +	case PCI_DEVICE_ID_VIPER:
>> +		id = VIPER;
>> +		break;
>> +
>> +	default:
>> +		dev_err(dev, "no images for 0x%x\n", pdev->device);
>> +		goto bcm_vk_auto_load_all_exit;
>> +	}
>> +
>> +	/* log a message to know the relative loading order */
>> +	dev_info(dev, "Load All for device %d\n", vk->misc_devid);
>> +
>> +	for (i = 0; i < NUM_BOOT_STAGES; i++) {
>> +		curr_type = image_tab[id][i].image_type;
>> +		if (bcm_vk_next_boot_image(vk) == curr_type) {
>> +			curr_name = image_tab[id][i].image_name;
>> +			ret = bcm_vk_load_image_by_type(vk, curr_type,
>> +							curr_name);
>> +			dev_info(dev, "Auto load %s, ret %d\n",
>> +				 curr_name, ret);
>> +
>> +			if (ret) {
>> +				dev_err(dev, "Error loading default %s\n",
>> +					curr_name);
>> +				goto bcm_vk_auto_load_all_exit;
>> +			}
>> +		}
>> +	}
>> +
>> +bcm_vk_auto_load_all_exit:
>> +	return ret;
>> +}
>> +
>> +static int bcm_vk_trigger_autoload(struct bcm_vk *vk)
>> +{
>> +	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0)
>> +		return -EPERM;
>> +
>> +	set_bit(BCM_VK_WQ_DWNLD_AUTO, vk->wq_offload);
>> +	queue_work(vk->wq_thread, &vk->wq_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static long bcm_vk_load_image(struct bcm_vk *vk, struct vk_image *arg)
>> +{
>> +	int ret;
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct vk_image image;
>> +	u32 next_loadable;
>> +
>> +	if (copy_from_user(&image, arg, sizeof(image))) {
>> +		ret = -EACCES;
>> +		goto bcm_vk_load_image_exit;
>> +	}
>> +
>> +	/* first check if fw is at the right state for the download */
> What does this comment mean?  Just delete it.  The code is clear on
> its own.
>
>> +	next_loadable = bcm_vk_next_boot_image(vk);
>> +	if (next_loadable != image.type) {
>> +		dev_err(dev, "Next expected image %u, Loading %u\n",
>> +			next_loadable, image.type);
>> +		ret = -EPERM;
>> +		goto bcm_vk_load_image_exit;
>> +	}
>> +
>> +	/*
>> +	 * if something is pending download already.  This could only happen
>> +	 * for now when the driver is being loaded, or if someone has issued
>> +	 * another download command in another shell.
>> +	 */
>> +	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0) {
>> +		dev_err(dev, "Download operation already pending.\n");
>> +		return -EPERM;
> Woohoo for the direct return!  Just make this function use direct
> returns everywhere and delete all the do nothing returns.
>
>> +	}
>> +
>> +	ret = bcm_vk_load_image_by_type(vk, image.type, image.filename);
>> +	clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
>> +
>> +bcm_vk_load_image_exit:
>> +	return ret;
>> +}
>> +
>> +static long bcm_vk_access_bar(struct bcm_vk *vk, struct vk_access *arg)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct vk_access access;
>> +	long ret = -EINVAL;
>> +	u32 value;
>> +	long i;
>> +	long num;
>> +
>> +	if (copy_from_user(&access, arg, sizeof(struct vk_access))) {
>> +		ret = -EACCES;
> 		return -EFAULT;
>
>> +		goto err_out;
>> +	}
>> +
>> +	/* do some range checking in the barno and offset */
>> +	if (access.barno >= MAX_BAR) {
>> +		dev_err(dev, "invalid bar no %d\n", access.barno);
>> +		goto err_out;
>> +	} else if ((access.offset + access.len) >
>> +		   pci_resource_len(vk->pdev, access.barno * 2)) {
> There is an arithmatic overlfow.  Also len should be a multiple of
> sizeof(u32).
>
> 	} else if (access.len % sizeof(u32) ||
> 		   access.offset + access.len < access.offset ||
> 		   access.offset + access.len > pci_resource_len(vk->pdev,
> 							access.barno * 2)) {
>
>
>> +		dev_err(dev, "invalid bar offset 0x%llx, len 0x%x\n",
>> +			access.offset, access.len);
>> +		goto err_out;
>> +	}
>> +
>> +	if (access.type == VK_ACCESS_READ) {
>> +		dev_dbg(dev, "read barno:%d offset:0x%llx len:0x%x\n",
>> +			access.barno, access.offset, access.len);
>> +		num = access.len / sizeof(u32);
>> +		for (i = 0; i < num; i++) {
>> +			value = vkread32(vk, access.barno,
>> +					 access.offset + (i * sizeof(u32)));
>> +			ret = put_user(value, access.data + i);
>> +			if (ret)
>> +				goto err_out;
>> +
>> +			dev_dbg(dev, "0x%x\n", value);
>> +		}
>> +	} else if (access.type == VK_ACCESS_WRITE) {
>> +		dev_dbg(dev, "write barno:%d offset:0x%llx len:0x%x\n",
>> +			access.barno, access.offset, access.len);
>> +		num = access.len / sizeof(u32);
>> +		for (i = 0; i < num; i++) {
>> +			ret = get_user(value, access.data + i);
>> +			if (ret)
>> +				goto err_out;
>> +
>> +			vkwrite32(vk, value, access.barno,
>> +				  access.offset + (i * sizeof(u32)));
>> +			dev_dbg(dev, "0x%x\n", value);
>> +		}
>> +	} else {
>> +		dev_dbg(dev, "invalid access type %d\n", access.type);
>> +	}
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static int bcm_vk_reset_successful(struct bcm_vk *vk)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	u32 fw_status, reset_reason;
>> +	int ret = -EAGAIN;
>> +
>> +	/*
>> +	 * Reset could be triggered when the card in several state:
>> +	 *   i)   in bootROM
>> +	 *   ii)  after boot1
>> +	 *   iii) boot2 running
>> +	 *
>> +	 * i) & ii) - no status bits will be updated.  If vkboot1
>> +	 * runs automatically after reset, it  will update the reason
>> +	 * to be unknown reason
>> +	 * iii) - reboot reason match + deinit done.
>> +	 */
>> +	fw_status = vkread32(vk, BAR_0, VK_BAR_FWSTS);
>> +	/* immediate exit if interface goes down */
>> +	if (BCM_VK_INTF_IS_DOWN(fw_status)) {
>> +		dev_err(dev, "PCIe Intf Down!\n");
>> +		goto bcm_vk_reset_exit;
>> +	}
>> +
>> +	/* initial check on reset reason */
> This comment doesn't add anything.
>
>> +	reset_reason = (fw_status & VK_FWSTS_RESET_REASON_MASK);
>> +	if ((reset_reason == VK_FWSTS_RESET_MBOX_DB)
>> +	     || (reset_reason == VK_FWSTS_RESET_UNKNOWN))
>> +		ret = 0;
> Please use checkpatch.pl --strict.
>
> 	if ((reset_reason == VK_FWSTS_RESET_MBOX_DB) ||
> 	    (reset_reason == VK_FWSTS_RESET_UNKNOWN))
> 		ret = 0;
>
>
>> +
>> +	/*
>> +	 * if some of the deinit bits are set, but done
>> +	 * bit is not, this is a failure if triggered while boot2 is running
>> +	 */
>> +	if ((fw_status & VK_FWSTS_DEINIT_TRIGGERED)
>> +	    && !(fw_status & VK_FWSTS_RESET_DONE))
>> +		ret = -EAGAIN;
>> +
>> +bcm_vk_reset_exit:
>> +	dev_dbg(dev, "FW status = 0x%x ret %d\n", fw_status, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset *arg)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct vk_reset reset;
>> +	int ret = 0;
>> +
>> +	if (copy_from_user(&reset, arg, sizeof(struct vk_reset))) {
>> +		ret = -EACCES;
>
> 		return -EFAULT;
>
>> +		goto err_out;
>> +	}
>> +	dev_info(dev, "Issue Reset\n");
>> +
>> +	/*
>> +	 * The following is the sequence of reset:
>> +	 * - send card level graceful shut down
>> +	 * - wait enough time for VK to handle its business, stopping DMA etc
>> +	 * - kill host apps
>> +	 * - Trigger interrupt with DB
>> +	 */
>> +	bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_GRACEFUL, 0);
>> +
>> +	spin_lock(&vk->ctx_lock);
>> +	if (!vk->reset_ppid) {
>> +		vk->reset_ppid = current;
>> +	} else {
>> +		dev_err(dev, "Reset already launched by process pid %d\n",
>> +			task_pid_nr(vk->reset_ppid));
>> +		ret = -EACCES;
>> +	}
>> +	spin_unlock(&vk->ctx_lock);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	bcm_vk_blk_drv_access(vk);
>> +	bcm_vk_trigger_reset(vk);
>> +
>> +	/*
>> +	 * Wait enough time for card os to deinit
>> +	 * and populate the reset reason.
>> +	 */
>> +	msleep(BCM_VK_DEINIT_TIME_MS);
>> +
>> +	ret = bcm_vk_reset_successful(vk);
>> +
>> +err_out:
>> +	return ret;
>> +}
>> +
>> +static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct bcm_vk_ctx *ctx = file->private_data;
>> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
>> +	unsigned long pg_size;
>> +
>> +	/* only BAR2 is mmap possible, which is bar num 4 due to 64bit */
>> +#define VK_MMAPABLE_BAR 4
>> +
>> +	pg_size = ((pci_resource_len(vk->pdev, VK_MMAPABLE_BAR) - 1)
>> +		    >> PAGE_SHIFT) + 1;
>> +	if (vma->vm_pgoff + vma_pages(vma) > pg_size)
>> +		return -EINVAL;
>> +
>> +	vma->vm_pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
>> +			  >> PAGE_SHIFT);
>> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +
>> +	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>> +				  vma->vm_end - vma->vm_start,
>> +				  vma->vm_page_prot);
>> +}
>> +
>> +static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>> +{
>> +	long ret = -EINVAL;
>> +	struct bcm_vk_ctx *ctx = file->private_data;
>> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
>> +	void __user *argp = (void __user *)arg;
>> +
>> +	dev_dbg(&vk->pdev->dev,
>> +		"ioctl, cmd=0x%02x, arg=0x%02lx\n",
>> +		cmd, arg);
>> +
>> +	mutex_lock(&vk->mutex);
>> +
>> +	switch (cmd) {
>> +	case VK_IOCTL_LOAD_IMAGE:
>> +		ret = bcm_vk_load_image(vk, argp);
>> +		break;
>> +
>> +	case VK_IOCTL_ACCESS_BAR:
>> +		ret = bcm_vk_access_bar(vk, argp);
>> +		break;
>> +
>> +	case VK_IOCTL_RESET:
>> +		ret = bcm_vk_reset(vk, argp);
>> +		break;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	mutex_unlock(&vk->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations bcm_vk_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = bcm_vk_open,
>> +	.read = bcm_vk_read,
>> +	.write = bcm_vk_write,
>> +	.release = bcm_vk_release,
>> +	.mmap = bcm_vk_mmap,
>> +	.unlocked_ioctl = bcm_vk_ioctl,
>> +};
>> +
>> +static int bcm_vk_on_panic(struct notifier_block *nb,
>> +			   unsigned long e, void *p)
>> +{
>> +	struct bcm_vk *vk = container_of(nb, struct bcm_vk, panic_nb);
>> +
>> +	bcm_h2vk_doorbell(vk, VK_BAR0_RESET_DB_NUM, VK_BAR0_RESET_DB_HARD);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +	int err;
>> +	int i;
>> +	int id;
>> +	int irq;
>> +	char name[20];
>> +	struct bcm_vk *vk;
>> +	struct device *dev = &pdev->dev;
>> +	struct miscdevice *misc_device;
>> +	uint32_t boot_status;
>> +
>> +	/* allocate vk structure which is tied to kref for freeing */
>> +	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
>> +	if (!vk)
>> +		return -ENOMEM;
>> +
>> +	kref_init(&vk->kref);
>> +	if (nr_ib_sgl_blk > BCM_VK_IB_SGL_BLK_MAX) {
>> +		dev_warn(dev, "Inband SGL blk %d limited to max %d\n",
>> +			 nr_ib_sgl_blk, BCM_VK_IB_SGL_BLK_MAX);
>> +		nr_ib_sgl_blk = BCM_VK_IB_SGL_BLK_MAX;
>> +	}
>> +	vk->ib_sgl_size = nr_ib_sgl_blk * VK_MSGQ_BLK_SIZE;
>> +	vk->pdev = pdev;
>> +	mutex_init(&vk->mutex);
>> +
>> +	err = pci_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(dev, "Cannot enable PCI device\n");
>> +		return err;
>> +	}
>> +
>> +	err = pci_request_regions(pdev, DRV_MODULE_NAME);
>> +	if (err) {
>> +		dev_err(dev, "Cannot obtain PCI resources\n");
>> +		goto err_disable_pdev;
>> +	}
>> +
>> +	/* make sure DMA is good */
>> +	err = dma_set_mask_and_coherent(&pdev->dev,
>> +					DMA_BIT_MASK(BCM_VK_DMA_BITS));
>> +	if (err) {
>> +		dev_err(dev, "failed to set DMA mask\n");
>> +		goto err_disable_pdev;
>> +	}
>> +
>> +	/* The tdma is a scratch area for some DMA testings. */
>> +	if (nr_scratch_pages) {
>> +		vk->tdma_vaddr = dma_alloc_coherent(dev,
>> +					 nr_scratch_pages * PAGE_SIZE,
>> +					 &vk->tdma_addr, GFP_KERNEL);
>> +		if (!vk->tdma_vaddr) {
>> +			err = -ENOMEM;
>> +			goto err_disable_pdev;
>> +		}
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +	pci_set_drvdata(pdev, vk);
>> +
>> +	irq = pci_alloc_irq_vectors(pdev,
>> +				    1,
>> +				    VK_MSIX_IRQ_MAX,
>> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
>> +
>> +	if (irq < VK_MSIX_IRQ_MAX) {
>> +		dev_err(dev, "failed to get %d MSIX interrupts, ret(%d)\n",
>> +			VK_MSIX_IRQ_MAX, irq);
>> +		err = (irq >= 0) ? -EINVAL : irq;
>> +		goto err_disable_pdev;
>> +	}
>> +
>> +	dev_info(dev, "Number of IRQs %d allocated.\n", irq);
>> +
>> +	for (i = 0; i < MAX_BAR; i++) {
>> +		/* multiple by 2 for 64 bit BAR mapping */
>> +		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
>> +		if (!vk->bar[i]) {
>> +			dev_err(dev, "failed to remap BAR%d\n", i);
>> +			goto err_iounmap;
>> +		}
>> +	}
>> +
>> +	for (vk->num_irqs = 0;
>> +	     vk->num_irqs < VK_MSIX_MSGQ_MAX;
>> +	     vk->num_irqs++) {
>> +		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
>> +				       bcm_vk_msgq_irqhandler,
>> +				       IRQF_SHARED, DRV_MODULE_NAME, vk);
>> +		if (err) {
>> +			dev_err(dev, "failed to request msgq IRQ %d for MSIX %d\n",
>> +				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
>> +			goto err_irq;
>> +		}
>> +	}
>> +	/* one irq for notification from VK */
>> +	err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
>> +			       bcm_vk_notf_irqhandler,
>> +			       IRQF_SHARED, DRV_MODULE_NAME, vk);
>> +	if (err) {
>> +		dev_err(dev, "failed to request notf IRQ %d for MSIX %d\n",
>> +			pdev->irq + vk->num_irqs, vk->num_irqs + 1);
>> +		goto err_irq;
>> +	}
>> +	vk->num_irqs++;
>> +
>> +	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
>> +	if (id < 0) {
>> +		err = id;
>> +		dev_err(dev, "unable to get id\n");
>> +		goto err_irq;
>> +	}
>> +
>> +	vk->misc_devid = id;
>> +	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>> +	misc_device = &vk->miscdev;
>> +	misc_device->minor = MISC_DYNAMIC_MINOR;
>> +	misc_device->name = kstrdup(name, GFP_KERNEL);
>> +	if (!misc_device->name) {
>> +		err = -ENOMEM;
>> +		goto err_ida_remove;
>> +	}
>> +	misc_device->fops = &bcm_vk_fops,
>> +
>> +	err = misc_register(misc_device);
>> +	if (err) {
>> +		dev_err(dev, "failed to register device\n");
>> +		goto err_kfree_name;
>> +	}
>> +
>> +	err = bcm_vk_msg_init(vk);
>> +	if (err) {
>> +		dev_err(dev, "failed to init msg queue info\n");
>> +		goto err_misc_deregister;
>> +	}
>> +
>> +	/* sync other info */
>> +	bcm_vk_sync_card_info(vk);
>> +
>> +	/* register for panic notifier */
>> +	vk->panic_nb.notifier_call = bcm_vk_on_panic;
>> +	atomic_notifier_chain_register(&panic_notifier_list,
>> +				       &vk->panic_nb);
>> +
>> +	snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
>> +	err = bcm_vk_tty_init(vk, name);
>> +	if (err)
>> +		goto err_unregister_panic_notifier;
>> +
>> +	/*
>> +	 * lets trigger an auto download.  We don't want to do it serially here
>> +	 * because at probing time, it is not supposed to block for a long time.
>> +	 */
>> +	boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
>> +	if (auto_load) {
>> +		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
>> +			if (bcm_vk_trigger_autoload(vk))
>> +				goto err_bcm_vk_tty_exit;
>> +		} else {
>> +			dev_info(dev,
>> +				 "Auto-load skipped - BROM not in proper state (0x%x)\n",
>> +				 boot_status);
>> +		}
>> +	}
>> +
>> +	/* enable hb */
>> +	bcm_vk_hb_init(vk);
>> +
>> +	dev_info(dev, "BCM-VK:%u created, 0x%p\n", id, vk);
>> +
>> +	return 0;
>> +
>> +err_bcm_vk_tty_exit:
>> +	bcm_vk_tty_exit(vk);
>> +
>> +err_unregister_panic_notifier:
>> +	atomic_notifier_chain_unregister(&panic_notifier_list,
>> +					 &vk->panic_nb);
>> +
>> +err_misc_deregister:
>> +	misc_deregister(misc_device);
>> +
>> +err_kfree_name:
>> +	kfree(misc_device->name);
>> +	misc_device->name = NULL;
>> +
>> +err_ida_remove:
>> +	ida_simple_remove(&bcm_vk_ida, id);
>> +
>> +err_irq:
>> +	for (i = 0; i < vk->num_irqs; i++)
>> +		devm_free_irq(dev, pci_irq_vector(pdev, i), vk);
>> +
>> +	pci_disable_msix(pdev);
>> +	pci_disable_msi(pdev);
>> +
>> +err_iounmap:
>> +	for (i = 0; i < MAX_BAR; i++) {
>> +		if (vk->bar[i])
>> +			pci_iounmap(pdev, vk->bar[i]);
>> +	}
>> +	pci_release_regions(pdev);
>> +
>> +err_disable_pdev:
>> +	pci_disable_device(pdev);
>> +
>> +	return err;
>> +}
>> +
>> +void bcm_vk_release_data(struct kref *kref)
>> +{
>> +	struct bcm_vk *vk = container_of(kref, struct bcm_vk, kref);
>> +
>> +	/* use raw print, as dev is gone */
>> +	pr_info("BCM-VK:%d release data 0x%p\n", vk->misc_devid, vk);
>> +	kfree(vk);
>> +}
>> +
>> +static void bcm_vk_remove(struct pci_dev *pdev)
>> +{
>> +	int i;
>> +	struct bcm_vk *vk = pci_get_drvdata(pdev);
>> +	struct miscdevice *misc_device = &vk->miscdev;
>> +
>> +	bcm_vk_hb_deinit(vk);
>> +	bcm_vk_tty_exit(vk);
>> +
>> +	/* unregister panic notifier */
>> +	atomic_notifier_chain_unregister(&panic_notifier_list,
>> +				       &vk->panic_nb);
>> +
>> +	bcm_vk_msg_remove(vk);
>> +
>> +	if (vk->tdma_vaddr)
>> +		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
>> +				  vk->tdma_vaddr, vk->tdma_addr);
>> +
>> +	/* remove if name is set which means misc dev registered */
>> +	if (misc_device->name) {
>> +		misc_deregister(misc_device);
>> +		kfree(misc_device->name);
>> +		ida_simple_remove(&bcm_vk_ida, vk->misc_devid);
>> +	}
>> +	for (i = 0; i < vk->num_irqs; i++)
>> +		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
>> +
>> +	pci_disable_msix(pdev);
>> +	pci_disable_msi(pdev);
>> +
>> +	cancel_work_sync(&vk->wq_work);
>> +	destroy_workqueue(vk->wq_thread);
>> +
>> +	for (i = 0; i < MAX_BAR; i++) {
>> +		if (vk->bar[i])
>> +			pci_iounmap(pdev, vk->bar[i]);
>> +	}
>> +
>> +	dev_info(&pdev->dev, "BCM-VK:%d released\n", vk->misc_devid);
>> +
>> +	pci_release_regions(pdev);
>> +	pci_disable_device(pdev);
>> +
>> +	kref_put(&vk->kref, bcm_vk_release_data);
>> +}
>> +
>> +static const struct pci_device_id bcm_vk_ids[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
>> +
>> +static struct pci_driver pci_driver = {
>> +	.name     = DRV_MODULE_NAME,
>> +	.id_table = bcm_vk_ids,
>> +	.probe    = bcm_vk_probe,
>> +	.remove   = bcm_vk_remove,
>> +};
>> +module_pci_driver(pci_driver);
>> +
>> +MODULE_DESCRIPTION("Broadcom VK Host Driver");
>> +MODULE_AUTHOR("Scott Branden <scott.branden@broadcom.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_VERSION("1.0");
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
>> new file mode 100644
>> index 000000000000..651fba2149e2
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
>> @@ -0,0 +1,1359 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/hash.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/list.h>
>> +#include <linux/sizes.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/timer.h>
>> +
>> +#include "bcm_vk.h"
>> +#include "bcm_vk_msg.h"
>> +#include "bcm_vk_sg.h"
>> +
>> +#if defined(CONFIG_BCM_VK_H2VK_VERIFY_AND_RETRY)
>> +/*
>> + * Turn on the following to verify the data passed down to VK is good, and
>> + * if not, do retry.  This is a debug/workaround on FPGA PCIe timing issues
>> + * but may be found useful for debugging other PCIe hardware issues.
>> + */
>> +static void bcm_vk_h2vk_verify_idx(struct device *dev,
>> +				   const char *tag,
>> +				   volatile uint32_t *idx,
>> +				   uint32_t expected)
>> +{
>> +	unsigned int count = 0;
>> +
>> +	while (*idx != expected) {
>> +		count++;
>> +		dev_err(dev, "[%d] %s exp %d idx %d\n",
>> +			count, tag, expected, *idx);
>> +
>> +		/* write again */
>> +		*idx = expected;
>> +	}
>> +}
>> +
>> +static void bcm_vk_h2vk_verify_blk(struct device *dev,
>> +				   const struct vk_msg_blk *src,
>> +				   volatile struct vk_msg_blk *dst)
>> +
>> +{
>> +	struct vk_msg_blk rd_bck;
>> +	unsigned int count = 0;
>> +
>> +	rd_bck = *dst;
>> +	while (memcmp(&rd_bck, src, sizeof(rd_bck)) != 0) {
>> +		count++;
>> +		dev_err(dev,
>> +			"[%d]Src Blk: [0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x]\n",
>> +			count,
>> +			src->function_id,
>> +			src->size,
>> +			src->queue_id,
>> +			src->msg_id,
>> +			src->context_id,
>> +			src->args[0],
>> +			src->args[1]);
>> +		dev_err(dev,
>> +			"[%d]Rdb Blk: [0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x]\n",
>> +			count,
>> +			rd_bck.function_id,
>> +			rd_bck.size,
>> +			rd_bck.queue_id,
>> +			rd_bck.msg_id,
>> +			rd_bck.context_id,
>> +			rd_bck.args[0],
>> +			rd_bck.args[1]);
>> +
>> +		*dst = *src;
>> +		rd_bck = *dst;
>> +	}
>> +}
>> +#else
>> +static void bcm_vk_h2vk_verify_idx(struct device __always_unused *dev,
>> +				   const char __always_unused *tag,
>> +				   volatile uint32_t __always_unused *idx,
>> +				   uint32_t __always_unused expected)
>> +{
>> +}
>> +
>> +static void bcm_vk_h2vk_verify_blk
>> +		(struct device __always_unused *dev,
>> +		 const struct vk_msg_blk __always_unused *src,
>> +		 volatile struct vk_msg_blk __always_unused *dst)
>> +
>> +{
>> +}
>> +#endif
>> +
>> +#if defined(CONFIG_BCM_VK_QSTATS)
>> +
>> +/* Use default value of 20000 rd/wr per update */
>> +#if !defined(BCM_VK_QSTATS_ACC_CNT)
>> +#define BCM_VK_QSTATS_ACC_CNT 20000
>> +#endif
>> +
>> +void bcm_vk_update_qstats(struct bcm_vk *vk, const char *tag,
>> +			  struct bcm_vk_qstats *qstats, uint32_t occupancy)
>> +{
>> +	struct bcm_vk_qs_cnts *qcnts = &qstats->qcnts;
>> +
>> +	if (occupancy > qcnts->max_occ) {
>> +		qcnts->max_occ = occupancy;
>> +		if (occupancy > qcnts->max_abs)
>> +			qcnts->max_abs = occupancy;
>> +	}
>> +
>> +	qcnts->acc_sum += occupancy;
>> +	if (++qcnts->cnt >= BCM_VK_QSTATS_ACC_CNT) {
>> +		/* log average and clear counters */
>> +		dev_info(&vk->pdev->dev,
>> +			 "%s[%d]: Max: [%3d/%3d] Acc %d num %d, Aver %d\n",
>> +			 tag, qstats->q_num,
>> +			 qcnts->max_occ, qcnts->max_abs,
>> +			 qcnts->acc_sum,
>> +			 qcnts->cnt,
>> +			 qcnts->acc_sum / qcnts->cnt);
>> +
>> +		qcnts->cnt = 0;
>> +		qcnts->max_occ = 0;
>> +		qcnts->acc_sum = 0;
>> +	}
>> +}
>> +#endif
>> +
>> +/* number of retries when enqueue message fails before returning EAGAIN */
>> +#define BCM_VK_H2VK_ENQ_RETRY 10
>> +#define BCM_VK_H2VK_ENQ_RETRY_DELAY_MS 50
>> +
>> +bool bcm_vk_drv_access_ok(struct bcm_vk *vk)
>> +{
>> +	return (!!atomic_read(&vk->msgq_inited));
>> +}
>> +
>> +static void bcm_vk_set_host_alert(struct bcm_vk *vk, uint32_t bit_mask)
>> +{
>> +	struct bcm_vk_alert *alert = &vk->host_alert;
>> +	unsigned long flags;
>> +
>> +	/* use irqsave version as this maybe called inside timer interrupt */
>> +	spin_lock_irqsave(&vk->host_alert_lock, flags);
>> +	alert->notfs |= bit_mask;
>> +	spin_unlock_irqrestore(&vk->host_alert_lock, flags);
>> +
>> +	if (test_and_set_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload) == 0)
>> +		queue_work(vk->wq_thread, &vk->wq_work);
>> +}
>> +
>> +/*
>> + * Heartbeat related defines
>> + * The heartbeat from host is a last resort.  If stuck condition happens
>> + * on the card, firmware is supposed to detect it.  Therefore, the heartbeat
>> + * values used will be more relaxed on the driver, which need to be bigger
>> + * than the watchdog timeout on the card.
>> + */
>> +#define BCM_VK_HB_TIMER_S 3
>> +#define BCM_VK_HB_TIMER_VALUE (BCM_VK_HB_TIMER_S * HZ)
>> +#define BCM_VK_HB_LOST_MAX 4
>> +
>> +static void bcm_vk_hb_poll(struct timer_list *t)
>> +{
>> +	uint32_t uptime_s;
>> +	struct bcm_vk_hb_ctrl *hb = container_of(t, struct bcm_vk_hb_ctrl,
>> +						 timer);
>> +	struct bcm_vk *vk = container_of(hb, struct bcm_vk, hb_ctrl);
>> +
>> +	if (bcm_vk_drv_access_ok(vk)) {
>> +		/* read uptime from register and compare */
>> +		uptime_s = vkread32(vk, BAR_0, BAR_OS_UPTIME);
>> +
>> +		if (uptime_s == hb->last_uptime)
>> +			hb->lost_cnt++;
>> +
>> +		dev_dbg(&vk->pdev->dev, "Last uptime %d current %d, lost %d\n",
>> +			hb->last_uptime, uptime_s, hb->lost_cnt);
>> +
>> +		/*
>> +		 * if the interface goes down without any activity, a value
>> +		 * of 0xFFFFFFFF will be continuously read, and the detection
>> +		 * will be happened eventually.
>> +		 */
>> +		hb->last_uptime = uptime_s;
>> +	} else {
>> +		/* reset heart beat lost cnt */
>> +		hb->lost_cnt = 0;
>> +	}
>> +
>> +	/* next, check if heartbeat exceeds limit */
>> +	if (hb->lost_cnt > BCM_VK_HB_LOST_MAX) {
>> +		dev_err(&vk->pdev->dev, "Heartbeat Misses %d times, %d s!\n",
>> +			BCM_VK_HB_LOST_MAX,
>> +			BCM_VK_HB_LOST_MAX * BCM_VK_HB_TIMER_S);
>> +
>> +		bcm_vk_blk_drv_access(vk);
>> +		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_HB_FAIL);
>> +	}
>> +	/* re-arm timer */
>> +	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
>> +}
>> +
>> +void bcm_vk_hb_init(struct bcm_vk *vk)
>> +{
>> +	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
>> +
>> +	timer_setup(&hb->timer, bcm_vk_hb_poll, 0);
>> +	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
>> +}
>> +
>> +void bcm_vk_hb_deinit(struct bcm_vk *vk)
>> +{
>> +	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
>> +
>> +	del_timer(&hb->timer);
>> +}
>> +
>> +static void bcm_vk_msgid_bitmap_clear(struct bcm_vk *vk,
>> +				      unsigned int start,
>> +				      unsigned int nbits)
>> +{
>> +	spin_lock(&vk->msg_id_lock);
>> +	bitmap_clear(vk->bmap, start, nbits);
>> +	spin_unlock(&vk->msg_id_lock);
>> +}
>> +
>> +/*
>> + * allocate a ctx per file struct
>> + */
>> +static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk,
>> +					 struct task_struct *ppid)
>> +{
>> +	uint32_t i;
>> +	struct bcm_vk_ctx *ctx = NULL;
>> +	const pid_t pid = task_pid_nr(ppid);
>> +	uint32_t hash_idx = hash_32(pid, VK_PID_HT_SHIFT_BIT);
>> +
>> +	spin_lock(&vk->ctx_lock);
>> +
>> +	/* check if it is in reset, if so, don't allow */
>> +	if (vk->reset_ppid) {
>> +		dev_err(&vk->pdev->dev,
>> +			"No context allowed during reset by pid %d\n",
>> +			task_pid_nr(vk->reset_ppid));
>> +
>> +		goto in_reset_exit;
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(vk->ctx); i++) {
>> +		if (!vk->ctx[i].in_use) {
>> +			vk->ctx[i].in_use = true;
>> +			ctx = &vk->ctx[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!ctx) {
>> +		dev_err(&vk->pdev->dev, "All context in use\n");
>> +
>> +		goto all_in_use_exit;
>> +	}
>> +
>> +	/* set the pid and insert it to hash table */
>> +	ctx->ppid = ppid;
>> +	ctx->hash_idx = hash_idx;
>> +	list_add_tail(&ctx->node, &vk->pid_ht[hash_idx].head);
>> +
>> +	/* increase kref */
>> +	kref_get(&vk->kref);
>> +
>> +	/* clear counter */
>> +	ctx->pend_cnt = 0;
>> +all_in_use_exit:
>> +in_reset_exit:
>> +	spin_unlock(&vk->ctx_lock);
>> +
>> +	return ctx;
>> +}
>> +
>> +static uint16_t bcm_vk_get_msg_id(struct bcm_vk *vk)
>> +{
>> +	uint16_t rc = VK_MSG_ID_OVERFLOW;
>> +	uint16_t test_bit_count = 0;
>> +
>> +	spin_lock(&vk->msg_id_lock);
>> +	while (test_bit_count < VK_MSG_ID_BITMAP_SIZE) {
>> +		vk->msg_id++;
>> +		vk->msg_id = vk->msg_id & VK_MSG_ID_BITMAP_MASK;
>> +		if (test_bit(vk->msg_id, vk->bmap)) {
>> +			test_bit_count++;
>> +			continue;
>> +		}
>> +		rc = vk->msg_id;
>> +		bitmap_set(vk->bmap, vk->msg_id, 1);
>> +		break;
>> +	}
>> +	spin_unlock(&vk->msg_id_lock);
>> +
>> +	return rc;
>> +}
>> +
>> +static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
>> +{
>> +	uint32_t idx;
>> +	uint32_t hash_idx;
>> +	pid_t pid;
>> +	struct bcm_vk_ctx *entry;
>> +	int count = 0;
>> +
>> +	if (ctx == NULL) {
>> +		dev_err(&vk->pdev->dev, "NULL context detected\n");
>> +		return -EINVAL;
>> +	}
>> +	idx = ctx->idx;
>> +	pid = task_pid_nr(ctx->ppid);
>> +
>> +	spin_lock(&vk->ctx_lock);
>> +
>> +	if (!vk->ctx[idx].in_use) {
>> +		dev_err(&vk->pdev->dev, "context[%d] not in use!\n", idx);
>> +	} else {
>> +		vk->ctx[idx].in_use = false;
>> +		vk->ctx[idx].miscdev = NULL;
>> +
>> +		/* Remove it from hash list and see if it is the last one. */
>> +		list_del(&ctx->node);
>> +		hash_idx = ctx->hash_idx;
>> +		list_for_each_entry(entry, &vk->pid_ht[hash_idx].head, node) {
>> +			if (task_pid_nr(entry->ppid) == pid)
>> +				count++;
>> +		}
>> +	}
>> +
>> +	spin_unlock(&vk->ctx_lock);
>> +
>> +	return count;
>> +}
>> +
>> +static void bcm_vk_free_wkent(struct device *dev, struct bcm_vk_wkent *entry)
>> +{
>> +	bcm_vk_sg_free(dev, entry->dma, VK_DMA_MAX_ADDRS);
>> +
>> +	kfree(entry->vk2h_msg);
>> +	kfree(entry);
>> +}
>> +
>> +static void bcm_vk_drain_all_pend(struct device *dev,
>> +				  struct bcm_vk_msg_chan *chan,
>> +				  struct bcm_vk_ctx *ctx)
>> +{
>> +	uint32_t num;
>> +	struct bcm_vk_wkent *entry, *tmp;
>> +	struct bcm_vk *vk;
>> +	struct list_head del_q;
>> +
>> +	if (ctx)
>> +		vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
>> +
>> +	INIT_LIST_HEAD(&del_q);
>> +	spin_lock(&chan->pendq_lock);
>> +	for (num = 0; num < chan->q_nr; num++) {
>> +		list_for_each_entry_safe(entry, tmp, &chan->pendq[num], node) {
>> +			if (ctx == NULL) {
>> +				list_del(&entry->node);
>> +				list_add_tail(&entry->node, &del_q);
>> +			} else if (entry->ctx->idx == ctx->idx) {
>> +				struct vk_msg_blk *msg;
>> +				int bit_set;
>> +				bool responded;
>> +
>> +				/* if it is specific ctx, log for any stuck */
>> +				msg = entry->h2vk_msg;
>> +				bit_set = test_bit(msg->msg_id, vk->bmap);
>> +				responded = entry->vk2h_msg ? true : false;
>> +				dev_info(dev,
>> +					 "Drained: fid %u size %u msg 0x%x(seq-%x) ctx 0x%x[fd-%d] args:[0x%x 0x%x] resp %s, bmap %d\n",
>> +					 msg->function_id, msg->size,
>> +					 msg->msg_id, entry->seq_num,
>> +					 msg->context_id, entry->ctx->idx,
>> +					 msg->args[0], msg->args[1],
>> +					 responded ? "T" : "F", bit_set);
>> +				list_del(&entry->node);
>> +				list_add_tail(&entry->node, &del_q);
>> +				if (responded)
>> +					ctx->pend_cnt--;
>> +				else if (bit_set)
>> +					bcm_vk_msgid_bitmap_clear(vk,
>> +								  msg->msg_id,
>> +								  1);
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&chan->pendq_lock);
>> +
>> +	/* batch clean up */
>> +	num = 0;
>> +	list_for_each_entry_safe(entry, tmp, &del_q, node) {
>> +		list_del(&entry->node);
>> +		bcm_vk_free_wkent(dev, entry);
>> +		num++;
>> +	}
>> +	if (num)
>> +		dev_info(dev, "Total drained items %d\n", num);
>> +}
>> +
>> +bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
>> +{
>> +	uint32_t rdy_marker = 0;
>> +	uint32_t fw_status;
>> +
>> +	fw_status = vkread32(vk, BAR_0, VK_BAR_FWSTS);
>> +
>> +	if ((fw_status & VK_FWSTS_READY) == VK_FWSTS_READY)
>> +		rdy_marker = vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
>> +
>> +	return (rdy_marker == VK_BAR1_MSGQ_RDY_MARKER);
>> +}
>> +
>> +/*
>> + * Function to sync up the messages queue info that is provided by BAR1
>> + */
>> +int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync)
>> +{
>> +	struct bcm_vk_msgq *msgq = NULL;
>> +	struct device *dev = &vk->pdev->dev;
>> +	uint32_t msgq_off;
>> +	uint32_t num_q;
>> +	struct bcm_vk_msg_chan *chan_list[] = {&vk->h2vk_msg_chan,
>> +					       &vk->vk2h_msg_chan};
>> +	struct bcm_vk_msg_chan *chan = NULL;
>> +	int i, j;
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * If the driver is loaded at startup where vk OS is not up yet,
>> +	 * the msgq-info may not be available until a later time.  In
>> +	 * this case, we skip and the sync function is supposed to be
>> +	 * called again.
>> +	 */
>> +	if (!bcm_vk_msgq_marker_valid(vk)) {
>> +		dev_info(dev, "BAR1 msgq marker not initialized.\n");
>> +		return ret;
> This is "return 0;" which seems wrong.
>
>> +	}
>> +
>> +	msgq_off = vkread32(vk, BAR_1, VK_BAR1_MSGQ_CTRL_OFF);
>> +
>> +	/* each side is always half the total  */
>> +	num_q = vk->h2vk_msg_chan.q_nr = vk->vk2h_msg_chan.q_nr =
>> +		vkread32(vk, BAR_1, VK_BAR1_MSGQ_NR) / 2;
>> +
>> +	/* first msgq location */
>> +	msgq = (struct bcm_vk_msgq *)(vk->bar[BAR_1] + msgq_off);
>> +
>> +	/*
>> +	 * if this function is called when it is already inited,
>> +	 * something is wrong
>> +	 */
>> +	if (bcm_vk_drv_access_ok(vk) && (!force_sync)) {
> Delete extra parens.
>
>> +		dev_err(dev, "Msgq info already in sync\n");
>> +		ret = -EPERM;
>> +		goto already_inited;
> Please do a direct "return -EPERM;"
>
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(chan_list); i++) {
>> +		chan = chan_list[i];
>> +		memset(chan->sync_qinfo, 0, sizeof(chan->sync_qinfo));
>> +
>> +		for (j = 0; j < num_q; j++) {
>> +			chan->msgq[j] = msgq;
>> +
>> +			dev_info(dev,
>> +				 "MsgQ[%d] type %d num %d, @ 0x%x, rd_idx %d wr_idx %d, size %d, nxt 0x%x\n",
>> +				 j,
>> +				 chan->msgq[j]->type,
>> +				 chan->msgq[j]->num,
>> +				 chan->msgq[j]->start,
>> +				 chan->msgq[j]->rd_idx,
>> +				 chan->msgq[j]->wr_idx,
>> +				 chan->msgq[j]->size,
>> +				 chan->msgq[j]->nxt);
> It would be shorter to replace chan->msgq[j]->type with msgq->type.
>
>> +
>> +			/* formulate and record static info */
>> +			chan->sync_qinfo[j].q_start =
>> +				vk->bar[BAR_1] + chan->msgq[j]->start;
> Maybe set "qinfo = &chan->sync_qinfo[j];" at the start of the loop so
> that these fit on one line.
>
> 			qinfo->q_start = vk->bar[BAR_1] + msgq->start;
>
>> +			chan->sync_qinfo[j].q_size = chan->msgq[j]->size;
>> +			/* set low threshold as 50% or 1/2 */
>> +			chan->sync_qinfo[j].q_low =
>> +				chan->sync_qinfo[j].q_size >> 1;
>> +			chan->sync_qinfo[j].q_mask =
>> +				chan->sync_qinfo[j].q_size - 1;
>> +
>> +			msgq = (struct bcm_vk_msgq *)
>> +				((char *)msgq + sizeof(*msgq) + msgq->nxt);
>> +
>> +			rmb(); /* do a read mb to guarantee */
>> +		}
>> +	}
>> +	atomic_set(&vk->msgq_inited, 1);
>> +
>> +already_inited:
>> +	return ret;
>> +}
>> +
>> +static int bcm_vk_msg_chan_init(struct bcm_vk_msg_chan *chan)
>> +{
>> +	int rc = 0;
>> +	uint32_t i;
>> +
>> +	mutex_init(&chan->msgq_mutex);
>> +	spin_lock_init(&chan->pendq_lock);
>> +	for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
>> +		INIT_LIST_HEAD(&chan->pendq[i]);
>> +#if defined(CONFIG_BCM_VK_QSTATS)
>> +		chan->qstats[i].q_num = i;
>> +#endif
>> +	}
>> +
>> +	return rc;
>
> 	return 0;
>
>> +}
>> +
>> +static void bcm_vk_append_pendq(struct bcm_vk_msg_chan *chan, uint16_t q_num,
>> +				struct bcm_vk_wkent *entry)
>> +{
>> +	spin_lock(&chan->pendq_lock);
>> +	list_add_tail(&entry->node, &chan->pendq[q_num]);
>> +	if (entry->vk2h_msg)
>> +		entry->ctx->pend_cnt++;
>> +	spin_unlock(&chan->pendq_lock);
>> +}
>> +
>> +static uint32_t bcm_vk_append_ib_sgl(struct bcm_vk *vk,
>> +				     struct bcm_vk_wkent *entry,
>> +				     struct _vk_data *data,
>> +				     unsigned int num_planes)
>> +{
>> +	unsigned int i;
>> +	unsigned int item_cnt = 0;
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct bcm_vk_msg_chan *chan = &vk->h2vk_msg_chan;
>> +	struct vk_msg_blk *msg = &entry->h2vk_msg[0];
>> +	struct bcm_vk_msgq *msgq;
>> +	struct bcm_vk_sync_qinfo *qinfo;
>> +	uint32_t ib_sgl_size = 0;
>> +	uint8_t *buf = (uint8_t *)&entry->h2vk_msg[entry->h2vk_blks];
>> +	uint32_t avail;
>> +
>> +	/* check if high watermark is hit, and if so, skip */
>> +	msgq = chan->msgq[msg->queue_id];
>> +	qinfo = &chan->sync_qinfo[msg->queue_id];
>> +	avail = VK_MSGQ_AVAIL_SPACE(msgq, qinfo);
>> +	if (avail < qinfo->q_low) {
>> +		dev_dbg(dev, "Skip inserting inband SGL, [0x%x/0x%x]\n",
>> +			avail, qinfo->q_size);
>> +		return ib_sgl_size;
> 		return 0;
>
>> +	}
>> +
>> +	for (i = 0; i < num_planes; i++) {
>> +		if (data[i].address &&
>> +		    (ib_sgl_size + data[i].size) <= vk->ib_sgl_size) {
>> +
>> +			item_cnt++;
>> +			memcpy(buf, entry->dma[i].sglist, data[i].size);
>> +			ib_sgl_size += data[i].size;
>> +			buf += data[i].size;
>> +		}
>> +	}
>> +
>> +	dev_dbg(dev, "Num %u sgl items appended, size 0x%x, room 0x%x\n",
>> +		item_cnt, ib_sgl_size, vk->ib_sgl_size);
>> +
>> +	/* round up size */
>> +	ib_sgl_size = (ib_sgl_size + VK_MSGQ_BLK_SIZE - 1)
>> +		       >> VK_MSGQ_BLK_SZ_SHIFT;
>> +
>> +	return ib_sgl_size;
>> +}
>> +
>> +void bcm_h2vk_doorbell(struct bcm_vk *vk, uint32_t q_num,
>> +			      uint32_t db_val)
>> +{
>> +	/* press door bell based on q_num */
>> +	vkwrite32(vk,
>> +		  db_val,
>> +		  BAR_0,
>> +		  VK_BAR0_REGSEG_DB_BASE + q_num * VK_BAR0_REGSEG_DB_REG_GAP);
>> +}
>> +
>> +static int bcm_h2vk_msg_enqueue(struct bcm_vk *vk, struct bcm_vk_wkent *entry)
>> +{
>> +	static uint32_t seq_num;
>> +	struct bcm_vk_msg_chan *chan = &vk->h2vk_msg_chan;
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct vk_msg_blk *src = &entry->h2vk_msg[0];
>> +
>> +	volatile struct vk_msg_blk *dst;
>> +	struct bcm_vk_msgq *msgq;
>> +	struct bcm_vk_sync_qinfo *qinfo;
>> +	uint32_t q_num = src->queue_id;
>> +	uint32_t wr_idx; /* local copy */
>> +	uint32_t i;
>> +	uint32_t avail;
>> +	uint32_t retry;
>> +
>> +	if (entry->h2vk_blks != src->size + 1) {
>> +		dev_err(dev, "number of blks %d not matching %d MsgId[0x%x]: func %d ctx 0x%x\n",
>> +			entry->h2vk_blks,
>> +			src->size + 1,
>> +			src->msg_id,
>> +			src->function_id,
>> +			src->context_id);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	msgq = chan->msgq[q_num];
>> +	qinfo = &chan->sync_qinfo[q_num];
>> +
>> +	rmb(); /* start with a read barrier */
>> +	mutex_lock(&chan->msgq_mutex);
>> +
>> +	avail = VK_MSGQ_AVAIL_SPACE(msgq, qinfo);
>> +
>> +#if defined(CONFIG_BCM_VK_QSTATS)
>> +	bcm_vk_update_qstats(vk, "h2vk", &chan->qstats[q_num],
>> +			     qinfo->q_size - avail);
>> +#endif
>> +	/* if not enough space, return EAGAIN and let app handles it */
>> +	retry = 0;
>> +	while ((avail < entry->h2vk_blks)
>> +	       && (retry++ < BCM_VK_H2VK_ENQ_RETRY)) {
>> +		mutex_unlock(&chan->msgq_mutex);
>> +
>> +		msleep(BCM_VK_H2VK_ENQ_RETRY_DELAY_MS);
>> +		mutex_lock(&chan->msgq_mutex);
>> +		avail = VK_MSGQ_AVAIL_SPACE(msgq, qinfo);
>> +	}
>> +	if (retry > BCM_VK_H2VK_ENQ_RETRY) {
>> +		mutex_unlock(&chan->msgq_mutex);
>> +		return -EAGAIN;
>> +	}
>> +
>> +	/* at this point, mutex is taken and there is enough space */
>> +	entry->seq_num = seq_num++; /* update debug seq number */
>> +	wr_idx = msgq->wr_idx;
>> +
>> +	if (wr_idx >= qinfo->q_size) {
>> +		dev_crit(dev, "Invalid wr_idx 0x%x => max 0x%x!",
>> +			 wr_idx, qinfo->q_size);
>> +		bcm_vk_blk_drv_access(vk);
>> +		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_PCIE_DWN);
>> +		goto idx_err;
>> +	}
>> +
>> +	dst = VK_MSGQ_BLK_ADDR(qinfo, wr_idx);
>> +	for (i = 0; i < entry->h2vk_blks; i++) {
>> +		*dst = *src;
>> +
>> +		bcm_vk_h2vk_verify_blk(dev, src, dst);
>> +
>> +		src++;
>> +		wr_idx = VK_MSGQ_INC(qinfo, wr_idx, 1);
>> +		dst = VK_MSGQ_BLK_ADDR(qinfo, wr_idx);
>> +	}
>> +
>> +	/* flush the write pointer */
>> +	msgq->wr_idx = wr_idx;
>> +	wmb(); /* flush */
>> +
>> +	bcm_vk_h2vk_verify_idx(dev, "wr_idx", &msgq->wr_idx, wr_idx);
>> +
>> +	/* log new info for debugging */
>> +	dev_dbg(dev,
>> +		"MsgQ[%d] [Rd Wr] = [%d %d] blks inserted %d - Q = [u-%d a-%d]/%d\n",
>> +		msgq->num,
>> +		msgq->rd_idx, msgq->wr_idx, entry->h2vk_blks,
>> +		VK_MSGQ_OCCUPIED(msgq, qinfo),
>> +		VK_MSGQ_AVAIL_SPACE(msgq, qinfo),
>> +		msgq->size);
>> +	/*
>> +	 * press door bell based on queue number. 1 is added to the wr_idx
>> +	 * to avoid the value of 0 appearing on the VK side to distinguish
>> +	 * from initial value.
>> +	 */
>> +	bcm_h2vk_doorbell(vk, q_num, wr_idx + 1);
>> +idx_err:
>> +	mutex_unlock(&chan->msgq_mutex);
>> +	return 0;
>> +}
>> +
>> +int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, uint32_t shut_type,
>> +			     pid_t pid)
>> +{
>> +	int rc = 0;
>> +	struct bcm_vk_wkent *entry;
>> +	struct device *dev = &vk->pdev->dev;
>> +
>> +	/*
>> +	 * check if the marker is still good.  Sometimes, the PCIe interface may
>> +	 * have gone done, and if so and we ship down thing based on broken
>> +	 * values, kernel may panic.
>> +	 */
>> +	if (!bcm_vk_msgq_marker_valid(vk)) {
>> +		dev_info(dev, "PCIe comm chan - invalid marker (0x%x)!\n",
>> +			 vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY));
>> +		return -EINVAL;
>> +	}
>> +
>> +	entry = kzalloc(sizeof(struct bcm_vk_wkent) +
>> +			sizeof(struct vk_msg_blk), GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENOMEM;
>> +
>> +	/* just fill up non-zero data */
>> +	entry->h2vk_msg[0].function_id = VK_FID_SHUTDOWN;
>> +	entry->h2vk_msg[0].queue_id = 0; /* use highest queue */
>> +	entry->h2vk_blks = 1; /* always 1 block */
>> +
>> +	entry->h2vk_msg[0].args[0] = shut_type;
>> +	entry->h2vk_msg[0].args[1] = pid;
>> +
>> +	rc = bcm_h2vk_msg_enqueue(vk, entry);
>> +	if (rc)
>> +		dev_err(dev,
>> +			"Sending shutdown message to q %d for pid %d fails.\n",
>> +			entry->h2vk_msg[0].queue_id, pid);
>> +
>> +	kfree(entry);
>> +
>> +	return rc;
>> +}
>> +
>> +int bcm_vk_handle_last_sess(struct bcm_vk *vk, struct task_struct *ppid)
>> +{
>> +	int rc = 0;
>> +	pid_t pid = task_pid_nr(ppid);
>> +	struct device *dev = &vk->pdev->dev;
>> +
>> +	/*
>> +	 * don't send down or do anything if message queue is not initialized
>> +	 * and if it is the reset session, clear it.
>> +	 */
>> +	if (!bcm_vk_drv_access_ok(vk)) {
>> +
>> +		if (vk->reset_ppid == ppid)
>> +			vk->reset_ppid = NULL;
>> +		return -EPERM;
>> +	}
>> +
>> +	dev_dbg(dev, "No more sessions, shut down pid %d\n", pid);
>> +
>> +	/* only need to do it if it is not the reset process */
>> +	if (vk->reset_ppid != ppid)
>> +		rc = bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_PID, pid);
>> +	else
>> +		/* reset the pointer if it is exiting last session */
>> +		vk->reset_ppid = NULL;
>> +
>> +	return rc;
>> +}
>> +
>> +static struct bcm_vk_wkent *bcm_vk_find_pending(struct bcm_vk *vk,
>> +						struct bcm_vk_msg_chan *chan,
>> +						uint16_t q_num,
>> +						uint16_t msg_id)
>> +{
>> +	bool found = false;
>> +	struct bcm_vk_wkent *entry;
>> +
>> +	spin_lock(&chan->pendq_lock);
>> +	list_for_each_entry(entry, &chan->pendq[q_num], node) {
>> +
>> +		if (entry->h2vk_msg[0].msg_id == msg_id) {
>> +			list_del(&entry->node);
>> +			found = true;
>> +			bcm_vk_msgid_bitmap_clear(vk, msg_id, 1);
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock(&chan->pendq_lock);
>> +	return ((found) ? entry : NULL);
>> +}
>> +
>> +static uint32_t bcm_vk2h_msg_dequeue(struct bcm_vk *vk)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct bcm_vk_msg_chan *chan = &vk->vk2h_msg_chan;
>> +	struct vk_msg_blk *data;
>> +	volatile struct vk_msg_blk *src;
>> +	struct vk_msg_blk *dst;
>> +	struct bcm_vk_msgq *msgq;
>> +	struct bcm_vk_sync_qinfo *qinfo;
>> +	struct bcm_vk_wkent *entry;
>> +	uint32_t rd_idx;
>> +	uint32_t q_num, j;
>> +	uint32_t num_blks;
>> +	uint32_t total = 0;
>> +
>> +	/*
>> +	 * drain all the messages from the queues, and find its pending
>> +	 * entry in the h2vk queue, based on msg_id & q_num, and move the
>> +	 * entry to the vk2h pending queue, waiting for user space
>> +	 * program to extract
>> +	 */
>> +	mutex_lock(&chan->msgq_mutex);
>> +	rmb(); /* start with a read barrier */
>> +	for (q_num = 0; q_num < chan->q_nr; q_num++) {
>> +		msgq = chan->msgq[q_num];
>> +		qinfo = &chan->sync_qinfo[q_num];
>> +
>> +		while (!VK_MSGQ_EMPTY(msgq)) {
>> +
>> +			/*
>> +			 * Make a local copy and get pointer to src blk
>> +			 * The rd_idx is masked before getting the pointer to
>> +			 * avoid out of bound access in case the interface goes
>> +			 * down.  It will end up pointing to the last block in
>> +			 * the buffer, but subsequent src->size check would be
>> +			 * able to catch this.
>> +			 */
>> +			rd_idx = msgq->rd_idx;
>> +			src = VK_MSGQ_BLK_ADDR(qinfo,
>> +					     rd_idx & VK_MSGQ_SIZE_MASK(qinfo));
>> +
>> +			if ((rd_idx >= qinfo->q_size)
>> +			    || (src->size > (qinfo->q_size - 1))) {
>> +				dev_crit(dev,
>> +					 "Invalid rd_idx 0x%x or size 0x%x => max 0x%x!",
>> +					 rd_idx, src->size, qinfo->q_size);
>> +				bcm_vk_blk_drv_access(vk);
>> +				bcm_vk_set_host_alert(
>> +					vk, ERR_LOG_HOST_PCIE_DWN);
>> +				goto idx_err;
>> +			}
>> +
>> +#if defined(CONFIG_BCM_VK_QSTATS)
>> +			bcm_vk_update_qstats(vk, "vk2h", &chan->qstats[q_num],
>> +					     VK_MSGQ_OCCUPIED(msgq, qinfo));
>> +#endif
>> +			num_blks = src->size + 1;
>> +			data = kzalloc(num_blks * VK_MSGQ_BLK_SIZE, GFP_KERNEL);
>> +			if (data) {
>> +				/* copy messages and linearize it */
>> +				dst = data;
>> +				for (j = 0; j < num_blks; j++) {
>> +					*dst = *src;
>> +
>> +					dst++;
>> +					rd_idx = VK_MSGQ_INC(qinfo, rd_idx, 1);
>> +					src = VK_MSGQ_BLK_ADDR(qinfo, rd_idx);
>> +				}
>> +				total++;
>> +			} else {
>> +				dev_crit(dev, "Error allocating memory\n");
>> +				/* just keep draining..... */
>> +				rd_idx = VK_MSGQ_INC(qinfo, rd_idx, num_blks);
>> +			}
>> +
>> +			/* flush rd pointer after a message is dequeued */
>> +			msgq->rd_idx = rd_idx;
>> +			mb(); /* do both rd/wr as we are extracting data out */
>> +
>> +			bcm_vk_h2vk_verify_idx(dev, "rd_idx",
>> +					       &msgq->rd_idx, rd_idx);
>> +
>> +			/* log new info for debugging */
>> +			dev_dbg(dev,
>> +				"MsgQ[%d] [Rd Wr] = [%d %d] blks extracted %d - Q = [u-%d a-%d]/%d\n",
>> +				msgq->num,
>> +				msgq->rd_idx, msgq->wr_idx, num_blks,
>> +				VK_MSGQ_OCCUPIED(msgq, qinfo),
>> +				VK_MSGQ_AVAIL_SPACE(msgq, qinfo),
>> +				msgq->size);
>> +
>> +			/*
>> +			 * No need to search if it is an autonomous one-way
>> +			 * message from driver, as these messages do not bear
>> +			 * a h2vk pending item. Currently, only the shutdown
>> +			 * message falls into this category.
>> +			 */
>> +			if (data->function_id == VK_FID_SHUTDOWN) {
>> +				kfree(data);
>> +				continue;
>> +			}
>> +
>> +			/* lookup original message in h2vk direction */
>> +			entry = bcm_vk_find_pending(vk,
>> +						    &vk->h2vk_msg_chan,
>> +						    q_num,
>> +						    data->msg_id);
>> +
>> +			/*
>> +			 * if there is message to does not have prior send,
>> +			 * this is the location to add here
>> +			 */
>> +			if (entry) {
>> +				entry->vk2h_blks = num_blks;
>> +				entry->vk2h_msg = data;
>> +				bcm_vk_append_pendq(&vk->vk2h_msg_chan,
>> +						    q_num, entry);
>> +
>> +			} else {
>> +				dev_crit(dev,
>> +					 "Could not find MsgId[0x%x] for resp func %d bmap %d\n",
>> +					 data->msg_id, data->function_id,
>> +					 test_bit(data->msg_id, vk->bmap));
>> +				kfree(data);
>> +			}
>> +
>> +		}
>> +	}
>> +idx_err:
>> +	mutex_unlock(&chan->msgq_mutex);
>> +	dev_dbg(dev, "total %d drained from queues\n", total);
>> +
>> +	return total;
>> +}
>> +
>> +/*
>> + * deferred work queue for draining and auto download.
>> + */
>> +static void bcm_vk_wq_handler(struct work_struct *work)
>> +{
>> +	struct bcm_vk *vk = container_of(work, struct bcm_vk, wq_work);
>> +	struct device *dev = &vk->pdev->dev;
>> +	uint32_t tot;
>> +
>> +	/* check wq offload bit map to perform various operations */
>> +	if (test_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload)) {
>> +		/* clear bit right the way for notification */
>> +		clear_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload);
>> +		bcm_vk_handle_notf(vk);
>> +	}
>> +	if (test_bit(BCM_VK_WQ_DWNLD_AUTO, vk->wq_offload)) {
>> +		bcm_vk_auto_load_all_images(vk);
>> +
>> +		/*
>> +		 * at the end of operation, clear AUTO bit and pending
>> +		 * bit
>> +		 */
>> +		clear_bit(BCM_VK_WQ_DWNLD_AUTO, vk->wq_offload);
>> +		clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
>> +	}
>> +
>> +	/* next, try to drain */
>> +	tot = bcm_vk2h_msg_dequeue(vk);
>> +
>> +	if (tot == 0)
>> +		dev_dbg(dev, "Spurious trigger for workqueue\n");
>> +}
>> +
>> +/*
>> + * init routine for all required data structures
>> + */
>> +static int bcm_vk_data_init(struct bcm_vk *vk)
>> +{
>> +	int rc = 0;
>> +	int i;
>> +
>> +	spin_lock_init(&vk->ctx_lock);
>> +	for (i = 0; i < ARRAY_SIZE(vk->ctx); i++) {
>> +		vk->ctx[i].in_use = false;
>> +		vk->ctx[i].idx = i;	/* self identity */
>> +		vk->ctx[i].miscdev = NULL;
>> +	}
>> +	spin_lock_init(&vk->msg_id_lock);
>> +	spin_lock_init(&vk->host_alert_lock);
>> +	vk->msg_id = 0;
>> +
>> +	/* initialize hash table */
>> +	for (i = 0; i < VK_PID_HT_SZ; i++)
>> +		INIT_LIST_HEAD(&vk->pid_ht[i].head);
>> +
>> +	INIT_WORK(&vk->wq_work, bcm_vk_wq_handler);
>> +	return rc;
> 	return 0;
>
>> +}
>> +
>> +irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id)
>> +{
>> +	struct bcm_vk *vk = dev_id;
>> +
>> +	if (!bcm_vk_drv_access_ok(vk)) {
>> +		dev_err(&vk->pdev->dev,
>> +			"Interrupt %d received when msgq not inited\n", irq);
>> +		goto skip_schedule_work;
>> +	}
>> +
>> +	queue_work(vk->wq_thread, &vk->wq_work);
>> +
>> +skip_schedule_work:
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +int bcm_vk_open(struct inode *inode, struct file *p_file)
>> +{
>> +	struct bcm_vk_ctx *ctx;
>> +	struct miscdevice *miscdev = (struct miscdevice *)p_file->private_data;
>> +	struct bcm_vk *vk = container_of(miscdev, struct bcm_vk, miscdev);
>> +	struct device *dev = &vk->pdev->dev;
>> +	int    rc = 0;
>> +
>> +	/* get a context and set it up for file */
>> +	ctx = bcm_vk_get_ctx(vk, current);
>> +	if (!ctx) {
>> +		dev_err(dev, "Error allocating context\n");
>> +		rc = -ENOMEM;
>> +	} else {
>> +
>> +		/*
>> +		 * set up context and replace private data with context for
>> +		 * other methods to use.  Reason for the context is because
>> +		 * it is allowed for multiple sessions to open the sysfs, and
>> +		 * for each file open, when upper layer query the response,
>> +		 * only those that are tied to a specific open should be
>> +		 * returned.  The context->idx will be used for such binding
>> +		 */
>> +		ctx->miscdev = miscdev;
>> +		p_file->private_data = ctx;
>> +		dev_dbg(dev, "ctx_returned with idx %d, pid %d\n",
>> +			ctx->idx, task_pid_nr(ctx->ppid));
>> +	}
>> +	return rc;
>> +}
>> +
>> +ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
>> +			   loff_t *f_pos)
>> +{
>> +	ssize_t rc = -ENOMSG;
>> +	struct bcm_vk_ctx *ctx = p_file->private_data;
>> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
>> +					 miscdev);
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct bcm_vk_msg_chan *chan = &vk->vk2h_msg_chan;
>> +	struct bcm_vk_wkent *entry = NULL;
>> +	uint32_t q_num;
>> +	uint32_t rsp_length;
>> +	bool found = false;
>> +
>> +	if (!bcm_vk_drv_access_ok(vk))
>> +		return -EPERM;
>> +
>> +	dev_dbg(dev, "Buf count %ld\n", count);
>> +	found = false;
>> +
>> +	/*
>> +	 * search through the pendq on the vk2h chan, and return only those
>> +	 * that belongs to the same context.  Search is always from the high to
>> +	 * the low priority queues
>> +	 */
>> +	spin_lock(&chan->pendq_lock);
>> +	for (q_num = 0; q_num < chan->q_nr; q_num++) {
>> +		list_for_each_entry(entry, &chan->pendq[q_num], node) {
>> +			if (entry->ctx->idx == ctx->idx) {
>> +				if (count >=
>> +				    (entry->vk2h_blks * VK_MSGQ_BLK_SIZE)) {
>> +					list_del(&entry->node);
>> +					ctx->pend_cnt--;
>> +					found = true;
>> +				} else {
>> +					/* buffer not big enough */
>> +					rc = -EMSGSIZE;
>> +				}
>> +				goto bcm_vk_read_loop_exit;
>> +			}
>> +		}
>> +	}
>> + bcm_vk_read_loop_exit:
>> +	spin_unlock(&chan->pendq_lock);
>> +
>> +	if (found) {
>> +		/* retrieve the passed down msg_id */
>> +		entry->vk2h_msg[0].msg_id = entry->usr_msg_id;
>> +		rsp_length = entry->vk2h_blks * VK_MSGQ_BLK_SIZE;
>> +		if (copy_to_user(buf, entry->vk2h_msg, rsp_length) == 0)
>> +			rc = rsp_length;
> The error code should be -EFAULT if this message fails (vs -ENOMSG).
>
>
>> +
>> +		bcm_vk_free_wkent(dev, entry);
>> +	} else if (rc == -EMSGSIZE) {
>> +		struct vk_msg_blk tmp_msg = entry->vk2h_msg[0];
>> +
>> +		/*
>> +		 * in this case, return just the first block, so
>> +		 * that app knows what size it is looking for.
>> +		 */
>> +		tmp_msg.msg_id = entry->usr_msg_id;
>> +		tmp_msg.size = entry->vk2h_blks - 1;
>> +		if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
>> +			dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
>> +			rc = -EFAULT;
>> +		}
>> +	}
>> +	return rc;
>> +}
>> +
>> +ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
>> +			    size_t count, loff_t *f_pos)
>> +{
>> +	ssize_t rc = -EPERM;
>> +	struct bcm_vk_ctx *ctx = p_file->private_data;
>> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
>> +					 miscdev);
>> +	struct bcm_vk_msgq *msgq;
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct bcm_vk_wkent *entry;
>> +	uint32_t sgl_extra_blks;
>> +
>> +	if (!bcm_vk_drv_access_ok(vk))
>> +		return -EPERM;
>> +
>> +	dev_dbg(dev, "Msg count %ld\n", count);
>> +
>> +	/* first, do sanity check where count should be multiple of basic blk */
>> +	if (count & (VK_MSGQ_BLK_SIZE - 1)) {
>> +		dev_err(dev, "Failure with size %ld not multiple of %ld\n",
>> +			count, VK_MSGQ_BLK_SIZE);
>> +		rc = -EBADR;
> #define EBADR           53      /* Invalid request descriptor */
>
> This should just be -EINVAL;
>
>
>> +		goto bcm_vk_write_err;
> These label names are too long.  They don't need the function prefix.
>
>> +	}
>> +
>> +	/* allocate the work entry + buffer for size count and inband sgl */
>> +	entry = kzalloc(sizeof(struct bcm_vk_wkent) + count + vk->ib_sgl_size,
>> +			GFP_KERNEL);
>> +	if (!entry) {
>> +		rc = -ENOMEM;
>> +		goto bcm_vk_write_err;
>> +	}
>> +
>> +	/* now copy msg from user space, and then formulate the wk ent */
>> +	if (copy_from_user(&entry->h2vk_msg[0], buf, count))
>> +		goto bcm_vk_write_free_ent;
> This is returning -EPERM instead of -EFAULT.
>
>> +
>> +	entry->h2vk_blks = count >> VK_MSGQ_BLK_SZ_SHIFT;
>> +	entry->ctx = ctx;
>> +
>> +	/* do a check on the blk size which could not exceed queue space */
>> +	msgq = vk->h2vk_msg_chan.msgq[entry->h2vk_msg[0].queue_id];
>> +	if (entry->h2vk_blks + (vk->ib_sgl_size >> VK_MSGQ_BLK_SZ_SHIFT)
>> +	    > (msgq->size - 1)) {
>> +		dev_err(dev, "Blk size %d exceed max queue size allowed %d\n",
>> +			entry->h2vk_blks, msgq->size - 1);
>> +		rc = -EOVERFLOW;
> This should probably just be -EINVAL as well.
>
>
>> +		goto bcm_vk_write_free_ent;
>> +	}
>> +
>> +	/* Use internal message id */
>> +	entry->usr_msg_id = entry->h2vk_msg[0].msg_id;
>> +	rc = bcm_vk_get_msg_id(vk);
>> +	if (rc == VK_MSG_ID_OVERFLOW) {
>> +		dev_err(dev, "msg_id overflow\n");
>> +		rc = -EOVERFLOW;
>> +		goto bcm_vk_write_free_ent;
>> +	}
>> +	entry->h2vk_msg[0].msg_id = rc;
>> +
>> +	dev_dbg(dev,
>> +		"Message ctx id %d, usr_msg_id 0x%x sent msg_id 0x%x\n",
>> +		ctx->idx, entry->usr_msg_id,
>> +		entry->h2vk_msg[0].msg_id);
>> +
>> +	/* Convert any pointers to sg list */
>> +	if (entry->h2vk_msg[0].function_id == VK_FID_TRANS_BUF) {
>> +		unsigned int num_planes;
>> +		int dir;
>> +		struct _vk_data *data;
>> +
>> +		/*
>> +		 * check if we are in reset, if so, no buffer transfer is
>> +		 * allowed and return error.
>> +		 */
>> +		if (vk->reset_ppid) {
>> +			dev_dbg(dev, "No Transfer allowed during reset, pid %d.\n",
>> +				task_pid_nr(ctx->ppid));
>> +			rc = -EACCES;
>> +			goto bcm_vk_write_free_msgid;
>> +		}
>> +
>> +		num_planes = entry->h2vk_msg[0].args[0] & VK_CMD_PLANES_MASK;
>> +		if ((entry->h2vk_msg[0].args[0] & VK_CMD_MASK)
>> +		    == VK_CMD_DOWNLOAD) {
>> +			/* Memory transfer from vk device */
> There are a bunch of pretty obvious comments that should just be
> deleted.
>
>> +			dir = DMA_FROM_DEVICE;
>> +		} else {
>> +			/* Memory transfer to vk device */
>> +			dir = DMA_TO_DEVICE;
>> +		}
>> +
>> +		/* Calculate vk_data location */
>> +		/* Go to end of the message */
>> +		data = (struct _vk_data *)
>> +			&(entry->h2vk_msg[entry->h2vk_msg[0].size + 1]);
>> +		/* Now back up to the start of the pointers */
>> +		data -= num_planes;
>> +
>> +		/* Convert user addresses to DMA SG List */
>> +		rc = bcm_vk_sg_alloc(dev, entry->dma, dir, data, num_planes);
>> +		if (rc)
>> +			goto bcm_vk_write_free_msgid;
>> +
>> +		/* try to embed inband sgl */
>> +		sgl_extra_blks = bcm_vk_append_ib_sgl(vk, entry, data,
>> +						      num_planes);
>> +		entry->h2vk_blks += sgl_extra_blks;
>> +		entry->h2vk_msg[0].size += sgl_extra_blks;
>> +	}
>> +
>> +	/*
>> +	 * store wk ent to pending queue until a response is got. This needs to
>                   ^^
> vk?
>
>> +	 * be done before enqueuing the message
>> +	 */
>> +	bcm_vk_append_pendq(&vk->h2vk_msg_chan, entry->h2vk_msg[0].queue_id,
>> +			    entry);
>> +
>> +	rc = bcm_h2vk_msg_enqueue(vk, entry);
>> +	if (rc) {
>> +		dev_err(dev, "Fail to enqueue msg to h2vk queue\n");
>> +
>> +		/* remove message from pending list */
>> +		entry = bcm_vk_find_pending(vk,
>> +					    &vk->h2vk_msg_chan,
>> +					    entry->h2vk_msg[0].queue_id,
>> +					    entry->h2vk_msg[0].msg_id);
>
> Can bcm_vk_find_pending() return NULL here (leading to an Oops when we
> do entry->h2vk_msg[0].msg_id and why can't we just use the previous
> value of entry?  The comment doesn't help me.
>
>> +		goto bcm_vk_write_free_ent;
>> +	}
>> +
>> +	return count;
>> +
>> +bcm_vk_write_free_msgid:
>> +	bcm_vk_msgid_bitmap_clear(vk, entry->h2vk_msg[0].msg_id, 1);
>> +bcm_vk_write_free_ent:
>> +	kfree(entry);
>> +bcm_vk_write_err:
>> +	return rc;
>> +}
>> +
>> +int bcm_vk_release(struct inode *inode, struct file *p_file)
>> +{
>> +	int ret;
>> +	struct bcm_vk_ctx *ctx = p_file->private_data;
>> +	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
>> +	struct device *dev = &vk->pdev->dev;
>> +	struct task_struct *ppid = ctx->ppid;
>> +	pid_t pid = task_pid_nr(ppid);
>> +
>> +	dev_dbg(dev, "Draining with context idx %d pid %d\n",
>> +		ctx->idx, pid);
>> +
>> +	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->h2vk_msg_chan, ctx);
>> +	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->vk2h_msg_chan, ctx);
>> +
>> +	ret = bcm_vk_free_ctx(vk, ctx);
> This returns a positive number.
>
>> +	if (ret == 0)
>> +		ret = bcm_vk_handle_last_sess(vk, ppid);
>> +
>> +	/* free memory if it is the last reference */
>> +	kref_put(&vk->kref, bcm_vk_release_data);
>> +
>> +	return ret;
> Which we propogate to here.  Probably this should just be "return 0;".
>
>> +}
>> +
>> +int bcm_vk_msg_init(struct bcm_vk *vk)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +	int err = 0;
>> +
>> +	if (bcm_vk_data_init(vk)) {
>> +		dev_err(dev, "Error initializing internal data structures\n");
>> +		err = -EINVAL;
>> +		goto err_out;
>> +	}
>> +
>> +	if (bcm_vk_msg_chan_init(&vk->h2vk_msg_chan) ||
>> +	    bcm_vk_msg_chan_init(&vk->vk2h_msg_chan)) {
>> +		dev_err(dev, "Error initializing communication channel\n");
>> +		err = -EIO;
>> +		goto err_out;
>> +	}
>> +
>> +	/* create dedicated workqueue */
>> +	vk->wq_thread = create_singlethread_workqueue(vk->miscdev.name);
>> +	if (!vk->wq_thread) {
>> +		dev_err(dev, "Fail to create workqueue thread\n");
>> +		err = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	/* read msgq info */
>> +	if (bcm_vk_sync_msgq(vk, false)) {
>> +		dev_err(dev, "Error reading comm msg Q info\n");
>> +		err = -EIO;
>> +		goto err_out;
>> +	}
>> +
>> +err_out:
>> +	return err;
> This should probably clean up the work queue on error?
>
>> +}
>> +
>> +void bcm_vk_msg_remove(struct bcm_vk *vk)
>> +{
>> +	bcm_vk_blk_drv_access(vk);
>> +
>> +	/* drain all pending items */
>> +	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->h2vk_msg_chan, NULL);
>> +	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->vk2h_msg_chan, NULL);
>> +}
>> +
>> +void bcm_vk_trigger_reset(struct bcm_vk *vk)
>> +{
>> +	uint32_t i;
>> +	u32 value;
>> +
>> +	/* clean up before pressing the door bell */
>> +	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->h2vk_msg_chan, NULL);
>> +	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->vk2h_msg_chan, NULL);
>> +	vkwrite32(vk, 0, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
>> +	/* make tag '\0' terminated */
>> +	vkwrite32(vk, 0, BAR_1, VK_BAR1_BOOT1_VER_TAG);
>> +
>> +	for (i = 0; i < VK_BAR1_DAUTH_MAX; i++) {
>> +		vkwrite32(vk, 0, BAR_1, VK_BAR1_DAUTH_STORE_ADDR(i));
>> +		vkwrite32(vk, 0, BAR_1, VK_BAR1_DAUTH_VALID_ADDR(i));
>> +	}
>> +	for (i = 0; i < VK_BAR1_SOTP_REVID_MAX; i++)
>> +		vkwrite32(vk, 0, BAR_1, VK_BAR1_SOTP_REVID_ADDR(i));
>> +
>> +	memset(&vk->card_info, 0, sizeof(vk->card_info));
>> +	memset(&vk->alert_cnts, 0, sizeof(vk->alert_cnts));
>> +
>> +	/*
>> +	 * When boot request fails, the CODE_PUSH_OFFSET stays persistent.
>> +	 * Allowing us to debug the failure. When we call reset,
>> +	 * we should clear CODE_PUSH_OFFSET so ROM does not execute
>> +	 * boot again (and fails again) and instead waits for a new
>> +	 * codepush.
>> +	 */
>> +	value = vkread32(vk, BAR_0, BAR_CODEPUSH_SBL);
>> +	value &= ~CODEPUSH_MASK;
>> +	vkwrite32(vk, value, BAR_0, BAR_CODEPUSH_SBL);
>> +
>> +	/* reset fw_status with proper reason, and press db */
>> +	vkwrite32(vk, VK_FWSTS_RESET_MBOX_DB, BAR_0, VK_BAR_FWSTS);
>> +	bcm_h2vk_doorbell(vk, VK_BAR0_RESET_DB_NUM, VK_BAR0_RESET_DB_SOFT);
>> +
>> +	/* clear the uptime register after reset pressed and alert record */
>> +	vkwrite32(vk, 0, BAR_0, BAR_OS_UPTIME);
>> +	memset(&vk->host_alert, 0, sizeof(vk->host_alert));
>> +	memset(&vk->peer_alert, 0, sizeof(vk->peer_alert));
>> +#if defined(CONFIG_BCM_VK_QSTATS)
>> +	/* clear qstats */
>> +	for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
>> +		memset(&vk->h2vk_msg_chan.qstats[i].qcnts, 0,
>> +		       sizeof(vk->h2vk_msg_chan.qstats[i].qcnts));
>> +		memset(&vk->vk2h_msg_chan.qstats[i].qcnts, 0,
>> +		       sizeof(vk->vk2h_msg_chan.qstats[i].qcnts));
>> +	}
>> +#endif
>> +	/* clear 4096 bits of bitmap */
>> +	bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
>> +}
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
>> new file mode 100644
>> index 000000000000..076307b2f1c4
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
>> @@ -0,0 +1,210 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef BCM_VK_MSG_H
>> +#define BCM_VK_MSG_H
>> +
>> +#include <uapi/linux/misc/bcm_vk.h>
>> +#include "bcm_vk_sg.h"
>> +
>> +/* Single message queue control structure */
>> +struct bcm_vk_msgq {
>> +	uint16_t type;	/* queue type */
>> +	uint16_t num;	/* queue number */
>> +	uint32_t start;	/* offset in BAR1 where the queue memory starts */
>> +	volatile uint32_t rd_idx; /* read idx */
>> +	volatile uint32_t wr_idx; /* write idx */
>> +	uint32_t size;	/*
>> +			 * size, which is in number of 16byte blocks,
>> +			 * to align with the message data structure.
>> +			 */
>> +	uint32_t nxt;	/*
>> +			 * nxt offset to the next msg queue struct.
>> +			 * This is to provide flexibity for alignment purposes.
>> +			 */
>> +};
>> +
>> +/*
>> + * Structure to record static info from the msgq sync.  We keep local copy
>> + * for some of these variables for both performance + checking purpose.
>> + */
>> +struct bcm_vk_sync_qinfo {
>> +	void __iomem *q_start;
>> +	uint32_t q_size;
>> +	uint32_t q_mask;
>> +	uint32_t q_low;
>> +};
>> +
>> +#define VK_MSGQ_MAX_NR 4 /* Maximum number of message queues */
>> +
>> +/*
>> + * some useful message queue macros
>> + */
>> +
>> +/* vk_msg_blk is 16 bytes fixed */
>> +#define VK_MSGQ_BLK_SIZE   (sizeof(struct vk_msg_blk))
>> +/* shift for fast division of basic msg blk size */
>> +#define VK_MSGQ_BLK_SZ_SHIFT 4
>> +
>> +#define VK_MSGQ_EMPTY(_msgq) ((_msgq)->rd_idx == (_msgq)->wr_idx)
>> +
>> +#define VK_MSGQ_SIZE_MASK(_qinfo) ((_qinfo)->q_mask)
>> +
>> +#define VK_MSGQ_INC(_qinfo, _idx, _inc) \
>> +	(((_idx) + (_inc)) & VK_MSGQ_SIZE_MASK(_qinfo))
>> +
>> +#define VK_MSGQ_BLK_ADDR(_qinfo, _idx) \
>> +	(volatile struct vk_msg_blk *)((_qinfo)->q_start + \
>> +				       (VK_MSGQ_BLK_SIZE * (_idx)))
>> +
>> +#define VK_MSGQ_OCCUPIED(_msgq, _qinfo) \
>> +	(((_msgq)->wr_idx - (_msgq)->rd_idx) & VK_MSGQ_SIZE_MASK(_qinfo))
>> +
>> +#define VK_MSGQ_AVAIL_SPACE(_msgq, _qinfo) \
>> +	((_qinfo)->q_size - VK_MSGQ_OCCUPIED(_msgq, _qinfo) - 1)
>> +
>> +/* context per session opening of sysfs */
>> +struct bcm_vk_ctx {
>> +	struct list_head node; /* use for linkage in Hash Table */
>> +	uint idx;
>> +	bool in_use;
>> +	struct task_struct *ppid;
>> +	uint32_t hash_idx;
>> +	struct miscdevice *miscdev;
>> +	int pend_cnt; /* number of items pending to be read from host */
>> +};
>> +
>> +/* pid hash table entry */
>> +struct bcm_vk_ht_entry {
>> +	struct list_head head;
>> +};
>> +
>> +#define VK_DMA_MAX_ADDRS 4 /* Max 4 DMA Addresses */
>> +/* structure for house keeping a single work entry */
>> +struct bcm_vk_wkent {
>> +
>> +	struct list_head node; /* for linking purpose */
>> +	struct bcm_vk_ctx *ctx;
>> +
>> +	/* Store up to 4 dma pointers */
>> +	struct bcm_vk_dma dma[VK_DMA_MAX_ADDRS];
>> +
>> +	uint32_t vk2h_blks; /* response */
>> +	struct vk_msg_blk *vk2h_msg;
>> +
>> +	/*
>> +	 * put the h2vk_msg at the end so that we could simply append h2vk msg
>> +	 * to the end of the allocated block
>> +	 */
>> +	uint32_t usr_msg_id;
>> +	uint32_t h2vk_blks;
>> +	uint32_t seq_num;
>> +	struct vk_msg_blk h2vk_msg[0];
>> +};
>> +
>> +/* queue stats counters */
>> +struct bcm_vk_qs_cnts {
>> +	uint32_t cnt; /* general counter, used to limit output */
>> +	uint32_t acc_sum;
>> +	uint32_t max_occ; /* max during a sampling period */
>> +	uint32_t max_abs; /* the abs max since reset */
>> +};
>> +
>> +/* stats structure */
>> +struct bcm_vk_qstats {
>> +	uint32_t q_num;
>> +	struct bcm_vk_qs_cnts qcnts;
>> +};
>> +
>> +/* control channel structure for either h2vk or vk2h communication */
>> +struct bcm_vk_msg_chan {
>> +	uint32_t q_nr;
>> +	struct mutex msgq_mutex;
>> +	/* pointing to BAR locations */
>> +	struct bcm_vk_msgq *msgq[VK_MSGQ_MAX_NR];
>> +
>> +	spinlock_t pendq_lock;
>> +	/* for temporary storing pending items, one for each queue */
>> +	struct list_head pendq[VK_MSGQ_MAX_NR];
>> +	/* static queue info from the sync */
>> +	struct bcm_vk_sync_qinfo sync_qinfo[VK_MSGQ_MAX_NR];
>> +#if defined(CONFIG_BCM_VK_QSTATS)
>> +	/* qstats */
>> +	struct bcm_vk_qstats qstats[VK_MSGQ_MAX_NR];
>> +#endif
>> +};
>> +
>> +/* total number of supported ctx, 32 ctx each for 5 components */
>> +#define VK_CMPT_CTX_MAX		(32 * 5)
>> +
>> +/* hash table defines to store the opened FDs */
>> +#define VK_PID_HT_SHIFT_BIT	7 /* 128 */
>> +#define VK_PID_HT_SZ		(1 << VK_PID_HT_SHIFT_BIT)
>> +
>> +/* The following are offsets of DDR info provided by the vk card */
>> +#define VK_BAR0_SEG_SIZE	(4 * SZ_1K) /* segment size for BAR0 */
>> +
>> +/* shutdown types supported */
>> +#define VK_SHUTDOWN_PID		1
>> +#define VK_SHUTDOWN_GRACEFUL	2
>> +
>> +/*
>> + * first door bell reg, ie for queue = 0.  Only need the first one, as
>> + * we will use the queue number to derive the others
>> + */
>> +#define VK_BAR0_REGSEG_DB_BASE		0x484
>> +#define VK_BAR0_REGSEG_DB_REG_GAP	8 /*
>> +					   * DB register gap,
>> +					   * DB1 at 0x48c and DB2 at 0x494
>> +					   */
>> +
>> +/* reset register and specific values */
>> +#define VK_BAR0_RESET_DB_NUM		3
>> +#define VK_BAR0_RESET_DB_SOFT		0xFFFFFFFF
>> +#define VK_BAR0_RESET_DB_HARD		0xFFFFFFFD
>> +
>> +/* BAR1 message q definition */
>> +
>> +/* indicate if msgq ctrl in BAR1 is populated */
>> +#define VK_BAR1_MSGQ_DEF_RDY		0x60c0
>> +/* ready marker value for the above location, normal boot2 */
>> +#define VK_BAR1_MSGQ_RDY_MARKER		0xbeefcafe
>> +/* ready marker value for the above location, normal boot2 */
>> +#define VK_BAR1_DIAG_RDY_MARKER		0xdeadcafe
>> +/* number of msgqs in BAR1 */
>> +#define VK_BAR1_MSGQ_NR			0x60c4
>> +/* BAR1 queue control structure offset */
>> +#define VK_BAR1_MSGQ_CTRL_OFF		0x60c8
>> +/* BAR1 ucode and boot1 version tag */
>> +#define VK_BAR1_UCODE_VER_TAG		0x6170
>> +#define VK_BAR1_BOOT1_VER_TAG		0x61b0
>> +#define VK_BAR1_VER_TAG_SIZE		64
>> +/* Memory to hold the DMA buffer memory address allocated for boot2 download */
>> +#define VK_BAR1_DMA_BUF_OFF_HI		0x61e0
>> +#define VK_BAR1_DMA_BUF_OFF_LO		(VK_BAR1_DMA_BUF_OFF_HI + 4)
>> +#define VK_BAR1_DMA_BUF_SZ		(VK_BAR1_DMA_BUF_OFF_HI + 8)
>> +/* Scratch memory allocated on host for VK */
>> +#define VK_BAR1_SCRATCH_OFF_LO		0x61f0
>> +#define VK_BAR1_SCRATCH_OFF_HI		(VK_BAR1_SCRATCH_OFF_LO + 4)
>> +#define VK_BAR1_SCRATCH_SZ_ADDR		(VK_BAR1_SCRATCH_OFF_LO + 8)
>> +#define VK_BAR1_SCRATCH_DEF_NR_PAGES	32
>> +  /* BAR1 SOTP AUTH and REVID info */
>> +#define VK_BAR1_DAUTH_BASE_ADDR		0x6200
>> +#define VK_BAR1_DAUTH_STORE_SIZE	0x48
>> +#define VK_BAR1_DAUTH_VALID_SIZE	0x8
>> +#define VK_BAR1_DAUTH_MAX		4
>> +#define VK_BAR1_DAUTH_STORE_ADDR(x) \
>> +		(VK_BAR1_DAUTH_BASE_ADDR + \
>> +		 (x) * (VK_BAR1_DAUTH_STORE_SIZE + VK_BAR1_DAUTH_VALID_SIZE))
>> +#define VK_BAR1_DAUTH_VALID_ADDR(x) \
>> +		(VK_BAR1_DAUTH_STORE_ADDR(x) + VK_BAR1_DAUTH_STORE_SIZE)
>> +
>> +#define VK_BAR1_SOTP_REVID_BASE_ADDR	0x6340
>> +#define VK_BAR1_SOTP_REVID_SIZE		0x10
>> +#define VK_BAR1_SOTP_REVID_MAX		2
>> +#define VK_BAR1_SOTP_REVID_ADDR(x) \
>> +		(VK_BAR1_SOTP_REVID_BASE_ADDR + (x) * VK_BAR1_SOTP_REVID_SIZE)
>> +
>> +#endif
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.c b/drivers/misc/bcm-vk/bcm_vk_sg.c
>> new file mode 100644
>> index 000000000000..e5de07958f0b
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_sg.c
>> @@ -0,0 +1,273 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +#include <linux/dma-mapping.h>
>> +#include <linux/mm.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include <asm/page.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include <uapi/linux/misc/bcm_vk.h>
>> +
>> +#include "bcm_vk.h"
>> +#include "bcm_vk_msg.h"
>> +#include "bcm_vk_sg.h"
>> +
>> +/*
>> + * Valkyrie has a hardware limitation of 16M transfer size.
>> + * So limit the SGL chunks to 16M.
>> + */
>> +#define BCM_VK_MAX_SGL_CHUNK SZ_16M
>> +
>> +static int bcm_vk_dma_alloc(struct device *dev,
>> +			    struct bcm_vk_dma *dma,
>> +			    int dir,
>> +			    struct _vk_data *vkdata);
>> +static int bcm_vk_dma_free(struct device *dev, struct bcm_vk_dma *dma);
>> +
>> +/* Uncomment to dump SGLIST */
>> +//#define BCM_VK_DUMP_SGLIST
>> +
>> +static int bcm_vk_dma_alloc(struct device *dev,
>> +			    struct bcm_vk_dma *dma,
>> +			    int direction,
>> +			    struct _vk_data *vkdata)
>> +{
>> +	dma_addr_t addr, sg_addr;
>> +	int err;
>> +	int i;
>> +	int offset;
>> +	uint32_t size;
>> +	uint32_t remaining_size;
>> +	uint32_t transfer_size;
>> +	uint64_t data;
>> +	unsigned long first, last;
>> +	struct _vk_data *sgdata;
>> +
>> +	/* Get 64-bit user address */
>> +	data = get_unaligned(&(vkdata->address));
> Extra parens.
>
>> +
>> +	/* offset into first page */
>> +	offset = offset_in_page(data);
>> +
>> +	/* Calculate number of pages */
>> +	first = (data & PAGE_MASK) >> PAGE_SHIFT;
>> +	last  = ((data + vkdata->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
>> +	dma->nr_pages = last - first + 1;
>> +
>> +	/* Allocate DMA pages */
>> +	dma->pages = kmalloc_array(dma->nr_pages,
>> +				   sizeof(struct page *),
>> +				   GFP_KERNEL);
>> +	if (dma->pages == NULL)
>> +		return -ENOMEM;
>> +
>> +	dev_dbg(dev, "Alloc DMA Pages [0x%llx+0x%x => %d pages]\n",
>> +		data, vkdata->size, dma->nr_pages);
>> +
>> +	dma->direction = direction;
>> +
>> +	/* Get user pages into memory */
>> +	err = get_user_pages_fast(data & PAGE_MASK,
>> +				  dma->nr_pages,
>> +				  direction == DMA_FROM_DEVICE,
>> +				  dma->pages);
>> +	if (err != dma->nr_pages) {
>> +		dma->nr_pages = (err >= 0) ? err : 0;
>> +		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
>> +			err, dma->nr_pages);
>> +		return err < 0 ? err : -EINVAL;
>> +	}
>> +
>> +	/* Max size of sg list is 1 per mapped page + fields at start */
>> +	dma->sglen = (dma->nr_pages * sizeof(*sgdata)) +
>> +		     (sizeof(uint32_t) * SGLIST_VKDATA_START);
>> +
>> +	/* Allocate sglist */
>> +	dma->sglist = dma_alloc_coherent(dev,
>> +					 dma->sglen,
>> +					 &dma->handle,
>> +					 GFP_KERNEL);
>
> 	dma->sglist = dma_alloc_coherent(dev, dma->sglen, &dma->handle,
> 					 GFP_KERNEL);
>
>
>
>> +	if (!dma->sglist)
>> +		return -ENOMEM;
> No cleanup?
>
>> +
>> +	dma->sglist[SGLIST_NUM_SG] = 0;
>> +	dma->sglist[SGLIST_TOTALSIZE] = vkdata->size;
>> +	remaining_size = vkdata->size;
>> +	sgdata = (struct _vk_data *)&(dma->sglist[SGLIST_VKDATA_START]);
>> +
>> +	/* Map all pages into DMA */
>> +	i = 0;
> Set but not used.
>
>> +	size = min_t(size_t, PAGE_SIZE - offset, remaining_size);
>> +	remaining_size -= size;
>> +	sg_addr = dma_map_page(dev,
>> +			       dma->pages[0],
>> +			       offset,
>> +			       size,
>> +			       dma->direction);
>> +	transfer_size = size;
>> +	if (unlikely(dma_mapping_error(dev, sg_addr))) {
>> +		__free_page(dma->pages[0]);
>> +		return -EIO;
>> +	}
>> +
>> +	for (i = 1; i < dma->nr_pages; i++) {
>> +		size = min_t(size_t, PAGE_SIZE, remaining_size);
>> +		remaining_size -= size;
>> +		addr = dma_map_page(dev,
>> +				    dma->pages[i],
>> +				    0,
>> +				    size,
>> +				    dma->direction);
>> +		if (unlikely(dma_mapping_error(dev, addr))) {
>> +			__free_page(dma->pages[i]);
>> +			return -EIO;
>> +		}
>> +
>> +		/*
>> +		 * Compress SG list entry when pages are contiguous
>> +		 * and transfer size less or equal to BCM_VK_MAX_SGL_CHUNK
>> +		 */
>> +		if ((addr == (sg_addr + transfer_size)) &&
>> +		    ((transfer_size + size) <= BCM_VK_MAX_SGL_CHUNK)) {
>> +			/* pages are contiguous, add to same sg entry */
>> +			transfer_size += size;
>> +		} else {
>> +			/* pages are not contiguous, write sg entry */
>> +			sgdata->size = transfer_size;
>> +			put_unaligned(sg_addr, (uint64_t *)&(sgdata->address));
>> +			dma->sglist[SGLIST_NUM_SG]++;
>> +
>> +			/* start new sg entry */
>> +			sgdata++;
>> +			sg_addr = addr;
>> +			transfer_size = size;
>> +		}
>> +	}
>> +	/* Write last sg list entry */
>> +	sgdata->size = transfer_size;
>> +	put_unaligned(sg_addr, (uint64_t *)&(sgdata->address));
>> +	dma->sglist[SGLIST_NUM_SG]++;
>> +
>> +	/* Update pointers and size field to point to sglist */
>> +	put_unaligned((uint64_t)dma->handle, &(vkdata->address));
>> +	vkdata->size = (dma->sglist[SGLIST_NUM_SG] * sizeof(*sgdata)) +
>> +		       (sizeof(uint32_t) * SGLIST_VKDATA_START);
>> +
>> +#ifdef BCM_VK_DUMP_SGLIST
>> +	dev_dbg(dev,
>> +		"sgl 0x%llx handle 0x%llx, sglen: 0x%x sgsize: 0x%x\n",
>> +		(uint64_t)dma->sglist,
>> +		dma->handle,
>> +		dma->sglen,
>> +		vkdata->size);
>> +	for (i = 0; i < vkdata->size / sizeof(uint32_t); i++)
>> +		dev_dbg(dev, "i:0x%x 0x%x\n", i, dma->sglist[i]);
>> +#endif
>> +
>> +	return 0;
>> +}
>> +
>> +int bcm_vk_sg_alloc(struct device *dev,
>> +		    struct bcm_vk_dma *dma,
>> +		    int dir,
>> +		    struct _vk_data *vkdata,
>> +		    int num)
>> +{
>> +	int i;
>> +	int rc = -EINVAL;
>> +
>> +	/* Convert user addresses to DMA SG List */
>> +	for (i = 0; i < num; i++) {
>> +		if (vkdata[i].size && vkdata[i].address) {
>> +			/*
>> +			 * If both size and address are non-zero
>> +			 * then DMA alloc.
>> +			 */
>> +			rc = bcm_vk_dma_alloc(dev,
>> +					      &dma[i],
>> +					      dir,
>> +					      &vkdata[i]);
>> +		} else if (vkdata[i].size ||
>> +			   vkdata[i].address) {
>> +			/*
>> +			 * If one of size and address are zero
>> +			 * there is a problem.
>> +			 */
>> +			dev_err(dev,
>> +				"Invalid vkdata %x 0x%x 0x%llx\n",
>> +				i, vkdata[i].size, vkdata[i].address);
>> +			rc = -EINVAL;
>> +		} else {
>> +			/*
>> +			 * If size and address are both zero
>> +			 * don't convert, but return success.
>> +			 */
>> +			rc = 0;
>> +		}
>> +
>> +		if (rc)
>> +			goto fail_alloc;
>> +	}
>> +	return rc;
>> +
>> +fail_alloc:
>> +	while (i > 0) {
>> +		i--;
>> +		if (dma[i].sglist)
>> +			bcm_vk_dma_free(dev, &dma[i]);
>> +	}
>> +	return rc;
>> +}
>> +
>> +static int bcm_vk_dma_free(struct device *dev, struct bcm_vk_dma *dma)
>> +{
>> +	dma_addr_t addr;
>> +	int i;
>> +	int num_sg;
>> +	uint32_t size;
>> +	struct _vk_data *vkdata;
>> +
>> +	dev_dbg(dev, "free sglist=%p sglen=0x%x\n",
>> +		dma->sglist, dma->sglen);
>> +
> This fits in 80 characters.
>
> 	dev_dbg(dev, "free sglist=%p sglen=0x%x\n", dma->sglist, dma->sglen);
>
>
>> +	/* Unmap all pages in the sglist */
>> +	num_sg = dma->sglist[SGLIST_NUM_SG];
>> +	vkdata = (struct _vk_data *)&(dma->sglist[SGLIST_VKDATA_START]);
> Extra parens.
>
>> +	for (i = 0; i < num_sg; i++) {
>> +		size = vkdata[i].size;
>> +		addr = get_unaligned(&(vkdata[i].address));
>> +
>> +		dma_unmap_page(dev, addr, size, dma->direction);
>> +	}
>> +
>> +	/* Free allocated sglist */
>> +	dma_free_coherent(dev, dma->sglen, dma->sglist, dma->handle);
>> +
>> +	/* Release lock on all pages */
>> +	for (i = 0; i < dma->nr_pages; i++)
>> +		put_page(dma->pages[i]);
>> +
>> +	/* Free allocated dma pages */
>> +	kfree(dma->pages);
>> +	dma->sglist = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +int bcm_vk_sg_free(struct device *dev, struct bcm_vk_dma *dma, int num)
>> +{
>> +	int i;
>> +
>> +	/* Unmap and free all pages and sglists */
>> +	for (i = 0; i < num; i++) {
>> +		if (dma[i].sglist)
>> +			bcm_vk_dma_free(dev, &dma[i]);
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.h b/drivers/misc/bcm-vk/bcm_vk_sg.h
>> new file mode 100644
>> index 000000000000..df88154e80b7
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_sg.h
>> @@ -0,0 +1,60 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef BCM_VK_SG_H
>> +#define BCM_VK_SG_H
>> +
>> +#include <linux/dma-mapping.h>
>> +
>> +struct bcm_vk_dma {
>> +	/* for userland buffer */
>> +	struct page **pages;
>> +	int nr_pages;
>> +
>> +	/* common */
>> +	dma_addr_t handle;
>> +	/*
>> +	 * sglist is of the following LE format
>> +	 * [U32] num_sg  = number of sg addresses (N)
>> +	 * [U32] totalsize = totalsize of data being transferred in sglist
>> +	 * [U32] size[0] = size of data in address0
>> +	 * [U32] addr_l[0] = lower 32-bits of address0
>> +	 * [U32] addr_h[0] = higher 32-bits of address0
>> +	 * ..
>> +	 * [U32] size[N-1] = size of data in addressN-1
>> +	 * [U32] addr_l[N-1] = lower 32-bits of addressN-1
>> +	 * [U32] addr_h[N-1] = higher 32-bits of addressN-1
>> +	 */
>> +	uint32_t *sglist;
>> +#define SGLIST_NUM_SG		0
>> +#define SGLIST_TOTALSIZE	1
>> +#define SGLIST_VKDATA_START	2
>> +
>> +	int sglen; /* Length (bytes) of sglist */
>> +	int direction;
>> +};
>> +
>> +struct _vk_data {
>> +	uint32_t size;    /* data size in bytes */
>> +	uint64_t address; /* Pointer to data     */
>> +} __packed;
>> +
>> +/*
>> + * Scatter-gather DMA buffer API.
>> + *
>> + * These functions provide a simple way to create a page list and a
>> + * scatter-gather list from userspace address and map the memory
>> + * for DMA operation.
>> + */
>> +int bcm_vk_sg_alloc(struct device *dev,
>> +		    struct bcm_vk_dma *dma,
>> +		    int dir,
>> +		    struct _vk_data *vkdata,
>> +		    int num);
>> +
>> +int bcm_vk_sg_free(struct device *dev, struct bcm_vk_dma *dma, int num);
>> +
>> +#endif
>> +
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
>> new file mode 100644
>> index 000000000000..3835218aaec6
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
>> @@ -0,0 +1,327 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#include <linux/tty.h>
>> +#include <linux/tty_driver.h>
>> +#include <linux/tty_flip.h>
>> +
>> +#include "bcm_vk.h"
>> +
>> +/* TTYVK base offset is 0x30000 into BAR1 */
>> +#define BAR1_TTYVK_BASE_OFFSET	0x300000
>> +/* Each TTYVK channel (TO or FROM) is 0x10000 */
>> +#define BAR1_TTYVK_CHAN_OFFSET	0x100000
>> +/* Each TTYVK channel has TO and FROM, hence the * 2 */
>> +#define BAR1_TTYVK_BASE(index)	(BAR1_TTYVK_BASE_OFFSET + \
>> +				 ((index) * BAR1_TTYVK_CHAN_OFFSET * 2))
>> +/* TO TTYVK channel base comes before FROM for each index */
>> +#define TO_TTYK_BASE(index)	BAR1_TTYVK_BASE(index)
>> +#define FROM_TTYK_BASE(index)	(BAR1_TTYVK_BASE(index) + \
>> +				 BAR1_TTYVK_CHAN_OFFSET)
>> +
>> +struct bcm_vk_tty_chan {
>> +	uint32_t reserved;
>> +	uint32_t size;
>> +	uint32_t wr;
>> +	uint32_t rd;
>> +	uint32_t *data;
>> +};
>> +
>> +#define VK_BAR_CHAN(v, DIR, e)	((v)->DIR##_offset \
>> +				 + offsetof(struct bcm_vk_tty_chan, e))
>> +#define VK_BAR_CHAN_SIZE(v, DIR)	VK_BAR_CHAN(v, DIR, size)
>> +#define VK_BAR_CHAN_WR(v, DIR)		VK_BAR_CHAN(v, DIR, wr)
>> +#define VK_BAR_CHAN_RD(v, DIR)		VK_BAR_CHAN(v, DIR, rd)
>> +#define VK_BAR_CHAN_DATA(v, DIR, off)	(VK_BAR_CHAN(v, DIR, data) + off)
>> +
>> +/* Poll every 1/10 of second - temp hack till we use MSI interrupt */
>> +#define SERIAL_TIMER_VALUE (HZ / 10)
>> +
>> +#if defined(BCM_VK_LEGACY_API)
>> +
>> +/* No support in legacy case, and do a dummy init and exit */
>> +int bcm_vk_tty_init(struct bcm_vk *vk, char *name)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +
>> +	dev_dbg(dev, "init %s\n", name);
>> +	return 0;
>> +}
>> +
>> +void bcm_vk_tty_exit(struct bcm_vk *vk)
>> +{
>> +	struct device *dev = &vk->pdev->dev;
>> +
>> +	dev_dbg(dev, "exit\n");
>> +}
>> +
>> +#else
>> +
>> +static void bcm_vk_tty_poll(struct timer_list *t)
>> +{
>> +	struct bcm_vk *vk = from_timer(vk, t, serial_timer);
>> +	struct bcm_vk_tty *vktty;
>> +	int card_status;
>> +	int ready_mask;
>> +	int count = 0;
>> +	unsigned char c;
>> +	int i;
>> +	int wr;
>> +
>> +	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
>> +
>> +	for (i = 0; i < BCM_VK_NUM_TTY; i++) {
>> +		/* Check the card status that the tty channel is ready */
>> +		ready_mask = BIT(i);
>> +		if ((card_status & ready_mask) == 0)
> Get rid of ready_mask and use BIT(i) directly.
>
>> +			continue;
>> +
>> +		vktty = &vk->tty[i];
>> +
>> +		/* Fetch the wr offset in buffer from VK */
>> +		wr = vkread32(vk, BAR_1, VK_BAR_CHAN_WR(vktty, from));
>> +		if (wr >= vktty->from_size) {
>> +			dev_err(&vk->pdev->dev,
>> +				"ERROR: poll ttyVK%d wr:0x%x > 0x%x\n",
>> +				i, wr, vktty->from_size);
>> +			/* Need to signal and close device in this case */
>> +			return;
>> +		}
>> +
>> +		/*
>> +		 * Simple read of circular buffer and
>> +		 * insert into tty flip buffer
>> +		 */
>> +		while (vk->tty[i].rd != wr) {
>> +			c = vkread8(vk, BAR_1,
>> +				    VK_BAR_CHAN_DATA(vktty, from, vktty->rd));
>> +			vktty->rd++;
>> +			if (vktty->rd >= vktty->from_size)
>> +				vktty->rd = 0;
>> +			tty_insert_flip_char(&vktty->port, c, TTY_NORMAL);
>> +			count++;
>> +		}
>> +	}
>> +
>> +	if (count) {
>> +		tty_flip_buffer_push(&vktty->port);
>> +
>> +		/* Update read offset from shadow register to card */
>> +		vkwrite32(vk, vktty->rd, BAR_1, VK_BAR_CHAN_RD(vktty, from));
>> +	}
>> +
>> +	mod_timer(&vk->serial_timer, jiffies + SERIAL_TIMER_VALUE);
>> +}
>> +
>> +static int bcm_vk_tty_open(struct tty_struct *tty, struct file *file)
>> +{
>> +	int card_status;
>> +	int ready_mask;
>> +	struct bcm_vk *vk;
>> +	struct bcm_vk_tty *vktty;
>> +	int index;
>> +
>> +	/* initialize the pointer in case something fails */
>> +	tty->driver_data = NULL;
>> +
>> +	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
>> +	index = tty->index;
>> +
>> +	if (index >= BCM_VK_NUM_TTY)
>> +		return -EINVAL;
>> +
>> +	vktty = &vk->tty[index];
>> +
>> +	vktty->to_offset = TO_TTYK_BASE(index);
>> +	vktty->from_offset = FROM_TTYK_BASE(index);
>> +
>> +	/* Do not allow tty device to be opened if tty on card not ready */
>> +	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
>> +	if (card_status == -1)
>> +		return -1;
>> +
>> +	ready_mask = BIT(index);
>> +	if ((card_status & ready_mask) == 0)
>> +		return -1;
>> +
>> +	/*
>> +	 * Get shadow registers of the buffer sizes and the "to" write offset
>> +	 * and "from" read offset
>> +	 */
>> +	vktty->to_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, to));
>> +	vktty->wr = vkread32(vk, BAR_1,  VK_BAR_CHAN_WR(vktty, to));
>> +	vktty->from_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, from));
>> +	vktty->rd = vkread32(vk, BAR_1,  VK_BAR_CHAN_RD(vktty, from));
>> +
>> +	if (tty->count == 1) {
>> +		timer_setup(&vk->serial_timer, bcm_vk_tty_poll, 0);
>> +		mod_timer(&vk->serial_timer, jiffies + SERIAL_TIMER_VALUE);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void bcm_vk_tty_close(struct tty_struct *tty, struct file *file)
>> +{
>> +	struct bcm_vk *vk;
>> +
>> +	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
>
> 	struct bcm_vk *vk = dev_get_drvdata(tty->dev);
>
>> +
>> +	if (tty->count == 1)
>> +		del_timer_sync(&vk->serial_timer);
>> +}
>> +
>> +static int bcm_vk_tty_write(struct tty_struct *tty,
>> +			    const unsigned char *buffer,
>> +			    int count)
>> +{
>> +	int index;
>> +	struct bcm_vk *vk;
>> +	struct bcm_vk_tty *vktty;
>> +	int i;
>> +	int retval;
>> +
>> +	index = tty->index;
>> +	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
> The cast is unnecessary.
>
>> +	vktty = &vk->tty[index];
>> +
>> +	/* Simple write each byte to circular buffer */
>> +	for (i = 0; i < count; i++) {
>> +		vkwrite8(vk,
>> +			 buffer[i],
>> +			 BAR_1,
>> +			 VK_BAR_CHAN_DATA(vktty, to, vktty->wr));
> 		vkwrite8(vk, buffer[i], BAR_1,
> 			 VK_BAR_CHAN_DATA(vktty, to, vktty->wr));
>
>
>> +		vktty->wr++;
>> +		if (vktty->wr >= vktty->to_size)
>> +			vktty->wr = 0;
>> +	}
>> +	/* Update write offset from shadow register to card */
>> +	/* TODO: Need to add write to doorbell here */
>> +	vkwrite32(vk, vktty->wr, BAR_1, VK_BAR_CHAN_WR(vktty, to));
>> +
>> +	retval = count;
>> +
>> +	return retval;
> Delete the "retval" variable.
>
>> +}
>> +
>> +static int bcm_vk_tty_write_room(struct tty_struct *tty)
>> +{
>> +	int room;
>> +	struct bcm_vk *vk;
>> +	struct bcm_vk_tty *vktty;
>> +
>> +	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
> Delete cast.
>
>> +	vktty = &vk->tty[tty->index];
>> +
>> +	/*
>> +	 * Calculate how much room is left in the device
>> +	 * Just return the size -1 of buffer.  We could care about
>> +	 * overflow but don't at this point.
>> +	 */
> This comment raises more questions than it answers.  Why would we care
> about overflow and why don't we at this point?  Perhaps just delete the
> comment.
>
>> +	room = vktty->to_size - 1;
>> +
>> +	return room;
> Delete the room variable and the vktty variable.
>
> 	return vk->tty[tty->index].to_size - 1;
>
>
>> +}
>> +
>> +static const struct tty_operations serial_ops = {
>> +	.open = bcm_vk_tty_open,
>> +	.close = bcm_vk_tty_close,
>> +	.write = bcm_vk_tty_write,
>> +	.write_room = bcm_vk_tty_write_room,
>> +};
>> +
>> +int bcm_vk_tty_init(struct bcm_vk *vk, char *name)
>> +{
>> +	int i;
>> +	int err;
>> +	unsigned long flags;
>> +	struct tty_driver *tty_drv;
>> +	struct device *dev = &vk->pdev->dev;
>> +
>> +	/* allocate the tty driver */
>> +	flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>> +	tty_drv = tty_alloc_driver(BCM_VK_NUM_TTY, flags);
> Delete the flags variable.
>
>> +
> Delete this blank line.
>
>> +	if (IS_ERR(tty_drv)) {
>> +		err = PTR_ERR(tty_drv);
>> +		goto err_exit;
>
> 		return PTR_ERR(tty_drv);
>
>> +	}
>> +	/* Save struct tty_driver for uninstalling the device */
>> +	vk->tty_drv = tty_drv;
>> +
>> +	/* initialize the tty driver */
>> +	tty_drv->driver_name = KBUILD_MODNAME;
>> +	tty_drv->name = kstrdup(name, GFP_KERNEL);
>> +	if (!tty_drv->name) {
>> +		err = -ENOMEM;
>> +		goto err_put_tty_driver;
>> +	}
>> +	tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>> +	tty_drv->subtype = SERIAL_TYPE_NORMAL;
>> +	tty_drv->init_termios = tty_std_termios;
>> +	tty_set_operations(tty_drv, &serial_ops);
>> +
>> +	/* register the tty driver */
>> +	err = tty_register_driver(tty_drv);
>> +	if (err) {
>> +		dev_err(dev, "tty_register_driver failed\n");
>> +		goto err_kfree_tty_name;
>> +	}
>> +
>> +	for (i = 0; i < BCM_VK_NUM_TTY; i++) {
>> +		struct device *tty_dev;
>> +
>> +		tty_port_init(&vk->tty[i].port);
>> +		tty_dev = tty_port_register_device(&vk->tty[i].port,
>> +						   tty_drv,
>> +						   i,
>> +						   dev);
> 		tty_dev = tty_port_register_device(&vk->tty[i].port, tty_drv,
> 						   i, dev);
>
>
>> +		dev_set_drvdata(tty_dev, vk);
>> +
>> +		if (IS_ERR(tty_dev)) {
> Calling dev_set_drvdata() before checking for IS_ERR().
>
>> +			int j;
>> +
>> +			for (j = 0; j < i; j++)
>> +				tty_port_unregister_device(&vk->tty[j].port,
>> +							   tty_drv,
>> +							   j);
>> +			goto err_tty_unregister_driver;
> No error code.
>
>> +		}
> 			if (IS_ERR(tty_dev)) {
> 				err = PTR_ERR(tty_dev);
> 				goto unwind;
> 			}
>
>> +	}
>> +
>> +	return 0;
>> +
> unwind:
> 	while (--i >= 0)
> 		tty_port_unregister_device(&vk->tty[i].port, tty_drv, i);
>
>
>> +err_tty_unregister_driver:
>> +	tty_unregister_driver(tty_drv);
>> +
>> +err_kfree_tty_name:
>> +	kfree(tty_drv->name);
>> +	tty_drv->name = NULL;
>> +
>> +err_put_tty_driver:
>> +	put_tty_driver(tty_drv);
>> +
>> +err_exit:
>> +	return err;
>> +}
>> +
>> +void bcm_vk_tty_exit(struct bcm_vk *vk)
>> +{
>> +	int i;
>> +
>> +	del_timer_sync(&vk->serial_timer);
>> +	for (i = 0; i < BCM_VK_NUM_TTY; ++i) {
>> +		tty_port_unregister_device(&vk->tty[i].port,
>> +					   vk->tty_drv,
>> +					   i);
>> +		tty_port_destroy(&vk->tty[i].port);
>> +	}
>> +	tty_unregister_driver(vk->tty_drv);
>> +	put_tty_driver(vk->tty_drv);
>> +
>> +	kfree(vk->tty_drv->name);
>                ^^^^^^^^^^^
>
> Use after free because of the put_tty_driver().  I think test again
> with CONFIG_PAGE_POISONING?
>
>> +	vk->tty_drv->name = NULL;
>> +}
> regards,
> dan carpenter
>


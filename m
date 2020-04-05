Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D4C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4643320659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="dGhFt2no";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJh6UAaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgDEW3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 18:29:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51783 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgDEW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 18:29:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B1F4C5C00BF;
        Sun,  5 Apr 2020 18:29:38 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 05 Apr 2020 18:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=bCjANU738Er17Glcxj8rL5DOaCrOT4q
        2/xWj2fjd36c=; b=dGhFt2noyBc2q3WP8eB3v3utCaDxxw4VGaDmQMrxwafQ9Ty
        Bf+i17U4OXm33IU2eVLANI/eOMhwphktciaDZjsqNqwYpEUkk/rW7SDKWfmNikUh
        94eVRRIto8SbV/M9P3h2rb82v9LDXQpWtRkzCMFtTVnJz83pejZwYTAvYVJsYwBS
        dFIwdhfHlio5bI37VOPWGmuE1cyO9wf1yA3k9YfLrRWpCL9EoOgC5Iw6Vjpmp+0A
        CYqJiUV1nk864vGTQ0zQhFBgYgYsHYuPdqfypEW1JO232jUCXesMnyA5nqT8eGU2
        EupfnbISOtcnNb9tI9TOJhd+/1Ps2+s1mRKtpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bCjANU
        738Er17Glcxj8rL5DOaCrOT4q2/xWj2fjd36c=; b=LJh6UAaXO08UFMupI5p8kO
        ky2AjbXwH0cT11uTkSnJPssImEv6qapKz89MS6giuthtqzEezi4ZS2fR6oT6A4Cy
        U4VDA2aEMJgzUoocpr6uF05jM7SDXASwOFhtIQ87ap/Jf7NW/qaiWF6/3kEiNPVK
        ACsaML1kBJUqu0OXLif2s0kWkPAHTIqzWWxJPkTCfXnTGtPrs65ya6dJtVVxAIsu
        SHDa024FfgRrlLmr2tE8UQiHq9JduKWw4BEln0/vog0HhYJDsahw30kxoE0yMvWB
        OLQHs1ffgJEGIKi6Erv9YMRLCvk6RsVRAmRtLV3Cwo3BhC7qwbElOVMFtbHORdwA
        ==
X-ME-Sender: <xms:0VuKXrSJi_7IZPrWx06TgLZRnH4vNvbmRUiaem8uH_7vd74XMwFViw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:0VuKXhBPNmoYzm7mfW1NqNAE_NnTKI9hpLiWey_47e3wHjwScRbsPw>
    <xmx:0VuKXr32kogyaad3HM824kDSU-VL8pB7wLf-wZ8vJHDUB5_Akt5bYw>
    <xmx:0VuKXvXle5uZYtVJKgHt5MZ5_1RnPvGZF0Ag4wZUbGxGid6SdkN3UQ>
    <xmx:0luKXqhPCCMG_qASjLMP5snoLyTohvookcd8WTLtUilZmSH1yf1f-Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 94AEFE00B1; Sun,  5 Apr 2020 18:29:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1082-g13d7805-fmstable-20200403v1
Mime-Version: 1.0
Message-Id: <82b4f2d3-e92f-45ba-8f0b-87e6afa52c10@www.fastmail.com>
In-Reply-To: <20200403162901.21106-3-eajames@linux.ibm.com>
References: <20200403162901.21106-1-eajames@linux.ibm.com>
 <20200403162901.21106-3-eajames@linux.ibm.com>
Date:   Mon, 06 Apr 2020 07:59:47 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Rob Herring" <robh+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v8 2/5] soc: aspeed: Add XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Apr 2020, at 02:58, Eddie James wrote:
> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> DMA operations between the SOC (acting as a BMC) and a host processor
> in a server.
> 
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Changes since v6:
>  - Switch to use a chunk of reserved memory from the devicetree rather than
>    simply reading the address and size
>  - Add PCI-E root complex reset
>  - Fix buffer overrun in aspeed_xdma_start
>  - Switch to usleep_range with a smaller time than the old msleep(10) because
>    that time is for toggling the clock, which we don't do during reset and
>    should be done by the clock driver anyway
>  - Set some additional bit in the SCU necessary for XDMA to work
>  - Refactor probe error handling near the end
> 
>  MAINTAINERS                      |   2 +
>  drivers/soc/aspeed/Kconfig       |   8 +
>  drivers/soc/aspeed/Makefile      |   1 +
>  drivers/soc/aspeed/aspeed-xdma.c | 842 +++++++++++++++++++++++++++++++
>  include/uapi/linux/aspeed-xdma.h |  38 ++
>  5 files changed, 891 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
>  create mode 100644 include/uapi/linux/aspeed-xdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dcc0907b2aa5..e417a15f33a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2776,6 +2776,8 @@ M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> +F:	drivers/soc/aspeed/aspeed-xdma.c
> +F:	include/uapi/linux/aspeed-xdma.h
>  
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index 323e177aa74d..2a6c16f9e50b 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -29,4 +29,12 @@ config ASPEED_P2A_CTRL
>  	  ioctl()s, the driver also provides an interface for userspace mappings to
>  	  a pre-defined region.
>  
> +config ASPEED_XDMA
> +	tristate "Aspeed XDMA Engine Driver"
> +	depends on SOC_ASPEED && REGMAP && MFD_SYSCON && HAS_DMA
> +	help
> +	  Enable support for the Aspeed XDMA Engine found on the Aspeed AST2XXX
> +	  SOCs. The XDMA engine can perform automatic PCI DMA operations
> +	  between the AST2XXX (acting as a BMC) and a host processor.
> +
>  endmenu
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index b64be47f2b1f..977b046dfb73 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
>  obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_ASPEED_P2A_CTRL)	+= aspeed-p2a-ctrl.o
> +obj-$(CONFIG_ASPEED_XDMA)	+= aspeed-xdma.o
> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> new file mode 100644
> index 000000000000..7503246c14d5
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> @@ -0,0 +1,842 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright IBM Corp 2019
> +
> +#include <linux/aspeed-xdma.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/fs.h>
> +#include <linux/genalloc.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/poll.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +
> +#define DEVICE_NAME				"aspeed-xdma"
> +
> +#define SCU_AST2600_MISC_CTRL			0x0c0
> +#define  SCU_AST2600_MISC_CTRL_XDMA_BMC		 BIT(8)
> +
> +#define SCU_AST2500_PCIE_CONF			0x180
> +#define SCU_AST2600_PCIE_CONF			0xc20
> +#define  SCU_PCIE_CONF_VGA_EN			 BIT(0)
> +#define  SCU_PCIE_CONF_VGA_EN_MMIO		 BIT(1)
> +#define  SCU_PCIE_CONF_VGA_EN_LPC		 BIT(2)
> +#define  SCU_PCIE_CONF_VGA_EN_MSI		 BIT(3)
> +#define  SCU_PCIE_CONF_VGA_EN_MCTP		 BIT(4)
> +#define  SCU_PCIE_CONF_VGA_EN_IRQ		 BIT(5)
> +#define  SCU_PCIE_CONF_VGA_EN_DMA		 BIT(6)
> +#define  SCU_PCIE_CONF_BMC_EN			 BIT(8)
> +#define  SCU_PCIE_CONF_BMC_EN_MMIO		 BIT(9)
> +#define  SCU_PCIE_CONF_BMC_EN_MSI		 BIT(11)
> +#define  SCU_PCIE_CONF_BMC_EN_MCTP		 BIT(12)
> +#define  SCU_PCIE_CONF_BMC_EN_IRQ		 BIT(13)
> +#define  SCU_PCIE_CONF_BMC_EN_DMA		 BIT(14)
> +
> +#define SCU_AST2500_BMC_CLASS_REV		0x19c
> +#define SCU_AST2600_BMC_CLASS_REV		0xc68
> +#define  SCU_BMC_CLASS_REV_XDMA			 0xff000001
> +
> +#define XDMA_CMDQ_SIZE				PAGE_SIZE
> +#define XDMA_NUM_CMDS				\
> +	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
> +
> +/* Aspeed specification requires 100us after disabling the reset */
> +#define XDMA_ENGINE_SETUP_TIME_MAX_US          1000
> +#define XDMA_ENGINE_SETUP_TIME_MIN_US          100
> +
> +#define XDMA_CMD_AST2500_PITCH_SHIFT		3
> +#define XDMA_CMD_AST2500_PITCH_BMC		GENMASK_ULL(62, 51)
> +#define XDMA_CMD_AST2500_PITCH_HOST		GENMASK_ULL(46, 35)
> +#define XDMA_CMD_AST2500_PITCH_UPSTREAM		BIT_ULL(31)
> +#define XDMA_CMD_AST2500_PITCH_ADDR		GENMASK_ULL(29, 4)
> +#define XDMA_CMD_AST2500_PITCH_ID		BIT_ULL(0)
> +#define XDMA_CMD_AST2500_CMD_IRQ_EN		BIT_ULL(31)
> +#define XDMA_CMD_AST2500_CMD_LINE_NO		GENMASK_ULL(27, 16)
> +#define XDMA_CMD_AST2500_CMD_IRQ_BMC		BIT_ULL(15)
> +#define XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT	4
> +#define XDMA_CMD_AST2500_CMD_LINE_SIZE		\
> +	GENMASK_ULL(14, XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT)
> +#define XDMA_CMD_AST2500_CMD_ID			BIT_ULL(1)
> +
> +#define XDMA_CMD_AST2600_PITCH_BMC		GENMASK_ULL(62, 48)
> +#define XDMA_CMD_AST2600_PITCH_HOST		GENMASK_ULL(46, 32)
> +#define XDMA_CMD_AST2600_PITCH_ADDR		GENMASK_ULL(30, 0)
> +#define XDMA_CMD_AST2600_CMD_64_EN		BIT_ULL(40)
> +#define XDMA_CMD_AST2600_CMD_IRQ_BMC		BIT_ULL(37)
> +#define XDMA_CMD_AST2600_CMD_IRQ_HOST		BIT_ULL(36)
> +#define XDMA_CMD_AST2600_CMD_UPSTREAM		BIT_ULL(32)
> +#define XDMA_CMD_AST2600_CMD_LINE_NO		GENMASK_ULL(27, 16)
> +#define XDMA_CMD_AST2600_CMD_LINE_SIZE		GENMASK_ULL(14, 0)
> +#define XDMA_CMD_AST2600_CMD_MULTILINE_SIZE	GENMASK_ULL(14, 12)
> +
> +#define XDMA_AST2500_QUEUE_ENTRY_SIZE		4
> +#define XDMA_AST2500_HOST_CMDQ_ADDR0		0x00
> +#define XDMA_AST2500_HOST_CMDQ_ENDP		0x04
> +#define XDMA_AST2500_HOST_CMDQ_WRITEP		0x08
> +#define XDMA_AST2500_HOST_CMDQ_READP		0x0c
> +#define XDMA_AST2500_BMC_CMDQ_ADDR		0x10
> +#define XDMA_AST2500_BMC_CMDQ_ENDP		0x14
> +#define XDMA_AST2500_BMC_CMDQ_WRITEP		0x18
> +#define XDMA_AST2500_BMC_CMDQ_READP		0x1c
> +#define  XDMA_BMC_CMDQ_READP_RESET		 0xee882266
> +#define XDMA_AST2500_CTRL			0x20
> +#define  XDMA_AST2500_CTRL_US_COMP		 BIT(4)
> +#define  XDMA_AST2500_CTRL_DS_COMP		 BIT(5)
> +#define  XDMA_AST2500_CTRL_DS_DIRTY		 BIT(6)
> +#define  XDMA_AST2500_CTRL_DS_SIZE_256		 BIT(17)
> +#define  XDMA_AST2500_CTRL_DS_TIMEOUT		 BIT(28)
> +#define  XDMA_AST2500_CTRL_DS_CHECK_ID		 BIT(29)
> +#define XDMA_AST2500_STATUS			0x24
> +#define  XDMA_AST2500_STATUS_US_COMP		 BIT(4)
> +#define  XDMA_AST2500_STATUS_DS_COMP		 BIT(5)
> +#define  XDMA_AST2500_STATUS_DS_DIRTY		 BIT(6)
> +#define XDMA_AST2500_INPRG_DS_CMD1		0x38
> +#define XDMA_AST2500_INPRG_DS_CMD2		0x3c
> +#define XDMA_AST2500_INPRG_US_CMD00		0x40
> +#define XDMA_AST2500_INPRG_US_CMD01		0x44
> +#define XDMA_AST2500_INPRG_US_CMD10		0x48
> +#define XDMA_AST2500_INPRG_US_CMD11		0x4c
> +#define XDMA_AST2500_INPRG_US_CMD20		0x50
> +#define XDMA_AST2500_INPRG_US_CMD21		0x54
> +#define XDMA_AST2500_HOST_CMDQ_ADDR1		0x60
> +#define XDMA_AST2500_VGA_CMDQ_ADDR0		0x64
> +#define XDMA_AST2500_VGA_CMDQ_ENDP		0x68
> +#define XDMA_AST2500_VGA_CMDQ_WRITEP		0x6c
> +#define XDMA_AST2500_VGA_CMDQ_READP		0x70
> +#define XDMA_AST2500_VGA_CMD_STATUS		0x74
> +#define XDMA_AST2500_VGA_CMDQ_ADDR1		0x78
> +
> +#define XDMA_AST2600_QUEUE_ENTRY_SIZE		2
> +#define XDMA_AST2600_HOST_CMDQ_ADDR0		0x00
> +#define XDMA_AST2600_HOST_CMDQ_ADDR1		0x04
> +#define XDMA_AST2600_HOST_CMDQ_ENDP		0x08
> +#define XDMA_AST2600_HOST_CMDQ_WRITEP		0x0c
> +#define XDMA_AST2600_HOST_CMDQ_READP		0x10
> +#define XDMA_AST2600_BMC_CMDQ_ADDR		0x14
> +#define XDMA_AST2600_BMC_CMDQ_ENDP		0x18
> +#define XDMA_AST2600_BMC_CMDQ_WRITEP		0x1c
> +#define XDMA_AST2600_BMC_CMDQ_READP		0x20
> +#define XDMA_AST2600_VGA_CMDQ_ADDR0		0x24
> +#define XDMA_AST2600_VGA_CMDQ_ADDR1		0x28
> +#define XDMA_AST2600_VGA_CMDQ_ENDP		0x2c
> +#define XDMA_AST2600_VGA_CMDQ_WRITEP		0x30
> +#define XDMA_AST2600_VGA_CMDQ_READP		0x34
> +#define XDMA_AST2600_CTRL			0x38
> +#define  XDMA_AST2600_CTRL_US_COMP		 BIT(16)
> +#define  XDMA_AST2600_CTRL_DS_COMP		 BIT(17)
> +#define  XDMA_AST2600_CTRL_DS_DIRTY		 BIT(18)
> +#define  XDMA_AST2600_CTRL_DS_SIZE_256		 BIT(20)
> +#define XDMA_AST2600_STATUS			0x3c
> +#define  XDMA_AST2600_STATUS_US_COMP		 BIT(16)
> +#define  XDMA_AST2600_STATUS_DS_COMP		 BIT(17)
> +#define  XDMA_AST2600_STATUS_DS_DIRTY		 BIT(18)
> +#define XDMA_AST2600_INPRG_DS_CMD00		0x40
> +#define XDMA_AST2600_INPRG_DS_CMD01		0x44
> +#define XDMA_AST2600_INPRG_DS_CMD10		0x48
> +#define XDMA_AST2600_INPRG_DS_CMD11		0x4c
> +#define XDMA_AST2600_INPRG_DS_CMD20		0x50
> +#define XDMA_AST2600_INPRG_DS_CMD21		0x54
> +#define XDMA_AST2600_INPRG_US_CMD00		0x60
> +#define XDMA_AST2600_INPRG_US_CMD01		0x64
> +#define XDMA_AST2600_INPRG_US_CMD10		0x68
> +#define XDMA_AST2600_INPRG_US_CMD11		0x6c
> +#define XDMA_AST2600_INPRG_US_CMD20		0x70
> +#define XDMA_AST2600_INPRG_US_CMD21		0x74
> +
> +struct aspeed_xdma_cmd {
> +	u64 host_addr;
> +	u64 pitch;
> +	u64 cmd;
> +	u64 reserved;
> +};
> +
> +struct aspeed_xdma_regs {
> +	u8 bmc_cmdq_addr;
> +	u8 bmc_cmdq_endp;
> +	u8 bmc_cmdq_writep;
> +	u8 bmc_cmdq_readp;
> +	u8 control;
> +	u8 status;
> +};
> +
> +struct aspeed_xdma_status_bits {
> +	u32 us_comp;
> +	u32 ds_comp;
> +	u32 ds_dirty;
> +};
> +
> +struct aspeed_xdma;
> +
> +struct aspeed_xdma_chip {
> +	u32 control;
> +	u32 scu_bmc_class;
> +	u32 scu_misc_ctrl;
> +	u32 scu_pcie_conf;
> +	unsigned int queue_entry_size;
> +	struct aspeed_xdma_regs regs;
> +	struct aspeed_xdma_status_bits status_bits;
> +	unsigned int (*set_cmd)(struct aspeed_xdma *ctx,
> +				struct aspeed_xdma_cmd cmds[2],
> +				struct aspeed_xdma_op *op, u32 bmc_addr);
> +};
> +
> +struct aspeed_xdma_client;
> +
> +struct aspeed_xdma {
> +	const struct aspeed_xdma_chip *chip;
> +
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *clock;
> +	struct reset_control *reset;
> +	struct reset_control *reset_rc;
> +
> +	/* Protects current_client */
> +	spinlock_t client_lock;
> +	struct aspeed_xdma_client *current_client;
> +
> +	/* Protects engine configuration */
> +	spinlock_t engine_lock;
> +	struct aspeed_xdma_cmd *cmdq;
> +	unsigned int cmd_idx;
> +	bool in_reset;
> +	bool upstream;
> +
> +	/* Queue waiters for idle engine */
> +	wait_queue_head_t wait;
> +
> +	struct work_struct reset_work;
> +
> +	u32 mem_phys;
> +	u32 mem_size;
> +	void __iomem *mem_virt;
> +	dma_addr_t cmdq_phys;
> +	struct gen_pool *pool;
> +};
> +
> +struct aspeed_xdma_client {
> +	struct aspeed_xdma *ctx;
> +
> +	bool error;
> +	bool in_progress;
> +	void *virt;
> +	dma_addr_t phys;
> +	u32 size;
> +};
> +
> +static u32 aspeed_xdma_readl(struct aspeed_xdma *ctx, u8 reg)
> +{
> +	u32 v = readl(ctx->base + reg);
> +
> +	dev_dbg(ctx->dev, "read %02x[%08x]\n", reg, v);
> +	return v;
> +}
> +
> +static void aspeed_xdma_writel(struct aspeed_xdma *ctx, u8 reg, u32 val)
> +{
> +	writel(val, ctx->base + reg);
> +	dev_dbg(ctx->dev, "write %02x[%08x]\n", reg, val);
> +}
> +
> +static void aspeed_xdma_init_eng(struct aspeed_xdma *ctx)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctx->engine_lock, flags);
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_endp,
> +			   ctx->chip->queue_entry_size * XDMA_NUM_CMDS);
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_readp,
> +			   XDMA_BMC_CMDQ_READP_RESET);
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_writep, 0);
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.control, ctx->chip->control);
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_addr, ctx->cmdq_phys);
> +
> +	ctx->cmd_idx = 0;
> +	spin_unlock_irqrestore(&ctx->engine_lock, flags);
> +}
> +
> +static unsigned int aspeed_xdma_ast2500_set_cmd(struct aspeed_xdma *ctx,
> +						struct aspeed_xdma_cmd cmds[2],
> +						struct aspeed_xdma_op *op,
> +						u32 bmc_addr)
> +{
> +	unsigned int rc = 1;
> +	unsigned int pitch = 1;
> +	unsigned int line_no = 1;
> +	unsigned int line_size = op->len >>
> +		XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
> +	u64 cmd = XDMA_CMD_AST2500_CMD_IRQ_EN | XDMA_CMD_AST2500_CMD_IRQ_BMC |
> +		XDMA_CMD_AST2500_CMD_ID;
> +	u64 cmd_pitch = (op->direction ? XDMA_CMD_AST2500_PITCH_UPSTREAM : 0) |
> +		XDMA_CMD_AST2500_PITCH_ID;
> +
> +	dev_dbg(ctx->dev, "xdma %s ast2500: bmc[%08x] len[%08x] host[%08x]\n",
> +		op->direction ? "upstream" : "downstream", bmc_addr, op->len,
> +		(u32)op->host_addr);
> +
> +	if (op->len > XDMA_CMD_AST2500_CMD_LINE_SIZE) {
> +		unsigned int rem;
> +		unsigned int total;
> +
> +		line_no = op->len / XDMA_CMD_AST2500_CMD_LINE_SIZE;
> +		total = XDMA_CMD_AST2500_CMD_LINE_SIZE * line_no;
> +		rem = (op->len - total) >>
> +			XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
> +		line_size = XDMA_CMD_AST2500_CMD_LINE_SIZE;
> +		pitch = line_size >> XDMA_CMD_AST2500_PITCH_SHIFT;
> +		line_size >>= XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
> +
> +		if (rem) {
> +			u32 rbmc = bmc_addr + total;
> +
> +			cmds[1].host_addr = op->host_addr + (u64)total;
> +			cmds[1].pitch = cmd_pitch |
> +				((u64)rbmc & XDMA_CMD_AST2500_PITCH_ADDR) |
> +				FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, 1) |
> +				FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, 1);
> +			cmds[1].cmd = cmd |
> +				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, 1) |
> +				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE,
> +					   rem);
> +			cmds[1].reserved = 0ULL;
> +
> +			print_hex_dump_debug("xdma rem ", DUMP_PREFIX_OFFSET,
> +					     16, 1, &cmds[1], sizeof(*cmds),
> +					     true);
> +
> +			cmd &= ~(XDMA_CMD_AST2500_CMD_IRQ_EN |
> +				 XDMA_CMD_AST2500_CMD_IRQ_BMC);
> +
> +			rc++;
> +		}
> +	}
> +
> +	cmds[0].host_addr = op->host_addr;
> +	cmds[0].pitch = cmd_pitch |
> +		((u64)bmc_addr & XDMA_CMD_AST2500_PITCH_ADDR) |
> +		FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, pitch) |
> +		FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, pitch);
> +	cmds[0].cmd = cmd | FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, line_no) |
> +		FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE, line_size);
> +	cmds[0].reserved = 0ULL;
> +
> +	print_hex_dump_debug("xdma cmd ", DUMP_PREFIX_OFFSET, 16, 1, cmds,
> +			     sizeof(*cmds), true);
> +
> +	return rc;
> +}
> +
> +static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
> +						struct aspeed_xdma_cmd cmds[2],
> +						struct aspeed_xdma_op *op,
> +						u32 bmc_addr)
> +{
> +	unsigned int rc = 1;
> +	unsigned int pitch = 1;
> +	unsigned int line_no = 1;
> +	unsigned int line_size = op->len;
> +	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
> +		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
> +
> +	if (op->host_addr & 0xffffffff00000000ULL ||
> +	    (op->host_addr + (u64)op->len) & 0xffffffff00000000ULL)
> +		cmd |= XDMA_CMD_AST2600_CMD_64_EN;
> +
> +	dev_dbg(ctx->dev, "xdma %s ast2600: bmc[%08x] len[%08x] "
> +		"host[%016llx]\n", op->direction ? "upstream" : "downstream",
> +		bmc_addr, op->len, op->host_addr);
> +
> +	if (op->len > XDMA_CMD_AST2600_CMD_LINE_SIZE) {
> +		unsigned int rem;
> +		unsigned int total;
> +
> +		line_no = op->len / XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
> +		total = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE * line_no;
> +		rem = op->len - total;
> +		line_size = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
> +		pitch = line_size;
> +
> +		if (rem) {
> +			u32 rbmc = bmc_addr + total;
> +
> +			cmds[1].host_addr = op->host_addr + (u64)total;
> +			cmds[1].pitch =
> +				((u64)rbmc & XDMA_CMD_AST2600_PITCH_ADDR) |
> +				FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, 1) |
> +				FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, 1);
> +			cmds[1].cmd = cmd |
> +				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, 1) |
> +				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE,
> +					   rem);
> +			cmds[1].reserved = 0ULL;
> +
> +			print_hex_dump_debug("xdma rem ", DUMP_PREFIX_OFFSET,
> +					     16, 1, &cmds[1], sizeof(*cmds),
> +					     true);
> +
> +			cmd &= ~XDMA_CMD_AST2600_CMD_IRQ_BMC;
> +
> +			rc++;
> +		}
> +	}
> +
> +	cmds[0].host_addr = op->host_addr;
> +	cmds[0].pitch = ((u64)bmc_addr & XDMA_CMD_AST2600_PITCH_ADDR) |
> +		FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, pitch) |
> +		FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, pitch);
> +	cmds[0].cmd = cmd | FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, line_no) |
> +		FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE, line_size);
> +	cmds[0].reserved = 0ULL;
> +
> +	print_hex_dump_debug("xdma cmd ", DUMP_PREFIX_OFFSET, 16, 1, cmds,
> +			     sizeof(*cmds), true);
> +
> +	return rc;
> +}
> +
> +static int aspeed_xdma_start(struct aspeed_xdma *ctx, unsigned int num_cmds,
> +			     struct aspeed_xdma_cmd cmds[2], bool upstream,
> +			     struct aspeed_xdma_client *client)
> +{
> +	unsigned int i;
> +	int rc = -EBUSY;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctx->engine_lock, flags);
> +	if (ctx->in_reset)
> +		goto unlock;
> +
> +	spin_lock(&ctx->client_lock);
> +	if (ctx->current_client) {
> +		spin_unlock(&ctx->client_lock);
> +		goto unlock;
> +	}
> +
> +	client->error = false;
> +	client->in_progress = true;
> +	ctx->current_client = client;
> +	spin_unlock(&ctx->client_lock);
> +
> +	for (i = 0; i < num_cmds; ++i) {
> +		memcpy(&ctx->cmdq[ctx->cmd_idx], &cmds[i],
> +		       sizeof(struct aspeed_xdma_cmd));
> +		ctx->cmd_idx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
> +	}
> +	ctx->upstream = upstream;
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_writep,
> +			   ctx->cmd_idx * ctx->chip->queue_entry_size);
> +	rc = 0;
> +
> +unlock:
> +	spin_unlock_irqrestore(&ctx->engine_lock, flags);
> +	return rc;
> +}
> +
> +static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctx->client_lock, flags);
> +	if (ctx->current_client) {
> +		ctx->current_client->error = error;
> +		ctx->current_client->in_progress = false;
> +		ctx->current_client = NULL;
> +	}
> +	spin_unlock_irqrestore(&ctx->client_lock, flags);
> +
> +	wake_up_interruptible_all(&ctx->wait);
> +}
> +
> +static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
> +{
> +	struct aspeed_xdma *ctx = arg;
> +	u32 status;
> +
> +	spin_lock(&ctx->engine_lock);
> +	status = aspeed_xdma_readl(ctx, ctx->chip->regs.status);
> +
> +	if (status & ctx->chip->status_bits.ds_dirty) {
> +		aspeed_xdma_done(ctx, true);
> +	} else {
> +		if (status & ctx->chip->status_bits.us_comp) {
> +			if (ctx->upstream)
> +				aspeed_xdma_done(ctx, false);
> +		}
> +
> +		if (status & ctx->chip->status_bits.ds_comp) {
> +			if (!ctx->upstream)
> +				aspeed_xdma_done(ctx, false);
> +		}
> +	}
> +
> +	aspeed_xdma_writel(ctx, ctx->chip->regs.status, status);
> +	spin_unlock(&ctx->engine_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void aspeed_xdma_reset(struct aspeed_xdma *ctx)
> +{
> +	unsigned long flags;
> +
> +	reset_control_assert(ctx->reset);
> +	usleep_range(XDMA_ENGINE_SETUP_TIME_MIN_US,
> +		     XDMA_ENGINE_SETUP_TIME_MAX_US);
> +	reset_control_deassert(ctx->reset);
> +	usleep_range(XDMA_ENGINE_SETUP_TIME_MIN_US,
> +		     XDMA_ENGINE_SETUP_TIME_MAX_US);
> +
> +	aspeed_xdma_init_eng(ctx);
> +
> +	aspeed_xdma_done(ctx, true);
> +
> +	spin_lock_irqsave(&ctx->engine_lock, flags);
> +	ctx->in_reset = false;
> +	spin_unlock_irqrestore(&ctx->engine_lock, flags);
> +
> +	wake_up_interruptible(&ctx->wait);
> +}
> +
> +static void aspeed_xdma_reset_work(struct work_struct *work)
> +{
> +	struct aspeed_xdma *ctx = container_of(work, struct aspeed_xdma,
> +					       reset_work);
> +
> +	aspeed_xdma_reset(ctx);
> +}
> +
> +static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
> +{
> +	struct aspeed_xdma *ctx = arg;
> +
> +	dev_dbg(ctx->dev, "PCI-E reset requested.\n");
> +
> +	spin_lock(&ctx->engine_lock);
> +	if (ctx->in_reset) {
> +		spin_unlock(&ctx->engine_lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ctx->in_reset = true;
> +	spin_unlock(&ctx->engine_lock);
> +
> +	schedule_work(&ctx->reset_work);
> +	return IRQ_HANDLED;
> +}
> +
> +static int aspeed_xdma_init_scu(struct aspeed_xdma *ctx, struct device *dev)
> +{
> +	struct regmap *scu = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
> +
> +	if (!IS_ERR(scu)) {
> +		u32 selection;
> +		bool pcie_device_bmc = true;
> +		const u32 bmc = SCU_PCIE_CONF_BMC_EN |
> +			SCU_PCIE_CONF_BMC_EN_MSI | SCU_PCIE_CONF_BMC_EN_IRQ |
> +			SCU_PCIE_CONF_BMC_EN_DMA;
> +		const u32 vga = SCU_PCIE_CONF_VGA_EN |
> +			SCU_PCIE_CONF_VGA_EN_MSI | SCU_PCIE_CONF_VGA_EN_IRQ |
> +			SCU_PCIE_CONF_VGA_EN_DMA;
> +		const char *pcie = NULL;
> +
> +		if (!of_property_read_string(dev->of_node, "pcie-device",
> +					     &pcie)) {
> +			if (!strcmp(pcie, "vga")) {
> +				pcie_device_bmc = false;
> +			} else if (strcmp(pcie, "bmc")) {
> +				dev_err(dev,
> +					"Invalid pcie-device property %s.\n",
> +					pcie);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (pcie_device_bmc) {
> +			selection = bmc;
> +			regmap_write(scu, ctx->chip->scu_bmc_class,
> +				     SCU_BMC_CLASS_REV_XDMA);
> +		} else {
> +			selection = vga;
> +		}
> +
> +		regmap_update_bits(scu, ctx->chip->scu_pcie_conf, bmc | vga,
> +				   selection);
> +
> +		if (ctx->chip->scu_misc_ctrl)
> +			regmap_update_bits(scu, ctx->chip->scu_misc_ctrl,
> +					   SCU_AST2600_MISC_CTRL_XDMA_BMC,
> +					   SCU_AST2600_MISC_CTRL_XDMA_BMC);
> +	} else {
> +		dev_warn(dev, "Unable to configure PCIe: %ld; continuing.\n",
> +			 PTR_ERR(scu));
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_xdma_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	int irq;
> +	int pcie_irq;
> +	struct aspeed_xdma *ctx;
> +	struct reserved_mem *mem;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *memory_region;
> +	const void *md = of_device_get_match_data(dev);
> +
> +	if (!md)
> +		return -ENODEV;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->chip = md;
> +	ctx->dev = dev;
> +	platform_set_drvdata(pdev, ctx);
> +	spin_lock_init(&ctx->client_lock);
> +	spin_lock_init(&ctx->engine_lock);
> +	INIT_WORK(&ctx->reset_work, aspeed_xdma_reset_work);
> +	init_waitqueue_head(&ctx->wait);
> +
> +	ctx->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ctx->base)) {
> +		dev_err(dev, "Failed to map registers.\n");
> +		return PTR_ERR(ctx->base);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "Failed to find IRQ.\n");
> +		return irq;
> +	}
> +
> +	rc = devm_request_irq(dev, irq, aspeed_xdma_irq, 0, DEVICE_NAME, ctx);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to request IRQ %d.\n", irq);
> +		return rc;
> +	}
> +
> +	ctx->clock = devm_clk_get(dev, NULL);
> +	if (IS_ERR(ctx->clock)) {
> +		dev_err(dev, "Failed to request clock.\n");
> +		return PTR_ERR(ctx->clock);
> +	}
> +
> +	ctx->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(ctx->reset)) {
> +		dev_err(dev, "Failed to request reset control.\n");
> +		return PTR_ERR(ctx->reset);
> +	}
> +
> +	ctx->reset_rc = devm_reset_control_get_exclusive(dev, "rc");
> +	if (IS_ERR(ctx->reset_rc)) {
> +		dev_dbg(dev, "Failed to request reset RC control.\n");
> +		ctx->reset_rc = NULL;
> +	}
> +
> +	ctx->pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
> +	if (!ctx->pool) {
> +		dev_err(dev, "Failed to setup genalloc pool.\n");
> +		return -ENOMEM;
> +	}
> +
> +	memory_region = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!memory_region) {
> +		dev_err(dev, "Failed to find memory-region.\n");
> +		return -ENOMEM;
> +	}
> +
> +	mem = of_reserved_mem_lookup(memory_region);
> +	of_node_put(memory_region);
> +	if (!mem) {
> +		dev_err(dev, "Failed to find reserved memory.\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctx->mem_phys = mem->base;
> +	ctx->mem_size = mem->size;
> +
> +	ctx->mem_virt = devm_ioremap(dev, ctx->mem_phys, ctx->mem_size);

This isn't _really_ the right thing to do and there were complaints that it was
causing issues under qemu wrt MT_DEVICE. I'll do some experiments with
the DMA API.

Andrew

Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A2920888
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597843929;
	bh=IQ4RWF52YDcdUV3DlmmWYMd5P5ziSTioHBQV8osjXIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IhtnWqW2Rl4IucD+ffqIjK0NUEyyM0CgjgaivJW5sjWG6tPHdMv0aZDJo/3gadAnd
	 3LwuGLBr3f/8hJuihO7BRoPaQgmfjSUtCq1kfpjpooPnMifaEfpknzyaz8l8LoUYfS
	 25Nz8EPsuM19nzJc1joZiTpj5xbANiVJH8PrBu5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHSNcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHSNb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:31:57 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8089A2083B;
        Wed, 19 Aug 2020 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597843914;
        bh=IQ4RWF52YDcdUV3DlmmWYMd5P5ziSTioHBQV8osjXIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSSaWF42s3vhygdk2zx6U2zim5wNjX+Ljl/kzwl/hxAATP78oBs6JLlpjW0cExcI7
         7tse6Ka/vYLCqUzUjenpKtqBTvJz3xtpzN7JuA1b2Wyht0gOs5v0aZfWTfitc4GawM
         7t7V9XnznXcMUKjzXYRHO3AMoMqloF6ClY5Nq1W8=
Date:   Wed, 19 Aug 2020 21:31:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     franck.lenormand@oss.nxp.com, Arnd Bergmann <arnd@arndb.de>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: Re: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver
Message-ID: <20200819133136.GB7114@dragon>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-6-git-send-email-franck.lenormand@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595344835-67746-6-git-send-email-franck.lenormand@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:20:35PM +0200, franck.lenormand@oss.nxp.com wrote:
> From: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> 
> The SNVS is a hardware component in the imx8 SoC. One of its
> function is to detect hardware attacks, in which case it creates
> a SECurity VIOlation.
> 
> This patch adds the support for the reception of these secvio and
> report it to the audit framework.
> 
> It also gives the possibility to perform custom processing when a
> secvio is detected.
> 
> Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/soc/imx/Kconfig                     |  10 +
>  drivers/soc/imx/Makefile                    |   1 +
>  drivers/soc/imx/secvio/Kconfig              |  10 +
>  drivers/soc/imx/secvio/Makefile             |   3 +
>  drivers/soc/imx/secvio/imx-secvio-audit.c   |  39 ++
>  drivers/soc/imx/secvio/imx-secvio-debugfs.c | 379 ++++++++++++
>  drivers/soc/imx/secvio/imx-secvio-sc-int.h  |  84 +++
>  drivers/soc/imx/secvio/imx-secvio-sc.c      | 858 ++++++++++++++++++++++++++++
>  include/soc/imx/imx-secvio-sc.h             | 177 ++++++
>  9 files changed, 1561 insertions(+)
>  create mode 100644 drivers/soc/imx/secvio/Kconfig
>  create mode 100644 drivers/soc/imx/secvio/Makefile
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-audit.c
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
>  create mode 100644 include/soc/imx/imx-secvio-sc.h

Hi Arnd,

Do we have any subsystem to accommodate this driver?  Or 'soc' is just
the right place for it?

Shawn

> 
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index a9370f4..6c1bc78 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -19,4 +19,14 @@ config SOC_IMX8M
>  	  support, it will provide the SoC info like SoC family,
>  	  ID and revision etc.
>  
> +config SECVIO_SC
> +        tristate "NXP SC secvio support"
> +        depends on IMX_SCU
> +        help
> +           If you say yes here you get support for the NXP SNVS security
> +           violation module. It includes the possibility to read information
> +           related to security violations and tampers. It also gives the
> +           possibility to register user callbacks when a security violation
> +           occurs.
> +
>  endmenu
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 078dc91..c91a499 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -5,3 +5,4 @@ endif
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>  obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> +obj-${CONFIG_SECVIO_SC} += secvio/
> diff --git a/drivers/soc/imx/secvio/Kconfig b/drivers/soc/imx/secvio/Kconfig
> new file mode 100644
> index 0000000..dcfaea5
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/Kconfig
> @@ -0,0 +1,10 @@
> +config SECVIO_SC
> +        tristate "NXP SC secvio support"
> +        depends on IMX_SCU
> +        help
> +           If you say yes here you get support for the NXP SNVS security
> +           violation module. It includes the possibility to read information
> +           related to security violations and tampers. It also gives the
> +           possibility to register user callbacks when a security violation
> +           occurs.
> +
> diff --git a/drivers/soc/imx/secvio/Makefile b/drivers/soc/imx/secvio/Makefile
> new file mode 100644
> index 0000000..d5a89ba
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/Makefile
> @@ -0,0 +1,3 @@
> +obj-y +=  imx-secvio-sc.o
> +obj-$(CONFIG_DEBUG_FS) += imx-secvio-debugfs.o
> +obj-$(CONFIG_AUDIT) += imx-secvio-audit.o
> diff --git a/drivers/soc/imx/secvio/imx-secvio-audit.c b/drivers/soc/imx/secvio/imx-secvio-audit.c
> new file mode 100644
> index 0000000..dc96e16
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-audit.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +#include <linux/audit.h>
> +
> +#include <soc/imx/imx-secvio-sc.h>
> +
> +/**
> + * report_to_audit_notify() - Report secvio and tamper status to audit FW
> + *
> + * This function can be chained in a notifier list
> + *
> + * @nb: notifier block
> + * @status: error code
> + * @notif_info: Pointer on secvio_sc_notifier_info structure
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int report_to_audit_notify(struct notifier_block *nb, unsigned long status,
> +			   void *notif_info)
> +{
> +	struct audit_buffer *ab;
> +	struct secvio_sc_notifier_info *info = notif_info;
> +
> +	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_INTEGRITY_RULE);
> +	if (!ab)
> +		return -ENOMEM;
> +
> +	audit_log_format(ab, " hpsvs=0x%.08x lps=0x%.08x lptds=0x%.08x",
> +			 info->hpsvs, info->lps, info->lptds);
> +	audit_log_task_info(ab);
> +	audit_log_end(ab);
> +
> +	return 0;
> +}
> diff --git a/drivers/soc/imx/secvio/imx-secvio-debugfs.c b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
> new file mode 100644
> index 0000000..bcbd77a
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +/*
> + * The module exposes 3 files in debugfs:
> + *  - secvio/info:
> + *      * Read: It returns the value of the fuses and SNVS registers which are
> + *              readable and related to secvio and tampers
> + *      * Write: A write of the format "<hex id> [<hex value 0> <hex value 1>
> + *               <hex value 2> <hex value 3> <hex value 4>](<nb values>)"
> + *               will write the SNVS register having the provided id with the
> + *               values provided (cf SECO documentation)
> + *  - secvio/enable: State of the IRQ
> + *  - secvio/check: Check the state of the security violation and tampers
> + *                  and calls notifier
> + *  - secvio/clear: Clear the state of all secvio and tampers
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
> +#include <linux/nvmem-consumer.h>
> +
> +#include <linux/firmware/imx/svc/misc.h>
> +#include <linux/firmware/imx/svc/seco.h>
> +
> +#include <soc/imx/imx-secvio-sc.h>
> +#include "imx-secvio-sc-int.h"
> +
> +/**
> + * fuse_reader() - Read a set of fuse
> + *
> + * @dev: secvio device
> + * @id: offset of the fuse
> + * @value: array of values read
> + * @mul: number of fuse to read
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int fuse_reader(struct device *dev, u32 id, u32 *value, u8 mul)
> +{
> +	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
> +	u32 size_to_read = mul * sizeof(u32);
> +	int ret;
> +
> +	ret = nvmem_device_read(data->nvmem, id, size_to_read, value);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read fuse %d: %d\n", id, ret);
> +		return ret;
> +	}
> +
> +	if (ret != size_to_read) {
> +		dev_err(data->dev, "Read only %d instead of %d\n", ret,
> +			size_to_read);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * snvs_reader() - Read a set of SNVS register
> + *
> + * @dev: secvio device
> + * @id: offset of the register
> + * @value: array of values read
> + * @mul: number of registers to read
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int snvs_reader(struct device *dev, u32 id, u32 *value, u8 mul)
> +{
> +	int ret;
> +	u32 *v1, *v2, *v3, *v4, *v5;
> +
> +	v1 = NULL;
> +	v2 = NULL;
> +	v3 = NULL;
> +	v4 = NULL;
> +	v5 = NULL;
> +
> +	switch (mul) {
> +	case 5:
> +		v5 = &value[4];
> +		fallthrough;
> +	case 4:
> +		v4 = &value[3];
> +		fallthrough;
> +	case 3:
> +		v3 = &value[2];
> +		fallthrough;
> +	case 2:
> +		v2 = &value[1];
> +		fallthrough;
> +	case 1:
> +		v1 = &value[0];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = call_secvio_config(dev, id, SECVIO_CONFIG_READ, v1, v2, v3, v4,
> +				 v5, mul);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to read snvs reg %d: %d\n", id, ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * snvs_dgo_reader() - Read a set of DGO register
> + *
> + * @dev: secvio device
> + * @id: offset of the register
> + * @value: array of values read
> + * @mul: number of registers to read
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int snvs_dgo_reader(struct device *dev, u32 id, u32 *value, u8 mul)
> +{
> +	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* We check that we only have 1 register to read */
> +	if (mul != 1)
> +		return -EINVAL;
> +
> +	ret = imx_sc_seco_secvio_dgo_config(data->ipc_handle, id,
> +					    SECVIO_CONFIG_READ, value);
> +	if (ret)
> +		dev_err(dev, "Failed to read snvs dgo reg %d: %d\n", id, ret);
> +
> +	return ret;
> +}
> +
> +static const struct imx_secvio_info_entry {
> +	int (*reader)(struct device *dev, u32 id, u32 *value, u8 mul);
> +	const char *type;
> +	const char *name;
> +	u32 id;
> +	u8 mul;
> +} gs_imx_secvio_info_list[] = {
> +	{fuse_reader, "fuse", "trim", 30, 1},
> +	{fuse_reader, "fuse", "trim2", 31, 1},
> +	{fuse_reader, "fuse", "ctrim1", 260, 1},
> +	{fuse_reader, "fuse", "ctrim2", 261, 1},
> +	{fuse_reader, "fuse", "ctrim3", 262, 1},
> +	{fuse_reader, "fuse", "ctrim4", 263, 1},
> +	{fuse_reader, "fuse", "OSC_CAP", 768, 1},
> +
> +	{snvs_reader, "snvs", "HPLR",    0x0, 1},
> +	{snvs_reader, "snvs", "LPLR",    0x34, 1},
> +	{snvs_reader, "snvs", "HPSICR",  0xc, 1},
> +	{snvs_reader, "snvs", "HPSVCR",  0x10, 1},
> +	{snvs_reader, "snvs", "HPSVS",   0x18, 1},
> +	{snvs_reader, "snvs", "LPSVC",   0x40, 1},
> +	{snvs_reader, "snvs", "LPTDC",   0x48, 2},
> +	{snvs_reader, "snvs", "LPSR",    0x4c, 1},
> +	{snvs_reader, "snvs", "LPTDS",   0xa4, 1},
> +	{snvs_reader, "snvs", "LPTGFC",  0x44, 3},
> +	{snvs_reader, "snvs", "LPATCTL", 0xe0, 1},
> +	{snvs_reader, "snvs", "LPATCLK", 0xe4, 1},
> +	{snvs_reader, "snvs", "LPATRC1", 0xe8, 2},
> +	{snvs_reader, "snvs", "LPMKC",   0x3c, 1},
> +	{snvs_reader, "snvs", "LPSMC",   0x5c, 2},
> +	{snvs_reader, "snvs", "LPPGD",   0x64, 1},
> +	{snvs_reader, "snvs", "HPVID",   0xf8, 2},
> +
> +	{snvs_dgo_reader, "dgo", "Offset",  0x0, 1},
> +	{snvs_dgo_reader, "dgo", "PUP/PD",  0x10, 1},
> +	{snvs_dgo_reader, "dgo", "Anatest", 0x20, 1},
> +	{snvs_dgo_reader, "dgo", "T trim",  0x30, 1},
> +	{snvs_dgo_reader, "dgo", "Misc",    0x40, 1},
> +	{snvs_dgo_reader, "dgo", "Vmon",    0x50, 1},
> +};
> +
> +struct imx_secvio_sc_info_seq_data {
> +	struct device *dev;
> +	const struct imx_secvio_info_entry *list;
> +	int size;
> +};
> +
> +/**
> + * imx_secvio_sc_info_seq_start() - Start sequence
> + *
> + * @m: seq file
> + * @pos: position in the sequence
> + *
> + * Return pointer on position
> + */
> +static void *imx_secvio_sc_info_seq_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct imx_secvio_sc_info_seq_data *data = m->private;
> +
> +	/* Check we are not out of bound */
> +	if (*pos >= data->size)
> +		return NULL;
> +
> +	return (void *)pos;
> +}
> +
> +/**
> + * imx_secvio_sc_info_seq_next() - Iterate sequence
> + *
> + * @m: seq file
> + * @v: pointer
> + * @pos: position in the sequence
> + *
> + * Return pointer on position
> + */
> +static void *imx_secvio_sc_info_seq_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	/* Increment the counter */
> +	++*pos;
> +
> +	/* call the start function which will check the index */
> +	return imx_secvio_sc_info_seq_start(m, pos);
> +}
> +
> +/**
> + * imx_secvio_sc_info_seq_stop() - Stop sequence
> + *
> + * @m: seq file
> + * @v: pointer
> + */
> +static void imx_secvio_sc_info_seq_stop(struct seq_file *m, void *v)
> +{
> +}
> +
> +/**
> + * imx_secvio_sc_info_seq_show() - Show the item in the sequence
> + *
> + * @m: seq file
> + * @v: pointer
> + * @pos: position in the sequence
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_info_seq_show(struct seq_file *m, void *v)
> +{
> +	struct imx_secvio_sc_info_seq_data *data = m->private;
> +	const struct imx_secvio_info_entry *e;
> +	int ret;
> +	u32 vals[5];
> +	int idx;
> +
> +	idx = *(loff_t *)v;
> +	e = &data->list[idx];
> +
> +	/* Read the values */
> +	ret = e->reader(data->dev, e->id, (u32 *)&vals, e->mul);
> +	if (ret) {
> +		dev_err(data->dev, "Fail to read %s %s (idx %d)\n", e->type,
> +			e->name, e->id);
> +		return 0;
> +	}
> +
> +	seq_printf(m, "%5s/%-10s(%.3d):", e->type, e->name, e->id);
> +
> +	/* Loop over the values */
> +	for (idx = 0; idx < e->mul; idx++)
> +		seq_printf(m, " %.8x", vals[idx]);
> +
> +	seq_puts(m, "\n");
> +
> +	return 0;
> +}
> +
> +static const struct seq_operations imx_secvio_sc_info_seq_ops = {
> +	.start = imx_secvio_sc_info_seq_start,
> +	.next  = imx_secvio_sc_info_seq_next,
> +	.stop  = imx_secvio_sc_info_seq_stop,
> +	.show  = imx_secvio_sc_info_seq_show,
> +};
> +
> +/**
> + * imx_secvio_sc_info_open() - Store node info for ioctl
> + *
> + * @inode: inode
> + * @file: file used to perform the ioctl
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_info_open(struct inode *inode, struct file *file)
> +{
> +	struct imx_secvio_sc_info_seq_data *data;
> +
> +	data = __seq_open_private(file, &imx_secvio_sc_info_seq_ops, sizeof(*data));
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = inode->i_private;
> +	data->list = gs_imx_secvio_info_list;
> +	data->size = ARRAY_SIZE(gs_imx_secvio_info_list);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations imx_secvio_sc_info_ops = {
> +	.owner = THIS_MODULE,
> +	.open = imx_secvio_sc_info_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = seq_release_private,
> +};
> +
> +/**
> + * if_debugfs_remove_recursive() - Wrapper for debugfs_remove_recursive
> + *
> + * Can be used with devm
> + *
> + * @dentry: directory entry
> + */
> +static void if_debugfs_remove_recursive(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
> +/**
> + * imx_secvio_sc_debugfs() - Create the debugfs
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int imx_secvio_sc_debugfs(struct device *dev)
> +{
> +	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
> +	struct dentry *dir;
> +	int ret = 0;
> +
> +	/* Create a folder */
> +	dir = debugfs_create_dir(dev_name(dev), NULL);
> +	if (IS_ERR(dir)) {
> +		dev_err(dev, "Failed to create dfs dir\n");
> +		ret = PTR_ERR(dir);
> +		goto exit;
> +	}
> +	data->dfs = dir;
> +
> +	ret = devm_add_action(dev, if_debugfs_remove_recursive, data->dfs);
> +	if (ret) {
> +		dev_err(dev, "Failed to add managed action to disable IRQ\n");
> +		goto remove_fs;
> +	}
> +
> +	/* Create the file to read info and write to reg */
> +	dir = debugfs_create_file("info", 0x666, data->dfs, dev,
> +				  &imx_secvio_sc_info_ops);
> +	if (IS_ERR(dir)) {
> +		dev_err(dev, "Failed to add info to debugfs\n");
> +		ret = PTR_ERR(dir);
> +		goto exit;
> +	}
> +
> +	goto exit;
> +
> +remove_fs:
> +	debugfs_remove_recursive(data->dfs);
> +
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/soc/imx/secvio/imx-secvio-sc-int.h b/drivers/soc/imx/secvio/imx-secvio-sc-int.h
> new file mode 100644
> index 0000000..54de7fa
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-sc-int.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +#ifndef SECVIO_SC_H
> +#define SECVIO_SC_H
> +
> +/* Includes */
> +#include <linux/kernel.h>
> +#include <linux/notifier.h>
> +#include <linux/semaphore.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/miscdevice.h>
> +
> +/* Access for sc_seco_secvio_config API */
> +#define SECVIO_CONFIG_READ  0
> +#define SECVIO_CONFIG_WRITE 1
> +
> +/* Internal Structure */
> +struct imx_secvio_sc_data {
> +	struct device *dev;
> +
> +	struct imx_sc_ipc *ipc_handle;
> +
> +	struct notifier_block irq_nb;
> +	struct notifier_block report_nb;
> +	struct notifier_block audit_nb;
> +
> +	struct nvmem_device *nvmem;
> +
> +	struct miscdevice miscdev;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dfs;
> +#endif
> +
> +	u32 version;
> +};
> +
> +/**
> + * call_secvio_config() - Wrapper for imx_sc_seco_secvio_config()
> + *
> + * @dev: secvio device
> + * @id: ID of the register, ie the offset of the first register of the set
> + * @access: Write (1) or Read (0) the registers
> + * @data0: Data for the first register
> + * @data1: Data for the second register
> + * @data2: Data for the third register
> + * @data3: Data for the fourth register
> + * @data4: Data for the fifth register
> + * @size: Number of register to configure
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int call_secvio_config(struct device *dev, u8 id, u8 access, u32 *data0,
> +		       u32 *data1, u32 *data2, u32 *data3, u32 *data4, u8 size);
> +
> +#ifdef CONFIG_DEBUG_FS
> +extern
> +int imx_secvio_sc_debugfs(struct device *dev);
> +#else
> +static inline
> +int imx_secvio_sc_debugfs(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
> +#ifdef CONFIG_AUDIT
> +int report_to_audit_notify(struct notifier_block *nb, unsigned long status,
> +			   void *notif_info);
> +#else /* CONFIG_AUDIT */
> +static inline
> +int report_to_audit_notify(struct notifier_block *nb, unsigned long status,
> +			   void *notif_info)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_AUDIT */
> +
> +#endif /* SECVIO_SC_H */
> diff --git a/drivers/soc/imx/secvio/imx-secvio-sc.c b/drivers/soc/imx/secvio/imx-secvio-sc.c
> new file mode 100644
> index 0000000..1e0d6aa
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-sc.c
> @@ -0,0 +1,858 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +/*
> + * The SoC of the i.MX8 family contains a hardware block called SNVS
> + * (Secure Non-Volatile Storage).
> + *
> + * The i.MX8 (QM/QXP/DXL) SoC contains the  (SNVS) block. This
> + * block can detect specific hardware attacks. Due to the presence of the SECO,
> + * this block can only be accessible using the SCFW API.
> + *
> + * This module interacts with the SCU which relays request to/from the SNVS block
> + * to detect if security violation occurred.
> + *
> + * The module exports an API to add processing when a SV is detected:
> + *  - register_imx_secvio_sc_notifier
> + *  - unregister_imx_secvio_sc_notifier
> + *  - imx_secvio_sc_check_state
> + *  - int_imx_secvio_sc_clear_state
> + *  - imx_secvio_sc_enable_irq
> + *  - imx_secvio_sc_disable_irq
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/miscdevice.h>
> +
> +#include <linux/firmware/imx/ipc.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/firmware/imx/svc/seco.h>
> +#include <linux/firmware/imx/svc/rm.h>
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +
> +#include <soc/imx/imx-secvio-sc.h>
> +#include "imx-secvio-sc-int.h"
> +
> +/* Definitions */
> +static int int_imx_secvio_sc_enable_irq(struct device *dev);
> +static int int_imx_secvio_sc_disable_irq(struct device *dev);
> +
> +/* Reference on the driver_device */
> +static struct device *gs_imx_secvio_sc_dev;
> +
> +/* Register IDs for sc_seco_secvio_config API */
> +#define HPSVS_ID 0x18
> +#define LPS_ID 0x4c
> +#define LPTDS_ID 0xa4
> +#define HPVIDR_ID 0xf8
> +
> +#define SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER 0x53
> +#define SECO_VERSION_MINOR_MASK GENMASK(15, 0)
> +
> +/* Notifier list for new CB */
> +static BLOCKING_NOTIFIER_HEAD(imx_secvio_sc_notifier_chain);
> +
> +/**
> + * register_imx_secvio_sc_notifier() - Add function to secvio call chain
> + *
> + * @nb: notifier block of the function to add
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int register_imx_secvio_sc_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&imx_secvio_sc_notifier_chain,
> +						nb);
> +}
> +EXPORT_SYMBOL(register_imx_secvio_sc_notifier);
> +
> +/**
> + * unregister_imx_secvio_sc_notifier() - Remove function to secvio call chain
> + *
> + * @nb: notifier block of the function to add
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int unregister_imx_secvio_sc_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&imx_secvio_sc_notifier_chain,
> +						  nb);
> +}
> +EXPORT_SYMBOL(unregister_imx_secvio_sc_notifier);
> +
> +/**
> + * if_imx_scu_irq_register_notifier() - Wrapper for imx_scu_irq_register_notifier
> + *
> + * Can be used for devm actions
> + *
> + * @nb: notifier block of the function to add
> + */
> +static void if_unregister_imx_secvio_sc_notifier(void *nb)
> +{
> +	unregister_imx_secvio_sc_notifier(nb);
> +}
> +
> +/**
> + * imx_secvio_sc_notifier_call_chain() - Call secvio notifier chain
> + *
> + * @info: The structure containing the info to pass to notified functions
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static
> +int imx_secvio_sc_notifier_call_chain(struct secvio_sc_notifier_info *info)
> +{
> +	return blocking_notifier_call_chain(&imx_secvio_sc_notifier_chain, 0,
> +					    (void *)info);
> +}
> +
> +int call_secvio_config(struct device *dev, u8 id, u8 access, u32 *data0,
> +		       u32 *data1, u32 *data2, u32 *data3, u32 *data4, u8 size)
> +{
> +	int ret = 0;
> +	struct imx_secvio_sc_data *data;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, id, access, data0,
> +					data1, data2, data3, data4, size);
> +	if (ret)
> +		dev_err(dev, "Fail %s secvio config %d",
> +			((access) ? "write" : "read"), ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * int_imx_secvio_sc_get_state() - Get the state of secvio and tamper
> + *
> + * @dev: secvio device
> + * @info: The structure to use to store the status
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_get_state(struct device *dev,
> +				       struct secvio_sc_notifier_info *info)
> +{
> +	struct secvio_sc_notifier_info _info = {0};
> +	struct secvio_sc_notifier_info *p_info;
> +	int ret = 0, ret2 = 0;
> +
> +	p_info = info ? info : &_info;
> +
> +	/* Read secvio status */
> +	ret = call_secvio_config(dev, HPSVS_ID, SECVIO_CONFIG_READ,
> +				 &p_info->hpsvs, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		ret2 = ret;
> +		dev_warn(dev, "Cannot read secvio status: %d\n", ret);
> +	}
> +	p_info->hpsvs &= HPSVS__ALL_SV__MASK;
> +
> +	/* Read tampers status */
> +	ret = call_secvio_config(dev, LPS_ID, SECVIO_CONFIG_READ,
> +				 &p_info->lps, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		ret2 = ret;
> +		dev_warn(dev, "Cannot read tamper 1 status: %d\n", ret);
> +	}
> +	p_info->lps &= LPS__ALL_TP__MASK;
> +
> +	ret = call_secvio_config(dev, LPTDS_ID, SECVIO_CONFIG_READ,
> +				 &p_info->lptds, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		ret2 = ret;
> +		dev_warn(dev, "Cannot read  tamper 2 status: %d\n", ret);
> +	}
> +	p_info->lptds &= LPTDS__ALL_TP__MASK;
> +
> +	dev_dbg(dev, "Status: %.8x, %.8x, %.8x\n", p_info->hpsvs,
> +		p_info->lps, p_info->lptds);
> +
> +	return ret2;
> +}
> +
> +/**
> + * imx_secvio_sc_get_state() - Wrapper for int_imx_secvio_sc_get_state
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +inline int imx_secvio_sc_get_state(struct secvio_sc_notifier_info *info)
> +{
> +	if (!gs_imx_secvio_sc_dev)
> +		return -EOPNOTSUPP;
> +
> +	return int_imx_secvio_sc_get_state(gs_imx_secvio_sc_dev, info);
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_get_state);
> +
> +/**
> + * int_imx_secvio_sc_check_state() - Get the state and call chain of notifier
> + * if there is a status
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_check_state(struct device *dev)
> +{
> +	struct secvio_sc_notifier_info info = {0};
> +	int ret = 0;
> +
> +	ret = int_imx_secvio_sc_get_state(dev, &info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get secvio state\n");
> +		goto exit;
> +	}
> +
> +	/* Call chain of CB registered to this module if status detected */
> +	if (info.hpsvs || info.lps || info.lptds)
> +		if (imx_secvio_sc_notifier_call_chain(&info))
> +			dev_warn(dev,
> +				 "Issues when calling the notifier chain\n");
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * imx_secvio_sc_check_state() - Wrapper for int_imx_secvio_sc_check_state
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +inline int imx_secvio_sc_check_state(void)
> +{
> +	if (!gs_imx_secvio_sc_dev)
> +		return -EOPNOTSUPP;
> +
> +	return int_imx_secvio_sc_check_state(gs_imx_secvio_sc_dev);
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_check_state);
> +
> +/**
> + * imx_secvio_sc_notify() - Process event from SCU
> + *
> + * If the event is secvio we check the state, then
> + * re-enable the IRQ which has been disabled by SCU
> + *
> + * @nb: secvio device
> + * @event: The id of the IRQ received in a group
> + * @group: The group of the IRQ
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_notify(struct notifier_block *nb,
> +				unsigned long event, void *group)
> +{
> +	struct imx_secvio_sc_data *data =
> +				container_of(nb, struct imx_secvio_sc_data,
> +					     irq_nb);
> +	struct device *dev = data->dev;
> +	int ret = 0;
> +
> +	/* Filter event for us */
> +	if (!((event & IMX_SC_IRQ_SECVIO) &&
> +	      (*(u8 *)group == IMX_SC_IRQ_GROUP_WAKE)))
> +		goto exit;
> +
> +	dev_warn(dev, "secvio security violation detected\n");
> +
> +	ret = int_imx_secvio_sc_check_state(dev);
> +
> +	/* Re-enable interrupt */
> +	ret = int_imx_secvio_sc_enable_irq(dev);
> +	if (ret)
> +		dev_err(dev, "Failed to enable IRQ\n");
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * int_imx_secvio_sc_clear_state() - Clear secvio and tamper state
> + *
> + * @dev: secvio device
> + * @hpsvs: high power security violation status to clear
> + * @lps: low power status to clear
> + * @lptds: low power tamper detector status to clear
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, u32 lps,
> +					 u32 lptds)
> +{
> +	int ret = 0;
> +
> +	ret = call_secvio_config(dev, HPSVS_ID, SECVIO_CONFIG_WRITE, &hpsvs,
> +				 NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot clear secvio status: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = call_secvio_config(dev, LPS_ID, SECVIO_CONFIG_WRITE, &lps, NULL,
> +				 NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot clear tamper 1 status: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = call_secvio_config(dev, LPTDS_ID, SECVIO_CONFIG_WRITE, &lptds,
> +				 NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot clear tamper 2 status: %d\n", ret);
> +		goto exit;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * imx_secvio_sc_clear_state() - Wrapper for imx_secvio_sc_clear_state
> + *
> + * @hpsvs: high power security violation status to clear
> + * @lps: low power status to clear
> + * @lptds: low power tamper detector status to clear
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +inline int imx_secvio_sc_clear_state(u32 hpsvs, u32 lps, u32 lptds)
> +{
> +	if (!gs_imx_secvio_sc_dev)
> +		return -EOPNOTSUPP;
> +
> +	return int_imx_secvio_sc_clear_state(gs_imx_secvio_sc_dev, hpsvs, lps,
> +					     lptds);
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_clear_state);
> +
> +/**
> + * report_to_user_notify() - Print to console the status
> + *
> + * @nb: notifier block
> + * @status: error code
> + * @notif_info: Pointer on structure containing the status of the secvio and
> + * tampers
> + *
> + * Return:
> + * 0 - OK
> + */
> +static int report_to_user_notify(struct notifier_block *nb,
> +				 unsigned long status, void *notif_info)
> +{
> +	struct secvio_sc_notifier_info *info = notif_info;
> +	struct imx_secvio_sc_data *data =
> +				container_of(nb, struct imx_secvio_sc_data,
> +					     report_nb);
> +	struct device *dev = data->dev;
> +
> +	/* Information about the security violation */
> +	if (info->hpsvs & HPSVS__LP_SEC_VIO__MASK)
> +		dev_info(dev, "SNVS secvio: LPSV\n");
> +	if (info->hpsvs & HPSVS__SW_LPSV__MASK)
> +		dev_info(dev, "SNVS secvio: SW LPSV\n");
> +	if (info->hpsvs & HPSVS__SW_FSV__MASK)
> +		dev_info(dev, "SNVS secvio: SW FSV\n");
> +	if (info->hpsvs & HPSVS__SW_SV__MASK)
> +		dev_info(dev, "SNVS secvio: SW SV\n");
> +	if (info->hpsvs & HPSVS__SV5__MASK)
> +		dev_info(dev, "SNVS secvio: SV 5\n");
> +	if (info->hpsvs & HPSVS__SV4__MASK)
> +		dev_info(dev, "SNVS secvio: SV 4\n");
> +	if (info->hpsvs & HPSVS__SV3__MASK)
> +		dev_info(dev, "SNVS secvio: SV 3\n");
> +	if (info->hpsvs & HPSVS__SV2__MASK)
> +		dev_info(dev, "SNVS secvio: SV 2\n");
> +	if (info->hpsvs & HPSVS__SV1__MASK)
> +		dev_info(dev, "SNVS secvio: SV 1\n");
> +	if (info->hpsvs & HPSVS__SV0__MASK)
> +		dev_info(dev, "SNVS secvio: SV 0\n");
> +
> +	/* Information about the tampers */
> +	if (info->lps & LPS__ESVD__MASK)
> +		dev_info(dev, "SNVS tamper: External SV\n");
> +	if (info->lps & LPS__ET2D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 2\n");
> +	if (info->lps & LPS__ET1D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 1\n");
> +	if (info->lps & LPS__WMT2D__MASK)
> +		dev_info(dev, "SNVS tamper: Wire Mesh 2\n");
> +	if (info->lps & LPS__WMT1D__MASK)
> +		dev_info(dev, "SNVS tamper: Wire Mesh 1\n");
> +	if (info->lps & LPS__VTD__MASK)
> +		dev_info(dev, "SNVS tamper: Voltage\n");
> +	if (info->lps & LPS__TTD__MASK)
> +		dev_info(dev, "SNVS tamper: Temperature\n");
> +	if (info->lps & LPS__CTD__MASK)
> +		dev_info(dev, "SNVS tamper: Clock\n");
> +	if (info->lps & LPS__PGD__MASK)
> +		dev_info(dev, "SNVS tamper: Power Glitch\n");
> +	if (info->lps & LPS__MCR__MASK)
> +		dev_info(dev, "SNVS tamper: Monotonic Counter rollover\n");
> +	if (info->lps & LPS__SRTCR__MASK)
> +		dev_info(dev, "SNVS tamper: Secure RTC rollover\n");
> +	if (info->lps & LPS__LPTA__MASK)
> +		dev_info(dev, "SNVS tamper: Time alarm\n");
> +
> +	if (info->lptds & LPTDS__ET10D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 10\n");
> +	if (info->lptds & LPTDS__ET9D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 9\n");
> +	if (info->lptds & LPTDS__ET8D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 8\n");
> +	if (info->lptds & LPTDS__ET7D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 7\n");
> +	if (info->lptds & LPTDS__ET6D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 6\n");
> +	if (info->lptds & LPTDS__ET5D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 5\n");
> +	if (info->lptds & LPTDS__ET4D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 4\n");
> +	if (info->lptds & LPTDS__ET3D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 3\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * int_imx_secvio_sc_enable_irq() - Enable the secvio IRQ in SCU
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_enable_irq(struct device *dev)
> +{
> +	int ret = 0, ret2;
> +	u32 irq_status;
> +	struct imx_secvio_sc_data *data;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	/* Enable the IRQ */
> +	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
> +				       true);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SCU IRQ: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	/* Enable interrupt */
> +	ret = imx_sc_seco_secvio_enable(data->ipc_handle);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SNVS irq: %d\n", ret);
> +		goto exit;
> +	};
> +
> +	/* Unmask interrupt */
> +	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "Cannot unmask irq: %d\n", ret);
> +		goto exit;
> +	};
> +
> +exit:
> +	if (ret) {
> +		ret2 = int_imx_secvio_sc_disable_irq(dev);
> +		if (ret2)
> +			dev_warn(dev, "Failed to disable the IRQ\n");
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * int_imx_secvio_sc_disable_irq() - Disable secvio IRQ
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_disable_irq(struct device *dev)
> +{
> +	int ret = 0;
> +	struct imx_secvio_sc_data *data;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	/* Disable the IRQ */
> +	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
> +				       false);
> +	if (ret) {
> +		dev_err(dev, "Cannot disable SCU IRQ: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * if_imx_secvio_sc_disable_irq() - Wrapper for int_imx_secvio_sc_disable_irq
> + *
> + * Can be used with devm
> + *
> + * @dev: secvio device
> + */
> +static void if_imx_secvio_sc_disable_irq(void *dev)
> +{
> +	int_imx_secvio_sc_disable_irq(dev);
> +}
> +
> +/**
> + * imx_secvio_sc_open() - Store node info for ioctl
> + *
> + * @node: inode
> + * @file: file used to perform the ioctl
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_open(struct inode *node, struct file *filp)
> +{
> +	filp->private_data = node->i_private;
> +
> +	return 0;
> +}
> +
> +/**
> + * imx_secvio_sc_ioctl() - IOCTL handler for the driver
> + *
> + * @file: file used to perform the ioctl
> + * @cmd: command to perform
> + * @arg: Pointer on structure with info for the command
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct device *dev = file->private_data;
> +	struct secvio_sc_notifier_info info;
> +	int ret;
> +
> +	switch (cmd) {
> +	case IMX_SECVIO_SC_GET_STATE:
> +		ret = int_imx_secvio_sc_get_state(dev, &info);
> +		if (ret) {
> +			dev_err(dev, "Fail to get state\n");
> +			goto exit;
> +		}
> +
> +		ret = copy_to_user((void *)arg, &info, sizeof(info));
> +		if (ret) {
> +			dev_err(dev, "Fail to copy info to user\n");
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +		break;
> +	case IMX_SECVIO_SC_CHECK_STATE:
> +		ret = int_imx_secvio_sc_check_state(dev);
> +		if (ret) {
> +			dev_err(dev, "Fail to check state\n");
> +			goto exit;
> +		}
> +		break;
> +	case IMX_SECVIO_SC_CLEAR_STATE:
> +		ret = copy_from_user(&info, (void *)arg, sizeof(info));
> +		if (ret) {
> +			dev_err(dev, "Fail to copy info from user\n");
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +
> +		ret = int_imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
> +						    info.lptds);
> +		if (ret) {
> +			dev_err(dev, "Fail to clear state\n");
> +			goto exit;
> +		}
> +		break;
> +	default:
> +		ret = -ENOIOCTLCMD;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +const static struct file_operations imx_secvio_sc_fops = {
> +	.owner = THIS_MODULE,
> +	.open = imx_secvio_sc_open,
> +	.unlocked_ioctl = imx_secvio_sc_ioctl,
> +};
> +
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static void reset_global_dev(void *dev)
> +{
> +	gs_imx_secvio_sc_dev = NULL;
> +}
> +
> +/**
> + * imx_secvio_sc_setup() - Configure the driver
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_setup(struct device *dev)
> +{
> +	struct imx_secvio_sc_data *data;
> +	u32 seco_version = 0;
> +	bool own_secvio;
> +	u32 irq_status;
> +	int ret = 0;
> +
> +	if (!devres_open_group(dev, NULL, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate private data */
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Failed to allocate mem for data\n");
> +		goto clean;
> +	}
> +
> +	data->dev = dev;
> +
> +	dev_set_drvdata(dev, data);
> +
> +	data->nvmem = devm_nvmem_device_get(dev, NULL);
> +	if (IS_ERR(data->nvmem)) {
> +		ret = PTR_ERR(data->nvmem);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to retrieve nvmem\n");
> +
> +		goto clean;
> +	}
> +
> +	/* Get a handle */
> +	ret = imx_scu_get_handle(&data->ipc_handle);
> +	if (ret) {
> +		dev_err(dev, "cannot get handle to scu: %d\n", ret);
> +		goto clean;
> +	};
> +
> +	/* Check the version of the SECO */
> +	ret = imx_sc_seco_build_info(data->ipc_handle, &seco_version, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to get seco version\n");
> +		goto clean;
> +	}
> +
> +	if ((seco_version & SECO_VERSION_MINOR_MASK) <
> +	     SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER) {
> +		dev_err(dev, "SECO version %.8x doesn't support all secvio\n",
> +			seco_version);
> +		ret = -EOPNOTSUPP;
> +		goto clean;
> +	}
> +
> +	/* Init debug FS */
> +	ret = imx_secvio_sc_debugfs(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set debugfs\n");
> +		goto clean;
> +	}
> +
> +	/* Check we own the SECVIO */
> +	ret = imx_sc_rm_is_resource_owned(data->ipc_handle, IMX_SC_R_SECVIO);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to retrieve secvio ownership\n");
> +		goto clean;
> +	}
> +
> +	own_secvio = ret > 0;
> +	if (!own_secvio) {
> +		dev_err(dev, "Secvio resource is not owned\n");
> +		ret = -EPERM;
> +		goto clean;
> +	}
> +
> +	/* Check IRQ exists and enable it */
> +	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "Cannot get IRQ state: %d\n", ret);
> +		goto clean;
> +	}
> +
> +	ret = int_imx_secvio_sc_enable_irq(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable IRQ\n");
> +		goto clean;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, if_imx_secvio_sc_disable_irq, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add managed action to disable IRQ\n");
> +		goto clean;
> +	}
> +
> +	/* Register the notifier for IRQ from SNVS */
> +	data->irq_nb.notifier_call = imx_secvio_sc_notify;
> +	ret = imx_scu_irq_register_notifier(&data->irq_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IRQ notification handler\n");
> +		goto clean;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, if_unregister_imx_secvio_sc_notifier,
> +				       &data->irq_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to remove irq notify\n");
> +		goto clean;
> +	}
> +
> +	/* Register the notification for reporting to user */
> +	data->report_nb.notifier_call = report_to_user_notify;
> +	ret = register_imx_secvio_sc_notifier(&data->report_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to register report notify handler\n");
> +		goto clean;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, if_unregister_imx_secvio_sc_notifier,
> +				       &data->report_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to remove report notify\n");
> +		goto clean;
> +	}
> +
> +	/* Register the notification to report to audit FW */
> +	data->audit_nb.notifier_call = report_to_audit_notify;
> +	ret = register_imx_secvio_sc_notifier(&data->audit_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to register report audit handler\n");
> +		goto clean;
> +	}
> +
> +	ret = devm_add_action(dev, if_unregister_imx_secvio_sc_notifier,
> +			      &data->audit_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to remove audit notif\n");
> +		goto clean;
> +	}
> +
> +	/* Register misc device for IOCTL */
> +	data->miscdev.name = devm_kstrdup(dev, "secvio-sc", GFP_KERNEL);
> +	data->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	data->miscdev.fops = &imx_secvio_sc_fops;
> +	data->miscdev.parent = dev;
> +	ret = misc_register(&data->miscdev);
> +	if (ret) {
> +		dev_err(dev, "failed to register misc device\n");
> +		goto exit;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, if_misc_deregister, &data->miscdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to unregister miscdev\n");
> +		goto clean;
> +	}
> +
> +	gs_imx_secvio_sc_dev = dev;
> +	ret = devm_add_action_or_reset(dev, reset_global_dev, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to disable global dev\n");
> +		goto clean;
> +	}
> +
> +	/* Process current state of the secvio and tampers */
> +	int_imx_secvio_sc_check_state(dev);
> +
> +	devres_remove_group(dev, NULL);
> +
> +	goto exit;
> +
> +clean:
> +	devres_release_group(dev, NULL);
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * imx_secvio_sc_probe() - Probe the driver
> + *
> + * @pdev: platform device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +
> +	ret = imx_secvio_sc_setup(dev);
> +	if (ret && ret != -EPROBE_DEFER)
> +		dev_err(dev, "Failed to setup\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id imx_secvio_sc_dt_ids[] = {
> +	{ .compatible = "fsl,imx-sc-secvio", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_secvio_sc_dt_ids);
> +
> +static struct platform_driver imx_secvio_sc_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name	= "imx-secvio-sc",
> +		.of_match_table = imx_secvio_sc_dt_ids,
> +	},
> +	.probe		= imx_secvio_sc_probe,
> +};
> +module_platform_driver(imx_secvio_sc_driver);
> +
> +MODULE_AUTHOR("Franck LENORMAND <franck.lenormand@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX driver to handle SNVS secvio irq sent by SCFW");
> +MODULE_LICENSE("GPL");
> diff --git a/include/soc/imx/imx-secvio-sc.h b/include/soc/imx/imx-secvio-sc.h
> new file mode 100644
> index 0000000..a26e2ff
> --- /dev/null
> +++ b/include/soc/imx/imx-secvio-sc.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +#ifndef _MISC_IMX_SECVIO_SC_H_
> +#define _MISC_IMX_SECVIO_SC_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/notifier.h>
> +
> +/* Bitmask of the security violation status bit in the HPSVS register */
> +#define HPSVS__LP_SEC_VIO__MASK BIT(31)
> +#define HPSVS__SW_LPSV__MASK    BIT(15)
> +#define HPSVS__SW_FSV__MASK     BIT(14)
> +#define HPSVS__SW_SV__MASK      BIT(13)
> +#define HPSVS__SV5__MASK        BIT(5)
> +#define HPSVS__SV4__MASK        BIT(4)
> +#define HPSVS__SV3__MASK        BIT(3)
> +#define HPSVS__SV2__MASK        BIT(2)
> +#define HPSVS__SV1__MASK        BIT(1)
> +#define HPSVS__SV0__MASK        BIT(0)
> +
> +/* Bitmask of all security violation status bit in the HPSVS register */
> +#define HPSVS__ALL_SV__MASK (HPSVS__LP_SEC_VIO__MASK | \
> +			     HPSVS__SW_LPSV__MASK | \
> +			     HPSVS__SW_FSV__MASK | \
> +			     HPSVS__SW_SV__MASK | \
> +			     HPSVS__SV5__MASK | \
> +			     HPSVS__SV4__MASK | \
> +			     HPSVS__SV3__MASK | \
> +			     HPSVS__SV2__MASK | \
> +			     HPSVS__SV1__MASK | \
> +			     HPSVS__SV0__MASK)
> +
> +/*
> + * Bitmask of the security violation and tampers status bit in the LPS register
> + */
> +#define LPS__ESVD__MASK  BIT(16)
> +#define LPS__ET2D__MASK  BIT(10)
> +#define LPS__ET1D__MASK  BIT(9)
> +#define LPS__WMT2D__MASK BIT(8)
> +#define LPS__WMT1D__MASK BIT(7)
> +#define LPS__VTD__MASK   BIT(6)
> +#define LPS__TTD__MASK   BIT(5)
> +#define LPS__CTD__MASK   BIT(4)
> +#define LPS__PGD__MASK   BIT(3)
> +#define LPS__MCR__MASK   BIT(2)
> +#define LPS__SRTCR__MASK BIT(1)
> +#define LPS__LPTA__MASK  BIT(0)
> +
> +/*
> + * Bitmask of all security violation and tampers status bit in the LPS register
> + */
> +#define LPS__ALL_TP__MASK (LPS__ESVD__MASK | \
> +			   LPS__ET2D__MASK | \
> +			   LPS__ET1D__MASK | \
> +			   LPS__WMT2D__MASK | \
> +			   LPS__WMT1D__MASK | \
> +			   LPS__VTD__MASK | \
> +			   LPS__TTD__MASK | \
> +			   LPS__CTD__MASK | \
> +			   LPS__PGD__MASK | \
> +			   LPS__MCR__MASK | \
> +			   LPS__SRTCR__MASK | \
> +			   LPS__LPTA__MASK)
> +
> +/*
> + * Bitmask of the security violation and tampers status bit in the LPTDS
> + * register
> + */
> +#define LPTDS__ET10D__MASK  BIT(7)
> +#define LPTDS__ET9D__MASK   BIT(6)
> +#define LPTDS__ET8D__MASK   BIT(5)
> +#define LPTDS__ET7D__MASK   BIT(4)
> +#define LPTDS__ET6D__MASK   BIT(3)
> +#define LPTDS__ET5D__MASK   BIT(2)
> +#define LPTDS__ET4D__MASK   BIT(1)
> +#define LPTDS__ET3D__MASK   BIT(0)
> +
> +/*
> + * Bitmask of all security violation and tampers status bit in the LPTDS
> + * register
> + */
> +#define LPTDS__ALL_TP__MASK (LPTDS__ET10D__MASK | \
> +			     LPTDS__ET9D__MASK | \
> +			     LPTDS__ET8D__MASK | \
> +			     LPTDS__ET7D__MASK | \
> +			     LPTDS__ET6D__MASK | \
> +			     LPTDS__ET5D__MASK | \
> +			     LPTDS__ET4D__MASK | \
> +			     LPTDS__ET3D__MASK)
> +
> +/**
> + * struct secvio_sc_notifier_info - Information about the status of the SNVS
> + * @hpsvs:   status from register HPSVS
> + * @lps: status from register LPS
> + * @lptds: status from register LPTDS
> + */
> +struct secvio_sc_notifier_info {
> +	u32 hpsvs;
> +	u32 lps;
> +	u32 lptds;
> +};
> +
> +/**
> + * register_imx_secvio_sc_notifier() - Register a notifier
> + *
> + * @nb: The notifier block structure
> + *
> + * Register a function to notify to the imx-secvio-sc module. The function
> + * will be notified when a check of the state of the SNVS happens: called by
> + * a user or triggered by an interruption form the SNVS.
> + *
> + * The struct secvio_sc_notifier_info is passed as data to the notifier.
> + *
> + * Return: 0 in case of success
> + */
> +int register_imx_secvio_sc_notifier(struct notifier_block *nb);
> +
> +/**
> + * unregister_imx_secvio_sc_notifier() - Unregister a notifier
> + *
> + * @nb: The notifier block structure
> + *
> + * Return: 0 in case of success
> + */
> +int unregister_imx_secvio_sc_notifier(struct notifier_block *nb);
> +
> +/**
> + * imx_secvio_sc_get_state() - Get the state of the SNVS
> + *
> + * @info: The structure containing the state of the SNVS
> + *
> + * Return: 0 in case of success
> + */
> +int imx_secvio_sc_get_state(struct secvio_sc_notifier_info *info);
> +
> +/**
> + * imx_secvio_sc_check_state() - Check the state of the SNVS
> + *
> + * If a security violation or a tamper is detected, the list of notifier
> + * (registered using register_imx_secvio_sc_notifier() ) will be called
> + *
> + * Return: 0 in case of success
> + */
> +int imx_secvio_sc_check_state(void);
> +
> +/**
> + * imx_secvio_sc_clear_state() - Clear the state of the SNVS
> + *
> + * @hpsvs: Value to write to HPSVS register
> + * @lps:   Value to write to LPS register
> + * @lptds: Value to write to LPTDSregister
> + *
> + * The function will write the value provided to the corresponding register
> + * which will clear the status of the bits set.
> + *
> + * Return: 0 in case of success
> + */
> +int imx_secvio_sc_clear_state(u32 hpsvs, u32 lps, u32 lptds);
> +
> +/* Commands of the ioctl interface */
> +enum ioctl_cmd_t {
> +	GET_STATE,
> +	CHECK_STATE,
> +	CLEAR_STATE,
> +};
> +
> +/* Definition for the ioctl interface */
> +#define IMX_SECVIO_SC_GET_STATE   _IOR('S', GET_STATE, \
> +				       struct secvio_sc_notifier_info)
> +#define IMX_SECVIO_SC_CHECK_STATE _IO('S', CHECK_STATE)
> +#define IMX_SECVIO_SC_CLEAR_STATE _IOW('S', CLEAR_STATE, \
> +				       struct secvio_sc_notifier_info)
> +
> +#endif /* _MISC_IMX_SECVIO_SC_H_ */
> -- 
> 2.7.4
> 

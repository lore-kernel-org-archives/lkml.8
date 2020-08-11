Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2140720774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597165507;
	bh=dwZHod6KPc3W7szywYJ/l216Bk/RtF5qw8WxOfVfm1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G+qnIPmurHi2QjIQc5/kMflC1NX3KXcQ8Clu5bHW+roqLz/HG8Wcj3YtieQsDYzHP
	 9YDesREZGCaMjbRr/yvhshcV5gShvJQnKj3NCXGIgPqNUo9PnyZegb7njXr5OamrlF
	 AXU7mnIdJEI17r8s6MIAksk8WQV3vriI+VXwTSuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgHKRFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbgHKRFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:05:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877662076B;
        Tue, 11 Aug 2020 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597165500;
        bh=dwZHod6KPc3W7szywYJ/l216Bk/RtF5qw8WxOfVfm1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4ff7+a2wHioJT6TKLvhGgOrC3G4fKAx3Hb3BQR/FXG8pI1u9FntXbm64THwpT+pC
         n0hi8qcGPABJxd+zBSpdtN4Xt4A5BeBoz42AcBHwO2K5/bvdhLSDOu8KFf3U+x8a4j
         fbHAv448AkLehgSly2nXkTkxRAy2jalt0Cl4eXio=
Date:   Tue, 11 Aug 2020 19:05:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH v2 01/19] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200811170509.GA765993@kroah.com>
References: <20200811162732.1369-1-gage.eads@intel.com>
 <20200811162732.1369-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811162732.1369-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:27:14AM -0500, Gage Eads wrote:
> diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
> new file mode 100644
> index 000000000000..ffd6df788e2e
> --- /dev/null
> +++ b/drivers/misc/dlb2/dlb2_main.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2018-2020 Intel Corporation */
> +
> +#include <linux/aer.h>
> +#include <linux/cdev.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/uaccess.h>
> +
> +#include "dlb2_main.h"
> +
> +static const char
> +dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";

Why do you have this static string that you never use?

> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
> +MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
> +
> +/* The driver lock protects data structures that used by multiple devices. */
> +static DEFINE_MUTEX(dlb2_driver_lock);
> +static struct list_head dlb2_dev_list = LIST_HEAD_INIT(dlb2_dev_list);

A static list of devices that you constantly walk?  Why?  This isn't the
1990's anymore, that should not be needed anywhere at all.

> +
> +static struct class *dlb2_class;
> +static dev_t dlb2_dev_number_base;

static dev_t my_major; perhaps?

Why have "dlb2_" as a prefix for static variables?

> +
> +/*****************************/
> +/****** Devfs callbacks ******/

there is nothing in the kernel called "devfs", and has not been for 16+
years I think.  Where did you get that term from???

> +/*****************************/
> +
> +static int dlb2_open(struct inode *i, struct file *f)
> +{
> +	return 0;
> +}
> +
> +static int dlb2_close(struct inode *i, struct file *f)
> +{
> +	return 0;

If you do not need an open/close function, do not include it.

> +}
> +
> +static const struct file_operations dlb2_fops = {
> +	.owner   = THIS_MODULE,
> +	.open    = dlb2_open,
> +	.release = dlb2_close,
> +};

You never use this structure in this patch :(

> +
> +/**********************************/
> +/****** PCI driver callbacks ******/
> +/**********************************/
> +
> +static DEFINE_IDA(dlb2_ids);

This is not a pci driver callback :)

Why have comments if they instantly are wrong? :(

> +
> +static int dlb2_alloc_id(void)
> +{
> +	return ida_alloc_max(&dlb2_ids, DLB2_MAX_NUM_DEVICES - 1, GFP_KERNEL);
> +}
> +
> +static void dlb2_free_id(int id)
> +{
> +	ida_free(&dlb2_ids, id);

No locking needed for accessing the ida?

> +}
> +
> +static int dlb2_probe(struct pci_dev *pdev,
> +		      const struct pci_device_id *pdev_id)
> +{
> +	struct dlb2_dev *dlb2_dev;
> +	int ret;
> +
> +	dlb2_dev = devm_kzalloc(&pdev->dev, sizeof(*dlb2_dev), GFP_KERNEL);

Why are you calling devm_kzalloc() if you manually call devm_kfree() for
this chunk of memory?  Either rely on the devm api or don't use it at
all.

> +	if (!dlb2_dev)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, dlb2_dev);
> +
> +	dlb2_dev->pdev = pdev;
> +
> +	dlb2_dev->id = dlb2_alloc_id();
> +	if (dlb2_dev->id < 0) {
> +		dev_err(&pdev->dev, "probe: device ID allocation failed\n");
> +
> +		ret = dlb2_dev->id;
> +		goto alloc_id_fail;
> +	}
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "pci_enable_device() returned %d\n", ret);
> +
> +		goto pci_enable_device_fail;
> +	}
> +
> +	ret = pci_request_regions(pdev, dlb2_driver_name);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev,
> +			"pci_request_regions(): returned %d\n", ret);
> +
> +		goto pci_request_regions_fail;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	if (pci_enable_pcie_error_reporting(pdev))
> +		dev_info(&pdev->dev, "[%s()] Failed to enable AER\n", __func__);
> +
> +	mutex_lock(&dlb2_driver_lock);
> +	list_add(&dlb2_dev->list, &dlb2_dev_list);
> +	mutex_unlock(&dlb2_driver_lock);
> +
> +	return 0;
> +
> +pci_request_regions_fail:
> +	pci_disable_device(pdev);
> +pci_enable_device_fail:
> +	dlb2_free_id(dlb2_dev->id);
> +alloc_id_fail:
> +	devm_kfree(&pdev->dev, dlb2_dev);
> +	return ret;
> +}
> +
> +static void dlb2_remove(struct pci_dev *pdev)
> +{
> +	struct dlb2_dev *dlb2_dev;
> +
> +	/* Undo all the dlb2_probe() operations */
> +	dlb2_dev = pci_get_drvdata(pdev);
> +
> +	mutex_lock(&dlb2_driver_lock);
> +	list_del(&dlb2_dev->list);
> +	mutex_unlock(&dlb2_driver_lock);
> +
> +	pci_disable_pcie_error_reporting(pdev);
> +
> +	pci_release_regions(pdev);
> +
> +	pci_disable_device(pdev);
> +
> +	dlb2_free_id(dlb2_dev->id);
> +
> +	devm_kfree(&pdev->dev, dlb2_dev);
> +}
> +
> +static struct pci_device_id dlb2_id_table[] = {
> +	{ PCI_DEVICE_DATA(INTEL, DLB2_PF, NULL) },
> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(pci, dlb2_id_table);
> +
> +static struct pci_driver dlb2_pci_driver = {
> +	.name		 = (char *)dlb2_driver_name,

Why is this cast needed?  That's a hint that something is wrong...

> +	.id_table	 = dlb2_id_table,
> +	.probe		 = dlb2_probe,
> +	.remove		 = dlb2_remove,
> +};
> +
> +static int __init dlb2_init_module(void)
> +{
> +	int err;
> +
> +	dlb2_class = class_create(THIS_MODULE, dlb2_driver_name);
> +
> +	if (IS_ERR(dlb2_class)) {

blank line was not needed.

> +		pr_err("%s: class_create() returned %ld\n",
> +		       dlb2_driver_name, PTR_ERR(dlb2_class));
> +
> +		return PTR_ERR(dlb2_class);
> +	}
> +
> +	/* Allocate one minor number per domain */
> +	err = alloc_chrdev_region(&dlb2_dev_number_base,
> +				  0,
> +				  DLB2_MAX_NUM_DEVICES,
> +				  dlb2_driver_name);
> +
> +	if (err < 0) {
> +		pr_err("%s: alloc_chrdev_region() returned %d\n",
> +		       dlb2_driver_name, err);
> +
> +		return err;
> +	}
> +
> +	err = pci_register_driver(&dlb2_pci_driver);
> +	if (err < 0) {
> +		pr_err("%s: pci_register_driver() returned %d\n",
> +		       dlb2_driver_name, err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit dlb2_exit_module(void)
> +{
> +	pci_unregister_driver(&dlb2_pci_driver);
> +
> +	unregister_chrdev_region(dlb2_dev_number_base,
> +				 DLB2_MAX_NUM_DEVICES);
> +
> +	if (dlb2_class) {
> +		class_destroy(dlb2_class);
> +		dlb2_class = NULL;

Why set this?

> +	}

No freeing of allocated ida structures?  Or is that not needed anymore,
I can never remember...

> +}
> +
> +module_init(dlb2_init_module);
> +module_exit(dlb2_exit_module);
> diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
> new file mode 100644
> index 000000000000..cc05546fba13
> --- /dev/null
> +++ b/drivers/misc/dlb2/dlb2_main.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + * Copyright(c) 2017-2020 Intel Corporation
> + */
> +
> +#ifndef __DLB2_MAIN_H
> +#define __DLB2_MAIN_H
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/ktime.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +
> +#include "dlb2_hw_types.h"
> +
> +static const char dlb2_driver_name[] = KBUILD_MODNAME;
> +
> +/*
> + * The dlb2 driver uses a different minor number for each device file, of which
> + * there are:
> + * - 33 per device (PF or VF/VDEV): 1 for the device, 32 for scheduling domains
> + * - Up to 17 devices per PF: 1 PF and up to 16 VFs/VDEVs
> + * - Up to 16 PFs per system
> + */
> +#define DLB2_MAX_NUM_PFS	  16
> +#define DLB2_NUM_FUNCS_PER_DEVICE (1 + DLB2_MAX_NUM_VDEVS)
> +#define DLB2_MAX_NUM_DEVICES	  (DLB2_MAX_NUM_PFS * DLB2_NUM_FUNCS_PER_DEVICE)
> +
> +struct dlb2_dev {
> +	struct pci_dev *pdev;
> +	struct list_head list;

Why is list needed?

> +	int id;

u32?  u64?  u8?  Pick something :)

> +};
> +
> +#endif /* __DLB2_MAIN_H */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5c709a1450b1..eb865b4eb900 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2809,6 +2809,8 @@
>  #define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
>  #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
>  #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
> +#define PCI_DEVICE_ID_INTEL_DLB2_PF	0x2710
> +#define PCI_DEVICE_ID_INTEL_DLB2_VF	0x2711

Did you read the top of this file?  How does this patch justify the
request there?

{sigh}

I'm not reviewing beyond this patch, sorry.

greg k-h

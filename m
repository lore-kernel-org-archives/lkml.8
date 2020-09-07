Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3730206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599500596;
	bh=N5zwS1SwbQXmonrHwuqGV2GKLymlY/0dB1tFcUdNLis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JkWfDcoWTUEq3n4rbg3X2l0QDaq9lKtvMBzP4+NU+GMVY9/KA7nUvyBqg1eIsKXOx
	 vZmxT7vGfTNlCXurMQT8BxNlAAUE+LadZlPOALZ8DvaGfctPve1dDp5D4nZEn2Dbww
	 746sfXqmf9pOZ4eGX6YAhoTwPH4jL80t9PMA2D2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgIGNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbgIGNK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:10:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9356021481;
        Mon,  7 Sep 2020 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599484207;
        bh=N5zwS1SwbQXmonrHwuqGV2GKLymlY/0dB1tFcUdNLis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyAzNRs9Oq1DHj72hini5MBXBgY1KxD0MelkmEq6Ennr6rEovS21M/PLwMcDL79ww
         hpf/35WD4c5xMdKpHWaqksf1/nZmCNWwwi4OrWHUvNwCuyl4waptF3bno8UXH6xi1x
         nucnyXUbM7sLB4LpW0Wy0+MvIYZVMROpwe6oaJxY=
Date:   Mon, 7 Sep 2020 15:10:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200907131021.GF2371705@kroah.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
 <20200901191548.31646-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901191548.31646-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:15:30PM -0500, Gage Eads wrote:
> --- /dev/null
> +++ b/drivers/misc/dlb2/dlb2_hw_types.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + * Copyright(c) 2016-2020 Intel Corporation
> + */
> +
> +#ifndef __DLB2_HW_TYPES_H
> +#define __DLB2_HW_TYPES_H
> +
> +#define DLB2_MAX_NUM_VDEVS			16
> +#define DLB2_MAX_NUM_DOMAINS			32
> +#define DLB2_MAX_NUM_LDB_QUEUES			32 /* LDB == load-balanced */
> +#define DLB2_MAX_NUM_DIR_QUEUES			64 /* DIR == directed */
> +#define DLB2_MAX_NUM_LDB_PORTS			64
> +#define DLB2_MAX_NUM_DIR_PORTS			DLB2_MAX_NUM_DIR_QUEUES
> +#define DLB2_MAX_NUM_LDB_CREDITS		8192
> +#define DLB2_MAX_NUM_DIR_CREDITS		2048
> +#define DLB2_MAX_NUM_HIST_LIST_ENTRIES		2048
> +#define DLB2_MAX_NUM_AQED_ENTRIES		2048
> +#define DLB2_MAX_NUM_QIDS_PER_LDB_CQ		8
> +#define DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS	2
> +#define DLB2_MAX_NUM_SEQUENCE_NUMBER_MODES	5
> +#define DLB2_QID_PRIORITIES			8
> +#define DLB2_NUM_ARB_WEIGHTS			8
> +#define DLB2_MAX_WEIGHT				255
> +#define DLB2_NUM_COS_DOMAINS			4
> +#define DLB2_MAX_CQ_COMP_CHECK_LOOPS		409600
> +#define DLB2_MAX_QID_EMPTY_CHECK_LOOPS		(32 * 64 * 1024 * (800 / 30))
> +#define DLB2_HZ					800000000
> +
> +#endif /* __DLB2_HW_TYPES_H */
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
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
> +MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer 2.0 Driver");
> +
> +/* The driver lock protects data structures that used by multiple devices. */
> +static DEFINE_MUTEX(dlb2_driver_lock);
> +static struct list_head dlb2_dev_list = LIST_HEAD_INIT(dlb2_dev_list);

A static list of your devices?  Why?  Who is going to need to ever walk
the list, shouldn't you be able to just access it from the device node
directly?


> +
> +static struct class *dlb2_class;
> +static dev_t dlb2_dev_number_base;

"number_base"?

> +
> +/*****************************/
> +/****** Devfs callbacks ******/
> +/*****************************/

I said this before, but it seems to have been ignored, so I'm guessing
my other comments were also ignored...

Anyway, there has not been anything called "Devfs" for 15+ years now,
where did you port this code from that had a horrid, out-of-date comment
block like that?

> +
> +static int dlb2_open(struct inode *i, struct file *f)
> +{
> +	return 0;
> +}
> +
> +static int dlb2_close(struct inode *i, struct file *f)
> +{
> +	return 0;
> +}

If open/close do not do anything, then do not include them as a callback
please.

> +
> +static const struct file_operations dlb2_fops = {
> +	.owner   = THIS_MODULE,
> +	.open    = dlb2_open,
> +	.release = dlb2_close,
> +};
> +
> +/**********************************/
> +/****** PCI driver callbacks ******/
> +/**********************************/
> +
> +static DEFINE_IDA(dlb2_ids);

This is not a PCI driver callback :)

Bad comments are worse than no comments at all.

> +
> +static int dlb2_alloc_id(void)
> +{
> +	return ida_alloc_max(&dlb2_ids, DLB2_MAX_NUM_DEVICES - 1, GFP_KERNEL);
> +}
> +
> +static void dlb2_free_id(int id)
> +{
> +	ida_free(&dlb2_ids, id);

Why have wrapper functions for simple one line calls, especially when
you only call these once?  They aren't needed, right?

> +}
> +
> +static int dlb2_probe(struct pci_dev *pdev,
> +		      const struct pci_device_id *pdev_id)
> +{
> +	struct dlb2_dev *dlb2_dev;
> +	int ret;
> +
> +	dlb2_dev = devm_kzalloc(&pdev->dev, sizeof(*dlb2_dev), GFP_KERNEL);
> +	if (!dlb2_dev)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, dlb2_dev);
> +
> +	dlb2_dev->pdev = pdev;

No reference counting?  Brave...

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

dev_err()?  And if this fails, why not really error out?

> +
> +	mutex_lock(&dlb2_driver_lock);
> +	list_add(&dlb2_dev->list, &dlb2_dev_list);

What is this list for?

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

If you don't have a data pointer, PCI_DEVICE() works, right?

> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(pci, dlb2_id_table);
> +
> +static struct pci_driver dlb2_pci_driver = {
> +	.name		 = (char *)dlb2_driver_name,

Hm, we should const that name in the structure, right?

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

Shouldn't you allocate your device ids when you have a device show up in
the system?  Why try to "pre-allocate" them all here?  That feels really
wasteful.

Same for allocating your class, why not just do that once your first PCI
device shows up?


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

Nice, you just leaked device ids, and your class is stuck around for
forever...

{sigh}

Why am I finding such Linux device-driver-101 errors here?

Please go back and follow the Intel-documented procedures and find
someone who has experience with pci and misc drivers and get their
review before sending this whole thing out again.  To lean on
maintainers without that experience makes the documented policy that you
should be following pretty worthless :(

greg "your company still owes me a lot of liquor" k-h

Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2669C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715A22082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yPARac3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFZLlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:41:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFZLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:41:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QBcaLg154439;
        Fri, 26 Jun 2020 11:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PNI0Jua3x5q2I8Nlxm//VVHUGpNd4BRRAAm+pfIrA4c=;
 b=yPARac3qPia0iakKOb8Q+t8Smaf2bfuyV5Sy4XtC1c9rDmD5dUOca6eyqh9l5AU6XaOC
 vDZA1WKyCwOcLsCflUZQhbbZuQcHVfqcFWTb1fqE0jeS9kUeHT1cUmipz4nmNKaSEZd1
 uhFswiUJd7Hhs39GXgDcRuU/m85GuOuAtv2D9AitjiISQPHPgsx/p1jb7eX4j68bOcXO
 Xio+D9WGnNjUSi9wQYbwOg684Lda7n2Bqlo0iOo8BImjWiIoqxrBIaZ+abNy1byToqh7
 20A+k8x5FmZwltj8juaoWphve9YYPNhPyMG52ed9In5l0aby+Pj83LYjcIoaYhhiYwzD 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31wg3bg1x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 11:41:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QBcZvt037295;
        Fri, 26 Jun 2020 11:41:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31uuraj4um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 11:41:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05QBf7LN026222;
        Fri, 26 Jun 2020 11:41:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jun 2020 11:41:06 +0000
Date:   Fri, 26 Jun 2020 14:40:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, devicetree@vger.kernel.org,
        ben.dooks@codethink.co.uk, colin.king@canonical.com, rogerq@ti.com,
        peter.chen@nxp.com, weiyongjun1@huawei.com, jpawar@cadence.com,
        kurahul@cadene.com, sparmar@cadence.com
Subject: Re: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Message-ID: <20200626114057.GD2571@kadam>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626045450.10205-3-pawell@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=858 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2 phishscore=0
 malwarescore=0 cotscore=-2147483648 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 mlxlogscore=872 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006260084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 06:54:47AM +0200, Pawel Laszczak wrote:
> +static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
> +{
> +	struct pci_dev *func;
> +
> +	/*
> +	 * Gets the second function.
> +	 * It's little tricky, but this platform has two function.
> +	 * The fist keeps resources for Host/Device while the second
> +	 * keeps resources for DRD/OTG.
> +	 */
> +	func = pci_get_device(pdev->vendor, pdev->device, NULL);
> +	if (unlikely(!func))

Delete all likely/unlikely annotations.  Likely and unlikely annotations
make the code less readable.  We are willing to sacrifice readability on
fast paths.

They're only supposed to be used where they're supported by benchmarking.
Probably it's pretty tricky to benchmark probe.  The other rule of thumb
is don't add them to drivers.  Another thing to consider is that this
error path is probably obvious enough for the compiler to figure out
without help.

> +		return NULL;
> +
> +	if (func->devfn == pdev->devfn) {
> +		func = pci_get_device(pdev->vendor, pdev->device, func);
> +		if (unlikely(!func))
> +			return NULL;
> +	}
> +
> +	return func;
> +}
> +
> +static int cdnsp_pci_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *id)
> +{
> +	struct platform_device_info plat_info;
> +	struct cdnsp_wrap *wrap;
> +	struct resource *res;
> +	struct pci_dev *func;
> +	int err;
> +
> +	/*
> +	 * For GADGET/HOST PCI (devfn) function number is 0,
> +	 * for OTG PCI (devfn) function number is 1.
> +	 */
> +	if (!id || (pdev->devfn != PCI_DEV_FN_HOST_DEVICE &&
> +		    pdev->devfn != PCI_DEV_FN_OTG))
> +		return -EINVAL;
> +
> +	func = cdnsp_get_second_fun(pdev);
> +	if (unlikely(!func))
> +		return -EINVAL;
> +
> +	if (func->class == PCI_CLASS_SERIAL_USB_XHCI ||
> +	    pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
> +		return -EINVAL;


Do we need call pci_put_device(func) before returning?

		ret = -EINVAL;
		goto put_pci;

> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
> +		return err;

		goto put_pci;

> +	}
> +
> +	pci_set_master(pdev);
> +
> +	if (pci_is_enabled(func)) {
> +		wrap = pci_get_drvdata(func);
> +	} else {
> +		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
> +		if (!wrap) {
> +			pci_disable_device(pdev);
> +			return -ENOMEM;

goto disable_pci;

> +		}
> +	}
> +
> +	res = wrap->dev_res;
> +
> +	/* For GADGET device function number is 0. */
> +	if (pdev->devfn == 0) {
> +		/* Function 0: host(BAR_0) + device(BAR_1).*/
> +		dev_dbg(&pdev->dev, "Initialize Device resources\n");
> +		res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> +		res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
> +		res[RES_DEV_ID].name = "dev";
> +		res[RES_DEV_ID].flags = IORESOURCE_MEM;
> +		dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> +			&res[RES_DEV_ID].start);
> +
> +		res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> +		res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> +		res[RES_HOST_ID].name = "xhci";
> +		res[RES_HOST_ID].flags = IORESOURCE_MEM;
> +		dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> +			&res[RES_HOST_ID].start);
> +
> +		/* Interrupt for XHCI, */
> +		wrap->dev_res[RES_IRQ_HOST_ID].start = pdev->irq;
> +		wrap->dev_res[RES_IRQ_HOST_ID].name = "host";
> +		wrap->dev_res[RES_IRQ_HOST_ID].flags = IORESOURCE_IRQ;
> +
> +		/* Interrupt device. It's the same as for HOST. */
> +		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].start = pdev->irq;
> +		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].name = "peripheral";
> +		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].flags = IORESOURCE_IRQ;
> +	} else {
> +		res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> +		res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> +		res[RES_DRD_ID].name = "otg";
> +		res[RES_DRD_ID].flags = IORESOURCE_MEM;
> +		dev_dbg(&pdev->dev, "CDNSP-DRD physical base addr: %pa\n",
> +			&res[RES_DRD_ID].start);
> +
> +		/* Interrupt for OTG/DRD. */
> +		wrap->dev_res[RES_IRQ_OTG_ID].start = pdev->irq;
> +		wrap->dev_res[RES_IRQ_OTG_ID].name = "otg";
> +		wrap->dev_res[RES_IRQ_OTG_ID].flags = IORESOURCE_IRQ;
> +	}
> +
> +	if (pci_is_enabled(func)) {
> +		/* Set up platform device info. */
> +		memset(&plat_info, 0, sizeof(plat_info));
> +		plat_info.parent = &pdev->dev;
> +		plat_info.fwnode = pdev->dev.fwnode;
> +		plat_info.name = PLAT_DRIVER_NAME;
> +		plat_info.id = pdev->devfn;
> +		wrap->devfn  = pdev->devfn;
> +		plat_info.res = wrap->dev_res;
> +		plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
> +		plat_info.dma_mask = pdev->dma_mask;
> +		/* Register platform device. */
> +		wrap->plat_dev = platform_device_register_full(&plat_info);
> +		if (IS_ERR(wrap->plat_dev)) {
> +			pci_disable_device(pdev);
> +			err = PTR_ERR(wrap->plat_dev);
> +			kfree(wrap);

		err = PTR_ERR(wrap->plat_dev);
		goto free_wrap;

Except, do we really want to kfree(wrap)?  It looks like it came from
pci_get_drvdata().

> +			return err;
> +		}
> +	}
> +
> +	pci_set_drvdata(pdev, wrap);
> +	return err;

free_wrap:
	if (!pci_is_enabled(func))
		kfree(wrap);
disable_pci:
	pci_disable_device(pdev);
put_pci:
	pci_put_device(func);

> +}
> +
> +static void cdnsp_pci_remove(struct pci_dev *pdev)
> +{
> +	struct cdnsp_wrap *wrap;
> +	struct pci_dev *func;
> +
> +	func = cdnsp_get_second_fun(pdev);
> +
> +	wrap = (struct cdnsp_wrap *)pci_get_drvdata(pdev);
> +	if (wrap->devfn == pdev->devfn)
> +		platform_device_unregister(wrap->plat_dev);
> +
> +	if (!pci_is_enabled(func))
> +		kfree(wrap);

pci_put_device(func);

> +}
> +

regards,
dan carpenter


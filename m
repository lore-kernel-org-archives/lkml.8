Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144632063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vQSKGiaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgF2Sqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:46:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgF2Squ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TAI5A5183679;
        Mon, 29 Jun 2020 10:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RVLzP059DlYjzBiiOqdNCfynhakBKzEhALuZMStgOCk=;
 b=vQSKGiaq0zIns/2lBycvFYFzOvTWH6x563tdglMrINDFdNvaMv73K9/38WGWAfomiD+t
 K9rYtECfmnqITKCZ70NCFS1/ZtbKPzZZq0i2UHZ0KTjGO+XNMIoQB1vQPWQD/RRRkRKo
 5b6sx3nhlAlzjeLiYrW+iYM/5AsUY0heSM/mzhj5Gm03fSJ+so2eeAHOH8gT+94r4v1Y
 XRlXQIEISJJvABZBMxu60/2Y0XRlXujEauze5Jb0hdoJ5w5h5XWps4ScAKVJ86ZlVgUy
 oIhV4fICV8GJh6H22FjYWVQv13hFXU15ie5dmrUn3KTpX60w/+DgAXhpJ1xCDqCWxlS+ TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31wxrmwmeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 10:18:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TA8Xmx018029;
        Mon, 29 Jun 2020 10:16:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31xfvqhq6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 10:16:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05TAGXZC015810;
        Mon, 29 Jun 2020 10:16:33 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jun 2020 10:16:28 +0000
Date:   Mon, 29 Jun 2020 13:16:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, devicetree@vger.kernel.org,
        ben.dooks@codethink.co.uk, colin.king@canonical.com, rogerq@ti.com,
        peter.chen@nxp.com, weiyongjun1@huawei.com, jpawar@cadence.com,
        kurahul@cadene.com, sparmar@cadence.com
Subject: Re: [PATCH RFC 4/5] usb: cdnsp: usb:cdns3 Add main part of Cadence
 USBSSP DRD Driver
Message-ID: <20200629101619.GH2571@kadam>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-5-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626045450.10205-5-pawell@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9666 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9666 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=2 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 06:54:49AM +0200, Pawel Laszczak wrote:
> This patch introduces the main part of Cadence USBSSP DRD driver
> to Linux kernel.
> To reduce the patch size a little bit, the header file gadget.h was
> intentionally added as separate patch.
> 
> The Cadence USBSSP DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA platform. We have
> support for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS DRD controller is compliant with XHCI.
> The architecture for device side is almost the same as for host side,
> and most of the XHCI specification can be used to understand how
> this controller operates.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdnsp/Kconfig  |   23 +
>  drivers/usb/cdnsp/Makefile |    7 +
>  drivers/usb/cdnsp/core.c   |  632 ++++++++++
>  drivers/usb/cdnsp/core.h   |   90 ++
>  drivers/usb/cdnsp/drd.c    |  372 ++++++
>  drivers/usb/cdnsp/drd.h    |  127 ++
>  drivers/usb/cdnsp/ep0.c    |  462 +++++++
>  drivers/usb/cdnsp/export.h |   36 +
>  drivers/usb/cdnsp/gadget.c | 1935 +++++++++++++++++++++++++++++
>  drivers/usb/cdnsp/gadget.h |  138 +++
>  drivers/usb/cdnsp/host.c   |   74 ++
>  drivers/usb/cdnsp/mem.c    | 1327 ++++++++++++++++++++
>  drivers/usb/cdnsp/ring.c   | 2380 ++++++++++++++++++++++++++++++++++++
>  13 files changed, 7603 insertions(+)
>  create mode 100644 drivers/usb/cdnsp/core.c
>  create mode 100644 drivers/usb/cdnsp/core.h
>  create mode 100644 drivers/usb/cdnsp/drd.c
>  create mode 100644 drivers/usb/cdnsp/drd.h
>  create mode 100644 drivers/usb/cdnsp/ep0.c
>  create mode 100644 drivers/usb/cdnsp/export.h
>  create mode 100644 drivers/usb/cdnsp/gadget.c
>  create mode 100644 drivers/usb/cdnsp/host.c
>  create mode 100644 drivers/usb/cdnsp/mem.c
>  create mode 100644 drivers/usb/cdnsp/ring.c
> 
> diff --git a/drivers/usb/cdnsp/Kconfig b/drivers/usb/cdnsp/Kconfig
> index 5796a19bb8a0..d177ce7a8bb2 100644
> --- a/drivers/usb/cdnsp/Kconfig
> +++ b/drivers/usb/cdnsp/Kconfig
> @@ -12,6 +12,29 @@ config USB_CDNSP
>  
>  if USB_CDNSP
>  
> +config USB_CDNSP_GADGET
> +	bool "Cadence CDNSP device controller"
> +	depends on USB_GADGET=y || USB_GADGET=USB_CDNSP
> +	help
> +	  Say Y here to enable device controller functionality of the
> +	  Cadence CDNSP-DEV driver.
> +
> +	  Cadence CDNSP Device Controller in device mode is
> +	  very similar to XHCI controller. Therefore some algorithms
> +	  used has been taken from host driver.
> +	  This controller supports FF, HS, SS and SSP mode.
> +	  It doesn't support LS.
> +
> +config USB_CDNSP_HOST
> +	bool "Cadence CDNSP host controller"
> +	depends on USB=y || USB=USB_CDNSP
> +	help
> +	  Say Y here to enable host controller functionality of the
> +	  Cadence driver.
> +
> +	  Host controller is compliant with XHCI so it uses
> +	  standard XHCI driver.
> +
>  config USB_CDNSP_PCI
>  	tristate "Cadence CDNSP support on PCIe-based platforms"
>  	depends on USB_PCI && ACPI
> diff --git a/drivers/usb/cdnsp/Makefile b/drivers/usb/cdnsp/Makefile
> index 21adf3eb2f7d..386b6a7b8b4e 100644
> --- a/drivers/usb/cdnsp/Makefile
> +++ b/drivers/usb/cdnsp/Makefile
> @@ -1,3 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +cdnsp-y					:= core.o drd.o
> +
> +obj-$(CONFIG_USB_CDNSP) 		+= cdnsp.o
> +cdnsp-$(CONFIG_USB_CDNSP_GADGET)	+= ring.o gadget.o mem.o ep0.o
> +
> +cdnsp-$(CONFIG_USB_CDNSP_HOST)		+= host.o
> +
>  obj-$(CONFIG_USB_CDNSP_PCI)		+= cdnsp-pci.o
> diff --git a/drivers/usb/cdnsp/core.c b/drivers/usb/cdnsp/core.c
> new file mode 100644
> index 000000000000..215783623c6b
> --- /dev/null
> +++ b/drivers/usb/cdnsp/core.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + * Code based on Cadence USBSS DRD driver.
> + * Origin: Copyright (C) 2018-2019 Cadence.
> + *         Copyright (C) 2017-2018 NXP
> + *         Copyright (C) 2019 Texas Instruments
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "export.h"
> +#include "drd.h"
> +
> +static int cdnsp_idle_init(struct cdnsp *cdns);
> +
> +static inline
> +struct cdnsp_role_driver *cdnsp_get_current_role_driver(struct cdnsp *cdns)
> +{
> +	WARN_ON(!cdns->roles[cdns->role]);
> +	return cdns->roles[cdns->role];
> +}
> +
> +static int cdnsp_role_start(struct cdnsp *cdns, enum usb_role role)
> +{
> +	int ret;
> +
> +	if (WARN_ON(role > USB_ROLE_DEVICE))
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->role = role;
> +	mutex_unlock(&cdns->mutex);
> +
> +	if (!cdns->roles[role])
> +		return -ENXIO;
> +
> +	if (cdns->roles[role]->state == CDNSP_ROLE_STATE_ACTIVE)
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	ret = cdns->roles[role]->start(cdns);
> +	if (!ret)
> +		cdns->roles[role]->state = CDNSP_ROLE_STATE_ACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +
> +	return ret;
> +}
> +
> +static void cdnsp_role_stop(struct cdnsp *cdns)
> +{
> +	enum usb_role role = cdns->role;
> +
> +	if (WARN_ON(role > USB_ROLE_DEVICE))
> +		return;
> +
> +	if (cdns->roles[role]->state == CDNSP_ROLE_STATE_INACTIVE)
> +		return;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->roles[role]->stop(cdns);
> +	cdns->roles[role]->state = CDNSP_ROLE_STATE_INACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +}
> +
> +static void cdnsp_exit_roles(struct cdnsp *cdns)
> +{
> +	cdnsp_role_stop(cdns);
> +	cdnsp_drd_exit(cdns);
> +}
> +
> +/**
> + * cdnsp_core_init_role - initialize role of operation.
> + * @cdns: Pointer to cdnsp structure.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +static int cdnsp_core_init_role(struct cdnsp *cdns)
> +{
> +	struct device *dev = cdns->dev;
> +	enum usb_dr_mode best_dr_mode;
> +	enum usb_dr_mode dr_mode;
> +	int ret = 0;

Don't initialize

> +
> +	dr_mode = usb_get_dr_mode(dev);
> +	cdns->role = USB_ROLE_NONE;
> +
> +	/*
> +	 * If driver can't read mode by means of usb_get_dr_mode function then
> +	 * chooses mode according with Kernel configuration. This setting
> +	 * can be restricted later depending on strap pin configuration.
> +	 */
> +	if (dr_mode == USB_DR_MODE_UNKNOWN) {
> +		if (IS_ENABLED(CONFIG_USB_CDNSP_HOST) &&
> +		    IS_ENABLED(CONFIG_USB_CDNSP_GADGET))
> +			dr_mode = USB_DR_MODE_OTG;
> +		else if (IS_ENABLED(CONFIG_USB_CDNSP_HOST))
> +			dr_mode = USB_DR_MODE_HOST;
> +		else if (IS_ENABLED(CONFIG_USB_CDNSP_GADGET))
> +			dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	/*
> +	 * At this point cdns->dr_mode contains strap configuration.
> +	 * Driver try update this setting considering kernel configuration.
> +	 */
> +	best_dr_mode = cdns->dr_mode;
> +
> +	ret = cdnsp_idle_init(cdns);
> +	if (ret)
> +		return ret;
> +
> +	if (dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = cdns->dr_mode;
> +	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = dr_mode;
> +	} else if (cdns->dr_mode != dr_mode) {
> +		dev_err(dev, "Incorrect DRD configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	dr_mode = best_dr_mode;
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> +		ret = cdnsp_host_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Host initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		ret = cdnsp_gadget_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Device initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	cdns->dr_mode = dr_mode;
> +
> +	ret = cdnsp_drd_update_mode(cdns);
> +	if (ret)
> +		goto err;
> +
> +	/* Initialize idle role to start with. */
> +	ret = cdnsp_role_start(cdns, USB_ROLE_NONE);
> +	if (ret)
> +		goto err;
> +
> +	switch (cdns->dr_mode) {
> +	case USB_DR_MODE_OTG:
> +		ret = cdnsp_hw_role_switch(cdns);
> +		if (ret)
> +			goto err;
> +		break;
> +	case USB_DR_MODE_PERIPHERAL:
> +		ret = cdnsp_role_start(cdns, USB_ROLE_DEVICE);
> +		if (ret)
> +			goto err;
> +		break;
> +	case USB_DR_MODE_HOST:
> +		ret = cdnsp_role_start(cdns, USB_ROLE_HOST);
> +		if (ret)
> +			goto err;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	return ret;

This could be return 0;

> +err:
> +	cdnsp_exit_roles(cdns);
> +	return ret;
> +}
> +
> +/**
> + * cdnsp_hw_role_state_machine  - role switch state machine based on hw events.
> + * @cdns: Pointer to controller structure.
> + *
> + * Returns next role to be entered based on hw events.
> + */
> +static enum usb_role cdnsp_hw_role_state_machine(struct cdnsp *cdns)
> +{
> +	enum usb_role role = USB_ROLE_NONE;
> +	int id, vbus;
> +
> +	if (cdns->dr_mode != USB_DR_MODE_OTG)
> +		goto not_otg;

No need for this goto.  Move the code here.

> +
> +	id = cdnsp_get_id(cdns);
> +	vbus = cdnsp_get_vbus(cdns);
> +
> +	/*
> +	 * Role change state machine
> +	 * Inputs: ID, VBUS
> +	 * Previous state: cdns->role
> +	 * Next state: role
> +	 */
> +	role = cdns->role;
> +
> +	switch (role) {
> +	case USB_ROLE_NONE:
> +		/*
> +		 * Driver treats USB_ROLE_NONE synonymous to IDLE state from
> +		 * controller specification.
> +		 */
> +		if (!id)
> +			role = USB_ROLE_HOST;
> +		else if (vbus)
> +			role = USB_ROLE_DEVICE;
> +		break;
> +	case USB_ROLE_HOST: /* from HOST, we can only change to NONE. */
> +		if (id)
> +			role = USB_ROLE_NONE;
> +		break;
> +	case USB_ROLE_DEVICE: /* from GADGET, we can only change to NONE. */
> +		if (!vbus)
> +			role = USB_ROLE_NONE;
> +		break;
> +	}
> +
> +	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> +
> +	return role;
> +
> +not_otg:
> +	if (cdnsp_is_host(cdns))
> +		role = USB_ROLE_HOST;
> +	if (cdnsp_is_device(cdns))
> +		role = USB_ROLE_DEVICE;
> +
> +	return role;
> +}
> +
> +static int cdnsp_idle_role_start(struct cdnsp *cdns)
> +{
> +	return 0;
> +}
> +
> +static void cdnsp_idle_role_stop(struct cdnsp *cdns)
> +{
> +	/* Program Lane swap and bring PHY out of RESET. */
> +	phy_reset(cdns->usb3_phy);
> +}
> +
> +static int cdnsp_idle_init(struct cdnsp *cdns)
> +{
> +	struct cdnsp_role_driver *rdrv;
> +
> +	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +	if (!rdrv)
> +		return -ENOMEM;
> +
> +	rdrv->start = cdnsp_idle_role_start;
> +	rdrv->stop = cdnsp_idle_role_stop;
> +	rdrv->state = CDNSP_ROLE_STATE_INACTIVE;
> +	rdrv->suspend = NULL;
> +	rdrv->resume = NULL;
> +	rdrv->name = "idle";
> +
> +	cdns->roles[USB_ROLE_NONE] = rdrv;
> +
> +	return 0;
> +}
> +
> +/**
> + * cdnsp_hw_role_switch - switch roles based on HW state.
> + * @cdns: Pointer to controller structure.
> + */
> +int cdnsp_hw_role_switch(struct cdnsp *cdns)
> +{
> +	enum usb_role real_role, current_role;
> +	int ret = 0;
> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	current_role = cdns->role;
> +	real_role = cdnsp_hw_role_state_machine(cdns);
> +
> +	/* Do nothing if nothing changed. */
> +	if (current_role == real_role)
> +		goto exit;
> +
> +	cdnsp_role_stop(cdns);
> +
> +	dev_dbg(cdns->dev, "Switching role %d -> %d", current_role, real_role);
> +
> +	ret = cdnsp_role_start(cdns, real_role);
> +	if (ret) {
> +		/* Back to current role. */
> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +			real_role, current_role);
> +		ret = cdnsp_role_start(cdns, current_role);
> +		if (ret)
> +			dev_err(cdns->dev, "back to %d failed too\n",
> +				current_role);
> +	}
> +exit:
> +	pm_runtime_put_sync(cdns->dev);
> +	return ret;
> +}
> +
> +/**
> + * cdsn3_role_get - get current role of controller.
> + * @sw: Pointer to usb_role_switch object.
> + *
> + * Returns role.
> + */
> +static enum usb_role cdnsp_role_get(struct usb_role_switch *sw)
> +{
> +	struct cdnsp *cdns = usb_role_switch_get_drvdata(sw);
> +
> +	return cdns->role;
> +}
> +
> +/**
> + * cdnsp_role_set - set current role of controller.
> + * @sw: Pointer to usb_role_switch object.
> + * @role: The previous role.
> + * Handles below events:
> + * - Role switch for dual-role devices.
> + * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices.
> + */
> +static int cdnsp_role_set(struct usb_role_switch *sw, enum usb_role role)
> +{
> +	struct cdnsp *cdns = usb_role_switch_get_drvdata(sw);
> +	int ret = 0;
> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	if (cdns->role == role)
> +		goto pm_put;
> +
> +	if (cdns->dr_mode == USB_DR_MODE_HOST) {
> +		switch (role) {
> +		case USB_ROLE_NONE:
> +		case USB_ROLE_HOST:
> +			break;
> +		default:
> +			ret = -EPERM;
> +			goto pm_put;
> +		}
> +	}
> +
> +	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		switch (role) {
> +		case USB_ROLE_NONE:
> +		case USB_ROLE_DEVICE:
> +			break;
> +		default:
> +			ret = -EPERM;
> +			goto pm_put;
> +		}
> +	}
> +
> +	cdnsp_role_stop(cdns);
> +	ret = cdnsp_role_start(cdns, role);
> +	if (ret) {
> +		dev_err(cdns->dev, "set role %d has failed\n", role);
> +		ret = -EPERM;

Why not preserve the error code?

> +	}
> +
> +pm_put:
> +	pm_runtime_put_sync(cdns->dev);
> +	return ret;
> +}
> +
> +/**
> + * cdnsp_probe - probe for cdnsp core device.
> + * @pdev: Pointer to cdnsp core platform device.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +static int cdnsp_probe(struct platform_device *pdev)
> +{
> +	struct usb_role_switch_desc sw_desc = { };
> +	struct device *dev = &pdev->dev;
> +	struct resource	*res;
> +	struct cdnsp *cdns;
> +	void __iomem *regs;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(dev, "error setting dma mask: %d\n", ret);
> +		return -ENODEV;

Preserve the error code?

> +	}
> +
> +	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> +	if (!cdns)
> +		return -ENOMEM;
> +
> +	cdns->dev = dev;
> +
> +	platform_set_drvdata(pdev, cdns);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
> +	if (!res) {
> +		dev_err(dev, "missing host IRQ\n");
> +		return -ENODEV;
> +	}
> +
> +	cdns->xhci_res[0] = *res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> +	if (!res) {
> +		dev_err(dev, "couldn't get xhci resource\n");
> +		return -ENXIO;
> +	}
> +
> +	cdns->xhci_res[1] = *res;
> +
> +	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
> +	if (cdns->dev_irq == -EPROBE_DEFER)
> +		return cdns->dev_irq;
> +
> +	if (cdns->dev_irq < 0)
> +		dev_err(dev, "couldn't get peripheral irq\n");

It really feels like this should be an error return.

> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dev");
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->dev_regs	= regs;
> +
> +	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
> +	if (cdns->otg_irq == -EPROBE_DEFER)
> +		return cdns->otg_irq;
> +
> +	if (cdns->otg_irq < 0) {
> +		dev_err(dev, "couldn't get otg irq\n");
> +		return cdns->otg_irq;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> +	if (!res) {
> +		dev_err(dev, "couldn't get otg resource\n");
> +		return -ENXIO;
> +	}
> +
> +	cdns->otg_res = *res;
> +
> +	mutex_init(&cdns->mutex);
> +
> +	cdns->usb2_phy = devm_phy_optional_get(dev, "cdnsp,usb2-phy");
> +	if (IS_ERR(cdns->usb2_phy))
> +		return PTR_ERR(cdns->usb2_phy);
> +
> +	ret = phy_init(cdns->usb2_phy);
> +	if (ret)
> +		return ret;
> +
> +	cdns->usb3_phy = devm_phy_optional_get(dev, "cdnsp,usb3-phy");
> +	if (IS_ERR(cdns->usb3_phy))
> +		return PTR_ERR(cdns->usb3_phy);
> +
> +	ret = phy_init(cdns->usb3_phy);
> +	if (ret)
> +		goto err1;
> +
> +	ret = phy_power_on(cdns->usb2_phy);
> +	if (ret)
> +		goto err2;
> +
> +	ret = phy_power_on(cdns->usb3_phy);
> +	if (ret)
> +		goto err3;
> +
> +	sw_desc.set = cdnsp_role_set;
> +	sw_desc.get = cdnsp_role_get;
> +	sw_desc.allow_userspace_control = true;
> +	sw_desc.driver_data = cdns;
> +	if (device_property_read_bool(dev, "usb-role-switch"))
> +		sw_desc.fwnode = dev->fwnode;
> +
> +	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
> +	if (IS_ERR(cdns->role_sw)) {
> +		ret = PTR_ERR(cdns->role_sw);
> +		dev_warn(dev, "Unable to register Role Switch\n");
> +		goto err4;
> +	}
> +
> +	ret = cdnsp_drd_init(cdns);
> +	if (ret)
> +		goto err5;
> +
> +	ret = cdnsp_core_init_role(cdns);
> +	if (ret)
> +		goto err5;
> +
> +	device_set_wakeup_capable(dev, true);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
> +	 * The controller needs less time between bus and controller suspend,
> +	 * and we also needs a small delay to avoid frequently entering low
> +	 * power mode.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, 20);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_use_autosuspend(dev);
> +	dev_dbg(dev, "Cadence CDNSP core: probe succeed\n");
> +
> +	return 0;
> +err5:
> +	cdnsp_drd_exit(cdns);
> +	usb_role_switch_unregister(cdns->role_sw);
> +err4:
> +	phy_power_off(cdns->usb3_phy);
> +
> +err3:
> +	phy_power_off(cdns->usb2_phy);
> +err2:
> +	phy_exit(cdns->usb3_phy);
> +err1:
> +	phy_exit(cdns->usb2_phy);
> +
> +	return ret;
> +}
> +
> +/**
> + * cdnsp_remove - unbind drd driver and clean up.
> + * @pdev: Pointer to Linux platform device.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +static int cdnsp_remove(struct platform_device *pdev)
> +{
> +	struct cdnsp *cdns = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	cdnsp_exit_roles(cdns);
> +	usb_role_switch_unregister(cdns->role_sw);
> +	phy_power_off(cdns->usb2_phy);
> +	phy_power_off(cdns->usb3_phy);
> +	phy_exit(cdns->usb2_phy);
> +	phy_exit(cdns->usb3_phy);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int cdnsp_suspend(struct device *dev)
> +{
> +	struct cdnsp *cdns = dev_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	if (cdns->role == USB_ROLE_HOST)
> +		return 0;
> +
> +	if (pm_runtime_status_suspended(dev))
> +		pm_runtime_resume(dev);
> +
> +	if (cdns->roles[cdns->role]->suspend) {
> +		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
> +		cdns->roles[cdns->role]->suspend(cdns, false);
> +		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdnsp_resume(struct device *dev)
> +{
> +	struct cdnsp *cdns = dev_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	if (cdns->role == USB_ROLE_HOST)
> +		return 0;
> +
> +	if (cdns->roles[cdns->role]->resume) {
> +		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
> +		cdns->roles[cdns->role]->resume(cdns, false);
> +		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
> +	}
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops cdnsp_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cdnsp_suspend, cdnsp_resume)
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cdnsp_match[] = {
> +	{ .compatible = "cdns,usbssp" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_cdnsp_match);
> +#endif
> +
> +static struct platform_driver cdnsp_driver = {
> +	.probe		= cdnsp_probe,
> +	.remove		= cdnsp_remove,
> +	.driver		= {
> +		.name	= "cdns-usbssp",
> +		.of_match_table	= of_match_ptr(of_cdnsp_match),
> +		.pm	= &cdnsp_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(cdnsp_driver);
> +
> +MODULE_ALIAS("platform:cdnsp");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence CDNSP DRD Controller Driver");
> diff --git a/drivers/usb/cdnsp/core.h b/drivers/usb/cdnsp/core.h
> new file mode 100644
> index 000000000000..408889fdd2d9
> --- /dev/null
> +++ b/drivers/usb/cdnsp/core.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Authors: Pawel Laszczak <pawell@cadence.com>
> + *
> + */
> +#include <linux/usb/role.h>
> +#include <linux/usb/otg.h>
> +
> +#ifndef __LINUX_CDNSP_CORE_H
> +#define __LINUX_CDNSP_CORE_H
> +
> +struct cdnsp;
> +
> +/**
> + * struct cdnsp_role_driver - host/gadget role driver.
> + * @start: Start this role.
> + * @stop: Stop this role.
> + * @suspend: Suspend callback for this role.
> + * @resume: Resume callback for this role.
> + * @irq: irq handler for this role.
> + * @name: Role name string (host/gadget).
> + * @state: Current state.
> + */
> +struct cdnsp_role_driver {
> +	int (*start)(struct cdnsp *cdns);
> +	void (*stop)(struct cdnsp *cdns);
> +	int (*suspend)(struct cdnsp *cdns, bool do_wakeup);
> +	int (*resume)(struct cdnsp *cdns, bool hibernated);
> +	const char *name;
> +#define CDNSP_ROLE_STATE_INACTIVE	0
> +#define CDNSP_ROLE_STATE_ACTIVE		1
> +	int state;
> +};
> +
> +#define CDNSP_XHCI_RESOURCES_NUM	2
> +
> +/**
> + * struct cdnsp - Representation of Cadence USB3 DRD controller.
> + * @dev: Pointer to Cadence device struct.
> + * @xhci_regs: Pointer to base of xhci registers.
> + * @xhci_res: The resource for xhci.
> + * @dev_regs: Pointer to base of dev registers.
> + * @otg_res: The resource for otg.
> + * @otg_regs: Pointer to base of otg registers.
> + * @otg_irq: irq number for otg controller.
> + * @dev_irq: irq number for device controller.
> + * @roles: Array of supported roles for this controller.
> + * @role: Current role.
> + * @host_dev: The child host device pointer for cdnsp core.
> + * @gadget_dev: The child gadget device pointer for cdnsp core.
> + * @usb2_phy: Pointer to USB2 PHY.
> + * @usb3_phy: Pointer to USB3 PHY.
> + * @mutex: The mutex for concurrent code at driver.
> + * @dr_mode: Supported mode of operation it can be only Host, only Device
> + *           or OTG mode that allow to switch between Device and Host mode.
> + *           This field based on firmware setting, kernel configuration
> + *           and hardware configuration.
> + * @role_sw: Pointer to role switch object.
> + */
> +struct cdnsp {
> +	struct device *dev;
> +	void __iomem *xhci_regs;
> +	struct resource xhci_res[CDNSP_XHCI_RESOURCES_NUM];
> +	struct cdnsp_usb_regs __iomem *dev_regs;
> +
> +	struct resource otg_res;
> +	struct cdnsp_otg_regs *otg_regs;
> +
> +	int otg_irq;
> +	int dev_irq;
> +	struct cdnsp_role_driver *roles[USB_ROLE_DEVICE + 1];
> +	enum usb_role role;
> +	struct platform_device *host_dev;
> +	struct cdnsp_device *gadget_dev;
> +	struct phy *usb2_phy;
> +	struct phy *usb3_phy;
> +
> +	/* mutext used in workqueue. */
> +	struct mutex mutex;
> +	enum usb_dr_mode dr_mode;
> +	struct usb_role_switch *role_sw;
> +};
> +
> +int cdnsp_hw_role_switch(struct cdnsp *cdns);
> +
> +#endif /* __LINUX_CDNSP_CORE_H */
> diff --git a/drivers/usb/cdnsp/drd.c b/drivers/usb/cdnsp/drd.c
> new file mode 100644
> index 000000000000..8a8d244278ef
> --- /dev/null
> +++ b/drivers/usb/cdnsp/drd.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + * Code based on Cadence USBSS DRD driver.
> + * Origin: Copyright (C) 2018-2019 Cadence.
> + *         Copyright (C) 2019 Texas Instruments
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/usb/otg.h>
> +#include <linux/kernel.h>
> +#include <linux/iopoll.h>
> +#include <linux/delay.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "drd.h"
> +
> +/**
> + * cdnsp_set_mode - change mode of OTG Core.
> + * @cdns: Pointer to context structure.
> + * @mode: Selected mode from cdns_role.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +static int cdnsp_set_mode(struct cdnsp *cdns, enum usb_dr_mode mode)
> +{
> +	int ret = 0;
> +	u32 reg;
> +
> +	switch (mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		break;
> +	case USB_DR_MODE_HOST:
> +		break;
> +	case USB_DR_MODE_OTG:
> +		dev_dbg(cdns->dev, "Set controller to OTG mode\n");
> +		reg = readl(&cdns->otg_regs->override);
> +		reg |= OVERRIDE_IDPULLUP;
> +		writel(reg, &cdns->otg_regs->override);
> +
> +		/*
> +		 * Hardware specification says: "ID_VALUE must be valid within
> +		 * 50ms after idpullup is set to '1" so driver must wait
> +		 * 50ms before reading this pin.
> +		 */
> +		usleep_range(50000, 60000);
> +		break;
> +	default:
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;

return 0;  delete the "ret" variable.

> +}
> +
> +int cdnsp_get_id(struct cdnsp *cdns)
> +{
> +	int id;
> +
> +	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;

It took me a while to spot the & OTGSTS_ID_VALUE.  Could you move that
to its own line:

	id = readl(&cdns->otg_regs->sts);
	id &= OTGSTS_ID_VALUE;

I'm not sure I understand what ID means in this context.  I would have
expected both 0 and 1 to be valid identifiers?  The two identifiers
should have human readable names so change:

-	if (!cdnsp_get_id())

to

+	if (cdnsp_get_id() == MY_WHATEVER_IDENDTIFIER) {


> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
> +
> +	return id;
> +}
> +
> +int cdnsp_get_vbus(struct cdnsp *cdns)
> +{
> +	int vbus;
> +
> +	vbus = !!(readl(&cdns->otg_regs->sts) & OTGSTS_VBUS_VALID);
> +	dev_dbg(cdns->dev, "OTG VBUS: %d", vbus);
> +
> +	return vbus;
> +}
> +
> +int cdnsp_is_host(struct cdnsp *cdns)

Make this bool.  return true/false.

> +{
> +	if (cdns->dr_mode == USB_DR_MODE_HOST)
> +		return 1;
> +	else if (!cdnsp_get_id(cdns))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +int cdnsp_is_device(struct cdnsp *cdns)

Bool

> +{
> +	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
> +		return 1;
> +	else if (cdns->dr_mode == USB_DR_MODE_OTG)
> +		if (cdnsp_get_id(cdns))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +void cdnsp_clear_vbus(struct cdnsp *cdns)
> +{
> +	u32 reg;
> +
> +	reg = readl(&cdns->otg_regs->override);
> +	reg |= OVERRIDE_SESS_VLD_SEL;
> +	writel(reg, &cdns->otg_regs->override);
> +}
> +
> +void cdnsp_set_vbus(struct cdnsp *cdns)
> +{
> +	u32 reg;
> +
> +	reg = readl(&cdns->otg_regs->override);
> +	reg &= ~OVERRIDE_SESS_VLD_SEL;
> +	writel(reg, &cdns->otg_regs->override);
> +}
> +
> +/**
> + * cdnsp_otg_disable_irq - Disable all OTG interrupts.
> + * @cdns: Pointer to controller context structure.
> + */
> +static void cdnsp_otg_disable_irq(struct cdnsp *cdns)
> +{
> +	writel(0, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdnsp_otg_enable_irq - enable id and sess_valid interrupts.
> + * @cdns: Pointer to controller context structure.
> + */
> +static void cdnsp_otg_enable_irq(struct cdnsp *cdns)
> +{
> +	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
> +	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdnsp_drd_switch_host - start/stop host.
> + * @cdns: Pointer to controller context structure.
> + * @on: 1 for start, 0 for stop.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +int cdnsp_drd_switch_host(struct cdnsp *cdns, int on)

Split this into separate _on/off() functions.

> +{
> +	u32 reg = OTGCMD_OTG_DIS;
> +	u32 val;
> +	int ret;
> +
> +	/* switch OTG core */
> +	if (on) {
> +		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
> +		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> +						val & OTGSTS_HOST_READY,
> +						1, 100000);
> +		if (ret) {
> +			dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
> +			return ret;
> +		}
> +	} else {
> +		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP,
> +		       &cdns->otg_regs->cmd);
> +
> +		/* Waiting till H_IDLE state. */
> +		readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
> +					  !(val & OTGSTATE_HOST_STATE_MASK),
> +					  1, 2000000);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cdnsp_drd_switch_gadget - start/stop gadget.
> + * @cdns: Pointer to controller context structure.
> + * @on: 1 for start, 0 for stop.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +int cdnsp_drd_switch_gadget(struct cdnsp *cdns, int on)

There is no shared code for start and stop.  Just split this into two
functions:

int cdnsp_drd_gadget_on(struct cdnsp *cdns);
int cdnsp_drd_gadget_off(struct cdnsp *cdns);


> +{
> +	u32 reg = OTGCMD_OTG_DIS;

Delete the "reg" variable and use OTGCMD_OTG_DIS directly.

> +	u32 val;
> +	int ret;
> +
> +	/* switch OTG core */
> +	if (on) {
> +		writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +		dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
> +
> +		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> +						val & OTGSTS_DEV_READY,
> +						1, 100000);
> +		if (ret) {
> +			dev_err(cdns->dev, "timeout waiting for dev_ready\n");
> +			return ret;
> +		}
> +	} else {
> +		/*
> +		 * Driver should wait at least 10us after disabling Device
> +		 * before turning-off Device (DEV_BUS_DROP).
> +		 */
> +		usleep_range(20, 30);
> +		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP,
> +		       &cdns->otg_regs->cmd);
> +
> +		/* Waiting till DEV_IDLE state. */
> +		readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
> +					  !(val & OTGSTATE_DEV_STATE_MASK),
> +					  1, 2000000);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cdnsp_init_otg_mode - initialize drd controller.
> + * @cdns: Pointer to controller context structure.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +static int cdnsp_init_otg_mode(struct cdnsp *cdns)
> +{
> +	int ret = 0;

No need to initialize this.  It causes an unused assignment static
checker warning and it disables checking for uninitialized variables.

> +
> +	cdnsp_otg_disable_irq(cdns);
> +	/* clear all interrupts */
> +	writel(~(u32)0, &cdns->otg_regs->ivect);
> +
> +	ret = cdnsp_set_mode(cdns, USB_DR_MODE_OTG);
> +	if (ret)
> +		return ret;
> +
> +	cdnsp_otg_enable_irq(cdns);
> +	return ret;

	return 0;

> +}
> +
> +/**
> + * cdnsp_drd_update_mode - initialize mode of operation.
> + * @cdns: Pointer to controller context structure.
> + *
> + * Returns 0 on success otherwise negative errno.
> + */
> +int cdnsp_drd_update_mode(struct cdnsp *cdns)
> +{
> +	int ret = 0;

Don't initialize.

> +
> +	switch (cdns->dr_mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		ret = cdnsp_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
> +		break;
> +	case USB_DR_MODE_HOST:
> +		ret = cdnsp_set_mode(cdns, USB_DR_MODE_HOST);
> +		break;
> +	case USB_DR_MODE_OTG:
> +		ret = cdnsp_init_otg_mode(cdns);
> +		break;
> +	default:
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
> +			cdns->dr_mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t cdnsp_drd_thread_irq(int irq, void *data)
> +{
> +	struct cdnsp *cdns = data;
> +
> +	cdnsp_hw_role_switch(cdns);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * cdnsp_drd_irq - interrupt handler for OTG events.
> + *
> + * @irq: irq number for cdnsp core device.
> + * @data: Structure of cdnsp.
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE.
> + */
> +static irqreturn_t cdnsp_drd_irq(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	struct cdnsp *cdns = data;
> +	u32 reg;
> +
> +	if (cdns->dr_mode != USB_DR_MODE_OTG)
> +		return ret;

return IRQ_NONE;

> +
> +	reg = readl(&cdns->otg_regs->ivect);
> +

Delte this blank line.

> +	if (!reg)
> +		return ret;

return IRQ_NONE;

> +
> +	if (reg & OTGIEN_ID_CHANGE_INT) {
> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> +			cdnsp_get_id(cdns));
> +
> +		ret = IRQ_WAKE_THREAD;
> +	}
> +
> +	if (reg & (OTGIEN_VBUSVALID_RISE_INT | OTGIEN_VBUSVALID_FALL_INT)) {
> +		dev_dbg(cdns->dev, "OTG IRQ: new VBUS: %d\n",
> +			cdnsp_get_vbus(cdns));
> +
> +		ret = IRQ_WAKE_THREAD;
> +	}
> +
> +	writel(~(u32)0, &cdns->otg_regs->ivect);
> +
> +	return ret;
> +}
> +
> +int cdnsp_drd_init(struct cdnsp *cdns)
> +{
> +	int ret = 0;

Don't initialize

> +	u32 state;
> +
> +	cdns->otg_regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> +	if (IS_ERR(cdns->otg_regs))
> +		return PTR_ERR(cdns->otg_regs);
> +
> +	dev_info(cdns->dev, "DRD version (ID: %08x, rev: %08x)\n",
> +		 readl(&cdns->otg_regs->did),
> +		 readl(&cdns->otg_regs->rid));
> +
> +	state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> +
> +	/* Update dr_mode according to STRAP configuration. */
> +	cdns->dr_mode = USB_DR_MODE_OTG;
> +	if (state == OTGSTS_STRAP_HOST) {
> +		dev_dbg(cdns->dev, "Controller strapped to HOST\n");
> +		cdns->dr_mode = USB_DR_MODE_HOST;
> +	} else if (state == OTGSTS_STRAP_GADGET) {
> +		dev_dbg(cdns->dev, "Controller strapped to PERIPHERAL\n");
> +		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	ret = devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
> +					cdnsp_drd_irq,
> +					cdnsp_drd_thread_irq,
> +					IRQF_SHARED,
> +					dev_name(cdns->dev), cdns);
> +

Delete the blank line.

> +	if (ret) {
> +		dev_err(cdns->dev, "couldn't get otg_irq\n");
> +		return ret;
> +	}
> +
> +	state = readl(&cdns->otg_regs->sts);
> +	if (OTGSTS_OTG_NRDY(state) != 0) {

Remove the != 0

	if (OTGSTS_OTG_NRDY(state)) {

> +		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	return ret;

return 0;

> +}
> +
> +int cdnsp_drd_exit(struct cdnsp *cdns)
> +{
> +	cdnsp_otg_disable_irq(cdns);
> +	return 0;
> +}
> diff --git a/drivers/usb/cdnsp/drd.h b/drivers/usb/cdnsp/drd.h
> new file mode 100644
> index 000000000000..183080fd489e
> --- /dev/null
> +++ b/drivers/usb/cdnsp/drd.h
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence CDNSP DRD header file.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#ifndef __LINUX_CDNSP_DRD
> +#define __LINUX_CDNSP_DRD
> +
> +#include <linux/usb/otg.h>
> +#include <linux/phy/phy.h>
> +#include "core.h"
> +
> +/* DRD register interface. */
> +struct cdnsp_otg_regs {
> +	__le32 did;
> +	__le32 rid;
> +	__le32 cfgs1;
> +	__le32 cfgs2;
> +	__le32 cmd;
> +	__le32 sts;
> +	__le32 state;
> +	__le32 ien;
> +	__le32 ivect;
> +	__le32 tmr;
> +	__le32 simulate;
> +	__le32 adpbc_sts;
> +	__le32 adp_ramp_time;
> +	__le32 adpbc_ctrl1;
> +	__le32 adpbc_ctrl2;
> +	__le32 override;
> +	__le32 vbusvalid_dbnc_cfg;
> +	__le32 sessvalid_dbnc_cfg;
> +	__le32 susp_timing_ctrl;
> +};
> +
> +/* CDNS_RID - bitmasks. */
> +#define CDNS_RID(p)			((p) & GENMASK(15, 0))
> +
> +/* CDNS_VID - bitmasks. */
> +#define CDNS_DID(p)			((p) & GENMASK(31, 0))
> +
> +/* OTGCMD - bitmasks. */
> +/* "Request the bus for Device mode. */
> +#define OTGCMD_DEV_BUS_REQ		BIT(0)
> +/* Request the bus for Host mode. */
> +#define OTGCMD_HOST_BUS_REQ		BIT(1)
> +/* Enable OTG mode. */
> +#define OTGCMD_OTG_EN			BIT(2)
> +/* Disable OTG mode. */
> +#define OTGCMD_OTG_DIS			BIT(3)
> +/*"Configure OTG as A-Device. */
> +#define OTGCMD_A_DEV_EN			BIT(4)
> +/*"Configure OTG as A-Device. */
> +#define OTGCMD_A_DEV_DIS		BIT(5)
> +/* Drop the bus for Device mode. */
> +#define OTGCMD_DEV_BUS_DROP		BIT(8)
> +/* Drop the bus for Host mode. */
> +#define OTGCMD_HOST_BUS_DROP		BIT(9)
> +
> +/* OTGSTS - bitmasks. */
> +/*
> + * Current value of the ID pin. It is only valid when idpullup in
> + * OTGCTRL1_TYPE register is set to '1'.
> + */
> +#define OTGSTS_ID_VALUE			BIT(0)
> +/* Current value of the vbus_valid. */
> +#define OTGSTS_VBUS_VALID		BIT(1)
> +/* Current value of the b_sess_vld. */
> +#define OTGSTS_SESSION_VALID		BIT(2)
> +/* Device mode is active. */
> +#define OTGSTS_DEV_ACTIVE		BIT(3)
> +/* Host mode is active. */
> +#define OTGSTS_HOST_ACTIVE		BIT(4)
> +/* OTG Controller not ready. */
> +#define OTGSTS_OTG_NRDY(p)		((p) & BIT(11))
> +/*
> + * Value of the strap pins.
> + * 000 - No default configuration.
> + * 010 - Controller initiall configured as Host.
> + * 100 - Controller initially configured as Device.
> + */
> +#define OTGSTS_STRAP(p)			(((p) & GENMASK(13, 12)) >> 12)
> +#define OTGSTS_STRAP_NO_DEFAULT_CFG	0x00
> +#define OTGSTS_STRAP_HOST		0x01
> +#define OTGSTS_STRAP_GADGET		0x02
> +/* Device reade flag. */
> +#define OTGSTS_DEV_READY		BIT(26)
> +/* Host ready. */
> +#define OTGSTS_HOST_READY		BIT(27)
> +
> +/* OTGSTATE- bitmasks. */
> +#define OTGSTATE_DEV_STATE_MASK		GENMASK(2, 0)
> +#define OTGSTATE_HOST_STATE_MASK	GENMASK(5, 3)
> +#define OTGSTATE_HOST_STATE_IDLE	0x0
> +#define OTGSTATE_HOST_STATE_VBUS_FALL	0x7
> +#define OTGSTATE_HOST_STATE(p)		(((p) & OTGSTATE_HOST_STATE_MASK) >> 3)
> +
> +/* OTGIEN - bitmasks. */
> +/* ID change interrupt enable. */
> +#define OTGIEN_ID_CHANGE_INT		BIT(0)
> +/* Vbusvalid fall detected interrupt enable. */
> +#define OTGIEN_VBUSVALID_RISE_INT	BIT(4)
> +/* Vbusvalid fall detected interrupt enable. */
> +#define OTGIEN_VBUSVALID_FALL_INT	BIT(5)
> +
> +/* OVERRIDE - bitmasks. */
> +#define OVERRIDE_IDPULLUP		BIT(0)
> +/* Vbusvalid/Sesvalid override select. */
> +#define OVERRIDE_SESS_VLD_SEL		BIT(10)
> +
> +int cdnsp_is_host(struct cdnsp *cdns);
> +int cdnsp_is_device(struct cdnsp *cdns);
> +int cdnsp_get_id(struct cdnsp *cdns);
> +int cdnsp_get_vbus(struct cdnsp *cdns);
> +void cdnsp_clear_vbus(struct cdnsp *cdns);
> +void cdnsp_set_vbus(struct cdnsp *cdns);
> +int cdnsp_drd_init(struct cdnsp *cdns);
> +int cdnsp_drd_exit(struct cdnsp *cdns);
> +int cdnsp_drd_update_mode(struct cdnsp *cdns);
> +int cdnsp_drd_switch_gadget(struct cdnsp *cdns, int on);
> +int cdnsp_drd_switch_host(struct cdnsp *cdns, int on);
> +
> +#endif /* __LINUX_CDNSP_DRD */
> diff --git a/drivers/usb/cdnsp/ep0.c b/drivers/usb/cdnsp/ep0.c
> new file mode 100644
> index 000000000000..407a7ad06ddb
> --- /dev/null
> +++ b/drivers/usb/cdnsp/ep0.c
> @@ -0,0 +1,462 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + */
> +
> +#include <linux/usb/composite.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/list.h>
> +
> +#include "gadget.h"
> +
> +static void cdnsp_ep0_stall(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_request *preq;
> +	struct cdnsp_ep *pep;
> +	int ret = 0;

Delete the ret variable.  No one ever checks it.

> +
> +	pep = &pdev->eps[0];
> +	preq = next_request(&pep->pending_list);
> +
> +	if (pdev->three_stage_setup) {
> +		ret = cdnsp_halt_endpoint(pdev, pep, true);
> +
> +		if (preq)
> +			cdnsp_gadget_giveback(pep, preq, -ECONNRESET);
> +	} else {
> +		pep->ep_state |= EP0_HALTED_STATUS;
> +
> +		if (preq)
> +			list_del(&preq->list);
> +
> +		cdnsp_status_stage(pdev);
> +	}
> +}
> +
> +static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
> +				  struct usb_ctrlrequest *ctrl)
> +{
> +	int ret;
> +
> +	spin_unlock(&pdev->lock);
> +	ret = pdev->gadget_driver->setup(&pdev->gadget, ctrl);
> +	spin_lock(&pdev->lock);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_ep0_set_config(struct cdnsp_device *pdev,
> +				struct usb_ctrlrequest *ctrl)
> +{
> +	enum usb_device_state state = pdev->gadget.state;
> +	u32 cfg;
> +	int ret;
> +
> +	cfg = le16_to_cpu(ctrl->wValue);
> +
> +	switch (state) {
> +	case USB_STATE_ADDRESS:
> +		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (!cfg && !ret)
> +			usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);

Always do error handling, not success handling.

		if (ret)
			return ret;

Move the usb_gadget_set_state() after the end of the switch statement.


> +		break;
> +	case USB_STATE_CONFIGURED:
> +		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (!cfg && !ret)
> +			usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
> +		break;
> +	default:
> +		dev_err(pdev->dev, "Set Configuration - bad device state\n");
> +		ret = -EINVAL;
> +	}


	if (!cfg)
		usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);

	return 0;


> +
> +	return ret;
> +}
> +
> +static int cdnsp_ep0_set_address(struct cdnsp_device *pdev,
> +				 struct usb_ctrlrequest *ctrl)
> +{
> +	enum usb_device_state state = pdev->gadget.state;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	unsigned int slot_state;
> +	int dev_state;
> +	int ret = 0;

don't initialize

> +	u32 addr;
> +
> +	addr = le16_to_cpu(ctrl->wValue);
> +
> +	if (addr > 127) {
> +		dev_err(pdev->dev, "Invalid device address %d\n", addr);
> +		return -EINVAL;
> +	}
> +
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (state == USB_STATE_CONFIGURED) {
> +		dev_err(pdev->dev, "Can't Set Address from Configured State\n");
> +		return -EINVAL;
> +	}
> +
> +	pdev->device_address = le16_to_cpu(ctrl->wValue);
> +
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +	if (slot_state == SLOT_STATE_ADDRESSED)
> +		cdnsp_reset_device(pdev);
> +
> +	/*set device address*/
> +	ret = cdnsp_setup_device(pdev, SETUP_CONTEXT_ADDRESS);
> +	if (ret)
> +		return ret;
> +
> +	if (addr)
> +		usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
> +	else
> +		usb_gadget_set_state(&pdev->gadget, USB_STATE_DEFAULT);
> +
> +	return 0;
> +}
> +
> +int cdnsp_status_stage(struct cdnsp_device *pdev)
> +{
> +	pdev->ep0_stage = CDNSP_STATUS_STAGE;
> +	pdev->ep0_preq.request.length = 0;
> +
> +	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> +}
> +
> +int cdnsp_w_index_to_ep_index(__le32  wIndex)
> +{
> +	wIndex = le32_to_cpu(wIndex);
> +
> +	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
> +		return 0;
> +
> +	return ((wIndex & USB_ENDPOINT_NUMBER_MASK) * 2) +
> +		(wIndex & USB_ENDPOINT_DIR_MASK ? 1 : 0) - 1;
> +}
> +
> +static int cdnsp_ep0_handle_status(struct cdnsp_device *pdev,
> +				   struct usb_ctrlrequest *ctrl)
> +{
> +	struct cdnsp_ep *pep;
> +	__le16 *response;
> +	int ep_sts = 0;
> +	u16 status = 0;
> +	u32 recipient;
> +
> +	recipient = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +	switch (recipient) {
> +	case USB_RECIP_DEVICE:
> +		status = pdev->gadget.is_selfpowered |
> +			 ((pdev->u1_allowed) ? BIT(USB_DEV_STAT_U1_ENABLED) : 0) |
> +			 ((pdev->u2_allowed) ? BIT(USB_DEV_STAT_U2_ENABLED) : 0);
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		break;
> +	case USB_RECIP_ENDPOINT:
> +		pep = &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> +		ep_sts = GET_EP_CTX_STATE(pep->out_ctx);
> +
> +		/* check if endpoint is stalled */
> +		if (ep_sts == EP_STATE_HALTED)
> +			status =  BIT(USB_ENDPOINT_HALT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	response = (__le16 *)pdev->setup_buf;
> +	*response = cpu_to_le16(status);
> +
> +	pdev->ep0_preq.request.length = sizeof(*response);
> +	pdev->ep0_preq.request.buf = pdev->setup_buf;
> +
> +	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> +}
> +
> +void cdnsp_enter_test_mode(struct cdnsp_device *pdev)
> +{
> +	u32 temp;
> +
> +	temp = readl(&pdev->active_port->regs->portpmsc) & ~GENMASK(31, 28);
> +	temp |= PORT_TEST_MODE(pdev->test_mode);
> +	writel(temp, &pdev->active_port->regs->portpmsc);
> +	pdev->test_mode = 0;
> +}
> +
> +static int cdnsp_ep0_handle_feature_device(struct cdnsp_device *pdev,
> +					   struct usb_ctrlrequest *ctrl,
> +					   int set)
> +{
> +	enum usb_device_state state;
> +	enum usb_device_speed speed;
> +	int ret = 0;

Get rid of the "ret" variable and just return -EINVAL directly everywhere.

> +	u16 tmode;
> +
> +	state = pdev->gadget.state;
> +	speed = pdev->gadget.speed;
> +
> +	switch (le16_to_cpu(ctrl->wValue)) {
> +	case USB_DEVICE_REMOTE_WAKEUP:
> +		pdev->remote_wakeup_allowed = !!set;
> +		break;
> +	case USB_DEVICE_U1_ENABLE:
> +		if (state != USB_STATE_CONFIGURED || speed < USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		pdev->u1_allowed = !!set;
> +		break;
> +	case USB_DEVICE_U2_ENABLE:
> +		if (state != USB_STATE_CONFIGURED || speed < USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		pdev->u2_allowed = !!set;
> +		break;
> +	case USB_DEVICE_LTM_ENABLE:
> +		ret = -EINVAL;
> +		break;
> +	case USB_DEVICE_TEST_MODE:
> +		if (state != USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
> +			return -EINVAL;
> +
> +		tmode = le16_to_cpu(ctrl->wIndex);
> +
> +		if (!set || (tmode & 0xff) != 0)
> +			return -EINVAL;
> +
> +		tmode = tmode >> 8;
> +
> +		if (tmode > TEST_FORCE_EN || tmode < TEST_J)
> +			return -EINVAL;
> +
> +		pdev->test_mode = tmode;
> +
> +		/*
> +		 * Test mode must be set before Status Stage but controller
> +		 * will start testing sequence after Status Stage.
> +		 */
> +		cdnsp_enter_test_mode(pdev);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdnsp_ep0_handle_feature_intf(struct cdnsp_device *pdev,
> +					 struct usb_ctrlrequest *ctrl,
> +					 int set)
> +{
> +	u32 wValue;
> +	int ret = 0;
> +
> +	wValue = le16_to_cpu(ctrl->wValue);
> +
> +	switch (wValue) {
> +	case USB_INTRF_FUNC_SUSPEND:


Is this function supposed to do something?

> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdnsp_ep0_handle_feature_endpoint(struct cdnsp_device *pdev,
> +					     struct usb_ctrlrequest *ctrl,
> +					     int set)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	struct cdnsp_ep *pep;
> +	int ret = 0;

Don't initialize

> +	u32 wValue;
> +
> +	wValue = le16_to_cpu(ctrl->wValue);
> +	pep = &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> +	ep_ring = pep->ring;
> +
> +	switch (wValue) {
> +	case USB_ENDPOINT_HALT:
> +		if (!set && (pep->ep_state & EP_WEDGE)) {
> +			/* Resets Sequence Number */
> +			cdnsp_halt_endpoint(pdev, pep, 0);
> +			cdnsp_halt_endpoint(pdev, pep, 1);
> +			break;
> +		}
> +
> +		ret = cdnsp_halt_endpoint(pdev, pep, set);
> +		break;
> +	default:
> +		dev_warn(pdev->dev, "WARN Incorrect wValue %04x\n", wValue);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +int cdnsp_ep0_handle_feature(struct cdnsp_device *pdev,
> +			     struct usb_ctrlrequest *ctrl,
> +			     int set)
> +{
> +	switch (ctrl->bRequestType & USB_RECIP_MASK) {
> +	case USB_RECIP_DEVICE:
> +		return cdnsp_ep0_handle_feature_device(pdev, ctrl, set);
> +	case USB_RECIP_INTERFACE:
> +		return cdnsp_ep0_handle_feature_intf(pdev, ctrl, set);
> +	case USB_RECIP_ENDPOINT:
> +		return cdnsp_ep0_handle_feature_endpoint(pdev, ctrl, set);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cdnsp_ep0_set_sel(struct cdnsp_device *pdev,
> +			     struct usb_ctrlrequest *ctrl)
> +{
> +	enum usb_device_state state = pdev->gadget.state;
> +	u16 wLength;
> +
> +	if (state == USB_STATE_DEFAULT)
> +		return -EINVAL;
> +
> +	wLength = le16_to_cpu(ctrl->wLength);
> +
> +	if (wLength != 6) {
> +		dev_err(pdev->dev, "Set SEL should be 6 bytes, got %d\n",
> +			wLength);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * To handle Set SEL we need to receive 6 bytes from Host. So let's
> +	 * queue a usb_request for 6 bytes.
> +	 */
> +	pdev->ep0_preq.request.length = 0x6;

Just use decimal size values.

> +	pdev->ep0_preq.request.buf = pdev->setup_buf;
> +
> +	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> +}
> +
> +static int cdnsp_ep0_set_isoch_delay(struct cdnsp_device *pdev,
> +				     struct usb_ctrlrequest *ctrl)
> +{
> +	if (le16_to_cpu(ctrl->wIndex) || le16_to_cpu(ctrl->wLength))
> +		return -EINVAL;
> +
> +	pdev->gadget.isoch_delay = le16_to_cpu(ctrl->wValue);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_ep0_std_request(struct cdnsp_device *pdev,
> +				 struct usb_ctrlrequest *ctrl)
> +{
> +	int ret = 0;

Don't initialize

> +
> +	switch (ctrl->bRequest) {
> +	case USB_REQ_GET_STATUS:
> +		ret = cdnsp_ep0_handle_status(pdev, ctrl);
> +		break;
> +	case USB_REQ_CLEAR_FEATURE:
> +		ret = cdnsp_ep0_handle_feature(pdev, ctrl, 0);
> +		break;
> +	case USB_REQ_SET_FEATURE:
> +		ret = cdnsp_ep0_handle_feature(pdev, ctrl, 1);
> +		break;
> +	case USB_REQ_SET_ADDRESS:
> +		ret = cdnsp_ep0_set_address(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_CONFIGURATION:
> +		ret = cdnsp_ep0_set_config(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_SEL:
> +		ret = cdnsp_ep0_set_sel(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_ISOCH_DELAY:
> +		ret = cdnsp_ep0_set_isoch_delay(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_INTERFACE:
> +		/*
> +		 * Add request into pending list to block sending status stage
> +		 * by libcomposite.
> +		 */
> +		list_add_tail(&pdev->ep0_preq.list,
> +			      &pdev->ep0_preq.pep->pending_list);
> +
> +		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (ret == -EBUSY)
> +			ret = 0;
> +
> +		list_del(&pdev->ep0_preq.list);
> +		break;
> +	default:
> +		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
> +		break;
> +	}
> +	return ret;
> +}
> +
> +void cdnsp_setup_analyze(struct cdnsp_device *pdev)
> +{
> +	struct usb_ctrlrequest *ctrl = &pdev->setup;
> +	int ret = 0;
> +	__le16 len;
> +
> +	if (!pdev->gadget_driver)
> +		goto out;
> +
> +	if (pdev->gadget.state == USB_STATE_NOTATTACHED) {
> +		dev_err(pdev->dev, "ERR: Setup detected in unattached state\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Restore the ep0 to Stopped/Running state. */
> +	if (pdev->eps[0].ep_state & EP_HALTED)
> +		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> +
> +	/*
> +	 * Finishing previous SETUP transfer by removing request from
> +	 * list and informing upper layer
> +	 */
> +	if (!list_empty(&pdev->eps[0].pending_list)) {
> +		struct cdnsp_request	*req;
> +
> +		req = next_request(&pdev->eps[0].pending_list);
> +		cdnsp_ep_dequeue(&pdev->eps[0], req);
> +	}
> +
> +	len = le16_to_cpu(ctrl->wLength);
> +	if (!len) {
> +		pdev->three_stage_setup = false;
> +		pdev->ep0_expect_in = false;
> +	} else {
> +		pdev->three_stage_setup = true;
> +		pdev->ep0_expect_in = !!(ctrl->bRequestType & USB_DIR_IN);
> +	}
> +
> +	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
> +		ret = cdnsp_ep0_std_request(pdev, ctrl);
> +	else
> +		ret = cdnsp_ep0_delegate_req(pdev, ctrl);
> +
> +	if (!len)
> +		pdev->ep0_stage = CDNSP_STATUS_STAGE;
> +
> +	if (ret == USB_GADGET_DELAYED_STATUS)
> +		return;
> +out:
> +	if (ret < 0)
> +		cdnsp_ep0_stall(pdev);
> +	else if (pdev->ep0_stage == CDNSP_STATUS_STAGE)
> +		cdnsp_status_stage(pdev);
> +}
> diff --git a/drivers/usb/cdnsp/export.h b/drivers/usb/cdnsp/export.h
> new file mode 100644
> index 000000000000..0d8797ef7840
> --- /dev/null
> +++ b/drivers/usb/cdnsp/export.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence CDNSP DRD Driver - Gadget/Host Export APIs.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNSP_EXPORT
> +#define __LINUX_CDNSP_EXPORT
> +
> +#if IS_ENABLED(CONFIG_USB_CDNSP_GADGET)
> +int cdnsp_gadget_init(struct cdnsp *cdns);
> +void cdnsp_gadget_exit(struct cdnsp *cdns);
> +#else
> +static inline int cdnsp_gadget_init(struct cdnsp *cdns)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline void cdnsp_gadget_exit(struct cdnsp *cdns) { }
> +#endif /* CONFIG_USB_CDNSP_GADGET */
> +
> +#if IS_ENABLED(CONFIG_USB_CDNSP_HOST)
> +int cdnsp_host_init(struct cdnsp *cdns);
> +void cdnsp_host_exit(struct cdnsp *cdns);
> +#else
> +static inline int cdnsp_host_init(struct cdnsp *cdns)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline void cdnsp_host_exit(struct cdnsp *cdns) { }
> +#endif /* CONFIG_USB_CDNSP_HOST */
> +
> +#endif /* __LINUX_CDNSP_EXPORT */
> diff --git a/drivers/usb/cdnsp/gadget.c b/drivers/usb/cdnsp/gadget.c
> new file mode 100644
> index 000000000000..8cba6a22c998
> --- /dev/null
> +++ b/drivers/usb/cdnsp/gadget.c
> @@ -0,0 +1,1935 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + */
> +
> +#include <linux/moduleparam.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/iopoll.h>
> +#include <linux/delay.h>
> +#include <linux/log2.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/dmi.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "drd.h"
> +
> +unsigned int cdnsp_port_speed(unsigned int port_status)
> +{
> +	/*Detect gadget speed based on PORTSC register*/
> +	if (DEV_SUPERSPEEDPLUS(port_status))
> +		return USB_SPEED_SUPER_PLUS;
> +	else if (DEV_SUPERSPEED(port_status))
> +		return USB_SPEED_SUPER;
> +	else if (DEV_HIGHSPEED(port_status))
> +		return USB_SPEED_HIGH;
> +	else if (DEV_FULLSPEED(port_status))
> +		return USB_SPEED_FULL;
> +
> +	/* If device is detached then speed will be USB_SPEED_UNKNOWN.*/
> +	return USB_SPEED_UNKNOWN;
> +}
> +
> +/*
> + * Given a port state, this function returns a value that would result in the
> + * port being in the same state, if the value was written to the port status
> + * control register.
> + * Save Read Only (RO) bits and save read/write bits where
> + * writing a 0 clears the bit and writing a 1 sets the bit (RWS).
> + * For all other types (RW1S, RW1CS, RW, and RZ), writing a '0' has no effect.
> + */
> +u32 cdnsp_port_state_to_neutral(u32 state)
> +{
> +	/* Save read-only status and port state. */
> +	return (state & CDNSP_PORT_RO) | (state & CDNSP_PORT_RWS);
> +}
> +
> +/**
> + * Find the offset of the extended capabilities with capability ID id.
> + * @base: PCI MMIO registers base address.
> + * @start: Address at which to start looking, (0 or HCC_PARAMS to start at
> + *         beginning of list)
> + * @id: Extended capability ID to search for.
> + *
> + * Returns the offset of the next matching extended capability structure.
> + * Some capabilities can occur several times,
> + * e.g., the EXT_CAPS_PROTOCOL, and this provides a way to find them all.
> + */
> +int cdnsp_find_next_ext_cap(void __iomem *base, u32 start, int id)
> +{
> +	u32 offset = start;
> +	u32 next;
> +	u32 val;
> +
> +	if (!start || start == HCC_PARAMS_OFFSET) {
> +		val = readl(base + HCC_PARAMS_OFFSET);
> +		if (val == ~0)
> +			return 0;
> +
> +		offset = HCC_EXT_CAPS(val) << 2;
> +		if (!offset)
> +			return 0;
> +	};
> +
> +	do {
> +		val = readl(base + offset);
> +		if (val == ~0)
> +			return 0;
> +
> +		if (EXT_CAPS_ID(val) == id && offset != start)
> +			return offset;
> +
> +		next = EXT_CAPS_NEXT(val);
> +		offset += next << 2;
> +	} while (next);
> +
> +	return 0;
> +}
> +
> +void cdnsp_set_link_state(struct cdnsp_device *pdev,
> +			  __le32 __iomem *port_regs,
> +			  u32 link_state)
> +{
> +	int port_num = 0xFF;
> +	u32 temp;
> +
> +	temp = readl(port_regs);
> +	temp = cdnsp_port_state_to_neutral(temp);
> +	temp |= PORT_WKCONN_E | PORT_WKDISC_E;
> +	writel(temp, port_regs);
> +
> +	temp &= ~PORT_PLS_MASK;
> +	temp |= PORT_LINK_STROBE | link_state;
> +
> +	if (pdev->active_port)
> +		port_num = pdev->active_port->port_num;
> +
> +	writel(temp, port_regs);
> +}
> +
> +static void cdnsp_disable_port(struct cdnsp_device *pdev,
> +			       __le32 __iomem *port_regs)
> +{
> +	u32 temp = cdnsp_port_state_to_neutral(readl(port_regs));
> +
> +	writel(temp | PORT_PED, port_regs);
> +}
> +
> +static void cdnsp_clear_port_change_bit(struct cdnsp_device *pdev,
> +					__le32 __iomem *port_regs)
> +{
> +	u32 portsc = readl(port_regs);
> +
> +	writel(cdnsp_port_state_to_neutral(portsc) |
> +	       (portsc & PORT_CHANGE_BITS), port_regs);
> +}
> +
> +static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
> +{
> +	__le32 __iomem *reg;
> +	void __iomem *base;
> +	u32 offset = 0;
> +
> +	base = &pdev->cap_regs->hc_capbase;
> +	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
> +	reg = base + offset + REG_CHICKEN_BITS_2_OFFSET;
> +
> +	bit = readl(reg) | bit;
> +	writel(bit, reg);
> +}
> +
> +static void cdnsp_clear_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
> +{
> +	__le32 __iomem *reg;
> +	void __iomem *base;
> +	u32 offset = 0;
> +
> +	base = &pdev->cap_regs->hc_capbase;
> +	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
> +	reg = base + offset + REG_CHICKEN_BITS_2_OFFSET;
> +
> +	bit = readl(reg) & ~bit;
> +	writel(bit, reg);
> +}
> +
> +/*
> + * Disable interrupts and begin the controller halting process.
> + */
> +static void cdnsp_quiesce(struct cdnsp_device *pdev)
> +{
> +	u32 halted;
> +	u32 mask;
> +	u32 cmd;
> +
> +	mask = ~(u32)(CDNSP_IRQS);
> +
> +	halted = readl(&pdev->op_regs->status) & STS_HALT;
> +	if (!halted)
> +		mask &= ~(CMD_R_S | CMD_DEVEN);
> +
> +	cmd = readl(&pdev->op_regs->command);
> +	cmd &= mask;
> +	writel(cmd, &pdev->op_regs->command);
> +}
> +
> +/*
> + * Force controller into halt state.
> + *
> + * Disable any IRQs and clear the run/stop bit.
> + * Controller will complete any current and actively pipelined transactions, and
> + * should halt within 16 ms of the run/stop bit being cleared.
> + * Read controller Halted bit in the status register to see when the
> + * controller is finished.
> + */
> +int cdnsp_halt(struct cdnsp_device *pdev)
> +{
> +	int ret;
> +	u32 val;
> +
> +	cdnsp_quiesce(pdev);
> +
> +	ret = readl_poll_timeout_atomic(&pdev->op_regs->status, val,
> +					val & STS_HALT, 1,
> +					CDNSP_MAX_HALT_USEC);
> +	if (ret) {
> +		dev_err(pdev->dev, "ERROR: Device halt failed\n");
> +		return ret;
> +	}
> +
> +	pdev->cdnsp_state |= CDNSP_STATE_HALTED;
> +	return ret;

return 0;

> +}
> +
> +/*
> + * device controller died, register read returns 0xffffffff, or command never
> + * ends.
> + */
> +void cdnsp_died(struct cdnsp_device *pdev)
> +{
> +	dev_err(pdev->dev, "ERROR: CDNSP controller not responding\n");
> +	pdev->cdnsp_state |= CDNSP_STATE_DYING;
> +	cdnsp_halt(pdev);
> +}
> +
> +/*
> + * Set the run bit and wait for the device to be running.
> + */
> +static int cdnsp_start(struct cdnsp_device *pdev)
> +{
> +	u32 temp;
> +	int ret;
> +
> +	temp = readl(&pdev->op_regs->command);
> +	temp |= (CMD_R_S | CMD_DEVEN);
> +	writel(temp, &pdev->op_regs->command);
> +
> +	/*
> +	 * Wait for the STS_HALT Status bit to be 0 to indicate the device is
> +	 * running.
> +	 */
> +	ret = readl_poll_timeout_atomic(&pdev->op_regs->status, temp,
> +					!(temp & STS_HALT), 1,
> +					CDNSP_MAX_HALT_USEC);
> +
> +	pdev->cdnsp_state = 0;
> +
> +	if (ret) {
> +		pdev->cdnsp_state = CDNSP_STATE_DYING;
> +		dev_err(pdev->dev, "ERROR: Controller run failed\n");
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Reset a halted controller.
> + *
> + * This resets pipelines, timers, counters, state machines, etc.
> + * Transactions will be terminated immediately, and operational registers
> + * will be set to their defaults.
> + */
> +int cdnsp_reset(struct cdnsp_device *pdev)
> +{
> +	u32 command;
> +	u32 temp;
> +	int ret;
> +
> +	temp = readl(&pdev->op_regs->status);
> +
> +	if (temp == ~(u32)0) {
> +		dev_err(pdev->dev, "Device not accessible, reset failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	if ((temp & STS_HALT) == 0) {
> +		dev_err(pdev->dev, "Controller not halted, aborting reset.\n");
> +		return -EINVAL;
> +	}
> +
> +	command = readl(&pdev->op_regs->command);
> +	command |= CMD_RESET;
> +	writel(command, &pdev->op_regs->command);
> +
> +	ret = readl_poll_timeout_atomic(&pdev->op_regs->command, temp,
> +					!(temp & CMD_RESET), 1,
> +					10 * 1000);
> +	if (ret) {
> +		dev_err(pdev->dev, "ERROR: Controller reset failed\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * CDNSP cannot write any doorbells or operational registers other
> +	 * than status until the "Controller Not Ready" flag is cleared.
> +	 */
> +	ret = readl_poll_timeout_atomic(&pdev->op_regs->status, temp,
> +					!(temp & STS_CNR), 1,
> +					10 * 1000);
> +
> +	if (ret) {
> +		dev_err(pdev->dev, "ERROR: Controller not ready to work\n");
> +		return ret;
> +	}
> +
> +	dev_info(pdev->dev, "Controller ready to work");
> +
> +	return ret;
> +}
> +
> +/*
> + * cdnsp_get_endpoint_index - Find the index for an endpoint given its
> + * descriptor.Use the return value to right shift 1 for the bitmask.
> + *
> + * Index = (epnum * 2) + direction - 1,
> + * where direction = 0 for OUT, 1 for IN.
> + * For control endpoints, the IN index is used (OUT index is unused), so
> + * index = (epnum * 2) + direction - 1 = (epnum * 2) + 1 - 1 = (epnum * 2)
> + */
> +static unsigned int
> +	cdnsp_get_endpoint_index(const struct usb_endpoint_descriptor *desc)
> +{
> +	unsigned int index = (unsigned int)usb_endpoint_num(desc);
> +
> +	if (usb_endpoint_xfer_control(desc))
> +		return index * 2;
> +
> +	return (index * 2) + (usb_endpoint_dir_in(desc) ? 1 : 0) - 1;
> +}
> +
> +/*
> + * Find the flag for this endpoint (for use in the control context). Use the
> + * endpoint index to create a bitmask. The slot context is bit 0, endpoint 0 is
> + * bit 1, etc.
> + */
> +static unsigned int
> +	cdnsp_get_endpoint_flag(const struct usb_endpoint_descriptor *desc)
> +{
> +	return 1 << (cdnsp_get_endpoint_index(desc) + 1);
> +}
> +
> +int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
> +{
> +	struct cdnsp_device *pdev = pep->pdev;
> +	struct usb_request *request;
> +	int ret = 0;

don't initialize

> +
> +	if (preq->epnum == 0 && !list_empty(&pep->pending_list))
> +		return -EBUSY;
> +
> +	request = &preq->request;
> +	request->actual = 0;
> +	request->status = -EINPROGRESS;
> +	preq->direction = pep->direction;
> +	preq->epnum = pep->number;
> +	preq->td.drbl = 0;
> +
> +	ret = usb_gadget_map_request_by_dev(pdev->dev, request, pep->direction);
> +	if (ret)
> +		goto err;

Return directly. "return ret;"

> +
> +	list_add_tail(&preq->list, &pep->pending_list);
> +
> +	switch (usb_endpoint_type(pep->endpoint.desc)) {
> +	case USB_ENDPOINT_XFER_CONTROL:
> +		ret = cdnsp_queue_ctrl_tx(pdev, preq);
> +		break;
> +	case USB_ENDPOINT_XFER_BULK:
> +	case USB_ENDPOINT_XFER_INT:
> +		ret = cdnsp_queue_bulk_tx(pdev, preq);
> +		break;
> +	case USB_ENDPOINT_XFER_ISOC:
> +		ret = cdnsp_queue_isoc_tx_prepare(pdev, preq);
> +	}
> +
> +	if (!ret)
> +		return ret;

Flip this around.  Always to do error handling, not success handling.

	if (ret)
		goto unmap;

	return 0;

unmap:
	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
					pep->direction);
	list_del(&preq->list);
	return ret;

> +
> +	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
> +					pep->direction);
> +	list_del(&preq->list);
> +
> +err:
> +
> +	return ret;
> +}
> +
> +/*
> + * Remove the request's TD from the endpoint ring. This may cause the
> + * controller to stop USB transfers, potentially stopping in the middle of a
> + * TRB buffer. The controller should pick up where it left off in the TD,
> + * unless a Set Transfer Ring Dequeue Pointer is issued.
> + *
> + * The TRBs that make up the buffers for the canceled request will be "removed"
> + * from the ring. Since the ring is a contiguous structure, they can't be
> + * physically removed. Instead, there are two options:
> + *
> + *  1) If the controller is in the middle of processing the request to be
> + *     canceled, we simply move the ring's dequeue pointer past those TRBs
> + *     using the Set Transfer Ring Dequeue Pointer command. This will be
> + *     the common case, when drivers timeout on the last submitted request
> + *     and attempt to cancel.
> + *
> + *  2) If the controller is in the middle of a different TD, we turn the TRBs
> + *     into a series of 1-TRB transfer no-op TDs. No-ops shouldn't be chained.
> + *     The controller will need to invalidate the any TRBs it has cached after
> + *     the stop endpoint command.
> + *
> + *  3) The TD may have completed by the time the Stop Endpoint Command
> + *     completes, so software needs to handle that case too.
> + *
> + */
> +int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
> +{
> +	struct cdnsp_device *pdev;

	struct cdnsp_device *pdev = pep->pdev;

> +	int ret = 0;

Don't initialize

> +
> +	pdev = pep->pdev;
> +
> +	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_RUNNING) {
> +		ret = cdnsp_cmd_stop_ep(pdev, pep);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = cdnsp_remove_request(pdev, preq, pep);
> +
> +	return ret;

	return cdnsp_remove_request(pdev, preq, pep);

> +}
> +
> +static void cdnsp_zero_in_ctx(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	struct cdnsp_ep_ctx *ep_ctx;
> +	int i;
> +
> +	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +
> +	/*
> +	 * When a device's add flag and drop flag are zero, any subsequent
> +	 * configure endpoint command will leave that endpoint's state
> +	 * untouched. Make sure we don't leave any old state in the input
> +	 * endpoint contexts.
> +	 */
> +	ctrl_ctx->drop_flags = 0;
> +	ctrl_ctx->add_flags = 0;
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	slot_ctx->dev_info &= cpu_to_le32(~LAST_CTX_MASK);
> +
> +	/* Endpoint 0 is always valid */
> +	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1));
> +	for (i = 1; i < 31; ++i) {
> +		ep_ctx = cdnsp_get_ep_ctx(&pdev->in_ctx, i);
> +		ep_ctx->ep_info = 0;
> +		ep_ctx->ep_info2 = 0;
> +		ep_ctx->deq = 0;
> +		ep_ctx->tx_info = 0;
> +	}
> +}
> +
> +/* Issue a configure endpoint command and wait for it to finish. */
> +static int cdnsp_configure_endpoint(struct cdnsp_device *pdev)
> +{
> +	int ret;
> +
> +	cdnsp_queue_configure_endpoint(pdev, pdev->cmd.in_ctx->dma);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +

Delete the blank line.  The call and the error handling are part of the
same paragraph.

> +	if (ret) {
> +		ret = -EINVAL;
> +		dev_err(pdev->dev,
> +			"ERR: unexpected command completion code 0x%x.\n", ret);
                                                                           ^^^
This is always -EINVAL because we just set it on the line before.
Preserve the error code.

> +	}
> +
> +	return ret;
> +}
> +
> +static void cdnsp_invalidate_ep_events(struct cdnsp_device *pdev,
> +				       struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_segment *segment;
> +	union cdnsp_trb *event;
> +	u32 cycle_state;
> +	__le32  data;
> +
> +	event = pdev->event_ring->dequeue;
> +	segment = pdev->event_ring->deq_seg;
> +	cycle_state = pdev->event_ring->cycle_state;
> +
> +	while (1) {
> +		data = le32_to_cpu(event->trans_event.flags);
> +
> +		/* Check the owner of the TRB. */
> +		if ((data & TRB_CYCLE) != cycle_state)
> +			break;
> +
> +		if (TRB_FIELD_TO_TYPE(data) == TRB_TRANSFER &&
> +		    TRB_TO_EP_ID(data) == (pep->idx + 1)) {
> +			data |= TRB_EVENT_INVALIDATE;
> +			event->trans_event.flags = cpu_to_le32(data);
> +		}
> +
> +		if (cdnsp_last_trb_on_seg(segment, event)) {
> +			cycle_state ^= 1;
> +			segment = pdev->event_ring->deq_seg->next;
> +			event = segment->trbs;
> +		} else {
> +			event++;
> +		}
> +	}
> +}
> +
> +int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_segment *event_deq_seg;
> +	dma_addr_t cmd_deq_dma;
> +	union cdnsp_trb *cmd_trb;
> +	union cdnsp_trb *event;
> +	u32 cycle_state;
> +	__le32  flags;
> +	int ret, val;
> +	u64 cmd_dma;
> +
> +	cmd_trb = pdev->cmd.command_trb;
> +	pdev->cmd.status = 0;
> +
> +	ret = readl_poll_timeout_atomic(&pdev->op_regs->cmd_ring, val,
> +					!CMD_RING_BUSY(val), 1,
> +					CDNSP_CMD_TIMEOUT);
> +	if (ret) {
> +		dev_err(pdev->dev, "ERR: Timeout while waiting for command\n");
> +		pdev->cdnsp_state = CDNSP_STATE_DYING;
> +		return -ETIMEDOUT;
> +	}
> +
> +	event = pdev->event_ring->dequeue;
> +	event_deq_seg = pdev->event_ring->deq_seg;
> +	cycle_state = pdev->event_ring->cycle_state;
> +
> +	cmd_deq_dma = cdnsp_trb_virt_to_dma(pdev->cmd_ring->deq_seg, cmd_trb);
> +

Delete the blank line.

> +	if (!cmd_deq_dma)
> +		return -EINVAL;
> +
> +	while (1) {
> +		flags = le32_to_cpu(event->event_cmd.flags);
> +
> +		/* Check the owner of the TRB. */
> +		if ((flags & TRB_CYCLE) != cycle_state)
> +			return -EINVAL;
> +
> +		cmd_dma = le64_to_cpu(event->event_cmd.cmd_trb);
> +
> +		/*
> +		 * Check whether the completion event is for last queued
> +		 * command.
> +		 */
> +		if (TRB_FIELD_TO_TYPE(flags) != TRB_COMPLETION ||
> +		    cmd_dma != (u64)cmd_deq_dma) {
> +			if (!cdnsp_last_trb_on_seg(event_deq_seg, event)) {
> +				event++;
> +				continue;
> +			}
> +
> +			if (cdnsp_last_trb_on_ring(pdev->event_ring,
> +						   event_deq_seg, event))
> +				cycle_state ^= 1;
> +
> +			event_deq_seg = event_deq_seg->next;
> +			event = event_deq_seg->trbs;
> +			continue;
> +		}
> +
> +		pdev->cmd.status = GET_COMP_CODE(le32_to_cpu(event->event_cmd.status));
> +		if (pdev->cmd.status == COMP_SUCCESS)
> +			return 0;
> +
> +		return -pdev->cmd.status;
> +	}
> +
> +	return 0;
> +}
> +
> +int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep,
> +			int value)
> +{
> +	int ret = 0;

Don't initialize

> +
> +	if (value) {
> +		ret = cdnsp_cmd_stop_ep(pdev, pep);
> +		if (ret < 0)

if (ret)

> +			return ret;
> +
> +		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_STOPPED) {
> +			cdnsp_queue_halt_endpoint(pdev, pep->idx);
> +			cdnsp_ring_cmd_db(pdev);
> +			ret = cdnsp_wait_for_cmd_compl(pdev);
> +		}
> +
> +		pep->ep_state |= EP_HALTED;
> +	} else {
> +		/*
> +		 * In device mode driver can call reset endpoint command
> +		 * from any endpoint state.
> +		 */
> +		cdnsp_queue_reset_ep(pdev, pep->idx);
> +		cdnsp_ring_cmd_db(pdev);
> +		ret = cdnsp_wait_for_cmd_compl(pdev);
> +		if (ret)
> +			return ret;
> +
> +		pep->ep_state &= ~EP_HALTED;
> +
> +		if (pep->idx != 0 && !(pep->ep_state & EP_WEDGE))
> +			cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +
> +		pep->ep_state &= ~EP_WEDGE;
> +	}
> +
> +	return ret;

return 0;

> +}
> +
> +static int cdnsp_update_eps_configuration(struct cdnsp_device *pdev,
> +					  struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	u32 new_add_flags, new_drop_flags;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int ret = 0;
> +	u32 ep_sts;
> +	int i;
> +
> +	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +
> +	/* Don't issue the command if there's no endpoints to update. */
> +	if (ctrl_ctx->add_flags == 0 && ctrl_ctx->drop_flags == 0)
> +		return 0;
> +
> +	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
> +	ctrl_ctx->add_flags &= cpu_to_le32(~EP0_FLAG);
> +	ctrl_ctx->drop_flags &= cpu_to_le32(~(SLOT_FLAG | EP0_FLAG));
> +
> +	/* Fix up Context Entries field. Minimum value is EP0 == BIT(1). */
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	for (i = 31; i >= 1; i--) {
> +		__le32 le32 = cpu_to_le32(BIT(i));
> +
> +		if ((pdev->eps[i - 1].ring && !(ctrl_ctx->drop_flags & le32)) ||
> +		    (ctrl_ctx->add_flags & le32) || i == 1) {
> +			slot_ctx->dev_info &= cpu_to_le32(~LAST_CTX_MASK);
> +			slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(i));
> +			break;
> +		}
> +	}
> +
> +	ep_sts = GET_EP_CTX_STATE(pep->out_ctx);
> +	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
> +	new_drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
> +
> +	if ((ctrl_ctx->add_flags != cpu_to_le32(SLOT_FLAG) &&
> +	     ep_sts == EP_STATE_DISABLED) ||
> +	    (ep_sts != EP_STATE_DISABLED && ctrl_ctx->drop_flags))
> +		ret = cdnsp_configure_endpoint(pdev);
> +
> +	cdnsp_zero_in_ctx(pdev);
> +
> +	return ret;
> +}
> +
> +/*
> + * This submits a Reset Device Command, which will set the device state to 0,
> + * set the device address to 0, and disable all the endpoints except the default
> + * control endpoint. The USB core should come back and call
> + * cdnsp_setup_device(), and then re-set up the configuration.
> + */
> +int cdnsp_reset_device(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int slot_state;
> +	int ret = 0;

Don't initialize

> +	int i;
> +
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	slot_ctx->dev_info = 0;
> +	pdev->device_address = 0;
> +
> +	/* If device is not setup, there is no point in resetting it. */
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (slot_state <= SLOT_STATE_DEFAULT &&
> +	    pdev->eps[0].ep_state & EP_HALTED) {
> +		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> +	}
> +
> +	/*
> +	 * During Reset Device command controller shall transition the
> +	 * endpoint ep0 to the Running State.
> +	 */
> +	pdev->eps[0].ep_state &= ~(EP_STOPPED | EP_HALTED);
> +	pdev->eps[0].ep_state |= EP_ENABLED;
> +
> +	if (slot_state <= SLOT_STATE_DEFAULT)
> +		return 0;
> +
> +	cdnsp_queue_reset_device(pdev);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +
> +	/*
> +	 * After Reset Device command all not default endpoints
> +	 * are in Disabled state.
> +	 */
> +	for (i = 1; i < 31; ++i)
> +		pdev->eps[i].ep_state |= EP_STOPPED;
> +
> +	if (ret)
> +		dev_err(pdev->dev, "Reset device failed with error code %d",
> +			ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Sets the MaxPStreams field and the Linear Stream Array field.
> + * Sets the dequeue pointer to the stream context array.
> + */
> +static void cdnsp_setup_streams_ep_input_ctx(struct cdnsp_device *pdev,
> +					     struct cdnsp_ep_ctx *ep_ctx,
> +					     struct cdnsp_stream_info *stream_info)
> +{
> +	u32 max_primary_streams;
> +
> +	/* MaxPStreams is the number of stream context array entries, not the
> +	 * number we're actually using. Must be in 2^(MaxPstreams + 1) format.
> +	 * fls(0) = 0, fls(0x1) = 1, fls(0x10) = 2, fls(0x100) = 3, etc.
> +	 */
> +	max_primary_streams = fls(stream_info->num_stream_ctxs) - 2;
> +	ep_ctx->ep_info &= cpu_to_le32(~EP_MAXPSTREAMS_MASK);
> +	ep_ctx->ep_info |= cpu_to_le32(EP_MAXPSTREAMS(max_primary_streams)
> +				       | EP_HAS_LSA);
> +	ep_ctx->deq  = cpu_to_le64(stream_info->ctx_array_dma);
> +}
> +
> +/*
> + * The drivers use this function to prepare a bulk endpoints to use streams.
> + *
> + * Don't allow the call to succeed if endpoint only supports one stream
> + * (which means it doesn't support streams at all).
> + */
> +int cdnsp_alloc_streams(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	unsigned int num_streams = usb_ss_max_streams(pep->endpoint.comp_desc);
> +	unsigned int num_stream_ctxs;
> +	int ret = 0;

Don't initialize

> +
> +	if (num_streams ==  0)
> +		return 0;
> +
> +	if (num_streams > STREAM_NUM_STREAMS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Add two to the number of streams requested to account for
> +	 * stream 0 that is reserved for controller usage and one additional
> +	 * for TASK SET FULL response.
> +	 */
> +	num_streams += 2;
> +
> +	/* The stream context array size must be a power of two */
> +	num_stream_ctxs = roundup_pow_of_two(num_streams);
> +
> +	ret = cdnsp_alloc_stream_info(pdev, pep, num_stream_ctxs, num_streams);
> +	if (ret)
> +		return ret;
> +
> +	cdnsp_setup_streams_ep_input_ctx(pdev, pep->in_ctx, &pep->stream_info);
> +
> +	pep->ep_state |= EP_HAS_STREAMS;
> +	pep->stream_info.td_count = 0;
> +	pep->stream_info.first_prime_det = 0;
> +
> +	/* Subtract 1 for stream 0, which drivers can't use. */
> +	return num_streams - 1;
> +}
> +
> +int cdnsp_disable_slot(struct cdnsp_device *pdev)
> +{
> +	int ret = 0;

don't initialize

> +
> +	cdnsp_queue_slot_control(pdev, TRB_DISABLE_SLOT);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +
> +	pdev->slot_id = 0;
> +	pdev->active_port = NULL;
> +
> +	memset(pdev->in_ctx.bytes, 0, 2112);
> +	memset(pdev->out_ctx.bytes, 0, 2112);

Replace these magic numbers with defines.

> +
> +	return ret;
> +}
> +
> +int cdnsp_enable_slot(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int slot_state;
> +	int ret;
> +
> +	/* If device is not setup, there is no point in resetting it */
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (slot_state != SLOT_STATE_DISABLED)
> +		return 0;
> +
> +	cdnsp_queue_slot_control(pdev, TRB_ENABLE_SLOT);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +

Delete the blank line.

	if (ret)
		return ret;

	pdev->slot_id = 1;
	return 0;

Always do error handling, never do success handling.  Success should be
assumed.  Success should be indented one tap, and errors two tabs.

> +	if (!ret)
> +		pdev->slot_id = 1;
> +
> +	return ret;
> +}
> +
> +/*
> + * Issue an Address Device command with BSR=0 if setup is SETUP_CONTEXT_ONLY
> + * or with BSR = 1 if set_address is SETUP_CONTEXT_ADDRESS.
> + */
> +int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev setup)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int dev_state = 0;
> +	int ret = 0;
> +
> +	if (!pdev->slot_id)
> +		return -EINVAL;
> +
> +	if (!pdev->active_port->port_num)
> +		return -EINVAL;
> +
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (setup == SETUP_CONTEXT_ONLY && dev_state == SLOT_STATE_DEFAULT)
> +		goto out;

return 0;

> +
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +
> +	if (!slot_ctx->dev_info || dev_state == SLOT_STATE_DEFAULT) {
> +		ret = cdnsp_setup_addressable_priv_dev(pdev);
> +		if (ret)
> +			goto out;

return ret;

> +	}
> +
> +	cdnsp_copy_ep0_dequeue_into_input_ctx(pdev);
> +
> +	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG | EP0_FLAG);
> +	ctrl_ctx->drop_flags = 0;
> +
> +	cdnsp_queue_address_device(pdev, pdev->in_ctx.dma, setup);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +
> +	/* Zero the input context control for later use. */
> +	ctrl_ctx->add_flags = 0;
> +	ctrl_ctx->drop_flags = 0;
> +out:
> +	return ret;
> +}
> +
> +void cdnsp_set_usb2_hardware_lpm(struct cdnsp_device *pdev,
> +				 struct usb_request *req,
> +				 int enable)
> +{
> +	if (pdev->active_port != &pdev->usb2_port || !pdev->gadget.lpm_capable)
> +		return;
> +
> +	if (enable)
> +		writel(PORT_BESL(CDNSP_DEFAULT_BESL) | PORT_L1S_NYET | PORT_HLE,
> +		       &pdev->active_port->regs->portpmsc);
> +	else
> +		writel(PORT_L1S_NYET, &pdev->active_port->regs->portpmsc);
> +}
> +
> +static int cdnsp_get_frame(struct cdnsp_device *pdev)
> +{
> +	return readl(&pdev->run_regs->microframe_index) >> 3;
> +}
> +
> +static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
> +				  const struct usb_endpoint_descriptor *desc)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_device *pdev;
> +	unsigned long flags = 0;

Don't initialize

> +	struct cdnsp_ep *pep;
> +	u32 added_ctxs;
> +	int ret = 0;

Don't initialize

> +
> +	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
> +	    !desc->wMaxPacketSize)
> +		return -EINVAL;
> +
> +	pep = to_cdnsp_ep(ep);
> +	pdev = pep->pdev;
> +
> +	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
> +			  "%s is already enabled\n", pep->name))
> +		return 0;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	added_ctxs = cdnsp_get_endpoint_flag(desc);
> +	if (added_ctxs == SLOT_FLAG || added_ctxs == EP0_FLAG) {
> +		dev_err(pdev->dev, "ERROR: Bad endpoint number\n");
> +		ret = -EINVAL;
> +		goto finish;

A better label name would be "goto unlock;"

> +	}
> +
> +	pep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
> +
> +	if (pdev->gadget.speed == USB_SPEED_FULL) {
> +		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT)
> +			pep->interval = desc->bInterval << 3;
> +		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_ISOC)
> +			pep->interval = BIT(desc->bInterval - 1) << 3;
> +	}
> +
> +	if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_ISOC) {
> +		if (pep->interval > BIT(12)) {
> +			dev_err(pdev->dev, "bInterval %d not supported\n",
> +				desc->bInterval);
> +			ret = -EINVAL;
> +			goto finish;
> +		}
> +		cdnsp_set_chicken_bits_2(pdev, CHICKEN_XDMA_2_TP_CACHE_DIS);
> +	}
> +
> +	ret = cdnsp_endpoint_init(pdev, pep, GFP_ATOMIC);
> +	if (ret < 0)

Use "if (ret) " everywhere.

> +		goto finish;
> +
> +	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +	ctrl_ctx->add_flags = cpu_to_le32(added_ctxs);
> +	ctrl_ctx->drop_flags = 0;
> +
> +	ret = cdnsp_update_eps_configuration(pdev, pep);
> +	if (ret < 0) {

if (ref)

> +		cdnsp_free_endpoint_rings(pdev, pep);
> +		goto finish;
> +	}
> +
> +	pep->ep_state |= EP_ENABLED;
> +	pep->ep_state &= ~EP_STOPPED;
> +
> +finish:
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_request *preq;
> +	struct cdnsp_device *pdev;
> +	unsigned long flags = 0;

Don't initialize

> +	struct cdnsp_ep *pep;
> +	u32 drop_flag;
> +	int ret = 0;
> +
> +	if (!ep)
> +		return -EINVAL;
> +
> +	pep = to_cdnsp_ep(ep);
> +	pdev = pep->pdev;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	if (!(pep->ep_state & EP_ENABLED)) {
> +		dev_err(pdev->dev, "%s is already disabled\n", pep->name);
> +		ret = -EINVAL;
> +		goto finish;
> +	}
> +
> +	cdnsp_cmd_stop_ep(pdev, pep);
> +	pep->ep_state |= EP_DIS_IN_RROGRESS;
> +	cdnsp_cmd_flush_ep(pdev, pep);
> +
> +	/* Remove all queued USB requests. */
> +	while (!list_empty(&pep->pending_list)) {
> +		preq = next_request(&pep->pending_list);
> +		cdnsp_ep_dequeue(pep, preq);
> +	}
> +
> +	cdnsp_invalidate_ep_events(pdev, pep);
> +
> +	pep->ep_state &= ~EP_DIS_IN_RROGRESS;
> +	drop_flag = cdnsp_get_endpoint_flag(pep->endpoint.desc);
> +	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +	ctrl_ctx->drop_flags = cpu_to_le32(drop_flag);
> +	ctrl_ctx->add_flags = 0;
> +
> +	cdnsp_endpoint_zero(pdev, pep);
> +
> +	ret = cdnsp_update_eps_configuration(pdev, pep);
> +	cdnsp_free_endpoint_rings(pdev, pep);
> +
> +	pep->ep_state &= ~EP_ENABLED;
> +	pep->ep_state |= EP_STOPPED;
> +
> +finish:
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static struct usb_request *cdnsp_gadget_ep_alloc_request(struct usb_ep *ep,
> +							 gfp_t gfp_flags)
> +{
> +	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
> +	struct cdnsp_request *preq;
> +
> +	preq = kzalloc(sizeof(*preq), gfp_flags);
> +	if (!preq)
> +		return NULL;
> +
> +	preq->epnum = pep->number;
> +	preq->pep = pep;
> +
> +	return &preq->request;
> +}
> +
> +static void cdnsp_gadget_ep_free_request(struct usb_ep *ep,
> +					 struct usb_request *request)
> +{
> +	struct cdnsp_request *preq = to_cdnsp_request(request);
> +
> +	kfree(preq);
> +}
> +
> +static int cdnsp_gadget_ep_queue(struct usb_ep *ep,
> +				 struct usb_request *request,
> +				 gfp_t gfp_flags)
> +{
> +	struct cdnsp_request *preq;
> +	struct cdnsp_device *pdev;
> +	struct cdnsp_ep *pep;
> +	unsigned long flags = 0;
> +	int ret = 0;

Don't initialize these two


> +
> +	if (!request || !ep)
> +		return -EINVAL;
> +
> +	pep = to_cdnsp_ep(ep);
> +	pdev = pep->pdev;
> +
> +	if (!(pep->ep_state & EP_ENABLED)) {
> +		dev_err(pdev->dev, "%s: can't queue to disabled endpoint\n",
> +			pep->name);
> +		return -EINVAL;
> +	}
> +
> +	preq = to_cdnsp_request(request);
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	ret = cdnsp_ep_enqueue(pep, preq);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
> +				   struct usb_request *request)
> +{
> +	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
> +	struct cdnsp_device *pdev = pep->pdev;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!pep->endpoint.desc) {
> +		dev_err(pdev->dev,
> +			"%s: can't dequeue to disabled endpoint\n",
> +			pep->name);
> +		return -ESHUTDOWN;
> +	}
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	ret = cdnsp_ep_dequeue(pep, to_cdnsp_request(request));
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_set_halt(struct usb_ep *ep, int value)
> +{
> +	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
> +	struct cdnsp_device *pdev = pep->pdev;
> +	struct cdnsp_request *preq;
> +	unsigned long flags = 0;
> +	int ret;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	preq = next_request(&pep->pending_list);
> +	if (value) {
> +		if (preq) {
> +			ret = -EAGAIN;
> +			goto done;
> +		}
> +	}
> +
> +	ret = cdnsp_halt_endpoint(pdev, pep, value);
> +
> +done:
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_set_wedge(struct usb_ep *ep)
> +{
> +	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
> +	struct cdnsp_device *pdev = pep->pdev;
> +	unsigned long flags = 0;
> +	int ret;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	pep->ep_state |= EP_WEDGE;
> +	ret = cdnsp_halt_endpoint(pdev, pep, 1);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static const struct usb_ep_ops cdnsp_gadget_ep0_ops = {
> +	.enable		= cdnsp_gadget_ep_enable,
> +	.disable	= cdnsp_gadget_ep_disable,
> +	.alloc_request	= cdnsp_gadget_ep_alloc_request,
> +	.free_request	= cdnsp_gadget_ep_free_request,
> +	.queue		= cdnsp_gadget_ep_queue,
> +	.dequeue	= cdnsp_gadget_ep_dequeue,
> +	.set_halt	= cdnsp_gadget_ep_set_halt,
> +	.set_wedge	= cdnsp_gadget_ep_set_wedge,
> +};
> +
> +static const struct usb_ep_ops cdnsp_gadget_ep_ops = {
> +	.enable		= cdnsp_gadget_ep_enable,
> +	.disable	= cdnsp_gadget_ep_disable,
> +	.alloc_request	= cdnsp_gadget_ep_alloc_request,
> +	.free_request	= cdnsp_gadget_ep_free_request,
> +	.queue		= cdnsp_gadget_ep_queue,
> +	.dequeue	= cdnsp_gadget_ep_dequeue,
> +	.set_halt	= cdnsp_gadget_ep_set_halt,
> +	.set_wedge	= cdnsp_gadget_ep_set_wedge,
> +};
> +
> +void cdnsp_gadget_giveback(struct cdnsp_ep *pep,
> +			   struct cdnsp_request *preq,
> +			   int status)
> +{
> +	struct cdnsp_device *pdev = pep->pdev;
> +
> +	list_del(&preq->list);
> +
> +	if (preq->request.status == -EINPROGRESS)
> +		preq->request.status = status;
> +
> +	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
> +					preq->direction);
> +
> +	if (preq != &pdev->ep0_preq) {
> +		spin_unlock(&pdev->lock);
> +		usb_gadget_giveback_request(&pep->endpoint, &preq->request);
> +		spin_lock(&pdev->lock);
> +	}
> +}
> +
> +static struct usb_endpoint_descriptor cdnsp_gadget_ep0_desc = {
> +	.bLength =		USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType =	USB_DT_ENDPOINT,
> +	.bmAttributes =		USB_ENDPOINT_XFER_CONTROL,
> +};
> +
> +static int cdnsp_run(struct cdnsp_device *pdev,
> +		     enum usb_device_speed speed)
> +{
> +	u32 fs_speed = 0;
> +	u64 temp_64;
> +	u32 temp;
> +	int ret;
> +
> +	temp_64 = cdnsp_read_64(pdev, &pdev->ir_set->erst_dequeue);
> +	temp_64 &= ~ERST_PTR_MASK;
> +	temp = readl(&pdev->ir_set->irq_control);
> +	temp &= ~IMOD_INTERVAL_MASK;
> +	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
> +	writel(temp, &pdev->ir_set->irq_control);
> +
> +	temp = readl(&pdev->port3x_regs->mode_addr);
> +
> +	switch (speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +		temp |= CFG_3XPORT_SSP_SUPPORT;
> +		break;
> +	case USB_SPEED_SUPER:
> +		temp &= ~CFG_3XPORT_SSP_SUPPORT;
> +		break;
> +	case USB_SPEED_HIGH:
> +		break;
> +	case USB_SPEED_FULL:
> +		fs_speed = PORT_REG6_FORCE_FS;
> +		break;
> +	default:
> +		dev_err(pdev->dev, "invalid maximum_speed parameter %d\n",
> +			speed);
> +		/* fall-through */
> +	case USB_SPEED_UNKNOWN:
> +		/* Default to superspeed. */
> +		speed = USB_SPEED_SUPER;
> +		break;
> +	}
> +
> +	if (speed >= USB_SPEED_SUPER) {
> +		writel(temp, &pdev->port3x_regs->mode_addr);
> +		cdnsp_set_link_state(pdev, &pdev->usb3_port.regs->portsc,
> +				     XDEV_RXDETECT);
> +	} else {
> +		cdnsp_disable_port(pdev, &pdev->usb3_port.regs->portsc);
> +	}
> +
> +	cdnsp_set_link_state(pdev, &pdev->usb2_port.regs->portsc,
> +			     XDEV_RXDETECT);
> +
> +	cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
> +
> +	writel(PORT_REG6_L1_L0_HW_EN | fs_speed, &pdev->port20_regs->port_reg6);
> +
> +	ret = cdnsp_start(pdev);
> +	if (ret) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	temp = readl(&pdev->op_regs->command);
> +	temp |= (CMD_INTE);
> +	writel(temp, &pdev->op_regs->command);
> +
> +	temp = readl(&pdev->ir_set->irq_pending);
> +	writel(IMAN_IE_SET(temp), &pdev->ir_set->irq_pending);
> +
> +	return 0;
> +err:
> +	cdnsp_halt(pdev);
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_udc_start(struct usb_gadget *g,
> +				  struct usb_gadget_driver *driver)
> +{
> +	enum usb_device_speed max_speed = driver->max_speed;
> +	struct cdnsp_device *pdev = gadget_to_cdnsp(g);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	pdev->gadget_driver = driver;
> +
> +	/* limit speed if necessary */
> +	max_speed = min(driver->max_speed, g->max_speed);
> +	ret = cdnsp_run(pdev, max_speed);
> +
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +/*
> + * Update Event Ring Dequeue Pointer:
> + * - When all events have finished
> + * - To avoid "Event Ring Full Error" condition
> + */
> +void cdnsp_update_erst_dequeue(struct cdnsp_device *pdev,
> +			       union cdnsp_trb *event_ring_deq,
> +			       u8 clear_ehb)
> +{
> +	u64 temp_64;
> +	dma_addr_t deq;
> +
> +	temp_64 = cdnsp_read_64(pdev, &pdev->ir_set->erst_dequeue);
> +
> +	/* If necessary, update the HW's version of the event ring deq ptr. */
> +	if (event_ring_deq != pdev->event_ring->dequeue) {
> +		deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +					    pdev->event_ring->dequeue);
> +		temp_64 &= ERST_PTR_MASK;
> +		temp_64 |= ((u64)deq & (u64)~ERST_PTR_MASK);
> +	}
> +
> +	/* Clear the event handler busy flag (RW1C). */
> +	if (clear_ehb)
> +		temp_64 |= ERST_EHB;
> +	else
> +		temp_64 &= ~ERST_EHB;
> +
> +	cdnsp_write_64(pdev, temp_64, &pdev->ir_set->erst_dequeue);
> +}
> +
> +static void cdnsp_clear_cmd_ring(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_segment *seg;
> +	u64 val_64;
> +	int i;
> +
> +	cdnsp_initialize_ring_info(pdev->cmd_ring);
> +
> +	seg = pdev->cmd_ring->first_seg;
> +	for (i = 0; i < pdev->cmd_ring->num_segs; i++) {
> +		memset(seg->trbs, 0,
> +		       sizeof(union cdnsp_trb) * (TRBS_PER_SEGMENT - 1));
> +		seg = seg->next;
> +	}
> +
> +	/* Set the address in the Command Ring Control register. */
> +	val_64 = cdnsp_read_64(pdev, &pdev->op_regs->cmd_ring);
> +	val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
> +		 (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
> +		 pdev->cmd_ring->cycle_state;
> +	cdnsp_write_64(pdev, val_64, &pdev->op_regs->cmd_ring);
> +}
> +
> +static void cdnsp_consume_all_events(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_segment *event_deq_seg;
> +	union cdnsp_trb *event_ring_deq;
> +	union cdnsp_trb *event;
> +	u32 cycle_bit;
> +
> +	event_ring_deq = pdev->event_ring->dequeue;
> +	event_deq_seg = pdev->event_ring->deq_seg;
> +
> +	/* Update ring dequeue pointer. */
> +	while (1) {
> +		event = pdev->event_ring->dequeue;
> +		cycle_bit = (le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE);
> +
> +		/* Does the controller or driver own the TRB? */
> +		if (cycle_bit != pdev->event_ring->cycle_state)
> +			break;
> +
> +		cdnsp_inc_deq(pdev, pdev->event_ring);
> +
> +		if (!cdnsp_last_trb_on_seg(event_deq_seg, event)) {
> +			event++;

This incremement is pointless because we set
"event = pdev->event_ring->dequeue;"  Forever loop?


> +			continue;
> +		}
> +
> +		if (cdnsp_last_trb_on_ring(pdev->event_ring, event_deq_seg,
> +					   event))
> +			cycle_bit ^= 1;
> +
> +		event_deq_seg = event_deq_seg->next;
> +		event = event_deq_seg->trbs;

Pointless assignment.

> +		continue;

Delete this continue.

> +	}
> +
> +	cdnsp_update_erst_dequeue(pdev,  event_ring_deq, 1);
> +}
> +
> +static void cdnsp_stop(struct cdnsp_device *pdev)
> +{
> +	u32 temp;
> +
> +	cdnsp_cmd_flush_ep(pdev, &pdev->eps[0]);
> +
> +	/* Remove internally queued request for ep0. */
> +	if (!list_empty(&pdev->eps[0].pending_list)) {
> +		struct cdnsp_request	*req;
                                     ^^^
Extra space characters.


> +
> +		req = next_request(&pdev->eps[0].pending_list);
> +		if (req == &pdev->ep0_preq)
> +			cdnsp_ep_dequeue(&pdev->eps[0], req);
> +	}
> +
> +	cdnsp_disable_port(pdev, &pdev->usb2_port.regs->portsc);
> +	cdnsp_disable_port(pdev, &pdev->usb3_port.regs->portsc);
> +	cdnsp_disable_slot(pdev);
> +	cdnsp_halt(pdev);
> +
> +	temp = readl(&pdev->op_regs->status);
> +	writel((temp & ~0x1fff) | STS_EINT, &pdev->op_regs->status);
> +	temp = readl(&pdev->ir_set->irq_pending);
> +	writel(IMAN_IE_CLEAR(temp), &pdev->ir_set->irq_pending);
> +
> +	cdnsp_clear_port_change_bit(pdev, &pdev->usb2_port.regs->portsc);
> +	cdnsp_clear_port_change_bit(pdev, &pdev->usb3_port.regs->portsc);
> +
> +	/*Clear interrupt line */
> +	temp = readl(&pdev->ir_set->irq_pending);
> +	temp |= IMAN_IP;
> +	writel(temp, &pdev->ir_set->irq_pending);
> +
> +	cdnsp_consume_all_events(pdev);
> +	cdnsp_clear_cmd_ring(pdev);
> +}
> +
> +/*
> + * Stop controller.
> + * This function is called by the gadget core when the driver is removed.
> + * Disable slot, disable IRQs, and quiesce the controller.
> + */
> +static int cdnsp_gadget_udc_stop(struct usb_gadget *g)
> +{
> +	struct cdnsp_device *pdev = gadget_to_cdnsp(g);
> +	unsigned long flags = 0;

Don't initialize

> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	cdnsp_stop(pdev);
> +	pdev->gadget_driver = NULL;
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_get_frame(struct usb_gadget *g)
> +{
> +	struct cdnsp_device *pdev = gadget_to_cdnsp(g);
> +
> +	return cdnsp_get_frame(pdev);
> +}
> +
> +static int cdnsp_gadget_wakeup(struct usb_gadget *g)
> +{
> +	struct cdnsp_device *pdev = gadget_to_cdnsp(g);
> +	struct cdnsp_port_regs __iomem *port_regs;
> +	unsigned long flags = 0;

Don't initialize

> +	u32 temp;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	port_regs = pdev->active_port->regs;
> +	temp = readl(&port_regs->portpmsc);
> +	if (!(temp & PORT_RWE))
> +		return 0;

We have IRQs disabled.  Need to unlock before returning.

> +
> +	temp = readl(&port_regs->portsc);
> +	temp &= ~PORT_PLS_MASK;
> +	writel(temp, &port_regs->portsc);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_set_selfpowered(struct usb_gadget *g,
> +					int is_selfpowered)
> +{
> +	struct cdnsp_device *pdev = gadget_to_cdnsp(g);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	g->is_selfpowered = !!is_selfpowered;
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct cdnsp_device *pdev = gadget_to_cdnsp(gadget);
> +	struct cdnsp *cdns = dev_get_drvdata(pdev->dev);
> +
> +	if (!is_on) {
> +		cdnsp_reset_device(pdev);
> +		cdnsp_clear_vbus(cdns);
> +	} else {
> +		cdnsp_set_vbus(cdns);
> +	}
> +	return 0;
> +}
> +
> +const struct usb_gadget_ops cdnsp_gadget_ops = {
> +	.get_frame		= cdnsp_gadget_get_frame,
> +	.wakeup			= cdnsp_gadget_wakeup,
> +	.set_selfpowered	= cdnsp_gadget_set_selfpowered,
> +	.pullup			= cdnsp_gadget_pullup,
> +	.udc_start		= cdnsp_gadget_udc_start,
> +	.udc_stop		= cdnsp_gadget_udc_stop,
> +};
> +
> +static void cdnsp_get_ep_buffering(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep)
> +{
> +	void __iomem *reg = &pdev->cap_regs->hc_capbase;
> +	int endpoints;
> +
> +	reg += cdnsp_find_next_ext_cap(reg, 0, XBUF_CAP_ID);
> +
> +	if (!pep->direction) {
> +		pep->buffering = readl(reg + XBUF_RX_TAG_MASK_0_OFFSET);
> +		pep->buffering_period = readl(reg + XBUF_RX_TAG_MASK_1_OFFSET);
> +		pep->buffering = (pep->buffering + 1) / 2;
> +		pep->buffering_period = (pep->buffering_period + 1) / 2;
> +		return;
> +	}
> +
> +	endpoints = HCS_ENDPOINTS(readl(&pdev->hcs_params1)) / 2;
> +
> +	/* Set to XBUF_TX_TAG_MASK_0 register. */
> +	reg += XBUF_TX_CMD_OFFSET + (endpoints * 2 + 2) * sizeof(u32);
> +	/* Set reg to XBUF_TX_TAG_MASK_N related with this endpoint. */
> +	reg += (pep->number * sizeof(u32) * 2);

Remove parenthese.

> +
> +	pep->buffering = (readl(reg) + 1) / 2;
> +	pep->buffering_period = pep->buffering;
> +}
> +
> +static int cdnsp_gadget_init_endpoints(struct cdnsp_device *pdev)
> +{
> +	int max_streams = HCC_MAX_PSA(pdev->hcc_params);
> +	struct cdnsp_ep *pep;
> +	int i = 0;

Don't intialize

> +
> +	INIT_LIST_HEAD(&pdev->gadget.ep_list);
> +
> +	if (max_streams < STREAM_LOG_STREAMS) {
> +		dev_err(pdev->dev, "Stream size %d not supported\n",
> +			max_streams);
> +		return -EINVAL;
> +	}
> +
> +	max_streams  = STREAM_LOG_STREAMS;
                    ^
Extra space

> +
> +	for (i = 0; i < CDNSP_ENDPOINTS_NUM; i++) {
> +		bool direction = !(i & 1); /* Start from OUT endpoint. */
> +		u8 epnum = ((i + 1) >> 1);
> +
> +		if (!CDNSP_IF_EP_EXIST(pdev, epnum, direction))
> +			continue;
> +
> +		pep = &pdev->eps[i];
> +		pep->pdev = pdev;
> +		pep->number = epnum;
> +		pep->direction = direction; /* 0 for OUT, 1 for IN. */
> +
> +		/*
> +		 * Ep0 is bidirectional, so ep0in and ep0out are represented by
> +		 * pdev->eps[0]
> +		 */
> +		if (epnum == 0) {
> +			snprintf(pep->name, sizeof(pep->name), "ep%d%s",
> +				 epnum, "BiDir");
> +
> +			pep->idx = 0;
> +			usb_ep_set_maxpacket_limit(&pep->endpoint, 512);
> +			pep->endpoint.maxburst = 1;
> +			pep->endpoint.ops = &cdnsp_gadget_ep0_ops;
> +			pep->endpoint.desc = &cdnsp_gadget_ep0_desc;
> +			pep->endpoint.comp_desc = NULL;
> +			pep->endpoint.caps.type_control = true;
> +			pep->endpoint.caps.dir_in = true;
> +			pep->endpoint.caps.dir_out = true;
> +
> +			pdev->ep0_preq.epnum = pep->number;
> +			pdev->ep0_preq.pep = pep;
> +			pdev->gadget.ep0 = &pep->endpoint;
> +		} else {
> +			snprintf(pep->name, sizeof(pep->name), "ep%d%s",
> +				 epnum, (pep->direction) ? "in"  : "out");
> +
> +			pep->idx =  (epnum * 2 + (direction ? 1 : 0)) - 1;
> +			usb_ep_set_maxpacket_limit(&pep->endpoint, 1024);
> +
> +			pep->endpoint.max_streams = max_streams;
> +			pep->endpoint.ops = &cdnsp_gadget_ep_ops;
> +			list_add_tail(&pep->endpoint.ep_list,
> +				      &pdev->gadget.ep_list);
> +
> +			pep->endpoint.caps.type_iso = true;
> +			pep->endpoint.caps.type_bulk = true;
> +			pep->endpoint.caps.type_int = true;
> +
> +			pep->endpoint.caps.dir_in = direction;
> +			pep->endpoint.caps.dir_out = !direction;
> +		}
> +
> +		pep->endpoint.name = pep->name;
> +		pep->in_ctx = cdnsp_get_ep_ctx(&pdev->in_ctx, pep->idx);
> +		pep->out_ctx = cdnsp_get_ep_ctx(&pdev->out_ctx, pep->idx);
> +		cdnsp_get_ep_buffering(pdev, pep);
> +
> +		dev_dbg(pdev->dev, "Init %s, MPS: %04x SupType: "
> +			"CTRL: %s, INT: %s, BULK: %s, ISOC %s, "
> +			"SupDir IN: %s, OUT: %s\n",
> +			pep->name, 1024,
> +			(pep->endpoint.caps.type_control) ? "yes" : "no",
> +			(pep->endpoint.caps.type_int) ? "yes" : "no",
> +			(pep->endpoint.caps.type_bulk) ? "yes" : "no",
> +			(pep->endpoint.caps.type_iso) ? "yes" : "no",
> +			(pep->endpoint.caps.dir_in) ? "yes" : "no",
> +			(pep->endpoint.caps.dir_out) ? "yes" : "no");
> +
> +		INIT_LIST_HEAD(&pep->pending_list);
> +	}
> +
> +	return 0;
> +}
> +
> +static void cdnsp_gadget_free_endpoints(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_ep *pep;
> +	int i;
> +
> +	for (i = 0; i < CDNSP_ENDPOINTS_NUM; i++) {
> +		pep = &pdev->eps[i];
> +		if (pep->number != 0 && pep->out_ctx)
> +			list_del(&pep->endpoint.ep_list);
> +	}
> +}
> +
> +void cdnsp_disconnect_gadget(struct cdnsp_device *pdev)
> +{
> +	pdev->cdnsp_state |= CDNSP_STATE_DISCONNECT_PENDING;
> +
> +	if (pdev->gadget_driver && pdev->gadget_driver->disconnect) {
> +		spin_unlock(&pdev->lock);
> +		pdev->gadget_driver->disconnect(&pdev->gadget);
> +		spin_lock(&pdev->lock);
> +	}
> +
> +	pdev->gadget.speed = USB_SPEED_UNKNOWN;
> +	usb_gadget_set_state(&pdev->gadget, USB_STATE_NOTATTACHED);
> +
> +	pdev->cdnsp_state &= ~CDNSP_STATE_DISCONNECT_PENDING;
> +}
> +
> +void cdnsp_suspend_gadget(struct cdnsp_device *pdev)
> +{
> +	if (pdev->gadget_driver && pdev->gadget_driver->suspend) {
> +		spin_unlock(&pdev->lock);
> +		pdev->gadget_driver->suspend(&pdev->gadget);
> +		spin_lock(&pdev->lock);
> +	}
> +}
> +
> +void cdnsp_resume_gadget(struct cdnsp_device *pdev)
> +{
> +	if (pdev->gadget_driver && pdev->gadget_driver->resume) {
> +		spin_unlock(&pdev->lock);
> +		pdev->gadget_driver->resume(&pdev->gadget);
> +		spin_lock(&pdev->lock);
> +	}
> +}
> +
> +void cdnp_irq_reset(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_port_regs __iomem *port_regs;
> +
> +	cdnsp_reset_device(pdev);
> +
> +	port_regs = pdev->active_port->regs;
> +	pdev->gadget.speed = cdnsp_port_speed(readl(port_regs));
> +
> +	spin_unlock(&pdev->lock);
> +	usb_gadget_udc_reset(&pdev->gadget, pdev->gadget_driver);
> +	spin_lock(&pdev->lock);
> +
> +	switch (pdev->gadget.speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
> +		pdev->gadget.ep0->maxpacket = 512;
> +		break;
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_FULL:
> +		cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
> +		pdev->gadget.ep0->maxpacket = 64;
> +		break;
> +	default:
> +		/* Low speed is not supported. */
> +		dev_err(pdev->dev, "Unknown device speed\n");
> +		break;
> +	}
> +
> +	cdnsp_clear_chicken_bits_2(pdev, CHICKEN_XDMA_2_TP_CACHE_DIS);
> +	cdnsp_setup_device(pdev, SETUP_CONTEXT_ONLY);
> +	usb_gadget_set_state(&pdev->gadget, USB_STATE_DEFAULT);
> +}
> +
> +static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
> +{
> +	void __iomem *reg = &pdev->cap_regs->hc_capbase;
> +	struct cdnsp_rev_cap *rev_cap;
> +
> +	reg += cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
> +	rev_cap = reg;
> +
> +	pdev->rev_cap.ctrl_revision = readl(&rev_cap->ctrl_revision);
> +	pdev->rev_cap.rtl_revision = readl(&rev_cap->rtl_revision);
> +	pdev->rev_cap.ep_supported = readl(&rev_cap->ep_supported);
> +	pdev->rev_cap.ext_cap = readl(&rev_cap->ext_cap);
> +	pdev->rev_cap.rx_buff_size = readl(&rev_cap->rx_buff_size);
> +	pdev->rev_cap.tx_buff_size = readl(&rev_cap->tx_buff_size);
> +
> +	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
> +		 pdev->rev_cap.ctrl_revision, pdev->rev_cap.rtl_revision,
> +		 pdev->rev_cap.ep_supported, pdev->rev_cap.rx_buff_size,
> +		 pdev->rev_cap.tx_buff_size);
> +}
> +
> +static int cdnsp_gen_setup(struct cdnsp_device *pdev)
> +{
> +	int retval;

Use "int ret;" everywhere.

> +
> +	pdev->cap_regs = pdev->regs;
> +	pdev->op_regs = pdev->regs +
> +		HC_LENGTH(readl(&pdev->cap_regs->hc_capbase));
> +	pdev->run_regs = pdev->regs +
> +		(readl(&pdev->cap_regs->run_regs_off) & RTSOFF_MASK);
> +
> +	/* Cache read-only capability registers */
> +	pdev->hcs_params1 = readl(&pdev->cap_regs->hcs_params1);
> +	pdev->hcc_params = readl(&pdev->cap_regs->hc_capbase);
> +	pdev->hci_version = HC_VERSION(pdev->hcc_params);
> +	pdev->hcc_params = readl(&pdev->cap_regs->hcc_params);
> +
> +	cdnsp_get_rev_cap(pdev);
> +
> +	/* Make sure the Device Controller is halted. */
> +	retval = cdnsp_halt(pdev);
> +	if (retval)
> +		return retval;
> +
> +	/* Reset the internal controller memory state and registers. */
> +	retval = cdnsp_reset(pdev);
> +	if (retval)
> +		return retval;
> +
> +	/*
> +	 * Set dma_mask and coherent_dma_mask to 64-bits,
> +	 * if controller supports 64-bit addressing.
> +	 */
> +	if (HCC_64BIT_ADDR(pdev->hcc_params) &&
> +	    !dma_set_mask(pdev->dev, DMA_BIT_MASK(64))) {
> +		dev_dbg(pdev->dev, "Enabling 64-bit DMA addresses.\n");
> +		dma_set_coherent_mask(pdev->dev, DMA_BIT_MASK(64));
> +	} else {
> +		/*
> +		 * This is to avoid error in cases where a 32-bit USB
> +		 * controller is used on a 64-bit capable system.
> +		 */
> +		retval = dma_set_mask(pdev->dev, DMA_BIT_MASK(32));
> +		if (retval)
> +			return retval;
> +		dev_dbg(pdev->dev, "Enabling 32-bit DMA addresses.\n");
> +		dma_set_coherent_mask(pdev->dev, DMA_BIT_MASK(32));
> +	}
> +
> +	spin_lock_init(&pdev->lock);
> +
> +	retval = cdnsp_mem_init(pdev, GFP_KERNEL);
> +	if (retval)
> +		return retval;
> +
> +	return 0;
> +}
> +
> +static int __cdnsp_gadget_init(struct cdnsp *cdns)
> +{
> +	struct cdnsp_device *pdev;
> +	u32 max_speed;
> +	int ret = -ENOMEM;
> +
> +	cdnsp_drd_switch_gadget(cdns, 1);
> +
> +	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
> +	if (!pdev)
> +		return ret;

return -ENOMEM;

Returning a literal is more readable than returning a variable you have
to look up.

> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	cdns->gadget_dev = pdev;
> +	pdev->dev = cdns->dev;
> +	pdev->regs = cdns->dev_regs;
> +
> +	max_speed = usb_get_maximum_speed(cdns->dev);
> +
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_SUPER:
> +	case USB_SPEED_SUPER_PLUS:
> +		break;
> +	default:
> +		dev_err(cdns->dev, "invalid speed parameter %d\n", max_speed);
> +		/* fall-through */
> +	case USB_SPEED_UNKNOWN:
> +		/* Default to SSP */
> +		max_speed = USB_SPEED_SUPER_PLUS;
> +		break;
> +	}
> +
> +	pdev->gadget.ops = &cdnsp_gadget_ops;
> +	pdev->gadget.name = "cdnsp-gadget";
> +	pdev->gadget.speed = USB_SPEED_UNKNOWN;
> +	pdev->gadget.sg_supported = 1;
> +	pdev->gadget.max_speed = USB_SPEED_SUPER_PLUS;
> +	pdev->gadget.lpm_capable = 1;
> +
> +	pdev->setup_buf = kzalloc(CDNSP_EP0_SETUP_SIZE, GFP_KERNEL);
> +	if (!pdev->setup_buf)
> +		goto err1;
> +
> +	/*
> +	 * Controller supports not aligned buffer but it should improve
> +	 * performance.
> +	 */
> +	pdev->gadget.quirk_ep_out_aligned_size = true;
> +
> +	ret = cdnsp_gen_setup(pdev);
> +	if (ret < 0) {

Use "if (ret) " everywhere unless the function returns positive values
on success.  Don't mix styles.

> +		dev_err(pdev->dev, "Generic initialization failed %d\n", ret);
> +		goto err2;
> +	}
> +
> +	ret = cdnsp_gadget_init_endpoints(pdev);
> +	if (ret < 0) {
> +		dev_err(pdev->dev, "failed to initialize endpoints\n");
> +		goto err3;
> +	}
> +
> +	ret = usb_add_gadget_udc(pdev->dev, &pdev->gadget);
> +	if (ret) {
> +		dev_err(pdev->dev, "failed to register udc\n");
> +		goto err4;
> +	}
> +
> +	ret = devm_request_threaded_irq(pdev->dev, cdns->dev_irq,
> +					cdnsp_irq_handler,
> +					cdnsp_thread_irq_handler,
> +					IRQF_SHARED /*| IRQF_ONESHOT*/,
> +					dev_name(pdev->dev), pdev);
> +	if (ret < 0)
> +		goto err5;
> +
> +	return 0;
> +
> +err5:

This is like GW-BASIC "goto 10;" where you have numbers instead of names
and then the code changes and you have to "goto err_2point5;".  Label
names should say what the goto does just like functions say what happens
when you call them.

goto del_gadget; goto free_endpoints; goto halt_pdev; goto free_setup; etc.

Better to move everything you can to devm_kzalloc().

> +	usb_del_gadget_udc(&pdev->gadget);
> +err4:
> +	cdnsp_gadget_free_endpoints(pdev);
> +err3:
> +	cdnsp_halt(pdev);
> +	cdnsp_reset(pdev);
> +	cdnsp_mem_cleanup(pdev);
> +err2:
> +	kfree(pdev->setup_buf);
> +err1:
> +	kfree(pdev);
> +
> +	return ret;
> +}
> +
> +void cdnsp_gadget_exit(struct cdnsp *cdns)
> +{
> +	struct cdnsp_device *pdev = cdns->gadget_dev;
> +
> +	devm_free_irq(pdev->dev, cdns->dev_irq, pdev);

Hopefully, there is no need to free devm_ allocated code otherwise it
defeats the purpose.

> +
> +	pm_runtime_mark_last_busy(cdns->dev);
> +	pm_runtime_put_autosuspend(cdns->dev);
> +
> +	usb_del_gadget_udc(&pdev->gadget);
> +	cdnsp_gadget_free_endpoints(pdev);
> +
> +	cdnsp_mem_cleanup(pdev);
> +	kfree(pdev);
> +	cdns->gadget_dev = NULL;
> +
> +	cdnsp_drd_switch_gadget(cdns, 0);
> +}
> +
> +static int cdnsp_gadget_suspend(struct cdnsp *cdns, bool do_wakeup)
> +{
> +	struct cdnsp_device *pdev = cdns->gadget_dev;
> +
> +	cdnsp_disconnect_gadget(pdev);
> +	cdnsp_stop(pdev);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_resume(struct cdnsp *cdns, bool hibernated)
> +{
> +	struct cdnsp_device *pdev = cdns->gadget_dev;
> +	enum usb_device_speed max_speed;
> +	int ret;
> +
> +	if (!pdev->gadget_driver)
> +		return 0;
> +
> +	max_speed = pdev->gadget_driver->max_speed;
> +
> +	/* Limit speed if necessary. */
> +	max_speed = min(max_speed, pdev->gadget.max_speed);
> +	ret = cdnsp_run(pdev, max_speed);
> +
> +	return ret;

	return cdnsp_run(pdev, max_speed);

> +}
> +
> +/**
> + * cdnsp_gadget_init - initialize device structure
> + * @cdns: cdnsp instance
> + *
> + * This function initializes the gadget.
> + */
> +int cdnsp_gadget_init(struct cdnsp *cdns)
> +{
> +	struct cdnsp_role_driver *rdrv;
> +
> +	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +	if (!rdrv)
> +		return -ENOMEM;
> +
> +	rdrv->start	= __cdnsp_gadget_init;
> +	rdrv->stop	= cdnsp_gadget_exit;
> +	rdrv->suspend	= cdnsp_gadget_suspend;
> +	rdrv->resume	= cdnsp_gadget_resume;
> +	rdrv->state	= CDNSP_ROLE_STATE_INACTIVE;
> +	rdrv->name	= "gadget";
> +	cdns->roles[USB_ROLE_DEVICE] = rdrv;
> +
> +	return 0;
> +}
> diff --git a/drivers/usb/cdnsp/gadget.h b/drivers/usb/cdnsp/gadget.h
> index edc37763a3b7..298f97be24ad 100644
> --- a/drivers/usb/cdnsp/gadget.h
> +++ b/drivers/usb/cdnsp/gadget.h
> @@ -1443,4 +1443,142 @@ struct cdnsp_device {
>  	u16 test_mode;
>  };
>  
> +/*
> + * Registers should always be accessed with double word or quad word accesses.
> + *
> + * Registers with 64-bit address pointers should be written to with
> + * dword accesses by writing the low dword first (ptr[0]), then the high dword
> + * (ptr[1]) second. controller implementations that do not support 64-bit
> + * address pointers will ignore the high dword, and write order is irrelevant.
> + */
> +static inline u64 cdnsp_read_64(const struct cdnsp_device *pdev,
> +				__le64 __iomem *regs)
> +{
> +	return lo_hi_readq(regs);
> +}
> +
> +static inline void cdnsp_write_64(struct cdnsp_device *pdev,
> +				  const u64 val, __le64 __iomem *regs)
> +{
> +	lo_hi_writeq(val, regs);
> +}
> +
> +/* CDNSP memory management functions. */
> +void cdnsp_mem_cleanup(struct cdnsp_device *pdev);
> +int cdnsp_mem_init(struct cdnsp_device *pdev, gfp_t flags);
> +int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev);
> +void cdnsp_copy_ep0_dequeue_into_input_ctx(struct cdnsp_device *pdev);
> +void cdnsp_endpoint_zero(struct cdnsp_device *pdev, struct cdnsp_ep *ep);
> +int cdnsp_endpoint_init(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep,
> +			gfp_t mem_flags);
> +int cdnsp_ring_expansion(struct cdnsp_device *pdev,
> +			 struct cdnsp_ring *ring,
> +			 unsigned int num_trbs, gfp_t flags);
> +struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *ep, u64 address);
> +int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
> +			    struct cdnsp_ep *pep,
> +			    unsigned int num_stream_ctxs,
> +			    unsigned int num_streams);
> +int cdnsp_alloc_streams(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> +void cdnsp_free_endpoint_rings(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> +
> +/* Device controller glue. */
> +int cdnsp_find_next_ext_cap(void __iomem *base, u32 start, int id);
> +int cdnsp_halt(struct cdnsp_device *pdev);
> +void cdnsp_died(struct cdnsp_device *pdev);
> +int cdnsp_reset(struct cdnsp_device *pdev);
> +irqreturn_t cdnsp_irq_handler(int irq, void *priv);
> +int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev setup);
> +void cdnsp_set_usb2_hardware_lpm(struct cdnsp_device *usbsssp_data,
> +				 struct usb_request *req, int enable);
> +irqreturn_t cdnsp_thread_irq_handler(int irq, void *data);
> +
> +/* Ring, segment, TRB, and TD functions. */
> +dma_addr_t cdnsp_trb_virt_to_dma(struct cdnsp_segment *seg,
> +				 union cdnsp_trb *trb);
> +bool cdnsp_last_trb_on_seg(struct cdnsp_segment *seg, union cdnsp_trb *trb);
> +bool cdnsp_last_trb_on_ring(struct cdnsp_ring *ring,
> +			    struct cdnsp_segment *seg,
> +			    union cdnsp_trb *trb);
> +int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev);
> +void cdnsp_update_erst_dequeue(struct cdnsp_device *pdev,
> +			       union cdnsp_trb *event_ring_deq,
> +			       u8 clear_ehb);
> +void cdnsp_initialize_ring_info(struct cdnsp_ring *ring);
> +void cdnsp_ring_cmd_db(struct cdnsp_device *pdev);
> +void cdnsp_queue_slot_control(struct cdnsp_device *pdev, u32 trb_type);
> +void cdnsp_queue_address_device(struct cdnsp_device *pdev,
> +				dma_addr_t in_ctx_ptr,
> +				enum cdnsp_setup_dev setup);
> +void cdnsp_queue_stop_endpoint(struct cdnsp_device *pdev,
> +			       unsigned int ep_index);
> +int cdnsp_queue_ctrl_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq);
> +int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq);
> +int cdnsp_queue_isoc_tx_prepare(struct cdnsp_device *pdev,
> +				struct cdnsp_request *preq);
> +void cdnsp_queue_configure_endpoint(struct cdnsp_device *pdev,
> +				    dma_addr_t in_ctx_ptr);
> +void cdnsp_queue_reset_ep(struct cdnsp_device *pdev, unsigned int ep_index);
> +void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev,
> +			       unsigned int ep_index);
> +void cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
> +				unsigned int ep_index);
> +void cdnsp_queue_reset_device(struct cdnsp_device *pdev);
> +void cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep,
> +				   struct cdnsp_dequeue_state *deq_state);
> +void cdnsp_ring_doorbell_for_active_rings(struct cdnsp_device *pdev,
> +					  struct cdnsp_ep *pep);
> +void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring);
> +void cdnsp_set_link_state(struct cdnsp_device *pdev,
> +			  __le32 __iomem *port_regs, u32 link_state);
> +u32 cdnsp_port_state_to_neutral(u32 state);
> +
> +/* CDNSP device controller contexts. */
> +int cdnsp_enable_slot(struct cdnsp_device *pdev);
> +int cdnsp_disable_slot(struct cdnsp_device *pdev);
> +struct cdnsp_input_control_ctx
> +	*cdnsp_get_input_control_ctx(struct cdnsp_container_ctx *ctx);
> +struct cdnsp_slot_ctx *cdnsp_get_slot_ctx(struct cdnsp_container_ctx *ctx);
> +struct cdnsp_ep_ctx *cdnsp_get_ep_ctx(struct cdnsp_container_ctx *ctx,
> +				      unsigned int ep_index);
> +/* CDNSP gadget interface. */
> +void cdnsp_suspend_gadget(struct cdnsp_device *pdev);
> +void cdnsp_resume_gadget(struct cdnsp_device *pdev);
> +void cdnsp_disconnect_gadget(struct cdnsp_device *pdev);
> +void cdnsp_gadget_giveback(struct cdnsp_ep *pep, struct cdnsp_request *preq,
> +			   int status);
> +int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq);
> +int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq);
> +unsigned int cdnsp_port_speed(unsigned int port_status);
> +void cdnp_irq_reset(struct cdnsp_device *pdev);
> +int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep, int value);
> +int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> +int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> +void cdnsp_setup_analyze(struct cdnsp_device *pdev);
> +int cdnsp_status_stage(struct cdnsp_device *pdev);
> +int cdnsp_reset_device(struct cdnsp_device *pdev);
> +
> +/**
> + * next_request - gets the next request on the given list
> + * @list: the request list to operate on
> + *
> + * Caller should take care of locking. This function return NULL or the first
> + * request available on list.
> + */
> +static inline struct cdnsp_request *next_request(struct list_head *list)
> +{
> +	return list_first_entry_or_null(list, struct cdnsp_request, list);
> +}
> +
> +#define to_cdnsp_ep(ep) (container_of(ep, struct cdnsp_ep, endpoint))
> +#define gadget_to_cdnsp(g) (container_of(g, struct cdnsp_device, gadget))
> +#define request_to_cdnsp_request(r) (container_of(r, struct cdnsp_request, \
> +				     request))
> +#define to_cdnsp_request(r) (container_of(r, struct cdnsp_request, request))
> +int cdnsp_remove_request(struct cdnsp_device *pdev, struct cdnsp_request *preq,
> +			 struct cdnsp_ep *pep);
> +
>  #endif /* __LINUX_CDNSP_GADGET_H */
> diff --git a/drivers/usb/cdnsp/host.c b/drivers/usb/cdnsp/host.c
> new file mode 100644
> index 000000000000..355fe63149e4
> --- /dev/null
> +++ b/drivers/usb/cdnsp/host.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - host side
> + *
> + * Copyright (C) 2018-2019 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *          Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include "core.h"
> +#include "drd.h"
> +
> +int __cdnsp_host_init(struct cdnsp *cdns)
> +{
> +	struct platform_device *xhci;
> +	int ret;
> +
> +	cdnsp_drd_switch_host(cdns, 1);
> +
> +	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> +	if (!xhci) {
> +		dev_err(cdns->dev, "couldn't allocate xHCI device\n");
> +		return -ENOMEM;
> +	}
> +
> +	xhci->dev.parent = cdns->dev;
> +	cdns->host_dev = xhci;
> +
> +	ret = platform_device_add_resources(xhci, cdns->xhci_res,
> +					    CDNSP_XHCI_RESOURCES_NUM);
> +	if (ret) {
> +		dev_err(cdns->dev, "couldn't add resources to xHCI device\n");
> +		goto err1;
> +	}
> +
> +	ret = platform_device_add(xhci);
> +	if (ret) {
> +		dev_err(cdns->dev, "failed to register xHCI device\n");
> +		goto err1;
> +	}
> +
> +	return 0;
> +err1:
> +	platform_device_put(xhci);
> +	return ret;
> +}
> +
> +void cdnsp_host_exit(struct cdnsp *cdns)
> +{
> +	platform_device_unregister(cdns->host_dev);
> +	cdns->host_dev = NULL;
> +	cdnsp_drd_switch_host(cdns, 0);
> +}
> +
> +int cdnsp_host_init(struct cdnsp *cdns)
> +{
> +	struct cdnsp_role_driver *rdrv;
> +
> +	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +	if (!rdrv)
> +		return -ENOMEM;
> +
> +	rdrv->start	= __cdnsp_host_init;
> +	rdrv->stop	= cdnsp_host_exit;
> +	rdrv->state	= CDNSP_ROLE_STATE_INACTIVE;
> +	rdrv->name	= "host";
> +
> +	cdns->roles[USB_ROLE_HOST] = rdrv;
> +
> +	return 0;
> +}
> diff --git a/drivers/usb/cdnsp/mem.c b/drivers/usb/cdnsp/mem.c
> new file mode 100644
> index 000000000000..4a72c7d833ab
> --- /dev/null
> +++ b/drivers/usb/cdnsp/mem.c
> @@ -0,0 +1,1327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + * Code based on Linux XHCI driver.
> + * Origin: Copyright (C) 2008 Intel Corp.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +
> +#include "gadget.h"
> +
> +static void cdnsp_free_stream_info(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep);
> +/*
> + * Allocates a generic ring segment from the ring pool, sets the dma address,
> + * initializes the segment to zero, and sets the private next pointer to NULL.
> + *
> + * "All components of all Command and Transfer TRBs shall be initialized to '0'"
> + */
> +static struct cdnsp_segment *cdnsp_segment_alloc(struct cdnsp_device *pdev,
> +						 unsigned int cycle_state,
> +						 unsigned int max_packet,
> +						 gfp_t flags)
> +{
> +	struct cdnsp_segment *seg;
> +	dma_addr_t dma;
> +	int i;
> +
> +	seg = kzalloc(sizeof(*seg), flags);
> +	if (!seg)
> +		return NULL;
> +
> +	seg->trbs = dma_pool_zalloc(pdev->segment_pool, flags, &dma);
> +

Delete the blank line.

	if (!seg->trbs)
		goto free_seg;

> +	if (!seg->trbs) {
> +		kfree(seg);
> +		return NULL;
> +	}
> +
> +	if (max_packet) {
> +		seg->bounce_buf = kzalloc(max_packet, flags | GFP_DMA);
> +		if (!seg->bounce_buf) {
> +			dma_pool_free(pdev->segment_pool, seg->trbs, dma);
> +			kfree(seg);
> +
> +			return NULL;

		if (!seg->bounce_buf)
			goto free_dma;


> +		}
> +	}
> +
> +	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs. */
> +	if (cycle_state == 0) {
> +		for (i = 0; i < TRBS_PER_SEGMENT; i++)
> +			seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
> +	}
> +	seg->dma = dma;
> +	seg->next = NULL;
> +
> +	return seg;
> +}
> +
> +static void cdnsp_segment_free(struct cdnsp_device *pdev,
> +			       struct cdnsp_segment *seg)
> +{
> +	if (seg->trbs) {
> +		dma_pool_free(pdev->segment_pool, seg->trbs, seg->dma);
> +		seg->trbs = NULL;

No need to make this NULL because "seg" is freed two lines later.

> +	}
> +
> +	kfree(seg->bounce_buf);
> +	kfree(seg);
> +}
> +
> +static void cdnsp_free_segments_for_ring(struct cdnsp_device *pdev,
> +					 struct cdnsp_segment *first)
> +{
> +	struct cdnsp_segment *seg;
> +
> +	seg = first->next;
> +
> +	while (seg != first) {
> +		struct cdnsp_segment *next = seg->next;
> +
> +		cdnsp_segment_free(pdev, seg);
> +		seg = next;
> +	}
> +
> +	cdnsp_segment_free(pdev, first);
> +}
> +
> +/*
> + * Make the prev segment point to the next segment.
> + *
> + * Change the last TRB in the prev segment to be a Link TRB which points to the
> + * DMA address of the next segment. The caller needs to set any Link TRB
> + * related flags, such as End TRB, Toggle Cycle, and no snoop.
> + */
> +static void cdnsp_link_segments(struct cdnsp_device *pdev,
> +				struct cdnsp_segment *prev,
> +				struct cdnsp_segment *next,
> +				enum cdnsp_ring_type type)
> +{
> +	struct cdnsp_link_trb *link;
> +	u32 val;
> +
> +	if (!prev || !next)
> +		return;
> +
> +	prev->next = next;
> +	if (type != TYPE_EVENT) {
> +		link = &prev->trbs[TRBS_PER_SEGMENT - 1].link;
> +		link->segment_ptr = cpu_to_le64(next->dma);
> +
> +		/*
> +		 * Set the last TRB in the segment to have a TRB type ID
> +		 * of Link TRB
> +		 */
> +		val = le32_to_cpu(link->control);
> +		val &= ~TRB_TYPE_BITMASK;
> +		val |= TRB_TYPE(TRB_LINK);
> +		link->control = cpu_to_le32(val);
> +	}
> +}
> +
> +/*
> + * Link the ring to the new segments.
> + * Set Toggle Cycle for the new ring if needed.
> + */
> +static void cdnsp_link_rings(struct cdnsp_device *pdev,
> +			     struct cdnsp_ring *ring,
> +			     struct cdnsp_segment *first,
> +			     struct cdnsp_segment *last,
> +			     unsigned int num_segs)
> +{
> +	struct cdnsp_segment *next;
> +
> +	if (!ring || !first || !last)
> +		return;
> +
> +	next = ring->enq_seg->next;
> +	cdnsp_link_segments(pdev, ring->enq_seg, first, ring->type);
> +	cdnsp_link_segments(pdev, last, next, ring->type);
> +	ring->num_segs += num_segs;
> +	ring->num_trbs_free += (TRBS_PER_SEGMENT - 1) * num_segs;
> +
> +	if (ring->type != TYPE_EVENT && ring->enq_seg == ring->last_seg) {
> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control &=
> +			~cpu_to_le32(LINK_TOGGLE);
> +		last->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> +			cpu_to_le32(LINK_TOGGLE);
> +		ring->last_seg = last;
> +	}
> +}
> +
> +/*
> + * We need a radix tree for mapping physical addresses of TRBs to which stream
> + * ID they belong to. We need to do this because the device controller won't
> + * tell us which stream ring the TRB came from. We could store the stream ID
> + * in an event data TRB, but that doesn't help us for the cancellation case,
> + * since the endpoint may stop before it reaches that event data TRB.
> + *
> + * The radix tree maps the upper portion of the TRB DMA address to a ring
> + * segment that has the same upper portion of DMA addresses. For example,
> + * say I have segments of size 1KB, that are always 1KB aligned. A segment may
> + * start at 0x10c91000 and end at 0x10c913f0. If I use the upper 10 bits, the
> + * key to the stream ID is 0x43244. I can use the DMA address of the TRB to
> + * pass the radix tree a key to get the right stream ID:
> + *
> + *	0x10c90fff >> 10 = 0x43243
> + *	0x10c912c0 >> 10 = 0x43244
> + *	0x10c91400 >> 10 = 0x43245
> + *
> + * Obviously, only those TRBs with DMA addresses that are within the segment
> + * will make the radix tree return the stream ID for that ring.
> + *
> + * Caveats for the radix tree:
> + *
> + * The radix tree uses an unsigned long as a key pair. On 32-bit systems, an
> + * unsigned long will be 32-bits; on a 64-bit system an unsigned long will be
> + * 64-bits. Since we only request 32-bit DMA addresses, we can use that as the
> + * key on 32-bit or 64-bit systems (it would also be fine if we asked for 64-bit
> + * PCI DMA addresses on a 64-bit system). There might be a problem on 32-bit
> + * extended systems (where the DMA address can be bigger than 32-bits),
> + * if we allow the PCI dma mask to be bigger than 32-bits. So don't do that.
> + */
> +static int cdnsp_insert_segment_mapping(struct radix_tree_root *trb_address_map,
> +					struct cdnsp_ring *ring,
> +					struct cdnsp_segment *seg,
> +					gfp_t mem_flags)
> +{
> +	unsigned long key;
> +	int ret;
> +
> +	key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
> +
> +	/* Skip any segments that were already added. */
> +	if (radix_tree_lookup(trb_address_map, key))
> +		return 0;
> +
> +	ret = radix_tree_maybe_preload(mem_flags);
> +	if (ret)
> +		return ret;
> +
> +	ret = radix_tree_insert(trb_address_map, key, ring);
> +	radix_tree_preload_end();
> +
> +	return ret;
> +}
> +
> +static void cdnsp_remove_segment_mapping(struct radix_tree_root *trb_address_map,
> +					 struct cdnsp_segment *seg)
> +{
> +	unsigned long key;
> +
> +	key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
> +	if (radix_tree_lookup(trb_address_map, key))
> +		radix_tree_delete(trb_address_map, key);
> +}
> +
> +static int cdnsp_update_stream_segment_mapping(struct radix_tree_root *trb_address_map,
> +					       struct cdnsp_ring *ring,
> +					       struct cdnsp_segment *first_seg,
> +					       struct cdnsp_segment *last_seg,
> +					       gfp_t mem_flags)
> +{
> +	struct cdnsp_segment *failed_seg;
> +	struct cdnsp_segment *seg;
> +	int ret;
> +
> +	seg = first_seg;
> +	do {
> +		ret = cdnsp_insert_segment_mapping(trb_address_map, ring, seg,
> +						   mem_flags);
> +		if (ret)
> +			goto remove_streams;
> +		if (seg == last_seg)
> +			return 0;
> +		seg = seg->next;
> +	} while (seg != first_seg);
> +
> +	return 0;
> +
> +remove_streams:
> +	failed_seg = seg;
> +	seg = first_seg;
> +	do {
> +		cdnsp_remove_segment_mapping(trb_address_map, seg);
> +		if (seg == failed_seg)
> +			return ret;
> +		seg = seg->next;
> +	} while (seg != first_seg);
> +
> +	return ret;
> +}
> +
> +static void cdnsp_remove_stream_mapping(struct cdnsp_ring *ring)
> +{
> +	struct cdnsp_segment *seg;
> +
> +	seg = ring->first_seg;
> +	do {
> +		cdnsp_remove_segment_mapping(ring->trb_address_map, seg);
> +		seg = seg->next;
> +	} while (seg != ring->first_seg);
> +}
> +
> +static int cdnsp_update_stream_mapping(struct cdnsp_ring *ring)
> +{
> +	return cdnsp_update_stream_segment_mapping(ring->trb_address_map, ring,
> +			ring->first_seg, ring->last_seg, GFP_ATOMIC);
> +}
> +
> +void cdnsp_ring_free(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
> +{
> +	if (!ring)
> +		return;
> +
> +	if (ring->first_seg) {
> +		if (ring->type == TYPE_STREAM)
> +			cdnsp_remove_stream_mapping(ring);
> +
> +		cdnsp_free_segments_for_ring(pdev, ring->first_seg);
> +	}
> +
> +	kfree(ring);
> +}
> +
> +void cdnsp_initialize_ring_info(struct cdnsp_ring *ring)
> +{
> +	ring->enqueue = ring->first_seg->trbs;
> +	ring->enq_seg = ring->first_seg;
> +	ring->dequeue = ring->enqueue;
> +	ring->deq_seg = ring->first_seg;
> +
> +	/*
> +	 * The ring is initialized to 0. The producer must write 1 to the cycle
> +	 * bit to handover ownership of the TRB, so PCS = 1. The consumer must
> +	 * compare CCS to the cycle bit to check ownership, so CCS = 1.
> +	 *
> +	 * New rings are initialized with cycle state equal to 1; if we are
> +	 * handling ring expansion, set the cycle state equal to the old ring.
> +	 */
> +	ring->cycle_state = 1;
> +
> +	/*
> +	 * Each segment has a link TRB, and leave an extra TRB for SW
> +	 * accounting purpose
> +	 */
> +	ring->num_trbs_free = ring->num_segs * (TRBS_PER_SEGMENT - 1) - 1;
> +}
> +
> +/* Allocate segments and link them for a ring. */
> +static int cdnsp_alloc_segments_for_ring(struct cdnsp_device *pdev,
> +					 struct cdnsp_segment **first,
> +					 struct cdnsp_segment **last,
> +					 unsigned int num_segs,
> +					 unsigned int cycle_state,
> +					 enum cdnsp_ring_type type,
> +					 unsigned int max_packet,
> +					 gfp_t flags)
> +{
> +	struct cdnsp_segment *prev;
> +
> +	/* Allocate first segment. */
> +	prev = cdnsp_segment_alloc(pdev, cycle_state,
> +				   max_packet, flags);

This fits on one line.

	prev = cdnsp_segment_alloc(pdev, cycle_state, max_packet, flags);


> +	if (!prev)
> +		return -ENOMEM;
> +
> +	num_segs--;
> +	*first = prev;
> +
> +	/* Allocate all other segments. */
> +	while (num_segs > 0) {
> +		struct cdnsp_segment	*next;
> +
> +		next = cdnsp_segment_alloc(pdev, cycle_state,
> +					   max_packet, flags);
> +		if (!next) {
> +			prev = *first;
> +
> +			/*Free all reserved segment*/
> +			while (prev) {
> +				next = prev->next;
> +				cdnsp_segment_free(pdev, prev);
> +				prev = next;
> +			}
> +
> +			return -ENOMEM;

Can this free loop be replaced with cdnsp_free_segments_for_ring()?

> +		}
> +
> +		cdnsp_link_segments(pdev, prev, next, type);
> +
> +		prev = next;
> +		num_segs--;
> +	}
> +
> +	cdnsp_link_segments(pdev, prev, *first, type);
> +	*last = prev;
> +
> +	return 0;
> +}
> +
> +/*
> + * Create a new ring with zero or more segments.
> + *
> + * Link each segment together into a ring.
> + * Set the end flag and the cycle toggle bit on the last segment.
> + */
> +static struct cdnsp_ring *cdnsp_ring_alloc(struct cdnsp_device *pdev,
> +					   unsigned int num_segs,
> +					   enum cdnsp_ring_type type,
> +					   unsigned int max_packet,
> +					   gfp_t flags)
> +{
> +	struct cdnsp_ring *ring;
> +	int ret;
> +
> +	ring = kzalloc(sizeof *(ring), flags);
> +	if (!ring)
> +		return NULL;
> +
> +	ring->num_segs = num_segs;
> +	ring->bounce_buf_len = max_packet;
> +	INIT_LIST_HEAD(&ring->td_list);
> +	ring->type = type;
> +
> +	if (num_segs == 0)
> +		return ring;
> +
> +	ret = cdnsp_alloc_segments_for_ring(pdev, &ring->first_seg,
> +					    &ring->last_seg, num_segs,
> +					    1, type, max_packet, flags);
> +	if (ret)
> +		goto fail;
> +
> +	/* Only event ring does not use link TRB. */
> +	if (type != TYPE_EVENT)
> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> +			cpu_to_le32(LINK_TOGGLE);
> +
> +	cdnsp_initialize_ring_info(ring);
> +
> +	return ring;
> +fail:
> +	kfree(ring);
> +	return NULL;
> +}
> +
> +void cdnsp_free_endpoint_rings(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	cdnsp_ring_free(pdev, pep->ring);
> +	pep->ring = NULL;
> +	cdnsp_free_stream_info(pdev, pep);
> +}
> +
> +/*
> + * Expand an existing ring.
> + * Allocate a new ring which has same segment numbers and link the two rings.
> + */
> +int cdnsp_ring_expansion(struct cdnsp_device *pdev,
> +			 struct cdnsp_ring *ring,
> +			 unsigned int num_trbs,
> +			 gfp_t flags)
> +{
> +	unsigned int num_segs_needed;
> +	struct cdnsp_segment *first;
> +	struct cdnsp_segment *last;
> +	unsigned int num_segs;
> +	int ret;
> +
> +	num_segs_needed = (num_trbs + (TRBS_PER_SEGMENT - 1) - 1) /
> +			(TRBS_PER_SEGMENT - 1);
> +
> +	/* Allocate number of segments we needed, or double the ring size. */
> +	num_segs = ring->num_segs > num_segs_needed ?
> +		   ring->num_segs : num_segs_needed;

	num_segs = max(ring->num_segs, num_segs_needed);

> +
> +	ret = cdnsp_alloc_segments_for_ring(pdev, &first, &last, num_segs,
> +					    ring->cycle_state, ring->type,
> +					    ring->bounce_buf_len, flags);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	if (ring->type == TYPE_STREAM)
> +		ret = cdnsp_update_stream_segment_mapping(ring->trb_address_map,
> +							  ring, first,
> +							  last, flags);
> +
> +	if (ret) {
> +		struct cdnsp_segment *next;
> +
> +		do {
> +			next = first->next;
> +			cdnsp_segment_free(pdev, first);
> +			if (first == last)
> +				break;
> +			first = next;
> +		} while (true);
> +		return ret;

I really hope this can be replaced with cdnsp_free_segments_for_ring().

> +	}
> +
> +	cdnsp_link_rings(pdev, ring, first, last, num_segs);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_init_device_ctx(struct cdnsp_device *pdev)
> +{
> +	int size = HCC_64BYTE_CONTEXT(pdev->hcc_params) ? 2048 : 1024;
> +
> +	pdev->out_ctx.type = CDNSP_CTX_TYPE_DEVICE;
> +	pdev->out_ctx.size = size;
> +	pdev->out_ctx.ctx_size = CTX_SIZE(pdev->hcc_params);
> +	pdev->out_ctx.bytes = dma_pool_zalloc(pdev->device_pool, GFP_ATOMIC,
> +					      &pdev->out_ctx.dma);
> +
> +	if (!pdev->out_ctx.bytes)
> +		return -ENOMEM;
> +
> +	pdev->in_ctx.type = CDNSP_CTX_TYPE_INPUT;
> +	pdev->in_ctx.ctx_size = pdev->out_ctx.ctx_size;
> +	pdev->in_ctx.size = size + pdev->out_ctx.ctx_size;
> +	pdev->in_ctx.bytes = dma_pool_zalloc(pdev->device_pool, GFP_ATOMIC,
> +					     &pdev->in_ctx.dma);
> +
> +	if (!pdev->in_ctx.bytes) {
> +		dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
> +			      pdev->out_ctx.dma);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +struct cdnsp_input_control_ctx
> +	*cdnsp_get_input_control_ctx(struct cdnsp_container_ctx *ctx)
> +{
> +	if (ctx->type != CDNSP_CTX_TYPE_INPUT)
> +		return NULL;
> +
> +	return (struct cdnsp_input_control_ctx *)ctx->bytes;
> +}
> +
> +struct cdnsp_slot_ctx *cdnsp_get_slot_ctx(struct cdnsp_container_ctx *ctx)
> +{
> +	if (ctx->type == CDNSP_CTX_TYPE_DEVICE)
> +		return (struct cdnsp_slot_ctx *)ctx->bytes;
> +
> +	return (struct cdnsp_slot_ctx *)(ctx->bytes + ctx->ctx_size);
> +}
> +
> +struct cdnsp_ep_ctx *cdnsp_get_ep_ctx(struct cdnsp_container_ctx *ctx,
> +				      unsigned int ep_index)
> +{
> +	/* Increment ep index by offset of start of ep ctx array. */
> +	ep_index++;
> +	if (ctx->type == CDNSP_CTX_TYPE_INPUT)
> +		ep_index++;
> +
> +	return (struct cdnsp_ep_ctx *)(ctx->bytes +
> +		(ep_index * ctx->ctx_size));


This fits in 80 characters:

	return (struct cdnsp_ep_ctx *)(ctx->bytes + (ep_index * ctx->ctx_size));

> +}
> +
> +static void cdnsp_free_stream_ctx(struct cdnsp_device *pdev,
> +				  struct cdnsp_ep *pep)
> +{
> +	size_t size = sizeof(struct cdnsp_stream_ctx) *
> +		      pep->stream_info.num_stream_ctxs;
> +
> +	dma_free_coherent(pdev->dev, size, pep->stream_info.stream_ctx_array,
> +			  pep->stream_info.ctx_array_dma);
> +}
> +
> +/* The stream context array must be a power of 2. */
> +static struct cdnsp_stream_ctx
> +	*cdnsp_alloc_stream_ctx(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	size_t size = sizeof(struct cdnsp_stream_ctx) *
> +		      pep->stream_info.num_stream_ctxs;
> +
> +	return dma_alloc_coherent(pdev->dev, size,
> +				  &pep->stream_info.ctx_array_dma,
> +				  GFP_DMA32 | GFP_ATOMIC);
> +}
> +
> +struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *pep, u64 address)
> +{
> +	if (pep->ep_state & EP_HAS_STREAMS)
> +		return radix_tree_lookup(&pep->stream_info.trb_address_map,
> +					 address >> TRB_SEGMENT_SHIFT);
> +
> +	return pep->ring;
> +}
> +
> +/*
> + * Change an endpoint's internal structure so it supports stream IDs.
> + * The number of requested streams includes stream 0, which cannot be used by
> + * driver.
> + *
> + * The number of stream contexts in the stream context array may be bigger than
> + * the number of streams the driver wants to use. This is because the number of
> + * stream context array entries must be a power of two.
> + */
> +int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
> +			    struct cdnsp_ep *pep,
> +			    unsigned int num_stream_ctxs,
> +			    unsigned int num_streams)
> +{
> +	struct cdnsp_stream_info *stream_info;
> +	struct cdnsp_ring *cur_ring;
> +	u32 cur_stream;
> +	u64 addr;
> +	int ret;
> +	int mps;
> +
> +	stream_info = &pep->stream_info;
> +	stream_info->num_streams = num_streams;
> +	stream_info->num_stream_ctxs = num_stream_ctxs;
> +
> +	/* Initialize the array of virtual pointers to stream rings. */
> +	stream_info->stream_rings = kcalloc(num_streams,
> +					    sizeof(struct cdnsp_ring *),
> +					    GFP_ATOMIC);
> +	if (!stream_info->stream_rings)
> +		return -ENOMEM;
> +
> +	/* Initialize the array of DMA addresses for stream rings for the HW. */
> +	stream_info->stream_ctx_array = cdnsp_alloc_stream_ctx(pdev, pep);
> +	if (!stream_info->stream_ctx_array)
> +		goto cleanup_ctx;
> +
> +	memset(stream_info->stream_ctx_array, 0,
> +	       sizeof(struct cdnsp_stream_ctx) * num_stream_ctxs);
> +	INIT_RADIX_TREE(&stream_info->trb_address_map, GFP_ATOMIC);
> +	mps = usb_endpoint_maxp(pep->endpoint.desc);
> +
> +	/*
> +	 * Allocate rings for all the streams that the driver will use,
> +	 * and add their segment DMA addresses to the radix tree.
> +	 * Stream 0 is reserved.
> +	 */
> +	for (cur_stream = 1; cur_stream < num_streams; cur_stream++) {
> +		cur_ring = cdnsp_ring_alloc(pdev, 2, TYPE_STREAM, mps,
> +					    GFP_ATOMIC);
> +		stream_info->stream_rings[cur_stream] = cur_ring;
> +
> +		if (!cur_ring)
> +			goto cleanup_rings;
> +
> +		cur_ring->stream_id = cur_stream;
> +		cur_ring->trb_address_map = &stream_info->trb_address_map;
> +
> +		/* Set deq ptr, cycle bit, and stream context type. */
> +		addr = cur_ring->first_seg->dma | SCT_FOR_CTX(SCT_PRI_TR) |
> +		       cur_ring->cycle_state;
> +
> +		stream_info->stream_ctx_array[cur_stream].stream_ring =
> +			cpu_to_le64(addr);
> +
> +		ret = cdnsp_update_stream_mapping(cur_ring);
> +		if (ret) {
> +			cdnsp_ring_free(pdev, cur_ring);
> +			stream_info->stream_rings[cur_stream] = NULL;

This is the same as the error handling code so just do:

	goto cleanup_rings;

Presumably it's ok to undo the mappings if cdnsp_update_stream_mapping()
failed.

> +			goto cleanup_rings;
> +		}
> +	}
> +
> +	return 0;
> +
> +cleanup_rings:
> +	for (cur_stream = 1; cur_stream < num_streams; cur_stream++) {
> +		cur_ring = stream_info->stream_rings[cur_stream];
> +		if (cur_ring) {
> +			cdnsp_ring_free(pdev, cur_ring);
> +			stream_info->stream_rings[cur_stream] = NULL;
> +		}
> +	}
> +
> +cleanup_ctx:
> +	kfree(pep->stream_info.stream_rings);

It could be nicer to say:  kfree(stream_info->stream_rings);  maybe the
function name could be "free_rings;" or something?  I don't understand
what "ctx" means here.


> +
> +	return -ENOMEM;
> +}
> +
> +/* Frees all stream contexts associated with the endpoint. */
> +static void cdnsp_free_stream_info(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_stream_info *stream_info = &pep->stream_info;
> +	struct cdnsp_ring *cur_ring;
> +	int cur_stream;
> +
> +	if (!(pep->ep_state & EP_HAS_STREAMS))
> +		return;
> +
> +	for (cur_stream = 1; cur_stream < stream_info->num_streams;
> +	     cur_stream++) {
> +		cur_ring = stream_info->stream_rings[cur_stream];
> +		if (cur_ring) {
> +			cdnsp_ring_free(pdev, cur_ring);
> +			stream_info->stream_rings[cur_stream] = NULL;
> +		}
> +	}
> +
> +	if (stream_info->stream_ctx_array)
> +		cdnsp_free_stream_ctx(pdev, pep);
> +
> +	kfree(stream_info->stream_rings);
> +	pep->ep_state &= ~EP_HAS_STREAMS;
> +}
> +
> +/* All the cdnsp_tds in the ring's TD list should be freed at this point.*/
> +static void cdnsp_free_priv_device(struct cdnsp_device *pdev)
> +{
> +	pdev->dcbaa->dev_context_ptrs[1] = 0;
> +
> +	cdnsp_free_endpoint_rings(pdev, &pdev->eps[0]);
> +
> +	if (pdev->in_ctx.bytes)
> +		dma_pool_free(pdev->device_pool, pdev->in_ctx.bytes,
> +			      pdev->in_ctx.dma);
> +
> +	if (pdev->out_ctx.bytes)
> +		dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
> +			      pdev->out_ctx.dma);
> +
> +	pdev->in_ctx.bytes = NULL;
> +	pdev->out_ctx.bytes = NULL;
> +}
> +
> +static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev, gfp_t flags)
> +{
> +	int ret = -ENOMEM;
> +
> +	ret = cdnsp_init_device_ctx(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Allocate endpoint 0 ring. */
> +	pdev->eps[0].ring = cdnsp_ring_alloc(pdev, 2, TYPE_CTRL, 0, flags);
> +	if (!pdev->eps[0].ring)
> +		goto fail;
> +
> +	/* Point to output device context in dcbaa. */
> +	pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
> +	pdev->cmd.in_ctx = &pdev->in_ctx;
> +
> +	return 0;
> +fail:
> +	dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
> +		      pdev->out_ctx.dma);
> +	dma_pool_free(pdev->device_pool, pdev->in_ctx.bytes,
> +		      pdev->in_ctx.dma);
> +
> +	return ret;
> +}
> +
> +void cdnsp_copy_ep0_dequeue_into_input_ctx(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_ep_ctx *ep0_ctx = pdev->eps[0].in_ctx;
> +	struct cdnsp_ring *ep_ring = pdev->eps[0].ring;
> +	dma_addr_t dma;
> +
> +	dma = cdnsp_trb_virt_to_dma(ep_ring->enq_seg, ep_ring->enqueue);
> +	ep0_ctx->deq = cpu_to_le64(dma | ep_ring->cycle_state);
> +}
> +
> +/* Setup an controller private device for a Set Address command. */
> +int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	struct cdnsp_ep_ctx *ep0_ctx;
> +	u32 max_packets, port;
> +
> +	ep0_ctx = cdnsp_get_ep_ctx(&pdev->in_ctx, 0);
> +	slot_ctx = cdnsp_get_slot_ctx(&pdev->in_ctx);
> +
> +	/* Only the control endpoint is valid - one endpoint context. */
> +	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1));
> +
> +	switch (pdev->gadget.speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SSP);
> +		max_packets = MAX_PACKET(512);
> +		break;
> +	case USB_SPEED_SUPER:
> +		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SS);
> +		max_packets = MAX_PACKET(512);
> +		break;
> +	case USB_SPEED_HIGH:
> +		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_HS);
> +		max_packets = MAX_PACKET(64);
> +		break;
> +	case USB_SPEED_FULL:
> +		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_FS);
> +		max_packets = MAX_PACKET(64);
> +		break;
> +	default:
> +		/* Speed was not set , this shouldn't happen. */
> +		return -EINVAL;
> +	}
> +
> +	port = DEV_PORT(pdev->active_port->port_num);
> +	slot_ctx->dev_port |= cpu_to_le32(port);
> +	slot_ctx->dev_state = (pdev->device_address & DEV_ADDR_MASK);
> +	ep0_ctx->tx_info = EP_AVG_TRB_LENGTH(0x8);
> +	ep0_ctx->ep_info2 = cpu_to_le32(EP_TYPE(CTRL_EP));
> +	ep0_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
> +					 max_packets);
> +
> +	ep0_ctx->deq = cpu_to_le64(pdev->eps[0].ring->first_seg->dma |
> +				   pdev->eps[0].ring->cycle_state);
> +
> +	return 0;
> +}
> +
> +/*
> + * Convert interval expressed as 2^(bInterval - 1) == interval into
> + * straight exponent value 2^n == interval.
> + */
> +static unsigned int cdnsp_parse_exponent_interval(struct usb_gadget *g,
> +						  struct cdnsp_ep *pep)
> +{
> +	unsigned int interval;
> +
> +	interval = clamp_val(pep->endpoint.desc->bInterval, 1, 16) - 1;
> +	if (interval != pep->endpoint.desc->bInterval - 1)
> +		dev_warn(&g->dev, "ep %s - rounding interval to %d %sframes\n",
> +			 pep->name, 1 << interval,
> +			 g->speed == USB_SPEED_FULL ? "" : "micro");
> +
> +	/*
> +	 * Full speed isoc endpoints specify interval in frames,
> +	 * not microframes. We are using microframes everywhere,
> +	 * so adjust accordingly.
> +	 */
> +	if (g->speed == USB_SPEED_FULL)
> +		interval += 3;	/* 1 frame = 2^3 uframes */
> +
> +	/* Controller handles only up to 512ms (2^12). */
> +	if (interval > 12)
> +		interval = 12;
> +
> +	return interval;
> +}
> +
> +/*
> + * Convert bInterval expressed in microframes (in 1-255 range) to exponent of
> + * microframes, rounded down to nearest power of 2.
> + */
> +static unsigned int cdnsp_microframes_to_exponent(struct usb_gadget *g,
> +						  struct cdnsp_ep *pep,
> +						  unsigned int desc_interval,
> +						  unsigned int min_exponent,
> +						  unsigned int max_exponent)
> +{
> +	unsigned int interval;
> +
> +	interval = fls(desc_interval) - 1;
> +	return clamp_val(interval, min_exponent, max_exponent);
> +}
> +
> +/*
> + * Return the polling interval.
> + *
> + * The polling interval is expressed in "microframes". If controllers's Interval
> + * field is set to N, it will service the endpoint every 2^(Interval)*125us.
> + */
> +static unsigned int cdnsp_get_endpoint_interval(struct usb_gadget *g,
> +						struct cdnsp_ep *pep)
> +{
> +	unsigned int interval = 0;
> +
> +	switch (g->speed) {
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		if (usb_endpoint_xfer_int(pep->endpoint.desc) ||
> +		    usb_endpoint_xfer_isoc(pep->endpoint.desc))
> +			interval = cdnsp_parse_exponent_interval(g, pep);
> +		break;
> +	case USB_SPEED_FULL:
> +		if (usb_endpoint_xfer_isoc(pep->endpoint.desc)) {
> +			interval = cdnsp_parse_exponent_interval(g, pep);
> +		} else if (usb_endpoint_xfer_int(pep->endpoint.desc)) {
> +			interval = pep->endpoint.desc->bInterval << 3;
> +			interval = cdnsp_microframes_to_exponent(g, pep,
> +								 interval,
> +								 3, 10);
> +		}
> +
> +		break;
> +	default:
> +		WARN_ON(1);
> +	}
> +
> +	return interval;
> +}
> +
> +/*
> + * The "Mult" field in the endpoint context is only set for SuperSpeed isoc eps.
> + * High speed endpoint descriptors can define "the number of additional
> + * transaction opportunities per microframe", but that goes in the Max Burst
> + * endpoint context field.
> + */
> +static u32 cdnsp_get_endpoint_mult(struct usb_gadget *g, struct cdnsp_ep *pep)
> +{
> +	if (g->speed < USB_SPEED_SUPER ||
> +	    !usb_endpoint_xfer_isoc(pep->endpoint.desc))
> +		return 0;
> +
> +	return pep->endpoint.comp_desc->bmAttributes;
> +}
> +
> +static u32 cdnsp_get_endpoint_max_burst(struct usb_gadget *g,
> +					struct cdnsp_ep *pep)
> +{
> +	/* Super speed and Plus have max burst in ep companion desc */
> +	if (g->speed >= USB_SPEED_SUPER)
> +		return pep->endpoint.comp_desc->bMaxBurst;
> +
> +	if (g->speed == USB_SPEED_HIGH &&
> +	    (usb_endpoint_xfer_isoc(pep->endpoint.desc) ||
> +	     usb_endpoint_xfer_int(pep->endpoint.desc)))
> +		return (usb_endpoint_maxp(pep->endpoint.desc) & 0x1800) >> 11;
> +
> +	return 0;
> +}
> +
> +static u32 cdnsp_get_endpoint_type(const struct usb_endpoint_descriptor *desc)
> +{
> +	int in;
> +
> +	in = usb_endpoint_dir_in(desc);
> +
> +	switch (usb_endpoint_type(desc)) {
> +	case USB_ENDPOINT_XFER_CONTROL:
> +		return CTRL_EP;
> +	case USB_ENDPOINT_XFER_BULK:
> +		return in ? BULK_IN_EP : BULK_OUT_EP;
> +	case USB_ENDPOINT_XFER_ISOC:
> +		return in ? ISOC_IN_EP : ISOC_OUT_EP;
> +	case USB_ENDPOINT_XFER_INT:
> +		return in ? INT_IN_EP : INT_OUT_EP;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Return the maximum endpoint service interval time (ESIT) payload.
> + * Basically, this is the maxpacket size, multiplied by the burst size
> + * and mult size.
> + */
> +static u32 cdnsp_get_max_esit_payload(struct usb_gadget *g,
> +				      struct cdnsp_ep *pep)
> +{
> +	int max_packet;
> +	int max_burst;
> +
> +	/* Only applies for interrupt or isochronous endpoints*/
> +	if (usb_endpoint_xfer_control(pep->endpoint.desc) ||
> +	    usb_endpoint_xfer_bulk(pep->endpoint.desc))
> +		return 0;
> +
> +	/* SuperSpeedPlus Isoc ep sending over 48k per EIST. */
> +	if (g->speed >= USB_SPEED_SUPER_PLUS &&
> +	    USB_SS_SSP_ISOC_COMP(pep->endpoint.desc->bmAttributes))
> +		return le32_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> +	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
> +	else if (g->speed >= USB_SPEED_SUPER)
> +		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> +
> +	max_packet = usb_endpoint_maxp(pep->endpoint.desc);
> +	max_burst = usb_endpoint_maxp_mult(pep->endpoint.desc);
> +
> +	/* A 0 in max burst means 1 transfer per ESIT */
> +	return max_packet * max_burst;
> +}
> +
> +int cdnsp_endpoint_init(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep,
> +			gfp_t mem_flags)
> +{
> +	enum cdnsp_ring_type ring_type;
> +	struct cdnsp_ep_ctx *ep_ctx;
> +	unsigned int err_count = 0;
> +	unsigned int avg_trb_len;
> +	unsigned int max_packet;
> +	unsigned int max_burst;
> +	unsigned int interval;
> +	u32 max_esit_payload;
> +	unsigned int mult;
> +	u32 endpoint_type;
> +	int ret;
> +
> +	ep_ctx = pep->in_ctx;
> +
> +	endpoint_type = cdnsp_get_endpoint_type(pep->endpoint.desc);
> +	if (!endpoint_type)
> +		return -EINVAL;
> +
> +	ring_type = usb_endpoint_type(pep->endpoint.desc);
> +
> +	/*
> +	 * Get values to fill the endpoint context, mostly from ep descriptor.
> +	 * The average TRB buffer length for bulk endpoints is unclear as we
> +	 * have no clue on scatter gather list entry size. For Isoc and Int,
> +	 * set it to max available.
> +	 */
> +	max_esit_payload = cdnsp_get_max_esit_payload(&pdev->gadget, pep);
> +	interval = cdnsp_get_endpoint_interval(&pdev->gadget, pep);
> +	mult = cdnsp_get_endpoint_mult(&pdev->gadget, pep);
> +	max_packet = usb_endpoint_maxp(pep->endpoint.desc);
> +	max_burst = cdnsp_get_endpoint_max_burst(&pdev->gadget, pep);
> +	avg_trb_len = max_esit_payload;
> +
> +	/* Allow 3 retries for everything but isoc, set CErr = 3. */
> +	if (!usb_endpoint_xfer_isoc(pep->endpoint.desc))
> +		err_count = 3;
> +	if (usb_endpoint_xfer_bulk(pep->endpoint.desc) &&
> +	    pdev->gadget.speed == USB_SPEED_HIGH)
> +		max_packet = 512;
> +	/* Controller spec indicates that ctrl ep avg TRB Length should be 8. */
> +	if (usb_endpoint_xfer_control(pep->endpoint.desc))
> +		avg_trb_len = 8;
> +
> +	/* Set up the endpoint ring. */
> +	pep->ring = cdnsp_ring_alloc(pdev, 2, ring_type, max_packet, mem_flags);
> +	pep->skip = false;
> +
> +	/* Fill the endpoint context */
> +	ep_ctx->ep_info = cpu_to_le32(EP_MAX_ESIT_PAYLOAD_HI(max_esit_payload) |
> +				EP_INTERVAL(interval) | EP_MULT(mult));
> +	ep_ctx->ep_info2 = cpu_to_le32(EP_TYPE(endpoint_type) |
> +				MAX_PACKET(max_packet) | MAX_BURST(max_burst) |
> +				ERROR_COUNT(err_count));
> +	ep_ctx->deq = cpu_to_le64(pep->ring->first_seg->dma |
> +				  pep->ring->cycle_state);
> +
> +	ep_ctx->tx_info = cpu_to_le32(EP_MAX_ESIT_PAYLOAD_LO(max_esit_payload) |
> +				EP_AVG_TRB_LENGTH(avg_trb_len));
> +
> +	if (usb_endpoint_xfer_bulk(pep->endpoint.desc) &&
> +	    pdev->gadget.speed > USB_SPEED_HIGH) {
> +		ret = cdnsp_alloc_streams(pdev, pep);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void cdnsp_endpoint_zero(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	pep->in_ctx->ep_info = 0;
> +	pep->in_ctx->ep_info2 = 0;
> +	pep->in_ctx->deq = 0;
> +	pep->in_ctx->tx_info = 0;
> +}
> +
> +int cdnsp_alloc_erst(struct cdnsp_device *pdev,
> +		     struct cdnsp_ring *evt_ring,
> +		     struct cdnsp_erst *erst,
> +		     gfp_t flags)
> +{
> +	struct cdnsp_erst_entry *entry;
> +	struct cdnsp_segment *seg;
> +	unsigned int val;
> +	size_t size;
> +
> +	size = sizeof(struct cdnsp_erst_entry) * evt_ring->num_segs;
> +	erst->entries = dma_alloc_coherent(pdev->dev, size,
> +					   &erst->erst_dma_addr, flags);
> +	if (!erst->entries)
> +		return -ENOMEM;
> +
> +	erst->num_entries = evt_ring->num_segs;
> +
> +	seg = evt_ring->first_seg;
> +	for (val = 0; val < evt_ring->num_segs; val++) {
> +		entry = &erst->entries[val];
> +		entry->seg_addr = cpu_to_le64(seg->dma);
> +		entry->seg_size = cpu_to_le32(TRBS_PER_SEGMENT);
> +		entry->rsvd = 0;
> +		seg = seg->next;
> +	}
> +
> +	return 0;
> +}
> +
> +void cdnsp_free_erst(struct cdnsp_device *pdev, struct cdnsp_erst *erst)
> +{
> +	size_t size = sizeof(struct cdnsp_erst_entry) * (erst->num_entries);
> +	struct device *dev = pdev->dev;
> +
> +	if (erst->entries)
> +		dma_free_coherent(dev, size, erst->entries,
> +				  erst->erst_dma_addr);
> +
> +	erst->entries = NULL;
> +}
> +
> +void cdnsp_mem_cleanup(struct cdnsp_device *pdev)
> +{
> +	struct device *dev = pdev->dev;
> +
> +	cdnsp_free_priv_device(pdev);
> +	cdnsp_free_erst(pdev, &pdev->erst);
> +
> +	if (pdev->event_ring)
> +		cdnsp_ring_free(pdev, pdev->event_ring);
> +
> +	pdev->event_ring = NULL;
> +
> +	if (pdev->cmd_ring)
> +		cdnsp_ring_free(pdev, pdev->cmd_ring);
> +
> +	pdev->cmd_ring = NULL;
> +
> +	dma_pool_destroy(pdev->segment_pool);
> +	pdev->segment_pool = NULL;
> +	dma_pool_destroy(pdev->device_pool);
> +	pdev->device_pool = NULL;
> +
> +	if (pdev->dcbaa)
> +		dma_free_coherent(dev, sizeof(*pdev->dcbaa),
> +				  pdev->dcbaa, pdev->dcbaa->dma);
> +
> +	pdev->dcbaa = NULL;
> +
> +	pdev->usb2_port.exist = 0;
> +	pdev->usb3_port.exist = 0;
> +	pdev->usb2_port.port_num = 0;
> +	pdev->usb3_port.port_num = 0;
> +	pdev->active_port = NULL;
> +}
> +
> +static void cdnsp_set_event_deq(struct cdnsp_device *pdev)
> +{
> +	dma_addr_t deq;
> +	u64 temp;
> +
> +	deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +				    pdev->event_ring->dequeue);
> +
> +	/* Update controller event ring dequeue pointer */
> +	temp = cdnsp_read_64(pdev, &pdev->ir_set->erst_dequeue);
> +	temp &= ERST_PTR_MASK;
> +
> +	/*
> +	 * Don't clear the EHB bit (which is RW1C) because
> +	 * there might be more events to service.
> +	 */
> +	temp &= ~ERST_EHB;
> +
> +	cdnsp_write_64(pdev, ((u64)deq & (u64)~ERST_PTR_MASK) | temp,
> +		       &pdev->ir_set->erst_dequeue);
> +}
> +
> +static void cdnsp_add_in_port(struct cdnsp_device *pdev,
> +			      struct cdnsp_port *port,
> +			      __le32 __iomem *addr)
> +{
> +	u32 temp, port_offset, port_count;
> +
> +	temp = readl(addr);
> +	port->maj_rev = CDNSP_EXT_PORT_MAJOR(temp);
> +	port->min_rev = CDNSP_EXT_PORT_MINOR(temp);
> +
> +	/* Port offset and count in the third dword.*/
> +	temp = readl(addr + 2);
> +	port_offset = CDNSP_EXT_PORT_OFF(temp);
> +	port_count = CDNSP_EXT_PORT_COUNT(temp);
> +
> +	port->port_num = port_offset;
> +	port->exist = 1;
> +}
> +
> +/*
> + * Scan the Extended Capabilities for the "Supported Protocol Capabilities" that
> + * specify what speeds each port is supposed to be.
> + */
> +static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev, gfp_t flags)
> +{
> +	void __iomem *base;
> +	u32 offset = 0;
> +	int i;
> +
> +	base = &pdev->cap_regs->hc_capbase;
> +	offset = cdnsp_find_next_ext_cap(base, offset,
> +					 EXT_CAP_CFG_DEV_20PORT_CAP_ID);
> +	pdev->port20_regs = base + offset;
> +
> +	base = &pdev->cap_regs->hc_capbase;
> +	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_CFG_3XPORT_CAP);
> +	pdev->port3x_regs =  base + offset;
> +
> +	offset = 0;
> +	base = &pdev->cap_regs->hc_capbase;
> +
> +	/* Driver expects max 2 extended protocol capability. */
> +	for (i = 0; i < 2; i++) {
> +		u32 temp;
> +
> +		offset = cdnsp_find_next_ext_cap(base, offset,
> +						 EXT_CAPS_PROTOCOL);
> +		temp = readl(base + offset);
> +
> +		if (CDNSP_EXT_PORT_MAJOR(temp) == 0x03 &&
> +		    !pdev->usb3_port.port_num)
> +			cdnsp_add_in_port(pdev, &pdev->usb3_port,
> +					  base + offset);
> +
> +		if (CDNSP_EXT_PORT_MAJOR(temp) == 0x02 &&
> +		    !pdev->usb2_port.port_num)
> +			cdnsp_add_in_port(pdev, &pdev->usb2_port,
> +					  base + offset);
> +	}
> +
> +	if (!pdev->usb2_port.exist || !pdev->usb3_port.exist) {
> +		dev_err(pdev->dev, "Error: Only one port detected\n");
> +		return -ENODEV;
> +	}
> +
> +	pdev->usb2_port.regs = (struct cdnsp_port_regs *)
> +			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
> +				(pdev->usb2_port.port_num - 1));
> +
> +	pdev->usb3_port.regs = (struct cdnsp_port_regs *)
> +			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
> +				(pdev->usb3_port.port_num - 1));
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize memory for CDNSP (one-time init).
> + *
> + * Program the PAGESIZE register, initialize the device context array, create
> + * device contexts, set up a command ring segment, create event
> + * ring (one for now).
> + */
> +int cdnsp_mem_init(struct cdnsp_device *pdev, gfp_t flags)
> +{
> +	struct device *dev = pdev->dev;
> +	unsigned int val;
> +	dma_addr_t dma;
> +	u32 page_size;
> +	u64 val_64;
> +	int ret;
> +
> +	/*
> +	 * Use 4K pages, since that's common and the minimum the
> +	 * controller supports
> +	 */
> +	page_size = 1 << 12;
> +
> +	val = readl(&pdev->op_regs->config_reg);
> +	val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS);
> +	writel(val, &pdev->op_regs->config_reg);
> +
> +	/*
> +	 * Doorbell array must be physically contiguous
> +	 * and 64-byte (cache line) aligned.
> +	 */
> +	pdev->dcbaa = dma_alloc_coherent(dev, sizeof(*pdev->dcbaa),
> +					 &dma, GFP_KERNEL);
> +	if (!pdev->dcbaa)
> +		goto fail;
> +
> +	memset(pdev->dcbaa, 0, sizeof(*pdev->dcbaa));
> +	pdev->dcbaa->dma = dma;
> +
> +	cdnsp_write_64(pdev, dma, &pdev->op_regs->dcbaa_ptr);
> +
> +	/*
> +	 * Initialize the ring segment pool.  The ring must be a contiguous
> +	 * structure comprised of TRBs. The TRBs must be 16 byte aligned,
> +	 * however, the command ring segment needs 64-byte aligned segments
> +	 * and our use of dma addresses in the trb_address_map radix tree needs
> +	 * TRB_SEGMENT_SIZE alignment, so driver pick the greater alignment
> +	 * need.
> +	 */
> +	pdev->segment_pool = dma_pool_create("CDNSP ring segments", dev,
> +					     TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE,
> +					     page_size);
> +
> +	pdev->device_pool = dma_pool_create("CDNSP input/output contexts", dev,
> +					    2112, 64, page_size);

Replace 2112 with a define.

> +
> +	if (!pdev->segment_pool || !pdev->device_pool)
> +		goto fail;
> +
> +	/* Set up the command ring to have one segments for now. */
> +	pdev->cmd_ring = cdnsp_ring_alloc(pdev, 1, TYPE_COMMAND, 0, flags);
> +	if (!pdev->cmd_ring)
> +		goto fail;
> +
> +	/* Set the address in the Command Ring Control register */
> +	val_64 = cdnsp_read_64(pdev, &pdev->op_regs->cmd_ring);
> +	val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
> +		 (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
> +		 pdev->cmd_ring->cycle_state;
> +	cdnsp_write_64(pdev, val_64, &pdev->op_regs->cmd_ring);
> +
> +	val = readl(&pdev->cap_regs->db_off);
> +	val &= DBOFF_MASK;
> +	pdev->dba = (void __iomem *)pdev->cap_regs + val;
> +
> +	/* Set ir_set to interrupt register set 0 */
> +	pdev->ir_set = &pdev->run_regs->ir_set[0];
> +
> +	/*
> +	 * Event ring setup: Allocate a normal ring, but also setup
> +	 * the event ring segment table (ERST).
> +	 */
> +	pdev->event_ring = cdnsp_ring_alloc(pdev, ERST_NUM_SEGS, TYPE_EVENT,
> +					    0, flags);
> +	if (!pdev->event_ring)
> +		goto fail;
> +
> +	ret = cdnsp_alloc_erst(pdev, pdev->event_ring, &pdev->erst, flags);
> +	if (ret)
> +		goto fail;
> +
> +	/* Set ERST count with the number of entries in the segment table. */
> +	val = readl(&pdev->ir_set->erst_size);
> +	val &= ERST_SIZE_MASK;
> +	val |= ERST_NUM_SEGS;
> +	writel(val, &pdev->ir_set->erst_size);
> +
> +	/* Set the segment table base address. */
> +	val_64 = cdnsp_read_64(pdev, &pdev->ir_set->erst_base);
> +	val_64 &= ERST_PTR_MASK;
> +	val_64 |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
> +	cdnsp_write_64(pdev, val_64, &pdev->ir_set->erst_base);
> +
> +	/* Set the event ring dequeue address. */
> +	cdnsp_set_event_deq(pdev);
> +
> +	if (cdnsp_setup_port_arrays(pdev, flags))

Preserve the error code.

> +		goto fail;
> +
> +	if (cdnsp_alloc_priv_device(pdev, GFP_ATOMIC)) {

Preserve the error code.

> +		dev_err(pdev->dev,
> +			"Could not allocate cdnsp_device data structures\n");
> +		goto fail;
> +	}
> +
> +	return 0;
> +fail:

I always tell everyone that if there is an error label called "fail:"
or "err:" or "out:" that's a redflag.  Label names should say what the
label does.

> +	dev_err(pdev->dev, "Couldn't initialize memory\n");
> +	cdnsp_halt(pdev);
> +	cdnsp_reset(pdev);
> +	cdnsp_mem_cleanup(pdev);

This style of error handling is hopeless.  You've got one big function
that tries to free everything whether it was allocated or not.  There
are a few typical bugs with this.
1) Forget to free something (this style of error handling cannot be
   audited).
2) NULL dereference because kfree(foo->bar) when foo wasn't allocated.
3) Drop a reference count when the reference count wasn't incremented.
4) Dereferencing an error pointer or uninitialized pointer.
5) Double free bug because other code uses normal error handling style.

This code has at least one double free bug.

The better way to do error handling is to use a system called "Free
the last allocation".


	a = alloc();
	if (!a)
		return -ENOMEM;

	b = alloc();
	if (!b) {
		ret = -ENOMEM;
		goto free_a;
	}

	c = alloc();
	if (!c) {
		ret -ENOMEM;
		goto free_b;
	}

	return 0;

free_b:
	free(b);
free_a:
	free(a);

Just from looking at the gotos then you know the code is correct.
What was the most recent allocation?  a.  What does goto free_a; do?
It frees a.

Then you copy all the error handling and add a free(c) and that is your
free function:

void free_funtcion(struct whatever *p)
{
	free(c);
	free(b);
	free(a);
}

This uses basically the same number of lines (not counting curly braces
lines and label names) because it means that we can delete the if
statements in the free_everything_function().

I'm not going to tell you what the double free bug is because I want you
to try auditing the free everything function yourself.  :P

> +	return -ENOMEM;
> +}
> +
> diff --git a/drivers/usb/cdnsp/ring.c b/drivers/usb/cdnsp/ring.c
> new file mode 100644
> index 000000000000..a6baf27ad778
> --- /dev/null
> +++ b/drivers/usb/cdnsp/ring.c
> @@ -0,0 +1,2380 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + * Code based on Linux XHCI driver.
> + * Origin: Copyright (C) 2008 Intel Corp
> + */
> +
> +/*
> + * Ring initialization rules:
> + * 1. Each segment is initialized to zero, except for link TRBs.
> + * 2. Ring cycle state = 0. This represents Producer Cycle State (PCS) or
> + *    Consumer Cycle State (CCS), depending on ring function.
> + * 3. Enqueue pointer = dequeue pointer = address of first TRB in the segment.
> + *
> + * Ring behavior rules:
> + * 1. A ring is empty if enqueue == dequeue. This means there will always be at
> + *    least one free TRB in the ring. This is useful if you want to turn that
> + *    into a link TRB and expand the ring.
> + * 2. When incrementing an enqueue or dequeue pointer, if the next TRB is a
> + *    link TRB, then load the pointer with the address in the link TRB. If the
> + *    link TRB had its toggle bit set, you may need to update the ring cycle
> + *    state (see cycle bit rules). You may have to do this multiple times
> + *    until you reach a non-link TRB.
> + * 3. A ring is full if enqueue++ (for the definition of increment above)
> + *    equals the dequeue pointer.
> + *
> + * Cycle bit rules:
> + * 1. When a consumer increments a dequeue pointer and encounters a toggle bit
> + *    in a link TRB, it must toggle the ring cycle state.
> + * 2. When a producer increments an enqueue pointer and encounters a toggle bit
> + *    in a link TRB, it must toggle the ring cycle state.
> + *
> + * Producer rules:
> + * 1. Check if ring is full before you enqueue.
> + * 2. Write the ring cycle state to the cycle bit in the TRB you're enqueuing.
> + *    Update enqueue pointer between each write (which may update the ring
> + *    cycle state).
> + * 3. Notify consumer. If SW is producer, it rings the doorbell for command
> + *    and endpoint rings. If controller is the producer for the event ring,
> + *    and it generates an interrupt according to interrupt modulation rules.
> + *
> + * Consumer rules:
> + * 1. Check if TRB belongs to you. If the cycle bit == your ring cycle state,
> + *    the TRB is owned by the consumer.
> + * 2. Update dequeue pointer (which may update the ring cycle state) and
> + *    continue processing TRBs until you reach a TRB which is not owned by you.
> + * 3. Notify the producer. SW is the consumer for the event ring, and it
> + *    updates event ring dequeue pointer. Controller is the consumer for the
> + *    command and endpoint rings; it generates events on the event ring
> + *    for these.
> + */
> +
> +#include <linux/scatterlist.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +
> +#include "gadget.h"
> +
> +/*
> + * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
> + * address of the TRB.
> + */
> +dma_addr_t cdnsp_trb_virt_to_dma(struct cdnsp_segment *seg,
> +				 union cdnsp_trb *trb)
> +{
> +	unsigned long segment_offset;
> +
> +	if (!seg || !trb || trb < seg->trbs)
                            ^^^^^^^^^^^^^^^
It's alarming that a wild kernel pointer is even a possibility.  Don't
we also have to check alignment and that it can't go off the other side
of the array?


> +		return 0;
> +
> +	/* offset in TRBs */
> +	segment_offset = trb - seg->trbs;
> +	if (segment_offset >= TRBS_PER_SEGMENT)
> +		return 0;
> +
> +	return seg->dma + (segment_offset * sizeof(*trb));
> +}
> +
> +static bool cdnsp_trb_is_noop(union cdnsp_trb *trb)
> +{
> +	return TRB_TYPE_NOOP_LE32(trb->generic.field[3]);
> +}
> +
> +static bool cdnsp_trb_is_link(union cdnsp_trb *trb)
> +{
> +	return TRB_TYPE_LINK_LE32(trb->link.control);
> +}
> +
> +bool cdnsp_last_trb_on_seg(struct cdnsp_segment *seg, union cdnsp_trb *trb)
> +{
> +	return trb == &seg->trbs[TRBS_PER_SEGMENT - 1];
> +}
> +
> +bool cdnsp_last_trb_on_ring(struct cdnsp_ring *ring,
> +			    struct cdnsp_segment *seg,
> +			    union cdnsp_trb *trb)
> +{
> +	return cdnsp_last_trb_on_seg(seg, trb) && (seg->next == ring->first_seg);
> +}
> +
> +static bool cdnsp_link_trb_toggles_cycle(union cdnsp_trb *trb)
> +{
> +	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
> +}
> +
> +static void cdnsp_trb_to_noop(union cdnsp_trb *trb, u32 noop_type)
> +{
> +	if (cdnsp_trb_is_link(trb)) {
> +		/* Unchain chained link TRBs. */
> +		trb->link.control &= cpu_to_le32(~TRB_CHAIN);
> +	} else {
> +		trb->generic.field[0] = 0;
> +		trb->generic.field[1] = 0;
> +		trb->generic.field[2] = 0;
> +		/* Preserve only the cycle bit of this TRB. */
> +		trb->generic.field[3] &= cpu_to_le32(TRB_CYCLE);
> +		trb->generic.field[3] |= cpu_to_le32(TRB_TYPE(noop_type));
> +	}
> +}
> +
> +/*
> + * Updates trb to point to the next TRB in the ring, and updates seg if the next
> + * TRB is in a new segment. This does not skip over link TRBs, and it does not
> + * effect the ring dequeue or enqueue pointers.
> + */
> +static void cdnsp_next_trb(struct cdnsp_device *pdev,
> +			   struct cdnsp_ring *ring,
> +			   struct cdnsp_segment **seg,
> +			   union cdnsp_trb **trb)
> +{
> +	if (cdnsp_trb_is_link(*trb)) {
> +		*seg = (*seg)->next;
> +		*trb = ((*seg)->trbs);
> +	} else {
> +		(*trb)++;
> +	}
> +}
> +
> +/*
> + * See Cycle bit rules. SW is the consumer for the event ring only.
> + * Don't make a ring full of link TRBs. That would be dumb and this would loop.
> + */
> +void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
> +{
> +	/* event ring doesn't have link trbs, check for last trb. */
> +	if (ring->type == TYPE_EVENT) {
> +		if (!cdnsp_last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
> +			ring->dequeue++;
> +			return;
> +		}
> +
> +		if (cdnsp_last_trb_on_ring(ring, ring->deq_seg, ring->dequeue))
> +			ring->cycle_state ^= 1;
> +
> +		ring->deq_seg = ring->deq_seg->next;
> +		ring->dequeue = ring->deq_seg->trbs;
> +		return;
> +	}
> +
> +	/* All other rings have link trbs. */
> +	if (!cdnsp_trb_is_link(ring->dequeue)) {
> +		ring->dequeue++;
> +		ring->num_trbs_free++;
> +	}
> +	while (cdnsp_trb_is_link(ring->dequeue)) {
> +		ring->deq_seg = ring->deq_seg->next;
> +		ring->dequeue = ring->deq_seg->trbs;
> +	}
> +}
> +
> +/*
> + * See Cycle bit rules. SW is the consumer for the event ring only.
> + * Don't make a ring full of link TRBs. That would be dumb and this would loop.
> + *
> + * If we've just enqueued a TRB that is in the middle of a TD (meaning the
> + * chain bit is set), then set the chain bit in all the following link TRBs.
> + * If we've enqueued the last TRB in a TD, make sure the following link TRBs
> + * have their chain bit cleared (so that each Link TRB is a separate TD).
> + *
> + * @more_trbs_coming:	Will you enqueue more TRBs before ringing the doorbell.
> + */
> +static void cdnsp_inc_enq(struct cdnsp_device *pdev,
> +			  struct cdnsp_ring *ring,
> +			  bool more_trbs_coming)
> +{
> +	union cdnsp_trb *next;
> +	u32 chain;
> +
> +	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
> +
> +	/* If this is not event ring, there is one less usable TRB. */
> +	if (!cdnsp_trb_is_link(ring->enqueue))
> +		ring->num_trbs_free--;
> +	next = ++(ring->enqueue);
> +
> +	/* Update the dequeue pointer further if that was a link TRB */
> +	while (cdnsp_trb_is_link(next)) {
> +		/*
> +		 * If the caller doesn't plan on enqueuing more TDs before
> +		 * ringing the doorbell, then we don't want to give the link TRB
> +		 * to the hardware just yet. We'll give the link TRB back in
> +		 * cdnsp_prepare_ring() just before we enqueue the TD at the
> +		 * top of the ring.
> +		 */
> +		if (!chain && !more_trbs_coming)
> +			break;
> +
> +		next->link.control &= cpu_to_le32(~TRB_CHAIN);
> +		next->link.control |= cpu_to_le32(chain);
> +
> +		/* Give this link TRB to the hardware */
> +		wmb();
> +		next->link.control ^= cpu_to_le32(TRB_CYCLE);
> +
> +		/* Toggle the cycle bit after the last ring segment. */
> +		if (cdnsp_link_trb_toggles_cycle(next))
> +			ring->cycle_state ^= 1;
> +
> +		ring->enq_seg = ring->enq_seg->next;
> +		ring->enqueue = ring->enq_seg->trbs;
> +		next = ring->enqueue;
> +	}
> +}
> +
> +/*
> + * Check to see if there's room to enqueue num_trbs on the ring and make sure
> + * enqueue pointer will not advance into dequeue segment.
> + */
> +static inline int cdnsp_room_on_ring(struct cdnsp_device *pdev,
> +				     struct cdnsp_ring *ring,
> +				     unsigned int num_trbs)

Make this a bool.  You can remove the inline as well.  The compiler
pretty much ignores inline and it's smart enough that we trust it
normally.

> +{
> +	int num_trbs_in_deq_seg;
> +
> +	if (ring->num_trbs_free < num_trbs)
> +		return 0;
> +
> +	if (ring->type != TYPE_COMMAND && ring->type != TYPE_EVENT) {
> +		num_trbs_in_deq_seg = ring->dequeue - ring->deq_seg->trbs;
> +
> +		if (ring->num_trbs_free < num_trbs + num_trbs_in_deq_seg)
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +/* Ring the doorbell after placing a command on the ring. */
> +void cdnsp_ring_cmd_db(struct cdnsp_device *pdev)
> +{
> +	writel(DB_VALUE_CMD, &pdev->dba->cmd_db);
> +}
> +
> +/* Ring the doorbell after placing a transfer on the ring. */
> +static int cdnsp_ring_ep_doorbell(struct cdnsp_device *pdev,
> +				  struct cdnsp_ep *pep,
> +				  unsigned int stream_id)
> +{
> +	__le32 __iomem *reg_addr = &pdev->dba->ep_db;
> +	unsigned int ep_state = pep->ep_state;
> +	unsigned int db_value;
> +
> +	/*
> +	 * Don't ring the doorbell for this endpoint if endpoint is halted or
> +	 * disabled.
> +	 */
> +	if (ep_state & EP_HALTED || !(ep_state & EP_ENABLED))
> +		return 0;
> +
> +	/* For stream capable endpoints driver can ring doorbell only twice. */
> +	if (pep->ep_state & EP_HAS_STREAMS) {
> +		if (pep->stream_info.drbls_count >= 2)
> +			return 0;
> +
> +		pep->stream_info.drbls_count++;
> +	}
> +
> +	pep->ep_state &= ~EP_STOPPED;
> +
> +	if (pep->idx == 0 && pdev->ep0_stage == CDNSP_DATA_STAGE &&
> +	    !pdev->ep0_expect_in)
> +		db_value = DB_VALUE_EP0_OUT(pep->idx, stream_id);
> +	else
> +		db_value = DB_VALUE(pep->idx, stream_id);
> +
> +	writel(db_value, reg_addr);
> +
> +	return 1;

Please document the return values for this function.

> +}
> +
> +/*
> + * Get the right ring for the given pep and stream_id.
> + * If the endpoint supports streams, boundary check the USB request's stream ID.
> + * If the endpoint doesn't support streams, return the singular endpoint ring.
> + */
> +static struct cdnsp_ring *cdnsp_get_transfer_ring(struct cdnsp_device *pdev,
> +						  struct cdnsp_ep *pep,
> +						  unsigned int stream_id)
> +{
> +	if (!(pep->ep_state & EP_HAS_STREAMS))
> +		return pep->ring;
> +
> +	if (stream_id == 0 || stream_id >= pep->stream_info.num_streams) {
> +		dev_err(pdev->dev, "ERR: %s ring doesn't exist for SID: %d.\n",
> +			pep->name, stream_id);
> +		return NULL;
> +	}
> +
> +	return pep->stream_info.stream_rings[stream_id];
> +}
> +
> +static struct cdnsp_ring *
> +	cdnsp_request_to_transfer_ring(struct cdnsp_device *pdev,
> +				       struct cdnsp_request *preq)
> +{
> +	return cdnsp_get_transfer_ring(pdev, preq->pep,
> +				       preq->request.stream_id);
> +}
> +
> +/* Ring the doorbell for any rings with pending requests. */
> +void cdnsp_ring_doorbell_for_active_rings(struct cdnsp_device *pdev,
> +					  struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_stream_info *stream_info;
> +	unsigned int stream_id;
> +	int ret;
> +
> +	if (pep->ep_state & EP_DIS_IN_RROGRESS)
> +		return;
> +
> +	/* A ring has pending Request if its TD list is not empty. */
> +	if (!(pep->ep_state & EP_HAS_STREAMS) && pep->number) {
> +		if (pep->ring && !list_empty(&pep->ring->td_list))
> +			cdnsp_ring_ep_doorbell(pdev, pep, 0);
> +		return;
> +	}
> +
> +	stream_info = &pep->stream_info;
> +
> +	for (stream_id = 1; stream_id < stream_info->num_streams; stream_id++) {
> +		struct cdnsp_td *td, *td_temp;
> +		struct cdnsp_ring *ep_ring;
> +
> +		if (stream_info->drbls_count >= 2)
> +			return;
> +
> +		ep_ring = cdnsp_get_transfer_ring(pdev, pep, stream_id);
> +		if (!ep_ring)
> +			continue;
> +
> +		if (!ep_ring->stream_active || ep_ring->stream_rejected)
> +			continue;
> +
> +		list_for_each_entry_safe(td, td_temp, &ep_ring->td_list,
> +					 td_list) {
> +			if (td->drbl)
> +				continue;
> +
> +			ret = cdnsp_ring_ep_doorbell(pdev, pep, stream_id);
> +			if (ret)
> +				td->drbl = 1;
> +		}
> +	}
> +}
> +
> +/*
> + * Get the hw dequeue pointer controller stopped on, either directly from the
> + * endpoint context, or if streams are in use from the stream context.
> + * The returned hw_dequeue contains the lowest four bits with cycle state
> + * and possible stream context type.
> + */
> +static u64 cdnsp_get_hw_deq(struct cdnsp_device *pdev,
> +			    unsigned int ep_index,
> +			    unsigned int stream_id)
> +{
> +	struct cdnsp_stream_ctx *st_ctx;
> +	struct cdnsp_ep *pep;
> +
> +	pep = &pdev->eps[stream_id];
> +
> +	if (pep->ep_state & EP_HAS_STREAMS) {
> +		st_ctx = &pep->stream_info.stream_ctx_array[stream_id];
> +		return le64_to_cpu(st_ctx->stream_ring);
> +	}
> +
> +	return le64_to_cpu(pep->out_ctx->deq);
> +}
> +
> +/*
> + * Move the controller endpoint ring dequeue pointer past cur_td.
> + * Record the new state of the controller endpoint ring dequeue segment,
> + * dequeue pointer, and new consumer cycle state in state.
> + * Update internal representation of the ring's dequeue pointer.
> + *
> + * We do this in three jumps:
> + *  - First we update our new ring state to be the same as when the
> + *    controller stopped.
> + *  - Then we traverse the ring to find the segment that contains
> + *    the last TRB in the TD. We toggle the controller new cycle state
> + *    when we pass any link TRBs with the toggle cycle bit set.
> + *  - Finally we move the dequeue state one TRB further, toggling the cycle bit
> + *    if we've moved it past a link TRB with the toggle cycle bit set.
> + */
> +static void cdnsp_find_new_dequeue_state(struct cdnsp_device *pdev,
> +					 struct cdnsp_ep *pep,
> +					 unsigned int stream_id,
> +					 struct cdnsp_td *cur_td,
> +					 struct cdnsp_dequeue_state *state)
> +{
> +	bool td_last_trb_found = false;
> +	struct cdnsp_segment *new_seg;
> +	struct cdnsp_ring *ep_ring;
> +	union cdnsp_trb *new_deq;
> +	bool cycle_found = false;
> +	u64 hw_dequeue;
> +
> +	ep_ring = cdnsp_get_transfer_ring(pdev, pep, stream_id);
> +	if (!ep_ring)
> +		return;
> +
> +	/*
> +	 * Dig out the cycle state saved by the controller during the
> +	 * stop endpoint command.
> +	 */
> +	hw_dequeue = cdnsp_get_hw_deq(pdev, pep->idx, stream_id);
> +	new_seg = ep_ring->deq_seg;
> +	new_deq = ep_ring->dequeue;
> +	state->new_cycle_state = hw_dequeue & 0x1;
> +	state->stream_id = stream_id;
> +
> +	/*
> +	 * We want to find the pointer, segment and cycle state of the new trb
> +	 * (the one after current TD's last_trb). We know the cycle state at
> +	 * hw_dequeue, so walk the ring until both hw_dequeue and last_trb are
> +	 * found.
> +	 */
> +	do {
> +		if (!cycle_found && cdnsp_trb_virt_to_dma(new_seg, new_deq)
> +		    == (dma_addr_t)(hw_dequeue & ~0xf)) {
> +			cycle_found = true;
> +
> +			if (td_last_trb_found)
> +				break;
> +		}
> +
> +		if (new_deq == cur_td->last_trb)
> +			td_last_trb_found = true;
> +
> +		if (cycle_found && cdnsp_trb_is_link(new_deq) &&
> +		    cdnsp_link_trb_toggles_cycle(new_deq))
> +			state->new_cycle_state ^= 0x1;
> +
> +		cdnsp_next_trb(pdev, ep_ring, &new_seg, &new_deq);
> +
> +		/* Search wrapped around, bail out. */
> +		if (new_deq == pep->ring->dequeue) {
> +			dev_err(pdev->dev,
> +				"Error: Failed finding new dequeue state\n");
> +			state->new_deq_seg = NULL;
> +			state->new_deq_ptr = NULL;
> +			return;
> +		}
> +
> +	} while (!cycle_found || !td_last_trb_found);
> +
> +	state->new_deq_seg = new_seg;
> +	state->new_deq_ptr = new_deq;
> +}
> +
> +/*
> + * flip_cycle means flip the cycle bit of all but the first and last TRB.
> + * (The last TRB actually points to the ring enqueue pointer, which is not part
> + * of this TD.) This is used to remove partially enqueued isoc TDs from a ring.
> + */
> +static void cdnsp_td_to_noop(struct cdnsp_device *pdev,
> +			     struct cdnsp_ring *ep_ring,
> +			     struct cdnsp_td *td,
> +			     bool flip_cycle)
> +{
> +	struct cdnsp_segment *seg = td->start_seg;
> +	union cdnsp_trb *trb = td->first_trb;
> +
> +	while (1) {
> +		cdnsp_trb_to_noop(trb, TRB_TR_NOOP);
> +
> +		/* flip cycle if asked to */
> +		if (flip_cycle && trb != td->first_trb && trb != td->last_trb)
> +			trb->generic.field[3] ^= cpu_to_le32(TRB_CYCLE);
> +
> +		if (trb == td->last_trb)
> +			break;
> +
> +		cdnsp_next_trb(pdev, ep_ring, &seg, &trb);
> +	}
> +}
> +
> +/*
> + * This TD is defined by the TRBs starting at start_trb in start_seg and ending
> + * at end_trb, which may be in another segment. If the suspect DMA address is a
> + * TRB in this TD, this function returns that TRB's segment. Otherwise it
> + * returns 0.
> + */
> +struct cdnsp_segment *cdnsp_trb_in_td(struct cdnsp_device *pdev,
> +				      struct cdnsp_segment *start_seg,
> +				      union cdnsp_trb *start_trb,
> +				      union cdnsp_trb *end_trb,
> +				      dma_addr_t suspect_dma)
> +{
> +	struct cdnsp_segment *cur_seg;
> +	union cdnsp_trb *temp_trb;
> +	dma_addr_t end_seg_dma;
> +	dma_addr_t end_trb_dma;
> +	dma_addr_t start_dma;
> +
> +	start_dma = cdnsp_trb_virt_to_dma(start_seg, start_trb);
> +	cur_seg = start_seg;
> +
> +	do {
> +		if (start_dma == 0)
> +			return NULL;
> +
> +		temp_trb = &cur_seg->trbs[TRBS_PER_SEGMENT - 1];
> +		/* We may get an event for a Link TRB in the middle of a TD */
> +		end_seg_dma = cdnsp_trb_virt_to_dma(cur_seg, temp_trb);
> +		/* If the end TRB isn't in this segment, this is set to 0 */
> +		end_trb_dma = cdnsp_trb_virt_to_dma(cur_seg, end_trb);
> +
> +		if (end_trb_dma > 0) {
> +			/*
> +			 * The end TRB is in this segment, so suspect should
> +			 * be here
> +			 */
> +			if (start_dma <= end_trb_dma) {
> +				if (suspect_dma >= start_dma &&
> +				    suspect_dma <= end_trb_dma) {
> +					return cur_seg;
> +				}
> +			} else {
> +				/*
> +				 * Case for one segment with a
> +				 * TD wrapped around to the top
> +				 */
> +				if ((suspect_dma >= start_dma &&
> +				     suspect_dma <= end_seg_dma) ||
> +				    (suspect_dma >= cur_seg->dma &&
> +				     suspect_dma <= end_trb_dma)) {
> +					return cur_seg;
> +				}
> +			}
> +
> +			return NULL;
> +		}
> +
> +		/* Might still be somewhere in this segment */
> +		if (suspect_dma >= start_dma && suspect_dma <= end_seg_dma)
> +			return cur_seg;
> +
> +		cur_seg = cur_seg->next;
> +		start_dma = cdnsp_trb_virt_to_dma(cur_seg, &cur_seg->trbs[0]);
> +	} while (cur_seg != start_seg);
> +
> +	return NULL;
> +}
> +
> +void cdnsp_unmap_td_bounce_buffer(struct cdnsp_device *pdev,
> +				  struct cdnsp_ring *ring,
> +				  struct cdnsp_td *td)
> +{
> +	struct cdnsp_segment *seg = td->bounce_seg;
> +	struct cdnsp_request *preq;
> +	size_t len;
> +
> +	if (!seg)
> +		return;
> +
> +	preq = td->preq;
> +
> +	if (!preq->direction) {
> +		dma_unmap_single(pdev->dev, seg->bounce_dma,
> +				 ring->bounce_buf_len,  DMA_TO_DEVICE);
> +		return;
> +	}
> +
> +	dma_unmap_single(pdev->dev, seg->bounce_dma, ring->bounce_buf_len,
> +			 DMA_FROM_DEVICE);
> +
> +	/* For in transfers we need to copy the data from bounce to sg */
> +	len = sg_pcopy_from_buffer(preq->request.sg, preq->request.num_sgs,
> +				   seg->bounce_buf, seg->bounce_len,
> +				   seg->bounce_offs);
> +	if (len != seg->bounce_len)
> +		dev_warn(pdev->dev, "WARN Wrong bounce buffer read length: %zu != %d\n",
> +			 len, seg->bounce_len);
> +
> +	seg->bounce_len = 0;
> +	seg->bounce_offs = 0;
> +}
> +
> +static int cdnsp_cmd_set_deq(struct cdnsp_device *pdev,
> +			     struct cdnsp_ep *pep,
> +			     struct cdnsp_dequeue_state *deq_state)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	int ret = 0;
> +
> +	if (!deq_state->new_deq_ptr || !deq_state->new_deq_seg) {
> +		cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +		return ret;

return 0;

> +	}
> +
> +	cdnsp_queue_new_dequeue_state(pdev, pep, deq_state);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +
> +	/*
> +	 * Update the ring's dequeue segment and dequeue pointer
> +	 * to reflect the new position.
> +	 */
> +	ep_ring = cdnsp_get_transfer_ring(pdev, pep, deq_state->stream_id);
> +
> +	if (cdnsp_trb_is_link(ep_ring->dequeue)) {
> +		ep_ring->deq_seg = ep_ring->deq_seg->next;
> +		ep_ring->dequeue = ep_ring->deq_seg->trbs;
> +	}
> +
> +	while (ep_ring->dequeue != deq_state->new_deq_ptr) {
> +		ep_ring->num_trbs_free++;
> +		ep_ring->dequeue++;
> +
> +		if (cdnsp_trb_is_link(ep_ring->dequeue)) {
> +			if (ep_ring->dequeue == deq_state->new_deq_ptr)
> +				break;
> +
> +			ep_ring->deq_seg = ep_ring->deq_seg->next;
> +			ep_ring->dequeue = ep_ring->deq_seg->trbs;
> +		}
> +	}
> +
> +	/*
> +	 * Probably there was TIMEOUT during handling Set Dequeue Pointer
> +	 * command. It's critical error and controller will be stopped.
> +	 */
> +	if (ret)
> +		return -ESHUTDOWN;
> +
> +	/* Restart any rings with pending requests */
> +	cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +
> +	return ret;

return 0;

> +}
> +
> +int cdnsp_remove_request(struct cdnsp_device *pdev,
> +			 struct cdnsp_request *preq,
> +			 struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_dequeue_state deq_state;
> +	struct cdnsp_td *cur_td = NULL;
> +	struct cdnsp_ring *ep_ring;
> +	struct cdnsp_segment *seg;
> +	int status = -ECONNRESET;
> +	int ret = 0;
> +	u64 hw_deq;
> +
> +	memset(&deq_state, 0, sizeof(deq_state));
> +
> +	cur_td = &preq->td;
> +	ep_ring = cdnsp_request_to_transfer_ring(pdev, preq);
> +
> +	/*
> +	 * If we stopped on the TD we need to cancel, then we have to
> +	 * move the controller endpoint ring dequeue pointer past
> +	 * this TD.
> +	 */
> +	hw_deq = cdnsp_get_hw_deq(pdev, pep->idx, preq->request.stream_id);
> +	hw_deq &= ~0xf;
> +
> +	seg = cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
> +			      cur_td->last_trb, hw_deq);
> +
> +	if (seg && (pep->ep_state & EP_ENABLED))
> +		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
> +					     cur_td, &deq_state);
> +	else
> +		cdnsp_td_to_noop(pdev, ep_ring, cur_td, false);
> +
> +	/*
> +	 * The event handler won't see a completion for this TD anymore,
> +	 * so remove it from the endpoint ring's TD list.
> +	 */
> +	list_del_init(&cur_td->td_list);
> +	ep_ring->num_tds--;
> +	pep->stream_info.td_count--;
> +
> +	/*
> +	 * During disconnecting all endpoint will be disabled so we don't
> +	 * have to worry about updating dequeue pointer.
> +	 */
> +	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
> +		status = -ESHUTDOWN;
> +		ret = cdnsp_cmd_set_deq(pdev, pep, &deq_state);
> +	}
> +
> +	cdnsp_unmap_td_bounce_buffer(pdev, ep_ring, cur_td);
> +	cdnsp_gadget_giveback(pep, cur_td->preq, status);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_update_port_id(struct cdnsp_device *pdev, u32 port_id)
> +{
> +	struct cdnsp_port *port = pdev->active_port;
> +	u8 port_changed  = 0;

Delete the port_changed variable.

> +	u8 old_port = 0;
> +
> +	if (port && port->port_num == port_id)
> +		return 0;
> +
> +	if (port)
> +		old_port = port->port_num;
> +
> +	if (port_id == pdev->usb2_port.port_num) {
> +		port = &pdev->usb2_port;
> +	} else if (port_id == pdev->usb3_port.port_num) {
> +		port  = &pdev->usb3_port;
> +	} else {
> +		dev_err(pdev->dev, "Port event with invalid port ID %d\n",
> +			port_id);
> +		return -EINVAL;
> +	}
> +
> +	if (port_id != old_port) {
> +		cdnsp_disable_slot(pdev);
> +		pdev->active_port = port;
> +		cdnsp_enable_slot(pdev);
> +		port_changed = 1;
> +	}
> +
> +	if (port_id == pdev->usb2_port.port_num)
> +		cdnsp_set_usb2_hardware_lpm(pdev, NULL, 1);
> +	else
> +		writel(PORT_U1_TIMEOUT(1) | PORT_U2_TIMEOUT(1),
> +		       &pdev->usb3_port.regs->portpmsc);
> +
> +	return 0;
> +}
> +
> +static void cdnsp_handle_port_status(struct cdnsp_device *pdev,
> +				     union cdnsp_trb *event)
> +{
> +	struct cdnsp_port_regs __iomem *port_regs;
> +	u32 portsc, cmd_regs;
> +	u32 link_state = 0;

Don't initialize.

> +	u8 port2 = 0;

Make this a bool.

> +	u32 port_id;
> +
> +	/* Port status change events always have a successful completion code */
> +	if (GET_COMP_CODE(le32_to_cpu(event->generic.field[2])) != COMP_SUCCESS)
> +		dev_err(pdev->dev, "ERR: incorrect PSC event\n");
> +
> +	port_id = GET_PORT_ID(le32_to_cpu(event->generic.field[0]));
> +
> +	if (cdnsp_update_port_id(pdev, port_id))
> +		goto cleanup;
> +
> +	port_regs = pdev->active_port->regs;
> +
> +	if (port_id == pdev->usb2_port.port_num)
> +		port2 = 1;
> +
> +new_event:
> +	portsc = readl(&port_regs->portsc);
> +	writel(cdnsp_port_state_to_neutral(portsc) |
> +	       (portsc & PORT_CHANGE_BITS), &port_regs->portsc);
> +
> +	pdev->gadget.speed = cdnsp_port_speed(portsc);
> +	link_state = portsc & PORT_PLS_MASK;
> +
> +	/* Port Link State change detected. */
> +	if ((portsc & PORT_PLC)) {
> +		if (link_state == XDEV_RESUME) {
> +			cmd_regs = readl(&pdev->op_regs->command);
> +			if (!(cmd_regs & CMD_R_S))
> +				goto cleanup;
> +
> +			if (DEV_SUPERSPEED_ANY(portsc)) {
> +				cdnsp_set_link_state(pdev, &port_regs->portsc,
> +						     XDEV_U0);
> +				cdnsp_resume_gadget(pdev);
> +				goto cleanup;
> +			}
> +		}
> +
> +		if (link_state == XDEV_U0 && (pdev->link_state == XDEV_U3 ||
> +					      pdev->link_state == XDEV_U2 ||
> +					      pdev->link_state == XDEV_U1)) {
> +			cdnsp_resume_gadget(pdev);
> +		}
> +
> +		if (link_state == XDEV_U1 && DEV_SUPERSPEED_ANY(portsc))
> +			cdnsp_suspend_gadget(pdev);
> +
> +		pdev->link_state = link_state;
> +	}
> +
> +	if (portsc & PORT_CSC) {
> +		/* Detach device. */
> +		if (pdev->gadget.connected && !(portsc & PORT_CONNECT))
> +			cdnsp_disconnect_gadget(pdev);
> +
> +		/* Attach device. */
> +		if (portsc & PORT_CONNECT) {
> +			if (!port2)
> +				cdnp_irq_reset(pdev);
> +
> +			usb_gadget_set_state(&pdev->gadget, USB_STATE_ATTACHED);
> +		}
> +	}
> +
> +	/* Port reset. */
> +	if ((portsc & (PORT_RC | PORT_WRC)) && (portsc & PORT_CONNECT)) {
> +		cdnp_irq_reset(pdev);
> +		pdev->u1_allowed = 0;
> +		pdev->u2_allowed = 0;
> +	}
> +
> +	if (portsc & PORT_CEC)
> +		dev_err(pdev->dev, "Port Over Current detected\n");
> +
> +	if (portsc & PORT_CEC)
> +		dev_err(pdev->dev, "Port Configure Error detected\n");
> +
> +	if (readl(&port_regs->portsc) & PORT_CHANGE_BITS)
> +		goto new_event;
> +
> +cleanup:
> +	cdnsp_inc_deq(pdev, pdev->event_ring);
> +}
> +
> +static void cdnsp_td_cleanup(struct cdnsp_device *pdev,
> +			     struct cdnsp_td *td,
> +			     struct cdnsp_ring *ep_ring,
> +			     int *status)
> +{
> +	struct cdnsp_request *preq = NULL;

	struct cdnsp_request *preq = td->preq;

> +
> +	preq = td->preq;
> +
> +	/* if a bounce buffer was used to align this td then unmap it */
> +	cdnsp_unmap_td_bounce_buffer(pdev, ep_ring, td);
> +
> +	/*
> +	 * If the controller said we transferred more data than the buffer
> +	 * length, Play it safe and say we didn't transfer anything.
> +	 */
> +	if (preq->request.actual > preq->request.length) {
> +		preq->request.actual = 0;
> +		*status = 0;
> +	}
> +
> +	list_del_init(&td->td_list);
> +	ep_ring->num_tds--;
> +	preq->pep->stream_info.td_count--;
> +
> +	cdnsp_gadget_giveback(preq->pep, preq, *status);
> +}
> +
> +static void cdnsp_finish_td(struct cdnsp_device *pdev,
> +			    struct cdnsp_td *td,
> +			    struct cdnsp_transfer_event *event,
> +			    struct cdnsp_ep *ep,
> +			    int *status)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	u32 trb_comp_code;
> +
> +	ep_ring = cdnsp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
> +	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +
> +	if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
> +	    trb_comp_code == COMP_STOPPED ||
> +	    trb_comp_code == COMP_STOPPED_SHORT_PACKET) {
> +		/*
> +		 * The Endpoint Stop Command completion will take care of any
> +		 * stopped TDs. A stopped TD may be restarted, so don't update
> +		 * the ring dequeue pointer or take this TD off any lists yet.
> +		 */
> +		return;
> +	}
> +
> +	/* Update ring dequeue pointer */
> +	while (ep_ring->dequeue != td->last_trb)

I'm a bit surprised we don't check if "ep_ring" can be NULL.

> +		cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_td_cleanup(pdev, td, ep_ring, status);
> +}
> +
> +/* sum trb lengths from ring dequeue up to stop_trb, _excluding_ stop_trb */
> +static int cdnsp_sum_trb_lengths(struct cdnsp_device *pdev,
> +				 struct cdnsp_ring *ring,
> +				 union cdnsp_trb *stop_trb)
> +{
> +	struct cdnsp_segment *seg = ring->deq_seg;
> +	union cdnsp_trb *trb = ring->dequeue;
> +	u32 sum;
> +
> +	for (sum = 0; trb != stop_trb; cdnsp_next_trb(pdev, ring, &seg, &trb)) {
> +		if (!cdnsp_trb_is_noop(trb) && !cdnsp_trb_is_link(trb))
> +			sum += TRB_LEN(le32_to_cpu(trb->generic.field[2]));
> +	}
> +	return sum;
> +}
> +
> +static int cdnsp_giveback_first_trb(struct cdnsp_device *pdev,
> +				    struct cdnsp_ep *pep,
> +				    unsigned int stream_id,
> +				    int start_cycle,
> +				    struct cdnsp_generic_trb *start_trb)
> +{
> +	/*
> +	 * Pass all the TRBs to the hardware at once and make sure this write
> +	 * isn't reordered.
> +	 */
> +	wmb();
> +
> +	if (start_cycle)
> +		start_trb->field[3] |= cpu_to_le32(start_cycle);
> +	else
> +		start_trb->field[3] &= cpu_to_le32(~TRB_CYCLE);
> +
> +	if ((pep->ep_state & EP_HAS_STREAMS) &&
> +	    !pep->stream_info.first_prime_det)
> +		return 0;
> +
> +	return cdnsp_ring_ep_doorbell(pdev, pep, stream_id);
> +}
> +
> +/*
> + * Process control tds, update USB request status and actual_length.
> + */
> +static void cdnsp_process_ctrl_td(struct cdnsp_device *pdev,
> +				  struct cdnsp_td *td,
> +				  union cdnsp_trb *event_trb,
> +				  struct cdnsp_transfer_event *event,
> +				  struct cdnsp_ep *pep,
> +				  int *status)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	u32 remaining;
> +	u32 trb_type;
> +
> +	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event_trb->generic.field[3]));
> +	ep_ring = cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer));
> +	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> +
> +	/*
> +	 * if on data stage then update the actual_length of the USB
> +	 * request and flag it as set, so it won't be overwritten in the event
> +	 * for the last TRB.
> +	 */
> +	if (trb_type == TRB_DATA) {
> +		td->request_length_set = true;
> +		td->preq->request.actual = td->preq->request.length - remaining;
> +	}
> +
> +	/* at status stage */
> +	if (!td->request_length_set)
> +		td->preq->request.actual = td->preq->request.length;
> +
> +	if (pdev->ep0_stage == CDNSP_DATA_STAGE && pep->number == 0 &&
> +	    pdev->three_stage_setup) {
> +		td = list_entry(ep_ring->td_list.next, struct cdnsp_td,
> +				td_list);
> +		pdev->ep0_stage = CDNSP_STATUS_STAGE;
> +
> +		cdnsp_giveback_first_trb(pdev, pep, 0, ep_ring->cycle_state,
> +					 &td->last_trb->generic);
> +		return;
> +	}
> +
> +	cdnsp_finish_td(pdev, td, event, pep, status);
> +}
> +
> +/*
> + * Process isochronous tds, update usb request status and actual_length.
> + */
> +static void cdnsp_process_isoc_td(struct cdnsp_device *pdev,
> +				  struct cdnsp_td *td,
> +				  union cdnsp_trb *ep_trb,
> +				  struct cdnsp_transfer_event *event,
> +				  struct cdnsp_ep *pep,
> +				  int status)
> +{
> +	u32 remaining, requested, ep_trb_len;
> +	bool sum_trbs_for_length = false;
> +	struct cdnsp_ring *ep_ring;
> +	struct cdnsp_request *preq;

	struct cdnsp_request *preq = td->preq;

> +	u32 trb_comp_code;
> +	u32 td_length;
> +
> +	ep_ring = cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer));
> +	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> +	ep_trb_len = TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
> +
> +	preq = td->preq;
> +	requested = preq->request.length;
> +
> +	/* handle completion code */
> +	switch (trb_comp_code) {
> +	case COMP_SUCCESS:
> +		preq->request.status = 0;
> +		break;
> +	case COMP_SHORT_PACKET:
> +		preq->request.status = 0;
> +		sum_trbs_for_length = true;
> +		break;
> +	case COMP_ISOCH_BUFFER_OVERRUN:
> +	case COMP_BABBLE_DETECTED_ERROR:
> +		preq->request.status = -EOVERFLOW;
> +		break;
> +	case COMP_STOPPED:
> +		sum_trbs_for_length = true;
> +		break;
> +	case COMP_STOPPED_SHORT_PACKET:
> +		/* field normally containing residue now contains transferred */
> +		preq->request.status  = 0;
> +		requested = remaining;
> +		break;
> +	case COMP_STOPPED_LENGTH_INVALID:
> +		requested = 0;
> +		remaining = 0;
> +		break;
> +	default:
> +		sum_trbs_for_length = true;
> +		preq->request.status = -1;
> +		break;
> +	}
> +
> +	if (sum_trbs_for_length) {
> +		td_length = cdnsp_sum_trb_lengths(pdev, ep_ring, ep_trb);
> +		td_length += ep_trb_len - remaining;
> +	} else {
> +		td_length = requested;
> +	}
> +
> +	td->preq->request.actual += td_length;
> +
> +	cdnsp_finish_td(pdev, td, event, pep, &status);
> +}
> +
> +static void cdnsp_skip_isoc_td(struct cdnsp_device *pdev,
> +			       struct cdnsp_td *td,
> +			       struct cdnsp_transfer_event *event,
> +			       struct cdnsp_ep *pep,
> +			       int status)
> +{
> +	struct cdnsp_ring *ep_ring;
> +
> +	ep_ring = cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer));
> +	td->preq->request.status = -EXDEV;
> +	td->preq->request.actual = 0;
> +
> +	/* Update ring dequeue pointer */
> +	while (ep_ring->dequeue != td->last_trb)
> +		cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_td_cleanup(pdev, td, ep_ring, &status);
> +}
> +
> +/*
> + * Process bulk and interrupt tds, update usb request status and actual_length.
> + */
> +static void cdnsp_process_bulk_intr_td(struct cdnsp_device *pdev,
> +				       struct cdnsp_td *td,
> +				       union cdnsp_trb *ep_trb,
> +				       struct cdnsp_transfer_event *event,
> +				       struct cdnsp_ep *ep,
> +				       int *status)
> +{
> +	u32 remaining, requested, ep_trb_len;
> +	struct cdnsp_ring *ep_ring;
> +	u32 trb_comp_code;
> +
> +	ep_ring = cdnsp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
> +	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> +	ep_trb_len = TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
> +	requested = td->preq->request.length;
> +
> +	switch (trb_comp_code) {
> +	case COMP_SUCCESS:
> +	case COMP_SHORT_PACKET:
> +		*status = 0;
> +		break;
> +	case COMP_STOPPED_SHORT_PACKET:
> +		td->preq->request.actual = remaining;
> +		goto finish_td;
> +	case COMP_STOPPED_LENGTH_INVALID:
> +		/* stopped on ep trb with invalid length, exclude it */
> +		ep_trb_len = 0;
> +		remaining = 0;
> +		break;
> +	default:
> +		/* Others already handled above */

What does this comment mean?

> +		break;
> +	}
> +
> +	if (ep_trb == td->last_trb)
> +		ep_trb_len = requested - remaining;
> +	else
> +		ep_trb_len = cdnsp_sum_trb_lengths(pdev, ep_ring, ep_trb) +
> +						   ep_trb_len - remaining;
> +	td->preq->request.actual = ep_trb_len;
> +
> +finish_td:
> +	ep->stream_info.drbls_count--;
> +
> +	cdnsp_finish_td(pdev, td, event, ep, status);
> +}
> +
> +static void cdnsp_handle_tx_nrdy(struct cdnsp_device *pdev,
> +				 struct cdnsp_transfer_event *event)
> +{
> +	struct cdnsp_generic_trb *generic;
> +	struct cdnsp_ring *ep_ring;
> +	struct cdnsp_ep *pep;
> +	int cur_stream;
> +	int ep_index;
> +	int host_sid;
> +	int dev_sid;
> +
> +	generic = (struct cdnsp_generic_trb *)event;
> +	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
> +	dev_sid = TRB_TO_DEV_STREAM(le32_to_cpu(generic->field[0]));
> +	host_sid = TRB_TO_HOST_STREAM(le32_to_cpu(generic->field[2]));
> +
> +	pep = &pdev->eps[ep_index];
> +
> +	if (!(pep->ep_state & EP_HAS_STREAMS))
> +		return;
> +
> +	if (host_sid == STREAM_PRIME_ACK) {
> +		pep->stream_info.first_prime_det = 1;
> +		for (cur_stream = 1; cur_stream < pep->stream_info.num_streams;
> +		    cur_stream++) {
> +			ep_ring = pep->stream_info.stream_rings[cur_stream];
> +			ep_ring->stream_active = 1;
> +			ep_ring->stream_rejected = 0;
> +		}
> +	}
> +
> +	if (host_sid == STREAM_REJECTED) {
> +		struct cdnsp_td *td, *td_temp;
> +
> +		pep->stream_info.drbls_count--;
> +		ep_ring = pep->stream_info.stream_rings[dev_sid];
> +		ep_ring->stream_active = 0;
> +		ep_ring->stream_rejected = 1;
> +
> +		list_for_each_entry_safe(td, td_temp, &ep_ring->td_list,
> +					 td_list) {
> +			td->drbl = 0;
> +		}
> +	}
> +
> +	cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +}
> +
> +/*
> + * If this function returns an error condition, it means it got a Transfer
> + * event with a corrupted TRB DMA address or endpoint is disabled.
> + */
> +static int cdnsp_handle_tx_event(struct cdnsp_device *pdev,
> +				 struct cdnsp_transfer_event *event)
> +{
> +	const struct usb_endpoint_descriptor *desc;
> +	bool handling_skipped_tds = false;
> +	struct cdnsp_segment *ep_seg;
> +	struct cdnsp_td *td = NULL;

Don't initialize

> +	struct cdnsp_ring *ep_ring;
> +	int status = -EINPROGRESS;
> +	union cdnsp_trb *ep_trb;
> +	dma_addr_t ep_trb_dma;
> +	struct cdnsp_ep *pep;
> +	u32 trb_comp_code;
> +	int invalidate;
> +	int ep_index;
> +
> +	invalidate = le32_to_cpu(event->flags) & TRB_EVENT_INVALIDATE;
> +	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
> +	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +	ep_trb_dma = le64_to_cpu(event->buffer);
> +
> +	pep = &pdev->eps[ep_index];
> +	ep_ring = cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer));
> +
> +	/*
> +	 * If device is disconnect then all requests will be dequeued
> +	 * by upper layers as part of disconnect sequence.
> +	 * We don't want handle such event to avoid racing.
> +	 */
> +	if (invalidate || !pdev->gadget.connected)
> +		goto cleanup;
> +
> +	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_DISABLED)
> +		goto err_out;
> +
> +	/* Some transfer events don't always point to a trb*/
> +	if (!ep_ring) {
> +		switch (trb_comp_code) {
> +		case COMP_INVALID_STREAM_TYPE_ERROR:
> +		case COMP_INVALID_STREAM_ID_ERROR:
> +		case COMP_RING_UNDERRUN:
> +		case COMP_RING_OVERRUN:
> +			goto cleanup;
> +		default:
> +			dev_err(pdev->dev, "ERROR: %s event for unknown ring\n",
> +				pep->name);
> +			goto err_out;
> +		}
> +	}
> +
> +	/* Look for some error cases that need special treatment. */
> +	switch (trb_comp_code) {
> +	case COMP_BABBLE_DETECTED_ERROR:
> +		status = -EOVERFLOW;
> +		break;
> +	case COMP_RING_UNDERRUN:
> +	case COMP_RING_OVERRUN:
> +		/*
> +		 * When the Isoch ring is empty, the controller will generate
> +		 * a Ring Overrun Event for IN Isoch endpoint or Ring
> +		 * Underrun Event for OUT Isoch endpoint.
> +		 */
> +		goto cleanup;
> +	case COMP_MISSED_SERVICE_ERROR:
> +		/*
> +		 * When encounter missed service error, one or more isoc tds
> +		 * may be missed by controller.
> +		 * Set skip flag of the ep_ring; Complete the missed tds as
> +		 * short transfer when process the ep_ring next time.
> +		 */
> +		pep->skip = true;
> +		break;
> +	}
> +
> +	do {
> +		/*
> +		 * This TRB should be in the TD at the head of this ring's TD
> +		 * list.
> +		 */
> +		if (list_empty(&ep_ring->td_list)) {
> +			if (pep->skip)
> +				pep->skip = false;
> +
> +			goto cleanup;
> +		}
> +
> +		td = list_entry(ep_ring->td_list.next, struct cdnsp_td,
> +				td_list);
> +
> +		/* Is this a TRB in the currently executing TD? */
> +		ep_seg = cdnsp_trb_in_td(pdev, ep_ring->deq_seg,
> +					 ep_ring->dequeue, td->last_trb,
> +					 ep_trb_dma);
> +
> +		/*
> +		 * Skip the Force Stopped Event. The event_trb(ep_trb_dma)
> +		 * of FSE is not in the current TD pointed by ep_ring->dequeue
> +		 * because that the hardware dequeue pointer still at the
> +		 * previous TRB of the current TD. The previous TRB maybe a
> +		 * Link TD or the last TRB of the previous TD. The command
> +		 * completion handle will take care the rest.
> +		 */
> +		if (!ep_seg && (trb_comp_code == COMP_STOPPED ||
> +				trb_comp_code == COMP_STOPPED_LENGTH_INVALID)) {
> +			pep->skip = false;
> +			goto cleanup;
> +		}
> +
> +		desc = td->preq->pep->endpoint.desc;
> +		if (!ep_seg) {
> +			if (!pep->skip || !usb_endpoint_xfer_isoc(desc)) {
> +				/* Something is busted, give up! */
> +				dev_err(pdev->dev,
> +					"ERROR Transfer event TRB DMA ptr not "
> +					"part of current TD ep_index %d "
> +					"comp_code %u\n", ep_index,
> +					trb_comp_code);
> +				return -EINVAL;
> +			}
> +
> +			cdnsp_skip_isoc_td(pdev, td, event, pep, status);
> +			goto cleanup;
> +		}
> +
> +		if (trb_comp_code == COMP_SHORT_PACKET)
> +			ep_ring->last_td_was_short = true;
> +		else
> +			ep_ring->last_td_was_short = false;
> +
> +		if (pep->skip) {
> +			pep->skip = false;
> +			cdnsp_skip_isoc_td(pdev, td, event, pep, status);
> +			goto cleanup;
> +		}
> +
> +		ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma)
> +				       / sizeof(*ep_trb)];
> +
> +		if (cdnsp_trb_is_noop(ep_trb))
> +			goto cleanup;
> +
> +		if (usb_endpoint_xfer_control(desc))
> +			cdnsp_process_ctrl_td(pdev, td, ep_trb, event, pep,
> +					      &status);
> +		else if (usb_endpoint_xfer_isoc(desc))
> +			cdnsp_process_isoc_td(pdev, td, ep_trb, event, pep,
> +					      status);
> +		else
> +			cdnsp_process_bulk_intr_td(pdev, td, ep_trb, event, pep,
> +						   &status);
> +cleanup:
> +		handling_skipped_tds = pep->skip;
> +
> +		/*
> +		 * Do not update event ring dequeue pointer if we're in a loop
> +		 * processing missed tds.
> +		 */
> +		if (!handling_skipped_tds)
> +			cdnsp_inc_deq(pdev, pdev->event_ring);
> +
> +	/*
> +	 * If ep->skip is set, it means there are missed tds on the
> +	 * endpoint ring need to take care of.
> +	 * Process them as short transfer until reach the td pointed by
> +	 * the event.
> +	 */
> +	} while (handling_skipped_tds);
> +	return 0;
> +
> +err_out:
> +	dev_err(pdev->dev, "@%016llx %08x %08x %08x %08x\n",
> +		(unsigned long long)
> +		cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +				      pdev->event_ring->dequeue),
> +		 lower_32_bits(le64_to_cpu(event->buffer)),
> +		 upper_32_bits(le64_to_cpu(event->buffer)),
> +		 le32_to_cpu(event->transfer_len),
> +		 le32_to_cpu(event->flags));
> +	return -EINVAL;
> +}
> +
> +/*
> + * This function handles all events on the event ring.
> + * Returns >0 for "possibly more events to process" (caller should call again),
> + * otherwise 0 if done.
> + */
> +int cdnsp_handle_event(struct cdnsp_device *pdev)

Just return bool.

> +{
> +	unsigned int comp_code;
> +	union cdnsp_trb *event;
> +	int update_ptrs = 1;

bool

> +	__le32 cycle_bit;
> +	int ret = 0;
> +	u32 flags;
> +
> +	event = pdev->event_ring->dequeue;
> +	flags = le32_to_cpu(event->event_cmd.flags);
> +	cycle_bit = (flags & TRB_CYCLE);
> +
> +	/* Does the controller or driver own the TRB? */
> +	if (cycle_bit != pdev->event_ring->cycle_state)
> +		return 0;
> +
> +	/*
> +	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
> +	 * reads of the event's flags/data below.
> +	 */
> +	rmb();
> +
> +	switch (flags & TRB_TYPE_BITMASK) {
> +	case TRB_TYPE(TRB_COMPLETION):
> +		/*
> +		 * Command can't be handled in interrupt context so just
> +		 * increment command ring dequeue pointer.
> +		 */
> +		cdnsp_inc_deq(pdev, pdev->cmd_ring);
> +		break;
> +	case TRB_TYPE(TRB_PORT_STATUS):
> +		cdnsp_handle_port_status(pdev, event);
> +		update_ptrs = 0;
> +		break;
> +	case TRB_TYPE(TRB_TRANSFER):
> +		ret = cdnsp_handle_tx_event(pdev, &event->trans_event);
> +
> +		if (ret >= 0)

	if (ret)
		break;

	update_ptrs = false;

> +			update_ptrs = 0;
> +		break;
> +	case TRB_TYPE(TRB_SETUP):
> +		pdev->ep0_stage = CDNSP_SETUP_STAGE;
> +		pdev->setup_id = TRB_SETUPID_TO_TYPE(flags);
> +		pdev->setup_speed = TRB_SETUP_SPEEDID(flags);
> +		pdev->setup = *((struct usb_ctrlrequest *)
> +				&event->trans_event.buffer);
> +
> +		cdnsp_setup_analyze(pdev);
> +		break;
> +	case TRB_TYPE(TRB_ENDPOINT_NRDY):
> +		cdnsp_handle_tx_nrdy(pdev, &event->trans_event);
> +		break;
> +	case TRB_TYPE(TRB_HC_EVENT): {
> +		comp_code = GET_COMP_CODE(le32_to_cpu(event->generic.field[2]));
> +
> +		switch (comp_code) {
> +		case COMP_EVENT_RING_FULL_ERROR:
> +			dev_err(pdev->dev, "Event Ring Full\n");
> +			break;
> +		default:
> +			dev_err(pdev->dev, "Controller error code 0x%02x\n",
> +				comp_code);
> +		}
> +
> +		break;
> +	}
> +	case TRB_TYPE(TRB_MFINDEX_WRAP):
> +	case TRB_TYPE(TRB_DRB_OVERFLOW):
> +		break;
> +	default:
> +		dev_warn(pdev->dev, "ERROR unknown event type %ld\n",
> +			 TRB_FIELD_TO_TYPE(flags));
> +	}
> +
> +	if (update_ptrs)
> +		/* Update SW event ring dequeue pointer. */
> +		cdnsp_inc_deq(pdev, pdev->event_ring);
> +
> +	/*
> +	 * Caller will call us again to check if there are more items
> +	 * on the event ring.
> +	 */
> +	return 1;
> +}
> +
> +irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
> +{
> +	struct cdnsp_device *pdev = (struct cdnsp_device *)data;
> +	union cdnsp_trb *event_ring_deq;
> +	irqreturn_t ret = IRQ_NONE;
> +	u8 counter = 0;

Just make counter an int.

> +
> +	spin_lock(&pdev->lock);
> +
> +	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED | CDNSP_STATE_DYING)) {
> +		cdnsp_died(pdev);
> +		spin_unlock(&pdev->lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	event_ring_deq = pdev->event_ring->dequeue;
> +
> +	while ((ret = cdnsp_handle_event(pdev)) == 1) {

	while (cdnsp_handle_event(pdev)) {


> +		if (++counter >= TRBS_PER_EV_DEQ_UPDATE) {
> +			cdnsp_update_erst_dequeue(pdev, event_ring_deq, 0);
> +			event_ring_deq = pdev->event_ring->dequeue;
> +			counter = 0;
> +		}
> +	}
> +
> +	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
> +
> +	spin_unlock(&pdev->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t cdnsp_irq_handler(int irq, void *priv)
> +{
> +	struct cdnsp_device *pdev = (struct cdnsp_device *)priv;
> +	irqreturn_t ret = IRQ_WAKE_THREAD;
> +	u32 irq_pending;
> +	u32 status;
> +
> +	status = readl(&pdev->op_regs->status);
> +
> +	if (status == ~(u32)0) {
> +		cdnsp_died(pdev);
> +		ret = IRQ_HANDLED;
> +		goto out;

	return IRQ_HANDLED;

> +	}
> +
> +	if (!(status & STS_EINT)) {
> +		ret = IRQ_NONE;
> +		goto out;
> +	}
> +
> +	writel(status | STS_EINT, &pdev->op_regs->status);
> +	irq_pending = readl(&pdev->ir_set->irq_pending);
> +	irq_pending |= IMAN_IP;
> +	writel(irq_pending, &pdev->ir_set->irq_pending);
> +
> +	if (status & STS_FATAL) {
> +		cdnsp_died(pdev);
> +		ret = IRQ_HANDLED;
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/*
> + * Generic function for queuing a TRB on a ring.
> + * The caller must have checked to make sure there's room on the ring.
> + *
> + * @more_trbs_coming:	Will you enqueue more TRBs before setting doorbell?
> + */
> +static void cdnsp_queue_trb(struct cdnsp_device *pdev, struct cdnsp_ring *ring,
> +			    bool more_trbs_coming, u32 field1, u32 field2,
> +			    u32 field3, u32 field4)
> +{
> +	struct cdnsp_generic_trb *trb;
> +
> +	trb = &ring->enqueue->generic;
> +
> +	trb->field[0] = cpu_to_le32(field1);
> +	trb->field[1] = cpu_to_le32(field2);
> +	trb->field[2] = cpu_to_le32(field3);
> +	trb->field[3] = cpu_to_le32(field4);
> +
> +	cdnsp_inc_enq(pdev, ring, more_trbs_coming);
> +}
> +
> +/*
> + * Does various checks on the endpoint ring, and makes it ready to
> + * queue num_trbs.
> + */
> +static int cdnsp_prepare_ring(struct cdnsp_device *pdev,
> +			      struct cdnsp_ring *ep_ring,
> +			      u32 ep_state, unsigned
> +			      int num_trbs,
> +			      gfp_t mem_flags)
> +{
> +	unsigned int num_trbs_needed;
> +
> +	/* Make sure the endpoint has been added to controller schedule. */
> +	switch (ep_state) {
> +	case EP_STATE_STOPPED:
> +	case EP_STATE_RUNNING:
> +	case EP_STATE_HALTED:
> +		break;
> +	default:
> +		dev_err(pdev->dev, "ERROR: incorrect endpoint state\n");
> +		return -EINVAL;
> +	}
> +
> +	while (1) {
> +		if (cdnsp_room_on_ring(pdev, ep_ring, num_trbs))
> +			break;
> +
> +		num_trbs_needed = num_trbs - ep_ring->num_trbs_free;
> +		if (cdnsp_ring_expansion(pdev, ep_ring, num_trbs_needed,
> +					 mem_flags)) {
> +			dev_err(pdev->dev, "Ring expansion failed\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	while (cdnsp_trb_is_link(ep_ring->enqueue)) {
> +		ep_ring->enqueue->link.control |= cpu_to_le32(TRB_CHAIN);
> +		/* The cycle bit must be set as the last operation. */
> +		wmb();
> +		ep_ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
> +
> +		/* Toggle the cycle bit after the last ring segment. */
> +		if (cdnsp_link_trb_toggles_cycle(ep_ring->enqueue))
> +			ep_ring->cycle_state ^= 1;
> +		ep_ring->enq_seg = ep_ring->enq_seg->next;
> +		ep_ring->enqueue = ep_ring->enq_seg->trbs;
> +	}
> +	return 0;
> +}
> +
> +static int cdnsp_prepare_transfer(struct cdnsp_device *pdev,
> +				  struct cdnsp_request *preq,
> +				  unsigned int num_trbs)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	int ret;
> +
> +	ep_ring = cdnsp_get_transfer_ring(pdev, preq->pep,
> +					  preq->request.stream_id);
> +	if (!ep_ring)
> +		return -EINVAL;
> +
> +	ret = cdnsp_prepare_ring(pdev, ep_ring,
> +				 GET_EP_CTX_STATE(preq->pep->out_ctx),
> +				 num_trbs, GFP_ATOMIC);
> +	if (ret)
> +		return ret;
> +
> +	INIT_LIST_HEAD(&preq->td.td_list);
> +	preq->td.preq = preq;
> +
> +	/* Add this TD to the tail of the endpoint ring's TD list. */
> +	list_add_tail(&preq->td.td_list, &ep_ring->td_list);
> +	ep_ring->num_tds++;
> +	preq->pep->stream_info.td_count++;
> +
> +	preq->td.start_seg = ep_ring->enq_seg;
> +	preq->td.first_trb = ep_ring->enqueue;
> +
> +	return 0;
> +}
> +
> +static unsigned int cdnsp_count_trbs(u64 addr, u64 len)
> +{
> +	unsigned int num_trbs;
> +
> +	num_trbs = DIV_ROUND_UP(len + (addr & (TRB_MAX_BUFF_SIZE - 1)),
> +				TRB_MAX_BUFF_SIZE);
> +	if (num_trbs == 0)
> +		num_trbs++;
> +
> +	return num_trbs;
> +}
> +
> +static inline unsigned int count_trbs_needed(struct cdnsp_request *preq)
> +{
> +	return cdnsp_count_trbs(preq->request.dma, preq->request.length);
> +}
> +
> +static unsigned int count_sg_trbs_needed(struct cdnsp_request *preq)
> +{
> +	unsigned int i, len, full_len, num_trbs = 0;
> +	struct scatterlist *sg;
> +
> +	full_len = preq->request.length;
> +
> +	for_each_sg(preq->request.sg, sg, preq->request.num_sgs, i) {
> +		len = sg_dma_len(sg);
> +		num_trbs += cdnsp_count_trbs(sg_dma_address(sg), len);
> +		len = min_t(unsigned int, len, full_len);

Just use min().  All the types are unsigned int.

> +		full_len -= len;
> +		if (full_len == 0)
> +			break;
> +	}
> +
> +	return num_trbs;
> +}
> +
> +static unsigned int count_isoc_trbs_needed(struct cdnsp_request *preq)
> +{
> +	return cdnsp_count_trbs(preq->request.dma, preq->request.length);
> +}
> +
> +static void cdnsp_check_trb_math(struct cdnsp_request *preq, int running_total)
> +{
> +	if (running_total != preq->request.length)
> +		dev_err(preq->pep->pdev->dev,
> +			"%s - Miscalculated tx length, "
> +			"queued %#x, asked for %#x (%d)\n",
> +			preq->pep->name, running_total,
> +			preq->request.length, preq->request.actual);
> +}
> +
> +/*
> + * TD size is the number of max packet sized packets remaining in the TD
> + * (*not* including this TRB).
> + *
> + * Total TD packet count = total_packet_count =
> + *     DIV_ROUND_UP(TD size in bytes / wMaxPacketSize)
> + *
> + * Packets transferred up to and including this TRB = packets_transferred =
> + *     rounddown(total bytes transferred including this TRB / wMaxPacketSize)
> + *
> + * TD size = total_packet_count - packets_transferred
> + *
> + * It must fit in bits 21:17, so it can't be bigger than 31.
> + * This is taken care of in the TRB_TD_SIZE() macro
> + *
> + * The last TRB in a TD must have the TD size set to zero.
> + */
> +static u32 cdnsp_td_remainder(struct cdnsp_device *pdev,
> +			      int transferred,
> +			      int trb_buff_len,
> +			      unsigned int td_total_len,
> +			      struct cdnsp_request *preq,
> +			      bool more_trbs_coming)
> +{
> +	u32 maxp, total_packet_count;
> +
> +	/* One TRB with a zero-length data packet. */
> +	if (!more_trbs_coming || (transferred == 0 && trb_buff_len == 0) ||
> +	    trb_buff_len == td_total_len)
> +		return 0;
> +
> +	maxp = usb_endpoint_maxp(preq->pep->endpoint.desc);
> +	total_packet_count = DIV_ROUND_UP(td_total_len, maxp);
> +
> +	/* Queuing functions don't count the current TRB into transferred. */
> +	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
> +}
> +
> +static int cdnsp_align_td(struct cdnsp_device *pdev,
> +			  struct cdnsp_request *preq, u32 enqd_len,
> +			  u32 *trb_buff_len, struct cdnsp_segment *seg)
> +{
> +	struct device *dev = pdev->dev;
> +	unsigned int unalign;
> +	unsigned int max_pkt;
> +	u32 new_buff_len;
> +
> +	max_pkt = usb_endpoint_maxp(preq->pep->endpoint.desc);
> +	unalign = (enqd_len + *trb_buff_len) % max_pkt;
> +
> +	/* We got lucky, last normal TRB data on segment is packet aligned. */
> +	if (unalign == 0)
> +		return 0;
> +
> +	/* Is the last nornal TRB alignable by splitting it. */
> +	if (*trb_buff_len > unalign) {
> +		*trb_buff_len -= unalign;
> +		return 0;
> +	}
> +
> +	/*
> +	 * We want enqd_len + trb_buff_len to sum up to a number aligned to
> +	 * number which is divisible by the endpoint's wMaxPacketSize. IOW:
> +	 * (size of currently enqueued TRBs + remainder) % wMaxPacketSize == 0.
> +	 */
> +	new_buff_len = max_pkt - (enqd_len % max_pkt);
> +
> +	if (new_buff_len > (preq->request.length - enqd_len))
> +		new_buff_len = (preq->request.length - enqd_len);
> +
> +	/* Create a max max_pkt sized bounce buffer pointed to by last trb. */
> +	if (preq->direction) {
> +		sg_pcopy_to_buffer(preq->request.sg,
> +				   preq->request.num_mapped_sgs,
> +				   seg->bounce_buf, new_buff_len, enqd_len);
> +		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
> +						 max_pkt, DMA_TO_DEVICE);
> +	} else {
> +		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
> +						 max_pkt, DMA_FROM_DEVICE);
> +	}
> +
> +	if (dma_mapping_error(dev, seg->bounce_dma)) {
> +		/* Try without aligning.*/
> +		dev_warn(pdev->dev,
> +			 "Failed mapping bounce buffer, not aligning\n");
> +		return 0;
> +	}
> +
> +	*trb_buff_len = new_buff_len;
> +	seg->bounce_len = new_buff_len;
> +	seg->bounce_offs = enqd_len;
> +
> +	return 1;

Please document the error codes.

> +}
> +
> +int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
> +{
> +	unsigned int enqd_len, block_len, trb_buff_len, full_len;
> +	unsigned int start_cycle, num_sgs = 0;
> +	struct cdnsp_generic_trb *start_trb;
> +	u32 field, length_field, remainder;
> +	struct scatterlist *sg = NULL;
> +	bool more_trbs_coming = true;
> +	bool need_zero_pkt = false;
> +	bool zero_len_trb = false;
> +	struct cdnsp_ring *ring;
> +	bool first_trb = true;
> +	unsigned int num_trbs;
> +	struct cdnsp_ep *pep;
> +	u64 addr, send_addr;
> +	int sent_len, ret;
> +
> +	ring = cdnsp_request_to_transfer_ring(pdev, preq);
> +	if (!ring)
> +		return -EINVAL;
> +
> +	full_len = preq->request.length;
> +
> +	if (preq->request.num_sgs) {
> +		num_sgs = preq->request.num_sgs;
> +		sg = preq->request.sg;
> +		addr = (u64)sg_dma_address(sg);
> +		block_len = sg_dma_len(sg);
> +		num_trbs = count_sg_trbs_needed(preq);
> +	} else {
> +		num_trbs = count_trbs_needed(preq);
> +		addr = (u64)preq->request.dma;
> +		block_len = full_len;
> +	}
> +
> +	pep = preq->pep;
> +
> +	/* Deal with request.zero - need one more td/trb. */
> +	if (preq->request.zero && preq->request.length &&
> +	    IS_ALIGNED(full_len, usb_endpoint_maxp(pep->endpoint.desc))) {
> +		need_zero_pkt = true;
> +		num_trbs++;
> +	}
> +
> +	ret = cdnsp_prepare_transfer(pdev, preq, num_trbs);
> +	if (ret < 0)

if (ret)

> +		return ret;
> +
> +	/*
> +	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
> +	 * until we've finished creating all the other TRBs. The ring's cycle
> +	 * state may change as we enqueue the other TRBs, so save it too.
> +	 */
> +	start_trb = &ring->enqueue->generic;
> +	start_cycle = ring->cycle_state;
> +	send_addr = addr;
> +
> +	/* Queue the TRBs, even if they are zero-length */
> +	for (enqd_len = 0; zero_len_trb || first_trb || enqd_len < full_len;
> +	     enqd_len += trb_buff_len) {
> +		field = TRB_TYPE(TRB_NORMAL);
> +
> +		/* TRB buffer should not cross 64KB boundaries */
> +		trb_buff_len = TRB_BUFF_LEN_UP_TO_BOUNDARY(addr);
> +		trb_buff_len = min_t(unsigned int, trb_buff_len, block_len);
> +		if (enqd_len + trb_buff_len > full_len)
> +			trb_buff_len = full_len - enqd_len;
> +
> +		/* Don't change the cycle bit of the first TRB until later */
> +		if (first_trb) {
> +			first_trb = false;
> +			if (start_cycle == 0)
> +				field |= TRB_CYCLE;
> +		} else {
> +			field |= ring->cycle_state;
> +		}
> +
> +		/*
> +		 * Chain all the TRBs together; clear the chain bit in the last
> +		 * TRB to indicate it's the last TRB in the chain.
> +		 */
> +		if (enqd_len + trb_buff_len < full_len || need_zero_pkt) {
> +			field |= TRB_CHAIN;
> +			if (cdnsp_trb_is_link(ring->enqueue + 1)) {
> +				if (cdnsp_align_td(pdev, preq, enqd_len,
> +						   &trb_buff_len,
> +						   ring->enq_seg)) {
> +					send_addr = ring->enq_seg->bounce_dma;
> +					/* Assuming TD won't span 2 segs */
> +					preq->td.bounce_seg = ring->enq_seg;
> +				}
> +			}
> +		}
> +
> +		if (enqd_len + trb_buff_len >= full_len) {
> +			if (need_zero_pkt && zero_len_trb) {
> +				zero_len_trb = true;
> +			} else {
> +				field &= ~TRB_CHAIN;
> +				field |= TRB_IOC;
> +				more_trbs_coming = false;
> +				need_zero_pkt = false;
> +				preq->td.last_trb = ring->enqueue;
> +			}
> +		}
> +
> +		/* Only set interrupt on short packet for OUT endpoints. */
> +		if (!preq->direction)
> +			field |= TRB_ISP;
> +
> +		/* Set the TRB length, TD size, and interrupter fields. */
> +		remainder = cdnsp_td_remainder(pdev, enqd_len, trb_buff_len,
> +					       full_len, preq,
> +					       more_trbs_coming);
> +
> +		length_field = TRB_LEN(trb_buff_len) | TRB_TD_SIZE(remainder) |
> +			TRB_INTR_TARGET(0);
> +
> +		cdnsp_queue_trb(pdev, ring, more_trbs_coming | need_zero_pkt,
> +				lower_32_bits(send_addr),
> +				upper_32_bits(send_addr),
> +				length_field,
> +				field);
> +
> +		addr += trb_buff_len;
> +		sent_len = trb_buff_len;
> +		while (sg && sent_len >= block_len) {
> +			/* New sg entry */
> +			--num_sgs;
> +			sent_len -= block_len;
> +			if (num_sgs != 0) {
> +				sg = sg_next(sg);
> +				block_len = sg_dma_len(sg);
> +				addr = (u64)sg_dma_address(sg);
> +				addr += sent_len;
> +			}
> +		}
> +		block_len -= sent_len;
> +		send_addr = addr;
> +	}
> +
> +	cdnsp_check_trb_math(preq, enqd_len);
> +	ret = cdnsp_giveback_first_trb(pdev, pep, preq->request.stream_id,
> +				       start_cycle, start_trb);
> +
> +	if (ret)
> +		preq->td.drbl = 1;
> +
> +	return 0;
> +}
> +
> +int cdnsp_queue_ctrl_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
> +{
> +	struct cdnsp_generic_trb *start_trb;
> +	u32 field, length_field, remainder;
> +	struct cdnsp_ep *pep = preq->pep;
> +	struct cdnsp_ring *ep_ring;
> +	int start_cycle;
> +	int num_trbs;
> +	int ret;
> +
> +	ep_ring = cdnsp_request_to_transfer_ring(pdev, preq);
> +	if (!ep_ring)
> +		return -EINVAL;
> +
> +	/* 1 TRB for data, 1 for status */
> +	num_trbs = (pdev->three_stage_setup) ? 2 : 1;
> +
> +	ret = cdnsp_prepare_transfer(pdev, preq, num_trbs);
> +	if (ret < 0)

if (ret)

> +		return ret;
> +
> +	/*
> +	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
> +	 * until we've finished creating all the other TRBs. The ring's cycle
> +	 * state may change as we enqueue the other TRBs, so save it too.
> +	 */
> +	start_trb = &ep_ring->enqueue->generic;
> +	start_cycle = ep_ring->cycle_state;
> +
> +	/* If there's data, queue data TRBs */
> +	if (pdev->ep0_expect_in)
> +		field = TRB_TYPE(TRB_DATA) | TRB_IOC;
> +	else
> +		field = TRB_ISP | TRB_TYPE(TRB_DATA) | TRB_IOC;
> +
> +	if (preq->request.length > 0) {
> +		remainder = cdnsp_td_remainder(pdev, 0, preq->request.length,
> +					       preq->request.length, preq, 1);
> +
> +		length_field = TRB_LEN(preq->request.length) |
> +				TRB_TD_SIZE(remainder) | TRB_INTR_TARGET(0);
> +
> +		if (pdev->ep0_expect_in)
> +			field |= TRB_DIR_IN;
> +
> +		cdnsp_queue_trb(pdev, ep_ring, true,
> +				lower_32_bits(preq->request.dma),
> +				upper_32_bits(preq->request.dma), length_field,
> +				field | ep_ring->cycle_state |
> +				TRB_SETUPID(pdev->setup_id) |
> +				pdev->setup_speed);
> +
> +		pdev->ep0_stage = CDNSP_DATA_STAGE;
> +	}
> +
> +	/* Save the DMA address of the last TRB in the TD. */
> +	preq->td.last_trb = ep_ring->enqueue;
> +
> +	/* Queue status TRB. */
> +	if (preq->request.length == 0)
> +		field = ep_ring->cycle_state;
> +	else
> +		field = (ep_ring->cycle_state ^ 1);
> +
> +	if (preq->request.length > 0 && pdev->ep0_expect_in)
> +		field |= TRB_DIR_IN;
> +
> +	if (pep->ep_state & EP0_HALTED_STATUS) {
> +		pep->ep_state &= ~EP0_HALTED_STATUS;
> +		field |= TRB_SETUPSTAT(TRB_SETUPSTAT_STALL);
> +	} else {
> +		field |= TRB_SETUPSTAT(TRB_SETUPSTAT_ACK);
> +	}
> +
> +	cdnsp_queue_trb(pdev, ep_ring, false, 0, 0, TRB_INTR_TARGET(0),
> +			field | TRB_IOC | TRB_SETUPID(pdev->setup_id) |
> +			TRB_TYPE(TRB_STATUS) | pdev->setup_speed);
> +
> +	cdnsp_ring_ep_doorbell(pdev, pep, preq->request.stream_id);
> +
> +	return 0;
> +}
> +
> +int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	u32 ep_state = GET_EP_CTX_STATE(pep->out_ctx);
> +	int ret = 0;
> +
> +	if (ep_state == EP_STATE_STOPPED || ep_state == EP_STATE_DISABLED)
> +		goto ep_stopped;
> +
> +	cdnsp_queue_stop_endpoint(pdev, pep->idx);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +
> +ep_stopped:
> +	pep->ep_state |= EP_STOPPED;
> +	return ret;
> +}
> +
> +int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	int ret;
> +
> +	cdnsp_queue_flush_endpoint(pdev, pep->idx);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret = cdnsp_wait_for_cmd_compl(pdev);
> +
> +	return ret;
> +}
> +
> +/**
> + * The transfer burst count field of the isochronous TRB defines the number of
> + * bursts that are required to move all packets in this TD. Only SuperSpeed
> + * devices can burst up to bMaxBurst number of packets per service interval.
> + * This field is zero based, meaning a value of zero in the field means one
> + * burst. Basically, for everything but SuperSpeed devices, this field will be
> + * zero.
> + */
> +static unsigned int cdnsp_get_burst_count(struct cdnsp_device *pdev,
> +					  struct cdnsp_request *preq,
> +					  unsigned int total_packet_count)
> +{
> +	unsigned int max_burst;
> +
> +	if (pdev->gadget.speed < USB_SPEED_SUPER)
> +		return 0;
> +
> +	max_burst = preq->pep->endpoint.comp_desc->bMaxBurst;
> +	return DIV_ROUND_UP(total_packet_count, max_burst + 1) - 1;
> +}
> +
> +/**
> + * Returns the number of packets in the last "burst" of packets. This field is
> + * valid for all speeds of devices. USB 2.0 devices can only do one "burst", so
> + * the last burst packet count is equal to the total number of packets in the
> + * TD. SuperSpeed endpoints can have up to 3 bursts. All but the last burst
> + * must contain (bMaxBurst + 1) number of packets, but the last burst can
> + * contain 1 to (bMaxBurst + 1) packets.
> + */
> +static unsigned int
> +	cdnsp_get_last_burst_packet_count(struct cdnsp_device *pdev,
> +					  struct cdnsp_request *preq,
> +					  unsigned int total_packet_count)
> +{
> +	unsigned int max_burst;
> +	unsigned int residue;
> +
> +	if (pdev->gadget.speed >= USB_SPEED_SUPER) {
> +		/* bMaxBurst is zero based: 0 means 1 packet per burst. */
> +		max_burst = preq->pep->endpoint.comp_desc->bMaxBurst;
> +		residue = total_packet_count % (max_burst + 1);
> +
> +		/*
> +		 * If residue is zero, the last burst contains (max_burst + 1)
> +		 * number of packets, but the TLBPC field is zero-based.
> +		 */
> +		if (residue == 0)
> +			return max_burst;
> +
> +		return residue - 1;
> +	}
> +	if (total_packet_count == 0)
> +		return 0;
> +
> +	return total_packet_count - 1;
> +}
> +
> +/* Queue function isoc transfer */
> +static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
> +			       struct cdnsp_request *preq)
> +{
> +	int trb_buff_len, td_len, td_remain_len, ret;
> +	unsigned int burst_count, last_burst_pkt;
> +	unsigned int total_pkt_count, max_pkt;
> +	struct cdnsp_generic_trb *start_trb;
> +	bool more_trbs_coming = true;
> +	struct cdnsp_ring *ep_ring;
> +	int running_total = 0;
> +	u32 field, length_field;
> +	int start_cycle;
> +	int trbs_per_td;
> +	u64 addr;
> +	int i;
> +
> +	ep_ring = preq->pep->ring;
> +	start_trb = &ep_ring->enqueue->generic;
> +	start_cycle = ep_ring->cycle_state;
> +	td_len = preq->request.length;
> +	addr = (u64)preq->request.dma;
> +	td_remain_len = td_len;
> +
> +	max_pkt = usb_endpoint_maxp(preq->pep->endpoint.desc);
> +	total_pkt_count = DIV_ROUND_UP(td_len, max_pkt);
> +
> +	/* A zero-length transfer still involves at least one packet. */
> +	if (total_pkt_count == 0)
> +		total_pkt_count++;
> +
> +	burst_count = cdnsp_get_burst_count(pdev, preq, total_pkt_count);
> +	last_burst_pkt = cdnsp_get_last_burst_packet_count(pdev, preq,
> +							   total_pkt_count);
> +	trbs_per_td = count_isoc_trbs_needed(preq);
> +
> +	ret = cdnsp_prepare_transfer(pdev, preq, trbs_per_td);
> +	if (ret < 0)

if (ret)

> +		goto cleanup;
> +
> +	/*
> +	 * Set isoc specific data for the first TRB in a TD.
> +	 * Prevent HW from getting the TRBs by keeping the cycle state
> +	 * inverted in the first TDs isoc TRB.
> +	 */
> +	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
> +		!start_cycle | TRB_SIA | TRB_TBC(burst_count);
> +
> +	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
> +	for (i = 0; i < trbs_per_td; i++) {
> +		u32 remainder = 0;

don't initialize

> +
> +		/* Calculate TRB length. */
> +		trb_buff_len = TRB_BUFF_LEN_UP_TO_BOUNDARY(addr);
> +		if (trb_buff_len > td_remain_len)
> +			trb_buff_len = td_remain_len;
> +
> +		/* Set the TRB length, TD size, & interrupter fields. */
> +		remainder = cdnsp_td_remainder(pdev, running_total,
> +					       trb_buff_len, td_len, preq,
> +					       more_trbs_coming);
> +

regards,
dan carpenter


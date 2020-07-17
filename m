Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90821C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5252070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DSiRgRWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGQGEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:04:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:49538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgGQGEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:04:00 -0400
IronPort-SDR: UIxo6veOXBJDx7peBn1RYqrY79jD3kohqVwk43w/8ozJgwMvk3OEslldRQADzk/PLnW7f3Wa2O
 XyVSvYBiB1IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="149529223"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="149529223"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:03:58 -0700
IronPort-SDR: XixfNXzTiS3icEMRsGV4fWNYxF7N9zSELLL41MC4ZqZ/ilMXSN71i4Wi22qAuYFJQDw64je/iW
 OcNpgXcDKdVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="486864607"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2020 23:03:57 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 23:03:57 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX153.amr.corp.intel.com (10.22.226.247) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 23:03:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Jul 2020 23:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiikWBZjLZ6yIep6HowQ0Q20i6u0RwjHCloUaC8HXl+iW+4HcsgWuiINQ76Y4au4aho4GYkmwU7pMg8UX48twJqUTNdMCI8ouC44LeQmeweMrdcH7px9FNi8vzd7E2+ASXxHRkAqGUycjTK+VqTiweBYSgpZU+qv6OEAaGIcDjG7A3YXTserPXVIsi7Lqf6XYtel33YVn9Ub+GdN0k7FeG99I0/MHYsgTo5qmefuzMIYwUi0Jjpt7qO+A3kGjjBo1lPmId3pVPV6p+Jq0NAvKZjPf8dAEfgp0+e+aDcFNL+GyqlMzXWVI2WOY+8nFd7tSFtxGZ5C5ANybbxbBKQ0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy2+q4hiyOtu/08LJLHe7yWO5PepEhAL7twCRxa5QqQ=;
 b=YbIhEaWkpco9fLHlFPCwCdwKELgALc/HW9GfossHtkt//hDljJg26KZvlSejzdFL/FAeXCUESNxW5P13xXKVZV+kziDahdG1zJQVo1OhxgBdw3WXzg1obFbPXo+QI1Zd9cNAuM2B2tMoKoAI2FZKSxGCRJUJUQJnGXnGaGmhdKSj3cteb99/XKH2szk+wlH19D+eI+aQD+YvlUyAIik1aHQkdyhxUmJ0y7W/cFT7v7d7XdYxaLE27MRdeBM3YdqEqOhNrZQIphYyl8NarnZ2to2kElYFgcK+mfu2bNh/elIeriq9zh2UTr3DghpyeUtoGdOmUiB1noFBECMZ5slOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy2+q4hiyOtu/08LJLHe7yWO5PepEhAL7twCRxa5QqQ=;
 b=DSiRgRWYdDj/3fckMM+lukykJeskHFtylrjCVUGAlOtl4f+lGCo8gGsbS4++XLwzg7BdIL8ImcXAa40+jLn4L/Vc7rctaCADvIUhfco9JF1x+kLPfdes4Rm4bHcFiLL+G0nz4izXQ4sXXEckoLmpzMA7FK+0wVeXZNLv+DHUpGY=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 06:03:56 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::714f:fa64:4fd8:c9df]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::714f:fa64:4fd8:c9df%6]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 06:03:56 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?iso-8859-2?Q?Bla=BE_Hrastnik?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Index: AQHWWwsaPBfYigwTQE+Q2/IuyVCXHakJyhoAgAFtwuA=
Date:   Fri, 17 Jul 2020 06:03:55 +0000
Message-ID: <DM6PR11MB39632BD9A5A0DF4A9EAB351CF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-2-rajmohan.mani@intel.com>
 <20200716070950.GC962748@kroah.com>
In-Reply-To: <20200716070950.GC962748@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9a28461-941f-4b77-ba10-08d82a173097
x-ms-traffictypediagnostic: DM6PR11MB3962:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB39623B510E598C28FDF07EAFF67C0@DM6PR11MB3962.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mvzXFr71DH5CRZt9kXwlawT8BdwOd0R3OvoEcvNnIvZ/MuUhCeWU5S+4GElSte95STgPcAKhYutvC51vZwVP4/AxZLQVZ++//Qx9+0Rajft4su97x3bWyp4sipr6BmWxi1Ayn2WUQGGgvD3L4oto3OSwAb/SqBrqO/JXErRHvnZFwHocgAZHIVNlR7AHdiN/xyaSmdPSPhWpxrHXfi/Fpk0cszYcRF4qZW3zOpd5SMWcydP9FMYgMYKscmDGxfDHB4jgjQNapBfwwyFIvW8ttosXEmngf41CmL+Sz6542BNW4L9tPZR46ODfDAuKdJ8Vg7cH/XrZIskNimwoBJQDcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(6916009)(316002)(86362001)(26005)(8936002)(4326008)(186003)(9686003)(7696005)(76116006)(5660300002)(52536014)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(71200400001)(8676002)(6506007)(53546011)(83380400001)(478600001)(7416002)(2906002)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pLJiItX4I5mHo+39gOhOxqaCH8ulVZIR5VcjjWLDqSqUNaeC7M0zQjiy5xqEIIKcQNNmCuYtKUIN6tP9fa8UxNqKG6LpKsW7RRjEPIfCQWqvwPZ8ec0TCpvDkZoRxb/zYjXtT90gY9d5WQ8UHTLDtNvaEj6Q4DRkWw959ylo+oUI5AilUCbU2YOQEggFb9WqvKpzizzTfaRXb6pJY0gQQ40TXnEcJkFkUWEx9Qs+fKJHTNWBwLL4HtxBLFIAqHeBvwvjIJNO53czrnr0rqkzzoC3Vjs+aVoclv+IVvMIJn+X1kfM9ZEjQvdfJIcZ8l3yfdvxjR0Gfa5e0KkL0Z1Smsr/NyzBdwbVVJquSMLzMmXG6Yd8oWsu3puTcL+5vKB6WP9XSSbSY0q1IqsgRIeiU1sdD0Ed1g+qXj997Oe22bVEkx3eYiVrwTSG4k35l5f/Vf1Pq7Svfd03hzlNnOfAjLCk3sC3PDpu7ybYcIycdPXw+dbTpWFTNAyLZGu5IQPf
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a28461-941f-4b77-ba10-08d82a173097
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 06:03:56.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y3FNLJOsch1OfxIpuAret+AGJ2m27HXzAAjWWRPbiJ+upbm6t3IHjqgVghO6YE1D7SsjgwoISPuFdfBct5F9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3962
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the reviews.

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, July 16, 2020 12:10 AM
> To: Mani, Rajmohan <rajmohan.mani@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>; Andy Shevchenko
> <andy@infradead.org>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Dmitry Torokhov
> <dmitry.torokhov@gmail.com>; Lee Jones <lee.jones@linaro.org>; Ayman
> Bagabas <ayman.bagabas@gmail.com>; Masahiro Yamada
> <masahiroy@kernel.org>; Joseph, Jithu <jithu.joseph@intel.com>; Bla=BE
> Hrastnik <blaz@mxxn.io>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org; Heikki Krogerus
> <heikki.krogerus@linux.intel.com>; linux-usb@vger.kernel.org;
> pmalani@chromium.org; bleung@chromium.org
> Subject: Re: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IO=
M)
> driver
>=20
> On Wed, Jul 15, 2020 at 05:33:09PM -0700, Rajmohan Mani wrote:
> > Input Output Manager (IOM) is part of the Tiger Lake SoC that
> > configures the Type-C Sub System (TCSS). IOM is a micro controller
> > that handles Type-C topology, configuration and PM functions of
> > various Type-C devices connected on the platform.
> >
> > This driver helps read relevant information such as Type-C port status
> > (whether a device is connected to a Type-C port or not) and the
> > activity type on the Type-C ports (such as USB, Display Port,
> > Thunderbolt), for consumption by other drivers.
> >
> > Currently intel_iom_port_status() API is exported by this driver, that
> > has information about the Type-C port status and port activity type.
> >
> > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > ---
> >  drivers/platform/x86/Kconfig                |  16 +++
> >  drivers/platform/x86/Makefile               |   1 +
> >  drivers/platform/x86/intel_iom.c            | 133 ++++++++++++++++++++
> >  include/linux/platform_data/x86/intel_iom.h |  62 +++++++++
>=20
> Why do you need a .h file for a single .c file that no one else shares th=
is data?
> Just put it all in the .c file please.
>=20

The APIs exported by this driver, are used by the caller (Intel PMC USB mux
control driver), hence the need for header file.

> >  4 files changed, 212 insertions(+)
> >  create mode 100644 drivers/platform/x86/intel_iom.c  create mode
> > 100644 include/linux/platform_data/x86/intel_iom.h
> >
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig index 0581a54cf562..271feddb20ef 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -816,6 +816,22 @@ config INTEL_INT0002_VGPIO
> >  	  To compile this driver as a module, choose M here: the module will
> >  	  be called intel_int0002_vgpio.
> >
> > +config INTEL_IOM
> > +	tristate "Intel Input Output Manager (IOM) driver"
> > +	depends on ACPI && PCI
> > +	help
> > +	  This driver helps read relevant information such as Type-C port
> > +	  status (whether a device is connected to a Type-C port or not)
> > +	  and the activity type on the Type-C ports (such as USB, Display
> > +	  Port, Thunderbolt), for consumption by other drivers.
> > +
> > +	  Currently intel_iom_port_status() API is exported by this driver,
> > +	  that has information about the Type-C port status and port activity
> > +	  type.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called intel_iom.
> > +
> >  config INTEL_MENLOW
> >  	tristate "Thermal Management driver for Intel menlow platform"
> >  	depends on ACPI_THERMAL
> > diff --git a/drivers/platform/x86/Makefile
> > b/drivers/platform/x86/Makefile index 2b85852a1a87..d71e4620a7c6
> > 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -76,6 +76,7 @@ intel_cht_int33fe-objs			:=3D
> intel_cht_int33fe_common.o \
> >  					   intel_cht_int33fe_microb.o
> >  obj-$(CONFIG_INTEL_HID_EVENT)		+=3D intel-hid.o
> >  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+=3D intel_int0002_vgpio.o
> > +obj-$(CONFIG_INTEL_IOM)			+=3D intel_iom.o
> >  obj-$(CONFIG_INTEL_MENLOW)		+=3D intel_menlow.o
> >  obj-$(CONFIG_INTEL_OAKTRAIL)		+=3D intel_oaktrail.o
> >  obj-$(CONFIG_INTEL_VBTN)		+=3D intel-vbtn.o
> > diff --git a/drivers/platform/x86/intel_iom.c
> > b/drivers/platform/x86/intel_iom.c
> > new file mode 100644
> > index 000000000000..ece0fe720b2d
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel_iom.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Core SoC Input Output Manager (IOM) driver.
> > + *
> > + * This driver provides access to the Input Output Manager (IOM)
> > +(that
> > + * is part of Tiger Lake SoC) registers that can be used to know
> > +about
> > + * Type-C Sub System related information (such as Type-C port status,
> > + * activity type on Type-C ports).
> > + *
> > + * Copyright (C) 2020, Intel Corporation
> > + * Author: Rajmohan Mani <rajmohan.mani@intel.com>  */
> > +
> > +#include <linux/io.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_data/x86/intel_iom.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define IOM_PORT_STATUS_OFFSET				0x560
> > +
> > +struct intel_iom {
> > +	struct device *dev;
> > +	void __iomem *regbar;
> > +};
> > +
> > +static struct intel_iom iom_dev;
>=20
> Why just one?  Why is this static?
>=20

There is just one IOM device in the system.

> > +
> > +/**
> > + * intel_iom_get() - Get IOM device instance
> > + *
> > + * This function returns the IOM device instance. This also ensures
> > +that
> > + * this driver cannot be unloaded while the caller has the instance.
> > + *
> > + * Call intel_iom_put() to release the instance.
> > + *
> > + * Returns IOM device instance on success or error pointer otherwise.
> > + */
> > +struct intel_iom *intel_iom_get(void) {
> > +	struct device *dev =3D get_device(iom_dev.dev);
>=20
> Wht if dev is NULL?
>=20

Ack. Will add a check for NULL.

> > +
> > +	/* Prevent this driver from being unloaded while in use */
> > +	if (!try_module_get(dev->driver->owner)) {
>=20
> Why are you poking around in a random device's driver's owner?
>=20
> That's not ok.  And probably totally racy.
>=20
> Handle module reference counts properly, not like this.
>=20

Ack. Will use THIS_MODULE here.

> And why does it even matter that you incremented the module reference
> count?  What is that "protecting" you from?
>=20
=20
To prevent this driver from being unloaded, while it is being used.

> > +		put_device(iom_dev.dev);
> > +		return ERR_PTR(-EBUSY);
> > +	}
> > +
> > +	return &iom_dev;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_iom_get);
>=20
> Who calls this function?
>=20

Intel PMC USB mux control driver, in this case.
The callers are expected to call intel_iom_get() before using the
intel_iom_port_status(), after which intel_iom_put() can be called
to release the IOM device instance.

> > +
> > +/**
> > + * intel_iom_put() - Put IOM device instance
> > + * @iom: IOM device instance
> > + *
> > + * This function releases the IOM device instance created using
> > + * intel_iom_get() and allows the driver to be unloaded.
> > + *
> > + * Call intel_iom_put() to release the instance.
> > + */
> > +void intel_iom_put(struct intel_iom *iom) {
> > +	if (!iom)
> > +		return;
> > +
> > +	module_put(iom->dev->driver->owner);
>=20
> And if the device doesn't have a driver?  boom :(
>=20
> Don't do this.
>=20

Ack. Will use THIS_MODULE here.

> > +	put_device(iom->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(intel_iom_put);
> > +
> > +/**
> > + * intel_iom_port_status() - Get status bits for the Type-C port
> > + * @iom: IOM device instance
> > + * @port: Type-C port number
> > + * @status: pointer to receive the status bits
> > + *
> > + * Returns 0 on success, error otherwise.
> > + */
> > +int intel_iom_port_status(struct intel_iom *iom, u8 port, u32
> > +*status) {
> > +	void __iomem *reg;
> > +
> > +	if (!iom)
> > +		return -ENODEV;
> > +
> > +	if (!status || (port > IOM_MAX_PORTS - 1))
> > +		return -EINVAL;
> > +
> > +	reg =3D iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN *
> port;
> > +
> > +	*status =3D ioread32(reg);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_iom_port_status);
>=20
> So the whole driver is here just to read, directly from memory, a single
> 32 bit value?

Yes.

> Doesn't that seem like a lot of overkill?  Why can't the caller just
> do this themselves?
>=20

Ack.
Intel PMC USB mux device is part of the PCH, while IOM is part of the SoC.
So I thought it made sense to keep these 2 devices / drivers apart, despite
the overkill. Heikki also agreed with this approach, given the above.

> greg k-h

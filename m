Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738B6C35243
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D792087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oob/6ZtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgAWXui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:50:38 -0500
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:22248
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728655AbgAWXuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:50:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMM2u/f+2YN6FzjUwq1qxVnDR64vD2FHkxl3MoBFetJ06DnPU5WWHr6NyAOX6QO1Strw6C0A4Am9G2OYN/jfcMjTjJCOvCzX5jK/rgwfsrSagdjaGtUEFT5lWzF2qZ0Gdo306uaA9iDggvN034W313kpt7HQ27Q5NkaFQU6z7qtir96SOJH0T6La+ra1EZZnM/TQC+jcmt8hqvR+Wt+/TVby0BLebi7s2Q/0yc6ebv+MqQrcmaw5Yo2CJ7uuDCF0E0luEAbO7uIyfSZUXUip8VGvaQ+8gu3aPbJkjcZ8qFU697/gBnvNLqh1mR9cMUZi5S8qD0JiMKyO6kVUkaOoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sSqz9KV7u3eGJiuYSgWLEUVop7mKkbFiAfUNH+nplM=;
 b=FNlkUp02CawMzW+mh0YSmbTBJ1B7U595NRwZk5WtpSdgu40JDS8ne0UVFMpktiPSAXN1NO2r0A1ggbDCNp4yS9xekxUU3iLbF2e8rFEtzjgBVnwNYBZeeS9UAzFRdeUMzCJLzYytyc3JBhahEQTcf/O6kyofy/klGlKDppeXezQb4DcbN2aO1iJxwjDs7JSLBaaw21EF9O51PR3Zz957zFkt12Pgj50GbxSYE+Qo6eWYY/bMPje9FTZNlZw7YimDTYbxf+iUGtzNFRiZ9eARUxALdwaC/Lu9BFruHLakOiS2o5jIj29652K1GvIpzBSjUDb0X5bAnGSI0+P5VSVECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sSqz9KV7u3eGJiuYSgWLEUVop7mKkbFiAfUNH+nplM=;
 b=oob/6ZtSTVVKOl+y1zlw5NTwmIWBkOFwBnpKVEfZ87YjJhcO3YuEtPLs3aMSHxksmNK4cqB767bKmkAT8STjbL/92dt0E5kik9uCZbVw8Mv0uGnnGP9EWoz/KvySSd2QiO5pTwdoWy84mCwgYxIKYkjYtHmRqZ974bRzNdzn5v8=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4582.namprd02.prod.outlook.com (52.135.237.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 23 Jan 2020 23:47:57 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::f5fd:4723:4a89:3ed9]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::f5fd:4723:4a89:3ed9%7]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 23:47:57 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Thread-Topic: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Thread-Index: AQHVxn8DFx2mcD2XT0SouhH9uTzcjqfqR5+AgA6zcwA=
Date:   Thu, 23 Jan 2020 23:47:57 +0000
Message-ID: <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
 <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
 <20200114145257.GA1910108@kroah.com>
In-Reply-To: <20200114145257.GA1910108@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9903c75f-42e9-41a4-1130-08d7a05eac29
x-ms-traffictypediagnostic: BYAPR02MB4582:|BYAPR02MB4582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB45820D3A4667AF301FC269BDB80F0@BYAPR02MB4582.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(107886003)(6916009)(186003)(26005)(33656002)(64756008)(66446008)(76116006)(5660300002)(52536014)(71200400001)(2906002)(66476007)(66946007)(55016002)(30864003)(478600001)(9686003)(66556008)(7696005)(53546011)(6506007)(316002)(54906003)(7416002)(86362001)(8936002)(8676002)(4326008)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4582;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxUFfJzhrMG66S+hHEZu88GuKfD3Qh/Gg4J8yxcm9tlPg3LJIgB6mXgHsIi90GENkzaulNKGT8M6oT4V1kpN5H1WVTSID3EbdlyojZLo7po6Kt8E5kt7fSdCBixd5NDy84YOaDaB9/HpPhk78kH8i880JFi1lngpd01RubyG/S2VlcY7yz52szRfrVtlqhA2ohXEVQzxr1BPUBSqe686ysIiP9kZqm92c0bKrAfW73CBYyAW0M3t1CsTdOoX8WPTdQdBJ65dKc0ytwT06ufa/RfGWdFL5sb9jumBm72HYZVhpV5DfnpQd099ucZac/QR8JPdgNZN1wgvsdp0heGRWo3g+AYI6EoBjqDWRgTEtuh0tJYQZLYE1z3HH6Odo87BuXazGShkfN5tELD07CgRNeXDemGHSsBW/rtKrUiPhVDzQMWS/WcJLVFx3jaG5RDZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9903c75f-42e9-41a4-1130-08d7a05eac29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 23:47:57.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/0JjJmEYCEnjiKofgeIjHJjAFsSMNRi8AI0bKPDpdq4SelcsSCSIhnUM1eRqfJWTh0hohVprXt3eqnvxbfnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the review.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 14, 2020 6:53 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk=
;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
>=20
> On Wed, Jan 08, 2020 at 03:54:20PM -0800, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add Firmware-ggs sysfs interface which provides read/write
> > interface to global storage registers.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> > Changes in v2:
> >  - Updated Linux kernel version in documentation.
> >  - Used DEVICE_ATTR_* and ATTRIBUTE_GROUPS macros.
> >  - Free Kobject structure in case of error.
> >  - Resolved smatch errors.
> >  - Updated Signed-off-by sequence.
> > ---
> >  Documentation/ABI/stable/sysfs-firmware-zynqmp |  50 +++++
> >  drivers/firmware/xilinx/Makefile               |   2 +-
> >  drivers/firmware/xilinx/zynqmp-ggs.c           | 284
> +++++++++++++++++++++++++
> >  drivers/firmware/xilinx/zynqmp.c               |  32 +++
> >  include/linux/firmware/xlnx-zynqmp.h           |  10 +
> >  5 files changed, 377 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/stable/sysfs-firmware-zynqmp
> >  create mode 100644 drivers/firmware/xilinx/zynqmp-ggs.c
> >
> > diff --git a/Documentation/ABI/stable/sysfs-firmware-zynqmp
> b/Documentation/ABI/stable/sysfs-firmware-zynqmp
> > new file mode 100644
> > index 0000000..cffa2fc
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-firmware-zynqmp
> > @@ -0,0 +1,50 @@
> > +What:		/sys/firmware/zynqmp/ggs*
>=20
> Why are these attributes just not hanging off of the platform device for
> the firmware controller?  Why do you need a new subdir under "firmware"?

Firmware driver was changed later to be platform driver but these interface=
s were defined=20
earlier and are in use.

>=20
> > +Date:		January 2018
> > +KernelVersion:	5.5
>=20
> 5.6?  :)

Yes. Will fix it in next version.

>=20
> > +Contact:	"Jolly Shah" <jollys@xilinx.com>
> > +Description:
> > +		Read/Write PMU global general storage register value,
> > +		GLOBAL_GEN_STORAGE{0:3}.
> > +		Global general storage register that can be used
> > +		by system to pass information between masters.
> > +
> > +		The register is reset during system or power-on
> > +		resets. Three registers are used by the FSBL and
> > +		other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
> > +
> > +		Usage:
> > +		# cat /sys/firmware/zynqmp/ggs0
> > +		# echo <mask> <value> > /sys/firmware/zynqmp/ggs0
> > +
> > +		Example:
> > +		# cat /sys/firmware/zynqmp/ggs0
> > +		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
> > +
> > +Users:		Xilinx
> > +
> > +What:		/sys/firmware/zynqmp/pggs*
> > +Date:		January 2018
> > +KernelVersion:	5.5
> > +Contact:	"Jolly Shah" <jollys@xilinx.com>
> > +Description:
> > +		Read/Write PMU persistent global general storage register
> > +		value, PERS_GLOB_GEN_STORAGE{0:3}.
> > +		Persistent global general storage register that
> > +		can be used by system to pass information between
> > +		masters.
> > +
> > +		This register is only reset by the power-on reset
> > +		and maintains its value through a system reset.
> > +		Four registers are used by the FSBL and other Xilinx
> > +		software products: PERS_GLOB_GEN_STORAGE{4:7}.
> > +		Register is reset only by a POR reset.
> > +
> > +		Usage:
> > +		# cat /sys/firmware/zynqmp/pggs0
> > +		# echo <mask> <value> > /sys/firmware/zynqmp/pggs0
> > +
> > +		Example:
> > +		# cat /sys/firmware/zynqmp/pggs0
> > +		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/pggs0
> > +
> > +Users:		Xilinx
> > diff --git a/drivers/firmware/xilinx/Makefile
> b/drivers/firmware/xilinx/Makefile
> > index 875a537..1e8643c 100644
> > --- a/drivers/firmware/xilinx/Makefile
> > +++ b/drivers/firmware/xilinx/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Makefile for Xilinx firmwares
> >
> > -obj-$(CONFIG_ZYNQMP_FIRMWARE) +=3D zynqmp.o
> > +obj-$(CONFIG_ZYNQMP_FIRMWARE) +=3D zynqmp.o zynqmp-ggs.o
> >  obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) +=3D zynqmp-debug.o
> > diff --git a/drivers/firmware/xilinx/zynqmp-ggs.c
> b/drivers/firmware/xilinx/zynqmp-ggs.c
> > new file mode 100644
> > index 0000000..e2a6700
> > --- /dev/null
> > +++ b/drivers/firmware/xilinx/zynqmp-ggs.c
> > @@ -0,0 +1,284 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Xilinx Zynq MPSoC Firmware layer
> > + *
> > + *  Copyright (C) 2014-2018 Xilinx, Inc.
> > + *
> > + *  Jolly Shah <jollys@xilinx.com>
> > + *  Rajan Vaja <rajanv@xilinx.com>
> > + */
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/of.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/slab.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +
> > +static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
> > +{
> > +	int ret;
> > +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (IS_ERR(eemi_ops) || !eemi_ops->ioctl)
> > +		return -EFAULT;
> > +
> > +	ret =3D eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sprintf(buf, "0x%x\n", ret_payload[1]);
> > +}
> > +
> > +static ssize_t write_register(const char *buf, size_t count, u32 read_=
ioctl,
> > +			      u32 write_ioctl, u32 reg)
> > +{
> > +	char *kern_buff, *inbuf, *tok;
> > +	long mask, value;
> > +	int ret;
> > +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (IS_ERR(eemi_ops) || !eemi_ops->ioctl)
> > +		return -EFAULT;
> > +
> > +	kern_buff =3D kzalloc(count, GFP_KERNEL);
> > +	if (!kern_buff)
> > +		return -ENOMEM;
> > +
> > +	ret =3D strlcpy(kern_buff, buf, count);
> > +	if (ret < 0) {
> > +		ret =3D -EFAULT;
> > +		goto err;
> > +	}
> > +
> > +	inbuf =3D kern_buff;
> > +
> > +	/* Read the write mask */
> > +	tok =3D strsep(&inbuf, " ");
> > +	if (!tok) {
> > +		ret =3D -EFAULT;
>=20
> If you just set count to the error value, no need to test the value of
> ret when you exit.  Not a big deal...

Ok. Will fix it in next version

>=20
> > +		goto err;
> > +	}
> > +
> > +	ret =3D kstrtol(tok, 16, &mask);
> > +	if (ret) {
> > +		ret =3D -EFAULT;
> > +		goto err;
> > +	}
> > +
> > +	/* Read the write value */
> > +	tok =3D strsep(&inbuf, " ");
> > +	if (!tok) {
> > +		ret =3D -EFAULT;
> > +		goto err;
> > +	}
> > +
> > +	ret =3D kstrtol(tok, 16, &value);
> > +	if (ret) {
> > +		ret =3D -EFAULT;
> > +		goto err;
> > +	}
> > +
> > +	ret =3D eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
>=20
> This feels "tricky", if you tie this to the device you have your driver
> bound to, will this make it easier instead of having to go through the
> ioctl callback?
>=20

GGS(general global storage) registers are in PMU space and linux doesn't ha=
ve access to it=20
Hence ioctl is used.

>=20
> > +	if (ret) {
> > +		ret =3D -EFAULT;
> > +		goto err;
> > +	}
> > +	ret_payload[1] &=3D ~mask;
> > +	value &=3D mask;
> > +	value |=3D ret_payload[1];
> > +
> > +	ret =3D eemi_ops->ioctl(0, write_ioctl, reg, value, NULL);
> > +	if (ret)
> > +		ret =3D -EFAULT;
> > +
> > +err:
> > +	kfree(kern_buff);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +
> > +/**
> > + * ggs_show - Show global general storage (ggs) sysfs attribute
> > + * @device: Device structure
> > + * @attr: Device attribute structure
> > + * @buf: Requested available shutdown_scope attributes string
> > + * @reg: Register number
> > + *
> > + * Return:Number of bytes printed into the buffer.
> > + *
> > + * Helper function for viewing a ggs register value.
> > + *
> > + * User-space interface for viewing the content of the ggs0 register.
> > + * cat /sys/firmware/zynqmp/ggs0
> > + */
> > +static ssize_t ggs_show(struct device *device,
> > +			struct device_attribute *attr,
> > +			char *buf,
> > +			u32 reg)
> > +{
> > +	return read_register(buf, IOCTL_READ_GGS, reg);
> > +}
> > +
> > +/**
> > + * ggs_store - Store global general storage (ggs) sysfs attribute
> > + * @device: Device structure
> > + * @attr: Device attribute structure
> > + * @buf: User entered shutdown_scope attribute string
> > + * @count: Size of buf
> > + * @reg: Register number
> > + *
> > + * Return: count argument if request succeeds, the corresponding
> > + * error code otherwise
> > + *
> > + * Helper function for storing a ggs register value.
> > + *
> > + * For example, the user-space interface for storing a value to the
> > + * ggs0 register:
> > + * echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
> > + */
> > +static ssize_t ggs_store(struct device *device,
> > +			 struct device_attribute *attr,
> > +			 const char *buf, size_t count,
> > +			 u32 reg)
> > +{
> > +	if (!device || !attr || !buf || !count || reg >=3D GSS_NUM_REGS)
> > +		return -EINVAL;
> > +
> > +	return write_register(buf, count, IOCTL_READ_GGS, IOCTL_WRITE_GGS,
> reg);
> > +}
> > +
> > +/* GGS register show functions */
> > +#define GGS0_SHOW(N)						\
> > +	ssize_t ggs##N##_show(struct device *device,		\
> > +			      struct device_attribute *attr,	\
> > +			      char *buf)			\
> > +	{							\
> > +		return ggs_show(device, attr, buf, N);		\
> > +	}
> > +
> > +static GGS0_SHOW(0);
> > +static GGS0_SHOW(1);
> > +static GGS0_SHOW(2);
> > +static GGS0_SHOW(3);
> > +
> > +/* GGS register store function */
> > +#define GGS0_STORE(N)						\
> > +	ssize_t ggs##N##_store(struct device *device,		\
> > +			       struct device_attribute *attr,	\
> > +			       const char *buf,			\
> > +			       size_t count)			\
> > +	{							\
> > +		return ggs_store(device, attr, buf, count, N);	\
> > +	}
> > +
> > +static GGS0_STORE(0);
> > +static GGS0_STORE(1);
> > +static GGS0_STORE(2);
> > +static GGS0_STORE(3);
> > +
> > +/**
> > + * pggs_show - Show persistent global general storage (pggs) sysfs att=
ribute
> > + * @device: Device structure
> > + * @attr: Device attribute structure
> > + * @buf: Requested available shutdown_scope attributes string
> > + * @reg: Register number
> > + *
> > + * Return:Number of bytes printed into the buffer.
> > + *
> > + * Helper function for viewing a pggs register value.
> > + */
> > +static ssize_t pggs_show(struct device *device,
> > +			 struct device_attribute *attr,
> > +			 char *buf,
> > +			 u32 reg)
> > +{
> > +	return read_register(buf, IOCTL_READ_PGGS, reg);
> > +}
> > +
> > +/**
> > + * pggs_store - Store persistent global general storage (pggs) sysfs a=
ttribute
> > + * @device: Device structure
> > + * @attr: Device attribute structure
> > + * @buf: User entered shutdown_scope attribute string
> > + * @count: Size of buf
> > + * @reg: Register number
> > + *
> > + * Return: count argument if request succeeds, the corresponding
> > + * error code otherwise
> > + *
> > + * Helper function for storing a pggs register value.
> > + */
> > +static ssize_t pggs_store(struct device *device,
> > +			  struct device_attribute *attr,
> > +			  const char *buf, size_t count,
> > +			  u32 reg)
> > +{
> > +	return write_register(buf, count, IOCTL_READ_PGGS,
> > +			      IOCTL_WRITE_PGGS, reg);
> > +}
> > +
> > +#define PGGS0_SHOW(N)						\
> > +	ssize_t pggs##N##_show(struct device *device,		\
> > +			       struct device_attribute *attr,	\
> > +			       char *buf)			\
> > +	{							\
> > +		return pggs_show(device, attr, buf, N);		\
> > +	}
> > +
> > +#define PGGS0_STORE(N)						\
> > +	ssize_t pggs##N##_store(struct device *device,		\
> > +				struct device_attribute *attr,	\
> > +				const char *buf,		\
> > +				size_t count)			\
> > +	{							\
> > +		return pggs_store(device, attr, buf, count, N);	\
> > +	}
> > +
> > +/* PGGS register show functions */
> > +static PGGS0_SHOW(0);
> > +static PGGS0_SHOW(1);
> > +static PGGS0_SHOW(2);
> > +static PGGS0_SHOW(3);
> > +
> > +/* PGGS register store functions */
> > +static PGGS0_STORE(0);
> > +static PGGS0_STORE(1);
> > +static PGGS0_STORE(2);
> > +static PGGS0_STORE(3);
> > +
> > +/* GGS register attributes */
> > +static DEVICE_ATTR_RW(ggs0);
> > +static DEVICE_ATTR_RW(ggs1);
> > +static DEVICE_ATTR_RW(ggs2);
> > +static DEVICE_ATTR_RW(ggs3);
> > +
> > +/* PGGS register attributes */
> > +static DEVICE_ATTR_RW(pggs0);
> > +static DEVICE_ATTR_RW(pggs1);
> > +static DEVICE_ATTR_RW(pggs2);
> > +static DEVICE_ATTR_RW(pggs3);
> > +
> > +static struct attribute *zynqmp_ggs_attrs[] =3D {
> > +	&dev_attr_ggs0.attr,
> > +	&dev_attr_ggs1.attr,
> > +	&dev_attr_ggs2.attr,
> > +	&dev_attr_ggs3.attr,
> > +	&dev_attr_pggs0.attr,
> > +	&dev_attr_pggs1.attr,
> > +	&dev_attr_pggs2.attr,
> > +	&dev_attr_pggs3.attr,
> > +	NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(zynqmp_ggs);
> > +
> > +int zynqmp_pm_ggs_init(struct kobject *parent_kobj)
> > +{
> > +	return sysfs_create_group(parent_kobj, zynqmp_ggs_groups[0]);
>=20
> You might be racing userspace here and loosing :(

Prob is called before user space is notified about sysfs so racing shouldn'=
t happen.
Or you are referring to some other race condition?

>=20
> > +}
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> b/drivers/firmware/xilinx/zynqmp.c
> > index 75bdfaa..4c1117d 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -473,6 +473,10 @@ static inline int zynqmp_is_valid_ioctl(u32 ioctl_=
id)
> >  	case IOCTL_GET_PLL_FRAC_MODE:
> >  	case IOCTL_SET_PLL_FRAC_DATA:
> >  	case IOCTL_GET_PLL_FRAC_DATA:
> > +	case IOCTL_WRITE_GGS:
> > +	case IOCTL_READ_GGS:
> > +	case IOCTL_WRITE_PGGS:
> > +	case IOCTL_READ_PGGS:
>=20
> Huh???

Sorry not sure about your concern here. These registers are in PMU space an=
d hence
Ioctl is needed to let linux access them.

>=20
> >  		return 1;
> >  	default:
> >  		return 0;
> > @@ -704,6 +708,28 @@ const struct zynqmp_eemi_ops
> *zynqmp_pm_get_eemi_ops(void)
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
> >
> > +static int zynqmp_pm_sysfs_init(void)
> > +{
> > +	struct kobject *zynqmp_kobj;
> > +	int ret;
> > +
> > +	zynqmp_kobj =3D kobject_create_and_add("zynqmp", firmware_kobj);
> > +	if (!zynqmp_kobj) {
> > +		pr_err("zynqmp: Firmware kobj add failed.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret =3D zynqmp_pm_ggs_init(zynqmp_kobj);
> > +	if (ret) {
> > +		kobject_put(zynqmp_kobj);
> > +		pr_err("%s() GGS init fail with error %d\n",
> > +		       __func__, ret);
> > +		goto err;
> > +	}
> > +err:
> > +	return ret;
> > +}
> > +
> >  static int zynqmp_firmware_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> > @@ -751,6 +777,12 @@ static int zynqmp_firmware_probe(struct
> platform_device *pdev)
> >  	/* Assign eemi_ops_table */
> >  	eemi_ops_tbl =3D &eemi_ops;
> >
> > +	ret =3D zynqmp_pm_sysfs_init();
>=20
> See, you have a platform device, hang the attributes off of that instead
> of making a kobject and detatching yourself from the global device tree!
>=20
> Please redo this, I think it will make it a lot simpler and more
> obvious.

Agree it will be simpler but to as firmware driver was changed to be platfo=
rm driver,
to keep paths same, we used sysfs.

Thanks,
Jolly Shah


>=20
> thanks,
>=20
> greg k-h

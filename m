Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D5207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OYnoiGVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHRO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:56:56 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:34912
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgHRO4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:56:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0kADmzltT5dG7dlm6AJu8MJo3Tkgfwx9ICxVqaXayfEIhOrimsf6anIXVe9oEIQtrDvHfWSR8qpWm0leWdK5FjSY30xVyrcZNziQHoFBoqOHEn88UYNWVfhOmQYrlsMyprgatFmhEwz7XnJ85DbAQvkJSvn01WGGI82Z+sLRDxCII4gW3bmTQrq8os9yuiJwNkI2rVfYTrXc91WqrbfW78nCIGEHBIZGpHlbZ9DK1WdLAg7vThRF6ubpVTrl/M89xBPBw5sfok89i7tHMdb6x7H192oQuKa0NZuERV59Vcmk3wFKay+UEtFGoPq8SuHP9Wa4xq73JzDIgDcZvbb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjVVZLZ6sMb/V5aMSzBJ/V3ViMqeCsV0NvHcn5VSzJg=;
 b=GuHog73NYmCtRXv18byITZm94HKGJpjLgDhydqqWjRkLaDovvRS9eiVzpVlZp0z0o0YZKBlLMPNCMLaCUusLzc+azx3lNICHI0gcwa3pvkYendpdHqeLIcIYmdNrOl+PPKcmp5/XuVLKAatMqNIjMrWhoGQNYw3Mj3vhVT9xm5uYkfdeOIxACWXDL/Iuoc7OjgbWm/FOKYl1MXld10C/4RHUHXmGca4vIooaCh1o+VGUisa8bKQG3XpLAENvStR0mlRxjwNTDGcwvXcy7ESjLqqyEgJtksIbtLhRR5T/SQFm4+xxFzfmgumREdcLaWlahSMtMG7plaLqIDTpo1Qttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjVVZLZ6sMb/V5aMSzBJ/V3ViMqeCsV0NvHcn5VSzJg=;
 b=OYnoiGVbFtepaK/wP8aOxzjwpxZY8Qb8PlyjUeVI+PPHOMoA5y0llDas4ZMUBMgmr+TRK0q9F13nRtaLeSbq2jskEXR+XerkTTv1gT60ONC4sJzmgAVf13xAO2chKBvUn/vsVR/MwqG/W59EEibXc3Lr3TvxDbA2Nd0ydzEomIk=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BY5PR02MB6550.namprd02.prod.outlook.com (2603:10b6:a03:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 14:56:22 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.024; Tue, 18 Aug 2020
 14:56:22 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Stefano Stabellini <stefanos@xilinx.com>
CC:     Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Thread-Topic: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Thread-Index: AQHWb5ATV4ChTkO3Pki1oN57qb9mj6k2g4WAgAd0r9A=
Date:   Tue, 18 Aug 2020 14:56:22 +0000
Message-ID: <BYAPR02MB4407487EEA04C681FF99867CB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-6-ben.levinsky@xilinx.com>
 <alpine.DEB.2.21.2008131116060.15669@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2008131116060.15669@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0326b85f-f93e-4264-fcfe-08d84386df6e
x-ms-traffictypediagnostic: BY5PR02MB6550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB65501365EBAE6F9FA0555B66B55C0@BY5PR02MB6550.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOOdsxVq7KZquxSDKxm+Sv0kjckGtlLUNy+HbGFa8FBzGWBy9h9n2GIyU3UkgF3beo/c+EZh31+jDpOGY1/2eirCFRW40wmxL/oi440LTaY+dpXisWuqpfEyZgcpS0gazBPBCHRUokrvEGy1RC3rBQgjB+S+ecxBv0dusoA2wOmhiKQpWYnntvnMoxPFqnQZhUu3yD9TvqrDeD6qChu3TBH91A8V5Ln0EsxJPHIkjy3f8njyDEs7utvLS5+KhLrNtsR5f6+6nHiNOQ5vnXcqX3pZiGrmxWtN2OaklZkqip3JoUVDVMwfgTYkwdSPj2oqq6D3DFqnPHfr9AwwW3hTnB8cn8Wi/6N81WfWOwj29DoQC+D/gTlY1mzNC7qrE5sI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(8936002)(54906003)(30864003)(7696005)(4326008)(86362001)(6636002)(71200400001)(53546011)(6506007)(76116006)(66946007)(5660300002)(316002)(66446008)(64756008)(66556008)(66476007)(26005)(52536014)(55016002)(33656002)(83380400001)(6862004)(8676002)(186003)(478600001)(2906002)(9686003)(76704002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ysz2fW5vLlpAnK/nWpRczwrcLqiBkKRyuJNaI77W1yk/++R6+CP1Kovjtoc5/s239SU1lGdQGZMBjtWQ8U0uzrOj0GS+AvjvLmKq0UuWGVuQJPE6NxPkh+eMxjeW6yGCo6Lkl/81vue0A9U9cZtJ0WOzHfDdTg6X43b5H5RZ7CAa3xUPmarnFzpspHk0RoJDdXjImT6TK9n/KLsfc8M280sjGxJnWTyFw0WcMbBhhXpqfJXLnZX2s+jf6F3mSDCNZ3isHij1sTG7aiiGDG9iuuwbh1czCUz1G61Ykm45TqhEcnuo1meHjyx+a5NrxFCFqye5mY0ZecwQln55TebEh4d7mwK30nAb6DaCptCTO1DsXavv8g//0ZyCx42MnX7ueBzlTRbxhQlciEOMDXz/Fo2Vdk5E9/sXnqrSI+MbuKqViogCrdRapY2qqC6ZAGXNlDtdCiEqPObk07XUmuei7uyLbTWMv4siBWTpy+obiYfKcsFtukLC1U9YU7S2OUMJABt46GHSHE7LWkMfeaLhARQOpvvVEOV4iLW9B/rxjZKYqtvxTrVN0WeIBlGkV+XePtpclqG3V1P93jc2mUewgkX8WM2lDRGXr+E9AKXBz33pejSCRYzW7vyWx8GPJCQDsQWlk0U/4HkP9z2v3M7RqQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0326b85f-f93e-4264-fcfe-08d84386df6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 14:56:22.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fumdddfnsNwgSxrWEYL6EfOFXPdBsyc+PhdwDmCTnjL+ga1bzSK9r5Wbz7sR2Xh/UpZOKRNe/rNGoTuWyKgm1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano

Please see my comments inline=20

> -----Original Message-----
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Sent: Thursday, August 13, 2020 1:36 PM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Jiaying Liang
> <jliang@xilinx.com>; Jason Wu <j.wu@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
> driver
>=20
> On Mon, 10 Aug 2020, Ben Levinsky wrote:
> > R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> > remotproc driver, we can boot the R5 sub-system in different
> > configurations.
>=20
> Which different configurations? How can you boot them?
>=20
[Ben Levinsky] The different configurations are R5 split and lockstep mode.=
 Remoteproc boots the R5 up using Xilinx platform management firmware on a =
Microblaze core that has isolated access to power up/down. I will document =
as such in commit message for this patch in v9
>=20
> > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> > Signed-off-by: Jason Wu <j.wu@xilinx.com>
> > ---
> >  v2:
> >  - remove domain struct as per review from Mathieu
> >  v3:
> >  - add xilinx-related platform mgmt fn's instead of wrapping around
> >    function pointer in xilinx eemi ops struct
> >  v4:
> >  - add default values for enums
> >  - fix formatting as per checkpatch.pl --strict. Note that 1 warning an=
d 1
> check
> >    are still raised as each is due to fixing the warning results in tha=
t
> >  particular line going over 80 characters.
> >  v5:
> >  - parse_fw change from use of rproc_of_resm_mem_entry_init to
> >  rproc_mem_entry_init and use of alloc/release
> >  - var's of type zynqmp_r5_pdata all have same local variable name
> >  - use dev_dbg instead of dev_info
> >  v6:
> >  - adding memory carveouts is handled much more similarly. All mem
> >  carveouts are
> >    now described in reserved memory as needed. That is, TCM nodes are n=
ot
> >    coupled to remoteproc anymore. This is reflected in the remoteproc R=
5
> >  driver
> >    and the device tree binding.
> >  - remove mailbox from device tree binding as it is not necessary for e=
lf
> >    loading
> >  - use lockstep-mode property for configuring RPU
> >  v7:
> >  - remove unused headers
> >  - change  u32 *lockstep_mode ->  u32 lockstep_mode;
> >  - change device-tree binding "lockstep-mode"  to xlnx,cluster-mode
> >  - remove zynqmp_r5_mem_probe and loop to Probe R5 memory devices at
> >    remoteproc-probe time
> >  - remove is_r5_mode_set from  zynqmp rpu remote processor private data
> >  - do not error out if no mailbox is provided
> >  - remove zynqmp_r5_remoteproc_probe call of platform_set_drvdata as
> >  pdata is
> >    handled in zynqmp_r5_remoteproc_remove
> > v8:
> >  - remove old acks, reviewed-by's in commit message
> > ---
> >  drivers/remoteproc/Kconfig                |  10 +
> >  drivers/remoteproc/Makefile               |   1 +
> >  drivers/remoteproc/zynqmp_r5_remoteproc.c | 911
> ++++++++++++++++++++++
> >  3 files changed, 922 insertions(+)
> >  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index c4d1731295eb..342a7e668636 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -249,6 +249,16 @@ config STM32_RPROC
> >
> >  	  This can be either built-in or a loadable module.
[Ben Levinsky] Right will update in v9 in the help message
> >
> > +config ZYNQMP_R5_REMOTEPROC
> > +	tristate "ZynqMP_R5 remoteproc support"
> > +	depends on ARM64 && PM && ARCH_ZYNQMP
> > +	select RPMSG_VIRTIO
> > +	select MAILBOX
> > +	select ZYNQMP_IPI_MBOX
> > +	help
> > +	  Say y here to support ZynqMP R5 remote processors via the remote
> > +	  processor framework.
> > +
> >  endif # REMOTEPROC
> >
> >  endmenu
> > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > index e8b886e511f0..04d1c95d06d7 100644
> > --- a/drivers/remoteproc/Makefile
> > +++ b/drivers/remoteproc/Makefile
> > @@ -28,5 +28,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)		+=3D
> qcom_wcnss_pil.o
> >  qcom_wcnss_pil-y			+=3D qcom_wcnss.o
> >  qcom_wcnss_pil-y			+=3D qcom_wcnss_iris.o
> >  obj-$(CONFIG_ST_REMOTEPROC)		+=3D st_remoteproc.o
> > +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+=3D zynqmp_r5_remoteproc.o
> >  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+=3D st_slim_rproc.o
> >  obj-$(CONFIG_STM32_RPROC)		+=3D stm32_rproc.o
> > diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c
> b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> > new file mode 100644
> > index 000000000000..b600759e257e
> > --- /dev/null
> > +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
>=20
> I tried to build this but I get 4 warnings:
>=20
> drivers/remoteproc/zynqmp_r5_remoteproc.c: In function
> 'handle_tcm_parsing':
> drivers/remoteproc/zynqmp_r5_remoteproc.c:286:10: warning: return makes
> pointer from integer without a cast [-Wint-conversion]
>    return -EINVAL;
>           ^
> drivers/remoteproc/zynqmp_r5_remoteproc.c:293:10: warning: return makes
> pointer from integer without a cast [-Wint-conversion]
>    return -EINVAL;
>           ^
> drivers/remoteproc/zynqmp_r5_remoteproc.c:298:10: warning: return makes
> pointer from integer without a cast [-Wint-conversion]
>    return -ENOMEM;
>           ^
> drivers/remoteproc/zynqmp_r5_remoteproc.c:317:10: warning: return makes
> pointer from integer without a cast [-Wint-conversion]
>    return -ENOMEM;
>=20
>=20
> Please fix all warnings before submitting to the list.
>=20
[Ben Levinsky] will fix these in v9, thanks
>=20
> > @@ -0,0 +1,911 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Zynq R5 Remote Processor driver
> > + *
> > + * Copyright (C) 2019, 2020 Xilinx Inc. Ben Levinsky
> <ben.levinsky@xilinx.com>
> > + * Copyright (C) 2015 - 2018 Xilinx Inc.
> > + * Copyright (C) 2015 Jason Wu <j.wu@xilinx.com>
> > + *
> > + * Based on origin OMAP and Zynq Remote Processor driver
> > + *
> > + * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
> > + * Copyright (C) 2012 PetaLogix
> > + * Copyright (C) 2011 Texas Instruments, Inc.
> > + * Copyright (C) 2011 Google, Inc.
>=20
> In my opinion 8 copyright lines are too many. As you probably know, they
> aren't actually necessary or useful (the SPDX line and git log are the
> only things that matter). I would remove them all.
>=20
[Ben Levinsky] will do
>=20
> > + */
> > +
> > +#include <linux/atomic.h>
>=20
> I just looked at the first #include and noticed that it is not actually
> used. Please make sure that all headers included are necessary. (You can
> try to remove them one by one to test if necessary.)
>=20
[Ben Levinsky] will do
>=20
> > +#include <linux/cpu.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +#include <linux/genalloc.h>
> > +#include <linux/idr.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/mailbox/zynqmp-ipi-message.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/pfn.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/remoteproc.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +
> > +#include "remoteproc_internal.h"
> > +
> > +#define MAX_RPROCS	2 /* Support up to 2 RPU */
> > +#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory
> instance */
> > +
> > +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
> > +
> > +/* PM proc states */
> > +#define PM_PROC_STATE_ACTIVE 1U
> > +
> > +/* IPI buffer MAX length */
> > +#define IPI_BUF_LEN_MAX	32U
> > +/* RX mailbox client buffer max length */
> > +#define RX_MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
> > +				 sizeof(struct zynqmp_ipi_message))
> > +
> > +#define ZYNQMP_R5_NUM_TCM_BANKS 4
> > +
> > +/* lookup table mapping power-node-ID of TCM bank to absolute base
> address */
> > +static unsigned long
> tcm_addr_to_pnode[ZYNQMP_R5_NUM_TCM_BANKS][2] =3D {
> > +	{0xFFE00000,	0xF },
> > +	{0xFFE20000,	0x10},
> > +	{0xFFE90000,	0x10},
> > +	{0xFFEB0000,	0x11},
> > +};
> > +
> > +static bool autoboot __read_mostly;
>=20
> Please add a description of this parameter. What does it do? Why would
> anybody enable it?
>=20
[Ben Levinsky] this is not needed on ZynqMP so this can be removed. Previou=
sly was used in situations where R5 would be loaded at kernel boot time.
>=20
> > +/**
> > + * struct zynqmp_r5_mem - zynqmp rpu memory data
> > + * @pnode_id: TCM power domain ids
> > + * @res: memory resource
> > + * @node: list node
> > + */
> > +struct zynqmp_r5_mem {
> > +	u32 pnode_id[MAX_MEM_PNODES];
> > +	struct resource res;
> > +	struct list_head node;
> > +};
> > +
> > +/**
> > + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
> > + * @dev: device of RPU instance
> > + * @rproc: rproc handle
> > + * @pnode_id: RPU CPU power domain id
> > + * @mems: memory resources
> > + * @is_r5_mode_set: indicate if r5 operation mode is set
> > + * @tx_mc: tx mailbox client
> > + * @rx_mc: rx mailbox client
> > + * @tx_chan: tx mailbox channel
> > + * @rx_chan: rx mailbox channel
> > + * @mbox_work: mbox_work for the RPU remoteproc
> > + * @tx_mc_skbs: socket buffers for tx mailbox client
> > + * @rx_mc_buf: rx mailbox client buffer to save the rx message
> > + */
> > +struct zynqmp_r5_pdata {
> > +	struct device dev;
> > +	struct rproc *rproc;
> > +	u32 pnode_id;
> > +	struct list_head mems;
> > +	bool is_r5_mode_set;
> > +	struct mbox_client tx_mc;
> > +	struct mbox_client rx_mc;
> > +	struct mbox_chan *tx_chan;
> > +	struct mbox_chan *rx_chan;
> > +	struct work_struct mbox_work;
> > +	struct sk_buff_head tx_mc_skbs;
> > +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
>=20
> A simple small reordering of the struct fields would lead to small
> memory savings due to alignment.
>=20
>=20
[Ben Levinsky] will do. Do you mean ordering in either ascending or descend=
ing order?
> > +};
> > +
> > +/**
> > + * table of RPUs
> > + */
> > +struct zynqmp_r5_pdata rpus[MAX_RPROCS];
> > +/**
> > + *  RPU core configuration
>      ^ spurious white space
>=20
[Ben Levinsky] will remove this in v9
>=20
> > + */
> > +enum rpu_oper_mode rpu_mode;
> > +
> > +/*
> > + * r5_set_mode - set RPU operation mode
> > + * @pdata: Remote processor private data
> > + *
> > + * set RPU oepration mode
> > + *
> > + * Return: 0 for success, negative value for failure
> > + */
> > +static int r5_set_mode(struct zynqmp_r5_pdata *pdata)
> > +{
> > +	u32 val[PAYLOAD_ARG_CNT] =3D {0}, expect, tcm_mode;
> > +	struct device *dev =3D &pdata->dev;
> > +	int ret;
> > +
> > +	expect =3D (u32)rpu_mode;
> > +	ret =3D zynqmp_pm_get_rpu_mode(pdata->pnode_id, 0, 0, val);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get RPU oper mode.\n");
> > +		return ret;
> > +	}
> > +	if (val[0] =3D=3D expect) {
> > +		dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
> > +	} else {
> > +		ret =3D zynqmp_pm_set_rpu_mode(pdata->pnode_id,
> > +					     expect, 0, val);
>=20
> It looks like zynqmp_pm_set_rpu_mode is actually ignoring the second
> argument, so expect is not correctly handled?
>=20
[Ben Levinsky] will update this so that implementation of this zynqmp_pm_se=
t_rpu_mode using the input argument. Also, will remove use of val as arg as=
 we are not evaluating the output.
>=20
> > +		if (ret < 0) {
> > +			dev_err(dev,
> > +				"failed to set RPU oper mode.\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	tcm_mode =3D (expect =3D=3D (u32)PM_RPU_MODE_LOCKSTEP) ?
> > +		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
> > +	ret =3D zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0,
> val);
>=20
> Similarly, it looks like the second argument to zynqmp_pm_set_tcm_config
> is actually ignored by the implementation of the function. So tcm_mode
> here is not correctly handled by zynqmp_pm_set_tcm_config.
>=20
> Also val has not been zeroed from the previous call.
>=20
[Ben Levinsky] Same as above, will update zynqmp_pm_set_tcm_config and remo=
ve use of val as input arg.
>=20
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to config TCM to %x.\n",
> > +			expect);
> > +		return ret;
> > +	}
> > +	pdata->is_r5_mode_set =3D true;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * ZynqMP R5 remoteproc memory release function
> > + */
> > +static int zynqmp_r5_mem_release(struct rproc *rproc,
> > +				 struct rproc_mem_entry *mem)
> > +{
> > +	struct zynqmp_r5_mem *priv;
> > +	int i, ret;
> > +	struct device *dev =3D &rproc->dev;
> > +
> > +	priv =3D mem->priv;
> > +	if (!priv)
> > +		return 0;
> > +	for (i =3D 0; i < MAX_MEM_PNODES; i++) {
> > +		if (priv->pnode_id[i]) {
> > +			dev_dbg(dev, "%s, pnode %d\n",
> > +				__func__, priv->pnode_id[i]);
> > +			ret =3D zynqmp_pm_release_node(priv->pnode_id[i]);
> > +			if (ret < 0) {
> > +				dev_err(dev,
> > +					"failed to release power node: %u\n",
> > +					priv->pnode_id[i]);
> > +				return ret;
> > +			}
> > +		} else {
> > +			break;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * ZynqMP R5 remoteproc operations
> > + */
> > +static int zynqmp_r5_rproc_start(struct rproc *rproc)
> > +{
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +	enum rpu_boot_mem bootmem;
> > +	int ret;
> > +
> > +	if ((rproc->bootaddr & 0xF0000000) =3D=3D 0xF0000000)
> > +		bootmem =3D PM_RPU_BOOTMEM_HIVEC;
> > +	else
> > +		bootmem =3D PM_RPU_BOOTMEM_LOVEC;
> > +	dev_dbg(dev, "RPU boot from %s.",
> > +		bootmem =3D=3D PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
> > +	ret =3D zynqmp_pm_request_wakeup(pdata->pnode_id, 1,
> > +				       bootmem,
> ZYNQMP_PM_REQUEST_ACK_NO);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to boot R5.\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +	int ret;
> > +
> > +	ret =3D zynqmp_pm_force_powerdown(pdata->pnode_id,
> > +
> 	ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +	if (ret < 0) {
> > +		dev_err(&pdata->dev, "failed to shutdown R5.\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
> > +				      struct rproc_mem_entry *mem)
> > +{
> > +	struct device *dev =3D rproc->dev.parent;
> > +	void *va;
> > +
> > +	dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
> > +	va =3D ioremap_wc(mem->dma, mem->len);
> > +	if (IS_ERR_OR_NULL(va)) {
> > +		dev_err(dev, "Unable to map memory region: %pa+%lx\n",
> > +			&mem->dma, mem->len);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Update memory entry va */
> > +	mem->va =3D va;
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_rproc_mem_release(struct rproc *rproc,
> > +				       struct rproc_mem_entry *mem)
> > +{
> > +	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
> > +	iounmap(mem->va);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * TCM needs mapping to R5 relative address and xilinx platform mgmt c=
all
> > + */
> > +struct rproc_mem_entry *handle_tcm_parsing(struct device *dev,
> > +					    struct reserved_mem *rmem,
> > +					    struct device_node *node,
> > +					    int lookup_idx)
> > +{
> > +	void *va;
> > +	dma_addr_t dma;
> > +	resource_size_t size;
> > +	int ret;
> > +	u32 pnode_id;
> > +	struct resource rsc;
> > +	struct rproc_mem_entry *mem;
> > +
> > +	pnode_id =3D  tcm_addr_to_pnode[lookup_idx][1];
> > +	ret =3D zynqmp_pm_request_node(pnode_id,
> > +				     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to request power node: %u\n",
> pnode_id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D of_address_to_resource(node, 0, &rsc);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get resource of memory %s",
> > +			of_node_full_name(node));
> > +		return -EINVAL;
> > +	}
> > +	size =3D resource_size(&rsc);
> > +	va =3D devm_ioremap_wc(dev, rsc.start, size);
> > +	if (!va)
> > +		return -ENOMEM;
> > +
> > +	/* zero out tcm base address */
> > +	if (rsc.start & 0xffe00000) {
> > +		/* R5 can't see anything past 0xfffff so wipe it */
> > +		rsc.start &=3D 0x000fffff;
>=20
> If that is the case why not do:
>=20
>   rsc.start &=3D 0x000fffff;
>=20
> unconditionally? if (rsc.start & 0xffe00000) is superfluous.
>=20
> But I thought that actually the R5s could see TCM at both the low
> address (< 0x000fffff) and also at the high address (i.e. 0xffe00000).
>=20
>=20
[Ben Levinsky] Here yes can make rsc.start &=3D 0x000fffff undconditional. =
Will update in v9 as such
		Also, this logic is because this is only for the Xilinx R5 mappings of TC=
M banks that are at (from the TCM point of view) 0x0 and 0x2000
> > +		/*
> > +		 * handle tcm banks 1 a and b (0xffe9000 and
> > +		 * 0xffeb0000)
> > +		 */
> > +		if (rsc.start & 0x80000)
> > +			rsc.start -=3D 0x90000;
>=20
> It is very unclear to me why we have to do this
>=20
>=20
[Ben Levinsky] This is for TCM bank 0B and bank 1B to map them to 0x0002000=
0 so that the TCM relative addressing lines up. For example (0xffe90000 & 0=
x000fffff) - 0x90000 =3D 0x20000
> > +	}
> > +
> > +	dma =3D (dma_addr_t)rsc.start;
>=20
> Given the way the dma parameter is used by
> rproc_alloc_registered_carveouts, I think it might be best to pass the
> original start address (i.e. 0xffe00000) as dma.
>=20
>=20
> > +	mem =3D rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start,
> > +				   NULL, zynqmp_r5_mem_release,
>=20
> I don't know too much about the remoteproc APIs, but shouldn't you be
> passing zynqmp_r5_rproc_mem_alloc to it instead of NULL?
>=20
>=20
[Ben Levinsky] the difference is that for TCM we have to do make the relati=
ve address work for TCM, so the dma input to rproc_mem_entry_init is differ=
ent in TCM case.=20
> > +				   rsc.name);
> > +	if (!mem)
> > +		return -ENOMEM;
> > +
> > +	return mem;
> > +}
> > +
> > +static int parse_mem_regions(struct rproc *rproc)
> > +{
> > +	int num_mems, i;
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +	struct device *dev =3D  &pdata->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct rproc_mem_entry *mem;
> > +
> > +	num_mems =3D of_count_phandle_with_args(np, "memory-region",
> NULL);
> > +	if (num_mems <=3D 0)
> > +		return 0;
> > +	for (i =3D 0; i < num_mems; i++) {
> > +		struct device_node *node;
> > +		struct reserved_mem *rmem;
> > +
> > +		node =3D of_parse_phandle(np, "memory-region", i);
>=20
> Check node !=3D NULL ?
>=20
[Ben Levinsky] will add this in v9
>=20
> > +		rmem =3D of_reserved_mem_lookup(node);
> > +		if (!rmem) {
> > +			dev_err(dev, "unable to acquire memory-region\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (strstr(node->name, "vdev0buffer")) {
>=20
> vdev0buffer is not described in the device tree bindings, is that
> normal/expected?
>=20
>=20
[Ben Levinsky] vdev0buffer is not required, as there might be simple firmwa=
re loading with no IPC. Vdev0buffer only needed for IPC.=20
> > +			/* Register DMA region */
> > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > +						   (dma_addr_t)rmem->base,
> > +						   rmem->size, rmem->base,
> > +						   NULL, NULL,
> > +						   "vdev0buffer");
> > +			if (!mem) {
> > +				dev_err(dev, "unable to initialize memory-
> region %s\n",
> > +					node->name);
> > +				return -ENOMEM;
> > +			}
> > +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
> > +				mem->dma);
> > +		} else if (strstr(node->name, "vdev0vring")) {
>=20
> Same here
>=20
>=20
> > +			int vring_id;
> > +			char name[16];
> > +
> > +			/*
> > +			 * can be 1 of multiple vring IDs per IPC channel
> > +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
> > +			 */
> > +			vring_id =3D node->name[14] - '0';
>=20
> Where does the "14" comes from? Are we sure it is not possible to have a
> node->name smaller than 14 chars?
>=20
[Ben Levinsky] Presently there are only 2 vrings used per Xilinx OpenAMP ch=
annel to RPU. In Xilinx kernel we have hard-coded names as these are the on=
ly nodes that use it. For example RPU0vdev0vring0 and RPU1vdev0vring0. Henc=
e we only check for vdev0vring and not a sscanf("%*s%i") to parse out the v=
ring ID or other, cleaner solution.
>=20
> > +			snprintf(name, sizeof(name), "vdev0vring%d",
> vring_id);
> > +			/* Register vring */
> > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > +						   (dma_addr_t)rmem->base,
> > +						   rmem->size, rmem->base,
> > +
> zynqmp_r5_rproc_mem_alloc,
> > +
> zynqmp_r5_rproc_mem_release,
> > +						   name);
> > +			dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
> > +				mem->dma);
> > +		} else {
> > +			int idx;
> > +
> > +			/*
> > +			 * if TCM update address space for R5 and
> > +			 * make xilinx platform mgmt call
> > +			 */
> > +			for (idx =3D 0; idx < ZYNQMP_R5_NUM_TCM_BANKS;
> idx++) {
> > +				if (tcm_addr_to_pnode[idx][0] =3D=3D rmem-
> >base)
> > +					break;
>=20
> There is something I don't quite understand. If the memory region to use
> is TCM, why would it be also described under reserved-memory?
> Reserved-memory is for normal memory being reserved, while TCM is not
> normal memory. Am I missing something?
>=20
[Ben Levinsky] I can change this in v9 as discussed. That is, have no TCM u=
nder reserved mem. Instead have the banks as nodes in device tree with stat=
us=3D"[enabled|disabled]" and if enabled, then try to add memories in parse=
_fw call.
>=20
> > +			}
> > +
> > +			if (idx !=3D ZYNQMP_R5_NUM_TCM_BANKS) {
> > +				mem =3D handle_tcm_parsing(dev, rmem, node,
> idx);
> > +			} else {
> > +				mem =3D rproc_mem_entry_init(dev, NULL,
> > +						   (dma_addr_t)rmem->base,
> > +						   rmem->size, rmem->base,
> > +
> zynqmp_r5_rproc_mem_alloc,
> > +
> zynqmp_r5_rproc_mem_release,
> > +						   node->name);
>=20
> This case looks identical to the vdev0vring above. Is the difference
> really just in the "name"? If so, can we merge the two cases into one?
> no, because the devm_ioremap_wc call has to be done before changing the d=
ma address to relative for TCM banks.
>=20
> > +			}
> > +
> > +			if (!mem) {
> > +				dev_err(dev,
> > +					"unable to init memory-region %s\n",
> > +					node->name);
> > +				return -ENOMEM;
> > +			}
> > +		}
> > +		rproc_add_carveout(rproc, mem);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmwa=
re
> *fw)
> > +{
> > +	int ret;
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +	struct device *dev =3D &pdata->dev;
> > +
> > +	ret =3D parse_mem_regions(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D rproc_elf_load_rsc_table(rproc, fw);
> > +	if (ret =3D=3D -EINVAL) {
> > +		dev_info(dev, "no resource table found.\n");
> > +		ret =3D 0;
>=20
> Why do we want to continue ignoring the error in this case?
>=20
[Ben Levinsky] as there can be simple firmware loaded onto R5 that do not h=
ave resource table. Resource table only needed for specific IPC case.
>=20
> > +	}
> > +	return ret;
> > +}
> > +
> > +/* kick a firmware */
> > +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> > +{
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +
> > +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n",
> vqid);
> > +
> > +	if (vqid < 0) {
> > +		/* If vqid is negative, does not pass the vqid to
> > +		 * mailbox. As vqid is supposed to be 0 or possive.
> > +		 * It also gives a way to just kick instead but
> > +		 * not use the IPI buffer. It is better to provide
> > +		 * a proper way to pass the short message, which will
> > +		 * need to sync to upstream first, for now,
> > +		 * use negative vqid to assume no message will be
> > +		 * passed with IPI buffer, but just raise interrupt.
> > +		 * This will be faster as it doesn't need to copy the
> > +		 * message to the IPI buffer.
>=20
> I take that by "upstream" you mean the upstream Linux kernel community?
> Did the conversation happen?
>=20
[Ben Levinsky] can remove this in v9 and just use the logic present in the =
else clause.
>=20
> > +		 * It will ignore the return, as failure is due to
> > +		 * there already kicks in the mailbox queue.
> > +		 */
> > +		(void)mbox_send_message(pdata->tx_chan, NULL);
> > +	} else {
> > +		struct sk_buff *skb;
> > +		unsigned int skb_len;
> > +		struct zynqmp_ipi_message *mb_msg;
> > +		int ret;
> > +
> > +		skb_len =3D (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
> > +		skb =3D alloc_skb(skb_len, GFP_ATOMIC);
> > +		if (!skb) {
> > +			dev_err(dev,
> > +				"Failed to allocate skb to kick remote.\n");
> > +			return;
> > +		}
> > +		mb_msg =3D (struct zynqmp_ipi_message *)skb_put(skb,
> skb_len);
> > +		mb_msg->len =3D sizeof(vqid);
> > +		memcpy(mb_msg->data, &vqid, sizeof(vqid));
> > +		skb_queue_tail(&pdata->tx_mc_skbs, skb);
> > +		ret =3D mbox_send_message(pdata->tx_chan, mb_msg);
> > +		if (ret < 0) {
> > +			dev_warn(dev, "Failed to kick remote.\n");
> > +			skb_dequeue_tail(&pdata->tx_mc_skbs);
> > +			kfree_skb(skb);
> > +		}
> > +	}
> > +}
> > +
> > +static struct rproc_ops zynqmp_r5_rproc_ops =3D {
> > +	.start		=3D zynqmp_r5_rproc_start,
> > +	.stop		=3D zynqmp_r5_rproc_stop,
> > +	.load		=3D rproc_elf_load_segments,
> > +	.parse_fw	=3D zynqmp_r5_parse_fw,
> > +	.find_loaded_rsc_table =3D rproc_elf_find_loaded_rsc_table,
> > +	.sanity_check	=3D rproc_elf_sanity_check,
> > +	.get_boot_addr	=3D rproc_elf_get_boot_addr,
> > +	.kick		=3D zynqmp_r5_rproc_kick,
> > +};
> > +
> > +/* zynqmp_r5_mem_probe() - probes RPU TCM memory device
> > + * @pdata: pointer to the RPU remoteproc private data
> > + * @node: pointer to the memory node
> > + *
> > + * Function to retrieve resources for RPU TCM memory device.
> > + */
> > +static int zynqmp_r5_mem_probe(struct zynqmp_r5_pdata *pdata,
> > +			       struct device_node *node)
> > +{
>=20
> TCM nodes as children of the zynqmp_r5_remoteproc node are not described
> in device tree, hence, they should not be parsed here.
>=20
[Ben Levinsky] ok will remove here.
>=20
> > +	struct device *dev;
> > +	struct zynqmp_r5_mem *mem;
> > +	int ret;
> > +	struct property *prop;
> > +	const __be32 *cur;
> > +	u32 val;
> > +	int i;
> > +
> > +	dev =3D &pdata->dev;
> > +	mem =3D devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
> > +	if (!mem)
> > +		return -ENOMEM;
> > +	ret =3D of_address_to_resource(node, 0, &mem->res);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get resource of memory %s",
> > +			of_node_full_name(node));
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Get the power domain id */
> > +	i =3D 0;
> > +	if (of_find_property(node, "pnode-id", NULL)) {
> > +		of_property_for_each_u32(node, "pnode-id", prop, cur, val)
> > +			mem->pnode_id[i++] =3D val;
> > +	}
> > +	list_add_tail(&mem->node, &pdata->mems);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * zynqmp_r5_release() - ZynqMP R5 device release function
> > + * @dev: pointer to the device struct of ZynqMP R5
> > + *
> > + * Function to release ZynqMP R5 device.
> > + */
> > +static void zynqmp_r5_release(struct device *dev)
> > +{
> > +	struct zynqmp_r5_pdata *pdata;
> > +	struct rproc *rproc;
> > +	struct sk_buff *skb;
> > +
> > +	pdata =3D dev_get_drvdata(dev);
> > +	rproc =3D pdata->rproc;
> > +	if (rproc) {
> > +		rproc_del(rproc);
> > +		rproc_free(rproc);
> > +	}
> > +	if (pdata->tx_chan)
> > +		mbox_free_channel(pdata->tx_chan);
> > +	if (pdata->rx_chan)
> > +		mbox_free_channel(pdata->rx_chan);
> > +	/* Discard all SKBs */
> > +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> > +		skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> > +		kfree_skb(skb);
> > +	}
> > +
> > +	put_device(dev->parent);
> > +}
> > +
> > +/**
> > + * event_notified_idr_cb() - event notified idr callback
> > + * @id: idr id
> > + * @ptr: pointer to idr private data
> > + * @data: data passed to idr_for_each callback
> > + *
> > + * Pass notification to remoteproc virtio
> > + *
> > + * Return: 0. having return is to satisfy the idr_for_each() function
> > + *          pointer input argument requirement.
> > + **/
> > +static int event_notified_idr_cb(int id, void *ptr, void *data)
> > +{
> > +	struct rproc *rproc =3D data;
> > +
> > +	(void)rproc_vq_interrupt(rproc, id);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * handle_event_notified() - remoteproc notification work funciton
> > + * @work: pointer to the work structure
> > + *
> > + * It checks each registered remoteproc notify IDs.
> > + */
> > +static void handle_event_notified(struct work_struct *work)
> > +{
> > +	struct rproc *rproc;
> > +	struct zynqmp_r5_pdata *pdata;
> > +
> > +	pdata =3D container_of(work, struct zynqmp_r5_pdata, mbox_work);
> > +
> > +	(void)mbox_send_message(pdata->rx_chan, NULL);
> > +	rproc =3D pdata->rproc;
> > +	/*
> > +	 * We only use IPI for interrupt. The firmware side may or may
> > +	 * not write the notifyid when it trigger IPI.
> > +	 * And thus, we scan through all the registered notifyids.
> > +	 */
> > +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
>=20
> This looks expensive. Should we at least check whether the notifyid was
> written as first thing before doing the scan?
>=20
[Ben Levinsky] this will be at most 2 vrings presently per firmware-load an=
d only done when the firmware is loaded so the latency so should not impact=
 performace or user
>=20
> > +}
> > +
> > +/**
> > + * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
> > + * @cl: mailbox client
> > + * @mssg: message pointer
> > + *
> > + * It will schedule the R5 notification work.
> > + */
> > +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg)
> > +{
> > +	struct zynqmp_r5_pdata *pdata;
> > +
> > +	pdata =3D container_of(cl, struct zynqmp_r5_pdata, rx_mc);
> > +	if (mssg) {
> > +		struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> > +		size_t len;
> > +
> > +		ipi_msg =3D (struct zynqmp_ipi_message *)mssg;
> > +		buf_msg =3D (struct zynqmp_ipi_message *)pdata->rx_mc_buf;
> > +		len =3D (ipi_msg->len >=3D IPI_BUF_LEN_MAX) ?
> > +		      IPI_BUF_LEN_MAX : ipi_msg->len;
> > +		buf_msg->len =3D len;
> > +		memcpy(buf_msg->data, ipi_msg->data, len);
> > +	}
> > +	schedule_work(&pdata->mbox_work);
> > +}
> > +
> > +/**
> > + * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
> > + * @cl: mailbox client
> > + * @mssg: pointer to the message which has been sent
> > + * @r: status of last TX - OK or error
> > + *
> > + * It will be called by the mailbox framework when the last TX has don=
e.
> > + */
> > +static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg, i=
nt
> r)
> > +{
> > +	struct zynqmp_r5_pdata *pdata;
> > +	struct sk_buff *skb;
> > +
> > +	if (!mssg)
> > +		return;
> > +	pdata =3D container_of(cl, struct zynqmp_r5_pdata, tx_mc);
> > +	skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> > +	kfree_skb(skb);
> > +}
> > +
> > +/**
> > + * zynqmp_r5_setup_mbox() - Setup mailboxes
> > + *
> > + * @pdata: pointer to the ZynqMP R5 processor platform data
> > + * @node: pointer of the device node
> > + *
> > + * Function to setup mailboxes to talk to RPU.
> > + *
> > + * Return: 0 for success, negative value for failure.
> > + */
> > +static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
> > +				struct device_node *node)
> > +{
> > +	struct device *dev =3D &pdata->dev;
> > +	struct mbox_client *mclient;
> > +
> > +	/* Setup TX mailbox channel client */
> > +	mclient =3D &pdata->tx_mc;
> > +	mclient->dev =3D dev;
> > +	mclient->rx_callback =3D NULL;
> > +	mclient->tx_block =3D false;
> > +	mclient->knows_txdone =3D false;
> > +	mclient->tx_done =3D zynqmp_r5_mb_tx_done;
> > +
> > +	/* Setup TX mailbox channel client */
> > +	mclient =3D &pdata->rx_mc;
> > +	mclient->dev =3D dev;
> > +	mclient->rx_callback =3D zynqmp_r5_mb_rx_cb;
> > +	mclient->tx_block =3D false;
> > +	mclient->knows_txdone =3D false;
> > +
> > +	INIT_WORK(&pdata->mbox_work, handle_event_notified);
> > +
> > +	/* Request TX and RX channels */
> > +	pdata->tx_chan =3D mbox_request_channel_byname(&pdata->tx_mc,
> "tx");
> > +	if (IS_ERR(pdata->tx_chan)) {
> > +		dev_err(dev, "failed to request mbox tx channel.\n");
> > +		pdata->tx_chan =3D NULL;
> > +		return -EINVAL;
> > +	}
> > +	pdata->rx_chan =3D mbox_request_channel_byname(&pdata->rx_mc,
> "rx");
> > +	if (IS_ERR(pdata->rx_chan)) {
> > +		dev_err(dev, "failed to request mbox rx channel.\n");
> > +		pdata->rx_chan =3D NULL;
> > +		return -EINVAL;
> > +	}
> > +	skb_queue_head_init(&pdata->tx_mc_skbs);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
> > + * @pdata: pointer to the ZynqMP R5 processor platform data
> > + * @pdev: parent RPU domain platform device
> > + * @node: pointer of the device node
> > + *
> > + * Function to retrieve the information of the ZynqMP R5 device node.
> > + *
> > + * Return: 0 for success, negative value for failure.
> > + */
> > +static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
> > +			   struct platform_device *pdev,
> > +			   struct device_node *node)
> > +{
> > +	struct device *dev =3D &pdata->dev;
> > +	struct rproc *rproc;
> > +	struct device_node *nc;
> > +	int ret;
> > +
> > +	/* Create device for ZynqMP R5 device */
> > +	dev->parent =3D &pdev->dev;
> > +	dev->release =3D zynqmp_r5_release;
> > +	dev->of_node =3D node;
> > +	dev_set_name(dev, "%s", of_node_full_name(node));
> > +	dev_set_drvdata(dev, pdata);
> > +	ret =3D device_register(dev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register device.\n");
> > +		return ret;
> > +	}
> > +	get_device(&pdev->dev);
> > +
> > +	/* Allocate remoteproc instance */
> > +	rproc =3D rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops,
> NULL, 0);
> > +	if (!rproc) {
> > +		dev_err(dev, "rproc allocation failed.\n");
> > +		ret =3D -ENOMEM;
> > +		goto error;
> > +	}
> > +	rproc->auto_boot =3D autoboot;
> > +	pdata->rproc =3D rproc;
> > +	rproc->priv =3D pdata;
> > +
> > +	/*
> > +	 * The device has not been spawned from a device tree, so
> > +	 * arch_setup_dma_ops has not been called, thus leaving
> > +	 * the device with dummy DMA ops.
> > +	 * Fix this by inheriting the parent's DMA ops and mask.
> > +	 */
>=20
> This comment looks ominous. Is it still true even in Linux master,
> after Christoph rework of the dma_ops? Probably not?
>=20
[Ben Levinsky] tested without it and now is fine. Will remove in v9
>=20
> > +	rproc->dev.dma_mask =3D pdev->dev.dma_mask;
> > +	set_dma_ops(&rproc->dev, get_dma_ops(&pdev->dev));
> > +
> > +	/* Probe R5 memory devices */
> > +	INIT_LIST_HEAD(&pdata->mems);
> > +	for_each_available_child_of_node(node, nc) {
> > +		ret =3D zynqmp_r5_mem_probe(pdata, nc);
> > +		if (ret) {
> > +			dev_err(dev, "failed to probe memory %s.\n",
> > +				of_node_full_name(nc));
> > +			goto error;
> > +		}
> > +	}
> > +
> > +	/* Set up DMA mask */
> > +	ret =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > +	if (ret) {
> > +		dev_warn(dev, "dma_set_coherent_mask failed: %d\n", ret);
> > +		/* If DMA is not configured yet, try to configure it. */
> > +		ret =3D of_dma_configure(dev, node, true);
> > +		if (ret) {
> > +			dev_err(dev, "failed to configure DMA.\n");
> > +			goto error;
> > +		}
> > +	}
>=20
> It looks like we are following a trial-and-error approach to setup dma
> coherency. Can we do the right thing without having to try first?
>=20
> Specifically, in which circumstances of_dma_configure() would need to be
> called again here?
>=20
[Ben Levinsky] will remove in v9 - that is only do the dma_set_coherent_mas=
k, that is also done in other remoteproc drivers.
>=20
> > +	/* Get R5 power domain node */
> > +	ret =3D of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get power node id.\n");
> > +		goto error;
> > +	}
> > +
> > +	/* TODO Check if R5 is running */
> > +
> > +	/* Set up R5 if not already setup */
> > +	ret =3D pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set R5 operation mode.\n");
> > +		return ret;
> > +	}
>=20
> is_r5_mode_set is set by r5_set_mode(), which is only called here.
> So it looks like this check is important in cases where
> zynqmp_r5_probe() is called twice for the same R5 node. But I don't
> think that is supposed to happen?
>=20
[Ben Levinsky] this is needed as there are cases where user can repeatedly =
load different firmware so the check is needed in cases like this where rpu=
 is already configured. It is also possible that a user might repeatedly lo=
ad/unload the module
>=20
> > +	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
> > +		dev_dbg(dev, "no mailboxes.\n");
> > +		goto error;
> > +	} else {
> > +		ret =3D zynqmp_r5_setup_mbox(pdata, node);
> > +		if (ret < 0)
> > +			goto error;
>=20
> Given that mboxes is actually required, I think you should update the
> device tree example with it. Otherwise, if mboxes is not required, then
> we shouldn't fail with an error here if it is absent.
>=20
>=20
[Ben Levinsky] will update so that if no mboxes it will not error out.=20
> > +	}
> > +
> > +	/* Add R5 remoteproc */
> > +	ret =3D rproc_add(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "rproc registration failed\n");
> > +		goto error;
> > +	}
> > +	return 0;
> > +error:
> > +	if (pdata->rproc)
> > +		rproc_free(pdata->rproc);
> > +	pdata->rproc =3D NULL;
> > +	device_unregister(dev);
> > +	put_device(&pdev->dev);
> > +	return ret;
> > +}
> > +
> > +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> > +{
> > +	int ret, i =3D 0;
> > +	u32 *lockstep_mode;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *nc;
> > +	struct zynqmp_r5_pdata *pdata;
> > +
> > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	lockstep_mode =3D devm_kzalloc(dev, sizeof(u32 *), GFP_KERNEL);
>=20
> Any reasons why lockstep_mode couldn't just be a local variable then use
> &lockstep_mode when you need a reference?
>=20
[Ben Levinsky] good point. Will fix in v9
>=20
> > +	if (!pdata || !lockstep_mode)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, pdata);
> > +
> > +	of_property_read_u32(dev->of_node, "lockstep-mode",
> lockstep_mode);
> > +
> > +	if (!(*lockstep_mode)) {
> > +		rpu_mode =3D PM_RPU_MODE_SPLIT;
> > +	} else if (*lockstep_mode =3D=3D 1) {
> > +		rpu_mode =3D PM_RPU_MODE_LOCKSTEP;
> > +	} else {
> > +		dev_err(dev,
> > +			"Invalid lockstep-mode mode provided - %x %d\n",
> > +			*lockstep_mode, rpu_mode);
> > +		return -EINVAL;
> > +	}
> > +	dev_dbg(dev, "RPU configuration: %s\r\n",
> > +		(*lockstep_mode) ? "lockstep" : "split");
> > +
> > +	for_each_available_child_of_node(dev->of_node, nc) {
> > +		ret =3D zynqmp_r5_probe(&rpus[i], pdev, nc);
> > +		if (ret) {
> > +			dev_err(dev, "failed to probe rpu %s.\n",
> > +				of_node_full_name(nc));
> > +			return ret;
> > +		}
> > +		i++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < MAX_RPROCS; i++) {
> > +		struct zynqmp_r5_pdata *pdata =3D &rpus[i];
> > +		struct rproc *rproc;
> > +
> > +		rproc =3D pdata->rproc;
> > +		if (rproc) {
> > +			rproc_del(rproc);
> > +			rproc_free(rproc);
> > +			pdata->rproc =3D NULL;
> > +		}
> > +		if (pdata->tx_chan) {
> > +			mbox_free_channel(pdata->tx_chan);
> > +			pdata->tx_chan =3D NULL;
> > +		}
> > +		if (pdata->rx_chan) {
> > +			mbox_free_channel(pdata->rx_chan);
> > +			pdata->rx_chan =3D NULL;
> > +		}
> > +
> > +		device_unregister(&pdata->dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Match table for OF platform binding */
> > +static const struct of_device_id zynqmp_r5_remoteproc_match[] =3D {
> > +	{ .compatible =3D "xlnx,zynqmp-r5-remoteproc-1.0", },
> > +	{ /* end of list */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> > +
> > +static struct platform_driver zynqmp_r5_remoteproc_driver =3D {
> > +	.probe =3D zynqmp_r5_remoteproc_probe,
> > +	.remove =3D zynqmp_r5_remoteproc_remove,
> > +	.driver =3D {
> > +		.name =3D "zynqmp_r5_remoteproc",
> > +		.of_match_table =3D zynqmp_r5_remoteproc_match,
> > +	},
> > +};
> > +module_platform_driver(zynqmp_r5_remoteproc_driver);
> > +
> > +module_param_named(autoboot,  autoboot, bool, 0444);
> > +MODULE_PARM_DESC(autoboot,
> > +		 "enable | disable autoboot. (default: false)");
> > +
> > +MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
> > +MODULE_LICENSE("GPL v2");

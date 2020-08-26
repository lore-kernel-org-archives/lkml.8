Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D0B22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RXT/P43w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHZVe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:34:27 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:8928
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgHZVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWGffOtYXH61xYcD7xmpnLrTl0dINjm/Tr3bmkopR33VlmL+j5HqB4yBWSJ6qgkw1OwKD6lewomGTZNZdyavtV2gEPeo44xrapNgpPFJA1JALnSqs6XFDHBHHt0A5yutNNaNlV3a73NIccG6M1aQ3arad+KBAiBiY4NX6bcD4isRzxLaPGO5wVgRTjzRx+ofiCwtocs/OkzmSFBHXpx8ylWQhN+wu5a2cMOfKfi1WGecGY7n+fJWsZw6Y99TPsx2YsrAjmMNxSZpvtdGrF4siKGzWXvG+hNwi3MBf/jq9TU8yIxgr99zrngNYaQATGaei0MTzTOgCaifR+dIA+uTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l4wJfk7iha3UiGvN8tKFRsHG7oCXIGDncSmFJsClK4=;
 b=Cs+RurHY+WSu82lYtj3n5s+XttPcHivGcu9YeTcsqbFrOOmsK3p3dDu5LmBEifLJH8FyNZRy252KOdpahypOAzKYo5IvGf4crnU3mRYUMRoMwWlzAVyW4EiMJd7kRZreb+fcwnk/3Q4E3zrk29uX3t7udndl/bKH6cq2jLcAWKMyqswIs2CZyb7XLhK/HT1cDkF2dzb3f7gCdeJ4i/1hf4ib+0/Y9mOVSTHp+SqznlieV/ojKWOP0WFpJVEN3bZDdVvt5wCtllbwVMvFa0X9Y2FJVHxqEynNczdRHHUCtLf+eb1Euw+v0BUr8nzkCdAcuYi9ptVpNVketXy5mXj5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l4wJfk7iha3UiGvN8tKFRsHG7oCXIGDncSmFJsClK4=;
 b=RXT/P43wwdaIew4agfa/TzWjibmVEYBWLNxmI5ICyx1qY/5cmrGCoGQ7kpSPJFzufpAXn+yHIoe6EAKzkB9nX7NYlEzVjLeDcekcrtaFgigMcgat4uOVKYwg/9pSNfSGOWpbeAMcT3oZTS83EyejpXIcV8o36XVK0fJRbD+gl5k=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5334.namprd02.prod.outlook.com (2603:10b6:a03:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 21:34:15 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 21:34:15 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Michael Auchter <michael.auchter@ni.com>
CC:     Stefano Stabellini <stefanos@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Thread-Topic: [PATCH v9 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Thread-Index: AQHWe8QVOFVHYsWxu0aNDK2y8QHEVKlK6TOAgAAAerA=
Date:   Wed, 26 Aug 2020 21:34:14 +0000
Message-ID: <BYAPR02MB4407A03F43D6110654EF772BB5540@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200826161307.1064-1-ben.levinsky@xilinx.com>
 <20200826161307.1064-6-ben.levinsky@xilinx.com>
 <20200826213215.GA404249@xaphan>
In-Reply-To: <20200826213215.GA404249@xaphan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: ni.com; dkim=none (message not signed)
 header.d=none;ni.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c365ff0d-8df0-4e2c-bd0c-08d84a07c7ff
x-ms-traffictypediagnostic: BYAPR02MB5334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB53341B11473E82C122D7139AB5540@BYAPR02MB5334.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSc56HzFgVwwjN/Z/Q7GzK7IB4u9PwETlBv8xnq/3er0vABAu01qzRmxyAn3udv+wQMHA03zGH8z4ZgNonwHwfZs1bnaDKl7Thrx8XJp5gH/L7kF9TCvkulgEK4387no5qeRDKcDxPngn52710RbuSq7BgwHHBFNxCN7kMg3AZCzICvW5p+XgjSqvjyqPHPszngyFtTI8wnSucYPDT1HG9gmT+/TbNp8iUHCIISw8iLhRI13A8cqk6u+A84yN6IG/utNljTxIBaUhSBVxUd7XjE7SZdbTNwrNIrynsB2+1xpeXB4/XID5wfKDaAD+PGlVyBBXkhCL+oudTAdDOih5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(64756008)(9686003)(4326008)(54906003)(83380400001)(478600001)(2906002)(5660300002)(966005)(316002)(30864003)(52536014)(6916009)(55016002)(33656002)(66446008)(76116006)(66946007)(71200400001)(66556008)(6506007)(86362001)(8936002)(66476007)(8676002)(186003)(53546011)(7696005)(26005)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HiBjSyBFSfrdipw0Dmwr5Xl0wbT3+M15gNK+jGyPZE3736cbJCwro0yIg8QpVrRB3DBtJkwGFOXX97yJ9k6iCs1NC/G5FAbW8sdaks70CEg93TVpWScF+Ec7nBI9PTsiUX8/b9n0jF6jCOJMXbUMXH7UIaXxgqzl+XXGWJAH3ZbrnjbRWwu7DmiQVq9Sfbcz8zJ2fDr8Ttj3C9mx2on8fP/p9NRMG7plF7jxr9xEvpB2brabyrHN4oz3NgYST6syO1r5foanp9PtsHLaIFveFehVjab5qD7TQLwV9tK5WaaR+m1xtpky1+ZNU3fAL59z32CYf+4uE4n5TicF8oouhfD97MA874+O+mebVANWl+HoSAOVMM8IsZCuZTKVifXpYZGVRhiL6L3f9kIy3lfW6VZi9dtc3YoDCO0G8AbbdlVeJa8JAvpvmflc5nHXcDDRR3YzVqitl493hpV0uVVqD0Dya6SUjczmRaLx/aqOgpxNbqhh5m4zdAvwdyQUT1mw8xf2fCIBsBxJMDFkvGW0Q3kkMWfWdZ6vfv5jUCpsFLB4WbmaEJBaiKWSwRVlYaIR6e+A21ZMReJMhYCCVhiEd0LCePNHooXwM8uXet1GAk4GvKaCfFQC3JtT3F+jSY4GMYNicXsymj/fQqezVyImtQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c365ff0d-8df0-4e2c-bd0c-08d84a07c7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 21:34:15.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GytI4fH2lL+/ZsKVGMWpChY9bF9IcQ4nVLOywPElsYnssoW7pZ2qehL5t/MZ+RJPV52JVdqe0BLwjKjiS/xH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for the catch, will update in v10=20

> -----Original Message-----
> From: Michael Auchter <michael.auchter@ni.com>
> Sent: Wednesday, August 26, 2020 2:32 PM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Jiaying Liang
> <jliang@xilinx.com>; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v9 5/5] remoteproc: Add initial zynqmp R5 remoteproc
> driver
>=20
> Hello Ben,
>=20
> On Wed, Aug 26, 2020 at 09:13:07AM -0700, Ben Levinsky wrote:
> > R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> > remotproc driver, we can boot the R5 sub-system in different 2
> > configurations: split or lock-step.
> >
> > The Xilinx R5 Remoteproc Driver boots the R5's via calls to the Xilinx
> > Platform Management Unit that handles the R5 configuration, memory
> access
> > and R5 lifecycle management. The interface to this manager is done in t=
his
> > driver via zynqmp_pm_* function calls.
> >
> > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> > Signed-off-by: Jason Wu <j.wu@xilinx.com>
> > ---
> > v2:
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
> > v9:
> > - as mboxes are now optional, if pdata->tx_mc_skbs not initialized then
> >   do not call skb_queue_empty
> > - update usage for zynqmp_pm_set_rpu_mode,
> zynqmp_pm_set_tcm_config and
> >   zynqmp_pm_get_rpu_mode
> > - update 5/5 patch commit message to document supported configurations
> >   and how they are booted by the driver.
> > - remove copyrights other than SPDX from zynqmp_r5_remoteproc.c
> > - compilation warnings no longer raised
> > - remove unused includes from zynqmp_r5_remoteproc.c
> > - remove unused  var autoboot from zynqmp_r5_remoteproc.c
> > - reorder zynqmp_r5_pdata fpr small mem savings due to alignment
> > - use of zynqmp_pm_set_tcm_config now does not have
> >   output arg
> > - in tcm handling, unconditionally use &=3D 0x000fffff mask since all n=
odes
> >   in this fn are for tcm
> > - update comments for translating dma field in tcm handling to device
> >   address
> > - update calls to rproc_mem_entry_init in parse_mem_regions so that the=
re
> >   are only 2 cases for types of carveouts instead of 3
> > - in parse_mem_regions, check if device tree node is null before using =
it
> > - add example device tree nodes used in parse_mem_regions and tcm
> parsing
> > - add comment for vring id node length
> > - add check for string length so that vring id is at least min length
> > - move tcm nodes from reserved mem to instead own device tree nodes
> >    and only use them if enabled in device tree
> > - add comment for explaining handling of rproc_elf_load_rsc_table
> > - remove obsolete check for "if (vqid < 0)" in zynqmp_r5_rproc_kick
> > - remove unused field mems in struct zynqmp_r5_pdata
> > - remove call to zynqmp_r5_mem_probe and the fn itself as tcm handling
> >   is done by zyqmp_r5_pm_request_tcm
> > - remove obsolete setting of dma_ops and parent device dma_mask
> > - remove obsolete use of of_dma_configure
> > - add comment for call to r5_set_mode fn
> > - make mbox usage optional and gracefully inform user via dev_dbg if no=
t
> >   present
> > - change var lockstep_mode from u32* to u32
> > ---
> >  drivers/remoteproc/Kconfig                |  10 +
> >  drivers/remoteproc/Makefile               |   1 +
> >  drivers/remoteproc/zynqmp_r5_remoteproc.c | 898
> ++++++++++++++++++++++
> >  3 files changed, 909 insertions(+)
> >  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index c4d1731295eb..dd9ed45654e0 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -249,6 +249,16 @@ config STM32_RPROC
> >
> >  	  This can be either built-in or a loadable module.
> >
> > +config ZYNQMP_R5_REMOTEPROC
> > +	tristate "ZynqMP_R5 remoteproc support"
> > +	depends on ARM64 && PM && ARCH_ZYNQMP
> > +	select RPMSG_VIRTIO
> > +	select MAILBOX
> > +	select ZYNQMP_IPI_MBOX
> > +	help
> > +	  Say y or m here to support ZynqMP R5 remote processors via the
> remote
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
> > index 000000000000..2fbcccfe538c
> > --- /dev/null
> > +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> > @@ -0,0 +1,898 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Zynq R5 Remote Processor driver
> > + *
> > + * Based on origin OMAP and Zynq Remote Processor driver
> > + *
> > + */
> > +
> > +#include <linux/firmware/xlnx-zynqmp.h>
>=20
> Compilation fails for me here, since there are typedefs used (e.g. u32)
> in xlnx-zynqmp.h that are missing. Likely was masked before due to
> include order.
>=20
> Seems like xlnx-zynqmp.h should include linux/types.h
>=20
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/mailbox/zynqmp-ipi-message.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/remoteproc.h>
> > +#include <linux/skbuff.h>
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
> > +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> > +	struct mbox_client tx_mc;
> > +	struct mbox_client rx_mc;
> > +	struct work_struct mbox_work;
> > +	struct sk_buff_head tx_mc_skbs;
> > +	struct device dev;
> > +	struct rproc *rproc;
> > +	struct mbox_chan *tx_chan;
> > +	struct mbox_chan *rx_chan;
> > +	u32 pnode_id;
> > +	bool is_r5_mode_set;
> > +};
> > +
> > +/**
> > + * table of RPUs
> > + */
> > +struct zynqmp_r5_pdata rpus[MAX_RPROCS];
> > +/**
> > + * RPU core configuration
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
> > +	ret =3D zynqmp_pm_get_rpu_mode(pdata->pnode_id, val);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get RPU oper mode.\n");
> > +		return ret;
> > +	}
> > +	if (val[0] =3D=3D expect) {
> > +		dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
>=20
> Can the zynqmp_pm_* functions be reworked to take the correct types from
> the caller's perspective? All of the casting in this function is rather
> distracting.
>=20
> 	enum rpu_oper_mode cur_rpu_mode;
>=20
> 	ret =3D zynqmp_pm_get_rpu_mode(pdata->pnode_id, &cur_rpu_mode);
> 	// ...
> 	if (cur_rpu_mode =3D=3D rpu_mode) {
> 		// ...
>=20
> would be easier on the eyes.
>=20
> > +	} else {
> > +		ret =3D zynqmp_pm_set_rpu_mode(pdata->pnode_id,
> > +					     expect, 0);
>=20
> Is the last argument ever used? Can it perhaps be removed?
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
> > +	ret =3D zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0);
>=20
> Same question about the last argument.
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
> > +	ret =3D zynqmp_pm_request_wake(pdata->pnode_id, 1,
> > +				     bootmem,
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
> > +	ret =3D zynqmp_pm_force_pwrdwn(pdata->pnode_id,
> > +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +	if (ret < 0) {
> > +		dev_err(&pdata->dev, "failed to shutdown R5.\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
> > +				     struct rproc_mem_entry *mem)
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
> > +
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
> > +		if (!node) {
> > +			dev_err(dev, "no memory-region specified\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		rmem =3D of_reserved_mem_lookup(node);
> > +		if (!rmem) {
> > +			dev_err(dev, "unable to acquire memory-region\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (strstr(node->name, "vdev0vring")) {
> > +			int vring_id;
> > +			char name[16];
> > +
> > +			/*
> > +			 * expecting form of "rpuXvdev0vringX as documented
> > +			 * in xilinx remoteproc device tree binding
> > +			 */
> > +			if (strlen(node->name) < 14) {
> > +				dev_err(dev, "%s has to be at least 14 chars",
> > +					node->name);
> > +				return -EINVAL;
> > +			}
> > +
> > +			/*
> > +			 * can be 1 of multiple vring IDs per IPC channel
> > +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
> > +			 */
> > +			vring_id =3D node->name[14] - '0';
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
> > +			/* Register DMA region */
> > +			int (*alloc)(struct rproc *r,
> > +				     struct rproc_mem_entry *rme);
> > +			int (*release)(struct rproc *r,
> > +				       struct rproc_mem_entry *rme);
> > +			char name[20];
> > +
> > +			if (strstr(node->name, "vdev0buffer")) {
> > +				alloc =3D NULL;
> > +				release =3D NULL;
> > +				strcpy(name, "vdev0buffer");
> > +			} else {
> > +				alloc =3D zynqmp_r5_rproc_mem_alloc;
> > +				release =3D zynqmp_r5_rproc_mem_release;
> > +				strcpy(name, node->name);
> > +			}
> > +
> > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > +						   (dma_addr_t)rmem->base,
> > +						   rmem->size, rmem->base,
> > +						   alloc, release, name);
> > +			if (!mem) {
> > +				dev_err(dev, "unable to initialize memory-
> region %s\n",
> > +					node->name);
> > +				return -ENOMEM;
> > +			}
> > +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
> > +				mem->dma);
> > +		}
> > +		rproc_add_carveout(rproc, mem);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* call Xilix Platform manager to request access to TCM bank */
> > +static int zyqmp_r5_pm_request_tcm(struct device_node *tcm_node,
> > +				   struct device *dev)
> > +{
> > +	u32 pnode_id;
> > +	int ret;
> > +
> > +	ret =3D of_property_read_u32(tcm_node, "pnode-id", &pnode_id);
> > +	if (ret) {
> > +		dev_err(dev, "Can't parse pnode-id property\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D zynqmp_pm_request_node(pnode_id,
> ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to request power node: %u\n",
> pnode_id);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Given tcm bank entry,
> > + * this callback will set device address for R5 running on TCM
> > + * and also setup virtual address for tcm bank remoteproc carveout
> > + */
> > +static int tcm_mem_alloc(struct rproc *rproc,
> > +			 struct rproc_mem_entry *mem)
> > +{
> > +	void *va;
> > +	struct device *dev =3D rproc->dev.parent;
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
> > +
> > +	va =3D devm_ioremap_wc(dev, mem->da, mem->len);
> > +	if (!va)
> > +		return -ENOMEM;
> > +	/* As R5 is 32 bit, wipe out extra high bits */
> > +	mem->da &=3D 0x000fffff;
> > +	/*
> > +	 * handle tcm banks 1 a and b (0xffe90000 and oxffeb0000)
> > +	 * As both of these the only common bit found not in tcm bank0 a or
> b
> > +	 * is at 0x80000 use this mask to suss it out
> > +	 */
> > +	if (mem->da & 0x80000)
> > +		/*
> > +		 * similar to wiping tcm banks 0a and 0b with just the
> > +		 * mask of 0x000fffff will translate to device addr's
> > +		 * at 0x0 and 0x20000, need to do more to further translate
> > +		 * tcm banks 1a and 1b at 0xffe90000 and oxffeb0000
> > +		 * respectively to 0x0 and 0x20000
> > +		 */
> > +		mem->da -=3D 0x90000;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Given R5 node in remoteproc instance,
> > + * allocate remoteproc carveout for TCM memory
> > + * needed for firmware to be loaded
> > + */
> > +static int parse_tcm_banks(struct rproc *rproc)
> > +{
> > +	int ret;
> > +	struct device_node *dt_node;
> > +	int tcm_bank_idx, tcm_bank_done;
> > +	char tcm_str[10];
> > +	struct resource rsc;
> > +	resource_size_t size;
> > +	struct rproc_mem_entry *mem;
> > +
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +	struct device *dev =3D &pdata->dev;
> > +
> > +	/* set start and stop for loop through tcm banks. */
> > +	if (rpu_mode =3D=3D PM_RPU_MODE_SPLIT) {
> > +		/*
> > +		 * In split mode, R50 can use TCM banks
> > +		 * 0a, 0b and R51 can use 1a, 1b
> > +		 *
> > +		 * indices relate to the power node id that will
> > +		 * then be translated by Xilinx Platform Manager
> > +		 */
> > +		tcm_bank_idx =3D (pdata->pnode_id =3D=3D 0x7) ? 0 : 2;
> > +		tcm_bank_done =3D tcm_bank_idx + 2;
> > +	} else {
> > +		/* if RPU in lockstep, all banks are available */
> > +		tcm_bank_idx =3D 0;
> > +		tcm_bank_done =3D tcm_bank_idx + 4;
> > +	}
> > +
> > +	/* process TCM bank nodes in device tree */
> > +	for (; tcm_bank_idx < tcm_bank_done ; tcm_bank_idx++) {
> > +		/* construct tcm bank name */
> > +		strcpy(tcm_str, "tcm_");
> > +		strcat(tcm_str, (tcm_bank_idx <=3D 0x10) ? "0" : "1");
>=20
> tcm_bank_idx <=3D 0x10? Seems like this should be tcm_bank_idx <=3D 1 ins=
tead...
>=20
> > +		strcat(tcm_str, (tcm_bank_idx & 0x1) ? "b" : "a");
>=20
> Instead of all this string manipulation at runtime, wouldn't a static
> table be more straightforward? e.g.
>=20
> 	static const char tcm_banks[] =3D {
> 	    "tcm_0a", "tcm_0b", "tcm_1a", "tcm_1b"
> 	};
>=20
> > +
> > +		dt_node =3D of_find_node_by_name(NULL, tcm_str);
>=20
> It seems strange to require specific node names, and perhaps
> contradicts: https://devicetree-
> specification.readthedocs.io/en/latest/devicetree-basics.html#generic-nam=
es-
> recommendation
>=20
> Should the names instead be specified at the reference using
> memory-region-names, as suggested in the reserved-memory binding?
>=20
> > +		if (dt_node && of_device_is_available(dt_node)) {
> > +			dev_dbg(dev, "node %s is available\n", tcm_str);
> > +
> > +			/* get address */
> > +			ret =3D of_address_to_resource(dt_node, 0, &rsc);
> > +			if (ret < 0) {
> > +				dev_err(dev, "fail to get rsc mem %s",
> > +					of_node_full_name(dt_node));
>=20
> %pOF can be used instead of of_node_full_name()
>=20
> > +				return -EINVAL;
> > +			}
> > +
> > +			/* request access */
> > +			zyqmp_r5_pm_request_tcm(dt_node, dev);
> > +
> > +			/* add carveout */
> > +			size =3D resource_size(&rsc);
> > +			mem =3D rproc_mem_entry_init(dev, NULL, rsc.start,
> > +						   (int)size, rsc.start,
> > +						   tcm_mem_alloc,
> > +						   zynqmp_r5_mem_release,
> > +						   rsc.name);
> > +			if (!mem)
> > +				return -ENOMEM;
> > +
> > +			rproc_add_carveout(rproc, mem);
> > +		} else {
> > +			dev_info(dev, "node %s is not available\n", tcm_str);
> > +		}
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
> > +	ret =3D parse_tcm_banks(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "parse_tcm_banks failed %x\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D parse_mem_regions(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D rproc_elf_load_rsc_table(rproc, fw);
> > +	if (ret =3D=3D -EINVAL) {
> > +		/*
> > +		 * resource table only required for IPC.
> > +		 * if not present, this is not necessarily an error;
> > +		 * for example, loading r5 hello world application
> > +		 * so simply inform user and keep going.
> > +		 */
> > +		dev_info(dev, "no resource table found.\n");
> > +		ret =3D 0;
> > +	}
> > +	return ret;
> > +}
> > +
> > +/* kick a firmware */
> > +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> > +{
> > +	struct sk_buff *skb;
> > +	unsigned int skb_len;
> > +	struct zynqmp_ipi_message *mb_msg;
> > +	int ret;
> > +
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > +
> > +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n",
> vqid);
> > +
> > +	skb_len =3D (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
> > +	skb =3D alloc_skb(skb_len, GFP_ATOMIC);
> > +	if (!skb) {
> > +		dev_err(dev,
> > +			"Failed to allocate skb to kick remote.\n");
> > +		return;
> > +	}
> > +	mb_msg =3D (struct zynqmp_ipi_message *)skb_put(skb, skb_len);
> > +	mb_msg->len =3D sizeof(vqid);
> > +	memcpy(mb_msg->data, &vqid, sizeof(vqid));
> > +	skb_queue_tail(&pdata->tx_mc_skbs, skb);
> > +	ret =3D mbox_send_message(pdata->tx_chan, mb_msg);
> > +	if (ret < 0) {
> > +		dev_warn(dev, "Failed to kick remote.\n");
> > +		skb_dequeue_tail(&pdata->tx_mc_skbs);
> > +		kfree_skb(skb);
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
> > +
> > +	/* Discard all SKBs if tx_mc_skbs is initialized */
> > +	if (&pdata->tx_mc_skbs.prev) {
> > +		while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> > +			skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> > +			kfree_skb(skb);
> > +		}
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
> > +
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
> > +	int ret;
> > +
> > +	/* Create device for ZynqMP R5 device */
> > +	dev->parent =3D &pdev->dev;
> > +	dev->release =3D zynqmp_r5_release;
> > +	dev->of_node =3D node;
> > +	dev_set_name(dev, "%s", of_node_full_name(node));
>=20
> %pOF can be used instead of of_node_full_name()
>=20
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
> > +	pdata->rproc =3D rproc;
> > +	rproc->priv =3D pdata;
> > +
> > +	/* Set up DMA mask */
> > +	ret =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Get R5 power domain node */
> > +	ret =3D of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get power node id.\n");
> > +		goto error;
> > +	}
> > +
> > +	/* TODO Check if R5 is running */
> > +
> > +	/*
> > +	 * Set up R5 if not already setup
> > +	 * This check is needed as there are cases where
> > +	 * a user might repeatedly do modprobe
> > +	 * and modprobe -r. In this case, upon a
> > +	 * subsequent load, this check is needed.
> > +	 */
> > +	ret =3D pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set R5 operation mode.\n");
> > +		return ret;
> > +	}
> > +
> > +	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
> > +		dev_dbg(dev, "no mailboxes.\n");
> > +	} else {
> > +		ret =3D zynqmp_r5_setup_mbox(pdata, node);
> > +		if (ret < 0)
> > +			goto error;
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
> > +	u32 lockstep_mode;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *nc;
> > +	struct zynqmp_r5_pdata *pdata;
> > +
> > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, pdata);
> > +
> > +	of_property_read_u32(dev->of_node, "lockstep-mode",
> &lockstep_mode);
> > +
> > +	if (!lockstep_mode) {
> > +		rpu_mode =3D PM_RPU_MODE_SPLIT;
> > +	} else if (lockstep_mode =3D=3D 1) {
> > +		rpu_mode =3D PM_RPU_MODE_LOCKSTEP;
> > +	} else {
> > +		dev_err(dev,
> > +			"Invalid lockstep-mode mode provided - %x %d\n",
> > +			lockstep_mode, rpu_mode);
> > +		return -EINVAL;
> > +	}
> > +	dev_dbg(dev, "RPU configuration: %s\r\n",
>=20
> \n should be sufficient
>=20
> > +		lockstep_mode ? "lockstep" : "split");
> > +
> > +	for_each_available_child_of_node(dev->of_node, nc) {
> > +		ret =3D zynqmp_r5_probe(&rpus[i], pdev, nc);
> > +		if (ret) {
> > +			dev_err(dev, "failed to probe rpu %s.\n",
> > +				of_node_full_name(nc));
>=20
> %pOF can be used instead of of_node_full_name()
>=20
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
> > +MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
>=20
>=20
> Cheers,
>  Michael

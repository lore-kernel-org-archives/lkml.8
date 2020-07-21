Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A047620714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hhqwOupN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGUBYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:24:16 -0400
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:28934
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgGUBYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMA/SAShlcxl6uiGD19fZPaU2H10QImyBWD983+FeS05PsSWxJrwMCh2h20dLL098vg7gvtgAVj2nDp3C0ps3rv6JfIFCtQi+KFxpCFGbbjhVB82Kq1KwUTlSTJNLo+pcAIrLBcUzlHZUds51JhnM6BAt5IjEl2qgi76iQkLyrsYyT8zB3OoPi2ZZz2gLx5nK/RuBhCNdLkf8M2q5WbCoo4xv36uEDaW0e6vU7kWPiQ8JlzXKuyOx+0CWDj+O2TnqXKPC+JL94/Gw/kLQyV5XoxywFhANoj/BrplWpsqj+er6Dv0z+8vvgMl8LKLmMBiE8uiRQUWZZGMXE1EA5iNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKkC2QYz8z4hnSYOO9D4rXOOIRvnIfaUvI1nSkSowmk=;
 b=DyjHm+pitGbIgqwGgQFatdafZMtNdF68qZ43XNu1l8a7AGgCOjiv5tnB6x6qvGFNNxrw1Z3355WXZZxFuq8oaTciz7i+7Rm5MJI6ZMajhH+afoLl7QYJ+bhbyv9OYvXwysjDK8X7QJuafx5kqRQGixrFYmXWUx9q48MYhMK//y6PSGWExr74zLv4T1E3eRUpBtw/15lD37UhVTUc/yk920lzBOA4j7iV5wrhoj9aTob3Xyz/S3RQqe8VfIPwnDayTrV3MIjIYtOYRop4UBZB3aRRCBFZBT9msfKAi+iTc+WZOk9hmofELitYOMTq5xs5HZA3fYB2wiuKV9z1t/fbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKkC2QYz8z4hnSYOO9D4rXOOIRvnIfaUvI1nSkSowmk=;
 b=hhqwOupNGzbM2Mu2XT99wNg54Tv3W42JXiBbLdubyI5kWfYVjaiHLiSDkQF8W2FKjyTzGiBmGezU/2vjgmvXlL8vabTrGStym3dAiAd1IiYucZCYs1ULRoYQD6vvLkwpgMhupRbubl9lVthH577+8GXDmy3VY6FrC5uwmUB8R8g=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3128.eurprd04.prod.outlook.com (2603:10a6:6:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 21 Jul
 2020 01:24:08 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 01:24:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH 1/7] firmware: imx: scu-rm: Add Resource Management APIs
Thread-Topic: [PATCH 1/7] firmware: imx: scu-rm: Add Resource Management APIs
Thread-Index: AQHWXnUJI44NmvM5HEauy2uyJtPrIqkRPiZQ
Date:   Tue, 21 Jul 2020 01:24:08 +0000
Message-ID: <DB6PR0402MB27605C7B70DCB03EDE3BF6A588780@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595235977-106241-2-git-send-email-franck.lenormand@oss.nxp.com>
In-Reply-To: <1595235977-106241-2-git-send-email-franck.lenormand@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b70fc30-e790-4670-e98b-08d82d14c401
x-ms-traffictypediagnostic: DB6PR04MB3128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB312835D85FCD45F96C65923888780@DB6PR04MB3128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +bHz/R33WemI6OCgVH8hk8BSv7qz+bI6qm7eLAzqQXGXMiIcLM8c4Q1WQbDCfIxGW3YF4wGN6SyspL3tg3vq49SHOe22mUj9ghBU93+AouiHeIWgnp5y8QJyfS9+vmGGKcRSTSczm/hjzz08GtTeCawQVpvQ6ookZvnIFPNWxu6/+mIOCdQIq/4QNX/6nLdmcFIRmNO0+gzTc4xrxijN/aFvfp0DCmkZ/oKaACK/6brN0KZYf7sk5p1v/EglM4wKD+jC6gK5WqB9H65O6uJKUv2fYZM6PaJw7CDEeHLB9rwfo12LPllz5SilL6UeG7eY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(55016002)(186003)(26005)(9686003)(52536014)(83380400001)(110136005)(316002)(71200400001)(478600001)(5660300002)(2906002)(8936002)(54906003)(6506007)(33656002)(8676002)(7696005)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(86362001)(4326008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: In8qN4SBPG+FmoeB+o7N4Rg+T6Olr1cMhwJZgKPeBxUaPQ6NbWO2VcN18Or28ltLIhbnWp+3SECHCicsYhrYe6/YH2Nr89Cyp6k86hjcasVPPuU0q3EtGVUdj0wzfkzNpoSdzl0vDJ/u7sa59xm3fgkS0J+3dhT9cSyApoVenr6uP88y45sBTCnhaMu2PZS6SNqmy8ytUL4Blr4M8UPRHhgR6I5Xi3a//uEJbYplSTxglj8wWliQIObKwfEV6RgivzTbUe6yIQDrLqzqH5bU4TgMj7Hp5QOOuzpk4vZJU7/UX0QGd7cyqJzrtCpNHIK0H3tQmQPkH/7jY0QKa1x9HZ2nXNtPndeFJ6ugV+wrejDTXdp9WMmlKNpQmMnhbnqBai7/TpO+qYjzFswUCKycoDyYl8xDDyN9ggI2Xgm6ltLc4kWQMjIl9kpTkQhwK8KK/GPEjITCEaNSp/KDU8NtO2GEEjNBdg1bSTBhwPBIGyz1UUFrvvMiiyiFblripjc0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b70fc30-e790-4670-e98b-08d82d14c401
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 01:24:08.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1VYPi8d/mPE3MHtCXjPmgZypBuXyK7BjVmdZxWE9llkLt+7XwjTJCQoEz7ddqPHKqHNp7U3G2gDyOu6KhkkNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Franck,

> Subject: [PATCH 1/7] firmware: imx: scu-rm: Add Resource Management APIs

Are you using an old base? This was already in tree.

Regards,
Peng.

>=20
> From: Franck LENORMAND <franck.lenormand@oss.nxp.com>
>=20
> This patch adds the imx_sc_rm_is_resource_owned indicating if a specific
> resource is owned by the caller.
>=20
> Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> ---
>  drivers/firmware/imx/Makefile       |  2 +-
>  drivers/firmware/imx/rm.c           | 44 +++++++++++++++++++++++
>  include/linux/firmware/imx/sci.h    |  1 +
>  include/linux/firmware/imx/svc/rm.h | 69
> +++++++++++++++++++++++++++++++++++++
>  4 files changed, 115 insertions(+), 1 deletion(-)  create mode 100644
> drivers/firmware/imx/rm.c  create mode 100644
> include/linux/firmware/imx/svc/rm.h
>=20
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefil=
e
> index 08bc9dd..17ea361 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+=3D imx-dsp.o
> -obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-irq.o
> +obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-irq.o rm.o
>  obj-$(CONFIG_IMX_SCU_PD)	+=3D scu-pd.o
> diff --git a/drivers/firmware/imx/rm.c b/drivers/firmware/imx/rm.c new fi=
le
> mode 100644 index 00000000..a397c6b
> --- /dev/null
> +++ b/drivers/firmware/imx/rm.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017-2020 NXP
> + *
> + * File containing client-side RPC functions for the RM service. These
> + * functions are ported to clients that communicate to the SC.
> + */
> +
> +#include <linux/firmware/imx/svc/rm.h>
> +
> +struct imx_sc_msg_rm_rsrc_owned {
> +	struct imx_sc_rpc_msg hdr;
> +	u16 resource;
> +} __packed __aligned(4);
> +
> +/**
> + * imx_sc_rm_is_resource_owned() - Checks @resource is owned by current
> + * partition or not
> + *
> + * @ipc: IPC handle
> + * @resource: resource the control is associated with
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
> +{
> +	struct imx_sc_msg_rm_rsrc_owned msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +
> +	hdr->ver =3D IMX_SC_RPC_VERSION;
> +	hdr->svc =3D IMX_SC_RPC_SVC_RM;
> +	hdr->func =3D IMX_SC_RM_FUNC_IS_RESOURCE_OWNED;
> +	hdr->size =3D 2;
> +
> +	msg.resource =3D resource;
> +
> +	imx_scu_call_rpc(ipc, &msg, true);
> +
> +	return hdr->func;
> +}
> +EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
> diff --git a/include/linux/firmware/imx/sci.h
> b/include/linux/firmware/imx/sci.h
> index 3fa418a..3c459f5 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -14,6 +14,7 @@
>=20
>  #include <linux/firmware/imx/svc/misc.h>  #include
> <linux/firmware/imx/svc/pm.h>
> +#include <linux/firmware/imx/svc/rm.h>
>=20
>  int imx_scu_enable_general_irq_channel(struct device *dev);  int
> imx_scu_irq_register_notifier(struct notifier_block *nb); diff --git
> a/include/linux/firmware/imx/svc/rm.h
> b/include/linux/firmware/imx/svc/rm.h
> new file mode 100644
> index 00000000..9924216
> --- /dev/null
> +++ b/include/linux/firmware/imx/svc/rm.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017-2020 NXP
> + *
> + * Header file containing the public API for the System Controller (SC)
> + * Power Management (PM) function. This includes functions for power
> +state
> + * control, clock control, reset control, and wake-up event control.
> + *
> + * RM_SVC (SVC) Resource Management Service
> + *
> + * Module for the Resource Management (RM) service.
> + */
> +
> +#ifndef _SC_RM_API_H
> +#define _SC_RM_API_H
> +
> +#include <linux/firmware/imx/sci.h>
> +
> +/*
> + * This type is used to indicate RPC RM function calls.
> + */
> +enum imx_sc_rm_func {
> +	IMX_SC_RM_FUNC_UNKNOWN =3D 0,
> +	IMX_SC_RM_FUNC_PARTITION_ALLOC =3D 1,
> +	IMX_SC_RM_FUNC_SET_CONFIDENTIAL =3D 31,
> +	IMX_SC_RM_FUNC_PARTITION_FREE =3D 2,
> +	IMX_SC_RM_FUNC_GET_DID =3D 26,
> +	IMX_SC_RM_FUNC_PARTITION_STATIC =3D 3,
> +	IMX_SC_RM_FUNC_PARTITION_LOCK =3D 4,
> +	IMX_SC_RM_FUNC_GET_PARTITION =3D 5,
> +	IMX_SC_RM_FUNC_SET_PARENT =3D 6,
> +	IMX_SC_RM_FUNC_MOVE_ALL =3D 7,
> +	IMX_SC_RM_FUNC_ASSIGN_RESOURCE =3D 8,
> +	IMX_SC_RM_FUNC_SET_RESOURCE_MOVABLE =3D 9,
> +	IMX_SC_RM_FUNC_SET_SUBSYS_RSRC_MOVABLE =3D 28,
> +	IMX_SC_RM_FUNC_SET_MASTER_ATTRIBUTES =3D 10,
> +	IMX_SC_RM_FUNC_SET_MASTER_SID =3D 11,
> +	IMX_SC_RM_FUNC_SET_PERIPHERAL_PERMISSIONS =3D 12,
> +	IMX_SC_RM_FUNC_IS_RESOURCE_OWNED =3D 13,
> +	IMX_SC_RM_FUNC_GET_RESOURCE_OWNER =3D 33,
> +	IMX_SC_RM_FUNC_IS_RESOURCE_MASTER =3D 14,
> +	IMX_SC_RM_FUNC_IS_RESOURCE_PERIPHERAL =3D 15,
> +	IMX_SC_RM_FUNC_GET_RESOURCE_INFO =3D 16,
> +	IMX_SC_RM_FUNC_MEMREG_ALLOC =3D 17,
> +	IMX_SC_RM_FUNC_MEMREG_SPLIT =3D 29,
> +	IMX_SC_RM_FUNC_MEMREG_FRAG =3D 32,
> +	IMX_SC_RM_FUNC_MEMREG_FREE =3D 18,
> +	IMX_SC_RM_FUNC_FIND_MEMREG =3D 30,
> +	IMX_SC_RM_FUNC_ASSIGN_MEMREG =3D 19,
> +	IMX_SC_RM_FUNC_SET_MEMREG_PERMISSIONS =3D 20,
> +	IMX_SC_RM_FUNC_IS_MEMREG_OWNED =3D 21,
> +	IMX_SC_RM_FUNC_GET_MEMREG_INFO =3D 22,
> +	IMX_SC_RM_FUNC_ASSIGN_PAD =3D 23,
> +	IMX_SC_RM_FUNC_SET_PAD_MOVABLE =3D 24,
> +	IMX_SC_RM_FUNC_IS_PAD_OWNED =3D 25,
> +	IMX_SC_RM_FUNC_DUMP =3D 27,
> +};
> +
> +#if IS_ENABLED(CONFIG_IMX_SCU)
> +bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource);
> +#else static inline bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc
> +*ipc, u16 resource) {
> +	return true;
> +}
> +#endif
> +#endif
> --
> 2.7.4


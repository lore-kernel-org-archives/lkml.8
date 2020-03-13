Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFEDC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41F3206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mN0fs1Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCMHuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:50:06 -0400
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:46368
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgCMHuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNveq3kR5ZjRbn1tNv1s8GHMry8tRxf7Wm/3iASwqDLuluXcdUSfCMNeewH5tnP1Ag90UpSNR5p43I8rAXUZQ8c46odKQTQ812u2sIbMIh/MhR596ER8j+R+j9n+8uzyoHcGcieS1AP/AZSsfq0LtOkqFPFOMJH/Cz+91IdbKjcuAYYgpRrEigbroeWM1acWZFjOQHqQ9I8OJDPTf6+uGwmDN44KFSRcj7oQ7m3Tv/3kUG6u3GQofH9AzfwtWkWgCuaKQ00ouzPL3tIhzsgK7WCChAC+PNqkh171v+/c1xK39ivovCYILGJKhfUNzaFFn/559Wg7RWB5x4YnCU2eXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYRjk7xIK0yv1tj8YXANcUvjtHeYdp5QImFTkzKPn/Q=;
 b=YRzD1Pdu2rTpAsF5hgNgjHt3VO3UPtEOQSAagISJOJtF2PPjj1tfSRB6U09RZCQBtf9UfbMmtYAIyFWcb/Lc6LSlpJQIfi/7gcp6B9o7x0diAfV+nrd26ps9blaSUnx/1l1gcMlSbhMpycoxPKXE6V9n/piC7ZefSOsVXNpWNQTz5VelcBhyNKH488bonJt6uWZYvFl/HekMWG24o+wmePTZYxJ2nKQIdxulRUd6lIz/Ilq2/ZR7yY4jk8QVyasLcyMNbSTYzViAxOYi2gXqF1kqC2dhpS6hBn4EGCRGmzpPMbdO8KplrexkHEKqkPUfeOzV2p5rADdjdXdJT9hPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYRjk7xIK0yv1tj8YXANcUvjtHeYdp5QImFTkzKPn/Q=;
 b=mN0fs1VjJiqn/SgB0o4q87cKUkZaxfPQvMsG7WqErj5cWGB4NT0AXzERGthZXdoZOkKdCwauX0s+9HU8DeY9iIQgqDweQVPkyIl0EmUFCKqnxeagBozyYyF24+y1CMHH4bgfrXOTz//AjrzkQmZjrkKpNz5H27sINb3XTChlimE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6002.eurprd04.prod.outlook.com (20.178.114.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20; Fri, 13 Mar 2020 07:47:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 07:47:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [RFC 04/11] clk: imx: Add gate shared for i.MX8MP audiomix
Thread-Topic: [RFC 04/11] clk: imx: Add gate shared for i.MX8MP audiomix
Thread-Index: AQHV8TqlpdEwDmBs0U+iFgh60sh+aKhGNI2w
Date:   Fri, 13 Mar 2020 07:47:26 +0000
Message-ID: <AM0PR04MB44817B0DBC695577617CFC8C88FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
 <1583226206-19758-5-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1583226206-19758-5-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e604eb9-e424-40cd-2768-08d7c722c646
x-ms-traffictypediagnostic: AM0PR04MB6002:|AM0PR04MB6002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6002F3097CA08E1CB8A5F58188FA0@AM0PR04MB6002.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(76116006)(66556008)(66446008)(9686003)(7696005)(66476007)(66946007)(86362001)(64756008)(55016002)(33656002)(71200400001)(478600001)(4326008)(316002)(5660300002)(110136005)(54906003)(6506007)(6636002)(44832011)(52536014)(8676002)(81166006)(8936002)(26005)(2906002)(81156014)(186003)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6002;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaG+pDZAMEcQ8D1HFrMIYh+B6+fobrcmV6gnMcpur9MCZWEdQFY6bVPMd4lPkvnTnkswChKTiT3hmCX5KCNWef3AqEllrZ/wWsqp3sEzivYN1bLayJFVf+ixMR2xl5CTvXC3ft95R/hwmtg8g6EI/RprasVLroAHPpLzQRwGeEx1N2sJTDfRZLMsxRpB5Hx6Ixt1GPn7F0yoQfWT1qy7tNSKYRU++479/Y2WVyB0gOZes/lHYF+d87ltQMsmdioERtWGHPaX4tFBbREWuJw75WyjDfk091b6O6H7WQ7MUCMtLdE1NkGU12XoisaU6OJxivs4Qw/GgqcHw95wLR8RHxLUF0M29Mv0aWlXGYfRfutYKl6yr4P9VHbxd+8tjPQY8U2MsTgFARKPjEjjzsyM1T6qasEUwuKg9RFfMrICm7MA073Qkx665IQLLHoOXTgipYDCrBeeoA8bAhp2Tae8GlYRJb9z8qJ4eq0/29tsjpWAJQp30rDECSj3qoMufPHO
x-ms-exchange-antispam-messagedata: WTqjGsi0eKl22pr6otW+uoq8f0WnXcwL4CvNJrRYvswdFxmXn6pon10eyJNTS6ilxWRsKC2kldZy3hnktVMiFKZFNRce78H+8ZkIqWjmqCKWXyX0kIIuA1jc8zPZpmv7KnH/AE/89OjxBLsM+RErJw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e604eb9-e424-40cd-2768-08d7c722c646
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 07:47:26.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYKC/OfQ7LkFDv+Jl7+wwnunDKuKAUSFn3go7gR1jmFLLCi3/BzA5SXqd+qLgIIdg47rXZ2EP1+H7ZB1IjQyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [RFC 04/11] clk: imx: Add gate shared for i.MX8MP audiomix
>=20
> The newer i.MX platform use some gates that have a shared control bit
> between them.

Could the existing clk_hw_register_gate2 handle your case?

Thanks,
Peng.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile          |   2 +-
>  drivers/clk/imx/clk-gate-shared.c | 111
> ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h             |   4 ++
>  3 files changed, 116 insertions(+), 1 deletion(-)  create mode 100644
> drivers/clk/imx/clk-gate-shared.c
>=20
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> 928f874c..799a8ef 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -27,7 +27,7 @@ obj-$(CONFIG_MXC_CLK_SCU) +=3D \
>=20
>  obj-$(CONFIG_CLK_IMX8MM) +=3D clk-imx8mm.o
>  obj-$(CONFIG_CLK_IMX8MN) +=3D clk-imx8mn.o
> -obj-$(CONFIG_CLK_IMX8MP) +=3D clk-imx8mp.o
> +obj-$(CONFIG_CLK_IMX8MP) +=3D clk-imx8mp.o clk-gate-shared.o
>  obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
>  obj-$(CONFIG_CLK_IMX8QXP) +=3D clk-imx8qxp.o clk-imx8qxp-lpcg.o
>=20
> diff --git a/drivers/clk/imx/clk-gate-shared.c
> b/drivers/clk/imx/clk-gate-shared.c
> new file mode 100644
> index 00000000..961a0e3
> --- /dev/null
> +++ b/drivers/clk/imx/clk-gate-shared.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include "clk.h"
> +
> +/**
> + * struct clk_gate_shared - i.MX specific gate clock having the gate
> +flag
> + * shared with other gate clocks
> + */
> +struct clk_gate_shared {
> +	struct clk_gate	gate;
> +	spinlock_t	*lock;
> +	unsigned int	*share_count;
> +};
> +
> +static int clk_gate_shared_enable(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	struct clk_gate_shared *shgate =3D container_of(gate,
> +					struct clk_gate_shared, gate);
> +	unsigned long flags =3D 0;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(shgate->lock, flags);
> +
> +	if (shgate->share_count && (*shgate->share_count)++ > 0)
> +		goto out;
> +
> +	ret =3D clk_gate_ops.enable(hw);
> +out:
> +	spin_unlock_irqrestore(shgate->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void clk_gate_shared_disable(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	struct clk_gate_shared *shgate =3D container_of(gate,
> +					struct clk_gate_shared, gate);
> +	unsigned long flags =3D 0;
> +
> +	spin_lock_irqsave(shgate->lock, flags);
> +
> +	if (shgate->share_count) {
> +		if (WARN_ON(*shgate->share_count =3D=3D 0))
> +			goto out;
> +		else if (--(*shgate->share_count) > 0)
> +			goto out;
> +	}
> +
> +	clk_gate_ops.disable(hw);
> +out:
> +	spin_unlock_irqrestore(shgate->lock, flags); }
> +
> +static int clk_gate_shared_is_enabled(struct clk_hw *hw) {
> +	return clk_gate_ops.is_enabled(hw);
> +}
> +
> +static const struct clk_ops clk_gate_shared_ops =3D {
> +	.enable =3D clk_gate_shared_enable,
> +	.disable =3D clk_gate_shared_disable,
> +	.is_enabled =3D clk_gate_shared_is_enabled, };
> +
> +struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev, const char
> *name,
> +				const char *parent, void __iomem *reg,
> +				u8 shift, unsigned int *share_count) {
> +	struct clk_gate_shared *shgate;
> +	struct clk_gate *gate;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	shgate =3D kzalloc(sizeof(*shgate), GFP_KERNEL);
> +	if (!shgate)
> +		return ERR_PTR(-ENOMEM);
> +	gate =3D &shgate->gate;
> +
> +	init.name =3D name;
> +	init.ops =3D &clk_gate_shared_ops;
> +	init.flags =3D CLK_OPS_PARENT_ENABLE;
> +	init.parent_names =3D parent ? &parent : NULL;
> +	init.num_parents =3D parent ? 1 : 0;
> +
> +	gate->reg =3D reg;
> +	gate->bit_idx =3D shift;
> +	gate->lock =3D NULL;
> +	gate->hw.init =3D &init;
> +	shgate->lock =3D &imx_ccm_lock;
> +	shgate->share_count =3D share_count;
> +
> +	hw =3D &gate->hw;
> +
> +	ret =3D clk_hw_register(NULL, hw);
> +	if (ret) {
> +		kfree(shgate);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> f074dd8..51d6c26 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -151,6 +151,10 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char
> *name,
>  				void __iomem *base,
>  				unsigned long flags);
>=20
> +struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev, const char
> *name,
> +				const char *parent, void __iomem *reg,
> +				u8 shift, unsigned int *share_count);
> +
>  enum imx_pllv3_type {
>  	IMX_PLLV3_GENERIC,
>  	IMX_PLLV3_SYS,
> --
> 2.7.4


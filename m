Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4506C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7975420727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sx8hF3gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgCKBQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:16:54 -0400
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:17317
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbgCKBQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITyQ9tVlluEDRAtMTFHTpLMtoAFnnrkL/4fzzyvICh39A/lG5Qs81kwcOP56sQiBP9h2jaGAhAsYhHZ4YM9q5xv0XgZIYKAsuRn5B+ePTx2ehcpyLQMzkq2218cZKMgcpw2dvk3t0WcxX/BTmvaD/T1EAhKxpEcAVHAOg5xIhxTSCjTkiAKRLI57wiG0frqIpCzbnKaTaRlBJhbbL+6/Qumzkvk0L5pYb6rCY4iAamZW4A+8o/Ela1FJ+biWraBEVQY15RKdQaO8Xx+IS7sA4Qq6mYxTBNvbZs/EGg3e5p216L2WIePh/UPqcZOGMxJ4kbxQsDpwZaDLGFySciPS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5IM5laMUx6UEfgtyX+lEgJjoVL4dTPd2vlFfmaTbYk=;
 b=bVWiVVvF3HJVxVrXR4ZT5lWXOdXeX99vSF1gymCBoWUUxjD1fe/SEPEuSNTT/C9cmiFF3geU21un4uk49ojngt325q9mjxLXUUhn4D+pmPenql52/E8h6aBk9TvwyrDpeyCAGPLmT/Ll5V64VkXcpIO06CfyBQAlwNvnChGRaeO8yuqWTUQSe9O/enmjsKaIM3dEB8vgyeVf19e+UkRjOGoQVN8IWzK0H357AN6Ba1QKNBlNwklCvQL6FtFHFrpKEPE4vfGk6YGJn2Msdw3eTBH3Ukp4W+gPKNelmk0v3Vw7PkyNZ61SHBDwfsTnjOitPbsRM2FN0tT/Sef8a/0fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5IM5laMUx6UEfgtyX+lEgJjoVL4dTPd2vlFfmaTbYk=;
 b=sx8hF3gXlZ/mTNi4KAsLNdwdsfoN6fWCMB+QHN9bYwRhtJpI0BtBGFMfTzSR1mA8dfRSNr5tFcwnYEABc3QPz7RwXijs2Z+TtkxjxR19+kREr7wxnDn4iUN97TyNxsOXweBroyas9ZWp+h6Tk6jaRkGVe3sJx5oXiN9DXQRb2tU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4594.eurprd04.prod.outlook.com (52.135.149.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Wed, 11 Mar 2020 01:16:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 01:16:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: [PATCH RESEND v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Topic: [PATCH RESEND v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Index: AQHV5w6XE6+JZJgh0E2+u/m5BMk3kqhCtvYg
Date:   Wed, 11 Mar 2020 01:16:45 +0000
Message-ID: <AM0PR04MB4481CD25DF8464085BBF780788FC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
 <1582107429-21123-2-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023009FE97679C01A80C866EEFF0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023009FE97679C01A80C866EEFF0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [222.93.164.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16107507-dd00-4a13-08b7-08d7c559ddd3
x-ms-traffictypediagnostic: AM0PR04MB4594:|AM0PR04MB4594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4594813234FB0141FB2D126588FC0@AM0PR04MB4594.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(6636002)(186003)(76116006)(6506007)(53546011)(33656002)(64756008)(66556008)(66476007)(66446008)(71200400001)(7696005)(9686003)(4326008)(55016002)(86362001)(45080400002)(26005)(66946007)(478600001)(110136005)(54906003)(5660300002)(316002)(2906002)(52536014)(8676002)(44832011)(8936002)(81166006)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4594;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8enE2oOj8Fp49Tzmcc+QeWGaVBlnwFAVcr9uu4QZ3D7VcGCaWPHvKKIwH3ixGwXS76zZVa3XritHT1mMcYmgbAKWa/aOHXkw5ZvTr0YFnhKx54htp4wdVw6gMrT29JklMawmKwKDieu3e+D1dZA2CrX9P5Xt2FeujCH4HJbi2syBBjvdiIXnSCP+umYJ7v3ri4JpTFNQGzm0Qaso6/7KR6xpzmVhEt+hWO3hvBokfMmIpiVA32V4JhLiSsNVj9ZtHyaKS8oeA50d8bWqEdycbAiDTUVSdd+vQjMytNvZlEypeDA/CBS8xCgaS/CHIElROe0SqRsWLwS8j0JgsKu24fegYhyBLhPNCTizA1q00cuWQ1x+qIyITORH0UKxrZm0sdGMkTJ2Zv4GYMe/7nUDiIG0VSD0Arm+CpkYFPJpg2aUU4fIoiC7HbBlhdgf7KzM4tPtdFXr9NJx02nRuYyfj0c+Vy6xwvm1s6hGFOt1Psn3owvcN5PUFgSvZNZVQAw
x-ms-exchange-antispam-messagedata: gok4aohzvZfSdcEfwQ2fJepWoRRR4fjjKGd4NjGTKJU0+6GI4SVQkMEhi8vPFcqJL3zT2j1Gm2QlVFPEKlZ7VWYtT/oL/FEEF2hxD65iFsIUUCivVbpE2Bx1+M3wlcALDYxM8wUR3O2iS1j3WpVqtg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16107507-dd00-4a13-08b7-08d7c559ddd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 01:16:45.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBLix9kvYCF+X+nQ9uQ3xeaWyWP0IM0i1m7DrgVM7/MIZJp3JPAhYmZVq7TAAlP3/MoBHU1rpEI8tf7EccW8vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4594
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH RESEND v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
>=20
> On 19.02.2020 12:23, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
> > signoff timing is 1Ghz, however the A53 core which sources from CCM
> > root could run above 1GHz which violates the CCM.
> >
> > There is a CORE_SEL slice before A53 core, we need to configure the
> > CORE_SEL slice source from ARM PLL, not A53 CCM clk root.
> >
> > The A53 CCM clk root should only be used when need to change ARM PLL
> > frequency.
> >
> > Add arm_a53_core clk that could source from arm_a53_div and
> arm_pll_out.
> > Configure a53 ccm root sources from 800MHz sys pll Configure a53 core
> > sources from arm_pll_out Mark arm_a53_core as critical clock
> >
> > +	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_SRC],
> hws[IMX8MQ_SYS1_PLL_800M]);
> > +	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_CORE],
> > +hws[IMX8MQ_ARM_PLL_OUT]);
>=20
> This triggers lockdep warnings:
>=20
> [    2.041743] ------------[ cut here ]------------
>=20
> [    2.043531] WARNING: CPU: 2 PID: 1 at drivers/clk/clk.c:2480
> clk_core_set_parent_nolock+0x1d4/0x508
> [    2.052584] Modules linked in:
>=20
> [    2.055642] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> 5.6.0-rc4-next-20200306-00027-g6b7e51d87f22 #225
> [    2.064966] Hardware name: NXP i.MX8MQ EVK (DT)
>=20
> [    2.069504] pstate: 60000005 (nZCv daif -PAN -UAO)
>=20
> [    2.074298] pc : clk_core_set_parent_nolock+0x1d4/0x508
>=20
> [    2.079529] lr : clk_core_set_parent_nolock+0x1d0/0x508
>=20
>=20
> [    2.084759] sp : ffff80001003b9b0
>=20
>=20
> [    2.088072] x29: ffff80001003b9b0 x28: ffff8000116e8218
>=20
>=20
> [    2.093392] x27: 0000000000004570 x26: ffff8000128745d0
>=20
>=20
> [    2.098711] x25: ffff0000b8422008 x24: ffff0000b8422008
>=20
> [    2.104030] x23: ffff80001104a518 x22: ffff80001104a508
>=20
> [    2.109349] x21: ffff800012260bf8 x20: ffff0000b84c9600
>=20
> [    2.114668] x19: ffff0000b84cbb00 x18: 0000000000004530
>=20
> [    2.119987] x17: 0000000000004520 x16: 0000000000004510
>=20
>=20
> [    2.125307] x15: 00000000000045d0 x14: 0000000000004500
>=20
>=20
> [    2.130626] x13: 00000000000044f0 x12: 00000000000044e0
>=20
> [    2.135945] x11: ffff8000116e6c68 x10: ffff8000117d7000
>=20
>=20
> [    2.141264] x9 : ffff80001067007c x8 : 0000000000000000
>=20
> [    2.146583] x7 : ffff800010671938 x6 : 0000000000000000
>=20
>=20
> [    2.151903] x5 : ffff800011633000 x4 : 0000000000000000
>=20
> [    2.157222] x3 : ffff80001003b804 x2 : 0000000000000000
>=20
>=20
> [    2.162541] x1 : ffff0000b9da0000 x0 : 0000000000000000
>=20
> [    2.167862] Call trace:
>=20
> [    2.170307]  clk_core_set_parent_nolock+0x1d4/0x508
>=20
> [    2.175190]  clk_hw_set_parent+0x1c/0x28
>=20
> [    2.179114]  imx8mq_clocks_probe+0x3538/0x3668
>=20
> [    2.183562]  platform_drv_probe+0x58/0xa8
>=20
> [    2.187573]  really_probe+0xe0/0x440
>=20
>=20
> [    2.191145]  driver_probe_device+0xe4/0x138
> [    2.195333]  device_driver_attach+0x74/0x80
>=20
>=20
> [    2.199519]  __driver_attach+0xa8/0x170
>=20
> [    2.203354]  bus_for_each_dev+0x74/0xc8
>=20
>=20
> [    2.207190]  driver_attach+0x28/0x30
>=20
> [    2.210767]  bus_add_driver+0x144/0x228
>=20
>=20
> [    2.214605]  driver_register+0x68/0x118
>=20
> [    2.218438]  __platform_driver_register+0x4c/0x58
>=20
>=20
> [    2.223151]  imx8mq_clk_driver_init+0x20/0x28
>=20
> [    2.227511]  do_one_initcall+0x88/0x410
>=20
> [    2.231348]  kernel_init_freeable+0x24c/0x2c0
>=20
> [    2.235706]  kernel_init+0x18/0x108
>=20
> [    2.239192]  ret_from_fork+0x10/0x18
>=20
> [    2.242768] irq event stamp: 130084
>=20
> [    2.246262] hardirqs last  enabled at (130083): [<ffff800010302e78>]
> __slab_alloc.isra.0+0x90/0xb8
> [    2.255241] hardirqs last disabled at (130084): [<ffff8000100a60b0>]
> do_debug_exception+0x168/0x254
> [    2.264308] softirqs last  enabled at (130070): [<ffff800010080e88>]
> __do_softirq+0x490/0x56c
> [    2.272856] softirqs last disabled at (130057): [<ffff800010101e1c>]
> irq_exit+0x11c/0x148
> [    2.281057] ---[ end trace 1fae73b5c77d8120 ]---
> [    2.285792] ------------[ cut here ]------------

I not met such warning when I test, you enabled lockdep debug?

>=20
> This happens because clk_hw_set_parent does not take the prepare_lock so
> a lockdep_assert_held fails. In practice it should be mostly harmless bec=
ause
> clk operations shouldn't happen while the SOC provider is probing.
>=20
> The issue can be worked around by doing the following instead:
>=20
> +       clk_set_parent(hws[IMX8MQ_CLK_A53_SRC]->clk,
> hws[IMX8MQ_SYS1_PLL_800M]->clk);
> +       clk_set_parent(hws[IMX8MQ_CLK_A53_CORE]->clk,
> hws[IMX8MQ_ARM_PLL_OUT]->clk);
>=20
> This implies reverting commit f95d58981f40 ("clk: imx: Include
> clk-provider.h instead of clk.h for i.MX8M SoCs clock driver") and
> somewhat rolls back the consumer/provider split.
>=20
> What would be a clean fix for this? It might make sense to add a new API.
>=20

How about moving this to dts? I'll give a try.

Thanks,
Peng.

> --
> Regards,
> Leonard

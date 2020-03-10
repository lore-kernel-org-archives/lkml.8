Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3107CC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C85208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FZ+B14Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgCJTiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:38:18 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:29374
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbgCJTiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:38:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpcIzjgKuhdydNkRjw7fku8viaEQRyUyCOheUysjbyt+7lnrpxG0TIlmRL2AIqWDXGXs4VN4SCmo3BAINRhvezJFHMIUDpe2/beChFfZ6CVVwZoWN/vSp83ZnRFQpuKHuu4peNNCKpKv82NTvmn64N6xja1ySsacOjC8HKSIRA8Oz8tK212tNcZERrcAOT4fsXjT1ym5CC59STxyc9yZtbh12X1MpTMwcA56/Hs8wSsqQhatpYFwNPMpT3H78hc5Xj3s1pWl1eF9hgt5RlcDeL2g2i4MS/sjcWnJnsnmgCYq8maal4cONqz5gRtqSWECYrJpLjv28T0p008gZQa0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAerinxFkch/A+CM7czdOLPguDDsxEF03nHkBMqXJXE=;
 b=VbCnUOkDYmADoG8hXq3ER35iamqkxoevsVa80fT/0LhVY1q0Wkx0Vsfrjlt58eggfsJIfgvtdMSPmkObHt8Kerc8DugNFkwwLlAxTJraiZLp6B89AHcRj4roip8+F+2/y6e2rxUXoZBoWf6luIwpLBocG6OBkFpPCIBH3+S3YyNX6mYvPqWtrhtnYA1G+YDh22BvfbETT0+K7BKhjgcxYwWLnuInw8l6/8QA299eh7HZVTOeYjBz+Fxd+Fa3JnQ7c+kjjXLGro6X+W3QxQgpPQF3/HPAHpFYI6EV+9rs6nUAv+I0BWUPRZl2dP0x/l+iJhl/puzixsT1ClonRZLEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAerinxFkch/A+CM7czdOLPguDDsxEF03nHkBMqXJXE=;
 b=FZ+B14IcLpKiw4y/BvrxCCSeswKlSU+WsU5+eOgw6EIu7fNklHnDfy9B0bt4oiaRqlNgAJ47bJzEDQ8EjOI2P8WDTbzgRRR/E+0n/nXL0Z2P5/O5m7x6UZKg6IKUHRPy2CINddFz97RaKxsBgjsQpY2OUgGgXDkWKdLkYUoVPLs=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6256.eurprd04.prod.outlook.com (20.179.25.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 19:38:13 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::7526:c459:a627:493]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::7526:c459:a627:493%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 19:38:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
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
Subject: Re: [PATCH RESEND v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Topic: [PATCH RESEND v3 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Index: AQHV5w6X9nT57Vl/6UmCiyRNcba+aw==
Date:   Tue, 10 Mar 2020 19:38:12 +0000
Message-ID: <VI1PR04MB7023009FE97679C01A80C866EEFF0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
 <1582107429-21123-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88539799-7a2c-436b-4a49-08d7c52a9236
x-ms-traffictypediagnostic: VI1PR04MB6256:|VI1PR04MB6256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6256AAC8350129C01ECBABA9EEFF0@VI1PR04MB6256.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(33656002)(76116006)(55016002)(66446008)(66556008)(64756008)(9686003)(8676002)(91956017)(7696005)(66946007)(66476007)(81166006)(186003)(5660300002)(478600001)(86362001)(26005)(8936002)(45080400002)(81156014)(4326008)(6506007)(44832011)(316002)(71200400001)(6636002)(54906003)(2906002)(53546011)(52536014)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6256;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7e0s1jcLQjAHQetIRCgxVOkKD1CQ/A9TroX5I4ihUfCkTtiAHvoaLqNPOTW0dDgwNL0UtyUKB2oSGI+tIlm9m4NexXFai7pH52ZgQsF6A5A7gJ4Yg2FZLAkgIl/KSefBJj9We5t9Fv9XIrjLu76mSUXHJ15lb3MlEiXRYelRCQmXdfn6deS7xST3KCuokk228v56IzXt82LntzrGEPcxBSqPI2GogjykN7bD+Do3fmA4Pay3IrtrN90d4TpfLRByF5PwzNB+lQYswwCpUCEY0vNOy3vznEdrFwZabu/zEkXtf73ke40hnaVUGJvRGMp9l1VnczQqBeiu4e7pBRiVioClpD1lE73rIOFnMVDcr8y82IP48nKBCXObiZDm15I5T7FaQKJkP3050wckwMbv533rfuJbdqhdFlNp6CsayQHHupqDqr73R5CaFM06E1aXecqJenaRUA19uy/oB2iLn4YmWzafU6HhOB7DAPBeYu28xtzIj8ue5SOOvD/zwEZr
x-ms-exchange-antispam-messagedata: G/rudQO4U2PzxAJZm03uHWm/QLYoEJuuGuyXkvsg4/viqXzCG1q/VdIjBG8vH5kp1BHjU21J1F6zeUDS/3iUb+HYUQctcyHuhxedw1ydZam1iN2U5DdaSqqX7xX5mjIdjVAUEffX4HIbAcjBa555Lw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88539799-7a2c-436b-4a49-08d7c52a9236
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 19:38:12.7220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwX/W2pY2KoWZIj0qhHuS0t0jFgdx3LnMNaoxUtmgcHJ8ZM0jsMAIaqsTKQ/fymbFYlY/du/Mk9iH+q61XtZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2020 12:23, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root=0A=
> signoff timing is 1Ghz, however the A53 core which sources from CCM=0A=
> root could run above 1GHz which violates the CCM.=0A=
> =0A=
> There is a CORE_SEL slice before A53 core, we need to configure the=0A=
> CORE_SEL slice source from ARM PLL, not A53 CCM clk root.=0A=
> =0A=
> The A53 CCM clk root should only be used when need to change ARM PLL=0A=
> frequency.=0A=
> =0A=
> Add arm_a53_core clk that could source from arm_a53_div and arm_pll_out.=
=0A=
> Configure a53 ccm root sources from 800MHz sys pll=0A=
> Configure a53 core sources from arm_pll_out=0A=
> Mark arm_a53_core as critical clock=0A=
> =0A=
> +	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_SRC], hws[IMX8MQ_SYS1_PLL_800M]);=
=0A=
> +	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_CORE], hws[IMX8MQ_ARM_PLL_OUT]);=
=0A=
=0A=
This triggers lockdep warnings:=0A=
=0A=
[    2.041743] ------------[ cut here ]------------ =0A=
=0A=
[    2.043531] WARNING: CPU: 2 PID: 1 at drivers/clk/clk.c:2480 =0A=
clk_core_set_parent_nolock+0x1d4/0x508=0A=
[    2.052584] Modules linked in: =0A=
=0A=
[    2.055642] CPU: 2 PID: 1 Comm: swapper/0 Not tainted =0A=
5.6.0-rc4-next-20200306-00027-g6b7e51d87f22 #225=0A=
[    2.064966] Hardware name: NXP i.MX8MQ EVK (DT) =0A=
=0A=
[    2.069504] pstate: 60000005 (nZCv daif -PAN -UAO) =0A=
=0A=
[    2.074298] pc : clk_core_set_parent_nolock+0x1d4/0x508 =0A=
=0A=
[    2.079529] lr : clk_core_set_parent_nolock+0x1d0/0x508 =0A=
 =0A=
=0A=
[    2.084759] sp : ffff80001003b9b0 =0A=
 =0A=
=0A=
[    2.088072] x29: ffff80001003b9b0 x28: ffff8000116e8218 =0A=
 =0A=
=0A=
[    2.093392] x27: 0000000000004570 x26: ffff8000128745d0 =0A=
 =0A=
=0A=
[    2.098711] x25: ffff0000b8422008 x24: ffff0000b8422008 =0A=
=0A=
[    2.104030] x23: ffff80001104a518 x22: ffff80001104a508 =0A=
=0A=
[    2.109349] x21: ffff800012260bf8 x20: ffff0000b84c9600 =0A=
=0A=
[    2.114668] x19: ffff0000b84cbb00 x18: 0000000000004530 =0A=
=0A=
[    2.119987] x17: 0000000000004520 x16: 0000000000004510 =0A=
 =0A=
=0A=
[    2.125307] x15: 00000000000045d0 x14: 0000000000004500 =0A=
 =0A=
=0A=
[    2.130626] x13: 00000000000044f0 x12: 00000000000044e0 =0A=
=0A=
[    2.135945] x11: ffff8000116e6c68 x10: ffff8000117d7000 =0A=
 =0A=
=0A=
[    2.141264] x9 : ffff80001067007c x8 : 0000000000000000 =0A=
=0A=
[    2.146583] x7 : ffff800010671938 x6 : 0000000000000000 =0A=
 =0A=
=0A=
[    2.151903] x5 : ffff800011633000 x4 : 0000000000000000 =0A=
=0A=
[    2.157222] x3 : ffff80001003b804 x2 : 0000000000000000 =0A=
 =0A=
=0A=
[    2.162541] x1 : ffff0000b9da0000 x0 : 0000000000000000 =0A=
=0A=
[    2.167862] Call trace: =0A=
=0A=
[    2.170307]  clk_core_set_parent_nolock+0x1d4/0x508 =0A=
=0A=
[    2.175190]  clk_hw_set_parent+0x1c/0x28 =0A=
=0A=
[    2.179114]  imx8mq_clocks_probe+0x3538/0x3668 =0A=
=0A=
[    2.183562]  platform_drv_probe+0x58/0xa8 =0A=
=0A=
[    2.187573]  really_probe+0xe0/0x440 =0A=
 =0A=
=0A=
[    2.191145]  driver_probe_device+0xe4/0x138=0A=
[    2.195333]  device_driver_attach+0x74/0x80 =0A=
 =0A=
=0A=
[    2.199519]  __driver_attach+0xa8/0x170 =0A=
=0A=
[    2.203354]  bus_for_each_dev+0x74/0xc8 =0A=
 =0A=
=0A=
[    2.207190]  driver_attach+0x28/0x30 =0A=
=0A=
[    2.210767]  bus_add_driver+0x144/0x228 =0A=
 =0A=
=0A=
[    2.214605]  driver_register+0x68/0x118 =0A=
=0A=
[    2.218438]  __platform_driver_register+0x4c/0x58 =0A=
 =0A=
=0A=
[    2.223151]  imx8mq_clk_driver_init+0x20/0x28 =0A=
=0A=
[    2.227511]  do_one_initcall+0x88/0x410 =0A=
=0A=
[    2.231348]  kernel_init_freeable+0x24c/0x2c0 =0A=
=0A=
[    2.235706]  kernel_init+0x18/0x108 =0A=
=0A=
[    2.239192]  ret_from_fork+0x10/0x18 =0A=
=0A=
[    2.242768] irq event stamp: 130084 =0A=
=0A=
[    2.246262] hardirqs last  enabled at (130083): [<ffff800010302e78>] =0A=
__slab_alloc.isra.0+0x90/0xb8=0A=
[    2.255241] hardirqs last disabled at (130084): [<ffff8000100a60b0>] =0A=
do_debug_exception+0x168/0x254=0A=
[    2.264308] softirqs last  enabled at (130070): [<ffff800010080e88>] =0A=
__do_softirq+0x490/0x56c=0A=
[    2.272856] softirqs last disabled at (130057): [<ffff800010101e1c>] =0A=
irq_exit+0x11c/0x148=0A=
[    2.281057] ---[ end trace 1fae73b5c77d8120 ]---=0A=
[    2.285792] ------------[ cut here ]------------=0A=
=0A=
This happens because clk_hw_set_parent does not take the prepare_lock so =
=0A=
a lockdep_assert_held fails. In practice it should be mostly harmless =0A=
because clk operations shouldn't happen while the SOC provider is probing.=
=0A=
=0A=
The issue can be worked around by doing the following instead:=0A=
=0A=
+       clk_set_parent(hws[IMX8MQ_CLK_A53_SRC]->clk, =0A=
hws[IMX8MQ_SYS1_PLL_800M]->clk);=0A=
+       clk_set_parent(hws[IMX8MQ_CLK_A53_CORE]->clk, =0A=
hws[IMX8MQ_ARM_PLL_OUT]->clk);=0A=
=0A=
This implies reverting commit f95d58981f40 ("clk: imx: Include =0A=
clk-provider.h instead of clk.h for i.MX8M SoCs clock driver") and =0A=
somewhat rolls back the consumer/provider split.=0A=
=0A=
What would be a clean fix for this? It might make sense to add a new API.=
=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=

Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62295C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCD20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVQfLt9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgGUBZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:25:21 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:36256
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgGUBZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:25:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qbf6aXxTft5imt6lVUpOjaXkDOfcB8EsnuBQ94+LMV0EQBF2lOH86vEt0chKM8MA1fhe+asEwHKxO0FxS0XTY70eVTorjA/bCb1A6O+vTESHTko3U2W/Cdgai6+aD1rBnigm+DnwE4A0Op5pZDJ/i0JgTUGFhMaSAqig89MtFInggRpoG7zj0MbbGLxXtJrsi0YXIsTUGPB25Rwr5EgOQAAIOkj95cPnE61znzbzH0a8YPHfJM4tfp/NKXX7CjGLuJBYSlaSmyKX93tqz1+Uh8kyGcfosYxrV3x621PMSGYutUdGBIbp5nRNSJw2AOzVdlvNMS0wEZhldXPHOWRUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVRy9ukWR9AkUShwVIy3kXxXGbhxZ3XiYHUb6Iz1ZGI=;
 b=RrUfAPvdxOjNxxPRXUISfjLTnPS4arMx6RTHT6H9pLen4RPbtiE3TVyQRN9q4fy1APQ1CSqzGpMrFb1pvZPnV31ZsGP6dkV7sCsRtU4jcGgM611KSuXJNTbDrl1hBsZtX+csDzSPE5IVDhz/DQNuVOI8UmVCdvFx6CJo0pZYgTqGxNbYAGXRPl9+XN8mL9H9Wgyb42noHquE8wcuc82QhvTXSmpuVJ7rvS1pXp+jJu/rXQilia6/vSWmhDoFX2+FPiCP6y342Gr3z+9hGmUKU2OTyakRTg/q7Xqy2RScW025rswq1QwopUpGpy3i7PwGXqSYW118SO14a6QWBuAXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVRy9ukWR9AkUShwVIy3kXxXGbhxZ3XiYHUb6Iz1ZGI=;
 b=hVQfLt9W3Owg5briBLWvrvssVG5U2k+Bk2EC8Fithp0BYp0tCPciJHNbR8HjGBI+MFuskmqIxQtAhP+soMJZQZFLXh4Z5Nw56PHXDnj3qBrS1USU3Do/z8x80r1BuLNPzB0xar+Ha6xf1X1r8r9MdVbOEFNytDuBoFRY/DpxGBA=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3128.eurprd04.prod.outlook.com (2603:10a6:6:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 21 Jul
 2020 01:25:17 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 01:25:17 +0000
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
Subject: RE: [PATCH 2/7] firmware: imx: scu: Support reception of messages of
 any size
Thread-Topic: [PATCH 2/7] firmware: imx: scu: Support reception of messages of
 any size
Thread-Index: AQHWXnUKNidKtJvMjkK/gc7U1xxq1akRPnhg
Date:   Tue, 21 Jul 2020 01:25:17 +0000
Message-ID: <DB6PR0402MB27609873F3C0183D022674A088780@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595235977-106241-3-git-send-email-franck.lenormand@oss.nxp.com>
In-Reply-To: <1595235977-106241-3-git-send-email-franck.lenormand@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0229f830-2473-4083-43c3-08d82d14ed0c
x-ms-traffictypediagnostic: DB6PR04MB3128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3128DB001549D029D255933188780@DB6PR04MB3128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XbRcn145UPalT6lqnT2GTUR0PoFQoKvjUNbbp9P2k+cJ3oCNACniSO3jJOcJcytkzXJ2YjIUQSlMWFyp1wDVyOZnbqoH+rpSopcvTGm3UHAh2ZZOd+GkHE8UdtvPSBtDNb/kjKCVK+C5WIl6iHBdlQFW+sDeBcOhxJ5WqrVpShArn+5nWY1ujZZP245ahq+vYoFvxiB8UwhVB1g6TnCKwg59ZCb7P7qQt2cGQr5vxHHjUvdg1cpwmfvjAechHZLAtF8AhMdD/QU2Nq+IgLuDFGkf06CTt9U02IyJJnqFSLnAqZS95sYB2evaQ4pVL/lpu65rcuxtrAD6JAYimFIv4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(55016002)(186003)(26005)(9686003)(15650500001)(52536014)(83380400001)(110136005)(316002)(71200400001)(478600001)(5660300002)(2906002)(8936002)(54906003)(6506007)(33656002)(8676002)(7696005)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(86362001)(4326008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XKD1A0BfF6zKtuzEB0HFrNrNk4kCd2VcaIqB6Yj57pm+rQYeDR1P7lOsCMg7e8zYlh+LaLqaYa6GtEBV0E7IvIypJykgn/kjj2wRdviJgZolim0W0zb10x+WIewEoExKL/OyHxr0punpPH1bcE0YSXQn0SwYDzVm32ZHcf+yEE8DyW89KQ9QTyw8TccQWtMbwO2l2ynqEELlTQCtaZV1WREZmd74GikGedihVxzBxJX45q2uJgDvEcJ1vlMWaBWv2NANwYFYw+i7+1+uy2lpU921Qw/1sc9eqdh8/9aSiM0yUZCh3zWJj8/pR+TCINZCrztAGWgVLAB0oxwnfqo0sjT13wquGpfscXqSgixCdOsYDOQiVBk65pJO1kYRdbjaaNz2JGOM/1kqx1pwHr3Dq8MUVNjvK1HcgAmq53qPvxSXQ0KDV2WNsgfOY8etXcSj64lBqAUEAyD/jrOsShFc6CczQRs4iyQE9wNTT2WEcsQ42wxglIHltOLfGH/swiof
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229f830-2473-4083-43c3-08d82d14ed0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 01:25:17.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lg7X/o+bJhMvralnwJsU3ZGFtKpQO2gUCX7qTzaQP+FB1DLzdyPaxBj2y1iItYMbEbX5gJDP1M0M42ZqajD9dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/7] firmware: imx: scu: Support reception of messages of
> any size

Could fast_ipc be used for your case? I am not fans to use the legacy metho=
d
which is error prone.

Thanks,
Peng.

>=20
> From: Franck LENORMAND <franck.lenormand@nxp.com>
>=20
> The word of a message can arrive in any order and the current driver cann=
ot
> receive more than 4-word message.
>=20
> To fix this, a new variable rx_pos is added to imx_sc_chan structure to s=
ave
> the position at which the word receive must be stored.
>=20
> The position is initialized by the index of the channel.
>=20
> The position is incremented by SCU_MU_RX_CHAN_NUM each time a word
> is received on the channel.
>=20
> This allow the words to be received in any order and be stored in the
> expected order.
>=20
> Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> ---
>  drivers/firmware/imx/imx-scu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-sc=
u.c
> index 2ab0482..7c13595 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2018 NXP
> + * Copyright 2018,2020 NXP
>   *  Author: Dong Aisheng <aisheng.dong@nxp.com>
>   *
>   * Implementation of the SCU IPC functions using MUs (client side).
> @@ -19,6 +19,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>=20
> +#define SCU_MU_TX_CHAN_NUM		4
> +#define SCU_MU_RX_CHAN_NUM		4
>  #define SCU_MU_CHAN_NUM		8
>  #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
>=20
> @@ -29,6 +31,7 @@ struct imx_sc_chan {
>  	struct mbox_chan *ch;
>  	int idx;
>  	struct completion tx_done;
> +	u8 rx_pos;
>  };
>=20
>  struct imx_sc_ipc {
> @@ -136,16 +139,14 @@ static void imx_scu_rx_callback(struct mbox_client
> *c, void *msg)
>  		return;
>  	}
>=20
> -	if (sc_chan->idx =3D=3D 0) {
> +	if (sc_chan->rx_pos =3D=3D 0) {
>  		hdr =3D msg;
>  		sc_ipc->rx_size =3D hdr->size;
>  		dev_dbg(sc_ipc->dev, "msg rx size %u\n", sc_ipc->rx_size);
> -		if (sc_ipc->rx_size > 4)
> -			dev_warn(sc_ipc->dev, "RPC does not support receiving over 4
> words: %u\n",
> -				 sc_ipc->rx_size);
>  	}
>=20
> -	sc_ipc->msg[sc_chan->idx] =3D *data;
> +	sc_ipc->msg[sc_chan->rx_pos] =3D *data;
> +	sc_chan->rx_pos +=3D SCU_MU_RX_CHAN_NUM;
>  	sc_ipc->count++;
>=20
>  	dev_dbg(sc_ipc->dev, "mu %u msg %u 0x%x\n", sc_chan->idx, @@
> -205,6 +206,7 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *ms=
g,
> bool have_resp)
>  	uint8_t saved_svc, saved_func;
>  	struct imx_sc_rpc_msg *hdr;
>  	int ret;
> +	int i;
>=20
>  	if (WARN_ON(!sc_ipc || !msg))
>  		return -EINVAL;
> @@ -212,6 +214,13 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void
> *msg, bool have_resp)
>  	mutex_lock(&sc_ipc->lock);
>  	reinit_completion(&sc_ipc->done);
>=20
> +	/* Set the indexes for the reception chans */
> +	for (i =3D SCU_MU_TX_CHAN_NUM; i < SCU_MU_CHAN_NUM; i++) {
> +		struct imx_sc_chan *sc_chan =3D &sc_ipc->chans[i];
> +
> +		sc_chan->rx_pos =3D sc_chan->idx;
> +	}
> +
>  	if (have_resp) {
>  		sc_ipc->msg =3D msg;
>  		saved_svc =3D ((struct imx_sc_rpc_msg *)msg)->svc;
> --
> 2.7.4


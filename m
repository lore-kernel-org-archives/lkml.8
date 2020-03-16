Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED778C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57B3205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQBken/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgCPDl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:41:56 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:64392
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729412AbgCPDl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 23:41:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmkmI0uYrrd/d33LKozHkanOhxqzDn4GHg4/x7tLGoD5dbr72ndXrPAJ/96rWfq40xphVMdNMgz3PVYMq3fVmfCO/in36+TPe4tDL635qhCO8Kgn4hba2X7kidXYAETN/YCWczKB84Y121rSym2ktHnmg+xdE0PKpJLU5pcM2841ly3+BQjWcmoIfHsc1kFVsMZjNbU9IRRBVDyCQcMT2ipSaak9d9mQ7Tjn7qeP/QQL2z6Xs/2LJPYoWSLz46vzHCUoHtDlnP2L2bUMntXGvCdS8O7lz5zbgmClJ7rLXQ3tI7SO3yTzesoggGd25Z1mKBXq3tjdw4JtupcfHUSofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzmm4udHkViO8F3Hbbt/17Qcb1ivn95jOzuEVofgBUo=;
 b=atV1Zwv74oW0IHOhdoj3JY/YfMSIu/6WGRdqZSEPuGbRUk6H8+T2qrP04bwC2T3KiRbnjGXVXte8cbiYGnJCs9N4u7qMEjJVqTRNJdfKG5KVzPUkC6iSzOKyHAV+M2o6o8B8aC7zrY7n8MMSc4sbrytw/dbQN69aCXth298Y4u2SGwF/fq2ykmmbTKbj7jWWr7hn7pIMEGDKbRvNC0Z9rTgzZq959oshJe4vKULmWLC5cYChS5OYJkGvrCUEafHre2ZeRmRxCDNvUFODuWS6XQqtgTgJ0tGTgzQcN9PJNaxDo+4RGAC4elwctLkDstY6D0tDK2k5oPrRt+80unbbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzmm4udHkViO8F3Hbbt/17Qcb1ivn95jOzuEVofgBUo=;
 b=bQBken/uKtXuo7Fyg1YUZItrE8B+xWoCHUTPI106wLtPq40i93EMeca+/VVKqq7r14OfrMjHgSOutdRvrUhFpZXsMA17YO94YYQ6kvS9na8cRHHzD1z3rN5eGQLoa5PYEW2u7T2EAjE1ghV+5EXz790iTK9YfWJl6g3IpoSwC44=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4478.eurprd04.prod.outlook.com (20.177.53.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Mon, 16 Mar 2020 03:41:38 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 03:41:38 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] USB: chipidea: Use the correct style for SPDX License
 Identifier
Thread-Topic: [PATCH] USB: chipidea: Use the correct style for SPDX License
 Identifier
Thread-Index: AQHV+rg4tLY0PLqM0U+by6gziKwWsqhKlAZA
Date:   Mon, 16 Mar 2020 03:41:38 +0000
Message-ID: <VI1PR04MB53270B1176108AF36224CB6B8BF90@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20200315105503.GA4440@nishad>
In-Reply-To: <20200315105503.GA4440@nishad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [180.171.74.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 717dfe13-07b5-4adf-781a-08d7c95bef33
x-ms-traffictypediagnostic: VI1PR04MB4478:|VI1PR04MB4478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4478551BF01F9231A41B10FB8BF90@VI1PR04MB4478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(55016002)(81166006)(81156014)(6506007)(966005)(8676002)(478600001)(66476007)(66556008)(7416002)(4326008)(5660300002)(52536014)(64756008)(66446008)(66946007)(9686003)(33656002)(76116006)(7696005)(316002)(2906002)(186003)(54906003)(86362001)(71200400001)(8936002)(44832011)(45080400002)(26005)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4478;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abgBtehLiZuHW7Lf+gWT2tFCLKNr7Sd/JY3CrkmwEvXZy8cY5io6BRUkB+NTQHmRWt+NYU68oTu+ABAUT+Tz4/ZLGEvnLrWOK9hwi7YGmORrkQGD7nh1qH35MNtHdVZnujs4ndHn9T56FDERj8/gBG+YzJ1Y3ryrUCgJKvAfcc24vbVecr9JfY4iqwwFAEdYcm+EjwOLgGuv99BiYL/gZKVn4+qMxHHyd5K5LoLUtouFDrfKVlQ+B2EiLOxt1gsRz6jWHvJVh5DqKEGwemWT7eNvnyzyNIdqGjSNYpI+w7BGgYekllCsuEaI+XckNP33RLvKDRmw3dp9JHtJ0j8oM7PdPkC9xVnflfCqxPVb8k6SwMfln29nccowCZnjP4kpG/Tj2iy6JZihgGSZKfqkCA0ND6yyRxrD8dfefSJh8g0nRlYaO0O27t5+ued0iUX7cGI/zvQw+Viiu3LVpTrKhopI/SOi7nnNCWi51FRSUA4gCdfNn2e/1JlNsB6xKwcAU5chrhPcCSBRVSBoTNnjNQ==
x-ms-exchange-antispam-messagedata: qfyn9dQuYQ8IgjGCw1MmKd/3ZhoqRhATTeEaTUAjSkk+/8vBiHA5+u98xB7k98khHydrJlKuQT5tUFk8tftnAw0FACSpA0448uIP3CEZ3aCYjrAPKvqQ2V89dWQrZ0EKHJii5rOiInTIJjmOGqSTcg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717dfe13-07b5-4adf-781a-08d7c95bef33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 03:41:38.7639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkq/dWTYRUgtZUf9Mn2NfZJ3uOFnFpohFmX0W+B8nc1q5xrQMLfAbLlVfO4EhKXb+Tol6q5bjue1qL+BUmOxOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> This patch corrects the SPDX License Identifier style in header files rel=
ated to
> ChipIdea Highspeed Dual Role Controller.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
>=20
> Changes made by using a script provided by Joe Perches here:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.=
org%2Fl
> kml%2F2019%2F2%2F7%2F46&amp;data=3D02%7C01%7CPeter.Chen%40nxp.com
> %7Cbea69ff84b574ca6b48e08d7c8cf58cf%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C637198665199494622&amp;sdata=3Dbk1n4%2BvnrfRS6ZDrps%2B
> uXiImdzaxKZ00YskBg6pjtn4%3D&amp;reserved=3D0.
>=20
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/usb/chipidea/bits.h        | 2 +-
>  drivers/usb/chipidea/ci.h          | 2 +-
>  drivers/usb/chipidea/ci_hdrc_imx.h | 2 +-
>  drivers/usb/chipidea/otg.h         | 2 +-
>  drivers/usb/chipidea/otg_fsm.h     | 2 +-
>  drivers/usb/chipidea/udc.h         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h in=
dex
> 98da99510be7..b1540ce93264 100644
> --- a/drivers/usb/chipidea/bits.h
> +++ b/drivers/usb/chipidea/bits.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * bits.h - register bits of the ChipIdea USB IP core
>   *
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h index
> d49d5e1235d0..644ecaef17ee 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ci.h - common structures, functions, and macros of the ChipIdea drive=
r
>   *
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.h b/drivers/usb/chipidea/ci=
_hdrc_imx.h
> index de2aac9a2868..c2051aeba13f 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.h
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   */
> diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h inde=
x
> 4f8b8179ec96..5e7a6e571dd2 100644
> --- a/drivers/usb/chipidea/otg.h
> +++ b/drivers/usb/chipidea/otg.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2013-2014 Freescale Semiconductor, Inc.
>   *
> diff --git a/drivers/usb/chipidea/otg_fsm.h b/drivers/usb/chipidea/otg_fs=
m.h index
> 2b49d29bf2fb..1f5c5ae0e71e 100644
> --- a/drivers/usb/chipidea/otg_fsm.h
> +++ b/drivers/usb/chipidea/otg_fsm.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2014 Freescale Semiconductor, Inc.
>   *
> diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h inde=
x
> e023735d94b7..ebb11b625bb8 100644
> --- a/drivers/usb/chipidea/udc.h
> +++ b/drivers/usb/chipidea/udc.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * udc.h - ChipIdea UDC structures
>   *
> --
> 2.17.1

Applied, thanks.

Peter


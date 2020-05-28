Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B061BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9A42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MM++JSv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgE1Byp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:54:45 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:24081
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbgE1Byo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnQkZJR2nUWKKS55eJCTsCDqvKNfnJXjHAggan6NZjdPd1mJA7s2HGKW3vPyuJSsXcyq+SATEb4aphBGDsdqTI+NrR9gMfkK6s8m4Wrk6TJ3kFlEKqsiZ7j8YNynUwjTLgw3oTQiWYZD9sFCn653U+AI3mJZENs3AH7tWN3Dds6eAqJcvVoV6L8GvwDEFJE04CeiCKKn39tzSV9DPkadFCmB4u/+rUpJ1JKxn3wGReZgKKNWWr+j+w//ftRfofEKVIycDXQyVgS6r9LU56QEevKKO6vlzbCOxifQ9rQH0/q9sVGuNt7YRwH25l4V5GMw3GK18cfa48aLHQQrVJ6fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjUPrPJ00xxIBEwt1p5tpm43IUd4loBg/3MMli0Nczc=;
 b=E5oG9jzuMAbdfuWDq8QnYp8kNInsNf2xJVNr+nKwj/ukGz9PVYvLcDgGj3/H7KL510pWhBt/T5pSLphbTxgN34uiOXhU2L4GXr4QPB4ae/b53JwoUhA0YHMrX1MRCQwEXGGwtyReUbLi4A+vWCeQaNNmuss3/6QhI8kwxHW4bBdQGBoa0R8u/GrVXeVLsHDJqCgYVr+I2kU7zhMEhg/5L4TFM+c8DfXybRK2l6bBmjoOYvFNKXu4kqX4ybPTxx4D8GcW16ZXP1BTmJ2laEJfiUkgq2UQFzxw34puutuXAnO5SEDdpNSAGmMDsKGSVxHlN74f3Uml33JfBzdR75SqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjUPrPJ00xxIBEwt1p5tpm43IUd4loBg/3MMli0Nczc=;
 b=MM++JSv3SOoba8fX5H14/ByeFnc+qE4//ZFxoyJeTWjqEHZOLFCK9F/gKD+oJr0TMYGDp8X6PY/+otVgRTA60vYfnXnm852YUY3Jm3Z5lOmpqAof3GxyCoEm3pGo+Wa8gEqtam+LRdZVuFtmdxfmf/a/kT71ia41L22I6ePNcKo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3644.eurprd04.prod.outlook.com (2603:10a6:8:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 01:54:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 01:54:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] firmware: imx: make sure MU irq can wake up system
 from suspend mode
Thread-Topic: [PATCH 1/2] firmware: imx: make sure MU irq can wake up system
 from suspend mode
Thread-Index: AQHWGcUyRhHY8Y+vZ0uZHvfqU0lQUai88iwg
Date:   Thu, 28 May 2020 01:54:40 +0000
Message-ID: <DB3PR0402MB39165713C539F1A81085F4B0F58E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4358e10f-6f4b-4d2f-ad86-08d802aa15b1
x-ms-traffictypediagnostic: DB3PR0402MB3644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3644782B3721F50077DE7E1DF58E0@DB3PR0402MB3644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cHP2TB71SrY+A6AWFazJ1mvIhNBl/Li4dvKiMAiyoQhQKUW8T8ahgZ+jXnM0fWXndvz4y/pswFXN9gqujZ4eGpWIjPxBgH5LPs5n5oqaqWhvt1Kw+zTEH42sNQjYBe4iHo2TQK1bgr0brZ4Ebz6tODza2DL+2f2HcSptRlkhcRGcz07egrIgx6DeMrSVKsXwI8avCRMNPU+iq4S2rSljE8an47VgH97iC6qrRmI9/WlcRUYoq30W5rG0QfT1G+jCDwUkZu8CwDiJr23laJ5o/IXwbmDsCKG6ragY8o8al14Nrqr+jTz11Z/Un5ys2Cf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(33656002)(86362001)(8936002)(6506007)(8676002)(44832011)(7696005)(5660300002)(76116006)(64756008)(66556008)(66946007)(26005)(66476007)(83380400001)(186003)(66446008)(71200400001)(55016002)(2906002)(478600001)(15650500001)(52536014)(110136005)(316002)(4326008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZoPgZn0JysQM10TmoWJKYgKan1Sk+ReFSh8BNsMZBaPGR2UryUFfR55Zbb38Szp5u+hrBS30Y4MfATXWrm49xGXSZbKIvWyKNxCbgjAZ+O9t97PrBnFIfY0kwuyLujWeI0djL0ymiq612E++4OcR9Z8aZI4sSVVFa7Iy68WTQHCNka7zzeS6o6UEH91iO6j5Pi4/jSjWXODjD3PVoGrcn6+qoTJuL4kcixkVo1pjaLhvgycCPKlSpSsCzJDE95NRxHSkOQ32uCakI+dRfq7+CzV3BrZDjkc/T5W37B5wI/UywnoVojS1c70Lq0EhiVM/f6loh0f641kl14DrMu0HIiz16S8DIFx79Wx2srz0nxASoKq4msdoIv0eLOqvqPmHuxJT5xgWfAg1sRZ3rM0FVOUryhVGtelP2dEQJsJKO4uLr3JPHhZcgsSoiP0SHibtVieSBl47PS1xIBlQ9Sm4tEYBHGAk6bSPkiplYSD+WYs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4358e10f-6f4b-4d2f-ad86-08d802aa15b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 01:54:40.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPLGJL7QiZCT5z4XJZWb/HC1DJaUMKzV2Lmn8fWUOHE6ap9ABwRYHrKVykABgjrNzHm+BNowmbkoLIL0yj6O2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping...


> Subject: [PATCH 1/2] firmware: imx: make sure MU irq can wake up system
> from suspend mode
>=20
> IRQF_NO_SUSPEND flag is set for MU IRQ of IPC work, but with this flag se=
t,
> IRQD_WAKEUP_ARMED flag will NOT be set during
> suspend_device_irq() phase, then when MU IRQ arrives, it will NOT wake up
> system from suspend.
>=20
> To fix this issue, pm_system_wakeup() is called in general MU IRQ handler=
 to
> make sure system can be waked up when MU IRQ arrives.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-irq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/firmware/imx/imx-scu-irq.c
> b/drivers/firmware/imx/imx-scu-irq.c
> index db655e8..d9dcc20 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware/imx/ipc.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/mailbox_client.h>
> +#include <linux/suspend.h>
>=20
>  #define IMX_SC_IRQ_FUNC_ENABLE	1
>  #define IMX_SC_IRQ_FUNC_STATUS	2
> @@ -91,6 +92,7 @@ static void imx_scu_irq_work_handler(struct work_struct
> *work)
>  		if (!irq_status)
>  			continue;
>=20
> +		pm_system_wakeup();
>  		imx_scu_irq_notifier_call_chain(irq_status, &i);
>  	}
>  }
> --
> 2.7.4


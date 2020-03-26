Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D075EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D7920714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="McsYNAFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgCZL1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:27:42 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:4580
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbgCZL1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcE0t/+P/ROT7bJqhMuRE+o/8HkX5ukQtoBcR2LkKrwaeZtKuBrueU1/cdBe+GjeVxBuTmRFoh6Fa+jIP0HsmLR7Srs/ta3cx42SC8g7SIV6d/+4Z9myU4Sr2IxzYUQ57KlLG6IalH3Ss15m/IVspJhtnKynGet58aPM1/VpTm1TbTsW3kGOYfGrjBy43ifeT+6Cd+U0f1rdcbF2yqDkLi/uVna7IS46Y1iSpfH1dAZf4V2464IRSnoFR+eZDrgqRfSNKlgdlYh6uhJUf4UsEII1N9pGvPpLK1ssAc8KZvOOe0NZdVn6WgZDWT4C+Z8gBH0MO8tbKRJqsZud7Oc/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=881QD6+SCFjpQD28jCSSQPDg3w4/ooncGEL1dHSZSYY=;
 b=RFgfKUtTsyLm0aze/i/S8/WqO7Kkr4aH4pE+UDt3xbA2Ytl3nw9Wl1OdF+554z7Ws9CMVV7p5CNbazuJIZ8RRvKOgNKrOZEWX2e/WlH3eCjUEiL6pDpZ/GXelYFOkSYHZfFr6v/wlv//KiK8M7+hfyHas8Y5XxQP7Wx3V7xG0ZwSobIAHJ1xSIOEPVtZwwAvgn2s0jhm0VrntK/khbjEqs//esrabAkbBi5MwXNEsQ9Jx6vcsW7lBt9Ofd5uMGZjWnUb3eh0WCfiiaAMdVpjcz2P8GmlfRCLOke+cV7ME0CFvE24VfqTSfVdxrPPMNEcXvz5pCxCkB1TpDEWPkULvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=881QD6+SCFjpQD28jCSSQPDg3w4/ooncGEL1dHSZSYY=;
 b=McsYNAFOdo+N/U4JywO14dPPqsrsofvjYmeQl0RNJhTqW2Y64AVLKdCugzh4rtOGsYsmf3sFN0JZ5EoZ6CDfLKAGZxS3ASGfz9fu1fENMJD3dfK4cMSYgNGPY9y5ZGKYNq8G4xxy605pLkXSklkDLU0kO6rLUylDqo7VHaapkPg=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (52.135.57.84) by
 AM7PR04MB7109.eurprd04.prod.outlook.com (52.135.57.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Thu, 26 Mar 2020 11:27:39 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 11:27:39 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     Leo Li <leoyang.li@nxp.com>, "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] usb: gadget: fsl: remove unused variable
 'driver_desc'
Thread-Topic: [PATCH -next] usb: gadget: fsl: remove unused variable
 'driver_desc'
Thread-Index: AQHWAz46AEx9LC9yH0mnhgCbnlg976havLiA
Date:   Thu, 26 Mar 2020 11:27:38 +0000
Message-ID: <20200326112759.GB23632@b29397-desktop>
References: <20200326071419.19240-1-yuehaibing@huawei.com>
In-Reply-To: <20200326071419.19240-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88ca04b9-f938-41dc-d988-08d7d178b0ed
x-ms-traffictypediagnostic: AM7PR04MB7109:|AM7PR04MB7109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB71094A505D179E5D93EEFEA18BCF0@AM7PR04MB7109.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(54906003)(5660300002)(6506007)(53546011)(8676002)(33656002)(478600001)(2906002)(44832011)(8936002)(26005)(6916009)(71200400001)(1076003)(66476007)(66556008)(64756008)(66446008)(4744005)(4326008)(91956017)(6512007)(86362001)(66946007)(76116006)(9686003)(316002)(33716001)(6486002)(81166006)(186003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7109;H:AM7PR04MB7157.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NB4n2WwV6gNRhhBlHxuRWIgH/M+O6LqeznisGC5xQxg9XRq0TecnWQcfwN1tpQkfKaHZPVua9+BfVGN8LdmKMgfvcvSFUQEz/MrEnRCO2X22bpcKPiXtqvdkmVkT0qFISN484wHV0bA6PTGe2imh+ZE6x+Yec+gCWLGgz8a169E30+bYs1PeaxcI//025CNB5sxI4Y9v4znY+hmp6RUtdw05QkouU5Yk1T0K7KhKZNtLMk7ckVWGEmDcANxjEgarJr4N7k5lzgeD8bzS70H+GdBmPdIjDNKui8+X/SDVC1kd1FeodKYhmzNTR7Iu/NRDccv0MGuXKyPOyg+2ufrKz2uwNY7M6dWvQPVTWvYjGo7J1t+8GVegvpbeDJD+k7uk3Mb2UG8U/5TiZmU129RUtW/zAEex49sXzEjPX+0kGMsv8xw8n/z9jDJhAlY0ZZ/h
x-ms-exchange-antispam-messagedata: t6a5bzMGvRmlYW7adR0kSacCBiShuQbMoUI8Woh7NEJvtEbyrGHoUB7c+L8g4spFPFCQ4WpJbKskVmCw+kccnUH/IkCSpNheaKHrhnogSph2lfEvWMgbBQx5DClblVI3gPGI7KwanRi0N9nwqBypoQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4243D766E89A814D926F964C91D19B01@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ca04b9-f938-41dc-d988-08d7d178b0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 11:27:39.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIYnYNPCxCaDSRWn0xoz/r9T+/BYdpQ6sjwEm/oSqj92ir95Xss3TgGKkdTEQC42v9skXe/nSFJ+6nfan9zJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-26 15:14:19, YueHaibing wrote:
> drivers/usb/gadget/udc/fsl_udc_core.c:56:19:
>  warning: 'driver_desc' defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, so remove it.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/usb/gadget/udc/fsl_udc_core.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/u=
dc/fsl_udc_core.c
> index ec6eda426223..febabde62f71 100644
> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
> @@ -53,7 +53,6 @@
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
> =20
>  static const char driver_name[] =3D "fsl-usb2-udc";
> -static const char driver_desc[] =3D DRIVER_DESC;
> =20
>  static struct usb_dr_device __iomem *dr_regs;
> =20
> --=20
> 2.17.1
>=20
>=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=

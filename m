Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A814E20738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ACfyQPM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgH0Liv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:38:51 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:64001
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728369AbgH0LaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:30:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USGO6BViMD0MUzPaTGYKQJW5VM4+enOSU5WRDURIg2/8fO3Zm3XbIOysSZWnDjcA5cwx/xBowWW3zGagblPlLCQ5CLmzNCt+Os/W6JN84mxnkykQX+fDIfGHIbbtc8ttKqf3PUf8TnHkyxBqbEnKepc9HFBVZnBQndRbOnGq0W9qitze7KWKpYWeHf99eZ8aajseL9uw5nVSHV4+ydwAbguyDtSwR1zPtPoCjr4b0hJ9p6nfbGmu+bRYC55K400Z5wSuS5zeO/wqJ0CZTLwPqWnBt3d1mE2o8T5E66bPYFqJoNMaj7flKRR0Xfseo2Y3erYY4Z+c7X1yywXEKFaBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL7B4j0n0Otina1rsv2p5lmfqBh4PHxqOuEBW8XBYY4=;
 b=KtxfIjbBua8DXOEw+SBOlZZKc+R6m0gWvllUq+U9/73aeGhNjS8IULe9AL5UpwfT5y0buo4dvB0v/M2WHQ+LoscDKRCsW8AXipz2/iR0W/b08F3NsF37aW4BkcZ6jOSK6YdBMgB+kqM5RDUEjF7HOlo8Ipi9zANEbcI6GXWZGgqmbYdkCmomv9O82OtTp8rj+ikxaLxx7bjZcX/drh0DUS4TJ/wolKgUB1pxlkQ2zAlGXPKCpvwNCjiL0EfxHr1dCZ2kg0YNqjf+Z+ugBT2blBO/Oug9qXJTq51in1Bk3mqAWACQbQRqsO1WElemIxlBgwXQ+Lw8SUoceOyJhLXnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL7B4j0n0Otina1rsv2p5lmfqBh4PHxqOuEBW8XBYY4=;
 b=ACfyQPM2ciUQ7gIYiqdT4qyYwpnRxKxHwZAYMGT95QKcA9GVzfo18oRxKm3kFKpAZVvmHWJVJjGI5ueUZ4lPyy3tO7EHFdFoy7eT/3eHjo5s9jOqPCjrZsxS4mAKSxsBlWEwb3A9GCN3tngxnUa2PNcTCJrmHHBCXcSn2Q+EsT8=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4421.eurprd04.prod.outlook.com (2603:10a6:20b:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 11:09:54 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 11:09:54 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Topic: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Index: AQHWete/XCUsbMkzVE2tONyDrFDh16lLzyQA
Date:   Thu, 27 Aug 2020 11:09:54 +0000
Message-ID: <20200827110838.GA5983@b29397-desktop>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com>
In-Reply-To: <20200825120059.12436-4-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf5344b3-7325-47d1-62bc-08d84a79ba1e
x-ms-traffictypediagnostic: AM6PR04MB4421:
x-microsoft-antispam-prvs: <AM6PR04MB4421BA17B93A367CA4773C878B550@AM6PR04MB4421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4IE6kEkx0b2Z1lSzh1fzVKYjKq1tjNuu28eCGlG2Cpab0AShl4IiB45XBlVEjKhPxVsxIrhFlzki74B7ofdPvECgudeeOYGqPeFaPctKgzN0JQk1GEZoHDo6awZ4d7ckEUdb6/fFZnugwwqRpAZHqtomeISaSiMMpRpGtPyTQcoLiiR7/NzgBYgsVeREbVKz3Be/55ysHZWGWvJtdVz46SfQOJuHzgzaJK6+oN935+tVSaeDJADIxMLsHiFUSPEweqINgsYViMJbhEO1iJuZfCrMJpVq/pSNSEJs2XiBqGv8llI/p2BdKX7bbwbfYnfojt31tJaLg2CFe2LzNjrUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(53546011)(54906003)(71200400001)(8936002)(316002)(83380400001)(6486002)(2906002)(1076003)(478600001)(6512007)(9686003)(6916009)(86362001)(64756008)(66476007)(66556008)(33656002)(7416002)(44832011)(76116006)(5660300002)(4326008)(186003)(6506007)(66446008)(66946007)(33716001)(91956017)(26005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: A0DDpLGLF9k/dITaNt0w4iYGnqTHXEL867MfMYbvThl0SXXc7b1F/qS+MAk60GwLMS0l3DI4fNe0tq7qs7KpLITtxihULfzTWKZIOX0ir1zpoBqbvuJC9YVo+NZ7t8J5vaQQvh1PaYCj0rqdQjpkxUN/d93gOAsaXiHXX+b5llNsEQDZpYv43IDSANpKugLuYP2dRvHYErWw+baFxIyhJp5GCafgrRWTF+LHrSTWS2kHXeEaPEi+8knPpqn4iEUTRrNdnKXR/oQkPdJSiwucQuMlKJoVNNVaPqxeXYPP/D7AKFp/ZkXH4uhj644On052JuzCl7xx9o7yd+rkBk20MxUcGTQQh0+m9EhnBGznoiWXqSJ+u3XnFwitXtHs+8fWgFxoR6+U2nnz+DM7svAejXhogfQX0y4/vnensqqD/lyfXr3tWL1qHWQ9IqfZgSpM/ZdzxP+f8bsV6IF7Th6KjmjRdHTc4gvLmb+qqKV7uvV6VPkkF4jBdzPW6TJhoibC9ZWImHkvTWdvpImRwbMld2/olYWqoLJXFzfMzZy3awaX2U+S76paM7BfiiHIs/BL2vkiHarmivcU77QqyHmoeIHjQhVxyVCtaPLEmWT0wFmZqeraPNx5UAb1fm69mGCmsGUFOca2Hd9olK+v/8H9Aw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D340B0A7B97ABF459EA8F32121C6E017@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5344b3-7325-47d1-62bc-08d84a79ba1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 11:09:54.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kl06ni5rmvSfn4wxG7723WnBSAsOa55ux8xBYc1LWa1Q4X94D43wNGL8/h05Vac8KzPR1O1hLRHJQNPzwp6mSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-25 15:00:59, Roger Quadros wrote:
> From: Pawel Laszczak <pawell@cadence.com>
>=20
> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
> amplitude is varied below and above the Squelch Level of
> Receiver during the active packet multiple times.
>=20
> Version 1 of the controller allows PHY to be reset when RX fail condition
> is detected to work around the above issue. This feature is
> disabled by default and needs to be enabled using a bit from
> the newly added PHYRST_CFG register. This patch enables the workaround.
>=20
> As there is no way to distinguish between the controller version
> before the device controller is started we need to rely on a
> DT property to decide when to apply the workaround.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
> ---
>  drivers/usb/cdns3/core.c |  2 ++
>  drivers/usb/cdns3/core.h |  1 +
>  drivers/usb/cdns3/drd.c  | 12 ++++++++++++
>  drivers/usb/cdns3/drd.h  |  5 ++++-
>  4 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 5c1586ec7824..34b36487682b 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
> =20
> +	cdns->phyrst_a_enable =3D device_property_read_bool(dev, "cdns,phyrst-a=
-enable");
> +
>  	cdns->otg_res =3D *res;
> =20
>  	mutex_init(&cdns->mutex);
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 1ad1f1fe61e9..24cf0f1b5726 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -76,6 +76,7 @@ struct cdns3 {
>  #define CDNS3_CONTROLLER_V0	0
>  #define CDNS3_CONTROLLER_V1	1
>  	u32				version;
> +	bool				phyrst_a_enable;
> =20
>  	int				otg_irq;
>  	int				dev_irq;
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 6234bcd6158a..b74803e9703d 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mod=
e mode)
>  			reg =3D readl(&cdns->otg_v1_regs->override);
>  			reg |=3D OVERRIDE_IDPULLUP;
>  			writel(reg, &cdns->otg_v1_regs->override);
> +
> +			/*
> +			 * Enable work around feature built into the
> +			 * controller to address issue with RX Sensitivity
> +			 * est (EL_17) for USB2 PHY. The issue only occures
> +			 * for 0x0002450D controller version.
> +			 */
> +			if (cdns->phyrst_a_enable) {
> +				reg =3D readl(&cdns->otg_v1_regs->phyrst_cfg);
> +				reg |=3D PHYRST_CFG_PHYRST_A_ENABLE;
> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
> +			}
>  		} else {
>  			reg =3D readl(&cdns->otg_v0_regs->ctrl1);
>  			reg |=3D OVERRIDE_IDPULLUP_V0;
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index 7e7cf7fa2dd3..f1ccae285a16 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
>  	__le32 simulate;
>  	__le32 override;
>  	__le32 susp_ctrl;
> -	__le32 reserved4;
> +	__le32 phyrst_cfg;
>  	__le32 anasts;
>  	__le32 adp_ramp_time;
>  	__le32 ctrl1;
> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
>  /* Only for CDNS3_CONTROLLER_V0 version */
>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> =20
> +/* PHYRST_CFG - bitmasks */
> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
> +
>  #define CDNS3_ID_PERIPHERAL		1
>  #define CDNS3_ID_HOST			0
> =20
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

--=20

Thanks,
Peter Chen=

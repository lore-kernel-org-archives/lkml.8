Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D603C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269902077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jl2o8uDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgGVAiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:38:18 -0400
Received: from mail-vi1eur05on2043.outbound.protection.outlook.com ([40.107.21.43]:28144
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbgGVAiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8Yxhs60j4ImMisJXQbpp0bZVzHtVMcLJvLqEblHK75D+GUxogNnFUpENO/UJRRoLoKQVqFFbBRIhHu2pyHTBxfdsmckwzz7wAlbz46IrOHpm0Qs7XWZQVCyV6Wg8p0kgXGE5f2zM6iYruKF6xWBkkVccbPgrHLnL5cxvWdJhDoGuv0WiNRk3dzFIQSDQZ+hEmx9flHWcn2miilrAxWMbHU7RDhdpUUw7FbtSb+qtvDLTcaIoqJCZ+bM4G82/yy/rH8/V+nlM8A7nec8QqNDWsLBUyQJG3QBpWMaGVlWF2pYGlfBX/WS9m0l5SPwQwpfGVtH4/Bu/I05j9yUiAvgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83rjQY6xhelfoaJss5pD6eCiDkR+rU2lkFSXp0fQVdI=;
 b=mizcZY202FT1x1GFpc7f/p/uJMuMOmTI67vftKWoDViQrN2TAfdQSxIRwxa4+qJ/BFcrmOCKSWNWJo1q2BoFL9nPc8eWcPnqj7uY2Pc8RBYXWcFvZiGEk/XfzgxdcABvVaxA82uGnI+NOJOCo2LWQKNKWQ/NPmIBgvJYS9ETApU+IxC0tqpQ9/ycVwA95EopkmZVcuyWgCimnZdxTjuWtHgLD/Dr9cm1vcfryegHARdZ0ZeGKhek32g7PSD58Hb5NWyTVlLt3G5IFRTyKnz/Ifrh2rumyp4FHOniv2ZLVl5Q/LZmaWzAIAWYFXIyU8Fe/vO8gcy6psye/Y+fiJj1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83rjQY6xhelfoaJss5pD6eCiDkR+rU2lkFSXp0fQVdI=;
 b=Jl2o8uDO+jHoe7xqX7kTTXPXLuJiDvjx3E1kZl0Xc//w7CxGafSXufC0KL9xAFFAQ7sEcapYjzeSSt+4LxU/PAyP9GAuFHOAIm1sM3IyIErXgCuNcFxZT5B5kCjLaMvk2clUE/y0UFWVBVbjUE1m8CLqeA0S9nc7JjU2fPkS7XE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6440.eurprd04.prod.outlook.com (2603:10a6:20b:f4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 22 Jul
 2020 00:38:14 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 00:38:14 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH v2 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and
 CDNS3_ID_HOST
Thread-Topic: [PATCH v2 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and
 CDNS3_ID_HOST
Thread-Index: AQHWWP1HRe/JjMrj3Eqt93mqctTf4akSzr0A
Date:   Wed, 22 Jul 2020 00:38:14 +0000
Message-ID: <20200722003804.GE5807@b29397-desktop>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-7-pawell@cadence.com>
In-Reply-To: <20200713100554.28530-7-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d349144-d5b2-44e7-6ad5-08d82dd7850c
x-ms-traffictypediagnostic: AM6PR04MB6440:
x-microsoft-antispam-prvs: <AM6PR04MB64407717B07BEA9A6F1F5B998B790@AM6PR04MB6440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kDqHDHGg0uyCankFfxb9Ngb3kH/EDHVrxAsYey1t4r9iNfimJNu7ud3IjlyNkjzVHjBzAEfkQryccH7vQugx8xgdEu17VT8F0dB4BV3mwwChoTwcR6fLP7pF3YKZMEZ/KcWICfkXQzm6jPS4EIfI0DPdHNkDYRzv+x68xO2+caexKIqmbzVRB7ueLtFYOXOyk3FR072/dCP00UgacBurpALJfgVbnIW9AvtWAlzYJF11UmroVL83cl4RWDSegRb+AiZu0vDuKKy18Fc1oDkLAWey6DqUrnm/B4nrrdGqbfBxPK0FPCGMEnWgT0XU4P6OnbMKgd0zgVOoZ2MO/ZYnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(33716001)(8936002)(71200400001)(66556008)(86362001)(316002)(91956017)(76116006)(64756008)(44832011)(66946007)(66476007)(1076003)(5660300002)(66446008)(83380400001)(8676002)(2906002)(54906003)(9686003)(6512007)(33656002)(6916009)(6486002)(186003)(53546011)(26005)(4326008)(478600001)(6506007)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EFsZ17myP/J50XkZIsnRJtJj79h29Fdsi1MF2u9zRX9sZujfvrWdNjNTJ+lnMUDNeUIpmgqeN/zrf+JhhW/Dl8xZd3xV1avX06c232euRfgbjDxLdurjzb0QoSCjOf0gBCXBOLBLpWUaMa5+SEnePH4viOIkhQEF/gCqu/lt1ULGhb0c4Ry9FfoOSlKyE96Kt28nl8khgXUwx2bIJfAQJBtohyIHMG6W0J2qwUhw3gQhFN5lNiujGD/j7GmlpNVxJcFhL8+Yo+T1krYEB2qIHYyYdiUUFAsu7AU935d59iYdMAkRK7dc8PVRiWYwneWQbTXwaMPgvB6/Yhicpp6l2coRqs+4Z/qln48K8adgNABDGJ8sfor8NLrRuS34Rosw5UKKGkHdQA0HFm3ZattShsL3cP6CzG7mHC6xQZ1CV/yRJF+XY5+0mSRKT0pcGrICck7KllMZgQJ/zVMkKK6Zz6Cg/ZKJeSNhg91HQBisQ6oT4VgbIFNCxwHGwz6j8JYN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95A652F578AC1C42AF821B9D008B0751@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d349144-d5b2-44e7-6ad5-08d82dd7850c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 00:38:14.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ppgEFWdYkckfJ9M5+kPcjZR112nyBh94iyAoLHSugB6j5fXeRPus6sFJ4xsPEyD8JtXxOS9wwHPrcVQ7UmrOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-13 12:05:51, Pawel Laszczak wrote:
> Patch adds 2 definitions that make it easier to understand the code.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/drd.c | 4 ++--
>  drivers/usb/cdns3/drd.h | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 6fe092c828b3..8e7673da905e 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -87,7 +87,7 @@ bool cdns3_is_host(struct cdns3 *cdns)
>  {
>  	if (cdns->dr_mode =3D=3D USB_DR_MODE_HOST)
>  		return true;
> -	else if (!cdns3_get_id(cdns))
> +	else if (cdns3_get_id(cdns) =3D=3D CDNS3_ID_HOST)
>  		return true;
> =20
>  	return false;
> @@ -98,7 +98,7 @@ bool cdns3_is_device(struct cdns3 *cdns)
>  	if (cdns->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
>  		return true;
>  	else if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG)
> -		if (cdns3_get_id(cdns))
> +		if (cdns3_get_id(cdns) =3D=3D CDNS3_ID_PERIPHERAL)
>  			return true;
> =20
>  	return false;
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index 35b6d459ee58..3889fead9df1 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
>  /* Only for CDNS3_CONTROLLER_V0 version */
>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> =20
> +#define CDNS3_ID_PERIPHERAL		1

Since you use cdns3_is_device for function name, it is
better define as CDNS3_ID_DEVICE.

Otherwise:

Reviewed-by: Peter Chen <peter.chen@nxp.com>

> +#define CDNS3_ID_HOST			0
> +
>  bool cdns3_is_host(struct cdns3 *cdns);
>  bool cdns3_is_device(struct cdns3 *cdns);
>  int cdns3_get_id(struct cdns3 *cdns);
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

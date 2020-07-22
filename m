Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A682077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bO9sZujo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgGVAgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:36:04 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:8755
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgGVAgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2FkKXXmtSzGt/oq1Vpaiur5BzuKRTP8q+iCpK6daG+gqoq0wpxNba6CiknStTps822vm9EyG0jDFYRaAEB7vW+fetOCHPs4fVp2V6mlkSZ5C3E07to25caDulc5XXV+TjLFKuogenSQHL2PWO1pkwi46jQFjtpcmRRJgpGuE8onhCUvXVMFfrniSShgTqWTyXcVHJYErxtFm1NIiiZDEmJRB2BAvrzKygo2NpG95yFyth3144r4c8MM9jDndFnlt8ILjxrcnqAn4xpXfQGcalKdfv7MriUCIv666ZtvsezX2KsHbipIkirHb6CW8y/hZ7d1S9Gc0BhAjowhPkdbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSqFNtv88YD0LCPfODrRg1ks5T5EKuwFUjkt9tWfXiE=;
 b=dhL0uVDDfT5OfIGzevZmFIQ6pwCsmVt0w8JYYLKE4z6ftYJ5lGtzAAv4sTML/HeFmIVAtAOWZjxbY2AwN/XcD7nL22PxmD9M5pAO4o9OWMKuuKN+Fk5o8mB0buw/wikA7xscGw6v8oXPBQUyqWk0xxr+jE9zcIrmnwhNf9lwC1WgCeHQa5X0ZcL9i1LbnVoxrrE7VeUTuRr4onvf36AOLXfZEiCPlLDWHU37jex5GLATviMj7AcncRR5HNioNgbtLIZq60hlahxe3FYHkFJ5ObsYz6W684wtBhG9kp75gmDCvlUH9B2QScdZ5cTRbSzCzyYIEnsXu66pgLDtlv+cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSqFNtv88YD0LCPfODrRg1ks5T5EKuwFUjkt9tWfXiE=;
 b=bO9sZujoarGnmD5cFsHmRsHyRT850Kk09CITF8vT4iWh78MzUUFNc5ZHzUkLEvazQ/btLkMpjp+FqWkY6RIlbo8qYPeywd8I1hIhLCxgqMuJvQw8nBip8XOrjzkq3U/LPwMaWUmnb+EDoxR/Bz5bP+9anX9P7zKws7dzOVTlGXY=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6440.eurprd04.prod.outlook.com (2603:10a6:20b:f4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 22 Jul
 2020 00:36:00 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 00:35:59 +0000
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
Subject: Re: [PATCH v2 5/9] usb: cdns3: drd: changed return type from int to
 bool
Thread-Topic: [PATCH v2 5/9] usb: cdns3: drd: changed return type from int to
 bool
Thread-Index: AQHWWP1GRsca5xBdWUurbAO4SuJn86kSzh4A
Date:   Wed, 22 Jul 2020 00:35:59 +0000
Message-ID: <20200722003550.GD5807@b29397-desktop>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-6-pawell@cadence.com>
In-Reply-To: <20200713100554.28530-6-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f88dc68-f148-48cc-21a9-08d82dd734c2
x-ms-traffictypediagnostic: AM6PR04MB6440:
x-microsoft-antispam-prvs: <AM6PR04MB64408D08180FF75AE1D6ABFE8B790@AM6PR04MB6440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qx0iYxIG0z91hNqQjN41etFGIokbNe65xdboUYpyvkiVRQBdvCSxDAQ/Yuzcmuowh7xEzRpPn3iXW+YhsIn1YqOd1ajg7nv3OZ8X2t/W906uS2mqLbt+80aAqKMK4yUiXYJ5yZ8Ii3g5WMXcWsswSprGUEaBrQ94zhwEQYetm6Q1+1fxltPISO5Vdj+GbClscabxCHUBl0iKkX9V5VId6b/19B+3PofPIG+/pTrBdEY/CJllNDzN6CdI6uv6Xa786W0MfycvO248vXErDI+VivCxxfFJMaKaqSp6m1x/WDwz0CgBX7DofW7c4KpKhILnF24VOUxkviMzlZ09XEobg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(6486002)(33656002)(6916009)(478600001)(6506007)(4326008)(7416002)(186003)(53546011)(26005)(91956017)(76116006)(64756008)(86362001)(316002)(44832011)(8936002)(71200400001)(33716001)(66556008)(54906003)(8676002)(2906002)(9686003)(6512007)(66946007)(66476007)(66446008)(83380400001)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iSFdeRqzW+nz1C0tW64nXGINm2gC0It6YbZ+c2YhcilyZBSRkhhf76SsTNTahgLQQ21Ittf25eZorYCTg0OtQ3AnphOp5YI7gS1Wd69IWjjxV7Ih4F2XfVRxgpCZFvX+9FtIxw7gbMh5HU4yz93vzejMJTEx/ZIKDIS9mwYggfK4rRbbIhMREbt801yCffbgjog9q5h4qb8im/pA1wqVDvz5hQi9XAeC3nQ+vvUKqZFberMOZgLy5Ybs8VksAtHb4uJU1TT5Fnrmn3wksABMnuF0kjkVM4JIOVT85GhRrwc6jUA2IKkR0WkN73RTaNwjaUQCJ+Tc32o9w43hcSTwNgvC9FDzA6d4PLRnvdQI+9ZQpq66ytcFUH+OcNeaHFU5UEX8Sio2ZWxuHm33g+ypnx9fyElTGg5XLz8QEUTOvcnHmdnsUvxDqR2/Z/dUTjNKBdiqzDsXMUzmUN9ENulYOL3N68AIO8bQWPTKJj/3Q9c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACDCEC493209DB4783AB48DA8E519A5B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f88dc68-f148-48cc-21a9-08d82dd734c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 00:35:59.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6ZKAmc0DBPQGiXiaiFfqEMRz1ncxPR2S/z3l8a1f5lFeqYB5K+75eySEUg66JjUL2+uCDYa48MKOmOrJk+pNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-13 12:05:50, Pawel Laszczak wrote:
> Patch changes return type from int to bool for
> cdns3_is_host and cdns3_is_device functions.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

> ---
>  drivers/usb/cdns3/drd.c | 16 ++++++++--------
>  drivers/usb/cdns3/drd.h |  4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 05a9f7d54c46..6fe092c828b3 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -83,25 +83,25 @@ int cdns3_get_vbus(struct cdns3 *cdns)
>  	return vbus;
>  }
> =20
> -int cdns3_is_host(struct cdns3 *cdns)
> +bool cdns3_is_host(struct cdns3 *cdns)
>  {
>  	if (cdns->dr_mode =3D=3D USB_DR_MODE_HOST)
> -		return 1;
> +		return true;
>  	else if (!cdns3_get_id(cdns))
> -		return 1;
> +		return true;
> =20
> -	return 0;
> +	return false;
>  }
> =20
> -int cdns3_is_device(struct cdns3 *cdns)
> +bool cdns3_is_device(struct cdns3 *cdns)
>  {
>  	if (cdns->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)
> -		return 1;
> +		return true;
>  	else if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG)
>  		if (cdns3_get_id(cdns))
> -			return 1;
> +			return true;
> =20
> -	return 0;
> +	return false;
>  }
> =20
>  /**
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index 04e01c4d2377..35b6d459ee58 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -153,8 +153,8 @@ struct cdns3_otg_common_regs {
>  /* Only for CDNS3_CONTROLLER_V0 version */
>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> =20
> -int cdns3_is_host(struct cdns3 *cdns);
> -int cdns3_is_device(struct cdns3 *cdns);
> +bool cdns3_is_host(struct cdns3 *cdns);
> +bool cdns3_is_device(struct cdns3 *cdns);
>  int cdns3_get_id(struct cdns3 *cdns);
>  int cdns3_get_vbus(struct cdns3 *cdns);
>  int cdns3_drd_init(struct cdns3 *cdns);
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

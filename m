Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40702C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1257D206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pZeqwp7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGGGi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:38:29 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:32740
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgGGGi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1naoUMdEYYQptbYONKSN7bFMky0SRdiKrfPEg7T5VcuV1SD9y2c1/ZAzxgN4pkpoj11ct/el6Zpwg4BB1HfRzd9iTmnYZ/SjMePgNf6O70hFDkxq+70RORUYVjBPm2kOgqeCcrEIKwrCi2129WxJ8NgUsLv1BKu/muThLRiMhGlr1im+yGZmmPSka5b45A2qkNkijTS5Cyow0iaf0qKFupChQknr6a4F5Dzz3/ILiZrpyyKI71l+nlou9yu8lg9GnCAiFQxVGP3JAQDRJWeQ9GB0kk+S6wE+HoDHJBOdYrlvEkQl0UdiaEBCpgdoz8jMjbSwy617vt1wJXhMgBLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATw82IjJ78BVElgglhRCwiS1GIi1+nVX2SDlDDehJiY=;
 b=AZMemt/buKqJ67R9fBeZMv0HBzvg7HUWX1/ppjG9+UGsvu/UwqDCk5tJsZ8ajejdfYGsDbcTaT7KVceGz0ry9PEVnW0gwwyuE3yJolN0Zd6SKr5s6aaY7Q2/KZAXadIG/g+Ciyib4h7ZpSdK+a7EyIv3lSY+f8VBBm/xwfVuYBdI9XTEG/L2pN6fZ5Tignyrwu+zITcz6oNJ+6UqoiLV+lycjKJDUHNbkP6M1DJQIIPZaDSuOk5DZucoR7ZN/Zsl53SouLAamktZ0h+z37gQFKg9rNG7iu1HZo7JcJPDteXgDxKM5QorKqS+63uMbPlPSfKTv8wWsWrFM2sgETsV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATw82IjJ78BVElgglhRCwiS1GIi1+nVX2SDlDDehJiY=;
 b=pZeqwp7UVtWBTjzdN/ek/Yif65YpHwTiM8e5DWRIKDaRGomR9e+9ZEvex7r3SRaXvB013lmnYXJFsqmV0b/nnU37kZI7PmEzERzv2Sedne2oXWkhOVSHk3jcdEz4VTVBULRMB6q8dhjgN/VS1+1fmQVn1xhxqca26MAl9ol9qoY=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR04MB3235.eurprd04.prod.outlook.com (2603:10a6:206:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 06:38:26 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:38:26 +0000
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
Subject: Re: [PATCH 8/9] usb: cdns3: Improvement: removed overwriting some
 error code
Thread-Topic: [PATCH 8/9] usb: cdns3: Improvement: removed overwriting some
 error code
Thread-Index: AQHWT3AXAF6F0d6xxE+B5FdDFK9zEqj7s5qA
Date:   Tue, 7 Jul 2020 06:38:25 +0000
Message-ID: <20200707063835.GG16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-9-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-9-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d6c9410-d09d-4ff1-9c6b-08d822405a4d
x-ms-traffictypediagnostic: AM5PR04MB3235:
x-microsoft-antispam-prvs: <AM5PR04MB323577EA093CF36F35F5E89B8B660@AM5PR04MB3235.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHRe3RuOX7NGi2HJIWCU0KuluvFvK0GZdt3RAtghrcjt3wjuqITwN47QPFuFM3A0JPzCR3H4WfHN/Qz3sRfQCeYjtxJg+eSo1DkQeHjNx1Gull0m/gcH+mgCNT914AnCw04Y0Z4k73CNPa3zOnnmyjdonUanBTjEK11ee3qtaaGo2qN0+rN3uAS1kZbe5YhTYRgCtGYfGX8xycVnl2j5nmKARWvjqLF0gifs3qW4MgP1RbOQE9N77x9dtZr2HPCzWul7eIepyzVY0TukaXdoAIciMyc7h5cV/b6wxBCLx5NtZ77mo//uGMYBdjd2+u7YWwLH042QbiY1RjZiRYPbtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(5660300002)(66946007)(76116006)(33716001)(91956017)(66476007)(66446008)(64756008)(66556008)(33656002)(1076003)(44832011)(86362001)(6486002)(71200400001)(186003)(2906002)(26005)(53546011)(6506007)(6512007)(9686003)(83380400001)(8676002)(478600001)(7416002)(8936002)(4326008)(54906003)(316002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3VOT2k1Fg0kI12FoWRuo4y4mXfXZI0jjoZqwvV+Kh4+aztaw/G2fLbxus9nSwnY7kE+bvDA/ySLEaaIc9canxOyBbXLY+7XT8eDfLEsdpolRHbpRwz3HKqDL3q0nAGow9BmXZWPMagii1yDLc0iRb/W+czstwwiAZC+FrVFsxEK9zoU61MrS+EgvdPiYBX8igs1w9RHyluRJUYvfAYkKH4I3EIk5H/CmhfnxqoOhbF80fpfl7/bO5T6U/+zscgxFY6HrcfntHC194OQjhcmUHn20RpGmFUZfFk/LpISQ3SfI/6KiL146hAY7WAvn3S5FAMvCQjFwUvahHFgfLfi0bHLWc7YmkxtG4/BXVeG+k1mNMBD0TdW4epdO2o1LEgXZZeHISK2GnLfX0Hpqjvh/BIVLwJpL4gEesyW0wOJQ7pCTFhK0R+oZRbv0pXD+7WoYbUu7CgWI/lKqeHwAwCGdtMATxWqr86NsSg9q1eUiI3it+1Bhr9EAYE89y4Tm+IjH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB3AED55B69B714DA46789910816E9DD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6c9410-d09d-4ff1-9c6b-08d822405a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:38:25.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hBDbXDRU3zyQgy7kNApio7O2011WgN+fvgs04skGHT4SfStorLuwkjzozergO1EtFHmDojDDAsw1OJ96lnR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:20:03, Pawel Laszczak wrote:
> Some error code can be preserved, so we can remove overwriting
> error code returned by some functions.

Improve the patch title, otherwise:

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 591186987245..01155ab73930 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -347,7 +347,6 @@ static int cdns3_role_set(struct usb_role_switch *sw,=
 enum usb_role role)
>  		case USB_ROLE_HOST:
>  			break;
>  		default:
> -			ret =3D -EPERM;
>  			goto pm_put;
>  		}
>  	}
> @@ -358,17 +357,14 @@ static int cdns3_role_set(struct usb_role_switch *s=
w, enum usb_role role)
>  		case USB_ROLE_DEVICE:
>  			break;
>  		default:
> -			ret =3D -EPERM;
>  			goto pm_put;
>  		}
>  	}
> =20
>  	cdns3_role_stop(cdns);
>  	ret =3D cdns3_role_start(cdns, role);
> -	if (ret) {
> +	if (ret)
>  		dev_err(cdns->dev, "set role %d has failed\n", role);
> -		ret =3D -EPERM;
> -	}
> =20
>  pm_put:
>  	pm_runtime_put_sync(cdns->dev);
> @@ -393,7 +389,7 @@ static int cdns3_probe(struct platform_device *pdev)
>  	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(dev, "error setting dma mask: %d\n", ret);
> -		return -ENODEV;
> +		return ret;
>  	}
> =20
>  	cdns =3D devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

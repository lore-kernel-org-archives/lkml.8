Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2627C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AC6206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ngk6+o8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGGGd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:33:27 -0400
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:43905
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727886AbgGGGd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:33:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUtQKbMnbfHVbGug1+YcALSH/igeTVGbzi//J3DkbwTEmrUWd3XxAnd8mKu2DsOETzPfm05KodeTpYwfaibOb/9Lsr2ZfnyLvm/sJOjFximKTSOxxQ3oEtqrakTyfK/RvS+oUCluw5QooTSi5VKtjPxL2HAUsd3tTIADqfDYfUbwJinPAY/V4ZLVG0OfCqLrabRGH4q3Lfoj84/IzAUq+6wswvBbkzGoNYbqQPJXnxLlufYwCeCNF5yTFNgoGVlXNAjsc1sRpKXuypCaKIUdypN5Zwao8SdOPPyzry+mIZWYH34Uw44ysAclwlEHbgKEOL8rMzfrSYr2crzTM8rTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q31x95vshRaMt6LYdyGFKP1Uho5ZTHdnJI0Td8Azb6M=;
 b=LO4t90onuR1Md46t5pKxWkcBAlOULAaYEtflfXmJh6Nzf7w7RXub553/BA5fGkiWsWlY8x94bpldi/W9bo+byXi8leKRS/5j84MYS8HIqCYmjbugDsxvckA5hVfmSki2x7zPqxcHa3A9PBdRFaiZjZvZPtiE93s5xnrkrx2I4R4eET3OLgSbF+Dm55xVOIk5f9sb6Q4xuvfXwmvxKxWsr4zyxOjBF1ReI3CVmtTFBWPoLEx9Pu0S0+qtEK5YSnG32wpljQigXtjOtRLbFiVogeNwg4U2vH7k3GfMauaLM3mpivqpcFm1Jq1CJnlcjurjm6wBKamWlgT2CGQXGdFl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q31x95vshRaMt6LYdyGFKP1Uho5ZTHdnJI0Td8Azb6M=;
 b=Ngk6+o8SsmoQzx3LqX/gLhZBv99cuyeAo6l2pSIx8ak8X1yLGWbQlMTGbVEk9vH6TZpDq63JqZ+u1xZejqeEIZLi4N6q8zcsZKxjEv5/o4db601znamquReX86xeD6cdkjaZsK3qyOldhhZuzCqE/mST8hJDytNvr69ayYH4laU=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR0401MB2484.eurprd04.prod.outlook.com (2603:10a6:203:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 06:33:22 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:33:22 +0000
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
Subject: Re: [PATCH 7/9] usb: cdns3: Improvement: removed 'goto not_otg'
Thread-Topic: [PATCH 7/9] usb: cdns3: Improvement: removed 'goto not_otg'
Thread-Index: AQHWT3AXzQ2TEp0xQUyCxuupShnoIqj7sjAA
Date:   Tue, 7 Jul 2020 06:33:22 +0000
Message-ID: <20200707063331.GF16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-8-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-8-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 084114a8-402a-4116-7ee6-08d8223fa586
x-ms-traffictypediagnostic: AM5PR0401MB2484:
x-microsoft-antispam-prvs: <AM5PR0401MB2484059BFA1A3722073374BF8B660@AM5PR0401MB2484.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kECpKcorRJ7yZLG1YNUwJjgC8qDRV1bdoydnwBJo6PZ50yiy7yQ2ApUOssM97G9AIpo8RqM2HiDJoPYIuV/sOhV9aUl1+Vk4rxLqMYVSskoZhGzRWDUJAC+3EpU75zV81sQDsJSMDWSIQhclfKvjn8zRngbvNOexk2jkYP3zS6u1ineWwSaoSE/8AuT0ueOGfBKOt82u7mZ6fB3/LvoVDhEYPyXmqmIX+0s471DCFtWKExyeN6wNRKWdtVX2OKOgq+yO2koxKt2u+jjNPSdileKpKflIaGOxUgwGIRwnbcdNAZqEhJeR7+cj+WtjAtMk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(26005)(53546011)(6506007)(66446008)(66476007)(66556008)(7416002)(64756008)(66946007)(2906002)(4326008)(33716001)(6916009)(5660300002)(1076003)(8936002)(83380400001)(91956017)(86362001)(9686003)(6512007)(76116006)(8676002)(186003)(316002)(44832011)(478600001)(54906003)(33656002)(71200400001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0bBboUabgX0OqUEJX5wX0fZjIjo12efOxyhvG//4V/pw/X8++/0KRgWsGh3yzlshWg5dd19IUMCgZbH6qECwmUBn8OiAlQni7ZPzBkHoJYLcuTWmE/B+hxQiJOpd+dVEaY9xilUWYA5zL5vsXTqiP0J0EHGHLuvXwcQQ+M89ydO3RK0+JQToGZEKbNTzfuRIFIPDza2vCb02nGUsnBOO7ePBGgt6LI5pBBT7GIGx/5AkF1QARCekNQ7oEearkBwdPY1p4Sxe9qApaE+UVuXV8JixvetvBj5ka90Q5/NWzSewLb0KtDg1q0JIpuDbDt7CL2b3TOcSAV4kEIRm+T7jjPipEG6g9VkCbQZGA+bVWJ/CPa/kVqetZzNqyERvf4EQVq6BHm9npDp64qnW5XXRC7jU6vYSNyt5/4QCC2y9iMz4+xyAgSYB4RcmnI8Ttnqyfut1lPeue+QT3HwTZVzbSBgI/Kebjx91qKx1ZZH21Mtop31qXrZL3jnboM5MVBU4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEEB3A7064DADA49B0CC94A80079BC3E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084114a8-402a-4116-7ee6-08d8223fa586
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:33:22.7248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mr3uO2NOxhtcsemigYme5i4LwyDAb29dkIy10X41r6oJqq9S1/smoW/KSAdYcK3Hu287U4ZkbG+5UwURURKuMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:20:02, Pawel Laszczak wrote:
> Patch removes 'goto not_otg' instruction from
>  cdnsp_hw_role_state_machine function.

Should be cdns3_hw_role_state_machine.

Peter

>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index c3dac945f63d..591186987245 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -191,11 +191,17 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>   */
>  static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
>  {
> -	enum usb_role role;
> +	enum usb_role role =3D USB_ROLE_NONE;
>  	int id, vbus;
> =20
> -	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
> -		goto not_otg;
> +	if (cdns->dr_mode !=3D USB_DR_MODE_OTG) {
> +		if (cdns3_is_host(cdns))
> +			role =3D USB_ROLE_HOST;
> +		if (cdns3_is_device(cdns))
> +			role =3D USB_ROLE_DEVICE;
> +
> +		return role;
> +	}
> =20
>  	id =3D cdns3_get_id(cdns);
>  	vbus =3D cdns3_get_vbus(cdns);
> @@ -232,14 +238,6 @@ static enum usb_role cdns3_hw_role_state_machine(str=
uct cdns3 *cdns)
>  	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> =20
>  	return role;
> -
> -not_otg:
> -	if (cdns3_is_host(cdns))
> -		role =3D USB_ROLE_HOST;
> -	if (cdns3_is_device(cdns))
> -		role =3D USB_ROLE_DEVICE;
> -
> -	return role;
>  }
> =20
>  static int cdns3_idle_role_start(struct cdns3 *cdns)
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

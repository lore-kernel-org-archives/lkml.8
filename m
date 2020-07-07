Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343B6206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jz2Yms7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGGGay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:30:54 -0400
Received: from mail-vi1eur05on2063.outbound.protection.outlook.com ([40.107.21.63]:38033
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbgGGGax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFpszsi9cT6jr8M4YElpQivDPbuEJtXBdjtBaZYAnwdcB+5HC62BmPYX+k/5Wr9JOY8rDjl7riFqml/vDrogv2Qja1IE/mDI2JJnKpwCYBQq+0gbOx/u7HvGijFsI+FFa9t1HxNBakbwHe5ZBRkLNWNSmoepyTwHWlyB2QAOVVoKf20vnEnMj6PIeSAYbXMN5jLLUVBig1iPL5QXWgCObKzv+0CG1xyKKneSwSgZN6N2BhhLd5zdu7+kWgQw70r0lZBURHvSNmMPZZZbmCEfPFF2l2EdwDQu6ZCp2+sMsykzXuXLyGp2kcVsXZfb3sDa7dWuENAF42OBpLoJRRvYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCl10eeCjyjMXKl3UEJMcM7cWfDth6F8YuhcJlqlxxM=;
 b=CL/R/6JffNx63ZXoRIktJmz4Viy75yijNV6Ta3nkPVB/xesCUNdEKdmR8nK9pCJWRdXot7MBTiN/dKHyNFjYOXSmMmykcvGdKtTp53Vzbi9as6ywGLak2gOz35Q133PB+BJbmCGOWFOl+A/VRgBWrC+GvD9ZYbw2V+DKQ9wEYKpixcRYOHrItaWj8RxSUv/v4SLt9wyM/uDZf2oEH425g3fft5XLnX3RpZ8JA9/PGG+08tTu7c3eHzdK+mw/19df+lzQqFUR/C1Z3lUrMUbFA/cWNE25a5TdGKDx0vmy/Gvza7nvdOKMMl7sG9EsEvIhpuNEqWGmgi4u9j/GodE1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCl10eeCjyjMXKl3UEJMcM7cWfDth6F8YuhcJlqlxxM=;
 b=Jz2Yms7zStVFL7rJ+hM5MqCfy3r0lmccuYbcuLHbB6igdNBQXpF/lV5k6iLYHy1xhYS40WwWTCM+zk1jBcdadwN8AJIltBoTCPnkO/yKQuP8IS3KWCZBbvy1vq6UbcHGtlBAy/r5X0arELVYZ/VLIS1h5ExfUBJVvvDbnEM7lP0=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR0401MB2484.eurprd04.prod.outlook.com (2603:10a6:203:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 06:30:50 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:30:50 +0000
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
Subject: Re: [PATCH 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and
 CDNS3_ID_HOST
Thread-Topic: [PATCH 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and
 CDNS3_ID_HOST
Thread-Index: AQHWT3AYVVVPDhft+UO/YATov584VKj7sXqA
Date:   Tue, 7 Jul 2020 06:30:50 +0000
Message-ID: <20200707063059.GE16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-7-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-7-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4454d870-8bd3-4b41-5bbf-08d8223f4aa9
x-ms-traffictypediagnostic: AM5PR0401MB2484:
x-microsoft-antispam-prvs: <AM5PR0401MB2484C8C6AFE804128BC9700B8B660@AM5PR0401MB2484.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfvUcWLoHIQDb2tHI47yv+8qzZMTWswTWSri+QheEqBk2kzv6PSF6t24HI6vKnRkbwhIR5wbcp0MJG4mplWMPBcAPSxNUb+WWKD7NkHacY50/diB4mZa7bO85YprFrxt3YPFcbFoCpdu0uGYUWbnEOO2nuYIub7TIsSx4NbbxRnTS8rFKBzt2ceCciUOx0VIlTRXOs0DjgsZYGK345P+qgn1yiBhQRbZxOAojCjRbcvtom8tDdNeyAtKCSKISxxcJRS91UQKnCVJ8ridh13U3zkx4DDRLe9TknNgPLeHBDZdlzN5C+a8cDpiBjDxOqivMaSnVHxBnu8rYNTOWJVpZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(186003)(91956017)(76116006)(8676002)(6512007)(9686003)(86362001)(33656002)(478600001)(54906003)(71200400001)(6486002)(44832011)(316002)(2906002)(53546011)(26005)(7416002)(64756008)(66946007)(6506007)(66446008)(66476007)(66556008)(83380400001)(8936002)(6916009)(5660300002)(4326008)(33716001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GdhTDqfGOycraDOR+hiXESVs4UXfKmQnE217cY04AoKiYHr3w8zkarfY2VACFAkNLtQH7DaGX456I0iz9YaUDJvDb5bxcy9c1dixMMv97UDNJs1WmPfs45rAA6orqaBQugNkd6oaHaGpcdVFSbyVjI9YP/jYwtEOtteHflbet4Tw1r4TxEMy03YslKyhwSAGU1MAo/FBpk2cx0du90wGpVlzy7PVqIoWPnVa42ZHv24J6k6V1P43KKKlvUuiFisT6TUIt9r+/yd86bT0nTyTC4jlKGJMtUx4C76jBWchAttNQKvy/ZGBa8DAw3pvu1Q09a8z+keEFuk+thgOdPRtsE5Oc19FFBh16098sFElmBXlnSchpsUgR8jXNqQXII55P64Z681aHpHrVT2fKJG8D3/S6dajnvqq5S4MLVrS9wkJ7kdnA3jH3BJaxIqep/oqw56g6oPED1B8BdzkcNXgN4zrufiVtDrc7VZsbSGeYM8RYoHD8KlE0MR1rZwVs5Nz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C596E9F0B24AAE43B287373CAF628AC3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4454d870-8bd3-4b41-5bbf-08d8223f4aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:30:50.2637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xO3wIt047czEJnpxQ6ojrBkNBV39wukOdOamR0WaD7EYNY+THqu1a2Xj4TwEBRsfrCL5Rw3qUrwAwnH8b0TSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:20:01, Pawel Laszczak wrote:
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
> +#define CDNS3_ID_HOST			0
> +

Instead of adding MACRO, I prefer adding comments at the code to indicate
"ID=3D0" means it is host mode, "ID=3D1" means it is device mode.

--=20

Thanks,
Peter Chen=

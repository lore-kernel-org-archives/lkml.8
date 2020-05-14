Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B09CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA81205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="doQPCXjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgENCvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:51:48 -0400
Received: from mail-db8eur05on2081.outbound.protection.outlook.com ([40.107.20.81]:34977
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbgENCvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5bEp3b5H7CNjUcU3G+uCbpnGTMvFJZJfbv+G6y2LlVPJiGHrMbs/xFfHw4AVF3dDVwXlyY5zVyK4i3NlBH0Y9yKjwkhZq65xOzL/shU+eET+j4lfuBgfYSu8wfP1DGvuDMjdt8BNN4AgPL1eYayPhIZqJDXAT78Ooxg3PlAuCRdrPrm74hIGFb6CsY15JR9OAuaD14JRJkrFee8y+uw/DWWy4D3I4+L/n9zGIdBYguy9xXdngL4/yyWsb1cxgd985bcD3oIPQ9vjVju6ER60fZsFA+2c1bSVtV3SmuoHMQsMu+nWWBDkm5BFYFQjpmLT4tJn9fjM7WFEvoFF/nLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rX/hwCCUaCVU4an3j6ByPIhEd18ho0mXs280UemoOg=;
 b=fHTOpfMiL1MEhZP7R8RknXptVzltUIY9dmTLQC+m39AJWWt1ypJOfL3eJ0wK3xcnLvFkLhZjWvFxUi8gUuFRuGCVeFlE9WCzGjf+6tVJ3Ap+P4MTugMRoClCazmVA242wGf3V6EU9w3nrnYJ2ARa/v0kcr7ykwZQr4cWXGI82Mh2gwdCe9nOKiTw0lO6jUuM4fE+g6SjEOKtVllTTt8ber/LbdbA3zFBzcvZhS5/wjyNjfWNWJBq4bC1xsi+7E/JzDeVmpm4gyNvUhZQ26AjKfoY9EMnHpr4q9hbP6kHb0JXkQuDh89/qDLmhV1xcdRIkK1x9OtAx/jJ7UabSPx5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rX/hwCCUaCVU4an3j6ByPIhEd18ho0mXs280UemoOg=;
 b=doQPCXjKg903VrBevvHHI9SrQ97W5GxLOS/+HbqrGDUYz0SN2GxgaNxm6BB/U0LnvFXYa/rc7elfK3yDYFW7vIDW6m0jwMN6kkKm9vNFbRAnlCvIxez6IUonWmqSEldAonMdH3lzSXv5jHJ5o78cebbIfruXXw+0DvczcnxTUDY=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 02:51:44 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792%9]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 02:51:44 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH v2] USB: host: ehci-mxc: Add error handling in
 ehci_mxc_drv_probe()
Thread-Topic: [PATCH v2] USB: host: ehci-mxc: Add error handling in
 ehci_mxc_drv_probe()
Thread-Index: AQHWKSoqHwlWXc5HRUSHh26WGa8dzqim4vkA
Date:   Thu, 14 May 2020 02:51:44 +0000
Message-ID: <20200514025206.GB20346@b29397-desktop>
References: <20200513132647.5456-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200513132647.5456-1-tangbin@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cmss.chinamobile.com; dkim=none (message not signed)
 header.d=none;cmss.chinamobile.com; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1f68066-0a3c-4517-6068-08d7f7b1bcc6
x-ms-traffictypediagnostic: AM7PR04MB6920:
x-microsoft-antispam-prvs: <AM7PR04MB6920A0987C9C10BC44F2ED9D8BBC0@AM7PR04MB6920.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzJeiu6yW3NVuIbkNOqKdACN60zni9mwGIKo6Ik5ET4LRgV4RGfABspmi7gdCei9ZoE38iC7a+sP0waJ4Wn9QUznZOr6OBhpEGeQCcMUrNu8lW8H/Kd2s03mghCNtGwDgUFf9/ORyuYTM1oy23N+wARvmiK3iC1bxu/GeH31XbqOwRCkj3IfqszCME34A+x1NAvEob1hihzBfoW117RUN+or9PXRIdHOqkqFnS14O5OUjz8ZltI9TiPD7pApUOqj36G50MB+/n1sfk3AMxAbOVV8jawNxxXiVQtRRZ62Am0+Jeqk3xrjNhBIi+DIMr6MY7fGSsLryrRQIUylBw8RU4VZ3cd1qhuCyRK2vqKpzAUNGJIJYWNtFOxJPQei0VC7cWegBjknkaKSJwPkjOteaQQVs0FVexEg9Yn30NNh9Io8NXkso4pLyHuFBFlpujjp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(8676002)(8936002)(6512007)(54906003)(6486002)(316002)(26005)(5660300002)(186003)(53546011)(44832011)(86362001)(33656002)(2906002)(6916009)(66476007)(1076003)(33716001)(71200400001)(4326008)(6506007)(9686003)(478600001)(66946007)(91956017)(4744005)(76116006)(66446008)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vAeG2auTBSc027YVla/hsBV7hjSky8kFV/yczPmI2DKH1HSogHvajy7MOwx8tuu5d63zW9MB2Of8WeLCOYju+i3jZ7aB57dIsadpY/G+4ovgr9/MnmL2thmwmO3ZS3rRomTsaPqSBkS3UgjIGnhCwZokTlw7hOD4ViXIer0yiBMAu98EUdn6jo8Deke1ELLoJrO3TP6vDTjmN8KYmyLlo7Xhg+9LCRiB3efBWu0KnfyaSqsn2MT9YtTM2bxeixieAyToRepuXLMyP8ryb98bh3NRdYAGKy/xmhY4q8xDlqWBbYvSTgKyX9nyFZUapmcQ24FIRloZWN50hdko56o8n48WcyKIw1F830AHJkqiE1R/z9SlnnBTXOMtbEDlNNKxM8jahiPfKFGnfNTGgCkoLFCZhXG7cE6NmGxaJWHPSksPCRyI/3x0vmb5Dcb7I6Ed5hPJv1zutVA9+IdlGRf4++oI8EJC1wLiDs3EiT556Rw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C724AFC661FD35499D3D8AF10E7D0AE1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f68066-0a3c-4517-6068-08d7f7b1bcc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 02:51:44.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEe+J5zWar11OqVaUjwkluDzzY8MhYmATWOqwvoL9FOV1TpLKm/wBVXuFMG5OFGhAY3gLyl7ZzYcbaEgyOxKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-13 21:26:47, Tang Bin wrote:
> The function ehci_mxc_drv_probe() does not perform sufficient error
> checking after executing platform_get_irq(), thus fix it.
>=20
> Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards=
")
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
> Changes from v1
>  - fix the subject.
> ---
>  drivers/usb/host/ehci-mxc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index c9f91e6c7..7f65c8604 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *p=
dev)
>  	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> =20
>  	hcd =3D usb_create_hcd(&ehci_mxc_hc_driver, dev, dev_name(dev));
>  	if (!hcd)
> --=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=

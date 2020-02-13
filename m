Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF8FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B50022314
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F19JJB61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgBMVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:11:05 -0500
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:6072
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbgBMVLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:11:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKNapBkBk5HNc2YH0AultyrR8u1kdeGyroEqBsdoYjtLzQ+gQk8XUHH1NaYSCGk3h+a3PXDHAsmo0E5sXY8zm7JZsMGPB/IqrDlhRhqVAsdKbX8iciBx6Q5djNCnUDwJiK2I2khG83jtg8jLJAsUfRYcw+jC+K1np3I6f/rKQXd9zWzhG18nIZYHjH/yM6HEd4uoRlJ7C2yp1f/XFpioUhzMJ+iCHp8oXjiDWTGT9o6BScR7JkhI7LwEZdU2aGNIIWBOgfuk89NMilN5wCcDOe2DHHkretOdNby3In20W9F3FOI057MLTjIpcSRmj5bw5zb1WJzbyweMtuSHEQO/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tB5uNrwZvDexppwe2gL71fzrDdHq2Nen4VRvguxqqQ=;
 b=fU/MHpPJ3liLXF+DpSoBzEB4ce7dD3GaIo4MUXT6T6WIaBwd3smU5Tq9U0AsoSnylgxvOUJdvMW//zCY8rQ1mPgdRNiWbXf96v1+smIJRebGveevUeIG1VWrlkWkXmovpr7SXPDMo1/8oM3/8JF8OSG7XfoqKKM5iwhdegQhKJrDFjN8wHlrSBOPk0FUA5E48LZIcm6GO3cO4rDcnUjwUjY2ZWZMX+J0SatyPlmsJsN/EZ9Wyj4MHxX57Kt634uSD3axs9lUx9GnHKjmtyP/rO16JmkCyeJS7X0buQEjyEyp2C85+lVf+2fNpfiu/EzxbwrJ7CCJK53eJhiX26VRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tB5uNrwZvDexppwe2gL71fzrDdHq2Nen4VRvguxqqQ=;
 b=F19JJB61AoDWhcb9RPMPXvMXdLDKf/U9u4bggo/OWePezqwv3ICb5+Li8XXvHpltS8moImabz4Sk5T/Rpy5Yywwd+vs+iQ/cvPm8UPoKktALHwrLFxhcVAHqcd+fhr2KdCRbbVOEp8MvJ5fI9K7uDjglf2WcKMN9fojr/JiG4e8=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6766.eurprd04.prod.outlook.com (20.179.235.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Thu, 13 Feb 2020 21:11:01 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 21:11:01 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
Thread-Topic: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
Thread-Index: AQHV4ksnZ2T5e7XCWEe+UUSA5ikK5agZncTw
Date:   Thu, 13 Feb 2020 21:11:01 +0000
Message-ID: <VE1PR04MB6687685FF0D3EA7485570ADB8F1A0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1ff63bb-c4f6-40f1-abfb-08d7b0c93aa7
x-ms-traffictypediagnostic: VE1PR04MB6766:
x-microsoft-antispam-prvs: <VE1PR04MB67663C1C27780777EFCFB83B8F1A0@VE1PR04MB6766.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(26005)(110136005)(54906003)(2906002)(186003)(71200400001)(7696005)(5660300002)(316002)(76116006)(8936002)(6506007)(81166006)(66476007)(81156014)(66556008)(53546011)(66946007)(478600001)(33656002)(52536014)(64756008)(55016002)(9686003)(4326008)(66446008)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6766;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B75inORmgMlrstd5/epg3ORtUO2xvushKVZN+EaeUzEXaGFNymnd/zqvt1PcDuxF13dO7g+pPRaFLf1EuaQOWBApKrnvdGcsA93eckU6FLnT68wiv5G/Ya2c7myHmreBK5QuajumF0R8ycCtzKm5PzZ9GEfFeKzUOMJ+i8vs6512bXV7sIFtOKXiak25k2ewwe3p/EoPA9jJmmgzqwbc5u14A8l1jor+3xF/5cSOPwaIgnkFPVpBYDAzmnPrmdErfgP0FLMXKC3YcejIuWHVrm1Fe9RGWL1hKtniXfloCHDGDScouWWC0rCMHQYsVYbh1rSvVHZbjIDsJ5AodFKOa+Cp82OmXrxSsge91vavKAC1o3SMPkRnUTY4itrO4e7KHzvfGv98aBx61mf/O0ix+ypxl+l4qmnAI3TbGQHV+5Ct9uT2ZDhVFppWFeSLGORH
x-ms-exchange-antispam-messagedata: jJoSE5nFRAEP7iztjle+FQ/DsbiE61oxyr/+aOdKWIaFEgSbIododPY2kaB6s1jqR9YUDk21Nu+G/5TjRGlKXVHUuL3uGLzf4GyvvN38GF7sp7fP4lNYVbykbTOuEXXg9TevgLc7ZDeDZrk2mtrlTQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ff63bb-c4f6-40f1-abfb-08d7b0c93aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 21:11:01.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIKpx6AXG+Cv9SdK7l/ONJsGX6HuE5AjmK7ihaygrFKI6FKZrw6DkcqYoFlEbt2pFVfzI3953fcQgkFU+CUCHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Thursday, February 13, 2020 2:54 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Timur Tabi
> <timur@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Gustavo A. R. Silva
> <gustavo@embeddedor.com>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>; kbuild test robot
> <lkp@intel.com>; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
> with fallthrough
>=20
> After this was made buildable for something other than PPC32, kbuild star=
ts
> warning
>=20
> drivers/usb/host/fhci-hcd.c:398:8: warning: this statement may fall throu=
gh
> [-Wimplicit-fallthrough=3D]
>=20
> I don't know this code, but from the construction (initializing size with=
 0 and
> explicitly using "size +=3D" in the PIPE_BULK case) I assume that fallthr=
ough is
> indeed intended.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 5a35435ef4e6 (soc: fsl: qe: remove PPC32 dependency from
> CONFIG_QUICC_ENGINE)
> Fixes: a035d552a93b (Makefile: Globally enable fall-through warning)
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>=20
> Two different Fixes: Obviously my 5a35435ef4e6 is the one that started
> making kbuild complain, but that's just because apparently kbuild doesn't
> cover a PPC32+USB_FHCI_HCD .config. Note for -stable folks, just in case
> 5.3.y is still maintained somewhere: a035d552a93b appeared in 5.3, but th=
e
> #define fallthrough that I'm using here wasn't introduced until 5.4
> (294f69e662d15). So either ignore this, make it /* fallthrough */, or bac=
kport
> 294f69e662d15 to 5.3.y as well.
>=20
>  drivers/usb/host/fhci-hcd.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c in=
dex
> 04733876c9c6..a8e1048278d0 100644
> --- a/drivers/usb/host/fhci-hcd.c
> +++ b/drivers/usb/host/fhci-hcd.c
> @@ -396,6 +396,7 @@ static int fhci_urb_enqueue(struct usb_hcd *hcd,
> struct urb *urb,
>  	case PIPE_CONTROL:
>  		/* 1 td fro setup,1 for ack */
>  		size =3D 2;
> +		fallthrough;
>  	case PIPE_BULK:
>  		/* one td for every 4096 bytes(can be up to 8k) */
>  		size +=3D urb->transfer_buffer_length / 4096;
> --
> 2.23.0


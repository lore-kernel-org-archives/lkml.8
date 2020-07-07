Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A865EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8107D206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmSe1lY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGGYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:24:41 -0400
Received: from mail-vi1eur05on2069.outbound.protection.outlook.com ([40.107.21.69]:38020
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbgGGGYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:24:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFFI0CxTgLklWEbSz0MvP/rk1wiChCKz2PkVRs07q1IDgPpd0tZXLt9fmdDd7SZE+RtHzBfAYseLYTA3I7eVpsLXrx8r7XEcoalBGy5jmcwWILZI+Lb8koBoI8foCmRCOFyHBbS+gnwOSW49lcCZy60TNTyWyMAsFQcQFbb3oCwIeEzCUxenKw0OSgfPCarzCTSpyBgTGzyYmuj575kuEZwACKSR0DG9rIDuXlA8NWbgX+p/rYLW4LuTnLe3rB17BA60qLL55djRqU9yqZTsZO4esCHNyPDbVQBfG3p8msvPVCM6FxIqpZafNMoxaw2WEnqqK3hiOv/l9/BXmymCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvHEEaE282tbIWmvbHEES7lvROb1p3/zYTLb//+Npv4=;
 b=gMBN34g2NgkzPynghKTjWNRsDeNF8Klsb2Tk75DloolJnGxHyuXH6JmvJ+z+uGG7UzTQDnefivuDkfWBZqdIZUc2DbI1mHT+gto5fz6BImNPGhmnPnrQlufVhWntvLj6iJvEII+o1y3MmTyr/mOwZGiR2ezeWGUpSV7gtjQQ4sokdRgIh/ObD8nGBsPvGZ+zNuYnGM/JY0xkG/1BChpabb8O2vxRuiTeNmtAbsg1Kx1vBKDZvf11etZOtsKUH7fX0Rtbx/7Nr6rDjBlsFRl5Am7LIb8LpinPXiVSSy/VRWz5l5MjRQOKaUlFUAKtdS4JV7Ks9DCuBsZoDaHucx+c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvHEEaE282tbIWmvbHEES7lvROb1p3/zYTLb//+Npv4=;
 b=BmSe1lY8GHPfRWconFjqWgEDyYNu9QRvmBfaSXGEtXHhGwePLBGA9S/WmtTDQWGIlxMYrCrUbwE7azJ1nF9eieC9+qsU5NSamkp4eGcR/BCwqkR0nCAb5NjjcPsBQEs8p74UUJwVXHHwqyBCLfrPa4DnvylSl/BWNfNs3kAGPFI=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 06:24:38 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:24:38 +0000
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
Subject: Re: [PATCH 3/9] usb: cnds3: Improvement: deleted !=
Thread-Topic: [PATCH 3/9] usb: cnds3: Improvement: deleted !=
Thread-Index: AQHWT3AY9oooruIrmEKoUul/1gn18Kj7r7+A
Date:   Tue, 7 Jul 2020 06:24:37 +0000
Message-ID: <20200707062447.GD16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-4-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-4-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a738e8d-3007-495c-c420-08d8223e6cb4
x-ms-traffictypediagnostic: AM7PR04MB6998:
x-microsoft-antispam-prvs: <AM7PR04MB699876C176EC17E69941F48F8B660@AM7PR04MB6998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XErZPCU4S68HNbMLF/wrUn9m3iF4mwt4L8J48892TNjKgakHtI5zKRvqv5+fqrsJX9oD+1fd7xCTjchjyLpTsz9OhD9Cf1U1UYdV/gjM7/AFprmoF4NE+96sOskfec8hO40+tOl1ougDHx1yEvHBbdAS907kEPoIQjw3vSoJGAPs48gEKDL2y+0Q057Hf5/9WC3pJ+mYJok2jYKefKo9y5FSFL3fpmMwK4SobOkPUf4HeNFTQZ60I7CiyetI9mVivoNm4GlOehCIeDuYESZjMh1o17S0J2ej6fxsvAstSYgCShdZ+2SQW43NTAFChYZ02E1hO0qZC+mcJ7bB30uug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(8936002)(478600001)(44832011)(54906003)(316002)(8676002)(7416002)(86362001)(6512007)(9686003)(71200400001)(2906002)(33716001)(6916009)(66476007)(91956017)(66556008)(64756008)(1076003)(76116006)(4326008)(6506007)(53546011)(66446008)(66946007)(6486002)(33656002)(186003)(5660300002)(4744005)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zbmZwHoDFA5IPrJNbz50FCvomqOBM3A4Ll/ML/bXlaxJMWlRMygA8gY0IXskEz7ShaYJea+CaKEc96Dl/bLsYL9g90hvBPK4MzTzSfIPy/k7W0ERpJv82ZvCZUxrzGXPMBl4YrMYcO8yLyntdtEcRyZ4EVBQvN8Z/70lnQfba1Jt2B3XikzGh1bzQPDEPLLhd89xQO8S3/KRY/gXPxsA+LLE289c0kYfiRkCocFstEEbCLuTkkuT8i8otXCD3sxsUlIPeW2G9L5wFo8yUfD9291V0VRbkxcZPszrgItMLLS0IrdK62r5wNTDAee3m+tavxyFieqK4IghzhVlGiPBKmbWCZWdsIVhCjT8PUjP5NamyNe28P1fj/mA5w6u7wQaPbrfGgvSJ1gFXqXZSps8cQeovi5HxN9/eu0Zu3yIdmFj7U+P1Qvyr3bD0sVqwtvZiTHxVjBbznZz/vy8MakWIardGRHEm5OhrtxwA8lBHkDJDW5/UqQ6OfLlVpwZQk6Z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B64551B614AF6342AF7FB550D845D379@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a738e8d-3007-495c-c420-08d8223e6cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:24:37.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0nUB8QX9YhNOl0nmNaPOqlTaJsxmKVZQWbpr6iF7z8LBbSe6GunxjDag7i+8kxZOfOcxD3RkzrR3TSsvxVwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:19:58, Pawel Laszczak wrote:
> Patch deletes unnecessary !=3D from condition statement ini cdns3_drd_ini=
t
> function.

Change the title.

%s/ini/in

Peter
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/drd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 4939a568d8a2..6d2da504ad49 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -365,7 +365,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  	}
> =20
>  	state =3D readl(&cdns->otg_regs->sts);
> -	if (OTGSTS_OTG_NRDY(state) !=3D 0) {
> +	if (OTGSTS_OTG_NRDY(state)) {
>  		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>  		return -ENODEV;
>  	}
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

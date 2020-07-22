Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64837C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D192073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEGMvNln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgGVAeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:34:22 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:11745
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgGVAeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6rBf4lgj6B45HKDay9UQjQE4060AUuHOJS6OQOKBu+N9JBlQAaUf6Tbf/7jJ7VX8wHTQKUZDA9HztcR3IEFa3bDg7nKmSgECPXPEvPYwDNoMzluOMVUca1WAddudPSFmrZBQBgCzBrPTJbYDOQ79CqI5dThpl38hUCKpUbopj/usGqvVkjkgg6dQqahstA2vF5EJBShcGKy0V1tZZRSjDs15+y5Qhd1ObwEOTyKVU/1dIDrmmOXBqEgRL/MYbacWMvGW7BtqA9W369v0otROtN460WCsxgP1futH7Hbcuj1mi68pMxS+Kf4AVAlugq/2Ow6iSCI+zNfRiaC3o6E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnxPOnlA9DDSWRMtw4Sy76HCX6Pbh8AXwdRgvzks9yQ=;
 b=KaAkmU07/OpufKaBi7/H8LpjSRHZnJLQZ3mgzStWNnkoqghOe8C+7CgeCg6f7w9UcRkIIeMCNvn6E3cejAUOy6bMqtnyD72FxxFe7vHbAihgbsmRcjqWY3ZoR0ocFPaSbFNK81a8W2hqyfXq/xv931H9xdP0e2Oyi402Gs5+7iYrUKSivvIP2ApjSq5rCCtrSg21XkFbJnt7iNTTdxuWXwWhJ/CA0KgHoWYfr3Qq56HvFQMatMUvCfwhbxHNeTq1IcJDITW2p9xilhTdLHf4ImaigexA7BkVsUZdNcJLU9el7LO+vmPi6Poqg/7CMdAZZ2vyanMDNPl3d5u5ojra2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnxPOnlA9DDSWRMtw4Sy76HCX6Pbh8AXwdRgvzks9yQ=;
 b=PEGMvNlncnlNUd5yu52B4U5kUZzVovZug4qPD+9UGvF8HPwwYRcC0ebMnhnP/DU3uYT6zkeSwpFLSbvy47OcQW4dKNCAKj8tprdx+shSYSbTpEftUrpVM2dnc92TA7dNbicGpUD4QgLVYeSiHxBNoiK5wm85aRY7OkvmzALg7Vw=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6440.eurprd04.prod.outlook.com (2603:10a6:20b:f4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 22 Jul
 2020 00:34:15 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 00:34:15 +0000
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
Subject: Re: [PATCH v2 2/9] usb: cdns3: drd: removed not needed variables
 initialization
Thread-Topic: [PATCH v2 2/9] usb: cdns3: drd: removed not needed variables
 initialization
Thread-Index: AQHWWP1GNbfFQJ555Em+ijhlTcauyakSzaGA
Date:   Wed, 22 Jul 2020 00:34:15 +0000
Message-ID: <20200722003405.GA5807@b29397-desktop>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-3-pawell@cadence.com>
In-Reply-To: <20200713100554.28530-3-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02b94dca-b52c-4ce9-7101-08d82dd6f693
x-ms-traffictypediagnostic: AM6PR04MB6440:
x-microsoft-antispam-prvs: <AM6PR04MB64404CA02F36DE3587D9D7798B790@AM6PR04MB6440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:217;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Xt9rtm42ua3+NAZuh01J+wqawqBD59E0W/HL4i419f751LxFgiKOZQSjHb4kipTTvTGWt3LAYJ0n7UOKaGBlCxH3vWRB0T4jnmWqmvaQvyv+Us+p26QYVF0vGxVZz4MZWehWpbTnkoFdpoGMxOL4UOix66YGUdYOhavOA5VQGmlTwYFIcXSWppysCxhoFSWuG3iFUSnw4dNUQcWyZ9T1K8tcgqPhftrashTU4tXZElgksfQf9JjP6DKGnpPrpyAcYtAFRzBCWLCm8K/EUVjfzRT3X0kRn3a3svTVE0qzLav9oP+26Lp3GZ7NnMJu5EobPA7UZwS8AvtIIuGxyKZmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(6486002)(33656002)(6916009)(478600001)(6506007)(4326008)(7416002)(186003)(53546011)(26005)(91956017)(76116006)(64756008)(86362001)(316002)(44832011)(8936002)(71200400001)(33716001)(66556008)(54906003)(8676002)(2906002)(9686003)(6512007)(66946007)(66476007)(66446008)(83380400001)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IkX8U6kmQkjdY+3U3aA62MWpL5QSTOHAM0ECrczLLLa682glS+IvqjIbnITjU/Fy0j+HW28uY/1v7XPovTrO9SBQ1nvXTlxpOz3/bNBVPDWx1sh01GCSP1JAYsIg0+QZldeZvlBi71d+44ZuA58Pt9NmT2OzyltFT+8igKGMHUPXCXIfuBhaprnR2QR5UWcBYyNrZTueF55VlnapcY4dDlcBlyh/DcXma/owiMvVSQhIAM+RUyeXiB3lKrq3tMOn5apa5tkiOVBNmQ9PbDrKGdTl20MdzANOtYtOYXK4UrIe1JMlsnN+x+xbt/ecUc0TAR1vNPo3sNE20khuYc0dFSaJgRfXyRN8U2bhmPcxEc0joCT0O7L22yATQ5ftkyRRTA0cjFf+88xnXcI13F+yT31j6OKL9VRvMTCaUpcKazOzlcWwcp9tkTJE7kWLiIsBC5oSb+Wyk2vef/WrjnoMfuZ/4rLsMFLmawvyZOqlEEhcTSOYtO68bQHVFWKZpZbH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE5C5CC2B3BD184EBA17A0DA95D512EE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b94dca-b52c-4ce9-7101-08d82dd6f693
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 00:34:15.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taUwBeRWUah6P5oaGhhZyaj7jm+48R8g+bPhuzMojZzzZ9AACkJCYCzspDS1GYl0UOXpFYXSJTaOXnOZ5oJxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-13 12:05:47, Pawel Laszczak wrote:
> Patch remove some variables initialization from core.c and drd.c
> file.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
> ---
>  drivers/usb/cdns3/core.c |  4 ++--
>  drivers/usb/cdns3/drd.c  | 19 +++++++++----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 1f77fb5aefbf..c498b585eb13 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -86,7 +86,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  	struct device *dev =3D cdns->dev;
>  	enum usb_dr_mode best_dr_mode;
>  	enum usb_dr_mode dr_mode;
> -	int ret =3D 0;
> +	int ret;
> =20
>  	dr_mode =3D usb_get_dr_mode(dev);
>  	cdns->role =3D USB_ROLE_NONE;
> @@ -177,7 +177,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  		goto err;
>  	}
> =20
> -	return ret;
> +	return 0;
>  err:
>  	cdns3_exit_roles(cdns);
>  	return ret;
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 58089841ed52..4939a568d8a2 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -29,7 +29,6 @@
>   */
>  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
>  {
> -	int ret =3D 0;
>  	u32 reg;
> =20
>  	switch (mode) {
> @@ -61,7 +60,7 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode=
 mode)
>  		return -EINVAL;
>  	}
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  int cdns3_get_id(struct cdns3 *cdns)
> @@ -134,11 +133,11 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns=
)
>  int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
>  {
>  	int ret, val;
> -	u32 reg =3D OTGCMD_OTG_DIS;
> =20
>  	/* switch OTG core */
>  	if (on) {
> -		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> +		       &cdns->otg_regs->cmd);
> =20
>  		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
>  		ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> @@ -212,7 +211,7 @@ int cdns3_drd_switch_gadget(struct cdns3 *cdns, int o=
n)
>   */
>  static int cdns3_init_otg_mode(struct cdns3 *cdns)
>  {
> -	int ret =3D 0;
> +	int ret;
> =20
>  	cdns3_otg_disable_irq(cdns);
>  	/* clear all interrupts */
> @@ -223,7 +222,8 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
>  		return ret;
> =20
>  	cdns3_otg_enable_irq(cdns);
> -	return ret;
> +
> +	return 0;
>  }
> =20
>  /**
> @@ -234,7 +234,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
>   */
>  int cdns3_drd_update_mode(struct cdns3 *cdns)
>  {
> -	int ret =3D 0;
> +	int ret;
> =20
>  	switch (cdns->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> @@ -307,8 +307,8 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
>  int cdns3_drd_init(struct cdns3 *cdns)
>  {
>  	void __iomem *regs;
> -	int ret =3D 0;
>  	u32 state;
> +	int ret;
> =20
>  	regs =3D devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>  	if (IS_ERR(regs))
> @@ -359,7 +359,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  					cdns3_drd_thread_irq,
>  					IRQF_SHARED,
>  					dev_name(cdns->dev), cdns);
> -
>  	if (ret) {
>  		dev_err(cdns->dev, "couldn't get otg_irq\n");
>  		return ret;
> @@ -371,7 +370,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  		return -ENODEV;
>  	}
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  int cdns3_drd_exit(struct cdns3 *cdns)
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

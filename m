Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F453C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CFD20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSWQ9pSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgGHGxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:53:48 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:35951
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729535AbgGHGxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6l85BcTB93s7R/Tzv96H9UZgoX0AtDU5Q2Tn3h5GtRL54dyVqSKA8nvygt7ej4qTZCoO/LD1C4dbq6RuSmHgOOGoCiCP4ZSlCMlJT3a7x8JGF1ISlmKjis5vdk9uOcELvazygQ+S7CDOYd1z3YxXUwdg0vx+usOON9qbLX5w5uaZXZoU0zCGJ3GTN3qoWTdGGNKEKR5CRlHDOf9ty+MRf6EjjtUvqWhvHlG1+yxVnx63xjRtETKmCmd+jtb08lzHGOdbWhGd72u+ht20YSbzc3Uav4WlHq36C2W25NLq2NYsG7/t6Vcm6oWBDj7UIW0rRJyNSNc97X1AoK8dhR4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2lZnREhaEcX5Y1doqMGaWdih0XWZNQgp/btD6ZewbM=;
 b=NWtfrTP99WQkX1CQpFAwtpp9J2JLZeZdczQZUwtJPuPlAnNSDsyfcDrTM7FeFVVn35s63/27kdyj5enyIt2wtk5qEbHNXcwN2/j1H1e5lD1sfizaIzVyj5m7UweoQJPciY2GNrZMHwSgiGaI98zikf4nGr4aUTvLUJeTld4LBcsA5kBSw2t9JyDNL/KRDHLrRz72iw6UpqxTLIDZGL5ze4/a2+sn096rly5VUxMBglQ4mYBDHs9LX5hrvoDuHOb+sFFInbd2ThL/h1j/8bkHP485eZqBdMnw1/6DaiTPPNNasj/wJ1hwcGkz+NTwsqVt9RM4DuXyVBwTvj9glC2vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2lZnREhaEcX5Y1doqMGaWdih0XWZNQgp/btD6ZewbM=;
 b=OSWQ9pSbVFZlu7G8NgOs2pn9hSxC3n7h6FwjygbTgtED5Wbjath9iCg7igvuhGCjOfqHBcLEylJ44RqOwQikQlRAOZ6tQavKU1ffHF2gDeu4izDuwLTMBl1/hGtIrTTuN3d2DuyHT1hwuqst5+MAJi4UPWLctycuw5jGq5wFdt0=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4632.eurprd04.prod.outlook.com (2603:10a6:20b:1a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 06:53:43 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 06:53:43 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH 2/9] usb: cdns3: Improvement: removed not needed variables
 initialization
Thread-Topic: [PATCH 2/9] usb: cdns3: Improvement: removed not needed
 variables initialization
Thread-Index: AQHWT3A7xx5kHJrdX06bV9HY3fSaRaj7r3CAgABBD4CAAVm0AA==
Date:   Wed, 8 Jul 2020 06:53:43 +0000
Message-ID: <20200708065352.GB18440@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-3-pawell@cadence.com>
 <20200707062341.GC16073@b29397-desktop> <20200707101633.GV2571@kadam>
In-Reply-To: <20200707101633.GV2571@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30c2c242-f687-4c53-411c-08d8230ba794
x-ms-traffictypediagnostic: AM6PR04MB4632:
x-microsoft-antispam-prvs: <AM6PR04MB4632938A59AE5994A078970B8B670@AM6PR04MB4632.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEYSz5G+0uKm7lNXqdpDY8+ZtbBLdIqZcgRzHmjIw+Df9kMjjXdjKa3Gp2DibZCdBCAAD0aAzSifCKDs12CzwQePLF2tlo85VM7UZGf6/JTBnvQcb49lhIxnyYMCDirf811NtqMQkTQkc98ckz8yhwArEAC+0Bwl7E7XB2wrkBSrLIhbGYrPgm0vPorpGag9B8BSwA7BFWz3sWgEx8EledK0eNwhNOh96Xln1jTDAQyflsrvlnJCUt/ybSxqp//N5PLuv01Sf7zYDv6CAPxjXP37rggmVihDNk/EszRNIhs2GmCt6L6qDpENPFBo6YdFJt+9DOpcAKc+Sh9j/LoTXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(53546011)(6506007)(7416002)(86362001)(6916009)(44832011)(33716001)(66476007)(66556008)(64756008)(66446008)(66946007)(33656002)(91956017)(76116006)(1076003)(316002)(5660300002)(54906003)(6512007)(83380400001)(478600001)(9686003)(6486002)(2906002)(26005)(8936002)(71200400001)(8676002)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wh8abxitcOAovIKz+eFQtCeXrDX3GIDzAn3VnneltDv3lAi+wSYKrB9Mlzk8TV2tfG5aaV0bQ+a2AHXwdEgCsDd+1cluI/NniuTj/Qccc5HfZ1iFIMCi2ET7WASOYnyadajV0Qn+Dm2wih2vFE6T9PNST9f8zybTE/Vy2NrIrTOmu2SkxA3t3wbcU7ZqFSqrvj8dbWUWqYty6/TtMDEuR5gQ6OZLeCyrS2H5LLWSUcmoiLdtOD37VSv//glKlTuyr9uHyVI8S3d8OoRRlo1WyrgfaKn4CwPEVEOmIhB1RyPHB9kzLEpNJv8vckAHz0vrv+hkaCZLYraBDgHJNZZsrBgVTB18CIZ/KSRrKYx7KcBrAvHNCGGuU2E9VHT4Uou4dAOl+PEA7z9BkNxGDWAWHkSnn+fEJeh2yhPmZ1f0I85mj7Bm8VDDEZ7Euwisomk2zKn4lRoGVOtpUGF+lAOX1Xs0PyTYkMyapJ0h1DPkUdumvUiq5TXLiF/1Cf/lXmzH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D931944FB3554D468C8C64F4E4884532@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c2c242-f687-4c53-411c-08d8230ba794
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 06:53:43.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOuqZ0ztZF2uqu+jZHLNF+hwHqXlKd8X3hwTI49uu3Oq3xbByLG4bMd96p7eDRi02SL/qm9T2qdjkhlbbsIVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-07 13:16:33, Dan Carpenter wrote:
> On Tue, Jul 07, 2020 at 06:23:32AM +0000, Peter Chen wrote:
> > On 20-07-01 08:19:57, Pawel Laszczak wrote:
> > > Patch remove some variables initialization from core.c and drd.c
> > > file.
> > >=20
> > > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > > ---
> > >  drivers/usb/cdns3/core.c |  4 ++--
> > >  drivers/usb/cdns3/drd.c  | 19 +++++++++----------
> > >  2 files changed, 11 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > index eaafa6bd2a50..c3dac945f63d 100644
> > > --- a/drivers/usb/cdns3/core.c
> > > +++ b/drivers/usb/cdns3/core.c
> > > @@ -86,7 +86,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
> > >  	struct device *dev =3D cdns->dev;
> > >  	enum usb_dr_mode best_dr_mode;
> > >  	enum usb_dr_mode dr_mode;
> > > -	int ret =3D 0;
> > > +	int ret;
> > > =20
> > >  	dr_mode =3D usb_get_dr_mode(dev);
> > >  	cdns->role =3D USB_ROLE_NONE;
> > > @@ -177,7 +177,7 @@ static int cdns3_core_init_role(struct cdns3 *cdn=
s)
> > >  		goto err;
> > >  	}
> > > =20
> > > -	return ret;
> > > +	return 0;
> > >  err:
> > >  	cdns3_exit_roles(cdns);
> > >  	return ret;
> > > diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> > > index 58089841ed52..4939a568d8a2 100644
> > > --- a/drivers/usb/cdns3/drd.c
> > > +++ b/drivers/usb/cdns3/drd.c
> > > @@ -29,7 +29,6 @@
> > >   */
> > >  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> > >  {
> > > -	int ret =3D 0;
> > >  	u32 reg;
> > > =20
> > >  	switch (mode) {
> > > @@ -61,7 +60,7 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_=
mode mode)
> > >  		return -EINVAL;
> > >  	}
> > > =20
> > > -	return ret;
> > > +	return 0;
> > >  }
> > > =20
> > >  int cdns3_get_id(struct cdns3 *cdns)
> > > @@ -134,11 +133,11 @@ static void cdns3_otg_enable_irq(struct cdns3 *=
cdns)
> > >  int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
> > >  {
> > >  	int ret, val;
> > > -	u32 reg =3D OTGCMD_OTG_DIS;
> > > =20
> > >  	/* switch OTG core */
> > >  	if (on) {
> > > -		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> > > +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> > > +		       &cdns->otg_regs->cmd);
> > > =20
> > >  		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
> > >  		ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> > > @@ -212,7 +211,7 @@ int cdns3_drd_switch_gadget(struct cdns3 *cdns, i=
nt on)
> > >   */
> > >  static int cdns3_init_otg_mode(struct cdns3 *cdns)
> > >  {
> > > -	int ret =3D 0;
> > > +	int ret;
> > > =20
> > >  	cdns3_otg_disable_irq(cdns);
> > >  	/* clear all interrupts */
> > > @@ -223,7 +222,8 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns=
)
> > >  		return ret;
> > > =20
> > >  	cdns3_otg_enable_irq(cdns);
> > > -	return ret;
> > > +
> > > +	return 0;
> > >  }
> > > =20
> > >  /**
> > > @@ -234,7 +234,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns=
)
> > >   */
> > >  int cdns3_drd_update_mode(struct cdns3 *cdns)
> > >  {
> > > -	int ret =3D 0;
> > > +	int ret;
> > > =20
> > >  	switch (cdns->dr_mode) {
> > >  	case USB_DR_MODE_PERIPHERAL:
> > > @@ -307,8 +307,8 @@ static irqreturn_t cdns3_drd_irq(int irq, void *d=
ata)
> > >  int cdns3_drd_init(struct cdns3 *cdns)
> > >  {
> > >  	void __iomem *regs;
> > > -	int ret =3D 0;
> > >  	u32 state;
> > > +	int ret;
> > > =20
> > >  	regs =3D devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> > >  	if (IS_ERR(regs))
> > > @@ -359,7 +359,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
> > >  					cdns3_drd_thread_irq,
> > >  					IRQF_SHARED,
> > >  					dev_name(cdns->dev), cdns);
> > > -
> > >  	if (ret) {
> > >  		dev_err(cdns->dev, "couldn't get otg_irq\n");
> > >  		return ret;
> > > @@ -371,7 +370,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
> > >  		return -ENODEV;
> > >  	}
> > > =20
> > > -	return ret;
> > > +	return 0;
> >=20
> > Is this necessary?
> >=20
>=20
> "return ret;" is not immediately clear like a "return 0;".  I review a
> lot of return values so it's really important that the code is clear.
> I'm looking for places which return both postives and negatives.  These
> should always be documented but the majority are not.
>=20
> Also another thing is that when people do:
>=20
> 	ret =3D some_function();
> 	if (!ret)
> 		return ret;
>=20
> I review all of those because a bug that we sometimes see is that the
> if statement is reversed and the ! should be removed.  A third thing is
> that people sometimes do silly things with the last if statement in the
> function.
>=20
> 	ret =3D one();
> 	if (ret)
> 		return ret;
>=20
> 	ret =3D two();
> 	if (ret)
> 		goto free_one;
>=20
> 	ret =3D three();
> 	if (!ret)
> 		return ret;   // <-- UGH!!!!
>=20
> 	free(two);
> free_one:
> 	free(one);
>=20
> Please look for this and tell people to not write code like that.  It's
> always better to do failure handling instead of success handling.
>=20

Thanks for your clarify.

--=20

Thanks,
Peter Chen=

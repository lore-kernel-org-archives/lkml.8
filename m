Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1125C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8202176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hnK2plRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgBRHXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:23:49 -0500
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:6132
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgBRHXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:23:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8Nt2mOFUWLam8fjB7hz2f4LFJ6u6TGL0PkPNKMeZCZSCQuySZVndnlW0hGgcdw7lwdxXd22qtQHmJ6JqQawuJbVn/L1gyudvn5Xb7RfCHjCaGRcOp9HXq1U5r44qqi/MszWEsyi5DV+F1O7z8ViIo0WGogSmrmHGx4hgvUYHz9vAPeGAm18gs/0IAQ1+eLpQXda6iajYYH8c+b+49p5XaWX0vpULxyhidxoquvtUoCu/+OATuhB55VvlIbhezI6uKB2kLyC9TVa7l6XlbxHqIkNzu5nbEDpQvlwcoSFEtmqsR91W9zkSrdywyvboKXg0ucpfh1qL7iZMcov3h1vdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlxt91dm49Q1+xYCg/MKtlH5X4eNlGwfdhQ8t69brJg=;
 b=XiaBWE08aGbbbWT5YWeP3dyd614TKausbTIqdBpO/U6ZS9NQ2MT2nwTHcwyCOP93oKVxRQRmVeqUuRol1kQDZO+zBuLMIfHQqvpg1EOlu/XUHACLXCxtMobzJ4CNryVTaKY/5QMAQ94Oea35UQIJ3QkjJx7uI4ChsxOFbOOLPbw+Pyypg+RZRzS3iF6QZcLXaViZp79GVx7k4Jj4GLKeOqBNAamAbTTZgBD9YNLZCkcUnRxdyX8Gc1Sg7dQdd4SBSE48y3Gr5NH21BzyizLEIQ+8RyTzw6+xNWuj6i5uwkj+KrJ5x9JtjIOoRRA4nzohtQrYW+dd0iVRdTYi2q4gWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlxt91dm49Q1+xYCg/MKtlH5X4eNlGwfdhQ8t69brJg=;
 b=hnK2plRXFYO7nuuVNRtXDwpallEUmggnMsuBrFJGNjwnjczqBL9QIlI0/RZeayF8vrBcXS7zeIxRNh9u4Z8Mn/ZpNrursJcwUXUyVQhnAer3YzzaHdha3QYxuR1xk7KTAlID07Zaa3KlLDwJpWxaIpaRdMy9pZo/vx2VjSUiYFc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4879.eurprd04.prod.outlook.com (20.177.51.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 07:23:41 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 07:23:41 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 5/9] usb: roles: Provide the switch drivers handle to the
 switch in the API
Thread-Topic: [PATCH 5/9] usb: roles: Provide the switch drivers handle to the
 switch in the API
Thread-Index: AQHV4nD6G15oErWo00iXG8zLCuhxYqgZHzyAgAd0koA=
Date:   Tue, 18 Feb 2020 07:23:41 +0000
Message-ID: <20200218072341.GA30350@b29397-desktop>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
 <20200213132428.53374-6-heikki.krogerus@linux.intel.com>
 <20200213133239.GN1498@kuha.fi.intel.com>
In-Reply-To: <20200213133239.GN1498@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67018166-469d-433f-a7aa-08d7b4437b2e
x-ms-traffictypediagnostic: VI1PR04MB4879:
x-microsoft-antispam-prvs: <VI1PR04MB4879E031CDFF6932E6D23D2F8B110@VI1PR04MB4879.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(26005)(7416002)(186003)(6512007)(9686003)(6486002)(54906003)(316002)(478600001)(44832011)(71200400001)(5660300002)(6506007)(4326008)(81156014)(8936002)(30864003)(1076003)(8676002)(91956017)(6916009)(33716001)(66556008)(66946007)(64756008)(66476007)(66446008)(53546011)(2906002)(81166006)(86362001)(33656002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4879;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qkcCfLiyjKQ2V9aljUFHuCD0nuFTmLWlsroUMYNApY8RDPFax6uvhug6+J51GGhjGv/Cg5/O2Wsm2x3TCVTPAk5e2L8aiMODtNfJWGtMyAYzgZgmGxD5cvACU0l08qmMCBw12VTgYYgoO5Ln9ZKcgraUR61k6OZ8SphCpDgvY7Ul0y7Xac5+lAfU/8F5ceKqm627mq2HQv1azQ0p0VzNTH3cGVYYQPCGxLUZtaBsleBmCm/xpOnn3AybYrdJ95oHz+/Zm20cxXt+Sj0vz56Fw7EEKBnoQlpxqs+mmrOoo6pQUh7rYToRZOJc2/Coe/R0s17UHOl8qz9xeWBisFxAAPqM7Uocwvsqds6JbTAV5nEoZOuVKwLR61CT4bqE8ySfGFthVBe16tBdTNSR0x0Onk3c97E3vIovuICtPbeVycQFdQmMTrSKc2wZwIK/IaS0
x-ms-exchange-antispam-messagedata: iNC3wsTJ2yKOdDhVtHAS0prDM2R/75XJkyZijp50Emtsbv1WRbgH6lljwQVp+G0pP0k0n0b3XlTj+k1ArEOx1NlmFDiUAcYZj2aPyadDrFUmh/NWjyIPuXZSmnBsPRX1k1vR2P3jtFE3PrqJM6ep5w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAEA8B48D0D4C341AB7350F72231343E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67018166-469d-433f-a7aa-08d7b4437b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 07:23:41.7508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHu2ySWX73o8woyHBgDUScvgPVusOjH5z6qp+VWbBenja1uM+IdhgkI6nrvCSeDVBlFI93NtJoNl3daJn6iBCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-13 15:32:39, Heikki Krogerus wrote:
> Hi guys,
>=20
> On Thu, Feb 13, 2020 at 04:24:24PM +0300, Heikki Krogerus wrote:
> > The USB role callback functions had a parameter pointing to
> > the parent device (struct device) of the switch. The
> > assumption was that the switch parent is always the
> > controller. Firstly, that may not be true in every case, and
> > secondly, it prevents us from supporting devices that supply
> > multiple muxes.
> >=20
> > Changing the first parameter of usb_role_switch_set_t and
> > usb_role_switch_get_t from struct device to struct
> > usb_role_switch.
> >=20
> > Cc: Peter Chen <Peter.Chen@nxp.com>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Cc: Bin Liu <b-liu@ti.com>
>=20
> This was meant for you guys, but I suppressed CC for everybody. Sorry
> about that.
>=20
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/cdns3/core.c                      | 10 ++++---
> >  drivers/usb/chipidea/core.c                   | 10 ++++---
> >  drivers/usb/dwc3/dwc3-meson-g12a.c            | 10 ++++---
> >  drivers/usb/gadget/udc/renesas_usb3.c         | 26 ++++++++++---------
> >  drivers/usb/gadget/udc/tegra-xudc.c           |  8 +++---
> >  drivers/usb/mtu3/mtu3_dr.c                    |  9 ++++---
> >  drivers/usb/musb/mediatek.c                   |  9 ++++---
> >  drivers/usb/roles/class.c                     |  4 +--
> >  .../usb/roles/intel-xhci-usb-role-switch.c    | 26 +++++++++++--------
> >  include/linux/usb/role.h                      |  5 ++--
> >  10 files changed, 67 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > index c2123ef8d8a3..a7a7cb9a2a48 100644
> > --- a/drivers/usb/cdns3/core.c
> > +++ b/drivers/usb/cdns3/core.c
> > @@ -330,9 +330,9 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
> >   *
> >   * Returns role
> >   */
> > -static enum usb_role cdns3_role_get(struct device *dev)
> > +static enum usb_role cdns3_role_get(struct usb_role_switch *sw)
> >  {
> > -	struct cdns3 *cdns =3D dev_get_drvdata(dev);
> > +	struct cdns3 *cdns =3D usb_role_switch_get_drvdata(sw);
> > =20
> >  	return cdns->role;
> >  }
> > @@ -346,9 +346,9 @@ static enum usb_role cdns3_role_get(struct device *=
dev)
> >   * - Role switch for dual-role devices
> >   * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
> >   */
> > -static int cdns3_role_set(struct device *dev, enum usb_role role)
> > +static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role ro=
le)
> >  {
> > -	struct cdns3 *cdns =3D dev_get_drvdata(dev);
> > +	struct cdns3 *cdns =3D usb_role_switch_get_drvdata(sw);
> >  	int ret =3D 0;
> > =20
> >  	pm_runtime_get_sync(cdns->dev);
> > @@ -536,6 +536,8 @@ static int cdns3_probe(struct platform_device *pdev=
)
> >  		goto err4;
> >  	}
> > =20
> > +	usb_role_switch_set_drvdata(cdns->role_sw, cdns);
> > +
> >  	ret =3D cdns3_drd_init(cdns);
> >  	if (ret)
> >  		goto err5;
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 52139c2a9924..ae0bdc036464 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -600,9 +600,9 @@ static int ci_cable_notifier(struct notifier_block =
*nb, unsigned long event,
> >  	return NOTIFY_DONE;
> >  }
> > =20
> > -static enum usb_role ci_usb_role_switch_get(struct device *dev)
> > +static enum usb_role ci_usb_role_switch_get(struct usb_role_switch *sw=
)
> >  {
> > -	struct ci_hdrc *ci =3D dev_get_drvdata(dev);
> > +	struct ci_hdrc *ci =3D usb_role_switch_get_drvdata(sw);
> >  	enum usb_role role;
> >  	unsigned long flags;
> > =20
> > @@ -613,9 +613,10 @@ static enum usb_role ci_usb_role_switch_get(struct=
 device *dev)
> >  	return role;
> >  }
> > =20
> > -static int ci_usb_role_switch_set(struct device *dev, enum usb_role ro=
le)
> > +static int ci_usb_role_switch_set(struct usb_role_switch *sw,
> > +				  enum usb_role role)
> >  {
> > -	struct ci_hdrc *ci =3D dev_get_drvdata(dev);
> > +	struct ci_hdrc *ci =3D usb_role_switch_get_drvdata(sw);
> >  	struct ci_hdrc_cable *cable =3D NULL;
> >  	enum usb_role current_role =3D ci_role_to_usb_role(ci);
> >  	enum ci_role ci_role =3D usb_role_to_ci_role(role);
> > @@ -1118,6 +1119,7 @@ static int ci_hdrc_probe(struct platform_device *=
pdev)
> >  	}
> > =20
> >  	if (ci_role_switch.fwnode) {
> > +		ci_role_switch.driver_data =3D ci;
> >  		ci->role_switch =3D usb_role_switch_register(dev,
> >  					&ci_role_switch);

Why the struct usb_role_switch_desc needs drvdata, the struct
usb_role_switch has already one?

Peter
> >  		if (IS_ERR(ci->role_switch)) {
> > diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3=
-meson-g12a.c
> > index 8a3ec1a951fe..3309ce90ca14 100644
> > --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> > +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> > @@ -321,9 +321,10 @@ static int dwc3_meson_g12a_otg_mode_set(struct dwc=
3_meson_g12a *priv,
> >  	return 0;
> >  }
> > =20
> > -static int dwc3_meson_g12a_role_set(struct device *dev, enum usb_role =
role)
> > +static int dwc3_meson_g12a_role_set(struct usb_role_switch *sw,
> > +				    enum usb_role role)
> >  {
> > -	struct dwc3_meson_g12a *priv =3D dev_get_drvdata(dev);
> > +	struct dwc3_meson_g12a *priv =3D usb_role_switch_get_drvdata(sw);
> >  	enum phy_mode mode;
> > =20
> >  	if (role =3D=3D USB_ROLE_NONE)
> > @@ -338,9 +339,9 @@ static int dwc3_meson_g12a_role_set(struct device *=
dev, enum usb_role role)
> >  	return dwc3_meson_g12a_otg_mode_set(priv, mode);
> >  }
> > =20
> > -static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
> > +static enum usb_role dwc3_meson_g12a_role_get(struct usb_role_switch *=
sw)
> >  {
> > -	struct dwc3_meson_g12a *priv =3D dev_get_drvdata(dev);
> > +	struct dwc3_meson_g12a *priv =3D usb_role_switch_get_drvdata(sw);
> > =20
> >  	return priv->otg_phy_mode =3D=3D PHY_MODE_USB_HOST ?
> >  		USB_ROLE_HOST : USB_ROLE_DEVICE;
> > @@ -499,6 +500,7 @@ static int dwc3_meson_g12a_probe(struct platform_de=
vice *pdev)
> >  	priv->switch_desc.allow_userspace_control =3D true;
> >  	priv->switch_desc.set =3D dwc3_meson_g12a_role_set;
> >  	priv->switch_desc.get =3D dwc3_meson_g12a_role_get;
> > +	priv->switch_desc.driver_data =3D priv;
> > =20
> >  	priv->role_switch =3D usb_role_switch_register(dev, &priv->switch_des=
c);
> >  	if (IS_ERR(priv->role_switch))
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget=
/udc/renesas_usb3.c
> > index c5c3c14df67a..4da90160b400 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2355,14 +2355,14 @@ static const struct usb_gadget_ops renesas_usb3=
_gadget_ops =3D {
> >  	.set_selfpowered	=3D renesas_usb3_set_selfpowered,
> >  };
> > =20
> > -static enum usb_role renesas_usb3_role_switch_get(struct device *dev)
> > +static enum usb_role renesas_usb3_role_switch_get(struct usb_role_swit=
ch *sw)
> >  {
> > -	struct renesas_usb3 *usb3 =3D dev_get_drvdata(dev);
> > +	struct renesas_usb3 *usb3 =3D usb_role_switch_get_drvdata(sw);
> >  	enum usb_role cur_role;
> > =20
> > -	pm_runtime_get_sync(dev);
> > +	pm_runtime_get_sync(usb3_to_dev(usb3));
> >  	cur_role =3D usb3_is_host(usb3) ? USB_ROLE_HOST : USB_ROLE_DEVICE;
> > -	pm_runtime_put(dev);
> > +	pm_runtime_put(usb3_to_dev(usb3));
> > =20
> >  	return cur_role;
> >  }
> > @@ -2372,7 +2372,7 @@ static void handle_ext_role_switch_states(struct =
device *dev,
> >  {
> >  	struct renesas_usb3 *usb3 =3D dev_get_drvdata(dev);
> >  	struct device *host =3D usb3->host_dev;
> > -	enum usb_role cur_role =3D renesas_usb3_role_switch_get(dev);
> > +	enum usb_role cur_role =3D renesas_usb3_role_switch_get(usb3->role_sw=
);
> > =20
> >  	switch (role) {
> >  	case USB_ROLE_NONE:
> > @@ -2424,7 +2424,7 @@ static void handle_role_switch_states(struct devi=
ce *dev,
> >  {
> >  	struct renesas_usb3 *usb3 =3D dev_get_drvdata(dev);
> >  	struct device *host =3D usb3->host_dev;
> > -	enum usb_role cur_role =3D renesas_usb3_role_switch_get(dev);
> > +	enum usb_role cur_role =3D renesas_usb3_role_switch_get(usb3->role_sw=
);
> > =20
> >  	if (cur_role =3D=3D USB_ROLE_HOST && role =3D=3D USB_ROLE_DEVICE) {
> >  		device_release_driver(host);
> > @@ -2438,19 +2438,19 @@ static void handle_role_switch_states(struct de=
vice *dev,
> >  	}
> >  }
> > =20
> > -static int renesas_usb3_role_switch_set(struct device *dev,
> > +static int renesas_usb3_role_switch_set(struct usb_role_switch *sw,
> >  					enum usb_role role)
> >  {
> > -	struct renesas_usb3 *usb3 =3D dev_get_drvdata(dev);
> > +	struct renesas_usb3 *usb3 =3D usb_role_switch_get_drvdata(sw);
> > =20
> > -	pm_runtime_get_sync(dev);
> > +	pm_runtime_get_sync(usb3_to_dev(usb3));
> > =20
> >  	if (usb3->role_sw_by_connector)
> > -		handle_ext_role_switch_states(dev, role);
> > +		handle_ext_role_switch_states(usb3_to_dev(usb3), role);
> >  	else
> > -		handle_role_switch_states(dev, role);
> > +		handle_role_switch_states(usb3_to_dev(usb3), role);
> > =20
> > -	pm_runtime_put(dev);
> > +	pm_runtime_put(usb3_to_dev(usb3));
> > =20
> >  	return 0;
> >  }
> > @@ -2831,6 +2831,8 @@ static int renesas_usb3_probe(struct platform_dev=
ice *pdev)
> >  		renesas_usb3_role_switch_desc.fwnode =3D dev_fwnode(&pdev->dev);
> >  	}
> > =20
> > +	renesas_usb3_role_switch_desc.driver_data =3D usb3;
> > +
> >  	INIT_WORK(&usb3->role_work, renesas_usb3_role_work);
> >  	usb3->role_sw =3D usb_role_switch_register(&pdev->dev,
> >  					&renesas_usb3_role_switch_desc);
> > diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/u=
dc/tegra-xudc.c
> > index 634c2c19a176..b9df6369d56d 100644
> > --- a/drivers/usb/gadget/udc/tegra-xudc.c
> > +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> > @@ -676,12 +676,13 @@ static void tegra_xudc_usb_role_sw_work(struct wo=
rk_struct *work)
> > =20
> >  }
> > =20
> > -static int tegra_xudc_usb_role_sw_set(struct device *dev, enum usb_rol=
e role)
> > +static int tegra_xudc_usb_role_sw_set(struct usb_role_switch *sw,
> > +				      enum usb_role role)
> >  {
> > -	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> > +	struct tegra_xudc *xudc =3D usb_role_switch_get_drvdata(sw);
> >  	unsigned long flags;
> > =20
> > -	dev_dbg(dev, "%s role is %d\n", __func__, role);
> > +	dev_dbg(xudc->dev, "%s role is %d\n", __func__, role);
> > =20
> >  	spin_lock_irqsave(&xudc->lock, flags);
> > =20
> > @@ -3590,6 +3591,7 @@ static int tegra_xudc_probe(struct platform_devic=
e *pdev)
> >  	if (of_property_read_bool(xudc->dev->of_node, "usb-role-switch")) {
> >  		role_sx_desc.set =3D tegra_xudc_usb_role_sw_set;
> >  		role_sx_desc.fwnode =3D dev_fwnode(xudc->dev);
> > +		role_sx_desc.driver_data =3D xudc;
> > =20
> >  		xudc->usb_role_sw =3D usb_role_switch_register(xudc->dev,
> >  							&role_sx_desc);
> > diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
> > index 08e18448e8b8..04f666e85731 100644
> > --- a/drivers/usb/mtu3/mtu3_dr.c
> > +++ b/drivers/usb/mtu3/mtu3_dr.c
> > @@ -320,9 +320,9 @@ void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
> >  	mtu3_writel(ssusb->ippc_base, SSUSB_U2_CTRL(0), value);
> >  }
> > =20
> > -static int ssusb_role_sw_set(struct device *dev, enum usb_role role)
> > +static int ssusb_role_sw_set(struct usb_role_switch *sw, enum usb_role=
 role)
> >  {
> > -	struct ssusb_mtk *ssusb =3D dev_get_drvdata(dev);
> > +	struct ssusb_mtk *ssusb =3D usb_role_switch_get_drvdata(sw);
> >  	bool to_host =3D false;
> > =20
> >  	if (role =3D=3D USB_ROLE_HOST)
> > @@ -334,9 +334,9 @@ static int ssusb_role_sw_set(struct device *dev, en=
um usb_role role)
> >  	return 0;
> >  }
> > =20
> > -static enum usb_role ssusb_role_sw_get(struct device *dev)
> > +static enum usb_role ssusb_role_sw_get(struct usb_role_switch *sw)
> >  {
> > -	struct ssusb_mtk *ssusb =3D dev_get_drvdata(dev);
> > +	struct ssusb_mtk *ssusb =3D usb_role_switch_get_drvdata(sw);
> >  	enum usb_role role;
> > =20
> >  	role =3D ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
> > @@ -356,6 +356,7 @@ static int ssusb_role_sw_register(struct otg_switch=
_mtk *otg_sx)
> >  	role_sx_desc.set =3D ssusb_role_sw_set;
> >  	role_sx_desc.get =3D ssusb_role_sw_get;
> >  	role_sx_desc.fwnode =3D dev_fwnode(ssusb->dev);
> > +	role_sx_desc.driver_data =3D ssusb;
> >  	otg_sx->role_sw =3D usb_role_switch_register(ssusb->dev, &role_sx_des=
c);
> > =20
> >  	return PTR_ERR_OR_ZERO(otg_sx->role_sw);
> > diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> > index 6b88c2f5d970..703b98d71180 100644
> > --- a/drivers/usb/musb/mediatek.c
> > +++ b/drivers/usb/musb/mediatek.c
> > @@ -115,9 +115,9 @@ static void mtk_musb_clks_disable(struct mtk_glue *=
glue)
> >  	clk_disable_unprepare(glue->main);
> >  }
> > =20
> > -static int musb_usb_role_sx_set(struct device *dev, enum usb_role role=
)
> > +static int musb_usb_role_sx_set(struct usb_role_switch *sw, enum usb_r=
ole role)
> >  {
> > -	struct mtk_glue *glue =3D dev_get_drvdata(dev);
> > +	struct mtk_glue *glue =3D usb_role_switch_get_drvdata(sw);
> >  	struct musb *musb =3D glue->musb;
> >  	u8 devctl =3D readb(musb->mregs + MUSB_DEVCTL);
> >  	enum usb_role new_role;
> > @@ -168,9 +168,9 @@ static int musb_usb_role_sx_set(struct device *dev,=
 enum usb_role role)
> >  	return 0;
> >  }
> > =20
> > -static enum usb_role musb_usb_role_sx_get(struct device *dev)
> > +static enum usb_role musb_usb_role_sx_get(struct usb_role_switch *sw)
> >  {
> > -	struct mtk_glue *glue =3D dev_get_drvdata(dev);
> > +	struct mtk_glue *glue =3D usb_role_switch_get_drvdata(sw);
> > =20
> >  	return glue->role;
> >  }
> > @@ -182,6 +182,7 @@ static int mtk_otg_switch_init(struct mtk_glue *glu=
e)
> >  	role_sx_desc.set =3D musb_usb_role_sx_set;
> >  	role_sx_desc.get =3D musb_usb_role_sx_get;
> >  	role_sx_desc.fwnode =3D dev_fwnode(glue->dev);
> > +	role_sx_desc.driver_data =3D glue;
> >  	glue->role_sw =3D usb_role_switch_register(glue->dev, &role_sx_desc);
> > =20
> >  	return PTR_ERR_OR_ZERO(glue->role_sw);
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > index f3132d231599..d5e57d26c31f 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -48,7 +48,7 @@ int usb_role_switch_set_role(struct usb_role_switch *=
sw, enum usb_role role)
> > =20
> >  	mutex_lock(&sw->lock);
> > =20
> > -	ret =3D sw->set(sw->dev.parent, role);
> > +	ret =3D sw->set(sw, role);
> >  	if (!ret)
> >  		sw->role =3D role;
> > =20
> > @@ -75,7 +75,7 @@ enum usb_role usb_role_switch_get_role(struct usb_rol=
e_switch *sw)
> >  	mutex_lock(&sw->lock);
> > =20
> >  	if (sw->get)
> > -		role =3D sw->get(sw->dev.parent);
> > +		role =3D sw->get(sw);
> >  	else
> >  		role =3D sw->role;
> > =20
> > diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/u=
sb/roles/intel-xhci-usb-role-switch.c
> > index 80d6559bbcb2..5c96e929acea 100644
> > --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > @@ -42,6 +42,7 @@
> >  #define DRV_NAME			"intel_xhci_usb_sw"
> > =20
> >  struct intel_xhci_usb_data {
> > +	struct device *dev;
> >  	struct usb_role_switch *role_sw;
> >  	void __iomem *base;
> >  	bool enable_sw_switch;
> > @@ -51,9 +52,10 @@ static const struct software_node intel_xhci_usb_nod=
e =3D {
> >  	"intel-xhci-usb-sw",
> >  };
> > =20
> > -static int intel_xhci_usb_set_role(struct device *dev, enum usb_role r=
ole)
> > +static int intel_xhci_usb_set_role(struct usb_role_switch *sw,
> > +				   enum usb_role role)
> >  {
> > -	struct intel_xhci_usb_data *data =3D dev_get_drvdata(dev);
> > +	struct intel_xhci_usb_data *data =3D usb_role_switch_get_drvdata(sw);
> >  	unsigned long timeout;
> >  	acpi_status status;
> >  	u32 glk, val;
> > @@ -66,11 +68,11 @@ static int intel_xhci_usb_set_role(struct device *d=
ev, enum usb_role role)
> >  	 */
> >  	status =3D acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> >  	if (ACPI_FAILURE(status) && status !=3D AE_NOT_CONFIGURED) {
> > -		dev_err(dev, "Error could not acquire lock\n");
> > +		dev_err(data->dev, "Error could not acquire lock\n");
> >  		return -EIO;
> >  	}
> > =20
> > -	pm_runtime_get_sync(dev);
> > +	pm_runtime_get_sync(data->dev);
> > =20
> >  	/*
> >  	 * Set idpin value as requested.
> > @@ -112,7 +114,7 @@ static int intel_xhci_usb_set_role(struct device *d=
ev, enum usb_role role)
> >  	do {
> >  		val =3D readl(data->base + DUAL_ROLE_CFG1);
> >  		if (!!(val & HOST_MODE) =3D=3D (role =3D=3D USB_ROLE_HOST)) {
> > -			pm_runtime_put(dev);
> > +			pm_runtime_put(data->dev);
> >  			return 0;
> >  		}
> > =20
> > @@ -120,21 +122,21 @@ static int intel_xhci_usb_set_role(struct device =
*dev, enum usb_role role)
> >  		usleep_range(5000, 10000);
> >  	} while (time_before(jiffies, timeout));
> > =20
> > -	pm_runtime_put(dev);
> > +	pm_runtime_put(data->dev);
> > =20
> > -	dev_warn(dev, "Timeout waiting for role-switch\n");
> > +	dev_warn(data->dev, "Timeout waiting for role-switch\n");
> >  	return -ETIMEDOUT;
> >  }
> > =20
> > -static enum usb_role intel_xhci_usb_get_role(struct device *dev)
> > +static enum usb_role intel_xhci_usb_get_role(struct usb_role_switch *s=
w)
> >  {
> > -	struct intel_xhci_usb_data *data =3D dev_get_drvdata(dev);
> > +	struct intel_xhci_usb_data *data =3D usb_role_switch_get_drvdata(sw);
> >  	enum usb_role role;
> >  	u32 val;
> > =20
> > -	pm_runtime_get_sync(dev);
> > +	pm_runtime_get_sync(data->dev);
> >  	val =3D readl(data->base + DUAL_ROLE_CFG0);
> > -	pm_runtime_put(dev);
> > +	pm_runtime_put(data->dev);
> > =20
> >  	if (!(val & SW_IDPIN))
> >  		role =3D USB_ROLE_HOST;
> > @@ -175,7 +177,9 @@ static int intel_xhci_usb_probe(struct platform_dev=
ice *pdev)
> >  	sw_desc.get =3D intel_xhci_usb_get_role,
> >  	sw_desc.allow_userspace_control =3D true,
> >  	sw_desc.fwnode =3D software_node_fwnode(&intel_xhci_usb_node);
> > +	sw_desc.driver_data =3D data;
> > =20
> > +	data->dev =3D dev;
> >  	data->enable_sw_switch =3D !device_property_read_bool(dev,
> >  						"sw_switch_disable");
> > =20
> > diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> > index 02dae936cebd..c028ba8029ad 100644
> > --- a/include/linux/usb/role.h
> > +++ b/include/linux/usb/role.h
> > @@ -13,8 +13,9 @@ enum usb_role {
> >  	USB_ROLE_DEVICE,
> >  };
> > =20
> > -typedef int (*usb_role_switch_set_t)(struct device *dev, enum usb_role=
 role);
> > -typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
> > +typedef int (*usb_role_switch_set_t)(struct usb_role_switch *sw,
> > +				     enum usb_role role);
> > +typedef enum usb_role (*usb_role_switch_get_t)(struct usb_role_switch =
*sw);
> > =20
> >  /**
> >   * struct usb_role_switch_desc - USB Role Switch Descriptor
> > --=20
> > 2.25.0
>=20
> thanks,
>=20
> --=20
> heikki

--=20

Thanks,
Peter Chen=

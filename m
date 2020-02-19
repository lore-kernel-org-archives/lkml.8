Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DDC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D9B20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Age6WU6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBSOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:09:58 -0500
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:57376
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbgBSOJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:09:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6k7U2vlIN8R9PmZEgfSQtl8DM0S9dmgFMbQe4zKSMKwcMgpnWJxRWChItjecyI6HhAehy/F0iNPeepCvTTJdbTLWO8H7by+v3b3TVB2/aaBdLTO23aT3n2daVGI/tWN3Xq/ZEWOQnlE4b+u61WsbO2dXcmGF39Njlm540aoPvuP9cD1wvz5lhc+yi5is6QlKguKmgGTPAlIHLOYdGtbrCcjTwjcUc8HjtL4TbmoSd9ERUISfeytS2nM+bUSl7+w5LoSJF8Vl7LUikSYnPbvXh0EcVjneCYD2TH5G+uHmHWlAAbSTf9jiC7+etxgdkG462rL831FUvnhKIIk3cNILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCDbxm/ukF1lQkO8g2Y9bcAGRH0QbUS+TIub+b/n+6w=;
 b=Al+baPimy1iH2tiHu5liKpHUYBEDJUgH8SZOWheRQ+JAKPnSU3DVPadc74HERc5BcWAdoYMiqV7U7cCVuTRz43Ha33yQWjlHORdefzJiNB2gp3TPRRFFhUEKQ0lgoUKJLmj6O+rNnYyQNTHjn94KGdITcf/9zNC/oL4q43h9cRABwnugIefo3WE74porlQByR9Ki7XkBRbr2pcNLCkoy8SmjZjxx2CvwQthat38HVYOLzYp0qQtLgwXhoZIqltCAq8CkE7a24VCRY37qzelOxif1hMyezeIeuIgtwDY80w6mLvFWe8Qb4jI+bauaSlM5JTManb9sBDVZnFgcYxxkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCDbxm/ukF1lQkO8g2Y9bcAGRH0QbUS+TIub+b/n+6w=;
 b=Age6WU6jc0qQUwe58oEOGcOsZm93W0/88uQzCj0qPFCUaG3gk0N/v8Yfbg2gaf7frtCp0nyLAfvhnb6eIEQ0e+j237UgRnmlEZAe/B5agyxV2Is2HbJmWilJ1UDP2oL4MDWrU3RrkyayHBDWsfATLJP+0nNpijhoig7SzuQ4ptY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6336.eurprd04.prod.outlook.com (20.179.24.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 14:09:54 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:09:54 +0000
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
Thread-Index: AQHV4nD6G15oErWo00iXG8zLCuhxYqgZHzyAgAd0koCAAFRlgIAA4yEAgADDdoCAAAjZgA==
Date:   Wed, 19 Feb 2020 14:09:54 +0000
Message-ID: <20200219140955.GA15569@b29397-desktop>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
 <20200213132428.53374-6-heikki.krogerus@linux.intel.com>
 <20200213133239.GN1498@kuha.fi.intel.com>
 <20200218072341.GA30350@b29397-desktop>
 <20200218122545.GF28776@kuha.fi.intel.com>
 <20200219015840.GC8602@b29397-desktop>
 <20200219133815.GH28776@kuha.fi.intel.com>
In-Reply-To: <20200219133815.GH28776@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8ba266c-f63d-4920-b34c-08d7b54564af
x-ms-traffictypediagnostic: VI1PR04MB6336:
x-microsoft-antispam-prvs: <VI1PR04MB6336AE8FAF0AAB8F746D954E8B100@VI1PR04MB6336.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(8936002)(8676002)(6916009)(44832011)(81156014)(7416002)(26005)(76116006)(33656002)(186003)(2906002)(86362001)(81166006)(6506007)(71200400001)(53546011)(4326008)(54906003)(66946007)(64756008)(478600001)(66556008)(1076003)(66446008)(91956017)(5660300002)(6512007)(9686003)(6486002)(66476007)(316002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6336;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3TYWlTxVlC/z6o4tXyqy71uqZ6k1L7wWd+fb2steyZNJkE7/1GuT15mtzjIMQ7//32de4guAaf3c+AwB/XVGGYAFSA162/itbBRIIOGCML+AsSkh2xRMgvOqXQZL/unsD0ilLFQiQEiLMwGBZinMELhXyHhcUDQfC/IhkDFj9CgZViR4MmVl2SeuQE3MBbVcfCvM2KomcBsqPww8co47LEGYttm7AbBBLFAVKY9Rj5oVg2PaxitDIajTtUGaaJQg+PLR/wTGwPmeZoMOl3pVN+bYqmIfb0R8ncXQ6zcPqlvtkArEdemak5pHAFcXjrdsBh/k44x3UO9YmslAcKlIcEBGKwM8GX11S9A0yhJaiaC73MprS8htaaRgu2CuxyEBbSv5bSOYQs4WumWo8Ri9OTfI5rtGaRmIkVCubZU80OHGTQl1fzi5Goe4Etgb8HD
x-ms-exchange-antispam-messagedata: 6dLDEwsgwIOlYCcJ1hrYxK3F5ByBC54IUwBwJ/vRHYGPRjV8y8VFVRkeaVDfOS9zVK+NI8Ze+zXkL1bGA11kw2L9N4oII57PuJG85lFmr3Fx1AXEtWGRuRPlRbVno5C3QqBFaVBrp2mexqRDAPKy8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D720C75BB1073948831A63342843B422@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ba266c-f63d-4920-b34c-08d7b54564af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 14:09:54.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4phJWA8nmZrNHokEfhdXpwdKwnrX7Tv3CZyhAEH/MGEslUQXtQjoJrfx3cNhN6oYWS+sptqkk9fGFGuGMYDV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-19 15:38:15, Heikki Krogerus wrote:
> On Wed, Feb 19, 2020 at 01:58:38AM +0000, Peter Chen wrote:
> > On 20-02-18 14:25:45, Heikki Krogerus wrote:
> > > Hi,
> > >=20
> > > On Tue, Feb 18, 2020 at 07:23:41AM +0000, Peter Chen wrote:
> > > > > > @@ -1118,6 +1119,7 @@ static int ci_hdrc_probe(struct platform_=
device *pdev)
> > > > > >  	}
> > > > > > =20
> > > > > >  	if (ci_role_switch.fwnode) {
> > > > > > +		ci_role_switch.driver_data =3D ci;
> > > > > >  		ci->role_switch =3D usb_role_switch_register(dev,
> > > > > >  					&ci_role_switch);
> > > >=20
> > > > Why the struct usb_role_switch_desc needs drvdata, the struct
> > > > usb_role_switch has already one?
> > >=20
> > > I'm assuming that you are asking why not just register the switch,
> > > and then call usb_role_switch_set_drvdata(), right?
> >=20
> > Yes.
> >=20
> > >=20
> > > That may create a race condition where the switch is accessed before
> > > the driver data is available. That can happen for example if the
> > > switch is exposed to the user space.
> > >=20
> > > To play it safe, supplying the driver data as part of the descriptor.
> > > That way we can be sure that the driver data is always available
> > > the moment the switch is registered.
> > >=20
> >=20
> > Then, you may use the uniform way for the driver. Some may have
> > race condition like you said.
>=20
> Uniform way for the driver?
>=20

Sorry, unify way. Take chipidea and cdns3 as an example, at chipidea you
use struct usb_role_switch_desc

+               ci_role_switch.driver_data =3D ci;
                ci->role_switch =3D usb_role_switch_register(dev,
			&ci_role_switch);

But at cdns3 side, you set usb_role_switch drvdata directly.
+       usb_role_switch_set_drvdata(cdns->role_sw, cdns);

But according to your comments, all the driver needs to use chipidea's
way to avoid race condition.

--=20

Thanks,
Peter Chen=

Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118AEC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D757F24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cV6Jmizf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBSB6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:58:43 -0500
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:37825
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbgBSB6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:58:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfx6TrqQ7/i9KReHcQlB1M1lNF/avV4MY0hkgCBVpR8IC/CkfOV83951vf2vsBFAfuqT/GVgRL6MH2Ze+duysuxEBxLIKVvlFcRRp4gqEEloZCGi8gyMVRVP5GA0Yihavt20eEI++cEh5xlm3DORyNRy7+3DPAMlDfz6UjJtbolmVlrKBmrkJQiaUttKJBbhSfDe+Abk7Zil1jwPS19SrYl+A+KFoHZRA5yzhKdEJgGANU6FHAvsoCDu3HWc5IU1jE/8xLW7CkwukO3DSh5VyVgicHQKenpQmcQtKTqyi+dm/TDx2yA5k3Z9BuPjI9eoMhz0ef96A86tzpPcBl9lSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFn00SDX5Pj8EfjPZX9lZbwtCYYKI5Z8eflZAUFfeC8=;
 b=QzPdiBwxYJI34ZgJ8OemzF2we98QUlWl+x8/zXqxB/wjE0PKPy54JP6cjeXgr1B8G0oygYAP2+ubn76vGrIGoIDfAP2T/j6eX+3blJJWSdQvcsfqOTcwJd6jdK2+Ya59uz3w6hb4gOCEhrsPpZBPkCywW58wKrlTQRYrne6lxzc3jKL0xciznjx2h7vubS+d9MLRznNPU4hwxJCh090VyPdLFkd+uzoBrxpv1N5pf08eiQCRz+ekE9s37J0a6zlqUxTErrv2OHiaMfOYOoDs/LzRZEIC3nujANzB0Oi6jrE5nMoy14GXrP/UnVPjl9mAXQuRYwanhjmFTAau7OTtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFn00SDX5Pj8EfjPZX9lZbwtCYYKI5Z8eflZAUFfeC8=;
 b=cV6Jmizfg/hvbJ7Ngmtw2VkJjQLsuecu3xEuP0yV2Xvb8O+AV+XJrHtzOgAkcyIWkr6XSCeq4EUjQtPSF2V9zl/qNRIxYmrw+jYAYzVRM7RIIDQSCfumCRY0teHsSYHxmsESUAbbkTw0Y9B2if40Mt85mCQhk/RweQNRqofxfxM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4528.eurprd04.prod.outlook.com (20.177.55.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 01:58:39 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 01:58:39 +0000
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
Thread-Index: AQHV4nD6G15oErWo00iXG8zLCuhxYqgZHzyAgAd0koCAAFRlgIAA4yEA
Date:   Wed, 19 Feb 2020 01:58:38 +0000
Message-ID: <20200219015840.GC8602@b29397-desktop>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
 <20200213132428.53374-6-heikki.krogerus@linux.intel.com>
 <20200213133239.GN1498@kuha.fi.intel.com>
 <20200218072341.GA30350@b29397-desktop>
 <20200218122545.GF28776@kuha.fi.intel.com>
In-Reply-To: <20200218122545.GF28776@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cec7ad7-20bf-412f-3366-08d7b4df3d18
x-ms-traffictypediagnostic: VI1PR04MB4528:
x-microsoft-antispam-prvs: <VI1PR04MB45282594A942BC342A3417438B100@VI1PR04MB4528.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(478600001)(81166006)(316002)(1076003)(6512007)(81156014)(54906003)(6486002)(9686003)(71200400001)(4326008)(8676002)(5660300002)(44832011)(186003)(8936002)(6506007)(7416002)(53546011)(6916009)(26005)(33656002)(86362001)(91956017)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(2906002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4528;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjNh6hV/9n4MtQZmZVNxNup4BLglEIy6bzDjVOAzZNmTUkgBZ2m9y6RgqFss8swLAooJt/tKblHhSHiKga6eKhRzGRDG2/uWWg/uGopIB/7BXdcnH+CW0e5d+1KfHs1hx5+s/HS++4qdUvsjHkiiU/4Djo5oIYx2LlNNEFy6YB99cei29+C2zTBNGzeNPsGWgL5zQzZIXI7mMqMhy7QGsCth9M05Dhv/ro/GpqnVyIYPXMs2VbG62Hv+UD6o3TLjqDKA1OKTBpTj7e5yI/vM6MmCFdZuAdJ3f+sRxj07Ytz3+FlcwT0mKDqOdZMwYYAgIqWm6ibJYbxyFZS1bniXB7NpbjZtEdUVoRQuvmxmepaQBRsQXg3z9GsLafFe6hcQfLoOaDX7LB9lCT7jb5+Z6iEDRfO8aMFMGAvXtFzFHJ+IxXXGEwXB1wfni7GKwOtN
x-ms-exchange-antispam-messagedata: Jws/rlimiKX135dsrgZAUponP8KFbGMsUJEuQcNWqZ490LV47bJBvBeyl5E64s7MbXjyH6JqWDiY1o8b6cjHoZlL/gIZeuC4y9D7OBPu9vmxhgUgz7fCLXo5ng/lD1VfFjXvEhrC6hKk6VP97EJi9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A3FCB9AEC60604EAC5F6EB950F0C670@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cec7ad7-20bf-412f-3366-08d7b4df3d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 01:58:39.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptVJ62dKA5PMMH7MGbNqyOOZn70qAQRBOzcE0ilPmUhbDii4hxAJgDIbPRxZtuKMYQJwGjbFSiR1XENKyCJE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-18 14:25:45, Heikki Krogerus wrote:
> Hi,
>=20
> On Tue, Feb 18, 2020 at 07:23:41AM +0000, Peter Chen wrote:
> > > > @@ -1118,6 +1119,7 @@ static int ci_hdrc_probe(struct platform_devi=
ce *pdev)
> > > >  	}
> > > > =20
> > > >  	if (ci_role_switch.fwnode) {
> > > > +		ci_role_switch.driver_data =3D ci;
> > > >  		ci->role_switch =3D usb_role_switch_register(dev,
> > > >  					&ci_role_switch);
> >=20
> > Why the struct usb_role_switch_desc needs drvdata, the struct
> > usb_role_switch has already one?
>=20
> I'm assuming that you are asking why not just register the switch,
> and then call usb_role_switch_set_drvdata(), right?

Yes.

>=20
> That may create a race condition where the switch is accessed before
> the driver data is available. That can happen for example if the
> switch is exposed to the user space.
>=20
> To play it safe, supplying the driver data as part of the descriptor.
> That way we can be sure that the driver data is always available
> the moment the switch is registered.
>=20

Then, you may use the uniform way for the driver. Some may have
race condition like you said.

--=20

Thanks,
Peter Chen=

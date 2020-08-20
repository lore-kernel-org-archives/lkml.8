Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC2C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D68020825
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F71J7N+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHTCES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:04:18 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:54401
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgHTCEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:04:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1/WV/AlvSM5FDSEY00sWNhWgVeXJP/G2AvupppLK5WrxerFpTg/pCbPM7F9lf1FisU2c2PHkYDCipaaw4X1sBJpggSBO0l+XACkFPQJI47qFxyzlceOE7LxU2A/FZyY3clXZgWxJuKRcwqN5Snc9ICcGRvfq1MsfuWt8jdrZUQB/FykjsCxIz9cO9fWq/StFWFZKX/ZCaXkhFxQ6pgVLwtZOeJoomP26R4/8o+2k0xZhGR0mH/TvhNweX24uy/mfBJTV31bu9bYrg8JVzS9Hd0igeKxfek9rqI7nj7M+H4B8EfqhTUFbHwwL/74d58st7NAF2mmYK8WhtPrOz3Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQhUprD3eKD9KpwdPnfeDmD8UVm3rYoJOGNFGvqUBVM=;
 b=XCQpr1bQBzTcDO3V6BjYAHwfCvzDOtkdnF/SJ9RUE2vi50md1mNAtkF2l1IyZGMpEhlFcvSWSxUkVihcGOUuu7RQVU6zXeBUwBS+NK8prCj8Wds4y1QosnVNmkEkRuYd0uyR+MjKE7BjFkdmXHc/kGgqGzBx1dRC4f+jDfYSCaFNHBF/exFX/5GtFz7XflsaijBksLqasYcZWtinAWA522BmOSILTRbt4FN0Sm4ltME2iziMzApdPVXalq52QlHDmPHbZB0TJIB+GhFg9aSJt2r6KGEKqw+VmOTzSZvjV+wMQVShq6Su8Y73bKI2VXHrHbiymw35Q1p4Ip2kQbjfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQhUprD3eKD9KpwdPnfeDmD8UVm3rYoJOGNFGvqUBVM=;
 b=F71J7N+c7X8yxmYwwJOKO/VQjR+GHIDMAAggULxnZlCaIenfUb+YnOJTe/mZqnHpKmn8lM9BNY464YggBljmdaSdlvTXkVqO+0f9yzRR5+ocCiD9DLXVibpgSepAQrXOc905EN5/BKhS+yF48LeSYtCVrEAXfswR+thVCsD7J2c=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6683.eurprd04.prod.outlook.com (2603:10a6:10:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 02:04:10 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3283.027; Thu, 20 Aug
 2020 02:04:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Thread-Topic: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Thread-Index: AQHWYY4pPqmFoZ4ZzEWHmcUWZM64s6k+jjUAgAAzq9CAAT17AIAAaPAA
Date:   Thu, 20 Aug 2020 02:04:10 +0000
Message-ID: <DB6PR0402MB2760B72DA179BED8434690E1885A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-5-peng.fan@nxp.com> <20200818214350.GA3822080@xps15>
 <DB6PR0402MB276017AA0C124172D9BC3483885D0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200819194504.GB3845366@xps15>
In-Reply-To: <20200819194504.GB3845366@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93095419-e46d-480c-6d98-08d844ad5411
x-ms-traffictypediagnostic: DB8PR04MB6683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6683C32AD151894B30D5714C885A0@DB8PR04MB6683.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bh+OMeywiT3e7I+G2IxY3mOQZkJRRAf1a8Z3+fS6zy/dRtFQCks0eJizBoO/aqT12QKOrY7PKESbbJG7OjIQrX4J7pmPkziwniTB7voBUNT+S/qwf9nJGdjkmUhdtaUXv7b1uATt7QpvMB0r42ifJlCy/6FPT5a2pl08QQDPryUVZMnya8jzLTWwI8no+z6+ft/3+48gLnPj+XBED71FAfn6fRxte9fEVE4laDirs6LnB0gmx1NPf9i2mAWLzhMaIuE+z0kqSf9d9lG901Sd7ZfBoxzL1E3CfeSpTQhiLmZeDn8E9G02XXJF8tk4SCc95XJ7oo/bMwavuBbloORJww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(52536014)(33656002)(8936002)(478600001)(6916009)(8676002)(9686003)(54906003)(4326008)(71200400001)(55016002)(76116006)(7416002)(186003)(64756008)(66556008)(66946007)(66446008)(44832011)(66476007)(316002)(86362001)(26005)(5660300002)(7696005)(6506007)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gMEvPZmIMVTmL+sAexwiieCdiIsoes1D57JJb2PJ52s/FKEIdlDmqmZfsATQyr1Kbp+2saQKX7HGBGUDjtBoXC0LXhEQ4Yq1azm1P3dcfit696denBBcd+VDS0zZwIId+bRjz3YT0CRNjqbBVob6lDwhB4oUrUoh95WMa6fKuCvj8n6BYmog4ZlUwRUssmIT+JMSxNafLIjEF8O757DySpTAnZIWtbrb7T8VnsBsF6WzTgRsDfzKpsmxCqX1MYOmNZKCzHFygJ3o8xJfm+dhICLOwCa1aG4TSZuIw7R/fdMzaZLaGaV9d89NkaP5VJQUndXZVBPF3CAv6TLubZEZ25YifylIVITNxJQ4myiK11gmTkXA73EClvuAuqXgWpby0/xbUs7Fjjz5yc108HUpekLUhT9JbdVU2hyB/YoP/dgB1l23hUT6J6pGce7MUTLj5IQCAa2iTAtP9EzD+Ij9Engq2FGHb444OJKV5GN8Hy2uVq/PI+a5vqwWDPRHg0UdaPcVf97TrJGvkrkKK6GXrYJuSuh0+Ph7AVxeqrburOZDsDZEK5e4EiaxYAwQv8j70V+qOEvrS0qckaXDwT/oUKaIqrKsAIZMknKa08JTdAzY2T15hVOlRrbpSoy0AUnbV2s4sIFhIiOpCrAV7YTG3A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93095419-e46d-480c-6d98-08d844ad5411
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 02:04:10.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2u2BrmAPLpd69pq/sZofBwNf7xhORl4/Sc3KUCMv3RyUy8iHYEXbIO7yxPZ8AOgOvhCN+IM38/6c7H1o6hOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
>=20
> On Wed, Aug 19, 2020 at 12:51:27AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon
> > > optional
> > >
> > > Hi Peng,
> > >
> > > On Fri, Jul 24, 2020 at 04:08:07PM +0800, Peng Fan wrote:
> > > > Make syscon optional, since i.MX8QM/QXP/7ULP not have SRC to
> > > > control
> > > M4.
> > > > But currently i.MX8QM/QXP/7ULP not added, so still check regmap
> > > > when start/stop to avoid unhappy things.
> > >
> > > On the i.MX8QM/QXP/7ULP processors, the remote processors are not
> > > handled by the remoteproc cores, as implemented in this patch.  In
> > > such a scenario how does the remoteproc core know the remote
> > > processor has crashed and how does it recover from such a condition?
> >
> > For 7ULP dual boot case, A7 is under control of M4, so if m4 crash, I
> > suppose
> > A7 would not work properly.
>=20
> In that case I assume the whole system gets rebooted, which puts the A7 i=
n a
> state where it can "attach" with the M4 again.

Yes. Whole system get rebooted.

>=20
> >
> > For 8QM/QXP partition case, M4 is in a standalone partition, if M4
> > crash or reboot, the system controller unit will restart M4 and notify
> > Acore that M4 restart.
>=20
> And how does that notification work exactly?  Does rproc_report_crash() g=
et
> called somewhere in that process in order for the remoteproc core to atta=
ch
> to the M4 again?

Yes. We registered a interrupt notification handler with system controller =
unit.
When M4 rebooted, the system controller will raise interrupt to A53 core.
Then the notification callback will be invoked, the callback will call
rproc_report_crash. I not included this part code in the patchset, since
this patchset is to add initial support for 8M case.

Thanks,
Peng.

>=20
> Many thanks for the help,
> Mathieu
>=20
> >
> > Thanks,
> > Peng.
> >
> > >
> > > Thanks,
> > > Mathieu
> > >
> > > >
> > > > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/remoteproc/imx_rproc.c | 11 +++++++++--
> > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > > b/drivers/remoteproc/imx_rproc.c index 82594a800a1b..4fad5c0b1c05
> > > > 100644
> > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > @@ -162,6 +162,9 @@ static int imx_rproc_start(struct rproc *rproc)
> > > >  	struct device *dev =3D priv->dev;
> > > >  	int ret;
> > > >
> > > > +	if (!priv->regmap)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> > > >  				 dcfg->src_mask, dcfg->src_start);
> > > >  	if (ret)
> > > > @@ -177,6 +180,9 @@ static int imx_rproc_stop(struct rproc *rproc)
> > > >  	struct device *dev =3D priv->dev;
> > > >  	int ret;
> > > >
> > > > +	if (!priv->regmap)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> > > >  				 dcfg->src_mask, dcfg->src_stop);
> > > >  	if (ret)
> > > > @@ -325,9 +331,10 @@ static int imx_rproc_probe(struct
> > > > platform_device
> > > *pdev)
> > > >  	regmap =3D syscon_regmap_lookup_by_phandle(np, "syscon");
> > > >  	if (IS_ERR(regmap)) {
> > > >  		dev_err(dev, "failed to find syscon\n");
> > > > -		return PTR_ERR(regmap);
> > > > +		regmap =3D NULL;
> > > > +	} else {
> > > > +		regmap_attach_dev(dev, regmap, &config);
> > > >  	}
> > > > -	regmap_attach_dev(dev, regmap, &config);
> > > >
> > > >  	/* set some other name then imx */
> > > >  	rproc =3D rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> > > > --
> > > > 2.16.4
> > > >

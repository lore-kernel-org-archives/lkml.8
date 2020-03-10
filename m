Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E38C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3BE24655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r/M5IHW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCJHfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:35:19 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:60160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgCJHfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irXZ/gw5Zvl9niuKmplVg2ZHa+plciho7L6SzAIt7iW9eQRpM1au6KUl7QU36nys8/eTog5gsgnI9aVzBkdxc26Zjw3UBL0ksT1Z2WlbfkC4PAm1GkqeYtB6vLZ0m9NqP59IUxTxE3tZTT/TzZ1RDuk1iXsIvNbGz29gRzO2GUwNK1DZsKlXAVhCrEcibaU9y3W5pNr/Bp0dDthrqID47yKQZGN5uA9I3ASYvPaAR/JU7g5wAWjLrtj0X29Q3CqjYZY26/dOenNbogjud+2Wf1v0Z1nlg5Z4fuLFLFyBAzHPolze8UmseCxpT8xV1XPhUAfCCjF4P005No+pX/xsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEzocSKC8cp4HZQ3spihh/GKsnbcnFluCQ0/MbYXwtA=;
 b=Txf9pilHK4vDsXXp5gHTZp2CwmHcdMFqyXMAFUImPKo2xCjXhHxyNIaTqrPIqEPIqgMz42icAm6Ym2dOlPNxCOstrkEyyejBiCDi29TCob56lCy1uQqlEWpDhA9IihtYB6F0n1bwMxn5DzYJZQl30pTJFm0Ku8PRGQuGPpWr3tzRlpPR2VmbiexI9K0xbG7AMk4knQqoBNWv5RSUZ0Usxg+FpLMNDU6hVnD0gTPtmNg6eByON4eyuoZUeQZMLhOIa0iqi+g2h7UyrAg4Lq2uW4sGcRPTWcSyZAQHHgreehq2b+RcYFEgm8z6pKjAXw3xD4yKxFzBlwPtQUc7PvnCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEzocSKC8cp4HZQ3spihh/GKsnbcnFluCQ0/MbYXwtA=;
 b=r/M5IHW2wXZ+rDbKq8o8tHZt3Wh/eKJxz8DK190FE3cfYCiHnKY471LjIeGvGDoFSO0r/qoEdnElEU+47PF1d8+AlXf1VfFtpIki1QV+p9AKck5kX4ZP8Jly534pVJl692cAYD9qxxBCFcyGJjMUhq4Layt2q95qTVkGBQSgKYU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6019.eurprd04.prod.outlook.com (20.179.34.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 07:35:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 07:35:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2 09/14] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed
 when HSRUN
Thread-Topic: [PATCH v2 09/14] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed
 when HSRUN
Thread-Index: AQHV5vuEHgK2PJFQ40mWbELKksccuKhBeBGAgAAWNZA=
Date:   Tue, 10 Mar 2020 07:35:14 +0000
Message-ID: <AM0PR04MB4481D2DD219E7254805CFE1E88FF0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-10-git-send-email-peng.fan@nxp.com>
 <20200310061328.GK15729@dragon>
In-Reply-To: <20200310061328.GK15729@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 593d94c2-ecc0-41b1-502e-08d7c4c59287
x-ms-traffictypediagnostic: AM0PR04MB6019:|AM0PR04MB6019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB60197B552B916EFAE9AF49DD88FF0@AM0PR04MB6019.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:52;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(71200400001)(54906003)(6506007)(6916009)(52536014)(2906002)(316002)(7416002)(66476007)(7696005)(76116006)(66946007)(55016002)(33656002)(81166006)(86362001)(66446008)(66556008)(44832011)(9686003)(8676002)(8936002)(81156014)(26005)(5660300002)(186003)(64756008)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6019;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fo1Ax7Iwo5MlFGZ/il05Ra5wZuASWha9ydxNUSuQjn+8nDE0pmqbVPeCrlpX+p/787I9L2mm3gB8VluHtQ6+iWvP/8sKn5z3LSC70gvkI5ewzhjZZRjqb3SO3zXXOCwcw6jXQ4HOYs04OyO1PRnQFGUvIITwQSgNYeqcH6nRf02LRJzNfStd7DRYSthXBDyzJLnmPTXwqVnThoGlvLzX19PZmQuBnDFoBf2KyYLXiYQd7lKAuSzBns5Cw3bsUUWLad0p798QehHlkmnmo9SH7DtI2iC2W8GjigP8tnTEip6s5l+OarULUB9CmcDHUCCZqoqaN4XmP5mIcrKNQPX29DLG7HwU/t+0lKsfftHtM5zB77ZcnCpXZmrGKxvIy/jCqlrVTiZgyjW3aWDHvsG+kakA9ONdQsAcsPM4ciJm1CQe3D5+7nOivaqx8urlwdk4
x-ms-exchange-antispam-messagedata: u0rXL2RL3HBxnNhNyNVK7JE1snLZeEAfACtkGqOVGixvLcZMLCvq9gROfs89ElIiOry4ItBFCTZqKc15ioyPpqOkUu2/SUje0XebQYlQtI7YCCGWvV0ieGqA8KnS9b4uy7+84M0MjtAZ9bBGXfvrLw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593d94c2-ecc0-41b1-502e-08d7c4c59287
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 07:35:14.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jxlN8tTGSwtdETgRR/+OZztYZtnBXVZLYiKzfVpBf8nKMfqOnNrjec6U5vvV6liPPqAbMqKN7KfeO8WVjusFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH v2 09/14] ARM: imx: cpuidle-imx7ulp: Stop mode
> disallowed when HSRUN
>=20
> On Wed, Feb 19, 2020 at 03:59:52PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When cpu runs in HSRUN mode, cpuidle is not allowed to run into Stop
> > mode. So add imx7ulp_get_mode to get thr cpu run mode, and use WAIT
> > mode instead, when cpu in HSRUN mode.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Why do you have cpuidle patches in a series titled as adding cpufreq supp=
ort?

The whole patchset is to add cpufreq support for i.MX7ULP.
But i.MX7ULP only support two freq points. One freq point is HSRUN point,
When cpu runs in this point, cpu is not allowed to run into STOP mode from
hardware perspective. Should I submit this patch as a standalone patch?

Thanks,
Peng.

>=20
> Shawn
>=20
> > ---
> >  arch/arm/mach-imx/common.h          |  1 +
> >  arch/arm/mach-imx/cpuidle-imx7ulp.c | 14 +++++++++++---
> >  arch/arm/mach-imx/pm-imx7ulp.c      | 10 ++++++++++
> >  3 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/common.h
> b/arch/arm/mach-imx/common.h
> > index 5aa5796cff0e..db542da4fe67 100644
> > --- a/arch/arm/mach-imx/common.h
> > +++ b/arch/arm/mach-imx/common.h
> > @@ -104,6 +104,7 @@ void imx6_set_int_mem_clk_lpm(bool enable);
> void
> > imx6sl_set_wait_clk(bool enter);  int imx_mmdc_get_ddr_type(void);
> > int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
> > +u32 imx7ulp_get_mode(void);
> >
> >  void imx_cpu_die(unsigned int cpu);
> >  int imx_cpu_kill(unsigned int cpu);
> > diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c
> > b/arch/arm/mach-imx/cpuidle-imx7ulp.c
> > index ca86c967d19e..e7009d10b331 100644
> > --- a/arch/arm/mach-imx/cpuidle-imx7ulp.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
> > @@ -15,10 +15,18 @@
> >  static int imx7ulp_enter_wait(struct cpuidle_device *dev,
> >  			    struct cpuidle_driver *drv, int index)  {
> > -	if (index =3D=3D 1)
> > +	u32 mode;
> > +
> > +	if (index =3D=3D 1) {
> >  		imx7ulp_set_lpm(ULP_PM_WAIT);
> > -	else
> > -		imx7ulp_set_lpm(ULP_PM_STOP);
> > +	} else {
> > +		mode =3D imx7ulp_get_mode();
> > +
> > +		if (mode =3D=3D 3)
> > +			imx7ulp_set_lpm(ULP_PM_WAIT);
> > +		else
> > +			imx7ulp_set_lpm(ULP_PM_STOP);
> > +	}
> >
> >  	cpu_do_idle();
> >
> > diff --git a/arch/arm/mach-imx/pm-imx7ulp.c
> > b/arch/arm/mach-imx/pm-imx7ulp.c index 393faf1e8382..1410ccfc71bd
> > 100644
> > --- a/arch/arm/mach-imx/pm-imx7ulp.c
> > +++ b/arch/arm/mach-imx/pm-imx7ulp.c
> > @@ -63,6 +63,16 @@ int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode
> mode)
> >  	return 0;
> >  }
> >
> > +u32 imx7ulp_get_mode(void)
> > +{
> > +	u32 mode;
> > +
> > +	mode =3D readl_relaxed(smc1_base + SMC_PMCTRL) &
> BM_PMCTRL_RUNM;
> > +	mode >>=3D BP_PMCTRL_RUNM;
> > +
> > +	return mode;
> > +}
> > +
> >  void __init imx7ulp_pm_init(void)
> >  {
> >  	struct device_node *np;
> > --
> > 2.16.4
> >

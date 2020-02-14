Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB40BC3B192
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEEE217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qRuHvfwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBNBE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:04:56 -0500
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:6177
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbgBNBEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:04:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epKlUHIl7Q/o2u2XLi2Jgj5tj3CWNXhXZHBUV1lprbTzhlkZ8IuOPqJPbD9E9LlxWljjx7kDeNWSwGAloQU9O28oxbgd+2GuYW/qKcs1I3gFE2XFFuusiObu22fL9lkCW0wUxrdETAASQnmSadt3Zg8EWv/LlPYYGcdqLmY2kADKDCjsEYvOP3XAWMThJTEeMNcn7ACibkXw7V7J0QYKo2ZaFehWLcd7slUMvBb46Hsf6VwqS7g+MpkwIjPt1yDhmoTuBAk2XUY3WlTq+D7JPZzJXYO2Jup5ZScZJJHpp11vYsqmIvdKx6RCZQA1UE5OvC/ZER5FA/WqL+CcqMuLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAefpg9ECaq+80QQ250M16OobZYgA3KyxgfYfjO2bq8=;
 b=e0cAWfNZ5qqFGCrj8a8Uy9jLaZWsLYiJjH6Z2T+18jkx991A5wmmrL0JVn57/4FQQucLly3Ln1k3aokQljMsDwYuYvJsnZ9DdN4ygHVP6aYJ0tt8PKdEnCgsdjj+PtzY3ltP8mjKqHe+J4VqwF03dWQtT4p/sl14LdJ6h2+jTMO4gGEyO1rvYFR93OPGhiOhlDmFpUmBLL1e/GYoGTAM2UTepl1GvI52KhMjQkuH6wXlrd7UhdguvJ24DqrYodK2DBU0LpxpT6hb5TnhZS3bvtVGjp/TvELBr1pw226pgei/4+pGpS33+cL2ZVyO8mAs/rqObFv3VuCO/Wf1oKVr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAefpg9ECaq+80QQ250M16OobZYgA3KyxgfYfjO2bq8=;
 b=qRuHvfwzxEPX3Yc5rm5JSi/9Vzg6nfWNi9Ooz+8/50QstkP/CbHAGFqyBZ6VfuO/j+ULWHmZ/65bOu3vNh1DxYVVrZXUHmyLzVuAeYbhbWntI13lAiQIEkdhAjkui5PY7xfFYSh3RDn7XDv0q5+gSHEhOOUzZnWHPsFbm5VCCb0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4369.eurprd04.prod.outlook.com (52.135.146.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Fri, 14 Feb 2020 01:04:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Fri, 14 Feb 2020
 01:04:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Subject: RE: [PATCH V2 2/2] firmware: arm_scmi: add smc/hvc transports
Thread-Topic: [PATCH V2 2/2] firmware: arm_scmi: add smc/hvc transports
Thread-Index: AQHV4iK4bdOeVthtEkSsAkE0C6BKJagY9meAgADpOXA=
Date:   Fri, 14 Feb 2020 01:04:49 +0000
Message-ID: <AM0PR04MB448169D76860470DE51F825A88150@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
 <1581566330-1029-3-git-send-email-peng.fan@nxp.com>
 <20200213110419.GB23374@bogus>
In-Reply-To: <20200213110419.GB23374@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75f4d136-bd30-4538-8087-08d7b0e9e433
x-ms-traffictypediagnostic: AM0PR04MB4369:|AM0PR04MB4369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB43693CDA049BABBAE541B53588150@AM0PR04MB4369.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(186003)(26005)(7696005)(4326008)(71200400001)(44832011)(55016002)(33656002)(54906003)(316002)(478600001)(86362001)(8936002)(2906002)(8676002)(64756008)(81166006)(81156014)(6506007)(6916009)(66476007)(5660300002)(66556008)(52536014)(66946007)(9686003)(76116006)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4369;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFUbSkUXDBzx1h4/wKMdvfkEIOioSB2pXsenFajGRJd+K7wF7aSkaG9Fk1gMU2NBH63f2s0vPk0FfOjM6TWGXqcsUehxvK9WqOXVqDS4xAtuB4BjidSud01vOmBcuSeiZ3rvsopxl0B7MU4K1WYR3/5+sXLJ4iE4w5aydtgWKod0nTCPm5N0CTO7hYSDsRZk0jL0MuxRvcFupfufCtPH+ReBnWKjtiA0GPNuRsZG4E5fPkKZ8lbmDZ3ke0C8XVd2grM30whJ+p3jNH1qQ/uO7c+Iqx7Npzstqlf7Q/nA6FxvmPvq91CR8RxbmBapVfrv9S1L7q5nxsQU6GT7MeFs0ZqCXoOwSkG/0P2qrNI/1YyJPhX1WtqpuGqZhfLrXSteWi916LTbAY9j42u1CRBBfI72U1m37gx8zKacMwJ31yjVPc9XNwF0bOjMMveG1d86
x-ms-exchange-antispam-messagedata: ijiLj2QmlOQGZLmi5ZqyzQ3IUex8fF2Ci1FDkO7wjjYM0uKzwUdj1A4ePASzB4O9cB/jH5GGrLvuulunhcozoc8FwMYmmrOdnF3CYMN4cpX/HkSlh/l5cRTJUWotrm9JuxI2bgca/mXRm7co49sN5A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f4d136-bd30-4538-8087-08d7b0e9e433
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 01:04:49.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTUUoijiRuZkPq2dNZ1EEf7oR0c69McicIpSywqKhaZLCBDr4Ph7s3yTnSHxLQ4eyZPK/TsYetuqzppMfIFCvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH V2 2/2] firmware: arm_scmi: add smc/hvc transports
>=20
> On Thu, Feb 13, 2020 at 11:58:50AM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add SCMI smc/hvc transports support.
> >
> > Take smc-id as the 2nd arg, and protocol id as the 2nd arg when
> > invokding SMC/HVC. Since we need protocol id, so add this parrameter
> > to chan_setup, then smc transport driver could directly use it.
> > There is no Rx, only Tx because of smc/hvc not support Rx.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/Makefile  |   2 +-
> >  drivers/firmware/arm_scmi/common.h  |   4 +-
> >  drivers/firmware/arm_scmi/driver.c  |  11 +-
> >  drivers/firmware/arm_scmi/mailbox.c |   2 +-
> >  drivers/firmware/arm_scmi/smc.c     | 222
> ++++++++++++++++++++++++++++++++++++
> >  5 files changed, 234 insertions(+), 7 deletions(-)  create mode
> > 100644 drivers/firmware/arm_scmi/smc.c
>=20
> [...]
>=20
> >
> > diff --git a/drivers/firmware/arm_scmi/driver.c
> > b/drivers/firmware/arm_scmi/driver.c
> > index dbec767222e9..65c56328e6d8 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -595,7 +595,7 @@ static int scmi_chan_setup(struct scmi_info *info,
> > struct device *dev,
> >
> >  	cinfo->dev =3D dev;
> >
> > -	ret =3D info->desc->ops->chan_setup(cinfo, info->dev, tx);
> > +	ret =3D info->desc->ops->chan_setup(cinfo, info->dev, prot_id, tx);
>=20
> Why do you need this ?

For smc tranports, all protocols share same smd-id, but if protocols
not share the same shmem, we need let firmare know which protocol
issues the smc call. So I take prot_id as an arguments of smc call.

>=20
> >  	if (ret)
> >  		return ret;
> >
> > @@ -826,7 +829,7 @@ ATTRIBUTE_GROUPS(versions);
> >
> >  /* Each compatible listed below must have descriptor associated with
> > it */  static const struct of_device_id scmi_of_match[] =3D {
> > -	{ .compatible =3D "arm,scmi", .data =3D &scmi_mailbox_desc },
> > +	{ .compatible =3D "arm,scmi",  },
>=20
> Don't do this, get "arm,scmi-smc"

You mean code as below?
/* Each compatible listed below must have descriptor associated with it */
static const struct of_device_id scmi_of_match[] =3D {
         { .compatible =3D "arm,scmi", .data =3D &scmi_mailbox_desc },
         { .compatible =3D "arm,scmi-smc", .data =3D &scmi_smc_desc },
         { /* Sentinel */ },
};

But since we could use mboxes and smc-id to know the tranports type,
do we really need arm,scmi-smc?

>=20
> >  	{ /* Sentinel */ },
> >  };
> >
> [...]
>=20
>=20
> > +static unsigned long
> > +__invoke_scmi_fn_hvc(unsigned long function_id, unsigned long arg0,
> > +		     unsigned long arg1, unsigned long arg2,
> > +		     unsigned long arg3, unsigned long arg4,
> > +		     unsigned long arg5, unsigned long arg6) {
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, arg5,
> > +		      arg6, &res);
> > +
> > +	return res.a0;
> > +}
> > +
> > +static unsigned long
> > +__invoke_scmi_fn_smc(unsigned long function_id, unsigned long arg0,
> > +		     unsigned long arg1, unsigned long arg2,
> > +		     unsigned long arg3, unsigned long arg4,
> > +		     unsigned long arg5, unsigned long arg6) {
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, arg5,
> > +		      arg6, &res);
> > +
> > +	return res.a0;
> > +}
> > +
> > +static int scmi_smc_conduit_method(struct device_node *np) {
> > +	const char *method;
> > +
> > +	if (invoke_scmi_smc_fn)
> > +		return 0;
> > +
> > +	if (of_property_read_string(np, "method", &method))
> > +		return -ENXIO;
> > +
> > +	if (!strcmp("hvc", method)) {
> > +		invoke_scmi_smc_fn =3D __invoke_scmi_fn_hvc;
> > +	} else if (!strcmp("smc", method)) {
> > +		invoke_scmi_smc_fn =3D __invoke_scmi_fn_smc;
> > +	} else {
> > +		pr_warn("invalid \"method\" property: %s\n", method);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
>=20
> You don't the above functions

ok

>=20
> [...]
>=20
> > +
> > +	np =3D of_find_node_by_path("/psci");
> > +	if (!np) {
> > +		dev_err(dev, "Not able to find /psci node\n");
> > +		return -ENODEV;
> > +	}
>=20
> No need for this as mentioned below.

ok

>=20
> > +
> > +	ret =3D scmi_smc_conduit_method(np);
>=20
> Just use arm_smccc_1_1_get_conduit if you want to get the conduit which I
> don't think you need. You can just use arm_smccc_1_1_invoke() directly.

Fix in v3.

I'll post v3 after we have an agreement on whether we need a new compatible
string arm,scmi-smc and the prot_id introduced in chan_setup.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep

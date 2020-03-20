Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24BDC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC8420767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PsAGq2FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCTI1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:27:51 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:39104
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgCTI1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:27:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HctYyvl/daw6JTBioJE86WbSIKFNlJBnqaERGRBf81t/cNus2rT4saPxHQ2BYDvVgGszwkFClGap6FZ4jdYf+d27xS8Z7rjIxDUMKO527J91VdMbH/ZwihYamDTonEWS3wtBEGSectI449Fb0Z8KvGWxYAycWM3blWTI17XHvTbOemeILNEiurbmaA/4vExo+bd+iJcaWSPIWVOJsWI5p5BBetDBtx3atfBCuGhjZ481FYJ+6vOu0amVj/ORsNLKxuZbBXn3y9iMxE+Rp1AupRM9V7vbdEc//dh9I7jM/r7Pj3VyBZ0P7IxUAtd3X0JlIZb/dUsQz450IDLsJ8s4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4Qvids4YIGC+Xng6E30AP9lfJMQU1IN+afC3qAtQtY=;
 b=Pk+ugyLp/RUCQx7+6tgHDGfd6ZqOfBc4odigu76ZJ0UJhaWNhRw+SeO5TC7622D/jUqwCo765iAi3PfV8UTtphc2u5XmLrpnyi3uTEVnruBb4cFC9ThdqQGJzuUuqETWPqsi193N1OOVVxycMW/PkrxY4pWD+HOJ2N9De7f7sauxmt1fAvY7yjEOPnyiI8/0eWEvwBY4UbMuQO98FsGrerv566wr7T3GvrAZ7K8tDV5ZQ1+bG5xeEorIy9cij+/HSX8VnaKkvLoQ/a693JTJXK9QvOs8GumOlzxDnpJQoiTGkIWqL/N3wBR24TFlJXSMuOCHEjuODzX197cIyPe37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4Qvids4YIGC+Xng6E30AP9lfJMQU1IN+afC3qAtQtY=;
 b=PsAGq2FC/7DJnmA+HeDOf0GLiEVs1AbeUROTzY9toj4H7Pl4XuJSqeFdeWDPnn9v4OrJ7eayzO1HBR2XufpUaave1RJxT3jNLBofwQZZwtk/MrYkL6XNG8S+onIAz2U8ie4OFWMgxGCAA+UPdIggvLqOIdHmXB+1ifMDV2uB1R4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4609.eurprd04.prod.outlook.com (52.135.144.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Fri, 20 Mar 2020 08:27:47 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 08:27:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports support
Thread-Topic: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports
 support
Thread-Index: AQHV9U3Qw/Abi3aPd0Wpj3X8/OF3VqhRN+vA
Date:   Fri, 20 Mar 2020 08:27:47 +0000
Message-ID: <AM0PR04MB4481F673F90C735F272C171F88F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21d9c2c5-1bd8-4a2e-fcc4-08d7cca89228
x-ms-traffictypediagnostic: AM0PR04MB4609:|AM0PR04MB4609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB46098A4E1C3BE474095B584B88F50@AM0PR04MB4609.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(86362001)(52536014)(6506007)(44832011)(966005)(55016002)(26005)(9686003)(186003)(71200400001)(7696005)(33656002)(2906002)(110136005)(8936002)(54906003)(4326008)(8676002)(66946007)(66476007)(76116006)(66446008)(5660300002)(64756008)(66556008)(316002)(478600001)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4609;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y62BUhUaWv00Ou6YEXKITVJgNHeJAJYzlkE8BLrVDTgcpi4F86jTI67Oi8jBZ9OgQVtwDF3qrLFCHfAtO4sqfAye49ALXnPAlD8bsxWuWqOeD6eopLOMAc8+5Hu2faJoP5xpiL9coDtCQ8oUNYlTzGdMsh38jVe6ql3/TNljgkt17brxzndC3H6HzEEH9NPR5ZHNLZC38/mdZJA2D1OsbY1KLziNlSyGgA0shroUvAfKEj1IEWsUIF3IBLmxJ+8U6p/Ey78pSQBZkyCLX/uWgvycIGk3GqlMydkI9b/wkeXuiHm9eeLbX7aHtKd2cbPkICO4W+4D08pjsekeVrE4cBI5a7aVvcqRH+vOCW0nAB85ju/6UusXzqLOXohIFcaYz1pBMpxoqDwF+AiRjlfYq3LtIznU+ckJT4RzTgfBuxk+w9YmWApnSO0L/tvBqC5y0Pm33qdFl53qQtPgYXbNzwUA1Un4a8pV724x2cZgiJEpNLjGKGVq5rFyynGbUVdlzAMMFC83MvnfQBCWpSVDzw==
x-ms-exchange-antispam-messagedata: YEiYcphiLfBW0dkRmG3XS0qNSSZaFRvsRPrdU/iOylWhCK8MmaDRh34VxnP00L6ADN8v3IxJlarFlSP9BzjHou2f00hhb6Jq216177zbIJJ4r+0K7lmgCooCVCQuSaZ1SZdqKN7AMx/hPzClb6XWHg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d9c2c5-1bd8-4a2e-fcc4-08d7cca89228
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 08:27:47.4266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84p0aQa8D1GJk6CfEld5EUZVz0AOXFX6jpZlR2wujZawPn1YcvsLYyezqSzyEh7ReDqkrPBtwG7UqqfyMowEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports suppor=
t

Are you fine with this patchset? Or You expect multi channel support?

We have some features depending on this for long time, so hope smc transpor=
ts
could be finalized sooner.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V5:
>  Add Rob's R-b tag for patch 1
>  Add mutex for patch 2
>=20
> V4:
>  Drop prot_id in scmi_chan_info, since not used for now.
>=20
> V3:
>  Add back arm,scmi-smc compatible string  Change smc-id to arm,smc-id
> Directly use arm_smccc_1_1_invoke  Add prot_id in scmi_chan_info for per
> protocol shmem usage.
>=20
> V2:
>  patch 1/2: only add smc-id property
>  patch 2/2: Parse smc/hvc from psci node
> 	    Use prot_id as 2nd arg when issue smc/hvc
> 	    Differentiate tranports using mboxes or smc-id property
> https://lore.kernel.org/patchwork/cover/1193435/
>=20
> This is to add smc/hvc transports support, based on Viresh's v6.
> SCMI firmware could be implemented in EL3, S-EL1, NS-EL2 or other A core
> exception level. Then smc/hvc could be used. And for vendor specific
> firmware, a wrapper layer could added in EL3, S-EL1,
> NS-EL2 and etc to translate SCMI calls to vendor specific firmware calls.
>=20
> A new compatible string arm,scmi-smc is added. arm,scmi is still for mail=
box
> transports.
>=20
> Per smc/hvc, only Tx supported.
>=20
> Peng Fan (2):
>   dt-bindings: arm: arm,scmi: add smc/hvc transport
>   firmware: arm_scmi: add smc/hvc transport
>=20
>  Documentation/devicetree/bindings/arm/arm,scmi.txt |   3 +-
>  drivers/firmware/arm_scmi/Makefile                 |   2 +-
>  drivers/firmware/arm_scmi/common.h                 |   1 +
>  drivers/firmware/arm_scmi/driver.c                 |   1 +
>  drivers/firmware/arm_scmi/smc.c                    | 152
> +++++++++++++++++++++
>  5 files changed, 157 insertions(+), 2 deletions(-)  create mode 100644
> drivers/firmware/arm_scmi/smc.c
>=20
> --
> 2.16.4


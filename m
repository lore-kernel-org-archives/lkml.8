Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28927C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBEF207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VUGRRyzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBIIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 03:41:25 -0500
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:13816
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbgBIIlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 03:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaeGLB+AdCV+uRubtjyShjPkN7uKmngvaFcnn0rYPjJkjAde53bFSYvdsNLyUw5qmperXThxbqYVe8MAbs2dALihiIt6T0N8xnpmMvfyJmIatGLhNH9LVaLhqLW3fS6DICaN0hHSsoQO3u4RfqANMh8OG/tf8c/PslS0sH1DdVRJR7MgaZ0etOb1YXm5OKnGlF3Lx8x1GcU5vGHwN5f48YUTSjQYciYil/YCeKRmDXWDeDO8kvG9tOcpaqjhb7JpSqDmjVHaBq8yqdVY895PxA9E6da7NIw0Fe36SKa3BthvaaMnRI7MWYqPBoYFAGM4bn6ospWlfCTFbDqZOkTHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wdxIVpMkPIKxK/PtXcPCJQvn9lnB1B7mvhpko8Ph3c=;
 b=lNGn464JggEeiELSMUTAbBDpRYkw4/RAWP7M0iav8zg4aSOtVIkydbuEgHLOzg2/z9x/JHTIAq+d0hXBALEsNfUgFCe7xj/qXdccOVjyc/zz5WuvNigO2ML23nfWnyj8bsjg4HsL2rWwdDkS9eaaLTrXXG9z9YUGHJ0pJurZhiDpZ/KfCubS9an50t2C+m35wjS/snJEikoOXD63CPnZuaMjYccbp4mTwAxRHAUz0LbaY7xdzuU9jabl3UxC9PALsx22jDBMRa/M57UaHAIZUeNnzoA3en+oq3ZmkUqItN32R1uW4ENCzhMd3r85MQSC4UvFicOQTDc+URjwXAy37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wdxIVpMkPIKxK/PtXcPCJQvn9lnB1B7mvhpko8Ph3c=;
 b=VUGRRyzUj+I6hDrnrZCV9boklujH/dDqYjJeARVigamzEjwtOL03vlft20SXOD9yHn3hnlo3PrPvJy+OjmRwb26JfzhVJtbcgcttOva6cA6pDzyEBeKk1pitMj/mZetRTKQ2J7rxjFLmyhUCTF+zox1J+f/nk7bJuGpIHcLvEec=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5843.eurprd04.prod.outlook.com (20.178.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Sun, 9 Feb 2020 08:41:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 08:41:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvmem: imx: ocotp: add i.MX8MP support
Thread-Topic: [PATCH] nvmem: imx: ocotp: add i.MX8MP support
Thread-Index: AQHVzOYys8WB3+BLO0KUDipX7ftHWKgSr3Rg
Date:   Sun, 9 Feb 2020 08:41:20 +0000
Message-ID: <AM0PR04MB4481AB5A3E3D7D623EA29923881E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1579231433-14201-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579231433-14201-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53c5c0a6-f7c4-44c0-af56-08d7ad3bd663
x-ms-traffictypediagnostic: AM0PR04MB5843:|AM0PR04MB5843:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5843C4F4DF2D4CF6CA3E851B881E0@AM0PR04MB5843.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(81156014)(2906002)(8676002)(81166006)(7696005)(8936002)(4326008)(44832011)(186003)(26005)(478600001)(110136005)(6506007)(66946007)(316002)(86362001)(5660300002)(33656002)(76116006)(54906003)(71200400001)(66556008)(9686003)(52536014)(64756008)(55016002)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5843;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsJJQDqAhT3uFngL4UQc7mfkTI6DtEyWwgVzSi+jhvAbbMMAVXc23AZP9ptOa6NDa8i+pf1BP/lKTKDT7MF/1IxTcsXfBrQ8mxvMz0/keNY/f3qMPEeGzSvmJEJXi9ewNDNFufVcXo1mU0c16brQeCVOpVHnrTw/s5ejwXqqVHHZ7oJANrgwA13Tv20WBmsajgLrDosIk2tCpN1eP7Z2e4QS5GHNxbhoYWlzlLyJkG6HB6LpuXWx+kRaVhVsSm2m/u7IbJUKhP42pAslcNB8/sonJrFmhho8CqOVVWCvPIMPoJX+554tJAE1nfToNuZZ05iRHf7ODQgmxBO9hnTN9w03FrywRsTAEVryKHYoKOdUkWk6i2yHckGfuSkL9dvaTefs5Ucm/GbH8UMoQ4xFkxzlXKtH1sIWkW40et4+7XLnG/3BrtJum93MfEgNWLTM
x-ms-exchange-antispam-messagedata: lo1u+x4LCkcKZFFISkJHQElU9iwnNCF5PlTx6kKuJM/gSB98TSap5eSnG7Ru4qFEnVPTaG6zYrlqCNC0AiMQ98Rudmiqt/xfL9veEZJIPbm/1bjagrQ5AgNhX4fqRLae1gRPUvQNkOkGsGgt2gvnJw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c5c0a6-f7c4-44c0-af56-08d7ad3bd663
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2020 08:41:20.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMHuqJuQ/DAqkAmgAa8ka9vqY4RqXBq8jUNem5MJhJ75K7ZTdJIokzfke5hHLeYi998CHqVRyFZR/rHBerJBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] nvmem: imx: ocotp: add i.MX8MP support

Gentle ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX8MP has 96 banks with each bank 4 words. And it has different ctrl
> register layout, so add new macros for that.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> dt-bindings doc has been posted by Anson Huang
>=20
>  drivers/nvmem/imx-ocotp.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c index
> 4ba9cc8f76df..794858093086 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -44,6 +44,11 @@
>  #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
>  #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
>=20
> +#define IMX_OCOTP_BM_CTRL_ADDR_8MP		0x000001FF
> +#define IMX_OCOTP_BM_CTRL_BUSY_8MP		0x00000200
> +#define IMX_OCOTP_BM_CTRL_ERROR_8MP		0x00000400
> +#define IMX_OCOTP_BM_CTRL_REL_SHADOWS_8MP	0x00000800
> +
>  #define IMX_OCOTP_BM_CTRL_DEFAULT				\
>  	{							\
>  		.bm_addr =3D IMX_OCOTP_BM_CTRL_ADDR,		\
> @@ -52,6 +57,14 @@
>  		.bm_rel_shadows =3D IMX_OCOTP_BM_CTRL_REL_SHADOWS,\
>  	}
>=20
> +#define IMX_OCOTP_BM_CTRL_8MP					\
> +	{							\
> +		.bm_addr =3D IMX_OCOTP_BM_CTRL_ADDR_8MP,		\
> +		.bm_busy =3D IMX_OCOTP_BM_CTRL_BUSY_8MP,		\
> +		.bm_error =3D IMX_OCOTP_BM_CTRL_ERROR_8MP,	\
> +		.bm_rel_shadows =3D IMX_OCOTP_BM_CTRL_REL_SHADOWS_8MP,\
> +	}
> +
>  #define TIMING_STROBE_PROG_US		10	/* Min time to blow a fuse */
>  #define TIMING_STROBE_READ_NS		37	/* Min time before read */
>  #define TIMING_RELAX_NS			17
> @@ -520,6 +533,13 @@ static const struct ocotp_params imx8mn_params =3D
> {
>  	.ctrl =3D IMX_OCOTP_BM_CTRL_DEFAULT,
>  };
>=20
> +static const struct ocotp_params imx8mp_params =3D {
> +	.nregs =3D 384,
> +	.bank_address_words =3D 0,
> +	.set_timing =3D imx_ocotp_set_imx6_timing,
> +	.ctrl =3D IMX_OCOTP_BM_CTRL_8MP,
> +};
> +
>  static const struct of_device_id imx_ocotp_dt_ids[] =3D {
>  	{ .compatible =3D "fsl,imx6q-ocotp",  .data =3D &imx6q_params },
>  	{ .compatible =3D "fsl,imx6sl-ocotp", .data =3D &imx6sl_params }, @@ -5=
32,6
> +552,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] =3D {
>  	{ .compatible =3D "fsl,imx8mq-ocotp", .data =3D &imx8mq_params },
>  	{ .compatible =3D "fsl,imx8mm-ocotp", .data =3D &imx8mm_params },
>  	{ .compatible =3D "fsl,imx8mn-ocotp", .data =3D &imx8mn_params },
> +	{ .compatible =3D "fsl,imx8mp-ocotp", .data =3D &imx8mp_params },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
> --
> 2.16.4


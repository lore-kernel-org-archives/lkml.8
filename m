Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7878C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C29420661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FVMcH/Rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgAPH0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:26:08 -0500
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:23029
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgAPH0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:26:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw5oiGngWHF9U6wKEuUdRi8FMH5I6YI2YQekBpzOjx3vfpKgBGuzYsi370cfY3aZxhJpbZXiEvCBVQGvuT91joKDry0y0CJn7q8u5xkIZ0b1wYGDgX3F0Z64p2zgA7fFNXpQDkgEE5/32cwCLtFqBipPMQyhsqlbehyE96aoLJFSrAM6fgx/wUjGL30NUq6PcbMVe/LResSBZuLxKp9cEixuvReKj3CLZenWUiRQ/iYWLaGPiGOaGQyMgKT6SH7AgVUrc65rK+x9XFXVeQwyIMZPEGe8O9ntbSAnC9LUTO8NLe5b5/SnRP/rKep5D1M6jYA0COlh0rM85Bz8OVeJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URdDU8oVuBysxW3/ULTx8oy91qKu12vMuHSFbeITS8U=;
 b=NxkVJkwSVGJwvh/4Yn5Y4xWZTYufwwrYMziksxxGFEQdvr42uHWAUGHitgZvE8+rdoYfjZwPQGYP1eDxcDYKbPcG+16/s4NDa+mPK1Fo9ZHBp/XyRakOtnmCSn+6cQdA9wZ5+SPFC0Mzh3k3DqP5uDfdapYmDdJRXHBV1oyd4HZ7LAuaMKej6bnHbIbN1N6bsUvHlDVJzd5UiyW8/BYuvSKGii9GhBqvyXS2uFDaDCMB4UN3jxbIS+2vgA9X5EmDOFNrTuRTCRSuYqqcta3bGiNC6KdCDGWI1ZcJb2qj419Eq5iic3XoHK+3V5DBKAJPFBbzfrU7l0iR8q2NBSc1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URdDU8oVuBysxW3/ULTx8oy91qKu12vMuHSFbeITS8U=;
 b=FVMcH/RngOe9G7g8gJPXJDwyuubx/1xVCqDX3uhgumcoscWSmWvGtwr2J2waK5cZjqMm38043HhwHV4canin7vq6aO2gRRIDAsmvCE2bX8fg3ZQwBbr64gs9/dD+S80K9u55a+u9Roa3mGJpH5trCw2bYds7cWGUP9NueBNrE5w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5476.eurprd04.prod.outlook.com (20.178.115.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 07:26:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 07:26:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: pll14xx: Add new frequency entries for pll1443x
 table
Thread-Topic: [PATCH] clk: imx: pll14xx: Add new frequency entries for
 pll1443x table
Thread-Index: AQHVzDnjd2mDRKvXSUifw1iBCyYV5qfs46Bw
Date:   Thu, 16 Jan 2020 07:26:03 +0000
Message-ID: <AM0PR04MB4481C67ACD22BFA0DEECFF0988360@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1579157449-7602-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1579157449-7602-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eeed5f38-e3e4-45db-8f0e-08d79a555808
x-ms-traffictypediagnostic: AM0PR04MB5476:|AM0PR04MB5476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB547689FE34DF24827045638488360@AM0PR04MB5476.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(189003)(199004)(4744005)(71200400001)(8936002)(9686003)(44832011)(5660300002)(81166006)(81156014)(8676002)(7696005)(4326008)(6506007)(316002)(478600001)(2906002)(110136005)(66556008)(66446008)(66946007)(64756008)(66476007)(86362001)(76116006)(33656002)(52536014)(55016002)(26005)(7416002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5476;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Md2kMkBO6ra3tiQZ12FZO68q8N3JvpOQj0LVqmz15Ml+erZ3gcjEUpGy1ozqjrUFb8xmCg+a0PByi124xNGrrr4rGYay3O5Qul95S/c3xOxhr13+3lrwV6R8Cbgl48LXAM1PzCiDsqMHdG3215J8UVeBG6IXQYgNKQ1akH//UYrSFxGroB0fvhiOH2YC5NjIPs5bysyLPIMTRRGcEf/IQY9tbiegOKzO00Hn2r9jlz/JL/ZT6s1cQf1/AyVuqHVrwsWvxMqyNSYTju7H7+iMCLauTxhcwNauPrJRhHAQgr4OlxFb12+qbsO1n6eCQpKv0HBbeah72+CiOc6fq/iD7VT4Uh58UqYP2HF1esYyF7Vl3gcLQAzAAOlRuYHjO/V0a5UE+hc4j30WbTZBWQHW+24nsa5PsQY+ku0AH8WkPL4Dvn/ouUZyoq32XbJT0JTdGWfY9n9g/B9c1PfcOGsJe0r7iGlbs/vH5gFW6+cDDvDl8onLoA7j/TGwtZJwSeJm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeed5f38-e3e4-45db-8f0e-08d79a555808
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 07:26:03.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvPWbozXrEA1BjAv5nddf4qtGP528Z/yaqcU3V+oUVFVhLDDqgm2uoqfcLgeHCMCvBltX1lZqXaRol6kR9Zk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH] clk: imx: pll14xx: Add new frequency entries for pll1443=
x
> table
>=20
> Add new frequency entries to pll1443x table to meet different display set=
tings
> requirement.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-pll14xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c index
> 5b0519a..37e311e 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -55,8 +55,10 @@ static const struct imx_pll14xx_rate_table
> imx_pll1416x_tbl[] =3D {  };
>=20
>  static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] =3D {
> +	PLL_1443X_RATE(1039500000U, 173, 2, 1, 16384),
>  	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
>  	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
> +	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
>  	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
>  	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),  };
> --
> 2.7.4


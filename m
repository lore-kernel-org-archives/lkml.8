Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VutFBNdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDIJAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:00:30 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:35651
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgDIJAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeRpwB3NK1Gqkgc8fbn6xoxYDwmxcwUMLbEm7quxEuiXarJelG3UmbU0KpNyH+rFFWSc8Bw1EfYTEnfwTXz+1Z3WNdEKy15+IOP6yFbAy6KsryFfbNVazWMMQlcFLYnNXugTPMEQhucGpBM2VwuE1AGVVyjs6L2uxStdUOf4yM6jMDK+gmOcG6xKXZ1vf5lb3cNVetXmRUO5YT1rRiTISOXFlPlxywLSjBus8BDOqzfMcPh8pPVJqF2YfwB99r7hy9MzKeNFigadHisxya8BQbykG4for/Y45KR4Y1UUGpSuDa3ubJwg1MqOI8bJh/5el+vlRtE3bgnulVz1LG8kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTgo6E0KhCgesssTNJ/pmnhEjCLELAajw4eTDiMWoeg=;
 b=GEiCpctv53aB2MsP8xaGy+jQBThuylZJszJIfzkJt21KqFjIc+QORO2a8LSd3pUSwW7sdcAGuX69AUxzxVk/S+YgPy6tU0U+Q9+7OcGZontRkgrA5orU7b/rglRMeLVNeMPQVqOHVZnOBdXdtmENYY+PxKR6ZZ1WL00PKWtxG1ANF2vyEsyG61gu1idETmwOmsJr8mjMW4qeDrlzVpuhOTefGw7Q7h2zcpZwGqjIzp+Rl6XZaw2wGzMy2ozUMMTswLtTlpNlIRbnrN4O063vTBYscYZtCF0Hy/P0E6j4m2nvBb3Fj15/cq4CSAGBYWk4d7kScrrDBUvPqs7i4im4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTgo6E0KhCgesssTNJ/pmnhEjCLELAajw4eTDiMWoeg=;
 b=VutFBNdu6g2RPz/IN8XUU6m00+7wU8pWZ1JkXTly7Ik02WC/CIST4me4biHkklVI+QfVHMPyUrVBd/Vb1gKceLsi9ykaqNvnej5FKy+ycpQAu/L82qDlYm5qv8Nhy6RF5/rSKjt9rrKdQntef/2ageMX2UQOgnkphznVldxbC7E=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB5825.eurprd04.prod.outlook.com (2603:10a6:208:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 9 Apr
 2020 09:00:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 09:00:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, "soc@kernel.org" <soc@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx8: select SOC_BUS
Thread-Topic: [PATCH] soc: imx8: select SOC_BUS
Thread-Index: AQHWDkPILViybyw+CEWAlrPoiFlrqqhwfepQ
Date:   Thu, 9 Apr 2020 09:00:26 +0000
Message-ID: <AM0PR04MB4481AE18877828766FD1818E88C10@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20200409075208.2824062-1-arnd@arndb.de>
In-Reply-To: <20200409075208.2824062-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9f925b8-83d4-4d5c-5f6c-08d7dc647251
x-ms-traffictypediagnostic: AM0PR04MB5825:|AM0PR04MB5825:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5825E64A8E80507F5E8D494188C10@AM0PR04MB5825.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(8936002)(71200400001)(86362001)(33656002)(44832011)(66446008)(8676002)(6636002)(316002)(4326008)(2906002)(81156014)(64756008)(66556008)(5660300002)(52536014)(76116006)(7696005)(54906003)(6506007)(9686003)(4744005)(478600001)(66476007)(26005)(81166007)(66946007)(55016002)(110136005)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4wj8UCbMLBqX3mBp06LziJUsuIqwuM2tv2YJlO2ztknNFzJbAINHtFpaSopNLHeuizYFv74Dvof/GyKou15luFl8j/cmVydleW9gk6oFFC5QtlIho5zQAJ9k0ejedG7yXIvXKIrk7dnGGO0REgyhDQCgZ5yBz3fwZIvKx1l2I4KAczDOf1rqe2YDEONPhFaIKoW/ivjVnyfo0450jXzxUOznZrJjwAlC2zseI5QnbUEdKnrH2aeblY9NpO9auKO+hMBkQdIW+GTB8sqMuWX29Ft2TuGUQvjc3lsr4MAyplLlChsa9e2aPrlzMfeRXmi+rMmVmmvqSIYsxfeBPu6PYmkL7YZn5+EQOlG3LNNPowSl7ud0nx58D4NhbRAaXGnoSuQkT8EY9gFHWCZkdUqpOcrWrIkGLUA+hmh5Eh5m9SiDdwEPvs/RDLG9t8pF7cjN
x-ms-exchange-antispam-messagedata: z7E836vbdDViwIfAmZ11nqDc7mAFr02HN6U7+ozubbskb9u9Thquq8+R+yagZG7wMGajTHblF/eo7ASryRpKqk+AGuZ+oRdaJJw9mlRZ1L9ojZT4me/2EloJ68h3gAXml2EKd2TlpU/5PCWuK8igVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f925b8-83d4-4d5c-5f6c-08d7dc647251
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 09:00:26.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLvpXcjEiH3Rkw146guUliFRJeWQRo6UNrhbn1o7CAOl0mUetrDcXrND8G5gUI3+0AeSBqGzdd4lP/1SR8hDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5825
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] soc: imx8: select SOC_BUS
>=20
> Compile-testing the driver can result in a link failure when CONFIG_SOC_B=
US
> is disabled:
>=20
> x86_64-linux-ld: drivers/soc/imx/soc-imx8m.o: in function `imx8_soc_init'=
:
> soc-imx8m.c:(.init.text+0x28d): undefined reference to `soc_device_regist=
er'
>=20
> Select it from Kconfig, as we do from the other SoC drivers.
>=20
> Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc dri=
ver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.

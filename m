Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE7620720
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FKyj0wBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbgFXNPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:15:41 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:35681
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387922AbgFXNPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:15:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYRx9uKxIC/voEIbz4degjOpCYAC7W0BMOCZ7PS9rI6cx9jPhvIACL2X3Ga4w2KRR6atsVxy86iQhpuFoU/TKrPCicbfVBNiOmrjSJPiV1TLvhvAo0is+elFRBV14WVxCmSXbr6ZNlpDSCPAweeRiV67Ypz0FlRo5A8e0iv2foDTkanGie0IynMJ/6SeemXBb9Isn4xKI18EA1V5Ji6TtLv8CRUqLklxUcRlsUzBtorBq+knhho4ErQdLOO3qQKdpD6Y7IM2jl8v2ML0S1CjlgAsZITgml7E0i6oP7g/zncURtxME8UOdiKeFmTP90URUsv4p1dceDjpSdtgdRN7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVe7LCIgX4cajCEwQQ2iTrHMQHt4il3VTnLpeZYzFso=;
 b=KmvxQBQw/e623EGiAatZC6ToZ44YD3H9jEbVV3XP+48Xd7k141pUbUISqi/MlCXvMXhncWQuI+7uuqtY6l/FvAzOD9ahIuszUjdXEc84T3cofXYvNABE94mRTmtlx1Qg6kB8iQMb+RWXrrC07QKyWNhl3THe7s8Ug3ZndEoKn7fJBcEmzqPovh+dmLqvLFvG9TQRQ5R24qdzxI1ViG11/iIdCW0xj5c8kYoi0xSd5MPI0JdhpLWtwYrpfpWocgUS5/3GlIskaezCcbqMkiPXehZYRp6sHHYZbK8mY3k+fl8AvN0X3PaHhm/WFY9PPYjfa6XrmYCPrw1F65k8lH203g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVe7LCIgX4cajCEwQQ2iTrHMQHt4il3VTnLpeZYzFso=;
 b=FKyj0wBxgymcNuJEadVRvHCZP/B5K7i9VXokaxCZFto6wLpmkfFQxsWNaOYvO0pwsSXgwwDND1JO1KDhwh/88jYO+tuieIQJUosj0RgQn6u+zAezme7BmPZk27hJMcsM9+EgcnN2zZe9ttvhx9avOtN61TjYoaipI/3zckKZLQM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB5467.eurprd04.prod.outlook.com (2603:10a6:10:80::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 13:15:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 13:15:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Franck Lenormand <franck.lenormand@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "olof@lixom.net" <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU firmware
 driver
Thread-Topic: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU
 firmware driver
Thread-Index: AQHWSiJDQC8EHEvbXEmiUi/qZAMEN6jnsyEAgAAG+IA=
Date:   Wed, 24 Jun 2020 13:15:36 +0000
Message-ID: <DB3PR0402MB391634C85F53E8A9456E89F0F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593000687-12213-1-git-send-email-Anson.Huang@nxp.com>
 <AM4PR0401MB24016D7F1E97F70AEC23BEB392950@AM4PR0401MB2401.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR0401MB24016D7F1E97F70AEC23BEB392950@AM4PR0401MB2401.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b1744f7-54ad-4aef-1241-08d81840af21
x-ms-traffictypediagnostic: DB7PR04MB5467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB54675CE043963AE01D92F194F5950@DB7PR04MB5467.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6oG8R/l0D3p8OL7Jyk9xZfBbpZM65Z5dF0ZojpObawm+neF26C1/EKhG0my17sTBxkZnOk4gaGw+R9QSrNwAzjm1sGKT9KZmJ/6GhP94YxP7L6sLnxzL3kC7/yxm7GRRZBlizPaI8FssHOo3fl/8s06aya6XCDz9K6ZPtCEzkVLWVptdgJNPvi4Mn5+q2CmPtYL3775YQ/x6DWAvL2GQGK4ufJsqRa7fxsh8bDGvz4WKRkLxpIcsEG5F4DJ8oTHDhUZ8u3mbjQCjrG/s+nnp7P0ttJIL2dM62acuhu6p3FxHAC5eJVD+xfDGw2IoG5gsoun69kuUrHg0onFE/FNnVomcoaqOqS1/q6LlzdfDXWeBy3vS/y4ttsmtVMO+GITe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(71200400001)(76116006)(4326008)(7696005)(66446008)(66946007)(66476007)(66556008)(64756008)(2906002)(9686003)(52536014)(6506007)(8676002)(55016002)(316002)(478600001)(86362001)(7416002)(26005)(4744005)(5660300002)(8936002)(186003)(110136005)(33656002)(44832011)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LE99VTSEtUysnR3dbEkjNd7w4H/FX8a4RRxOFl3y9UT2anMNgkD3dj2Bwfw5ZUSyYcfLlTpVJHjpd7LZoAN5dWkoqV/r1CH3hj28E5FdMRBgB82vLpoHODED5eePgTvUsqYW6xmeZq6Ft/5IDn6/TAFPD5f7qWBvg5HIy9O82iZkMUxLf4v3pDNEz0ZT6zEFa+nVzjdh0naTr7IHhjPKJWb6HsdeKt/b/Pg9HplPf5VkZ5EjlDVGxH/MbhiyOgVu2dlKDept3ZW1APGtwYE+IXCOjXDQGCmIUeCHHOP8RTiYi0V1Sn8F+vYOzwok7qL84skd+LmT/TU/IjeHug9IrTkJDQJncOLJAgmNfs4CKbmvk4Ioxb+CT0RxiLdI/vjzWV2/b8CkSEo3FqhJcfKSFDodlcDoqXQuZeeKC2jTczc9C5jZFXGhM9ldhVO6Ic47oTQVE800zERhZvhrZc5NxJLQTD5CJIpp+tH1Ai+ouxO64SXsQ9FnjkLHw2oOy3o+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1744f7-54ad-4aef-1241-08d81840af21
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 13:15:36.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41hLjJna8yXoME5lmCFf138pkO0WqRKsl6/y5PV1ETjxcVNM1tt3IZIAeM9t3D97bCH+X8yd8G6MUPuZjohuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Franck/Arnd

> Subject: RE: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU
> firmware driver
>=20
> Hello,
>=20
> The move of folder is a good idea however I do not feel adding the code o=
f
> soc-imx-scu.c  to imx-scu.c is the best.
> Until now imx-scu.c was focused on exchanging the RPC and init the IRQ.
> Why not have soc-imx-scu.c  copied to imx-scu-soc.c (change filename) to
> have a pattern similar to imx-scu-irq? And keep the  imx_scu_soc_init int=
o
> imx-scu.c.
>=20
Sound like making sense to me, it can make the code architecture more clear=
.=20

Hi, Arnd
	What do you think?

Thanks,
Anson

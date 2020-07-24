Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7AC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720F52074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ordliYh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgGXH3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:29:24 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:35715
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbgGXH3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMiIAqopTScr2kkYXobgRpHnRaBKpB3NTEiHbbjKPyfUK21ZgyQuMw7UL/xggdUo50TQTctxK+eAb7+EpUIUgMAbu0wqjwb+ldUZv7HGz1AfDVvhuxhIfaMOhdEWrYgIUC6BiA00fiDrE3vjAXdxMtAT4cCrAcelQxrH8CH2a0hLUAXUKsCAw4Lm1hoIICLQsxy7DWvQNg9WPIwMbJIvMzcljCaHTLVxJwGtD1D84A/lWCRt5lKOiaSuPuBkXYAtjO0E9LGrnjUSWIziaTmEIVWtD6dglXbgzAGmuUDOPA7XY0qlmUoZs5GEZ209uMVEf1eK9SG3ZMCbUoJLe8vdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtYZi8zq3ULyTe+9zuqPn3FaTTeQfgNGMF7b09PHYAo=;
 b=e3HZ9txdJfILg6ixBE2iUIKGnkyxWS1UlXAzZBnTHYkCeltSRNYmXzp7LfcMWp1ZQDm2GrbmVuK+l/VhqPtf7h4Yt8Xrt5rQWJQNn7ChgaDSowVZivtgLY3+kR/ZYEcLth3FHe9OLAfUndrf6ptDW2WSyoWrdX9q7uG7YwRb9Bk7yBmzzAeZ0MwtG9XWDUDOU0Ioi1y3S3C2zQ5KmefuWOvf5W3Vch3eHYrnXAMSl3DMaNez4L67gm3GUlbHKVblxi0RvgQoRUjZVvFuexZnqxTLt+yA/NqZBHz3PAKeuN+BvwJlsCGva01qqTkNtx3TwC7+6NCogPTYW+TU30pQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtYZi8zq3ULyTe+9zuqPn3FaTTeQfgNGMF7b09PHYAo=;
 b=ordliYh15+89jHHT+aNUmmfGUl53FJCHxIosEtiNkksZIYXvNWeMjHNJq2CC+C+WMLXYYmUUdwZnM74JhURme+FXKVO+2Afksk3v7qyVqAz40EYpSs77Ym7UB+jxGAsNFm/gVxLzH5OajX6V9GRlwx1Fq65W/xSCG4zudAN3z4U=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5465.eurprd04.prod.outlook.com (2603:10a6:10:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:29:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:29:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/9] remoteproc: Add support for attaching with rproc
Thread-Topic: [PATCH v6 0/9] remoteproc: Add support for attaching with rproc
Thread-Index: AQHWWhgNyH3zVuDHz0yAhBPxtyEMXakWY9oA
Date:   Fri, 24 Jul 2020 07:29:19 +0000
Message-ID: <DB6PR0402MB2760E18172FCCE6A0562514D88770@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d209e8c-b0ed-4ed4-118d-08d82fa34728
x-ms-traffictypediagnostic: DB7PR04MB5465:
x-microsoft-antispam-prvs: <DB7PR04MB5465A74438F70CCA43FB861588770@DB7PR04MB5465.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zEtJOwpJR5ttvxsfyBJHCU2wikL/EXFn0eF/zBzwAleDQSebCp2bfuLJHGDR3fIiIpx2AYRK0CfBA2MQZJ2zhWGkkv9RYgc00zWJ89AVtr10rJCWI65HIJjYh4XgHCu2xS4CkJXOTzj1DZdSoDN338hnCiwpIbndd1cLKW5zEHd+kgseNLeRzSYYD1qB+/dAv+C5TyLdrprjBXFn1pp3fo9DsVhL+op6A3TfIyWuDqsrYDqpkWIzf0xFtzMfDN+Qfxf6X6QRmBzX0fRbQ36rHOuVOOLGxx7k6b1/KsRP5n92ih6H3OZFP6oJ3B1HHnBK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(52536014)(186003)(26005)(5660300002)(2906002)(8936002)(86362001)(8676002)(76116006)(66946007)(66446008)(66476007)(64756008)(66556008)(6506007)(7696005)(71200400001)(9686003)(4326008)(44832011)(33656002)(478600001)(83380400001)(110136005)(316002)(54906003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zXptwMkTo0b9eGEtaefDh4fopAzuLSUiR8mE8TuFsnZJQyX9eRlR/ldiaWG9eAuBlhRCKlQeeVfAaNcDMv5xF4K6Ax84OI/wD/Fw/ZMsO4rbo3I8Lj4O5GQ+Kf30sXAZ3pSE1WrTwWiE/RAI53v9Dts+JY7qz9W6g7/PFcVHhA8L3QxlK0+CqoPQhjY86p2D9IehIUlnhx13gj1kr8oucyHSco2MQvvVNsexKcu4Sx+S+S0klFhrNO7enRnpWhx6/oCHxNw3jFU1vIpc7wWXqBRfYfKIagWu/6vhTNtjh9nHqn4QkgSe7k4Nf4QdB5OfKEM3NV7YyovmgTonLYjyXD8WRXWKSJCBl2e5bvIc1omQimTF5JRFTdU7SwbjZsJ4vjQ+8oXEWDReNCKbtrKhpDajfMOzGFyP7hufGHw7w9gdUtNrsWudMhYm3hlRt9XfsAsj5jX5PKBgQSfzTz83OIlpU0fuV2TPuTZw9KOTzRc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d209e8c-b0ed-4ed4-118d-08d82fa34728
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 07:29:19.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3PE4WeOLFujA4ZCeNYCVTStP//fSE61rXv0tWF+RXKqhlk768QFm5tt/wG8eDOgiw5D/lqUnEQjVPu5CgtlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v6 0/9] remoteproc: Add support for attaching with rproc

For the series,=20

Tested-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.
>=20
> This set provides functionality allowing the remoteproc core to attach to=
 a
> remote processor that was started by another entity.
>=20
> New in V6:
> 1) Added Arnaud's reviewed-by and tested-by tags.
>=20
> Applies cleanly on rproc-next (0cf17702d872)
>=20
> Thanks,
> Mathieu
>=20
> Mathieu Poirier (9):
>   remoteproc: Add new RPROC_DETACHED state
>   remoteproc: Add new attach() remoteproc operation
>   remoteproc: Introducing function rproc_attach()
>   remoteproc: Introducing function rproc_actuate()
>   remoteproc: Introducing function rproc_validate()
>   remoteproc: Refactor function rproc_boot()
>   remoteproc: Refactor function rproc_trigger_auto_boot()
>   remoteproc: Refactor function rproc_free_vring()
>   remoteproc: Properly handle firmware name when attaching
>=20
>  drivers/remoteproc/remoteproc_core.c     | 213
> +++++++++++++++++++++--
>  drivers/remoteproc/remoteproc_internal.h |   8 +
>  drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
>  include/linux/remoteproc.h               |   9 +-
>  4 files changed, 230 insertions(+), 17 deletions(-)
>=20
> --
> 2.25.1


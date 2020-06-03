Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35071C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A00206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONIB8cm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgFCDKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:10:30 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:14304
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgFCDKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsWwH8+/3pcssC2jGUMqjibiGkhPBkPsEHBmMLrLQ3nSZvBP9TnrB5AP7o6ILx1yMxozMbh1x7qfU0yyQaFNmFnojNVWee/aFQsbvk5RaUI2EvLxtNOdEPEfYo0Q+jtDNNW5W4YRoDLYFA5LHGeH25YQbx/9Vy1+sksgXAi1BOZ0BoDb0cTOs7MLIeW/bEvtBOxZen9kdl5sOPrRFtGL1ffHZVRgRUVnGHaS0hIPAmXAzROw3fYX7Fh/JuzBkgxPzvBPQgJ42ZQnzx3YNGSe60IZAXBQ5jcT0Hy7SSoEVyQu294HsSnQ5JkEq2uOWv0vHazgvDtYiqPTmTB47Tqd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaacibbE2lJDFxGLIyaKuAdMHmp7SHzDFyr2oUF8GoQ=;
 b=XqfYC5qySbjYZqL2XGy8o5tNHG2+SGItmu5umxz+faVdDRJlopYSqJ+Qcwj7kWn+bKge9B9gBOEceJzBp/05x483+yOoITqMnjqEwIS8c3nvdNCcuEffpZXxObRHt2v5kVL78Lw+DJJ5nmoQADmiNIkyiNp9tUKeOB19XooeUUMlJqYujj2hstXXCXpOK2Vsdsp7VdGTyEupqN3sbHvstCdjwP17e3f152mEMbC4q1EKMfV/Y4NsethBSavPdCcfGxXdSZ5LbVjdc+R5ql8Fre8nT8ZIFdHehudbHRUvuq3anMHNsdZmAKOovqktjBdsukbKmaE0pZBZeOc665QZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaacibbE2lJDFxGLIyaKuAdMHmp7SHzDFyr2oUF8GoQ=;
 b=ONIB8cm8KpqwsDt2CfWVhxI0l0HUiHyD/KY9qT2YwB9ma1Us5S6gB+YqD3EPTcLtSZ2A5g+fTSy8N4qNbfJTYmi8l1d6mtXd0HpsHs7KTUuk54rMxypElNfbHB0MR2XhV8UwDfausE+dLyo/+/itEhoNgEzBykkmyj9Rkq+3HGg=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2886.eurprd04.prod.outlook.com (2603:10a6:4:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 03:10:26 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:10:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Topic: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Index: AQHWN+7rKaBs4BAoiEu6e8UDHht806jGOLUQ
Date:   Wed, 3 Jun 2020 03:10:26 +0000
Message-ID: <DB6PR0402MB2760B88C0C1519203DE49A0E88880@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
 <1590999602-29482-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1590999602-29482-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa2bea13-0d5c-41b4-9bd5-08d8076ba9c6
x-ms-traffictypediagnostic: DB6PR0402MB2886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2886596288BCCAACC4AFF62788880@DB6PR0402MB2886.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYXbeSpllnmHvmqo0pb9I/wZWn8jHu6+2figSL+s0EIswnj2rgBVZPhOgdwloiz2OQJwBmjUWIZRSCnPDEIrBRxRtl+cMziQkwZkw2L23PXCMo11pL8jkgkxQem2hQ/hGDauRyHSUlQ9LdQFYAwOKlFKj6dw17RiaQlGTDmaUqHwAXq6jpdm4qBurl6xNDcMdSj810i2/TWHBKBHx1uW8UOFooG8ESYaraE8hqfONYjsdOW+Jxw79JpKH4m9VFlVYOrBzoIDGSmSY7etDil1CuMP8Q5ohGFxign+USZXHNIchHEAXXuUBP+D7L9UqLDaOVGjY0XFfNJ4WgPKVnFHNgfxE56hEzTUlgaltjEp+k+sQ/MdT19nB7LZccv5spEfKeWYmfHgp6oP1CMwul0xwRVU+sIlAoWMz5R/LtiUnkqkz7uE/XJs4W32M4aUdiRbvFGb/yY546POZHIGE9Pyhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(52536014)(186003)(2906002)(33656002)(4326008)(44832011)(7416002)(15650500001)(7696005)(966005)(8936002)(8676002)(26005)(5660300002)(54906003)(110136005)(316002)(478600001)(6506007)(66946007)(76116006)(83380400001)(9686003)(64756008)(55016002)(66476007)(86362001)(71200400001)(66556008)(66446008)(15585785002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MhFTtc/maOkcxzKwB3xxmNu3r4B0J8+HoOEGfz2t4B1PGMgQeimQNV5jAqEVBSqLoS3SDR2pqaWlNrhZaMofe/HA+Tvd91Bf6twYUjX5Q/LQwSMxvRLJzEU/eUWBwG94CjrKuxLfBMq0MeQwMLhlAfAvhsDLno1HwqQbZ0Lfiv6pvsPi3JlDMvMEgViD5MT0C/Y/R9JvRUqTldMfFvAkYc8dggdpMd4ChQ4XhAvMLTCLJQWeW2kiCi1RUMY6kqR8ubnok4gwHUBJxwHyMORbSYRrEQObor/VVE7rhl7fuuq3rib8Puz2R3BTI+Ud6nuXRxjMvY5y3L7rND5RKJEf2RTnG8XiiDNvQHBNIavBstH2IhsO4AeAC/YQCglScoGY5RrdcR8ZTjbvpHqmk18zdbUv3Dl6Vp3rt61fgeyljeGtOnk3y6HsbUHk7hvxTFSl30AlofgzFlX0UDQ79nllZfzMEDD3c7s5BYAhoDjkWWfy9FiGB/3nSYB9b3n/E+RN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2bea13-0d5c-41b4-9bd5-08d8076ba9c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 03:10:26.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqHHuhqy1klS5oRBfihilKEz0Pb3Or6bfMBherm7aT9YSlNOaFnADCSawpzNMv2yehxQ1Gpyy4+rpN2ldgJT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M

I'll drop this patch for yaml update, since https://lkml.org/lkml/2020/6/1/=
370
includes imx8mq/mm/n/p.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX8MQ/M/N/P compatible string to support i.MX8M SoCs
>=20
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index 26b7a88c2fea..906377acf2cd 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -18,7 +18,8 @@ Messaging Unit Device Node:
>  Required properties:
>  -------------------
>  - compatible :	should be "fsl,<chip>-mu", the supported chips include
> -		imx6sx, imx7s, imx8qxp, imx8qm.
> +		imx6sx, imx7s, imx8qxp, imx8qm, imx8mq, imx8mm, imx8mn,
> +		imx8mp.
>  		The "fsl,imx6sx-mu" compatible is seen as generic and should
>  		be included together with SoC specific compatible.
>  		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
> --
> 2.16.4


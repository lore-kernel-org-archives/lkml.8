Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B428BC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E71E20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rtnvihcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgEKOMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:12:24 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:43872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730314AbgEKOMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzWjH2qMxouDt7+yUNiNdAmNgi57gmm0Dc3VL4h4maFP4W9Bc5dEOa/l7vX74HyIGjhOmFVEgQP9+EM0XMFxomPb9hZo/aU8AcZn5PnGcJX97UzJYArG1vQWvnYG3L9eJLDzPz+VPrTibBGr6Nl6Q2eBxWRzLyKLODGpMPBy0Uaj0W0GIIbgMdin46uoKbZHcSPqC/a2p0cBgVeBnT61pNFIhIkyqhKMdWK4hsOOjlXUZFaDi6zGLtu/R3/CFSzssvPYdnmoOe2Jiq0IRGxVV69ZJ8TgKTInCn1RvBzTlavYjPHNgCRrYeV34wa/0xZUeL1Td3NqITE5s3itloGH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aHJaBav8SVerFGBaiFCVvU6lmrRdvs76kV2PP7qr0o=;
 b=XbNaZykZZ8ejPGHdQXJq0YnOf4RMOuYzxNoBB3DnqY34crhT7yrhZl+5ik0gmYejE7uVT0u+uRTqUxzMdo/THLmizR195fEvhx8pniNUCLt6I8IiloS49b3SlCDV826imbmEGdr5wFnoRNeOId92YdgfhS1SzDHN+STtSIICxChaCnRuJAmUBoyXBhKZmURG1DLwT965nwqBJxwi5btHoKEqn5IN6v58o3FOJKeN7OMvW91C+KqRq7w8Nk+xRL22EIInCSyYg+NBpTbq5gbDhIiDTdHt2lZhwudqtM+dOJBG3MuEnDNKfbifnleB8GpRr52nlNSGtf8ALb0xxSMIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aHJaBav8SVerFGBaiFCVvU6lmrRdvs76kV2PP7qr0o=;
 b=rtnvihcrcFpTckkKSfR5pd0rBWwuC2PYKVWUgslkQxtwrptPHZHP3eiogK2bJ75U7n15WVR5YRQwZJMCVqy+6xu6vnN+L9OScJJ4DDh8bUgG0jLylnwkMUDC2woQcTyAafkg8F2uEbKzeSqqnEnVz21aWkbNRZj+AWyZ5suzgCo=
Received: from DM6PR02MB4140.namprd02.prod.outlook.com (2603:10b6:5:97::21) by
 DM6PR02MB4059.namprd02.prod.outlook.com (2603:10b6:5:96::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Mon, 11 May 2020 14:12:21 +0000
Received: from DM6PR02MB4140.namprd02.prod.outlook.com
 ([fe80::3de9:d192:ff78:5302]) by DM6PR02MB4140.namprd02.prod.outlook.com
 ([fe80::3de9:d192:ff78:5302%5]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 14:12:21 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Harshal Chaudhari <harshalchau04@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: xilinx-sdfec: convert to module_platform_driver()
Thread-Topic: [PATCH] misc: xilinx-sdfec: convert to module_platform_driver()
Thread-Index: AQHWJuoken/qqN3q0UyLQIrh4T2n7Kii7bNQ
Date:   Mon, 11 May 2020 14:12:21 +0000
Message-ID: <DM6PR02MB41406B5BD7A4379F73ECEB12CBA10@DM6PR02MB4140.namprd02.prod.outlook.com>
References: <20200510164308.31358-1-harshalchau04@gmail.com>
In-Reply-To: <20200510164308.31358-1-harshalchau04@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e62cc84-f681-469f-9a6e-08d7f5b5524b
x-ms-traffictypediagnostic: DM6PR02MB4059:|DM6PR02MB4059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB4059B61A501F7C0E2CE477BDCBA10@DM6PR02MB4059.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0eU+vFffxo1aKQvxiz8o2j2Wcek9CB6yoSHgCkqqHOYbQSI/hocSIcSMB5LRGUif3A5q7t0g0iwOd8YG+/ueD5Lmb8dLenmGV9S0Hf2Y0ygUelvIiJufmXHRgBE2dpXA8YHyRiYESrQLtu9kM2sJ7inIi3pXciM8QXAU9etmBNJmapp2DTND0uOd6QWJ5+qkFQtjBV7Jrn9I8Rp8xyOJtzybLeNiwFStLI+bIwCi6H9/miIVlOA8H2dU5mBql1sW1p/mDxAyltdE2wMYoLPVVQ9sfxbOLWYJ2uqjynkaF7UBeIawRDHlsuVWaYDyyNQNoPoEIp5O+0PuEr2x2M9ZkNhR+JNRr7e+yg//XvBPI3BWIg4QSsnKabdh0C4UG+M6oT3F9IsWhRNT2RhkKb/4gzQIxYRhSHhUVM3GO5kZZQHeDF3QsizsUWdMbULdX10R9Rwub+KkrcZllWbhrL2U3fGNEvRCBmQB8z+lSJCqwMBgmDbH1bN3XAAhH2uKHberLsJE3VNqZwk47RBHNHsnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4140.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(33430700001)(54906003)(53546011)(110136005)(66446008)(66946007)(316002)(66556008)(55016002)(9686003)(4326008)(6506007)(71200400001)(478600001)(66476007)(64756008)(8676002)(26005)(7696005)(33656002)(5660300002)(76116006)(186003)(33440700001)(8936002)(52536014)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 48T4btpSAerlz1vPlylJtZrzVmY20xDv5AUHhFsqpn2o+/RrOozNdEsQQ7Pm2SQXy5rzgr4eSUwUEQuj10JGmOhuqxEzodf7e1FTw30j4NS4p7wfP2fLdfWLWeD2eDMsAOTLm9+JTyv4x0LN9p7PwHM2FXBOfIlpSfWbxnfJ3EOuM/iySz9BRpXRrVg5xIyJjxmOjJ7ahVKJPCxk89vxtMJTriWGyZ4lTqAbMr1xeNbLvfiVoGLua9u9U21zX+H5bzeU0kZxMg0QJUBm/xy9hMtD09RMEDFPKYH1Xp+BOSsSm3Q1ADuroOT1c9K2VD+R96RXk8XSq3kMGXLUksbJ2D4M2SG/ILuRxStpuRMkTrr5aqZ4xsZ1ScB4f3RH23yzy+Ca+kW06DXqPcHeif+q2eFl0d8P7DeTxai7DekZ+/6nyMPNS3yn000SZTpC2Q8Uk+NcxVdWi7FrgnQe4CsshKCvMeHeDCVt41Z5BwhwAcnEoMV4vVenZf8QiRWtqO6Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e62cc84-f681-469f-9a6e-08d7f5b5524b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 14:12:21.3627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0Tqkd5la4CU9SXwpGwclkIHeK6rrmSSr8as/u0T/FyZAnu6CBi0JiBaUEqv1K6G9mCy9sa7F/40DJGGhY6aHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Harshal Chaudhari <harshalchau04@gmail.com>
> Sent: Sunday 10 May 2020 17:43
> To: gregkh@linuxfoundation.org
> Cc: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>; arnd@arndb.de; Michal Simek
> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-kernel@=
vger.kernel.org; harshalchau04@gmail.com
> Subject: [PATCH] misc: xilinx-sdfec: convert to module_platform_driver()
>=20
> The driver init and exit function don't do anything besides registering
> and unregistering the platform driver, so the module_platform_driver()
> macro could just be used instead of having separate functions.
>=20
> Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 71bbaa56bdb5..db16a42c66f4 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -1484,25 +1484,7 @@ static struct platform_driver xsdfec_driver =3D {
>  	.remove =3D  xsdfec_remove,
>  };
>=20
> -static int __init xsdfec_init(void)
> -{
> -	int err;
> -
> -	err =3D platform_driver_register(&xsdfec_driver);
> -	if (err < 0) {
> -		pr_err("%s Unabled to register SDFEC driver", __func__);
> -		return err;
> -	}
> -	return 0;
> -}
> -
> -static void __exit xsdfec_exit(void)
> -{
> -	platform_driver_unregister(&xsdfec_driver);
> -}
> -
> -module_init(xsdfec_init);
> -module_exit(xsdfec_exit);
> +module_platform_driver(xsdfec_driver);
>=20
>  MODULE_AUTHOR("Xilinx, Inc");
>  MODULE_DESCRIPTION("Xilinx SD-FEC16 Driver");
> --
> 2.17.1

Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Thanks
Dragan

Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6607EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386252065D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="mXAsuZ2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgGMIpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:45:42 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:15836
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727834AbgGMIpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+4tLt8Mwhhco3OhfYp3ZMHvBnWt/VMLwkYZaHqNCGJ2M7Yxf9ODVJKmp1FOWyF1S8iL4EsvpfjqpR+VJd1q/gaM89yh04S/Hcg0DBL++fmMbx9CqzyY/W4OVH+NhvgMeDyGP1/V2+11GlDVT7mwoWY9uZ4iRU7jwCoLaK217qDfcG1Y2Yqi8JQ0P4N11nKX9enBdvQ6xjqjvjxMN4Az5G9yO+AyMnzPj5Cv6Dz9GN6+Dv9Q3yZvrCkKwC/oixeiZnHNiud+GE3Ceon5OEu20rbcMV7dnCQlOtd5Ma3tsOAzN7ZUC+4jzf9T9iVNfKWnLvTXKtp6TKyV6KS3OP9jEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJwUT5S+YE1A/su5q5q3JdJxgmj8h5pXAxgSsT9FS8M=;
 b=glkt5CZSdyHj+IqZsA0itW2oAQAWnLn1EqS5N7fltTpIpE9kCKhHYkqQsNBDP0wKAxssm/mHGM8UPa7zaHKMFOiaEc6JKEvE0v8/htK3HnN+EXC38pqJpjMceF3AMs2P84hZIT9GmBLOYgXbWAIwvnZY2WhL8Yy7uOh3mlj7G5ESSPXd8B37VjWArask550PuhpyDNFrSBOyV0EjZvPmGg17Ku3gI5l9QhIz8BQ4rmkopO/X1M2TS9aX5rx7HMOHt8VhtD6IgBTFPEzon1HbQUTi3knHOGmkBvq1lvfghPf6ilrEk0p+TuCviI7wydHs1CwqmQG2Jlh2moc2XA4rTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJwUT5S+YE1A/su5q5q3JdJxgmj8h5pXAxgSsT9FS8M=;
 b=mXAsuZ2cKiOHb5wOSVdE8+B4NUhvw+Vw5iibVzesqtHwyGrw2fcKfwxa1hTsnMcoL3GE7e3MH2b0lZuZrMfG0oV9/e3DZIWdwLsGfq6pNRukl+s5i2m0OGFk/sh8AhNApF+uNq3fGPcgCdRHEyU/1DwN7vxndKILKjlg4pZydsI=
Received: from VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:31::26)
 by VI1PR10MB2320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:81::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 08:45:36 +0000
Received: from VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f97b:2363:7cfc:9150]) by VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f97b:2363:7cfc:9150%4]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 08:45:36 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Replace HTTP links with HTTPS ones: Dialog Semiconductor
 drivers
Thread-Topic: [PATCH] Replace HTTP links with HTTPS ones: Dialog Semiconductor
 drivers
Thread-Index: AQHWUqG3NenvGbZLWUeE5MxT8HaZlakFPnUw
Date:   Mon, 13 Jul 2020 08:45:36 +0000
Message-ID: <VI1PR10MB1662457FD0D0B6549C1DDB6B80600@VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM>
References: <20200705075542.22728-1-grandmaster@al2klimov.de>
In-Reply-To: <20200705075542.22728-1-grandmaster@al2klimov.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: al2klimov.de; dkim=none (message not signed)
 header.d=none;al2klimov.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d9bb325-81b2-4cab-90a5-08d827091cf0
x-ms-traffictypediagnostic: VI1PR10MB2320:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB2320475785D3D47868674A39A7600@VI1PR10MB2320.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m5h02he1Jba/0BQLzi2Ij2epARz/pSJ6kGWKeayVALe8QGTrD18FZJVUEnt3L9gAXbDfVN2L3O3T9hTqqGKijXwa+O4jD4/svNX8kzqclovptF4JcDvTf0gg3g6CstdtQx2qZUjTy7p9woStw6kVAwDgaGfEiuXK0DJnBrAdTiCmqrYGb8Ec8I5VfATU8C2oRpPMpKb7WK0/Fx3UmgR7mLRLE87s+RpjGl3w3YwKJR0sbSGzaUGaSu82ET5kHO/g5viAcqZedVc8YvJrX1Ie2ElbeLO2wmOLAW3xGSh0V+KsRtzAKlpSsCZu7Ck6E/7zWQZI7c5k2iEzFD8RCTvL7QBNhPKfj2KnqerRhVl/O4m9dETJ+ZQOKMYmIfuPP2JJH8Rmg0gzxvoQE7y17zWZvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(55236004)(8936002)(2906002)(33656002)(6506007)(53546011)(316002)(71200400001)(52536014)(8676002)(110136005)(86362001)(186003)(478600001)(26005)(9686003)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(76116006)(55016002)(7696005)(966005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: C5GOEagkaQT/sWjhu8C2Qf27T9Qci4sASP6Oqle2/xmBZlcWSd1BqrtRtZPjXnAwI7FxVtdeT8JNaYRvlxZKilupQGJq4YWliGduLt5bS/UrgsgOwqRs9tvVhAOhTB6aSHw1t5yi3QLNnMm4Kf2bztzCicINRsb4xq6R4WCLzC/i9yZZPq49ilEYPDA0OjG9MRdVS9JRJOXD95+tnXvJ9KhJpXJgNGUYJL6Yxk38ifFph3D/mUTs13CkwRUNihnnUm0soq7dULoduxRml4/CDavIb82rcdmDDedXDACAEdzD0JqkAf9KHMIPTccu0e7nsEzZP/KqdYhGyEUzXbZEpTH3mEsULCOfnehITC+kENPKl9e1UozmgL6krU28WXSXHNegdUrew+LiHLl0MG9mp4R/K4HFRP8kdJa9d03/JlvUdMz67s8vACdr/Rr53pVSPIsJJ2y53qsxAFu1EDYT1jDPPpiVIOYXeZJbUeBxKO8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB1662.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9bb325-81b2-4cab-90a5-08d827091cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 08:45:36.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndQY4Nn7AHHMy+S6e6TWYAg4P2v38eXYFiuwRBG9MM+umLi4xPl23KPzwu7P6VU4Jl0Ds1xY31QHR8MCa/7KFS0YvLzRSXKN29ZwVNP66Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 July 2020 08:56, Alexander A. Klimov wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
>=20
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  Continuing my work started at 93431e0607e5.
>=20
>  If there are any URLs to be removed completely or at least not HTTPSifie=
d:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
>=20
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> b/Documentation/devicetree/bindings/mfd/da9062.txt
> index 857af982c88f..bab0d0e66cb3 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -1,8 +1,8 @@
>  * Dialog DA9062 Power Management Integrated Circuit (PMIC)
>=20
>  Product information for the DA9062 and DA9061 devices can be found here:
> -- http://www.dialog-semiconductor.com/products/da9062
> -- http://www.dialog-semiconductor.com/products/da9061
> +- https://www.dialog-semiconductor.com/products/da9062
> +- https://www.dialog-semiconductor.com/products/da9061
>=20
>  The DA9062 PMIC consists of:
>=20
> --
> 2.27.0


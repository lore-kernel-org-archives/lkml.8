Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2BFC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E95420771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="VuC13j7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgDHRBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:01:24 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:29060
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgDHRBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8msTDaCwqgj8/z1wTo6zTgchc9jsTwrYRevY5zmvQcYZ6G/ZFonVMKV439Qj5tIupZu4J3Der+rqdVLLDh2N6Z7tQp9cmfwsMVLZYUb19mCJPeNxO/2qP03cksORyu6h8LzWLUvG/dvGAYvOP5J/75gnlUfRpQfXAGEG9etYcml1NCraUlQ68meLQjW+reYAf4zQxhFojQxB51b9omBGmuoo0JGaJ6S5sx5J2P2qrNZAPwL/sCguTc33JHcpXE724sg8jVU1DuWfPF3VwsRUdnmBPJ7OvHUE576taqv1yBKsE9/7X5kD/Em6hnxryYWZDDn9KIqj/kWIKWa35m4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0ipXFG+hsotlA1ggq0sTO2n4IpjtmKdzNbJH3lowvU=;
 b=EKx90jpJlbCQ68G6LhuFTcqB7a1/ys9DahrzEepVxGWsMU5yGE+8sUNB9JuAQS3iNhviwYO7qa3lX/3vv8AYOjfPKPBIUzvuKna533YcbVfD2WA0tI950HxRfMnouO4qJT79pYa0GN1oU8UxIO/LA8LAjrgtfK/qBMIw+oTPtSVDhs8lx7pwPtmxFy7YJhiWEsFLfPWliiYIK3DJBi7PA3E3ioNBl6y+hMRJdkTgxhvhBMEbJu4yJHwcYozO31wZwtcR8gloeCOjMziNxRQ5E5eN6HPm3CsLiNngGFQtu46WwFvnFCRivSyvaotaPZ0OZ2srvWsXAczPkpYGPLyuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0ipXFG+hsotlA1ggq0sTO2n4IpjtmKdzNbJH3lowvU=;
 b=VuC13j7XyRjnevXHbl1zJffQqgkiGuXECJZ4YTNvM8fplf8N5bikl0vGPtHResGaReIpyv7XAomCH7Ih/xxKRJGQsgSU7SSTbNCihewoonTBZTdJwImmWvcJsTbDkXjN3EtZxwH/kS9wUq9MBhxBR4oXOop7/PiAWJr6OpPg3uY=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1838.namprd13.prod.outlook.com (2603:10b6:300:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.12; Wed, 8 Apr
 2020 17:01:20 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7c:8ba0:7659:de57]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7c:8ba0:7659:de57%7]) with mapi id 15.20.2900.012; Wed, 8 Apr 2020
 17:01:20 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: RE: [PATCH 1/6] scripts: sphinx-pre-install: improve distro detection
 check
Thread-Topic: [PATCH 1/6] scripts: sphinx-pre-install: improve distro
 detection check
Thread-Index: AQHWDb5iIjm0kAhwrECaQ7vbPFdNK6hvcodA
Date:   Wed, 8 Apr 2020 17:01:20 +0000
Message-ID: <MWHPR13MB08950C5CC92A0C0FE0532AFAFDC00@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <cover.1586361086.git.mchehab+huawei@kernel.org>
 <2f22c8a80a4740176fabdee0d0cd23dbe7395b03.1586361086.git.mchehab+huawei@kernel.org>
In-Reply-To: <2f22c8a80a4740176fabdee0d0cd23dbe7395b03.1586361086.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d77e18d-3675-4ea5-5bb6-08d7dbde7623
x-ms-traffictypediagnostic: MWHPR13MB1838:
x-microsoft-antispam-prvs: <MWHPR13MB1838F2D0266BE78F912AF166FDC00@MWHPR13MB1838.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR13MB0895.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(55016002)(66556008)(66476007)(66946007)(4326008)(186003)(71200400001)(64756008)(66446008)(478600001)(81156014)(5660300002)(52536014)(316002)(76116006)(7696005)(2906002)(86362001)(6506007)(54906003)(110136005)(26005)(81166007)(9686003)(8936002)(33656002)(8676002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7A8Vo4vT1vb/9EN4B/bxwvjJL1MLU2eYiFv0ehMuzpV3k/XEXyAsZCFjIDKpZUutwTYt/rMi9Z93LMc7Y05aabI4KYjbrhHZdxG2kFDZrIBCigPu8SsErn+yweFCRZfdULUtxAzC6zU+Ocfvei1u/MbWXK380hIJuxjiMOfItKA0LaCPeRsFI5WQ2HVpKk8t6PllKcuYU0hkjqpr9o8z0vX5Q928j9AwXJfctnnv/aH2OJOBrPzI/3rFdxEPqQ3URuWLAOOOyq80ffdz0HJg3Fkt+4FSTn/K3UiKFxcOiYu5OD6fb6BIAk3Eejnqsg3VRyEpC3J7kRbV7LeDm6d6CIbN7J8v32EAbj38SkXzEMDz360oy91/mA5UKRgidD68d3YGbP/DDj2Srz+w1TBeAJ8d19owkIadlYoGAjzI1d+AQeKmmuIqleLFXFNBbUGg
x-ms-exchange-antispam-messagedata: KNqU3ozymJkWKoMVdueqsai0dkWDbYpAPuYNI1jd0yureebe6rvlCuWjXSPoJd7lgwGpSl91ieSNWllznE+71RrigTl4T1bnDYbhTFEXf93ow950XBakWS1sJFMerhuoUinbu7tDEtXnQNIwvpVh2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d77e18d-3675-4ea5-5bb6-08d7dbde7623
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 17:01:20.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7z3LLFwKM5aPleDHVJ4frcXBw4InjDDvWb+TgpaYQusDW6iKBiubAGEq8sc8VINekhRnEkS8gsWGGrcOb6jzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mauro Carvalho Chehab <mchehab@kernel.org> On Behalf Of Mauro Carva=
lho Chehab
>=20
> The Arch-linux detection is hit by catting /etc/issue, whose
> contents is (nowadays):
>=20
> 	Arch Linux \r (\l)
>=20
> It sounds a little ackward to print such string, so,
> instead, let's use the /etc/os-release file, with exists
> on lots of distributions and should provide a more reliable
> result.
>=20
> We'll keep the old tests before it, in order to avoid possible
> regressions with the other distros, although the new way should
> probably work on all the currently supported distributions.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/sphinx-pre-install | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index fa3fb05cd54b..c2071a1c69ea 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -780,6 +780,24 @@ $system_release =3D catcheck("/etc/system-release") =
if !$system_release;
>  $system_release =3D catcheck("/etc/redhat-release") if !$system_release;
>  $system_release =3D catcheck("/etc/lsb-release") if !$system_release;
>  $system_release =3D catcheck("/etc/gentoo-release") if !$system_release;
> +
> +# This seems more common than LSB those days
should 'those' be 'these'?

> +if (!$system_release) {
> +	my %os_var;
> +	if (open IN, "cat /etc/os-release|") {
> +		while (<IN>) {
> +			if (m/^([\w\d\_]+)=3D\"?([^\"]*)\"?\n/) {
> +				$os_var{$1}=3D$2;
> +			}
> +		}
> +		$system_release =3D $os_var{"NAME"};
> +		if (defined($os_var{"VERSION_ID"})) {
> +			$system_release .=3D " " . $os_var{"VERSION_ID"} if (defined($os_var{=
"VERSION_ID"}));
> +		} else {
> +			$system_release .=3D " " . $os_var{"VERSION"};
> +		}
> +	}
> +}
>  $system_release =3D catcheck("/etc/issue") if !$system_release;
>  $system_release =3D~ s/\s+$//;
>=20
> --
> 2.25.2


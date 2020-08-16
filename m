Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B91C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67F820735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="XGAaOSiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgHPPY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:24:58 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728986AbgHPPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja+ORU9hfip3wy4cozdHSTtwhiCWfJIEc7fPX/Q8MS50Q6Pzf4kYiYNuZAJeUt3z2RI3GTh4zvAevrVmsIAzyLwcZIpy5S1YrkL+R1cpRGILql+I0CLVam/zX6NiZi9NAW/17D/kQLE4uXCdOlUpSVzhfEAtlyJTmppF5yi0t60XpcNh1mneu4z7q8GNIPFbLB4Sb1y8m1nMW5mdpWAKs5pSg6EE/9MGF3CmrAgkP3LYXCHzC4sTMnzhQV8wqR0WVwE/6VmXITi47dDy+rNMiS7dhW+Wit7cIyPNkL6JzIeecmtBOF8nrnw+2cgWEV0+qLYxLjdomiMkztgzfVw7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saKl9jgjFqG8JCVZLNRU/mIpUdbYjNEyJWqe967zcgg=;
 b=Bp4WqU45kpytIjCljeKAvp5IlIhCWYt6BIr5RRYF6UEnfqx+gTmKpBf94KR12KYYVtvSaCIPVzHJ/vLiCo/C+ZW+S2BKweAFAbbHhvJZsMcW1mYEi7gHj5HL26j6xzTpqj6OojO87MXOW4a3jXbTN548ju2XudtRaTEHHnA0Mezly1OGMxw4usXVpztK7SdHdmBhTsc/mNjRXU4yxyafDwKwhHgBAp5WzpeuykMkS7OXPSnGMPQca5Z6OYxui/HC/sPrbetTc0r0JpfkN0UX3etPVq95N22Hu2cb2Raot95hUN9teuQNn325yg08K955HUJjaQqx245H2EX2xnbT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saKl9jgjFqG8JCVZLNRU/mIpUdbYjNEyJWqe967zcgg=;
 b=XGAaOSiCKs/HR/Pr2fljan1MDNE02Ldgo0daF0LfJP6G9xcAffXGCEmLB7zOFth432LJlTpahOtVGbzMnNoCfRIOPNmYZImaUkHZYcuIrexb+A0oEXMDadt6LKBjHz5GmPa1npQ07Z9wdJp7eB+esNFbA7axW6E378eL73GlMlw=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:25 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:25 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 5/9] habanalabs: use FIELD_PREP() instead of <<
Thread-Topic: [PATCH 5/9] habanalabs: use FIELD_PREP() instead of <<
Thread-Index: AQHWcy3em7LwEXut6k+WnHG+hTCXm6k6uNYg
Date:   Sun, 16 Aug 2020 15:24:25 +0000
Message-ID: <DB8PR02MB546800915207BE06D7CF9A2DD25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-5-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-5-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bfc2ca3-6624-4c4d-1b19-08d841f87598
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB354788AB35E3C912F8527834D25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AXM8jJrHILHJvvSssDmEjk06PabMNiC0ca8o9JGjc5rHsGe3FlgtQuDi+srF4/Zj5xNsogKX+F8Cb+4v++PulJfQuncz7kxbRbXU65ux6n4iLolmr1BpeISyx/8HSfOIL5KmeQi/Igg2WEB6+JHHd0TPBrQ7G9yG86K2XiyTZ9rC1Rk0U7ocubsp9Wxee4RFxFp3ikYXjLmcfui9+vF26sIrthdfo2dCmVNojXJE/omaTOFq84yQlR4xkgAizbrvxzTq6GUruQt+Qwn8uGeMYyaq19ksG1BP9cYjsP5Ow+5rXxwUN+DvgEZW9zOZAsTUii1Sn7UlKkcj1WQ0scy3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(83380400001)(7696005)(86362001)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(558084003)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xoxKpfoMiFaEr7BL+/w38xOPewymyJBfwWaAmkLY6Wf36tRjjk2W2kf09pLxbAgIA0c+WM/mpKcrKnHyMqyTJwH3UYbCYmz9M96OTCcDc5LqPsWoItnMD7tBRCzXQFzdMM5Enxc/drtn9CUjjQL185OqI3LpI6kUmdlTIuMQLtvC9szc12g82Z3rR86ira3n4ovHGtiQOECcqvhJkevjaqkgtWdr7mElSr6hsmdtoPwvrs7N5jf/I2P6v0DvssyJsEWGLIoiGOCMNZyWmZ+1xq7Y2FLApEl5o/lS/+6M3Mc32x+S7+blst/nb0OQqtr/l26GFPZVLadkeXKZpziNyqZvd63rjZmqGej/ejxzgBlTq3wda4Q6mESYDmJyvq5g95aUbHEzncgmfAw2pl9BLnisjy5w9gU60M/oISFZ0bYJkQm0icykkWY1CxelOs9mFsx3XL822HfE5FrO3JVPtjPFiAcrolf3jN9NnaWBcnPhI1weXSIOJJr/CBwHcErKk71p5k23q3d2dEy687CIT+KQm6wOqRtQD4iwDPMSVh7abENkLGpEbju7oTaeTazgS7asAYe3D0S7vT8E4Hf7I8+icy4x1WWcDoTqb/24Ai2PGvJjjhsn98G3mllaLrFOK2xCuojRLFIgz4hhef8Dpw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc2ca3-6624-4c4d-1b19-08d841f87598
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:25.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiU0uJsevFyjBUbRKjqMo55h/4MWKe0frPiNY3nHh43JatJMrv2Jio2CF3mhy67PWpTnt2yRHFkGN1TWph0ntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Use the standard FIELD_PREP() macro instead of << operator to perform
> bitmask operations. This ensures type check safety and eliminate compiler
> warnings.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

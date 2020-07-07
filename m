Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F045820758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iq90VN2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGGGS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:18:29 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:12160
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbgGGGS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnVhY63UQouEj+mbjlHKK14awifozhdSrEFsfLaIK0xHAnHlinraOx+rfuXbMdfOjNwJb+eu4aRq7ZAg4winvtXzV1mM/hBE8tMABf8QLgqAuJmdzt/5Ayk/L1p/FfJ2AwXIJkKosqNOQoNZVFsOJMYiZ/KDTr7U8mTiRvk2MTON008DGoBAF/NH3Tkufu1ZTaFpGidwp5PvPNvm8EyqI5K6C2OAEuaM99fJW+Mii92BV0CO3gvs++57rtCWcUlSr0gW0/vDIwsFv7B2Wl9bt4B6+h4GMQQvgR2cEQQdU4BEb4dOzjkr4ohwvbKQ1BZwUT64vJZal0XrDAbIY0j7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3YUZVAs+hBGp2uPyhojEODy92OIKNPEgdYLt1Ovtxs=;
 b=B4nTMLU0+m+x5IDKbeTbOTa1+RU6oSI2AisUH7vNY/0EAfojfUSi1BhH0rPlVnRzFJazD/ixza4B6646hH3GDIcN9WpvROD2AWZRdUN9V3QicQ735vbxW6Qfg5t5w+S6sSF6KhojGZpQ3TEdFhHa55wEiOvwH9XJEz0bXofkYx0yxVAR0jJw3vIhWwCnG0fRD/LGSNPRBRJRPfZ+FBAOPDBySj6kGi75WlAuxw7bk75IrQPgzJU7ZHbLJCf0zVdWwI169YfbZQXBKsnmUYZs8hCEq7Hd+PTA/i5M6MFEs/Mw0QPbP65kcLth7dyp7u72NmCt0zGleoKWIYjdaIumnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3YUZVAs+hBGp2uPyhojEODy92OIKNPEgdYLt1Ovtxs=;
 b=iq90VN2zvPANsSrOJAYVupS6uT/a5mKP2rVxp9DtOXyq0HCXlziW3+jgSZSdLeyMlM6MArZzY7Dkfd/507nw6TjMtHUs/wDECcL0oPwiESnkbJg5auHMiTAfYU1SzMOAG/5motrpuqHjmSZBK8tgdS6R/2E4dBlfc1E2MPEIYd0=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6280.eurprd04.prod.outlook.com (2603:10a6:20b:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 06:18:24 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:18:24 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH 0/9] usb: cdns3: Improvements for cdns3 DRD code
Thread-Topic: [PATCH 0/9] usb: cdns3: Improvements for cdns3 DRD code
Thread-Index: AQHWT3AW2HPPPyrPm0KjpkjP0kQ20Kj7rgIA
Date:   Tue, 7 Jul 2020 06:18:24 +0000
Message-ID: <20200707061834.GA16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a91730f6-dcb7-4db9-6edf-08d8223d8e4e
x-ms-traffictypediagnostic: AM6PR04MB6280:
x-microsoft-antispam-prvs: <AM6PR04MB6280303041E5A3C43C72FB8C8B660@AM6PR04MB6280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKSqZzY69IOgE7X57iZdpTJlNIdHaI/HkZd2/9uBx630pFyncDUKwNYQbxOhe6oahzapYRUwGs9OApVRxD4hNR5bK6NjgFByhZpgduJq7Q+91NH/C/1SzT55uA6W0kHaNV9GqXZa6N99yDJme7oclMp3YCXIpgRCeffYSF0Gk9K4PJ7z3/triJT7IhRuPWU9hKOzMw9op3LKxgTsrPfGwjxrYzeoblASw4sj+kMBMl3kWb3r1V42CNCUR8E1EnuNK2yxxQTA8iCEy+PvVbAblMn2U9yW3S/7SoCTnhuku+wj0E0gCcmdxVCAOtBGwT0Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(71200400001)(8936002)(186003)(478600001)(91956017)(66946007)(76116006)(66446008)(64756008)(66476007)(26005)(4326008)(66556008)(53546011)(6506007)(33716001)(86362001)(7416002)(6916009)(1076003)(316002)(6512007)(44832011)(9686003)(54906003)(2906002)(5660300002)(83380400001)(6486002)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xQPdiBnKI70Atr42gID7/3dl63dczbNqSEZ5KUyQl7phv7pLNtfmstnoS5hzPs3vpP7ChiR1v551B3kDIVIMRBTae51bLhBJ0afppS17drjcunlfo1wm5ADk/9tVoiUsujJCG5Jx8fxP9dUxljKrApG2CZqHXMagtERu9t1n7pNDANfeiIFs4Zx+UvWTndnLpTwbk/WWOWhJ4v0fLqUYBPmjzrNyMiO+TsqVrMJgqjP8iraXpEbwSguCRao6hqcQGMT4fyFo6uWxLlaGqmbT0cdL0xOMNK7lHqqTbpDqaXWlVy1g7jJLg/dCLiJ/5z5Fjiq+qexqH9KPydJ1ejnnpw5kMio+IHBhbJnIIy83CDKLLhbyj6KOPOxZreMKGk6/Xsy8NOTjpBfIXZyeak7RVXbvWc9FMYTV9sdtuVw+fe1/ycYmYe4+20xl3LYt8HsqmUCFBHbHF7v7aPLQZgF37T9QeeJTD/fuSe/dZWj5+pw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D91B5D8DC228074BB3711A649C4553BC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91730f6-dcb7-4db9-6edf-08d8223d8e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:18:24.7395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QrQ+oQ5xL0YWUwMiHuQlyVD7DO/FE54W95JdwvKiEZcXvNzr1UFnuAF1qgF6QUF6Oz4GlLil+NjysJUgj12lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:19:55, Pawel Laszczak wrote:
> Series introduce some improvements to drd.c, drd.h and core.c files of=20
> cdns3 driver.
>=20
> Except for the first (1/9) patch that removes not needed function,
> the rest patches make improvements suggested by Dan Carpenter
> during reviewing CDNSP driver.
> CDNSP is the next Cadence USBSSP  driver which will be upstreamed.
> The DRD part is similar for both CDNS3 and CDNSP and Greg suggested
> to merge the similar part of DRD code. As first step I want to merge=20
> some improvemnts.
>=20
> Pawel Laszczak (9):
>   usb: cdns3: Improvement: removed cdns3_get_current_role_driver
>     function.
>   usb: cdns3: Improvement: removed not needed variables initialization
>   usb: cnds3: Improvement: deleted !=3D
>   usb: cdns3: Improvement: return IRQ_NONE explicitly.
>   usb: cdns3: Improvement: changed return type from int to bool
>   usb: cdns3: Added CDNS3_ID_PERIPHERAL and CDNS3_ID_HOST
>   usb: cdns3: Improvement: removed 'goto not_otg'
>   usb: cdns3: Improvement: removed overwriting some error code
>   usb: cdns3: Impovement: simplify *switch_gadet and *switch_host
>=20

There is no part named "Improvement", please replace it with
drd/core/gadget etc.

Peter

>  drivers/usb/cdns3/core.c   |  39 +++------
>  drivers/usb/cdns3/drd.c    | 165 ++++++++++++++++++++-----------------
>  drivers/usb/cdns3/drd.h    |  13 ++-
>  drivers/usb/cdns3/gadget.c |   4 +-
>  drivers/usb/cdns3/host.c   |   4 +-
>  5 files changed, 114 insertions(+), 111 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

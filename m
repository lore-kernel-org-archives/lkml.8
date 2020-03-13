Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C0720716
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GcB7bD2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCMDIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:08:52 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:23621
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbgCMDIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRFK7ZniZ3Alm2VjR9hrxKJennRZEr1n39PUDwhAZcI/MX9LaClRMck4Z+4jCfGBmzz3pOLJmF5UbMI6vvmjpK7etqMOZ/xrbt0etbo6C8V8YUCgw/g6utrQC9PhwEK1rli7HBCopszPabx8BS40d6ts7NzK36x/GagMa0852hMqRHDhRDWeJFZe4WyYECLHgC8PS6NkoprzzaPfaT4C13UFIXzlyooMpLcgHESrchfVVTci+eGUzKPuUhC0TjiUHShAFvV/a3KIRNTw1/DqVNbsd10zE7VHFesA9A1t2i9+64rdUI+J7+scievW3b2lu5YVi1AvSoKKls7K3K9rWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar5taA56XLik3dPQeFsVGrUfD445/K5UbmP4xtxYbGk=;
 b=OcSTIo5FFJHreggNuogL+axmjPBE9LZ44Aoy2yTuwmXyAdfdXTSdd6QzfruFWX7IvIXD7wtRLCUxIPOnAHjaocNZ8LYz991ciPOEA69SxOB5DBxqv3IiyVGRNB/dcPPAcheUb9W24cWGgVRT+0MegycoQ+W/FOMNLjBtODWEMwCLiQpMLsIC+Blkfg4IZFfCc1z7BSRFh4PmCDIzL0FRadIGn9hhWEVK/+cg0VPNINvKvaZ/Zq3Mu2vnY+ontJRQprN80IDDNYQXkWMp+fSIZ/YtEP9ukJXAGtX3Fk/BMNBK1Ewcn080ICsg6nwMeL8GBhLAwdeDlIK52dFNgf+tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar5taA56XLik3dPQeFsVGrUfD445/K5UbmP4xtxYbGk=;
 b=GcB7bD2+xkd8MrQkMHQZeO1tufIo0FZwl42FQZGfifVbj0JCetz6zJdP3eDMLvWeAiDz3m7KV5ojDrp2kSYFv0lVdCf4Knb2S3Eibxbz5zw/dF4ecnJHepKFx90N655gaEpg0N2Bn9mluDvPbmoU/IGG/5O9kfYBPrI9oclYpnI=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 03:08:48 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 03:08:48 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Topic: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Index: AQHV+FpZgufkrsn3KkuJmHgdNm1nAKhE1zoAgAAUhICAABsJgIAAB0wAgAABBgCAAMmjgA==
Date:   Fri, 13 Mar 2020 03:08:48 +0000
Message-ID: <20200313030851.GI14625@b29397-desktop>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk> <20200312130037.GG14625@b29397-desktop>
 <20200312143723.GF4038@sirena.org.uk> <20200312150330.GH14625@b29397-desktop>
 <20200312150710.GG4038@sirena.org.uk>
In-Reply-To: <20200312150710.GG4038@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4211b07c-136f-4932-7e8e-08d7c6fbd97e
x-ms-traffictypediagnostic: VI1PR04MB5327:|VI1PR04MB5327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5327B5C4FBDA79704B28AC248BFA0@VI1PR04MB5327.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(66446008)(66946007)(33656002)(71200400001)(91956017)(66556008)(76116006)(66476007)(316002)(33716001)(64756008)(5660300002)(26005)(6506007)(6512007)(186003)(9686003)(6916009)(6486002)(4326008)(4744005)(53546011)(2906002)(81156014)(44832011)(54906003)(81166006)(86362001)(1076003)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5327;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUuYm8uFG6O+EoRIu0Sem2a7/uKC0qE5eVnnW0xcmkn5iFc2s4qitCFkPN61Sq39uynjuhuRpJUWrnkQy5s2BAFUiABYd+cDYCDMw9zghIk5ibRat7FRTSF+aF/fehXitdwwv9Nr0B6mFxneFxsd9pXLSOWMdNSawo1VVVg66NeliZ8wFofKrMBqgWn4+YQUMJDEl2ME8lJ3g9VjMDJxHsGCqcee109orJ3yWcpQOiDOCskvg6WpaHZtQbQ4FRQHXiJbPaFmEKoOPgW2CQ3wCAXl4+Z28YotbDqxkhTrL2pNlb3akEbZiZ3ZHBFecNDm3DjYw3jRlPHioon2uUIe/8GD++UTFi1xOaPlyLrppd8shSz+InapooWwggBsOYK97UaNmvuFQwwJX8ipHJEtrFBbnFZIzJvsz2Cq5KmqrLAzJPEikRWATu6oZagA5+jE
x-ms-exchange-antispam-messagedata: SyCA6VwcOtSW7QdON7j+QOACj2NihLAEuYygJvRgEEAujRUpYLyOP7jUpNI3PXX1OVLbchdTJq82Ucph3jKVZBleWM+Jbg4Zw6CSC0pONaXZbtfjZfbGd3ogZDAOQTWpgXANoGkccfQtu7quyxZ+yg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7857552FA995FB4AA07CA7F99A6EEA02@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4211b07c-136f-4932-7e8e-08d7c6fbd97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 03:08:48.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXu2RY18VIxmkjtZYlv3sOAmkrRJFCgaM89AAY9NmWQ+jC8xb99zmvfeXBR+gFokBoJBj94cB9C7neF8MtWC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-12 15:07:10, Mark Brown wrote:
> On Thu, Mar 12, 2020 at 03:03:26PM +0000, Peter Chen wrote:
> > On 20-03-12 14:37:23, Mark Brown wrote:
>=20
> > > Surely it's the GPIO controller that needs pinctrl support then?
>=20
> > But the pinctrl register value for this gpio will be cleared after
> > suspend, we need to restore it, otherwise, the function will be not
> > gpio. See below patch:
>=20
> I'd expect that this would be handled by the GPIO driver, the user
> shouldn't need to care.

GPIO function is just our case for this fixed regulator, other users for
this fixed regulator may set pinctrl as other functions.

Here, it is just save and restore pinctrl value for fixed regulator
driver, not related to GPIO.

--=20

Thanks,
Peter Chen=

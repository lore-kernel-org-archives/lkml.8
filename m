Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88570C433EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4435206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vetr8OK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgHFKJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:09:50 -0400
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:55175
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729120AbgHFKJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLWYDMiqTiD8QdJJ8rsHR7e7yPsyymdNFDVsPWbIcTJQxuwB+mc64j1bfqdcRIVHzYJSxzd+I4nRQfrqDY79Sv/J+4bNt4wu7LhR6eN7LCKiOIqIkio55BddfjtxJy8jUQJZg67sploYiAG7sbha2nP+R2ocIMSTL9N4dcCj1jj6Ht2JcTySv4MePmruDzLfPtfl4plp9WTKeC/goOVmwDLqmUSpjwO29BYY+pSSUc1nkr7c3RzKE2dD8senaJ1UQ56CWvB+EK+jeCeC0IDakKfD3MQwsQPHDTm3iKI7yLEnw26QN8waaKBfdtCLTvYEgzMP1dz8EuzXFjn7EnEwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A40D78dl5W0DQmLSEXDvpeLJhkMUoqqrwkFnVtJWXok=;
 b=UTcob4/0sSWDjBQOV9eDewAVARqSGharqIYPkbJuvOeV0u5z7Id1XfahfCrfY15wP5oL5Xp/8EdVv/hNOHXBMEpl0vr4bmurTu72tWUhLBUgBVf7sXIXOHyzIY9rCUNmN6z4DrXXHA9xIRm56FKvPzC9lManEWYLG5/dHIxs5vyLkiA2wWiSkRfQWMARCUJ9XYdVWVLjyfXwcqxZsxh3FmCaEB6JMFas/nWn2OpHd1zAzM3dbLBc9Tysfn95r+oWCl8VnBE4lyOIJ6gnftzoCew3h2zxY4aj3Jol/qNvL0T+EkClp9Q+VPzULU3Q2NtIiUOIeGIyK+VnRkz0Dc9oJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A40D78dl5W0DQmLSEXDvpeLJhkMUoqqrwkFnVtJWXok=;
 b=Vetr8OK9Uz4dc25udX5TpLbOs0c6vkSybqH8Hpn4mfAGT6g4+9catRz0uZY4yKZYFmVv6eAPqcDyGf/9t2Jpd4sovxKkfn0dStViKEH1URafKfmVQMSsnKcf2T3ecO7BUi+FYm+FnCBv/ceZVnGaHDZ0a17SwC3LQqLQegMP0FU=
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR04MB7167.eurprd04.prod.outlook.com
 (2603:10a6:800:12a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 10:09:36 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024%5]) with mapi id 15.20.3261.018; Thu, 6 Aug 2020
 10:09:36 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Marc Zyngier <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Topic: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Index: AQHWaj3ZMAA/XWH8SkmG3qCWNnZEoaknx/iAgAALMQCAAQxYoIAAVj6AgAGoCSA=
Date:   Thu, 6 Aug 2020 10:09:36 +0000
Message-ID: <VI1PR0402MB38245CE471A2BB33CE27C33FAE480@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org> <20200804113850.GB15199@bogus>
 <VI1PR0402MB38243230C51FDB1C3F490853AE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <20200805084748.GA4818@bogus>
In-Reply-To: <20200805084748.GA4818@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5143661b-12b7-4fd3-facf-08d839f0d31e
x-ms-traffictypediagnostic: VI1PR04MB7167:
x-microsoft-antispam-prvs: <VI1PR04MB7167F8DFE7602B4EE122E836AE480@VI1PR04MB7167.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqET+pK/xbF7g4Klvj24VZ2RU67ADtPZOZxyAztxSXRR47/JiD9D02i0oYOvOSywosb7v9CSL9zjEtC+19AOHOpw8VRqdPzFp9cmF1qA2T4tMa3sX9Zht6xrzkkYMNPQmmhgeEXd+vprz8TpY3OrcMV6pkN5KP2DE5KQO94lqdwxiWi/PQquU132SfcN6ZNxx6oJgGkPvJtuD+MPefUVW5hteeiznLYoDdJB7g2FnEOTkr7qRsEY01tru1nR1TtaJcVIUiDPHWY6x4yyvPVEezy8WdMh0iJfwYkXFMTxPnTvgi5gYqLFMSnO9vW7PvpCf6tFtWeVBWpUUIXiGBtC9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(66476007)(316002)(54906003)(6506007)(8676002)(76116006)(8936002)(7696005)(66946007)(53546011)(55016002)(9686003)(5660300002)(83380400001)(33656002)(66556008)(2906002)(52536014)(4326008)(6916009)(64756008)(71200400001)(26005)(66446008)(186003)(86362001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2NER6oGy4jrk0JJ1t4NUN4IshvXeiQc2WmI9ZLvvnwtZoxgliSp9Naq24i6HpdPYuPBY7L9d1Nfyv/nTZDAN37oClygSpHf6+TNSVir6iAmQNwGdOApfxhwIe3UyeebA95kVGR6pVTdquu4jXrY3qsr+ZRAPoe5VDQvMxcIAV3ZNMaZwgIZqBHQgaJGmC7g2Vo3XIziIZgaQWfHQtuv55x4cSNHQGwHntPjXiUfJpXf6W9cTN5PVnxWy9tok/X2p3ya8yzddzmUSKy5Uedyb5P/wznrgp/f3uXDLE41osZ+KvviSrTnqfHzC4N3fezrK8zJGpfX2PsC2CmM4ZmKzlOFpFEa3457fJ1kiu7VxX5PKdUs0Cdx4NXsIQLFkJU1nW6coJq2TvhkdvdNDJOkIraApkhRyuDK47lOMM5BpLo7s0pLDVB5x6BkNZq4TlwntciYl3Zuji8LpWHEyCfBRPF4CpoSCqK5yzwH4In0lb6hhZ6i2EVDf7qjZyYOX7m6Cg+bZvy2rsyFPBhf06kDdmCf+TwyVXl+6x9ePLJdNLoz2f/2hrxodeUOt8M9U29qthTAV9b44Nvor9x6hvykfeS5alhwTlr7lCZoiTFUqCIv56ox4iQhRFeKc1ZvsIt4RdB6H5L2Lsc3jKLesKOVO1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5143661b-12b7-4fd3-facf-08d839f0d31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 10:09:36.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ot0a5D7qZpWaif2UptQ1rRN0+KEYkMigH8sSi2HtNRi987tz5ReARgiKnhfZi77aUBV6K7pWh8kd1A8HgDWWLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Wednesday, August 5, 2020 4:48 PM
> To: Jason Liu <jason.hui.liu@nxp.com>
> Cc: Marc Zyngier <maz@kernel.org>; catalin.marinas@arm.com;
> will@kernel.org; sashal@kernel.org; linux-kernel@vger.kernel.org; Sudeep
> Holla <sudeep.holla@arm.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask i=
f it
> already masked
>=20
> On Wed, Aug 05, 2020 at 06:31:20AM +0000, Jason Liu wrote:
> > >
> > > Indeed, the runtime PM ops in that driver looks dodgy. Any calls to
> > > mask_irq from drivers or anywhere with irqchip suspended with just
> > > blows up the system.
> >
> > If you look at the chip->irq_mask implementation on different
> > platforms, almost all with directly access the register of the irqchip =
including
> irqsteer.
> > There are fine due to driver will use the common mask_irq API.
> >
>=20
> That still doesn't explain how you can prevent system from blowing up if
> chip->irq_mask gets called with irqchip suspended ?

Do you mean driver, the driver will not call chip->irq_mask when irqchip wa=
s in suspend.
if it does, it will be big BUG. I believe we don't do that in the driver.

>=20
> --
> Regards,
> Sudeep

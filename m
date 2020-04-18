Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D2C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B01214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rv7na1Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDRJKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:10:16 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:49351
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgDRJKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deFECko1xrqyBPI5jy4xV+1sCzxpGMA9DsjYQ765lU/YoGo4wxXoziGCE91PElJdvFiPid1pwKpybhh0VjrP/xjHAedHEgphvPyNyPK8Xw85Yn7LJRnJECTiumEwo4QD4PTKxyCeOtAN2zauh74F8iA5TTdG0MfhRCW6suoP6jdNbbgVsecTsJYOAQdenlxSk7zg2mBwwHVo88fbXxlhm49hx5zPJp/NmDS2TnpFztKUCW4SrhI7rScVAHmFoDzI9D/fbPZn4Byb47M0irpPPmZnJx8UACJ5WeOkn/CQviok0VLEZPjBe9deelShAS1pdnDComsJNISfdHdlyvYiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXIvG1wj6s+aBHy7SheIEyaJstTIGN2nA6ALgwnvtVs=;
 b=LH0bVZ9CcE723ViBy4pNff3lVf8ZL40EflepEEnRfPsvQNcHGyk+O1312tMuHwPRgCcv2gCDZDX9nwcUufRIMaXsc5ZaFRLI7odwgHkRRPohdQrEuBjoj22Eg8MciMa4R1MJdiWIkxbhZghdPguLh+bCHRW6qp848VhhXjEcLWMyKIdkJMYcy3mYpNu2JMJ0l+Jr3AQXzVs0Y5BPq/6HArLFpHJ4YDp7o22+4gETYmgnRdzRHRBR1IFDewWTxu1vNqD9PA0wkMkH68fqR2flyXTuaqAkak9MHjs7UNVlflHPWvIejnH8j5YiPFzhc6ynNGZJD50lrQfwAK4DXPxl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXIvG1wj6s+aBHy7SheIEyaJstTIGN2nA6ALgwnvtVs=;
 b=rv7na1KpG6Ynz7+2nQEtpAdxzNzvdEBUJC2vCT548lxEsQu7wXGCkBebW7sZAtUqQhAfAyZt/5rPcO4o4oXtbVPIONxZwwb7rTatnFj4o0NtpzA2w7C47FbwDomrbgkYFGT08Xxrk94mYFQpEnib1pGG5kQnb3MsciL/KJPXtmE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2839.eurprd04.prod.outlook.com (2603:10a6:4:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sat, 18 Apr
 2020 09:10:11 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 09:10:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] remoteproc: use filesz as backup when translate memsz
 fail
Thread-Topic: [PATCH 2/2] remoteproc: use filesz as backup when translate
 memsz fail
Thread-Index: AQHWDkktpZBH/gJE+EqHoCmC5/cfIahxkGoAgAwt7ICAAOcL0A==
Date:   Sat, 18 Apr 2020 09:10:11 +0000
Message-ID: <DB6PR0402MB2760C900A4838657D82023F088D60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <1586420572-28353-2-git-send-email-peng.fan@nxp.com>
 <20200410012226.GV20625@builder.lan> <20200417192155.GA6797@xps15>
In-Reply-To: <20200417192155.GA6797@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [180.107.26.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac1c4c7b-bad3-4b2f-5eba-08d7e3784c5b
x-ms-traffictypediagnostic: DB6PR0402MB2839:|DB6PR0402MB2839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2839933E63F94D0A2B24E56988D60@DB6PR0402MB2839.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(76116006)(478600001)(26005)(55016002)(66946007)(86362001)(81156014)(8936002)(44832011)(71200400001)(66556008)(64756008)(66476007)(52536014)(66446008)(33656002)(54906003)(110136005)(316002)(4326008)(8676002)(9686003)(7696005)(186003)(6506007)(5660300002)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGfZCOWu6F+w6TSfxHt5wGrXd1p+6suHhXQC+yxiiI4t/reh8WEFWTrxK8x2zeIibxQ5wwhYYYsqpVmLVIBY0IVul+yY1Jfh9sl0nwAY65e7A9a/EkoCO+6TaJyAAss0dpnd2k+Of8hoSRn+EtXVaa7CqeD7bnqD4SGWZrVhCSjOuvhN58IddUXHkzaCyarQqFvAOa9JLGXu9hFxTmrcWnY+WVSx9Ohmoo99846/R0XcchsWVt5aiqHwj0xtmjRJuK0psJ7cT1B4CrlZiPX/JhPw/SUH3mfbah2LAchMlFNE2hb6WT5yN2uahrcp+SCYbW0cYdngTbMRUcea3kyEAJPeJKwv+kpPb3y0n/hUtmt3IOMyChKzpI+pauCyexgtur59Pw0+sxdg1xyG+vlfC8Yw40Rcn44nwlgWMWf6abgqBDZGfl4HLUpRO8mWlil6
x-ms-exchange-antispam-messagedata: Rbg4QfhNCgo5gd618Wxx5hQ7ni5DMvnwqslcKKj47i7VuktIeVGXwQxuTdfCNVcB4lYNF0fwoALjX0NGdIzzhsq8q0cUu3p9pp6ybj0A/cxlmQcOt3wR11bXTCgNqq6YJNKkyGrmk4q3yMQy33USGg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1c4c7b-bad3-4b2f-5eba-08d7e3784c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 09:10:11.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OkXDVnswPHIIpYwjUIyYYj5VL4huPf0AAtrVMvXxyRM0CptHSeIvb69NVEA6AetgsoFMWMoXZRsksx6ftmHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] remoteproc: use filesz as backup when translate
> memsz fail
>=20
> On Thu, Apr 09, 2020 at 06:22:26PM -0700, Bjorn Andersson wrote:
> > On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
> >
> > > Since we no need memset if memsz is larger than filesz, we could use
> > > filesz for the da to va translation when memsz translation fail.
> > >
> >
> > To me this implies that the firmware has a segment that's larger than
> > the memory that it's going to run in. I think even if we're not
> > writing to the entire memsz, asking da_to_va for the entire memsz
> > provides a valuable sanity check.
> >
> > Regards,
> > Bjorn
> >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_elf_loader.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
> > > b/drivers/remoteproc/remoteproc_elf_loader.c
> > > index cc50fe70d50c..74d425a4b34c 100644
> > > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > > @@ -229,8 +229,16 @@ int rproc_elf_load_segments(struct rproc *rproc,
> const struct firmware *fw)
> > >  		if (!ptr) {
> > >  			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> > >  				memsz);
> > > -			ret =3D -EINVAL;
> > > -			break;
> > > +
> > > +			ptr =3D rproc_da_to_va(rproc, da, filesz);
> > > +			if (!ptr) {
> > > +				dev_err(dev,
> > > +					"bad phdr da 0x%llx mem 0x%llx\n",
> > > +					da, filesz);
> > > +				ret =3D -EINVAL;
> > > +				break;
> > > +			}
> > > +
>=20
> Adding to Bjorn's comment, I think if rproc_da_to_va() fails with memsz b=
ut
> succeeds with filesz something went wrong with how memory was laid out in
> the DT or the ELF resources.  To me this patch offers the wrong solution =
- the
> focus should be on why rproc_da_to_va() fails.

ok, I'll send out patch to fix imx_rproc. It is TCML and TCMU are not mappe=
d continusly.

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> > >  		}
> > >
> > >  		/* put the segment where the remote processor expects it */
> > > --
> > > 2.16.4
> > >

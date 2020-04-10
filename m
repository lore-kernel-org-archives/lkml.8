Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF24C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598AF20768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hNTGdcYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJBaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:30:03 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:58790
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgDJBaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:30:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXy+0kDsD/v97xv6FjpT7si+ajVaIt9GJzwi8f5B1YaBUisisIHmHNVYNE1AdPsNJTnBW0UPpheJanqIu3rqkQfgpZD/WO9kTutfTXTuKVJ1EJ46C4YOpWMyso7kgGRUJ6t+s4QnaiwjHC1M/aY1lR6eLUwBpvGs5yDKTV43v0uXNz1oi4JhjFmGV1mYejmaUBUJXvE6mLO/cPrJhQLsZepRWz46hzXbo4lQDa2kQ/UMZTxbdV2ZfB6zi/u1tvwVQFSx6pMb6oGPYxVujA2NqmJh8Tl0+AlGuVV3GudtubHzLXfhINh3R6raNGPKfKQngRThn0YbxkeC4zaO0Zju3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dURG8zsqU2ZJe/vFBXp5gBH+vXZB9DQvt2K6ZKfXsk=;
 b=VRihnBxcQahBFwm517DzSEQuZ0YepUpl4paUFzIkpVCzAIwlxm683HUcBDwRq4cIOxDllF98i5JF5+AAQ9Akh3A6C9oHS11g7l06GHEtVHXKrBXFvXkShgzK6+Zeomk09I1Toq5ZI7cSJCFheDXEYEXlUSRZehXEfNY7/aSMmD7xcPFZ0/da+s4nLa61zJDl9UGSm/HtFkCRxYQYTGViWcCiErJIY9yq7dck3Xq0j/2RK+42nXyWUWmck4jQUopxfHvYGiqiqJLqHh2aQfNYFImAWh9DGQqbuTtgnzrg22gi0ybmyWeHIyqjUsLtw1LnXhjq/TCObBL8j16truNW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dURG8zsqU2ZJe/vFBXp5gBH+vXZB9DQvt2K6ZKfXsk=;
 b=hNTGdcYI3CSIIKI8ETbp3A2uNUpZRWsNsT36anQHtLZxafrjg4TgVETlosdlhprPGhDhv2as0H9wFkCBaLKomIddjJv/6WdfNn3fB/KnmwvenN9pIQV5wlDp+JwAowTSFBQwZ63VQ6yGe3TlgLDlxgW5qZ2ByNtewkicfKRHTqw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB5907.eurprd04.prod.outlook.com (2603:10a6:208:12f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 10 Apr
 2020 01:29:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 01:29:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Thread-Topic: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Thread-Index: AQHWDkksD911aIjfYEmeF50HneT1dahxj+QAgAAA5uA=
Date:   Fri, 10 Apr 2020 01:29:59 +0000
Message-ID: <AM0PR04MB44816C59A9BE84465AC8F2C388DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <20200410012034.GU20625@builder.lan>
In-Reply-To: <20200410012034.GU20625@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d503d0e-b512-49f8-63a8-08d7dceeaf4b
x-ms-traffictypediagnostic: AM0PR04MB5907:|AM0PR04MB5907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB59078B9B5DEADBC09408304F88DE0@AM0PR04MB5907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(81156014)(8936002)(5660300002)(6506007)(71200400001)(8676002)(186003)(26005)(33656002)(2906002)(44832011)(478600001)(66556008)(52536014)(9686003)(7696005)(6916009)(64756008)(66446008)(66476007)(55016002)(316002)(81166007)(86362001)(76116006)(4326008)(54906003)(66946007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJisyu0j17Mdyf0lMywGamQGOVNvBhgQPAhl0to/eK6SHQE0i3Zgt7PhsmXuqPTB6A4vox+SXxAgAXFPjnhM8vIO6EoKfr/V/NK5zVUO7H3ttAiOfWcz9SS02zuP+/UM2sFsII1nvPMLknYEmBvlsCSyY3icCJuAmepV7NgbdFopEH66luukIgYDyrbA+H8vy1UyPvvPFe/2YCMkBiodFP1+lXQQZ2rgM2OiF6WuyRlZbgWFru/WvDHUtFGChdA54vVIJfFzMLiGihN9mDgPCImMhUJno6niXBRomRW9qN0KXzNumkYRhTf84hLFy/t1EnvFc6WSAYOV17+R1LRq66IEeEwVikjD9p1s2uaC99S9HbA+VMOooTLiqN2IkgatdYDI8PwGfPMRL+BwvgDvjrn8s6kRx0mrqxvclWwpgVr4pLHXfK/+DgekoyapE2H0
x-ms-exchange-antispam-messagedata: eDHEGkTcPKc7Fj6/0LoS0qmGbbNatiMHy1y4aIou4pU+5jzXYjaaMDpyqBE9kojIF4dwEtLwI5dWqKXiNtyzOo7YuMGSoKPD3kcv6S/yLNgu/Clk4iQngFUvxUxb2S5VakF6jMKJDXKGo5kOJ4izNg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d503d0e-b512-49f8-63a8-08d7dceeaf4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 01:29:59.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxh9/13TGd0sw6wwWcsMvyDsc3rnVhFKO0JB3GaIxWFHPH274yoUcHZvlRlNSCaWzl+sokdmgK5YLtoVClrdZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
> segments
>=20
> On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
>=20
> > To arm64, "dc      zva, dst" is used in memset.
> > Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
> >
> > "If the memory region being zeroed is any type of Device memory, this
> > instruction can give an alignment fault which is prioritized in the
> > same way as other alignment faults that are determined by the memory
> > type."
> >
> > On i.MX platforms, when elf is loaded to onchip TCM area, the region
> > is ioremapped, so "dc zva, dst" will trigger abort.
> >
> > Since memset is not strictly required, let's drop it.
> >
>=20
> This would imply that we trust that the firmware doesn't expect remotepro=
c
> to zero out the memory, which we've always done. So I don't think we can =
say
> that it's not required.

Saying an image runs on a remote core needs Linux to help zero out BSS sect=
ion,
this not make sense to me. My case is as following, I need to load section =
7 data.
I no need to let remoteproc to memset section 8/9/10/11/12, the firmware it=
self
could handle that. Just because the memsz is larger than filesz, remoreproc=
 must
memset?
Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk I=
nf Al
  [ 0]                   NULL            00000000 000000 000000 00      0  =
 0  0
  [ 1] .interrupts       PROGBITS        1ffe0000 010000 000240 00   A  0  =
 0  4
  [ 2] .resource_table   PROGBITS        1ffe0240 010240 000058 00   A  0  =
 0  1
  [ 3] .text             PROGBITS        1ffe02a0 0102a0 009ccc 00  AX  0  =
 0 16
  [ 4] .ARM              ARM_EXIDX       1ffe9f6c 019f6c 000008 00  AL  3  =
 0  4
  [ 5] .init_array       INIT_ARRAY      1ffe9f74 019f74 000004 04  WA  0  =
 0  4
  [ 6] .fini_array       FINI_ARRAY      1ffe9f78 019f78 000004 04  WA  0  =
 0  4
  [ 7] .data             PROGBITS        1fff9240 029240 000084 00  WA  0  =
 0  4
  [ 8] .ncache.init      PROGBITS        1fff92c4 0292c4 000000 00   W  0  =
 0  1
  [ 9] .ncache           NOBITS          1fff92c4 0292c4 000a80 00  WA  0  =
 0  4
  [10] .bss              NOBITS          1fff9d44 0292c4 01f5c0 00  WA  0  =
 0  4
  [11] .heap             NOBITS          20019304 0292c4 000404 00  WA  0  =
 0  1
  [12] .stack            NOBITS          20019708 0292c4 000400 00  WA  0  =
 0  1

>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_elf_loader.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
> > b/drivers/remoteproc/remoteproc_elf_loader.c
> > index 16e2c496fd45..cc50fe70d50c 100644
> > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > @@ -238,14 +238,11 @@ int rproc_elf_load_segments(struct rproc *rproc,
> const struct firmware *fw)
> >  			memcpy(ptr, elf_data + offset, filesz);
> >
> >  		/*
> > -		 * Zero out remaining memory for this segment.
> > +		 * No need zero out remaining memory for this segment.
> >  		 *
> >  		 * This isn't strictly required since dma_alloc_coherent already
> > -		 * did this for us. albeit harmless, we may consider removing
> > -		 * this.
> > +		 * did this for us.
>=20
> In the case of recovery this comment is wrong, we do not
> dma_alloc_coherent() the carveout during a recovery.

Isn't the it the firmware's job to memset the region?

>=20
> And in your case you ioremapped existing TCM, so it's never true.
>=20
> >  		 */
> > -		if (memsz > filesz)
> > -			memset(ptr + filesz, 0, memsz - filesz);
>=20
> So I think you do want to zero out this region. Question is how we do it.=
..

I have contacted our M4 owners, we no need clear it from Linux side.
We also support booting m4 before booting Linux, at that case, Linux has
noting to do with memset. It is just I try loading m4 image with Linux,
and met the issue that memset trigger abort.

Thanks,
Peng.

>=20
> Regards,
> Bjorn
>=20
> >  	}
> >
> >  	if (ret =3D=3D 0)
> > --
> > 2.16.4
> >

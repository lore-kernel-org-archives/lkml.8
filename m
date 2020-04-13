Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E51C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD22A20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmAVr+U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgDMJGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:06:02 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:9462
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727889AbgDMJGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:06:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnpB2J6uUMazwRSgGVEBBC+OlyEt5ANPiZV7R1cYRNSLmsNcb94m+DTw6XyWUWSLa40VyINJQe7jY3SMfKRuESU+6vXHwLU9a9bA823XKMrQg4MCfw/w7i25pZSVuouP4QBQQtYqjUCY3XfXsUFNLAaKSTeU8zS4tmmZuvqvkmPjTBAfObj072pVy9qePddC6KNdCT0prscPjCAPfKwGkSc374RYN9R/2BAcDlHilSv4cffAG7Bhj0HcVx7jvoRi/bYc8Mf6D/B8fOR0X5hBC1zl6jNK9UNDT1UiBe0cpnfZNmOTnP7+cqZWpph1/sYGxYovO7dhf814/nhyzUV7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtNy7eOo4kYwRmxieTsNVo0TpJFD1FVYxj4rvMSdu0s=;
 b=nWDpjPoMkchCcmDJ7fAh6ihMSk6W+fC5ZHH2Z/MoNjHNKmFZzkDUfGXfgB30pZmPPeB/Kskx9zhEn2Nd/hKmIl2WgLobkkb13/zMoZf5ror6gwo/4CXmq4+tnwx4Enu9myshF/ucoGYouLt7l7DBf+je4YFO3GagglV+IPnej1/hBzdznnnytDK2uIUDqPDAhrdLXMo0Ve9sYN06b5r9x78UOJqejuhLh3jSyPnOl7wJw4m12dbglBeK81cZMwaHNtD1AP5LeXDS42ij/dRcEbs2EAgwlM6tDosKCvD+R//O1mDAokTi/Q3UGWNHGu6ILW+brxhZ1ZZkShpDGWjP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtNy7eOo4kYwRmxieTsNVo0TpJFD1FVYxj4rvMSdu0s=;
 b=UmAVr+U176Sa3jsVNHV0dz8AQ+d3XUHCS6zOCRCg6KHqxOXjTHsrwTPbLAfii3gAiaiUcWHnRT/RvQaAr5Gz1iRamnM1MPYaXZ1KYYb5+IUuJR+Tz8z9agwDFVKvtbSbITtvT8j/DdE3lnDzNG/F2rjitfuMMJSHJsLVNMdQ3Rk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB5090.eurprd04.prod.outlook.com (2603:10a6:208:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 09:05:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 09:05:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Thread-Topic: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Thread-Index: AQHWDkksD911aIjfYEmeF50HneT1dahxj+QAgAAA5uCAAZn1AIADm4TQ
Date:   Mon, 13 Apr 2020 09:05:53 +0000
Message-ID: <AM0PR04MB4481CF4ACD86C69B329D5F2188DD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <20200410012034.GU20625@builder.lan>
 <AM0PR04MB44816C59A9BE84465AC8F2C388DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200411015104.GJ576963@builder.lan>
In-Reply-To: <20200411015104.GJ576963@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdd4cf23-8d89-4f2f-54c7-08d7df89def1
x-ms-traffictypediagnostic: AM0PR04MB5090:|AM0PR04MB5090:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5090D39E388F00F03361423588DD0@AM0PR04MB5090.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(6916009)(54906003)(33656002)(316002)(55016002)(6506007)(52536014)(9686003)(71200400001)(5660300002)(66556008)(66946007)(7696005)(8676002)(2906002)(186003)(8936002)(478600001)(4326008)(44832011)(64756008)(66446008)(76116006)(26005)(66476007)(86362001)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BjTddog6dwyQhPkK0T1F/ylMsZRPLM5v8Vp8kqBjmC62/ixRMMkV+WcfzNvDfOmALhpNCn1HW3l0f3UO6SHM5lfUjmQJ6d1iYl7uA2QGqpr5lw+4xznwtmxELsuwIGMYHQuNbPjop6PKvsZwt3FAo+lxlm6nsA2K1TOP3xaTgkLagTNbi1tk/m1Y1RoVjcXvhzt1hLXEFR6bXnXUfKB/74TugsIw9XC6EvaNH25eyYQX4muEI1ooeExvzLZcZHHU+9CM4vVxK/af/eCBaYbcnuo+RVrjKvbIqLU1y//MazPO3HRFHEU5jDNbgmRLMh7vgE2Iqe3XXt1c9f433ZC1TVWnhytE3Alkd4HH3kagWjOTildIaishuqqNSq6TtSQIr3elvTtUQEPEffG3f4j0+pcURfl56eRBLF+NZfPjY0lNBw3bILQcLTXbcqfXrHSX
x-ms-exchange-antispam-messagedata: TSLI+5xqJj4ot/DeGtJeshwC6h/kyHR43FohJ9sjEEoRcCOC+sG9NkeK7GBbFl9QSgDS2WZGy6J+whWrFsRuHq2ALBL3OiO7V4O19wP0+P+bT1uKYiXA4a6cu8syAShW/qdIL9t0PgBvfCEI+UQk2w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4cf23-8d89-4f2f-54c7-08d7df89def1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 09:05:53.9516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqBU7JJOBlwQxGJ46OPEDZsF20rCOZvrXIy5+4XqatlKB87wWXbvpbYnFQCPk2ONXIyAY6qGEetWgKSWHr4mxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
> segments
>=20
> On Thu 09 Apr 18:29 PDT 2020, Peng Fan wrote:
>=20
> > Hi Bjorn,
> >
> > > Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
> > > segments
> > >
> > > On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
> > >
> > > > To arm64, "dc      zva, dst" is used in memset.
> > > > Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
> > > >
> > > > "If the memory region being zeroed is any type of Device memory,
> > > > this instruction can give an alignment fault which is prioritized
> > > > in the same way as other alignment faults that are determined by
> > > > the memory type."
> > > >
> > > > On i.MX platforms, when elf is loaded to onchip TCM area, the
> > > > region is ioremapped, so "dc zva, dst" will trigger abort.
> > > >
> > > > Since memset is not strictly required, let's drop it.
> > > >
> > >
> > > This would imply that we trust that the firmware doesn't expect
> > > remoteproc to zero out the memory, which we've always done. So I
> > > don't think we can say that it's not required.
> >
> > Saying an image runs on a remote core needs Linux to help zero out BSS
> > section, this not make sense to me.
>=20
> Maybe not, but it has always done it, so if there's firmware out there th=
at
> depends on it such change would break them..

Got it.

>=20
> > My case is as following, I need to load section 7 data.
> > I no need to let remoteproc to memset section 8/9/10/11/12, the
> > firmware itself could handle that. Just because the memsz is larger
> > than filesz, remoreproc must memset?
>=20
> By having a PT_LOAD segment covering these I think it's reasonable to
> assume that the ELF loader should be able to touch the associated memory.
>=20
> > Section Headers:
> >   [Nr] Name              Type            Addr     Off    Size
> ES Flg Lk Inf Al
> >   [ 0]                   NULL            00000000 000000
> 000000 00      0   0  0
> >   [ 1] .interrupts       PROGBITS        1ffe0000 010000 000240 00
> A  0   0  4
> >   [ 2] .resource_table   PROGBITS        1ffe0240 010240 000058 00
> A  0   0  1
> >   [ 3] .text             PROGBITS        1ffe02a0 0102a0 009ccc 00
> AX  0   0 16
> >   [ 4] .ARM              ARM_EXIDX       1ffe9f6c 019f6c 000008
> 00  AL  3   0  4
> >   [ 5] .init_array       INIT_ARRAY      1ffe9f74 019f74 000004 04
> WA  0   0  4
> >   [ 6] .fini_array       FINI_ARRAY      1ffe9f78 019f78 000004 04
> WA  0   0  4
> >   [ 7] .data             PROGBITS        1fff9240 029240 000084
> 00  WA  0   0  4
> >   [ 8] .ncache.init      PROGBITS        1fff92c4 0292c4 000000 00
> W  0   0  1
> >   [ 9] .ncache           NOBITS          1fff92c4 0292c4 000a80
> 00  WA  0   0  4
> >   [10] .bss              NOBITS          1fff9d44 0292c4 01f5c0
> 00  WA  0   0  4
> >   [11] .heap             NOBITS          20019304 0292c4 000404
> 00  WA  0   0  1
> >   [12] .stack            NOBITS          20019708 0292c4 000400
> 00  WA  0   0  1
> >
> > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/remoteproc/remoteproc_elf_loader.c | 7 ++-----
> > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
> > > > b/drivers/remoteproc/remoteproc_elf_loader.c
> > > > index 16e2c496fd45..cc50fe70d50c 100644
> > > > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > > > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > > > @@ -238,14 +238,11 @@ int rproc_elf_load_segments(struct rproc
> > > > *rproc,
> > > const struct firmware *fw)
> > > >  			memcpy(ptr, elf_data + offset, filesz);
> > > >
> > > >  		/*
> > > > -		 * Zero out remaining memory for this segment.
> > > > +		 * No need zero out remaining memory for this segment.
> > > >  		 *
> > > >  		 * This isn't strictly required since dma_alloc_coherent already
> > > > -		 * did this for us. albeit harmless, we may consider removing
> > > > -		 * this.
> > > > +		 * did this for us.
> > >
> > > In the case of recovery this comment is wrong, we do not
> > > dma_alloc_coherent() the carveout during a recovery.
> >
> > Isn't the it the firmware's job to memset the region?
> >
>=20
> I'm not aware of this being a documented requirement, we've always done i=
t
> here for them, so removing this call would be a change in behavior.
>=20
> > >
> > > And in your case you ioremapped existing TCM, so it's never true.
> > >
> > > >  		 */
> > > > -		if (memsz > filesz)
> > > > -			memset(ptr + filesz, 0, memsz - filesz);
> > >
> > > So I think you do want to zero out this region. Question is how we do=
 it...
> >
> > I have contacted our M4 owners, we no need clear it from Linux side.
>=20
> And I think _most_ firmware out there, like yours, does clear BSS etc dur=
ing
> initialization.
>=20
> > We also support booting m4 before booting Linux, at that case, Linux
> > has noting to do with memset. It is just I try loading m4 image with
> > Linux, and met the issue that memset trigger abort.
> >
>=20
> Please see the proposal for attaching to already running remoteproc's fro=
m
> Mathieu. I don't expect that you want to load your PROGBITS either in thi=
s
> case?

No need to load for early boot case. It is just userspace load trigger
kernel panic, because memset arm64 could not work for ioremapped memory.

How about adding ops hooks for memset and memcpy to let driver
have their own implementation?

Thanks,
Peng.

>=20
> Regards,
> Bjorn

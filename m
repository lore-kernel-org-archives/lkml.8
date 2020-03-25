Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC8C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324352076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nd1qeHuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCYMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:30:29 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:53924
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgCYMa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsfk93Z7S/jGXIe2Y92MlVHS2ZF4424UQ0RmZMezKo7avpfLfIaJzFdP4Ds3RQt8sMqPLQJopvrF0qevtAD2dV7+FHBkbY2RlbtB6KnyHamPilPnLpZHc9hPGouFgwKl3NpvAlKKbq7FrPmG7Ya7VJOw8uSzL+qnZgXpootrUjmDN89tLnv6XVTxexvyBh68wCqlPwsX357EttE/CN0gfTFiiEOPGJ88uwj95rqFm7MUo073EEhRBDzUxkkt8cnl483jcjT4N4CYg3YDCVBkekl2VX6IzE8ky/90oyREyfqYUi7EBjvUx6nzoYBMQNpUwVWawSvkAr2x3mjlIgl+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4BjYlW/6YO0guIU3ipAjjc8TE1V69gyw/Vq7shKALM=;
 b=SF7MLkmn6HZJoJ64JM3ANB1KKc8+cvv7G0pBHd99nfJy9AvSlmYaC4HMZXgZDTRLowozWSESKjrVEH7I7Cu0Ec4AVbU5d1ZmAGwSebq1/1c0ZSsvgubpgFHQC6vU9vkEm17cMsFoei/0q2qga+RpGxfWtKJqfxi1/HQedh+UuDiy7qEOC12x1lsUgqWOOWRryXomTj5IURmgFRSRAj3ymzCUjJHE5CQXgLXdAFWcf3oaPFevQI12anoluHXbIvwX81lpOmyFcvSYyJDreJuqSE1EaV0gU2hsvRQK9gms5JO1q3njkxXX+90uKXfbujVBrD7CLmbIQehvNRYEO/LqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4BjYlW/6YO0guIU3ipAjjc8TE1V69gyw/Vq7shKALM=;
 b=Nd1qeHuKyDQLgVWuXwvJXPvZT95ONAzG8eqcVhp7IDw1EarHYMdhC+ZNVYKblKXyxUHl3KGfDFqq4FuutJA2KRZ+vAv8n34UNw2CrL6sAnufI5YfEAwbJNz9MmjyRh+zIag6wmeeR7lIp7RplhRe/+I6x8nTnu2+MUwpNZ2WR2E=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 25 Mar 2020 12:30:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 12:30:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable without
 EXPERT
Thread-Topic: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable without
 EXPERT
Thread-Index: AQHV9tsrS4nkBuxsuEaY66LPIEgB5ahYGTaAgABvteCAAKZfAIAAJLhQ
Date:   Wed, 25 Mar 2020 12:30:11 +0000
Message-ID: <AM0PR04MB4481C3A233AB455BDC68736288CE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583844526-24229-1-git-send-email-peng.fan@nxp.com>
 <20200324174134.GH3901@mbp>
 <AM0PR04MB44819E95EB1FABF09DEE682788CE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200325101652.GJ3901@mbp>
In-Reply-To: <20200325101652.GJ3901@mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2756cbd8-7d92-445e-2c62-08d7d0b842f7
x-ms-traffictypediagnostic: AM0PR04MB4353:|AM0PR04MB4353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4353832C686498E2B43E984788CE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(45080400002)(64756008)(66446008)(76116006)(66476007)(66946007)(66556008)(7696005)(55016002)(81166006)(81156014)(8936002)(8676002)(478600001)(5660300002)(4326008)(9686003)(966005)(52536014)(316002)(44832011)(6506007)(33656002)(71200400001)(186003)(2906002)(54906003)(86362001)(26005)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4353;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmIQPvNrh5P1wVcvbh11m0GzNWPP+Fi4R6m8+qWHXZxABeNgFzdQUj9bPmWz9Nfw4D2bqpGPUNuyu3VFwqHPdJD6Ae3YScaI1yNfxxq9DszP/0TYJMQwd/gUXvD5AhQomSRofDs1xxnfLn3k+/bMPfhGoigmTYub4DxR0WUyvYIHl/3DN9TGOm62pOvk5jHS4NgU5PlKAtfxXqs9s2qzBZJEIpt26bPFDrN0f+RauMJ29i2IRtaW0kIINDiJOILeMuV4ARnWFJ86SXmURA7uh1ZW7fwW6+YEFBnxFcsmDi4ITNIcRp8OFndUkYFB7oTiG/Kihvy2MtSaDntH2JsuLgDLq7Xplz3Z9XDyLNaQKjthYuXeVaILASU+cwTDIYNFyXi2XZmYREh4W2MYFCoN5hQsUKTI2n6ZQlxkQVZXjNvvwY38LHNTGQ4Qn0CLH8RX+MyDK2j93mqJ+Haovq25YTomlSKxmeyskUAjaIPc9gQ7E2iw2BRLwyjDkQyZrOt8b7F1vsmw/zooSffHaBeITQ==
x-ms-exchange-antispam-messagedata: Po4jOW8p9I14Hl6pv95ENiWVoAYFD79XDwxUEVxVB14SGm6SuzRdV42r3Zg1HVbz/u4bathb4GBN4HpVJwoKRr7ncqNuD4kWItgGoJVHmk5tfqcWtcxBVAPWN88glj4t2MeTBlPrtQZU8ezAQSgFNQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2756cbd8-7d92-445e-2c62-08d7d0b842f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 12:30:11.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo/VuOfGok600PDPuTFOeIFYpI2pCeB/JLn4l+55yqyUaTWmTaSkqVS/N63wV6hzAkq5npypANOE+pqQJn5Wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable
> without EXPERT
>=20
> On Wed, Mar 25, 2020 at 12:34:15AM +0000, Peng Fan wrote:
> > > On Tue, Mar 10, 2020 at 08:48:46PM +0800, peng.fan@nxp.com wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and
> ZONE_DMA32")
> > > > enables both ZONE_DMA and ZONE_DMA32. The lower 1GB memory
> will be
> > > > occupied by ZONE_DMA, this will cause CMA allocation fail on some
> > > > platforms, because CMA area could not across different type of
> > > > memory zones.
> > > >
> > > > Make CONFIG_ZONE_DMA configurable without EXPERT option could
> let
> > > > people build non debug kernel image with CONFIG_ZONE_DMA
> disabled.
> > >
> > > While I see why you need to toggle this feature, I'd rather try to
> > > figure out whether there is a better solution that does not break
> > > the single kernel image aim (i.e. the same config works for all suppo=
rted
> SoCs).
> > >
> > > When we decided to go ahead with a static 1GB ZONE_DMA for
> Raspberry
> > > Pi 4, we thought that other platforms would be fine, ZONE_DMA32
> > > allocations fall back to ZONE_DMA. We missed the large CMA case.
> > >
> > > I see a few potential options:
> > >
> > > a) Ensure the CMA is contained within a single zone.
> >
> > This will break legacy dts with new version kernel.
> >
> > > How large is it in your case?
> >
> > It is 1GB
> >
> > > Is it allocated by the kernel dynamically or a fixed start set by
> > > the boot loader?
> >
> > We use alloc-ranges and size in kernel dts.
> >
> > But there is only 2GB DRAM in the board.
>=20
> So I guess without changing the dts, option (a) doesn't really work.
>=20
> > > b) Change the CMA allocator to allow spanning multiple zones (last ti=
me
> > >    I looked it wasn't trivial since it relied on some per-zone lock).
> > >
> > > c) Make ZONE_DMA dynamic on arm64 and only enable it if RPi4.
> >
> > Option c seems a bit easier to me :)
> >
> > I will try to explore both, but if you have time to help, that would
> > be appreciated.
>=20
> I don't have time but option (c) was already discussed and there are patc=
hes
> from Nicolas on the list:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flinux-arm-kernel%2F20190820145821.27214-5-nsaenzjulienne%
> 40suse.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C6403ddf37
> 89b452ae5ee08d7d0a5a659%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637207282191026738&amp;sdata=3Dt2cZ9HTCcRuaL9RO4kD%2BzN
> 2n4VqM%2F66zYNZIOComCVs%3D&amp;reserved=3D0
>=20
> The above series was checking whether the platform is RPi4 and limiting t=
he
> ZONE_DMA size to 1GB (otherwise 4GB with ZONE_DMA32 empty). We
> ended up with a static 1GB for ZONE_DMA but we missed the fact that it ma=
y
> break existing platforms.


Thanks for the information. I'll check the patchset and work out something
proper to fix the issue I met.

Thanks,
Peng.

>=20
> So I don't think it would be too hard to revive the above series (most of=
 it was
> already merged).
>=20
> --
> Catalin

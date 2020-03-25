Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57262C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24040206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BNmHE66I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYAeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:34:23 -0400
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:6085
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbgCYAeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 20:34:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+2Zbw7sLYd6E1doZpiEYoXz4HUyKxYaUaZ6/pFD8cOPKEWum6+oyh69X8Dd7SC56mvHbTVCo7o/V8uDi09sYL4/LjCVH2TVXYaJJ19fXzfn4ImlfAcIWXpDTGvzrTOOIprImGYwWxtTTdLJ1BdIIcSqpdTiqNlKYWdgCwfixRbjZhzr7kyUgxMKIxhzRqWjgIp8sBo6i7uo1Eb3XDKZQNEyGLXfogXYa256J8z1XfdT0Mn1zSkpTdC+B1VSMjBGXYkonV298o1NXGdWFIqoEtrAM9GrAOifxsJu3gqNFh/gypr0yrK/5FAaK/6QFQWcRCIkB2f08rF2rI0xZ2UJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ80jsi8n7OF1+QIDKfFGPXM5vE/RyJtvCyzBEXV5Hw=;
 b=cw/fo8+inNn9DXbB3xSBadKqcsGHxbtYfKAdr4eAMXEb5huIp6PpPiZNN1Rf+B/r8RrDrjs2blDqbu1hUXoGH2UtbjOZbgaDh611iE6sioSopyvZaHakVUilkjBY5jdasER+LJvI25WwTMp/DHSvF12XpW5813arXRUBp4AzakYDmA7tPwmljgSZWrK8cgHpu1hTGXsYq9ZjL3DQtoBFylMDlTiv8Xa1HHxHkcjS+kwgRZLRSTpyx1riGj2disG4qjOlCtOTlkVLd1LUOfe/axp0LET+UPZ6KF+Qi+vxIkgrTXl5IdVrt0u4LDM0K7LiRPkECYW88rmtJpVVnnWloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ80jsi8n7OF1+QIDKfFGPXM5vE/RyJtvCyzBEXV5Hw=;
 b=BNmHE66IybWkku2zl80HX4PrffuVdnjsHsWlQ+GxK4J0eXSXzJ4N86j3GKL433m0kmTQWFWD/lbVh0KjW30I7Z3KFooQOXsXr8JNGfXLRNo5fSXP5DQU/yvKssy9YuMMK0iqDgXM3dmNEDKdX2hSnbQi/wjQEHQiS3KxAb97API=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4946.eurprd04.prod.outlook.com (20.176.214.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 00:34:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 00:34:15 +0000
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
Thread-Index: AQHV9tsrS4nkBuxsuEaY66LPIEgB5ahYGTaAgABvteA=
Date:   Wed, 25 Mar 2020 00:34:15 +0000
Message-ID: <AM0PR04MB44819E95EB1FABF09DEE682788CE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583844526-24229-1-git-send-email-peng.fan@nxp.com>
 <20200324174134.GH3901@mbp>
In-Reply-To: <20200324174134.GH3901@mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [121.239.103.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc6d26de-6cdc-44f4-f05b-08d7d0543f6d
x-ms-traffictypediagnostic: AM0PR04MB4946:|AM0PR04MB4946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4946C5691B37A227DE0C7C4F88CE0@AM0PR04MB4946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(54906003)(2906002)(5660300002)(9686003)(478600001)(4326008)(44832011)(316002)(6506007)(8936002)(8676002)(66476007)(81156014)(81166006)(52536014)(7696005)(55016002)(6916009)(66446008)(71200400001)(66556008)(33656002)(186003)(64756008)(76116006)(86362001)(66946007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4946;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szWmHy5CjW4yBwxaax9z7CbUnqtio6TBc5YIOEcpmyFxlgBSxScwjbL+kLl8SMwqWFCVjAOpGiuV8GsrBDSVxm5NWlj9cx4FfdnoyBNNz9meQXirgCZ/3c8E4Ly5gXrAquwS904/PD3/+9Sa+91KVDp6Dfce0TVVu6xbliw4HSGErySUnLJcGNUVbe3BZ89Na0ReY41ywYaifqqro2mNCGCXXC84HufSCS5RyjoK0GeCPtLv66vJqf3ED+j2u6kw9z1HlvCee9jHjlmU+N70NwOSPVuHUdDW2A4hhBskovpM4l1dk+g5hcZQ4BCgFsOfncqlqK9skQp5TBdKt2RkBMvsHBfmP97ZijExhl7a+ftdOWLyjNKb7PM8sdkCH3nooHRWDeP6JKQ3ARc2MPxNM+jU4iarW1SzyLcyVuRFlpuLB6iizRWOUfIgmbdIKjOd
x-ms-exchange-antispam-messagedata: gkjvvvWUjxdc0A+50rQKrWUUQiJo5rUHu6gFmzkuJfTAcdW8UUo9+TsKFuTwR8Gx7HltE/Dc9YILYEtAUvjGTmstaGe+S8J4f6yRQPVex+qprdQAOMXTPE3mjzIfNbRYLoU/C9RLRobj51FoB6YzMg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6d26de-6cdc-44f4-f05b-08d7d0543f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 00:34:15.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OS/PTADACCFgM2pbvffn76kSnc5Kmfj+3XdtQl18b2lV+Dv1EhvKWO+Go6ChyBHH2ePCN6Xo79xp+7wgGNpStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable
> without EXPERT
>=20
> On Tue, Mar 10, 2020 at 08:48:46PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> > enables both ZONE_DMA and ZONE_DMA32. The lower 1GB memory will
> be
> > occupied by ZONE_DMA, this will cause CMA allocation fail on some
> > platforms, because CMA area could not across different type of memory
> > zones.
> >
> > Make CONFIG_ZONE_DMA configurable without EXPERT option could let
> > people build non debug kernel image with CONFIG_ZONE_DMA disabled.
>=20
> While I see why you need to toggle this feature, I'd rather try to figure=
 out
> whether there is a better solution that does not break the single kernel =
image
> aim (i.e. the same config works for all supported SoCs).
>=20
> When we decided to go ahead with a static 1GB ZONE_DMA for Raspberry Pi
> 4, we thought that other platforms would be fine, ZONE_DMA32 allocations
> fall back to ZONE_DMA. We missed the large CMA case.
>=20
> I see a few potential options:
>=20
> a) Ensure the CMA is contained within a single zone.=20

This will break legacy dts with new version kernel.

How large is it in
>    your case?=20

It is 1GB

Is it allocated by the kernel dynamically or a fixed start
>    set by the boot loader?

We use alloc-ranges and size in kernel dts.

But there is only 2GB DRAM in the board.

>=20
> b) Change the CMA allocator to allow spanning multiple zones (last time
>    I looked it wasn't trivial since it relied on some per-zone lock).
>=20
> c) Make ZONE_DMA dynamic on arm64 and only enable it if RPi4.

Option c seems a bit easier to me :)

I will try to explore both, but if you have time to help, that would be
appreciated.

Thanks,
Peng.
>=20
> --
> Catalin

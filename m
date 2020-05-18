Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A612070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZpJhSnAp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HgRw0oMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgERJA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:00:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34957 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgERJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589792455; x=1621328455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yT1VkS78usXsgTgfQiq4RDkmgg3AqCarBuZedNqBenE=;
  b=ZpJhSnApf3pL1x/VpoHET8hMPkJSxHvIhM4oqMPuvWx9YsYndd8jGA05
   998pujXscEAiEL++eEbjt8em1N6S7su46HyIks4PVo8AeDRCSkO/bih1Y
   RQpHakPZMQKWqIEG5XytE8bwQsU4fogbdgv1900UqrR9/4/FdCyHlGrqF
   7GJRlrjYIQtdR3VTFA0IxXyRSyCb+jLtFGqCNGas4EKYZBGrLKXs4xYnX
   vlLUzwXMGmpTo5XDK+7Ye4RAtHmKCKybKLVoz7zE9HyjmYRx8rbEBaiSe
   llyJI3Lbi0uo3nVTqqNEPzLsSVCFE9JGV9GSp2JXF7gQ/12S0chcHxYWB
   Q==;
IronPort-SDR: mDYInK/grllTwUtmQTHgYoyV12V3TZv0c2N7g15VZUx2PkG0P5/SMpKIofNzZGwXEoAoqwc+Xz
 KDOKxsE7WUHbx1ASJCTAc1XOpVHbLRx501UaR3gqM3uC+z4rN8JyDTUx0icBUHWeBQKd1N40Qy
 y9/SVIeeXmsirNoHFRLY4eT0QGKT2GPlAW+DhUZ/MlbdVsLRbspdncQM7oqXXSvsM9dAwPSBkL
 LjRkDpqGM9JbL6zbrHR+6hsb577Dr76D95oB/F+7NIDzmG9o0Vm+VLNXVly0BdiGSDv9X4XTCL
 AGk=
X-IronPort-AV: E=Sophos;i="5.73,406,1583164800"; 
   d="scan'208";a="138264827"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 17:00:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbnA6xxcnBi8M3N9BRZE52tclbQ187DG4R4GMXkgIl8EsKPWLHKm4B1dLnxuAczAaMnT5mEyF43lBJt30DcRVet/884GHGb5F1C7BfSpuBneCo/qJoVjmvHCVDape8+4/kQFXtPiRdQdVYlJF24rCchYe/RXNTlpOY4ouA3n5WOGLy6G/KSIa2fttjnG6n2EXqCclDC9D9Xzj97LRFNSfZGgm9t/VQ3iYDs7B43JIqWCywplj/GB5JTkSEF99IeO4JBjLcScpqdqhjCfR48hhUcJmAtqrp6QK4c7JR/tJaAb/LSTdmi68CFGwPcnBPKBkKwEaZRJJ134Y1EFVxw00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT1VkS78usXsgTgfQiq4RDkmgg3AqCarBuZedNqBenE=;
 b=hNGxyMaMsibqphBH/qxPKGQAr7MIsqmswp61ateNM/tdl8WFa63hLAhlgs0ohS46B5J8ek848Gj/P7al9FppQBTOe9qJ48TxQvp2xCFWC6rJtnvsE640HPZ+bxHqJQAUSEjlqMpldtULwAhRqyL9mw3oDbC5ZlkkcoRY9PUB/qgp0PXBKq8F5Rz9z3wgyz9nNuW99LaZXTrI5NInjxAnOu6w3XdeAk4ENzXfxyd2n8IIslLd5jJk/XMP5v4S7tJ3I998HxPVd+QrN/dMvxpzywZPZUnxc5b6FIKk5sQByGwhHZ0bZnM+upBjIg2LwRkVI0EOQwHgzIv2HDa9yRY30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT1VkS78usXsgTgfQiq4RDkmgg3AqCarBuZedNqBenE=;
 b=HgRw0oMiw2MUuanDAHLnUerxSU7o8GDL7VKcXBVstfJHqfAE3DmPp1ps+IAodj/X2EirC77XhFYpqDVAueXFkVJ+I/aQciaKsORJlKpjenlRSfOdibJHhq3LWJr+eOjkZrQNURqOr1goy+Fum3R2KvOkW89Cg4IdnvBE47t5bWQ=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6234.namprd04.prod.outlook.com (2603:10b6:5:124::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 09:00:52 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:00:51 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] irqchip/sifive-plic: Separate irq_chip for muiltiple
 PLIC instances
Thread-Topic: [PATCH 3/4] irqchip/sifive-plic: Separate irq_chip for muiltiple
 PLIC instances
Thread-Index: AQHWK0zIG2SJo4BaZ0+zBbhx696gsKiqpKoAgAAHeACAAAWnAIAANrhQgAKZmgCAAAtfsA==
Date:   Mon, 18 May 2020 09:00:51 +0000
Message-ID: <DM6PR04MB62010CC19FEAEE738F2BC00E8DB80@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-4-anup.patel@wdc.com>
 <577f9a16b3dddfadb7c5487ffaef31d8@kernel.org>
 <DM6PR04MB6201FD64C78C51A94C4776558DBA0@DM6PR04MB6201.namprd04.prod.outlook.com>
 <6fbfca8f084f6cd0dc6818c4bbf58843@kernel.org>
 <MN2PR04MB62078C2854FE33CE81186FA88DBA0@MN2PR04MB6207.namprd04.prod.outlook.com>
 <5bc4010161af7bef8e3c30e08888ec82@kernel.org>
In-Reply-To: <5bc4010161af7bef8e3c30e08888ec82@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.27.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28caa290-5a4d-4e1b-c9cc-08d7fb09f750
x-ms-traffictypediagnostic: DM6PR04MB6234:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB623484CF0F5683AA1DD98DFD8DB80@DM6PR04MB6234.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U09WBjQxuSOT7r+nR2iGR6pJLs2d1Czhbo6maoBZjnrj3gdGqlO+QA32cCSXjp8VeYuBXT1fvKaEAATN6CsupJSJIRFo1LSU/8s1C+84Tm/U1/dch7xMoC9QStwfZ9Z3HuBPO8bIIy43NT1eOcOW3idiKtTqbQMoo6CIfgfLfuUFwE3f7S8pBv+t59kgjKkmFKy1w51UVqL4L+iKvN1oa8byceXY7qPgsZLgGsftHrJaeoGKlSHPL2BOEcO519pH/ith+RIuih69X9iJAnANMZzdarq7drisamZYjz/BLiSoF7DXaMdNC/E0Zsq8Yg8WGJTo1btVJCUttOSPN84cyahKfj60CFFk7exEtmQyx2vM86PhWdjyfs7avIHnwGZGQHm+kmuOkIaIVZqjEN9b9m9YqPqebRGtrA2zoPGDIZ3gNegG87iPMWgOgrek2Rxw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(71200400001)(55016002)(26005)(9686003)(6506007)(53546011)(55236004)(8676002)(76116006)(66946007)(33656002)(66476007)(66556008)(66446008)(478600001)(2906002)(64756008)(186003)(4326008)(52536014)(86362001)(5660300002)(316002)(8936002)(6916009)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oN43dqi3tCvkqz04+SdqBSMzRRzgb6YpOTBMXCPpPKWPZrAFtw8H6oSxn7yLLDd+n4xpxSrEFFzp+JSU1i2MyYMotMoyP69YZfNETmcCYhcSGZopJGimVOBWKSDH4ujotjXroHh/4Fez2jBRhR302iMLCWPxt+mMYFDeiVyBBIJm3CV6Fz+H+W8GkPiTEi/WFsu71PSi/uvJvq01yjXGV31e4TUGsRQaMN9LvtLTJy8HFYltOOdtAEeL8kU9e/7QOCRfnibXPOhfILbxr0hZsRcPelYsIwwzaQOnyKlf4b+OQb0836H80JnifqB7X4k8BswiIQZVG1ge9+snGdsoxpvu3Y1A+siBQWYeFWO05gV7ghACzu1+6kVJh5ZUnpvdFWgKH7oZ4E/xTbQIX1B8JemCO6H1dSZBzGj3P43uDvZezj8bX82UoFmQn/1s76a+Sfr1cDCdNa7jijHt9K1D0ObfOWyltTGpPiaCk1R3kmA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28caa290-5a4d-4e1b-c9cc-08d7fb09f750
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 09:00:51.7319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5xbbuGbHWvdwc70iMC/PfCi+E2jCX8Xa/VTbrU9win3WwuEKjZtHVesWe8MdzkASqXqZlzqeXoldbUdfxtXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: 18 May 2020 13:45
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Paul Walmsley
> <paul.walmsley@sifive.com>; Thomas Gleixner <tglx@linutronix.de>; Jason
> Cooper <jason@lakedaemon.net>; Atish Patra <Atish.Patra@wdc.com>; Alistai=
r
> Francis <Alistair.Francis@wdc.com>; Anup Patel <anup@brainfault.org>; lin=
ux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/4] irqchip/sifive-plic: Separate irq_chip for muilt=
iple PLIC
> instances
>=20
> On 2020-05-16 17:38, Anup Patel wrote:
> >> -----Original Message-----
> >> From: Marc Zyngier <maz@kernel.org>
>=20
> [...]
>=20
> >> I *have* given you a way to implement that in a better way. But
> >> again, I'd rather you *don't* do it for the reason I have outlined
> >> above.
> >
> > I explored kernel/irq/proc.c and we can achieve what this patch does
> > by implementing irq_print_chip() callback of "struct irq_chip" so we
> > certainly don't need separate "struct irq_chip" for each PLIC instance.
> >
> > I will implement irq_print_chip() callback in v2 series.
>=20
> You still haven't explained *why* you need to have this change.
> As it stands, I'm not prepared to take it.
>=20

This is only for differentiating interrupts of multiple PLIC instance
In /proc/interrupts.

I will drop this patch since (like you mentioned) contents of
/proc/interrupts is considered an ABI and this patch breaks it.

For now, we can infer the PLIC instance for interrupt X based
on contents of /proc/irq/X/node (i.e. interrupt NUMA node id).

Thanks,
Anup

Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A6C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B976B2253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ImFwkCgj";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="IYcHburU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCIV5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:57:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39766 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbgCIV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:57:38 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029LgeG9011145;
        Mon, 9 Mar 2020 14:57:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=XXq0MC9f7fghQeINkNiUwrL98TyUFSKjT5Eae2kzfVs=;
 b=ImFwkCgjXlvY1xxqmp24ntVkFjJaSxwFN50fyD3MafyAhKMg2kBu+noMFIxhOCuExcYP
 hpnJzvsu7oghBg+ll39GnUquWQjDj6dVypEYVS5TqOrDSFBMJrzDg0WDZKUgFB0B9zDz
 XpYcy8cu5KxtQOIiy0mhXokA41vGudGHsZBwVa2GTwT4Rg/yEiJUv8yOUTWjgJGrnzNe
 M9nyVsB9lPwJZn3PnpJNUi+hSJqEUPbnFBJ3LcXtuQsv5XXkGZd3XxX8cECK9is2DP1t
 PO9OLiupqb+qdVOPWFKpi81oKxkL25Yd57KU6XfWTWbkBIxlU9XuJcGDhVZWgDUi8sS4 Kw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ymc0ss2ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 14:57:32 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Mar
 2020 14:57:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 9 Mar 2020 14:57:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI0xCDgx0RmyqH2vOcvdCsbUoVKbNg3qzStftxXmjpYVJpLB3Hna4JUpA4ZSkjXPfiWkgAywKM4fm6lMDrwZfdYvJ85pkenLA6opLOfL9AWYkvWSxtJxX/AfQjEFgikjq4s4YXq9jdHIK0134jmEy4ckvf3H3xYJrYCMQxV4SU8/H09YTi6FBQwE9AvKmit0pLKQ9ZOxpzYWLCRQ8FvPJrQeAqM7aF+/lKiR/TKbaZeRFYj0tsEgEqrFwxAJbjrCqBUYPaHPmfOT2r1m8SOOJboS3+emtcL78dZqC+9/mssP8gAoDXjygkRqiS5MT6G2vRlkKcRAU4PzP+QFxx+GIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXq0MC9f7fghQeINkNiUwrL98TyUFSKjT5Eae2kzfVs=;
 b=FLrJvf/d4bAJ5RmaaZZ2ZYpynFtdM+jyMNw5bwWwrrGPKPlQzXVz2pN0GNHaYtUB8eCkLDVg2s8w7OxuMQ8uEkB7pC09YU9XdhJ6xxyxqBVf2W/muVVAD1yVSbdrAwnJedLRjCB2z/67svNio5ZLPsiqTCDVwuMQUE+45mHoovXJv443VTlbbv3nxWvlU0cwdTeMPMUqKNMrWitsdDs0UdRWBQ2E+jX+gxJLDXWDGxNa8hKRLcQTvYP6RI3UvvV+bnYY6mOdw6h1gvECE1184bbRs2wkbzxFqyuliAlCJXRtUPaiFKATSOBCMhRgBqMV7ughyypibS+mZoEhyxrXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXq0MC9f7fghQeINkNiUwrL98TyUFSKjT5Eae2kzfVs=;
 b=IYcHburU6X+D2hRwnxv/FMQtTax38Bz3lFwqllGBtFPhUfcfMMHF0Tzyt8D1JNGer6Ha0baGCYkuvDu8bcGEBGSE6XBUFODpPGWE+hEZRbsoikIWu92CONk4DNyMjHyP5oMRG1jxH0TrT6/x+TuU9XTUa0Tk8sl4iA8m7ZgVMAk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2686.namprd18.prod.outlook.com (2603:10b6:208:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 21:57:28 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 21:57:28 +0000
Date:   Mon, 9 Mar 2020 22:57:21 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Mark Salter <msalter@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3: avoid reading typer2 if GICv3
Message-ID: <20200309215720.yiubhtgymnece6dm@rric.localdomain>
References: <20200307233442.958122-1-msalter@redhat.com>
 <20200308102756.4bae3c27@why>
 <20200309151425.nex3scw46sgrxu5v@rric.localdomain>
 <47e631b06719415f4b3cf8ffb6b158fc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e631b06719415f4b3cf8ffb6b158fc@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0220.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0220.eurprd05.prod.outlook.com (2603:10a6:3:fa::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 21:57:27 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ae8856-9bc7-4597-b630-08d7c474dbcd
X-MS-TrafficTypeDiagnostic: MN2PR18MB2686:
X-Microsoft-Antispam-PRVS: <MN2PR18MB2686416BF0CAB89104C59362D9FE0@MN2PR18MB2686.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39850400004)(346002)(396003)(366004)(376002)(189003)(199004)(81156014)(966005)(66476007)(956004)(81166006)(45080400002)(478600001)(66556008)(86362001)(4326008)(6666004)(1076003)(66946007)(8936002)(316002)(186003)(52116002)(55016002)(9686003)(7696005)(16526019)(53546011)(6506007)(2906002)(5660300002)(26005)(6916009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2686;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wemyjYa5UL51iElBC7OsJMPxLx+Cl7PQtuaI+RPp8wypEFZsSWgQ9nR49GWhGXmZvC1WYYwHUVdePL3AJU1yrp0xTVUm8FFx7nYJ6dBn4SJep3rj3BoWDAac8gsuYiPfH5r9n3ErRL8KfWDrovzFe3/T6OBbZ7idrkPdc22EzX1onpENDZfulMdMcbglqzHCtEnqAbTGcbbSJ8SjBdcNY3PDX5tc3i97OQaqz4/v1H+Unvy2DHS1iQ5bmGlcXHx4Gsc/vFhLJLiGJhzSrKvjyqXakXuTIvgf48l5Lguu6kDDMr0tXqG6oChk9QZBrQfl4ZRQQs0q6Y60jz8tWfDff6qCefOXjUsNKhA/9Pmo1I75swxe2VDx91hgBjBSQaZ6Emvl6q0zsXovTHe2JQG5Sezy7fgwNF2y3uD6zweJFR7J5V7SvXAEPEXHoyYIq9ZGPnHHJLW1aEhj5EAUa0Dl89VbADhwyMJ3WG7BHm3GgyHkMOZ36eFSiVWBvWGoDV5JjrDQklp7HqBO7yFZTLYA9w==
X-MS-Exchange-AntiSpam-MessageData: u57bB9x73wFvilptXuMZFx7vzIijMnwpDIhdzY19JF3wwQ/KSaD+vONz21gwQAp2+DANNzTOrBHnqvis5tHfBoCdw1aNmOGxn5yShy851PgkjH8meVvKKxqJv5KUfQHwm8DuYzzERuslhnxIQtgFJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ae8856-9bc7-4597-b630-08d7c474dbcd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 21:57:28.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3d/KNyd/9P8Vix3IDELM4knsYeeMucGhXXECk0IqaxJBqe7XWru0YnKT+fXvYi81mm+SbujQ4e4s3aIUfxt5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2686
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_11:2020-03-09,2020-03-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.20 17:15:00, Marc Zyngier wrote:
> Hi Robert,
> 
> On 2020-03-09 15:14, Robert Richter wrote:
> > Marc,
> > 
> > On 08.03.20 10:27:56, Marc Zyngier wrote:
> > > Hi Mark,
> > > 
> > > +Robert for Marvell/Cavium
> > > 
> > > On Sat,  7 Mar 2020 18:34:42 -0500
> > > Mark Salter <msalter@redhat.com> wrote:
> > > 
> > > > Trying to boot v5.6-rc1 on a ThunderX platform leads to
> > > > a SEA splat when trying to read the GICv4 TYPER2 register:
> > > 
> > > There is no such thing as a GICv4 register. All registers exist on all
> > > versions of the architecture. They all have a well defined behaviour
> > > when not implemented, which is RAZ/WI. New versions of the GICv3
> > > architecture (which continues to evolve in parallel to GICv4) may use
> > > this register as well, and this patch would then become a problem on
> > > its own.
> > > 
> > > Now, to the issue itself:
> > > 
> > > >
> > > > [    0.000000] GICv3: 0 Extended SPIs implemented
> > > > [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
> > > > [    0.000000] Modules linked in:
> > > > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc4+ #11
> > > > [    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
> > > > [    0.000000] pstate: 60400085 (nZCv daIf +PAN -UAO)
> > > > [    0.000000] pc : __raw_readl+0x0/0x8
> > > > [    0.000000] lr : gic_init_bases+0x110/0x4b0
> > > > [    0.000000] sp : ffff800011973dd0
> > > > [    0.000000] x29: ffff800011973dd0 x28: 0000000002150018
> > > > [    0.000000] x27: 0000000000000018 x26: 0000000000000000
> > > > [    0.000000] x25: 0000000000000002 x24: ffff010fe7ef6700
> > > > [    0.000000] x23: 0000000000000000 x22: ffff800010dc3b90
> > > > [    0.000000] x21: ffff010fef138020 x20: 00000000009b0404
> > > > [    0.000000] x19: ffff80001198c508 x18: 0000000000000005
> > > > [    0.000000] x17: 000000006fc20c07 x16: 0000000000000001
> > > > [    0.000000] x15: 0000000000000010 x14: ffffffffffffffff
> > > > [    0.000000] x13: ffff800091973b4f x12: ffff800011973b5c
> > > > [    0.000000] x11: ffff800011989000 x10: 0000000000000080
> > > > [    0.000000] x9 : ffff8000101991e4 x8 : 0000000000040000
> > > > [    0.000000] x7 : 000000000000413d x6 : 0000000000000000
> > > > [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> > > > [    0.000000] x3 : 0000000000000080 x2 : ffff8000119c1f10
> > > > [    0.000000] x1 : ffff800011991a40 x0 : ffff800013c9000c
> > > > [    0.000000] Call trace:
> > > > [    0.000000]  __raw_readl+0x0/0x8
> > > > [    0.000000]  gic_of_init+0x170/0x1f8
> > > > [    0.000000]  of_irq_init+0x1e4/0x3c4
> > > > [    0.000000]  irqchip_init+0x1c/0x40
> > > > [    0.000000]  init_IRQ+0x164/0x194
> > > > [    0.000000]  start_kernel+0x334/0x4cc
> > > >
> > > > So avoid reading TYPER2 on GICv3.
> > 
> > we can confirm that access to a GIC3.0 unspecified register will cause
> > a fault.
> 
> Not unspecified. It is specified as "Reserved", for which the behaviour
> is perfectly defined. Does it also mean that other register in the
> GICD space will suffer from the same problem? How about the redistributors,
> the ITS?

It is only clear for GICD, for other cases the actual behavior was
hard to find out, see below.

> 
> > I have double-checked with the specification (GICv3 spec, ARM
> > IHI 0069C). Rev. C of the spec includes already GICv4 parts and the
> > register size is there set to 64 bit with the upper bits set to RES0
> > for the GICv3 case. This would mean a violation of the spec. I don't
> > have an earlier GICv3 spec at hand, but Appendix C, Revisions
> > indicates the register is 64 bits from the beginning, though, I am not
> > sure here.
> 
> I don't follow. My copy of IHI0096C shows:
> 
> - GICD_IIDR: Offset 8
> - Reserved: Offset  0xc
> - GICD_STATUSR: Offset 0x10
> 
> I can't see how you'd squeeze a 64bit register between IIDR and STATUSR.

I screwed this up with GITS_TYPER, sorry.

I now found 8.8 The GIC Distributor register map of IHI0096C which
says "Reserved register addresses are RAZ/WI."

> 
> > It could be anyway that the upper part (offset 0xc) was marked as
> > Reserved in the beginning (a draft or earlier version) the same way as
> > other ranges in the ITS register map (8.18 The ITS register map). An
> > access to 'Reserved' ranges is defined in the Glossary as
> > UNPREDICTABLE.
> 
> It's not an ITS register. This is a distributor register, and these are
> always 32bit. Even the 64bit registers must support 32bit accesses
> because of AArch32 (such as GICD_IROUTERn).
> 
> > So the spec might have been imprecise here in the beginning. That
> > said, it might be better to check for ArchRev of GICD_PIDR2 for >= 4
> > before accessing typer2, instead of checking for certain part IDs.
> 
> No, the spec has always been pretty precise. It says [IHI0069A, 8.8]:
> 
> "Unless otherwise stated in the register description, all GIC registers
> are 32-bits wide."

I don't have the version A of the spec, but does it also describe the
access behavior? I agree that version C is clear for GICD registers.
But still version C is from July 2016 and even June 2015 for the A
release is far after tapeout of that chip that was shown running at
SC2014. Please keep that in mind.

Other parts are not that clear. Mostly the spec marks such addresses
as 'Reserved' only without further note, meaning there is only the
Glossary describing access of "Reserved" registers as "UNPREDICTABLE
behavior."  (I also agree a fault is not the best we can do here, but
at least it is unpredictable :-).

> 
> And the reason for that is that it has to work with 32bit CPUs. So as far
> as I can see, TX1 is violating the letter of the architecture. As for
> checking
> ArchRev, that's a firm No. All registers exist on all revision of the
> architecture, which is why there's a unified GICv3/v4 architecture document.
> 
> > > I have reported this exact problem back in October:
> > > 
> > > https://lore.kernel.org/lkml/20191027144234.8395-1-maz@kernel.org/
> > > 
> > > and proposed a patch for it:
> > > 
> > > https://lore.kernel.org/lkml/20191027144234.8395-11-maz@kernel.org/
> > 
> > There are more parts affected than with ProductID 0xa1, I will reply
> > to the patch.
> > 
> > > I've been repeatedly asking for Marvell/Cavium to come up with a
> > > description of the issue so that we know the extent of the problem. So
> > > far, all I've heard is the sound of crickets, which confirm my
> > > impression that this HW is dead to its manufacturer and that they
> > > don't
> > > want to support it. I'm not asking much though: just tell me what is
> > > wrong (again!) with this CPU, which are the affected revisions, what
> > > is
> > > the errata number and I'll deal with it.
> > 
> > There is no errata number yet, sorry. There will be one once a spec
> > violation is confirmed.
> 
> /me grabs pop-corn and waits...
> 
> > > I can't get that information. Can you?
> > > 
> > > I'm now proposing that we fully remove support for TX1 from the
> > > mainline kernel, because every single bit of this CPU is completely
> > > busted. Just look at the number of workarounds we have to carry
> > > around.
> > > Without involvement from Marvell, this CPU is a liability for the rest
> > > of the arm64 kernel (just look at what we have to do to enable KPTI
> > > *because of TX1*, the amount of crap I added to KVM to fully emulate
> > > the broken CPU interface, and plenty of other things).
> > 
> > This is a bit unfair, during 2015/16 timeframe this was the only
> > non-ARM cpu available at all. So everything was in the beginning there
> > and things may happen. But many errata have been fixed in newer
> > revisions (which stops of course when newer CPUs become available).
> 
> Even XGene-1 was available before TX1, and wasn't so grossly buggy.
> And even then. Having a buggy CPU is not the end of the world if
> the SV works with us. Over the past 5 years, we have had to work
> *despite* Cavium. Yes, I'm a bit bitter about it.
> 
> > > I intend to propose such removal once 5.7-rc1 lands.
> > 
> > I hope we can work on a better solution here.
> 
> How about getting Marvell to actually work with upstream? Over 5 months
> between a bug being reported and the first acknowledgement that "yes,
> we may have a problem here" is not exactly something that fills me
> with the utmost confidence.

I read your message here.

Thanks,

-Robert

> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...

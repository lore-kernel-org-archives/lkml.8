Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72210C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3790622522
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hEgonWza";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="sJwORciv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCIPOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:14:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1344 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgCIPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:14:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029F1MOL026604;
        Mon, 9 Mar 2020 08:14:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=Cy9Q/FtikUSksye4W9ufHoVPWU2qaCrSj5PMfZeNTGo=;
 b=hEgonWzaL4pTRG2gSmYK8BTtZJFPMZnu9xcdAs2RiUcEMXN65ZEvrrsjvqyJ/BA3DHJt
 935Ph7SDlnB8SDEVxjylDZqixruYj1tnm/itp4oDb/2xC1YrV9WoTDV+KLZSsxAkeHr3
 HxpbQVVFw2kK3vKrWKJadtdCdqaGUjjBrI41Z1Ctx1lynnzL0B/rZR8ClC0OmhY+WIwx
 njtdJalkwfI5zoLSBcTRTXa8OBbefGRGK67r0RLCNmpOgfMfimGXNSL8VWT/N1pAu5e1
 3kTAEkncVpGIA1Ui3PDEp7dxTFXrSkMb4LYwDynhA8hwef3Y3BXimXE+5yjYLgq6WQlE fg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ymc0sq8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 08:14:37 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Mar
 2020 08:14:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 9 Mar 2020 08:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLy+Fmr0s9u4oMHvtB6z44jcxm5MfZRluj5cPXu9EUJ8BSVa0qpsGU097haHZzlKlLNv1dm+WnjYxW37vxCjfBlKI1ZlLUVVEm1V2vDTAuYuWXoXWYGefyO+elcMfOha/E9dAce08EdRCWmFdzRsZBMEKn2v083BVaDVuUgo+xxe3kg8mT1IP3k4PKl2vRt5q6PzTm7ZJowaKkvfF/ALBoGl9Lg939R388zT2xfEjJBLpdVmt2tdYUc4L0DL1SOG+nHwKmCEfUqY4TaS+PGYqFdcDePFaXPlGNmNUxuSyPywX7zZWW/GiBCpoTZQjRt+6mz1MaiXQppwmaOPTUh6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy9Q/FtikUSksye4W9ufHoVPWU2qaCrSj5PMfZeNTGo=;
 b=ZYnd68gHYjBpXeRtTJoy/7gu/6bwhjcxAY8CqdA4J7TTeg0B7E/WiqQ5+0HFkY30Y93XIzBp62k3n07R8++aRbLBIZ8uNNlhHmgf5rvFX8ZSJU+ZtkTvpKBW7Ne6LpjpGYRrGEbxsYO7omr+gTk3ZhN2cd69FMrVd6XtVQeteONVEYpLY5DyMv3qW3NlDF/BGmQvraLRD1o7ZnZID6iISeI/XqRScsqElz34pFcfV5j+6jhn3fdNzZHaiuEDvLDHLDoOPZGbWAz0DDOapVoPtuBEp7vC5dDBPGLW+OTHSEha0TOznubk5U99lkXSv36mAyhbGzIvQRDKOfO7Vklnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy9Q/FtikUSksye4W9ufHoVPWU2qaCrSj5PMfZeNTGo=;
 b=sJwORcivosInJYaAWGUiUPMvEy1YkjtYZF4p69V57YphwsUGBs/LVazTUyW72AWCnAOSi1w7nShWJDFcOCVtAOfLp6yk9yh4Cz0exn5AekSj4BQlGky0yilV1s5YVH24bfKuwQsVIoFmyPmTZUkYYaeAebr2yDdG/Pb0ml9kBUc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2736.namprd18.prod.outlook.com (2603:10b6:208:a4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 15:14:33 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 15:14:33 +0000
Date:   Mon, 9 Mar 2020 16:14:25 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Mark Salter <msalter@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3: avoid reading typer2 if GICv3
Message-ID: <20200309151425.nex3scw46sgrxu5v@rric.localdomain>
References: <20200307233442.958122-1-msalter@redhat.com>
 <20200308102756.4bae3c27@why>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308102756.4bae3c27@why>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0177.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::25) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0177.eurprd05.prod.outlook.com (2603:10a6:3:f8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 15:14:32 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8de258-fb42-4a81-6ab4-08d7c43c92a6
X-MS-TrafficTypeDiagnostic: MN2PR18MB2736:
X-Microsoft-Antispam-PRVS: <MN2PR18MB27368DAB3BA1B092AFF475D9D9FE0@MN2PR18MB2736.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(6916009)(81166006)(45080400002)(9686003)(81156014)(16526019)(186003)(8936002)(8676002)(1076003)(478600001)(86362001)(66946007)(4326008)(6666004)(26005)(66556008)(53546011)(6506007)(966005)(316002)(55016002)(52116002)(2906002)(7696005)(5660300002)(66476007)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2736;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnTuc20COU9c9kzk41HaDCGWa0X70Mll4Yf2OsvRI/aE+vSRHJLszX9xVLYJ6I+g3vDavWIt7UdNrLLUOfR7szlGh0qxwTx/DzTLR9NxCtKnZui6HWlMgoJrCJAwILG0kKuAtgWFIZgrhyIWXlD/MS+fiPuhcMl1SHosr3PYrg9QnrxEZKq6RoXgmyLEQ2otlmkW40ds2ngQPCyFa7p4BxXejV04FJJ4iNcrDjJcyTjvsxnUw77IlIFi2wAcc1+zJEVxvL48Nuc72BRyIjN1fWWJeYQjGzzpoJEbu9KDAI+2/HfdMZlVqQYp+0orGLbexhBRk0cVMIOOuMBk8S01QtJxJWvSqAsWo8lTu1ObYk/ATSivvxtGio9BU56oJfIEZ5eDQR1s5wOY+VRQDI5g8wLthpBKFeCOLNulPMtQtQwy+l5ByUgAeLiZXXY6af1fijdP5vheTzcI3vOg6KU/ppX4TWEe7zFXpspQUPzMgpTrhtUCWG0bPuY5MGTJE4yEVp7E/vPM+8bk6gbS8jGIDQ==
X-MS-Exchange-AntiSpam-MessageData: /GIx20h+fJ8tmut4FMPEu3Ryp8ZQhJjhcRzoFqHXcM6KYSH3rI6RazaxuXAPK7jWidf5D/3SCTSgifdq39p2YXjRPNWGjLeesubl+6I0EhuHwy1qsGfVcTypC4lGgsrhdKl2t28mz9x2ZdcTgWiDEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8de258-fb42-4a81-6ab4-08d7c43c92a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 15:14:33.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2GtP45JreUzv7UunSXRH7fYkufUQEAkF8mx6umudoxnEJuXarbVvIw7imk1bAqmcx2sUsHTjQS7Fc6bTbEaCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2736
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_06:2020-03-09,2020-03-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On 08.03.20 10:27:56, Marc Zyngier wrote:
> Hi Mark,
> 
> +Robert for Marvell/Cavium
> 
> On Sat,  7 Mar 2020 18:34:42 -0500
> Mark Salter <msalter@redhat.com> wrote:
> 
> > Trying to boot v5.6-rc1 on a ThunderX platform leads to
> > a SEA splat when trying to read the GICv4 TYPER2 register:
> 
> There is no such thing as a GICv4 register. All registers exist on all
> versions of the architecture. They all have a well defined behaviour
> when not implemented, which is RAZ/WI. New versions of the GICv3
> architecture (which continues to evolve in parallel to GICv4) may use
> this register as well, and this patch would then become a problem on
> its own.
> 
> Now, to the issue itself:
> 
> > 
> > [    0.000000] GICv3: 0 Extended SPIs implemented
> > [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc4+ #11
> > [    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
> > [    0.000000] pstate: 60400085 (nZCv daIf +PAN -UAO)
> > [    0.000000] pc : __raw_readl+0x0/0x8
> > [    0.000000] lr : gic_init_bases+0x110/0x4b0
> > [    0.000000] sp : ffff800011973dd0
> > [    0.000000] x29: ffff800011973dd0 x28: 0000000002150018
> > [    0.000000] x27: 0000000000000018 x26: 0000000000000000
> > [    0.000000] x25: 0000000000000002 x24: ffff010fe7ef6700
> > [    0.000000] x23: 0000000000000000 x22: ffff800010dc3b90
> > [    0.000000] x21: ffff010fef138020 x20: 00000000009b0404
> > [    0.000000] x19: ffff80001198c508 x18: 0000000000000005
> > [    0.000000] x17: 000000006fc20c07 x16: 0000000000000001
> > [    0.000000] x15: 0000000000000010 x14: ffffffffffffffff
> > [    0.000000] x13: ffff800091973b4f x12: ffff800011973b5c
> > [    0.000000] x11: ffff800011989000 x10: 0000000000000080
> > [    0.000000] x9 : ffff8000101991e4 x8 : 0000000000040000
> > [    0.000000] x7 : 000000000000413d x6 : 0000000000000000
> > [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> > [    0.000000] x3 : 0000000000000080 x2 : ffff8000119c1f10
> > [    0.000000] x1 : ffff800011991a40 x0 : ffff800013c9000c
> > [    0.000000] Call trace:
> > [    0.000000]  __raw_readl+0x0/0x8
> > [    0.000000]  gic_of_init+0x170/0x1f8
> > [    0.000000]  of_irq_init+0x1e4/0x3c4
> > [    0.000000]  irqchip_init+0x1c/0x40
> > [    0.000000]  init_IRQ+0x164/0x194
> > [    0.000000]  start_kernel+0x334/0x4cc
> > 
> > So avoid reading TYPER2 on GICv3.

we can confirm that access to a GIC3.0 unspecified register will cause
a fault. I have double-checked with the specification (GICv3 spec, ARM
IHI 0069C). Rev. C of the spec includes already GICv4 parts and the
register size is there set to 64 bit with the upper bits set to RES0
for the GICv3 case. This would mean a violation of the spec. I don't
have an earlier GICv3 spec at hand, but Appendix C, Revisions
indicates the register is 64 bits from the beginning, though, I am not
sure here.

It could be anyway that the upper part (offset 0xc) was marked as
Reserved in the beginning (a draft or earlier version) the same way as
other ranges in the ITS register map (8.18 The ITS register map). An
access to 'Reserved' ranges is defined in the Glossary as
UNPREDICTABLE.

So the spec might have been imprecise here in the beginning. That
said, it might be better to check for ArchRev of GICD_PIDR2 for >= 4
before accessing typer2, instead of checking for certain part IDs.

> 
> I have reported this exact problem back in October:
> 
> https://lore.kernel.org/lkml/20191027144234.8395-1-maz@kernel.org/ 
> 
> and proposed a patch for it:
> 
> https://lore.kernel.org/lkml/20191027144234.8395-11-maz@kernel.org/ 

There are more parts affected than with ProductID 0xa1, I will reply
to the patch.

> I've been repeatedly asking for Marvell/Cavium to come up with a
> description of the issue so that we know the extent of the problem. So
> far, all I've heard is the sound of crickets, which confirm my
> impression that this HW is dead to its manufacturer and that they don't
> want to support it. I'm not asking much though: just tell me what is
> wrong (again!) with this CPU, which are the affected revisions, what is
> the errata number and I'll deal with it.

There is no errata number yet, sorry. There will be one once a spec
violation is confirmed.

> 
> I can't get that information. Can you?
> 
> I'm now proposing that we fully remove support for TX1 from the
> mainline kernel, because every single bit of this CPU is completely
> busted. Just look at the number of workarounds we have to carry around.
> Without involvement from Marvell, this CPU is a liability for the rest
> of the arm64 kernel (just look at what we have to do to enable KPTI
> *because of TX1*, the amount of crap I added to KVM to fully emulate
> the broken CPU interface, and plenty of other things).

This is a bit unfair, during 2015/16 timeframe this was the only
non-ARM cpu available at all. So everything was in the beginning there
and things may happen. But many errata have been fixed in newer
revisions (which stops of course when newer CPUs become available).

> 
> I intend to propose such removal once 5.7-rc1 lands.

I hope we can work on a better solution here.

Thanks,

-Robert

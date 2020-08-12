Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A797C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D401C20771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lH9Z+X1G";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lH9Z+X1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:42:30 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:26727
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbgHLQm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUib+BLn3K+UEUmsWjCJuKSGcT19t7UxACArQT65AXI=;
 b=lH9Z+X1GnTH4hOm16md1X7svkhUReg8uMtXFqm6lVVRY5DoyZs5jk5E7We4R5CIv+LifX30Ng4pTdfdhAPDhc+ed59nPgS1YuvW60SsOrHSxZy35mQ9u31LFoTdc3RfKQc+UggybJOjqdxea0IXtxqFMjlCTBffa93XnTd/KN3Q=
Received: from AM5PR0502CA0006.eurprd05.prod.outlook.com
 (2603:10a6:203:91::16) by VE1PR08MB4958.eurprd08.prod.outlook.com
 (2603:10a6:803:108::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 12 Aug
 2020 16:42:22 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::24) by AM5PR0502CA0006.outlook.office365.com
 (2603:10a6:203:91::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Wed, 12 Aug 2020 16:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 16:42:22 +0000
Received: ("Tessian outbound 7fc8f57bdedc:v64"); Wed, 12 Aug 2020 16:42:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5b875e2148a86c44
X-CR-MTA-TID: 64aa7808
Received: from f70412a847e3.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9746B3BB-B18A-4A73-BDAF-6799CCE58BBD.1;
        Wed, 12 Aug 2020 16:42:16 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f70412a847e3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Aug 2020 16:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM/G1bTSBrzApFVuAchhRrfv6FoEcXZXHXqFfJPeh8tYQJbeDrV+cMQEuvwrPkDCIiqz+ta4RfZQCw7xwVYXEvDy56TbkAqaGNdN236my+0etLx64SIrjCweiJRw1rlzXycFPhtdHLrYlk5qkpw2mrkZn2v4KcNNjxINvh8rncoUerQDvWj/JULhVcmPLdLZTpRuPmIb1A8tLIHUTNdUy1o/n8qWlgvK7IBFhQ5Mry4/9C4udC18ftAiB7+JCqDH2dBLnbLpkZEaqavfAST4qzbG8IQbcSlhYxObGRI8pc7fsGnGHPo5DVxlZr+89kSdlaDPthBD7ywMjYc0jm3acQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUib+BLn3K+UEUmsWjCJuKSGcT19t7UxACArQT65AXI=;
 b=iJ4CJQL9tce0XabU+i7m+c8JO2eHXmWLq8cPsoQ43z1e6k4Oqx6dY0zuDlnJagE3mPN4O5HGJCA0c9Y7Kn7mHC20UWRiqRT1+r8i0c/FipumX7ZNyk+3bqiXcbHRahyk34L5rtm1bgleqzDSq3gQiAUgFx7KZwCqAhjt4z5SEIm8jkZXn3IehAkIc/o78MvtOZ2jdq/ODzKx9vRt6+TWMk57CgZXhVX0Dk6ySE8RBvj604USH60o8LLF/II4IqavGMzHmlBlhhuIlfrlCbhJdwgXuRqHWC20/NjijvzzAF7+DL14u1j55IUk9ddkwVSVNPu/kzZ8hzzM75yc8u6mtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUib+BLn3K+UEUmsWjCJuKSGcT19t7UxACArQT65AXI=;
 b=lH9Z+X1GnTH4hOm16md1X7svkhUReg8uMtXFqm6lVVRY5DoyZs5jk5E7We4R5CIv+LifX30Ng4pTdfdhAPDhc+ed59nPgS1YuvW60SsOrHSxZy35mQ9u31LFoTdc3RfKQc+UggybJOjqdxea0IXtxqFMjlCTBffa93XnTd/KN3Q=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM5PR0801MB1682.eurprd08.prod.outlook.com (2603:10a6:203:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 12 Aug
 2020 16:42:15 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 16:42:15 +0000
Date:   Wed, 12 Aug 2020 17:42:05 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200812164205.GS14398@arm.com>
References: <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM5PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:4:ad::49) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 16:42:11 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cbfa9b3-8457-4402-83dc-08d83edeaf87
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1682:|VE1PR08MB4958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4958A9E0F0CCEF1849E601F2ED420@VE1PR08MB4958.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(6916009)(6666004)(52116002)(7696005)(4326008)(966005)(33656002)(7416002)(5660300002)(2616005)(66556008)(316002)(54906003)(8886007)(86362001)(16526019)(2906002)(1076003)(44832011)(186003)(478600001)(8936002)(26005)(66946007)(8676002)(36756003)(956004)(66476007)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1682
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2bff4025-2f64-4c18-15de-08d83edeab24
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnWBniYU8Kbh1nyvpgor+qOUmu/2+vODWdiKd6MO3NBPh9fzDWiwLQcXCDGIT7/3dQjLXhRUu7I+CYVKCJzonodOLsxwDWgfTpGUbyQ+hEIrOfHXhLLkp+sqEIxGx5EFIFH//FlPYwrBDf1swQPA7QX3G3QYmrxzSg7EvYwkLKGvGgxgt5FpP267s+gFaTNUhFVGtn8Bj64dRMdCWB/GpyQsafMNYCj2YzP2+WTjvnrw/42p5N/OwnDWTsuq9ZaWyvmj/TNBBD9Vu1vUYQbUeibjsapXVrfEnvfRO7EIndkUxIXNz7Xe1QdUY96coHTKoJ6FaY3HUQs24pX0zKKZsnm9hK9PFCWXQjOz4qov6dR2TY6I6LIlt6wddT7o0m4DRy6pOlaEeomLsf/T+NuYrQ6hWJmegiu4l3x+Yg7GRvuiWFAN6gZUTVOilXYWQrUMU9EgxBtiMNbb3o3WBta95SLc1kaFPVvcXvcZi2/NhjA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(8886007)(36756003)(54906003)(316002)(36906005)(6666004)(7696005)(336012)(956004)(2616005)(16526019)(186003)(2906002)(26005)(33656002)(966005)(478600001)(55016002)(6862004)(8936002)(86362001)(47076004)(82740400003)(5660300002)(70206006)(356005)(1076003)(70586007)(82310400002)(4326008)(8676002)(44832011)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 16:42:22.0931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbfa9b3-8457-4402-83dc-08d83edeaf87
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/12/2020 18:37, Ard Biesheuvel wrote:
> module_frob_arch_sections
> 
> On Wed, 12 Aug 2020 at 18:00, Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Szabolcs Nagy [12/08/20 15:15 +0100]:
> > >The 08/12/2020 13:56, Will Deacon wrote:
> > >> On Wed, Aug 12, 2020 at 12:40:05PM +0200, peterz@infradead.org wrote:
> > >> > On Wed, Aug 12, 2020 at 10:56:56AM +0200, Ard Biesheuvel wrote:
> > >> > > The module .lds has BYTE(0) in the section contents to prevent the
> > >> > > linker from pruning them entirely. The (NOLOAD) is there to ensure
> > >> > > that this byte does not end up in the .ko, which is more a matter of
> > >> > > principle than anything else, so we can happily drop that if it helps.
> > >> > >
> > >> > > However, this should only affect the PROGBITS vs NOBITS designation,
> > >> > > and so I am not sure whether it makes a difference.
> > >> > >
> > >> > > Depending on where the w^x check occurs, we might simply override the
> > >> > > permissions of these sections, and strip the writable permission if it
> > >> > > is set in the PLT handling init code, which manipulates the metadata
> > >> > > of all these 3 sections before the module space is vmalloc'ed.
> > >> >
> > >> > What's curious is that this seems the result of some recent binutils
> > >> > change. Every build with binutils-2.34 (or older) does not seem to
> > >> > generate these as WAX, but has the much more sensible WA.
> > >> >
> > >> > I suppose we can change the kernel check and 'allow' W^X for 0 sized
> > >> > sections, but I think we should still figure out why binutils-2.35 is
> > >> > now generating WAX sections all of a sudden, it might come bite us
> > >> > elsewhere.
> > >>
> > >> Agreed, I think it's important to figure out what's going on here before we
> > >> try to bodge around it.
> > >>
> > >> Adding Szabolcs, in case he has any ideas.
> > >>
> > >> To save him reading the whole thread, here's a summary:
> > >>
> > >> AArch64 kernel modules built with binutils 2.35 end up with a couple of
> > >> ELF sections marked as SHF_WRITE | SHF_ALLOC | SHF_EXECINSTR:
> > >>
> > >> [ 5] .plt PROGBITS 0000000000000388 01d000 000008 00 WAX  0   0  1
> > >> [ 6] .init.plt NOBITS 0000000000000390 01d008 000008 00  WA  0   0  1
> > >> [ 7] .text.ftrace_trampoline PROGBITS 0000000000000398 01d008 000008 00 WAX  0   0  1
> > >>
> > >> This results in the module being rejected by our loader, because we don't
> > >> permit writable, executable mappings.
> > >>
> > >> Our linker script for these entries uses NOLOAD, so it's odd to see PROGBITS
> > >> appearing in the readelf output above (and older binutils emits NOBITS
> > >> sections). Anyway, here's the linker script:
> > >>
> > >> SECTIONS {
> > >>      .plt (NOLOAD) : { BYTE(0) }
> > >>      .init.plt (NOLOAD) : { BYTE(0) }
> > >>      .text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
> > >> }
> > >>
> > >> It appears that the name of the section influences the behaviour, as
> > >> Jessica observed [1] that sections named .text.* end up with PROGBITS,
> > >> whereas random naming such as ".test" ends up with NOBITS, as before.
> > >>
> > >> We've looked at the changelog between binutils 2.34 and 2.35, but nothing
> > >> stands out. Any clues? Is this intentional binutils behaviour?
> > >
> > >for me it bisects to
> > >
> > >https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=8c803a2dd7d3d742a3d0071914f557ef465afe71
> > >
> > >i will have to investigate further what's going on.
> >
> > Thanks for the hint. I'm almost certain it's due to this excerpt from
> > the changelog: "we now init sh_type and sh_flags for all known ABI sections
> > in _bfd_elf_new_section_hook."
> >
> > Indeed, .plt and .text.* are listed as special sections in bfd/elf.c.
> > The former requires an exact match and the latter only has to match
> > the prefix ".text." Since the code considers ".plt" and
> > ".text.ftrace_trampoline" special sections, their sh_type and sh_flags
> > are now set by default. Now I guess the question is whether this can
> > be overriden by a linker script..
> >
> 
> If this is even possible to begin with, doing this in a way that is
> portable across the various linkers that we claim to support is going
> to be tricky.
> 
> I suppose this is the downside of using partially linked objects as
> our module format - using ordinary shared libraries (along with the
> appropriate dynamic relocations which are mostly portable across
> architectures) would get rid of most of the PLT and trampoline issues,
> and of a lot of complex static relocation processing code.
> 
> I know there is little we can do at this point, apart from ignoring
> the permissions - perhaps we should just defer the w^x check until
> after calling module_frob_arch_sections()?

i opened

https://sourceware.org/bugzilla/show_bug.cgi?id=26378

and waiting for binutils maintainers if this is intentional.

Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A2C20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rI9zXoyy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rI9zXoyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHLOQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:16:48 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:27587
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbgHLOQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeAs3CxtdJJ99/rZY44V7/YvDQ/bVMA3/ZJN/1D4ShY=;
 b=rI9zXoyyuT2W7JC0A/yNfwpbUkuHDWaElSIC50U+CRS5E8YlGhvDUNxM669pM5nnX9Qt9TyW6sCckA4ymNN4tB30VD5UE0aM+hw8PouaQkhdf2CRGNH/q/80/CcZgJi0fkH51yRWJcKkWMmnhSMZ3LLPJrCkrd8Yx0YsYDvC6yQ=
Received: from AM7PR03CA0024.eurprd03.prod.outlook.com (2603:10a6:20b:130::34)
 by DB6PR08MB2648.eurprd08.prod.outlook.com (2603:10a6:6:17::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 12 Aug
 2020 14:16:41 +0000
Received: from AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::25) by AM7PR03CA0024.outlook.office365.com
 (2603:10a6:20b:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 14:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT010.mail.protection.outlook.com (10.152.16.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 14:16:41 +0000
Received: ("Tessian outbound a0bffebca527:v64"); Wed, 12 Aug 2020 14:16:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f5e2f5a6ff76f675
X-CR-MTA-TID: 64aa7808
Received: from f5ace8dfe987.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F40675C1-35F2-47B4-AE90-F918059ACD9B.1;
        Wed, 12 Aug 2020 14:16:04 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f5ace8dfe987.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Aug 2020 14:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMXYNv/WNdvyfhoEYmAU22IGjDyToksT6glQBrU7jin64oKInJ8McvXeCzmvS+dO7gCH3MOM9LkolVrFibwsC3gyRztSFyLqFLmv33GVhudvJzCk7s7ki6A/J1513ACsCu4y2kDZbMmgsWsMKysknwuttTA8dXaTFQWP+1kx9bBZUX1NrxDroxcSD8UT1sAGjAKitrNPi8Yn574HdMdvIdJE2ffevYCNj/7XL8ag+tgEdGzS0GuvkdLqV6J3BbpvSwv/aHSVnC9kepn+DffCyTko/cp1tMdSd1o7Zn6liskp/8NxqUFiwON6FCxn8vNZTB/zpDPwzHF69+a5G2mLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeAs3CxtdJJ99/rZY44V7/YvDQ/bVMA3/ZJN/1D4ShY=;
 b=dt9hIVTcfxlSkx3Ck7QHVIyGMgE3asTZGZm3Vdd7OojViDarfaAtyJrWG0zG28XFPdZk7FWdZSDACwY+v+IXCbKBQ2X/pv99Li9AUbPTlpYTsl3vSiAXVinPNcrGRsP2jEGiKr6D6yPGcBD31VH4esxtshe+JcAXVL9rYa0SsuqRSN9gy7u01/UbWOZNX1AYm12mso7+2JPXveSOvylTpQt0Vx9PTdjtjwvYcC70c25DY3BPQx2rE9JllprBcWbpAjtu9oCWw6JPdo/XD+KOwLIIMhNDyV4GOA2Ys5wFTWp/HK9LKwV4tgOT28wmw3UyZVILsWbDsFyfct8hEUVhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeAs3CxtdJJ99/rZY44V7/YvDQ/bVMA3/ZJN/1D4ShY=;
 b=rI9zXoyyuT2W7JC0A/yNfwpbUkuHDWaElSIC50U+CRS5E8YlGhvDUNxM669pM5nnX9Qt9TyW6sCckA4ymNN4tB30VD5UE0aM+hw8PouaQkhdf2CRGNH/q/80/CcZgJi0fkH51yRWJcKkWMmnhSMZ3LLPJrCkrd8Yx0YsYDvC6yQ=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM5PR0801MB1810.eurprd08.prod.outlook.com (2603:10a6:203:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 12 Aug
 2020 14:16:02 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 14:16:02 +0000
Date:   Wed, 12 Aug 2020 15:15:59 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     peterz@infradead.org, Ard Biesheuvel <ardb@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd@arm.com
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200812141557.GQ14398@arm.com>
References: <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812125645.GA8675@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0458.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::14) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0458.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 14:16:01 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a3d6801-fb47-4413-061c-08d83eca55c4
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1810:|DB6PR08MB2648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB26488A2C7974C6E921FC24BDED420@DB6PR08MB2648.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BGOwkX1uyYOgKn1yxECNYBuydwsp3UQmdt+gkH0U7MpUXabo1NToaoxcNICLHt2B4m6J1roTzks5a5NclG4GFlyEYnRpUtuweIxNngzz31o0OBpaRdGOA72vew5aw1PXd8HR2zu4MvGIueTFnyfrUDHIXAZush3V2g7OhDC1IfP7cNQJGtZkN/ywIFwhTtMZaoI8m2Zw+GyLUa6wgGvYC6Cpe59eRkPIKYSewslLYf3gafNKCp2AiIjEtwa9d/EUWRmwzbXpnNlNcw3YY2FOo6lqDHkQKJD7or9eW47yDMcTQNoTp6WSjqdTgc+awvYLHxRU7tuP2WbJFTcUKbpJa0H1GKNJmGs0yLtq6uy4kGbPPD9JiroxPG2Vvh7s7PayCn184oWjQxtWZgjTfPoKHg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(186003)(478600001)(44832011)(8936002)(86362001)(66556008)(316002)(2616005)(16526019)(2906002)(1076003)(54906003)(8886007)(66946007)(8676002)(55016002)(36756003)(956004)(66476007)(26005)(52116002)(33656002)(4326008)(7696005)(966005)(6916009)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qFvbvmhu45OX82buhY8a/6JYKQ+GJhXgo2Ay6n0rhXuYBj6KozxOSNohKVBQ00YjefbsNCD3fVBHRKkDHjR8NOa7dAvDo+aBsl2gDDXoXTDSsS7ZGTH+YkIeVe71fN00UB4sGk/axArhoaGeneYODIelvnwRkUNYNC85q5E84Xd9PwGAQDh9LA43CbsyxwBu8D/9ak9nTPsd0ZMh07xUpJ8TXNcpFQUUGeW0kIpvL9Gl/gVeubmJbEoqzC5aFmr5iaeZ1AIylAbEtDPKaViH4JU22qpgGiHNKmvt+kIpOoubkpouDT5FUZsG3EM/DAxYNCEFj4jlBOvNmFh42iz4jArEIp6XRI2/siztaTQTSs05ypQcRD6ygen2k+wJEnny7Q/gK1PD9gqy9khX3jB5m1MWr3D6UMqDBO0MIYw7P+pOeAEt7y0XmJB855+zU0cdmYUPOSnEpkZt6jGDEopWyKak3sReBhFJNkxNKO3evbgfp1VyfXRPHVneoM5txoE6Qogaf3DFYXzHIdcetYtmCstB0nIQF3zHwcL5YzkXLEcdQomNGISwRYPkRbp3tNTBi660Eu7v75uPNa2slBnfpVijxdVku4eyMKVT0EdW8T4veYrNDKvHIGQR+tLLHexdHn5e6RFiYRCAoSVHORUX9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1810
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 92b76b88-6ebf-47b4-b825-08d83eca3e0a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtgWG668CPmU9Ixf26ZU7uCQyx+ykcp/RW2TC/D/1xeCs8mCbhC7VxFvJpuoigSR9wDDGZrqUMPtCHySQ97y2fdacOR7vjOLmOW1+j9RxibN0Y00nkrryL+KOixe4uy9i55eA7V40Ny5hq+EY1DUZ7KJzkcOKnP1TJS/t7zoWNv+9ePg7L0aZXvZhGYF3sVVlO+otoAKg5Depm1MsJYtxPfWnhwaeq4kBUIAJkcTP4mgwhtyqyzgqRXagst/fxiWHvJFQlhPL7y5Gw6+ZmqC+kA/5o2e9JUB1Fc0Ugag1uEGxAQEFAT6N+N3kPhkNB4ZTAZUXjzKVM2a7OCgnstU8HCU5LRoq7oVd7fmxhLd/HrxYDlb0J2DGV8vPdEOIbxsyFb6V9eRNroPDcNiQuGWNNAiW6jMbdqBop5gS09ve7nLOcTSynONDFY89CVXLHbvAWYh1hDd+ofb40RLBXgkHMiVHQLEiFMJ7yF/g9eyZ+w=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(8936002)(47076004)(82740400003)(2616005)(956004)(478600001)(2906002)(356005)(8676002)(6862004)(33656002)(81166007)(55016002)(82310400002)(186003)(7696005)(16526019)(36756003)(316002)(966005)(54906003)(70206006)(5660300002)(8886007)(26005)(44832011)(1076003)(86362001)(336012)(4326008)(70586007)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 14:16:41.5311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3d6801-fb47-4413-061c-08d83eca55c4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/12/2020 13:56, Will Deacon wrote:
> On Wed, Aug 12, 2020 at 12:40:05PM +0200, peterz@infradead.org wrote:
> > On Wed, Aug 12, 2020 at 10:56:56AM +0200, Ard Biesheuvel wrote:
> > > The module .lds has BYTE(0) in the section contents to prevent the
> > > linker from pruning them entirely. The (NOLOAD) is there to ensure
> > > that this byte does not end up in the .ko, which is more a matter of
> > > principle than anything else, so we can happily drop that if it helps.
> > > 
> > > However, this should only affect the PROGBITS vs NOBITS designation,
> > > and so I am not sure whether it makes a difference.
> > > 
> > > Depending on where the w^x check occurs, we might simply override the
> > > permissions of these sections, and strip the writable permission if it
> > > is set in the PLT handling init code, which manipulates the metadata
> > > of all these 3 sections before the module space is vmalloc'ed.
> > 
> > What's curious is that this seems the result of some recent binutils
> > change. Every build with binutils-2.34 (or older) does not seem to
> > generate these as WAX, but has the much more sensible WA.
> > 
> > I suppose we can change the kernel check and 'allow' W^X for 0 sized
> > sections, but I think we should still figure out why binutils-2.35 is
> > now generating WAX sections all of a sudden, it might come bite us
> > elsewhere.
> 
> Agreed, I think it's important to figure out what's going on here before we
> try to bodge around it.
> 
> Adding Szabolcs, in case he has any ideas.
> 
> To save him reading the whole thread, here's a summary:
> 
> AArch64 kernel modules built with binutils 2.35 end up with a couple of
> ELF sections marked as SHF_WRITE | SHF_ALLOC | SHF_EXECINSTR:
> 
> [ 5] .plt PROGBITS 0000000000000388 01d000 000008 00 WAX  0   0  1
> [ 6] .init.plt NOBITS 0000000000000390 01d008 000008 00  WA  0   0  1
> [ 7] .text.ftrace_trampoline PROGBITS 0000000000000398 01d008 000008 00 WAX  0   0  1
> 
> This results in the module being rejected by our loader, because we don't
> permit writable, executable mappings.
> 
> Our linker script for these entries uses NOLOAD, so it's odd to see PROGBITS
> appearing in the readelf output above (and older binutils emits NOBITS
> sections). Anyway, here's the linker script:
> 
> SECTIONS {
> 	.plt (NOLOAD) : { BYTE(0) }
> 	.init.plt (NOLOAD) : { BYTE(0) }
> 	.text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
> }
> 
> It appears that the name of the section influences the behaviour, as
> Jessica observed [1] that sections named .text.* end up with PROGBITS,
> whereas random naming such as ".test" ends up with NOBITS, as before.
> 
> We've looked at the changelog between binutils 2.34 and 2.35, but nothing
> stands out. Any clues? Is this intentional binutils behaviour?

for me it bisects to

https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=8c803a2dd7d3d742a3d0071914f557ef465afe71

i will have to investigate further what's going on.

> 
> Thanks,
> 
> Will
> 
> [1] https://lore.kernel.org/r/20200812114127.GA10824@linux-8ccs.fritz.box

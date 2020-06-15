Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536B7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AAF2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="icsSOJgW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="icsSOJgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgFOQsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:48:37 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:47374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730135AbgFOQsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XII8QcwjX2ZlQ/t/6zDZoPb+Foy1EiQBkIIF6r14xA=;
 b=icsSOJgWIEWLupJFgnLyKilLNax3OdLpU1p5auD39TlCyw21vAxzriys7ZctqphQWFFIU3pszcyOHN+r7KvleJmVe5CnZdwhbjqQyec4VIsbgLeqLTpRu1wegcEWVfFTOYZJTc+9433ZzRvcSIWrcMtqV65FPmPT9aZKHkfkkjY=
Received: from AM5PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:203:91::11) by HE1PR0801MB1673.eurprd08.prod.outlook.com
 (2603:10a6:3:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Mon, 15 Jun
 2020 16:48:31 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::b7) by AM5PR0502CA0001.outlook.office365.com
 (2603:10a6:203:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Mon, 15 Jun 2020 16:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 16:48:30 +0000
Received: ("Tessian outbound 299e58e1e4d2:v59"); Mon, 15 Jun 2020 16:48:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e940e49eeb63e485
X-CR-MTA-TID: 64aa7808
Received: from 62014d520eec.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A11F0873-122C-4234-A956-4402A4DF4A7A.1;
        Mon, 15 Jun 2020 16:48:24 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 62014d520eec.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Jun 2020 16:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+M3vjmSh3JGbQdjvwnA8/4XzNlAHQTzM3pfonHc3Cuxa2KdHaHaR7BK6mybuKWWeiOC7hVDd+24Pw2b3w+fXyIy6h189pu00ELdJmOMiEEKFGM0dk7iUKDzy/VP4Nv02Jzohnt1XgU9FiStufH/+fZ0QcMHRbmwiLuyfZJEdNgyAQSyrOY2fhIamapWFb0w27B4r9xm082/C+VyGHUnBmQ39rHWLBRatixs49oeuwQVwtUuBEYc5FYgPYr9R7bey1Jd3nz4De4p4zWi/nL1//63era+QGjB3K5MNDMervKYvxUDAldp66/7g2/c5uMhA0++D0TewAB/hrkYzsrQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XII8QcwjX2ZlQ/t/6zDZoPb+Foy1EiQBkIIF6r14xA=;
 b=WHBJM6wnWtygWivSbE4C+iBwD52LS+cvZpilg2gaLDBR655lPXBxBYfp+FO1evnoL5fJ2nm5A1v/B8sjnDUduZPq7Ty84i4kH+qzp7NQNcDksqam1SlOOh/18t+4Fz3Jl7ms83qgp/5L9OiAQsk0PPt3pEdLU6HTT7vVVTCiVcvgZer0I1DHETVm/Ak9TYb0I0Ivw2G6BJgjT/ghM41GnNEJMC1ZKBkkKiRcSJgCpS/ZtjwEmE5KGVHFNOpjeDZV6HuWFqRXyJ0jGz7UFqfXhT/XUbLHfOTBX54FRBRW+onV0aRV8tFrzCZQDmSAssQz+ilK7bmvvTuiaL7V+xCH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XII8QcwjX2ZlQ/t/6zDZoPb+Foy1EiQBkIIF6r14xA=;
 b=icsSOJgWIEWLupJFgnLyKilLNax3OdLpU1p5auD39TlCyw21vAxzriys7ZctqphQWFFIU3pszcyOHN+r7KvleJmVe5CnZdwhbjqQyec4VIsbgLeqLTpRu1wegcEWVfFTOYZJTc+9433ZzRvcSIWrcMtqV65FPmPT9aZKHkfkkjY=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com (2603:10a6:4:73::21)
 by DB6PR0801MB2006.eurprd08.prod.outlook.com (2603:10a6:4:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Mon, 15 Jun
 2020 16:48:23 +0000
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::ac31:e5b9:8aa0:4a33]) by DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::ac31:e5b9:8aa0:4a33%8]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 16:48:23 +0000
Date:   Mon, 15 Jun 2020 17:48:14 +0100
From:   Achin Gupta <achin.gupta@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200615164814.GG46361@C02TC1ARHF1T>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
 <20200610074346.GB15939@willie-the-truck>
 <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
 <20200611171222.GB7725@willie-the-truck>
 <20200615091639.GD46361@C02TC1ARHF1T>
 <20200615095133.GA2477@willie-the-truck>
 <20200615114220.GE46361@C02TC1ARHF1T>
 <20200615115549.GB2694@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615115549.GB2694@willie-the-truck>
X-ClientProxiedBy: LO2P265CA0380.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::32) To DB6PR0801MB1861.eurprd08.prod.outlook.com
 (2603:10a6:4:73::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from C02TC1ARHF1T (217.140.99.251) by LO2P265CA0380.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Mon, 15 Jun 2020 16:48:22 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 496ea29e-090d-4a37-698e-08d8114bef30
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2006:|HE1PR0801MB1673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB16732CDE8137C4C668D50BBEFF9C0@HE1PR0801MB1673.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MY2/v3GjNX/MjUuOGFJ28Srm6QXkKosJjExPIw5ICSpOh22UDU47JkViNCYwCPX1ztEK5KzoQ49LVc/F5fMYtrlTwSo3nrE8lNfFnIf0Qz+Pt94QwTbnB3HTdtENKmHW+psVDNOuoVNTp+jI0PndpH6a589AMnXX78lBTM2Jr89i8eGy8D+kwne36rHDQA2/8j92XZtYvEfMLlPG/6c4qILO0tF14o37+NxTssXiM3XvXt9dCqXYWEz1CTxzLzgLcEzMO3mHCXr2CY+XxCmLhxTtVAKqQ9AEP9gj/UbtYVfVekfB5kfEW2CP38yeAvd24II9BzS9npq+7UBw928Zbw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0801MB1861.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(86362001)(186003)(478600001)(1076003)(16526019)(2906002)(26005)(6496006)(6916009)(52116002)(4326008)(5660300002)(55016002)(33716001)(9686003)(316002)(33656002)(66946007)(66476007)(66556008)(956004)(6666004)(8936002)(83380400001)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wykljrHBU1kO+A8BgAQYsLNMyl7CpYvylLOXjgB18t3X2860uCLXYg3t+hjYUoR9950GhtIUc17gna3KI5jGMBwB1WW08tVAd1wbyrp00M7Pse4AUN6Us+vNL1V7F2YoG2PtPplCd4rHuTB+6ifKM/NXzL8G9ZFyBNfwS5qUsiGiesKwntWnfpsCYZk0Eb6cun8JVURfO8PnXhpoBL4RaHqbtmZcP90+fyqchKI8cpRmeNbdskc9or+Wb54J/r8tiNBUvzs1bRu73KqCT/v+DlZT141LAGKmT+JJQhUrz1LwOptbeblHAecNr0WMJZQC+XkTpDHydzLYfgfmIQblyNk2w+ib4cGO8Rmewvz/XZuPtBy1PyZUkwCN+rL3gZbbfnjbf+xTrEmLclKCDCtJSKRz/f8zR07cVfhfyFTHWsMZVlSErCFJ+1k7uUwULKbJGUMmdpLOZGKsM7tsgdOn81yGVbwJVtXQ5746GB9SLoqOTFcBbWSUvKds+YkNhwDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2006
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(5660300002)(6496006)(1076003)(336012)(6862004)(4326008)(450100002)(956004)(6666004)(70206006)(44832011)(70586007)(82310400002)(356005)(2906002)(86362001)(16526019)(33656002)(82740400003)(81166007)(47076004)(36906005)(316002)(55016002)(83380400001)(54906003)(186003)(9686003)(33716001)(26005)(8676002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9762414e-9c30-4f16-9efc-08d8114bea85
X-Forefront-PRVS: 04359FAD81
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqY8TZQEg1DBgwZjQPlnx5Z6KoLQWl4PUfE88voKU+i9suXH1mHfhvT/JPyD4plsB1dOAlJq7l0EwWy+zYgOout092jfo5AIG79ZHgiR3aJMza/Ic80Mon9dNDS85eeaWR8gLLFpNgVjJupDDcZXmvndzywZMzNgVt9ho7IADmTtMNYS7l81eVvWjpeoOP24LnAITQ9G4zWxlIfN6nU0I+nifApzNcix404x7h5MJn3iOeF50mCFAqtQsSfaKwYJj9DcMQCv4SM609J1y2VQASRs6lnhGgCJtExg1Oyzj5JVhl0s/ia3cM0plgv+e4E0YyXVBnn37Ll2Kp3ZZJ+RnD/6QwnufefR947CyyM83wxaUY3v4pJosgp3F7JqY23VVLZ9kaP+dZzMUEJXDYr6KA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 16:48:30.4602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496ea29e-090d-4a37-698e-08d8114bef30
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:55:49PM +0100, Will Deacon wrote:
> On Mon, Jun 15, 2020 at 12:42:20PM +0100, Achin Gupta wrote:
> > On Mon, Jun 15, 2020 at 10:51:34AM +0100, Will Deacon wrote:
> > > On Mon, Jun 15, 2020 at 10:16:39AM +0100, Achin Gupta wrote:
> > > > Right! FFA_PARTITION_INFO_GET is meant to help the FF-A driver in the kernel to
> > > > determine partition properties. It assumes that EL2 SW has already read each
> > > > partition's manifest and will reply to this ABI.
> > > >
> > > > IIUC, with protected KVM, this information will have to be a part of the
> > > > manifest that the KVM host consumes.
> > >
> > > The host does not consume the manifest directly -- instead, the bootloader
> > > will use the manifest to populate these DT nodes. Again, these are *only*
> > > for non-secure virtual partitions which are to be managed by KVM.
> >
> > Yes. Understand and agree. Manifest is an overloaded term. I was using it to
> > describe the DT nodes that the host will consume.
>
> Hmm, I think that conflates two things though because only the partitions
> managed by KVM will have DT nodes.

Sure. I am realising the need to maintain the distinction :o)

>
> > > > Separate topic, protected KVM does not get dibs on the manifest and it relies on
> > > > the KVM host to specify the address ranges for each partition? Does this not
> > > > mean that the KVM host can control the physical address space each partition
> > > > sees. This seems contrary to the isolation guarantees that protected KVM must
> > > > provide?
> > >
> > > The host is trusted during early boot, and gives up this trust after
> > > initialising EL2 fully. So roughly speaking, we:
> > >
> > > 	* Boot at EL2 and install a shim
> > > 	* Drop down to EL2 and start the host kernel
> > > 	* Before some initialisation (DT parsing, SMP bringup, etc)
> > > 	* Init KVM by calling back up to EL2 to install the full hypervisor
> > >
> > > At that point, the EL1 host is no longer trusted and the last call
> > > effectively "locks it out" from EL2.
> >
> > Ok. Protected KVM (PKVM) must create S2 tables when asked to setup a partition
> > by the Host. My main concern is if PKVM must trust the Host to provide the
> > correct physical address space ranges for a partition?
>
> Yes, but that all happens as part of KVM initialisation: the host parses
> the DT nodes and memory reservations, and then passes this information
> up to EL2.

Ok. Good to know this.

>
> > I guess your point is this is not a problem since PKVM can lock the Host out of
> > those address ranges in any case?
>
> It has to do this, regardless of how they are probed. Once KVM has
> initialised, the host will have a stage-2 which limits it to the memory that
> it is allowed to access.

Agree.

>
> > It is a bit counter intuitive that the Host gets to see and potentially
> > manipulate information that was verified and extracted by the bootloader from
> > the partition's manifest. This hapens before PKVM sees the same
> > information. Can't put my finger on what could go wrong though. Depends upon the
> > threat model too!
>
> I think you're trying too hard to separate the host from the EL2 code during
> early boot. Don't forget -- this is all part of the same binary payload that
> is loaded and initially run at EL2. Having the host take care of early boot
> /significantly/ reduces the amount of code at EL2, which has a very
> clear security benefit.

Fair point!

cheers,
Achin

>
> Will

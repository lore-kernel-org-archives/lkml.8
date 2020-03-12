Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E745FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE29E206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iXAMkW6U";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="GfcfGG8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCLSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:33:33 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:5870 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgCLSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:33:33 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CIHNwb015622;
        Thu, 12 Mar 2020 11:33:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=s/kCeHc2eIQcxOJ1baav99zMwOHBHfe+NIqt9v5yaKA=;
 b=iXAMkW6UGi7L7UD8zF4yM6t36jrvnE8VCwPgo8BUoDY1fsAEfllMWG6exLzNJZdcOkNT
 kHj9rCXh3RHx9A3isEkU1hdySz6zIRedN4lvQZZgrqtosKJPa9OoE1f/cof0o83YUdNo
 gMsOJ9Kq5PDbgwO5S4vgGeej+1LU25LsEcYXiQncFhH9oHCyQHUa+f8AyWurTp4ScGR1
 d5DDnHcK4QAK/tEDJJ8XGDUW5+MapVq29Vm6zErVlq+fxOmHcqwNdmmZlc7vu9TmQGtt
 NhXyL1j/PRd1/+2exeZ1ftY4cM85bhR69knyjDgTiNa/yUZnEynltc23zXcThRTD8s9q Tw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yqt7t023v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:33:18 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Mar
 2020 11:33:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 12 Mar 2020 11:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H90f1HqvwJl4GA0ukxxmyKnic4OaeLoX8UarVDFqQ6V9XPr5qYP9aldoQYQf4D8+Z0oh8jzrzkFaJAroK7LX2gRsgCGNgnU4RnCpBZ7Qa6qK5msemKdGGSMg7k9o8ga+obH4KIwqjfK9KF+IgqeO2cPq+vDHEycZ7z7tIIluPvnm7K0QCbSZZ6JPCcdCiUgZigrHNW1AedH/591nHs+oCkaL/hL14WB28ag0mX+zw6yfn9MEaqxwlRipnw7538D3/YB7MtjD11EWJdXWupVeMdcwj8IFjbYynJ805iZ9CAAkZQ1MNmIZr8uppZ1Ik8tra04GLUY1+zl3gdkZZHQMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/kCeHc2eIQcxOJ1baav99zMwOHBHfe+NIqt9v5yaKA=;
 b=VO1mFu++cf/2vpH22nxf8PG56cvlqrLJpMNxqo8Af2RUYo1lso3VQ9jGVGJJkoRSstNl5KcrdsakynUP7Vx1+M7fcvd9wXqxZFPt0CMwTeQggi8aYvigqyetTK5iyM1OVj9VRIuORF2ck+GWXl0oWwLJSRo/9I58fUzMuvmnNvQzx0Oaa2YN4g4aF6VTzOEKyiZ9QDLk0F2JP5G4Tv129UEE7HBS3bv8IORhJG0zsU9FHl/3dV3nEDbTybCKKLv6OnINhn/GZSf1wvJCO+8E8p/yJcSTAf1fD4oizR+QFqThYm8ShQIBickpvtAPl5m3Ug4bQH6kOmSRLXTOinBK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/kCeHc2eIQcxOJ1baav99zMwOHBHfe+NIqt9v5yaKA=;
 b=GfcfGG8S8zi0GHuXIOZ9psHj/WNITwHXOIe3s8L1wDmCS58+9yUCN9XMiKeSkHYnpN5iWkiJf6Vl62c8Nv00EBD+WJicV04YFxKYr1TJAhFBpZi0re2+pCypZqATPABQEH0YHbg6Eb/2c7yCDU+bBfvafQzipGtVGmgGD6lbA80=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2832.namprd18.prod.outlook.com (2603:10b6:208:a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 12 Mar
 2020 18:33:14 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 18:33:14 +0000
Date:   Thu, 12 Mar 2020 19:32:57 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround Cavium erratum 38539 when
 reading GICD_TYPER2
Message-ID: <20200312183257.xylz6seamaw3svl4@rric.localdomain>
References: <20200311115649.26060-1-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311115649.26060-1-maz@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR09CA0059.eurprd09.prod.outlook.com (2603:10a6:7:3c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13 via Frontend Transport; Thu, 12 Mar 2020 18:33:13 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e201a69-277c-4a9e-0afd-08d7c6b3d386
X-MS-TrafficTypeDiagnostic: MN2PR18MB2832:
X-Microsoft-Antispam-PRVS: <MN2PR18MB2832998F9C31F193AEB42126D9FD0@MN2PR18MB2832.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(186003)(66946007)(86362001)(81156014)(81166006)(956004)(8676002)(8936002)(52116002)(7696005)(45080400002)(6916009)(53546011)(6506007)(478600001)(2906002)(16526019)(4326008)(55016002)(66556008)(66476007)(1076003)(26005)(5660300002)(316002)(54906003)(9686003)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2832;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcHIOkJLdBbicu+I+cXE2IbCZqQBVRk/SNxsfeBYCGbGneVGAE0dQgNAm4pSN1iBSaYG7hncd5zFhtO+MAwOmLsWAq84jJrBrxbucndXZvwYCgQFZw4zUL609950ZKLBwAdOHhwll6r+vDtImd9RjivE/J0M4ov5hgx/Mu+hUQGjcFY60t+gsFKS/mPI7Eb6IyKhgkrI3IKSQgqEaOaCpaIdiLC4cyV23tJbS+Xho3m3o2u+A/trRzdgHiR9ALxbvqEbTUC6s1BwS14xtoweEF/u6KsCrLvgb2P872elA0qRx9+JdM+A5qMtxbXifbxnk4RCeX0S7tB8Ccf4qrMUhXJDwIiPhK4dIznVMzCUOLvg+T0jSz5a6AA5mBJLWpqIuRLAfS48lkPeNIV9FvKPGIgHH5+iv7zzp/0hZEck53Ay0c+3bvibt7ts2I5Amc00
X-MS-Exchange-AntiSpam-MessageData: c4bpGAnJYeoWWYqYY0qktqilxWLlm0KtRoXKOM5J2Ed2jun9vIYBI2K/tdFEua4flqfsyGthpRIzVOqtnm/jPG+hFpZTm0GsbiQxEddqTDQuOH36o/PMcQMawpraUEM/JBZnltjAUeHbjEzRASqeQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e201a69-277c-4a9e-0afd-08d7c6b3d386
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 18:33:14.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af2C0wy9ejCRRBcgN4n03OeC74D3pGUL2gJOM+MEjFZlfZUkBXouedzSi4jtMtA8qcKgQxyptV4gj7bFd3AwRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2832
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_12:2020-03-11,2020-03-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 11:56:49, Marc Zyngier wrote:
> Despite the architecture spec requiring that reserved registers in the GIC
> distributor memory map are RES0 (and thus are not allowed to generate
> an exception), the Cavium ThunderX (aka TX1) SoC explodes as such:
> 
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: 128 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc4-00035-g3cf6a3d5725f #7956
> [    0.000000] Hardware name: cavium,thunder-88xx (DT)
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : __raw_readl+0x0/0x8
> [    0.000000] lr : gic_init_bases+0x110/0x560
> [    0.000000] sp : ffff800011243d90
> [    0.000000] x29: ffff800011243d90 x28: 0000000000000000
> [    0.000000] x27: 0000000000000018 x26: 0000000000000002
> [    0.000000] x25: ffff8000116f0000 x24: ffff000fbe6a2c80
> [    0.000000] x23: 0000000000000000 x22: ffff010fdc322b68
> [    0.000000] x21: ffff800010a7a208 x20: 00000000009b0404
> [    0.000000] x19: ffff80001124dad0 x18: 0000000000000010
> [    0.000000] x17: 000000004d8d492b x16: 00000000f67eb9af
> [    0.000000] x15: ffffffffffffffff x14: ffff800011249908
> [    0.000000] x13: ffff800091243ae7 x12: ffff800011243af4
> [    0.000000] x11: ffff80001126e000 x10: ffff800011243a70
> [    0.000000] x9 : 00000000ffffffd0 x8 : ffff80001069c828
> [    0.000000] x7 : 0000000000000059 x6 : ffff8000113fb4d1
> [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.000000] x1 : 0000000000000000 x0 : ffff8000116f000c
> [    0.000000] Call trace:
> [    0.000000]  __raw_readl+0x0/0x8
> [    0.000000]  gic_of_init+0x188/0x224
> [    0.000000]  of_irq_init+0x200/0x3cc
> [    0.000000]  irqchip_init+0x1c/0x40
> [    0.000000]  init_IRQ+0x160/0x1d0
> [    0.000000]  start_kernel+0x2ec/0x4b8
> [    0.000000] Code: a8c47bfd d65f03c0 d538d080 d65f03c0 (b9400000)
> 
> when reading the GICv4.1 GICD_TYPER2 register, which is unexpected...
> 
> Work around it by adding a new quirk for the following variants:
> 
>  ThunderX: CN88xx
>  OCTEON TX: CN83xx, CN81xx
>  OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
> 
> and use this flag to avoid accessing GICD_TYPER2. Note that all
> reserved registers (including redistributors and ITS) are impacted
> by this erratum, but that only GICD_TYPER2 has to be worked around
> so far.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Robert Richter <rrichter@marvell.com>

Tested on a Cavium Thunder cn88xx.

Acked-by: Robert Richter <rrichter@marvell.com>
Tested-by: Robert Richter <rrichter@marvell.com>

Thanks,

-Robert

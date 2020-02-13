Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B782420873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ib49eKqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBMHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:50:03 -0500
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:26006
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729735AbgBMHuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:50:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofm8O3pZpMNxYh/EazGu+Z1d8bjus8WCsBsHKXrnfnAmpnq9txqRb/o/HiHF16mBdq6waHDfIMvkOXaT9p9+lMQbKmZy1bK2Azw9VNJgcidP+70jKC62BPJMcaKDsEnf111i4x8vL3+rTpeHd02sfTEWw4sDT+qmZQUat2qAsQACls2BmYksF7Ju+yFbLBtp8NIU31mlV0NDGOkzKBQW38FAbAUa5dTaCyhHFzfwqjRiIzgyuyIYYhW+wqy7Y7zNA2U4mVaCZ7+CVK+Jfr77U5ihGity0q8S1OTWeD9aldxSlzlAg9eNxCppFc3NIuGkZTyfKeGUWOwsGfv0q3VNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du0lLAxQu9g7+fpHsitcb4JBeVtLHGSprjFs+ITcAbE=;
 b=mBxcEvkoz45pfM6OiYIopqiJiO5x6Q4V6MW9uto2Mf2AqMlZgVlkoDfEU3bljVgx6dbvVkNyaZicvRISMsH8XgC/dca1cJY9WRN3einJbr+48pSaTwCNw+ScdN/eE51VPGaBmWOF3FEvk3BEwgKsHzuUA4NiOOXxvfIYwG7Aem36pr5iT3q5pz/daLK3J5kmP+KMxFnANsrZMODYv14kVJClAe0cqGRZnHTVgpGYQB0yy8kti2Xl9GDMP6vY/govTjCgAkejPqdcrSevpemhp8CeCjHAEQtUUURQe+hZhsoJo0yNXvM4SAohRzBIkjyzwV243JwcdXnBKTmJkgEuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du0lLAxQu9g7+fpHsitcb4JBeVtLHGSprjFs+ITcAbE=;
 b=ib49eKqvffFWn0KKeF/5HkO2w5fwAkCVwmzfB6OAz6NIAc1b2YxZlnecJCXosQJokCSiAtwhhnfzivV6kuWdcOATPD0VLwae6FV+NH5blTOoka+O6gP20HT+f3SjxFECRnmYVWq0iGL3zjGJK1adVfo9bu0PjoV/rXTci6l1gg4=
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by DM6PR02MB5994.namprd02.prod.outlook.com (2603:10b6:5:150::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Thu, 13 Feb
 2020 07:49:58 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Thu, 13 Feb 2020 07:49:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Thu, 13 Feb 2020 07:49:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29G1-00015L-Cx; Wed, 12 Feb 2020 23:49:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29Fw-00009m-9k; Wed, 12 Feb 2020 23:49:52 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01D7niQR030444;
        Wed, 12 Feb 2020 23:49:45 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j29Fo-00009O-Nz; Wed, 12 Feb 2020 23:49:44 -0800
Subject: Re: [PATCH 0/7] microblaze: Define SMP safe operations
To:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <20200212160852.GC14973@hirez.programming.kicks-ass.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8dc57ea5-0868-0707-25a7-4cd6d8a43add@xilinx.com>
Date:   Thu, 13 Feb 2020 08:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212160852.GC14973@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(5660300002)(426003)(6666004)(70586007)(70206006)(31696002)(356004)(9786002)(4326008)(336012)(316002)(54906003)(81156014)(966005)(110136005)(2616005)(8936002)(8676002)(36756003)(7416002)(186003)(478600001)(81166006)(2906002)(31686004)(26005)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5994;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b27062db-424d-4c07-82e1-08d7b0595291
X-MS-TrafficTypeDiagnostic: DM6PR02MB5994:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR02MB5994011931E66B0A24B14508C61A0@DM6PR02MB5994.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031257FE13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvc72+sclzKFZweuQX64ve6y+A7d3XRno7PYRYl7nbU6PKoXCoZszM0B2ucS6ICFrAv5YJWzTuZbX1/5LYPSyL6iuwbcLGXQ+usw4yIfzFBDpNlzCzI9DA3EveFIMkDWzRDUChzblZE8/jsP/Hp4qfPf0tZVKD7RIO487Pw6Y7z2X2T+oDCJxoZadocNmm45advExGFBSJ4lHfN2b0z9Mwj8ctIn9utLhLD29lt2u2nnpz8k2wG77+UttE/Zd4R03FuUDQnFoG5+MbgKDNORrB4QZSp6o99SOxMeSN/28l6f6ZRg6L0dgfp6plBBfdOdRsXQ+NvCkL+YR6eVzgUzp1n12Sw79BedtVh/vY0PrqBXhusliHhbPAaoNFt3EeV0cuXADMsE7U2T1c435snFeDvDrk06q1GNa/00UxAtsPe4jjPU9vNHYVTgJDbuCyOxJIIrbYR+C94ov7JHi978bXDX280xqFc6M1wxUffF6ApX+zU8zQP8OEidf6eLiWtxC6srhIRTwG7hcLIPG1S38A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 07:49:57.8338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27062db-424d-4c07-82e1-08d7b0595291
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 17:08, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 04:42:22PM +0100, Michal Simek wrote:
> 
>> Microblaze has 32bit exclusive load/store instructions which should be used
>> instead of irq enable/disable. For more information take a look at
>> https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug984-vivado-microblaze-ref.pdf
>> starting from page 25.
> 
>>  arch/microblaze/include/asm/Kbuild           |   1 -
>>  arch/microblaze/include/asm/atomic.h         | 265 ++++++++++++++++++-
>>  arch/microblaze/include/asm/bitops.h         | 189 +++++++++++++
>>  arch/microblaze/include/asm/cmpxchg.h        |  87 ++++++
>>  arch/microblaze/include/asm/cpuinfo.h        |   2 +-
>>  arch/microblaze/include/asm/pgtable.h        |  19 +-
>>  arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++
>>  arch/microblaze/include/asm/spinlock_types.h |  25 ++
>>  arch/microblaze/kernel/cpu/cache.c           | 154 ++++++-----
>>  arch/microblaze/kernel/cpu/cpuinfo.c         |  38 ++-
>>  arch/microblaze/kernel/cpu/mb.c              | 207 ++++++++-------
>>  arch/microblaze/kernel/timer.c               |   2 +-
>>  arch/microblaze/mm/consistent.c              |   8 +-
>>  13 files changed, 1040 insertions(+), 197 deletions(-)
>>  create mode 100644 arch/microblaze/include/asm/bitops.h
>>  create mode 100644 arch/microblaze/include/asm/spinlock.h
>>  create mode 100644 arch/microblaze/include/asm/spinlock_types.h
> 
> I'm missing asm/barrier.h

This has been sent in previous patchset. Link was in this email.

> 
> Also that PDF (thanks for that!), seems light on memory ordering
> details.
> 
> Your comment:
> 
> +/*
> + * clear_bit doesn't imply a memory barrier
> + */
> 
> worries me, because that would imply your ll/sc does not impose order,
> but then you also don't have any explicit barriers in your locking
> primitives or atomics where required.

I think this is just comment which shouldn't be there.
clear_bit is calling clear_bits which is using exclusive load/store
instruction which should impose ordering.

> 
> In the PDF I only find MBAR; is that what smp_mb() ends up being?

yes. All barriers should end up with mbar.

Stefan: Please correct me if I am wrong?

Thanks,
Michal



Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1599C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ED72173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gbjX+z6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgBMINU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:13:20 -0500
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:17927
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMINU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:13:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyySt6bEl3qD891CKivm/oMHV8aNzn1tZS1X4H23FGOfPsyvn3KN5gK8xC5tXoS4DqZPqrOLQ14oiQHrYNjVnektf5sIdjcKv/49vAdhmRTgX2gGXraij+HESkpp52yT1MuaAUzhpLdjn6C2DyJt5Op3PckLhM6N4ZPSvQllJBhHbfXkoy3fZBA8JHKYduZQyfoyeSx8Ruzu7keBCtw5wR0XCwEC5UrKr5nr/gs4AtRZwAXJGppJoSL77irzPIkb7D9FbSlqBEXCwk6LU6GIhDhyLufPS6GN7LxRGyKdWAc0MC+l744QwuMc00tP0RdgGXKicBmmFGY4jQQVAg7qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So+ZuelF37xB6DOj4AAJgtUmR/uhTE8wkz9/MPlzaH0=;
 b=c0lnaDfWf+VrhC3tDtvkmUn0XitPoD3xbxHUtxlcJVNXbDdpHEQNlkBXfBNngXY/HnS/6y3CYBOsx6JuZSeOn7b7KUfCwMOkf4n/YdYn+s5V/6cX19eFsgfc5HF8sK1/DlBols/jNMJ6dEiwvWa99LUHIn42fTZx6+0N553ia39bv1dVISmc0tXAxRXU8j5FGOkAav4a9mrVw5KAjWngb19wlonry8tPkH4euu/63hyysghwCyvtOpoTNFfxMLGt89kPM+f8gpSegGaXk/pLAQUR9cb92FKSKx15PFtt3wW+TUknRS+XheHnSWPp8NVDpZvF8NPuFRsie5N2o23f+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So+ZuelF37xB6DOj4AAJgtUmR/uhTE8wkz9/MPlzaH0=;
 b=gbjX+z6p5FQEYvShnq5PR4faTR7SCJtViIEvyk1nq75hNycknZ2wGZKX0L4cL/LCCLQJ3ludBub54sp5E3kDw8Apxh/eynqKS/F40TBHGJ10Jh+hKsxoaxu6tbq2CmRwThzcB40Wz0PLOs43kdM7dEmMUU3PKSlNJYzyCA5k400=
Received: from MN2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:fc::40)
 by BY5PR02MB6851.namprd02.prod.outlook.com (2603:10b6:a03:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 13 Feb
 2020 08:13:14 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MN2PR02CA0027.outlook.office365.com
 (2603:10b6:208:fc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Thu, 13 Feb 2020 08:13:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Thu, 13 Feb 2020 08:13:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29cX-0001pp-3o; Thu, 13 Feb 2020 00:13:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29cS-0000yi-0X; Thu, 13 Feb 2020 00:13:08 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01D8CwUL009191;
        Thu, 13 Feb 2020 00:12:58 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j29cI-0000u9-CS; Thu, 13 Feb 2020 00:12:58 -0800
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
 <8dc57ea5-0868-0707-25a7-4cd6d8a43add@xilinx.com>
 <20200213081139.GG14897@hirez.programming.kicks-ass.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7de2f55d-a5ee-0aae-3b53-ed39d2b7b38a@xilinx.com>
Date:   Thu, 13 Feb 2020 09:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213081139.GG14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(5660300002)(70206006)(70586007)(8936002)(81166006)(66574012)(9786002)(8676002)(6666004)(356004)(4326008)(81156014)(316002)(36756003)(426003)(966005)(336012)(110136005)(7416002)(54906003)(26005)(478600001)(31696002)(44832011)(2616005)(2906002)(31686004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6851;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939ca538-174b-46ff-120a-08d7b05c927a
X-MS-TrafficTypeDiagnostic: BY5PR02MB6851:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR02MB6851E0A6302D3484682CB596C61A0@BY5PR02MB6851.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031257FE13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2auIxPu7R4b9+oO0CaaPI8RQrKUNZnKaIgLQcYucT43Zmn5i1IY/4dSX6DEFr0zqT+zQ3ANOSJDYmM6bhUw15zmWduRhJws3L7QatefiPnsgOozFH5XYpvKRmDR1IFQpfxU+oNoy+uIIEDuVFzJa3OSj47QOuoQY8B1UpQw/fJwnYswAFYRNZlc8mdg0nchxRGUtxgrQ0MuYjv3bJzwbKex8r/TxDHYhssPKemYD9RTAJWN6yq0z5HFB6p9DW9MS9ERkUBzOuPs0BpTID5Mbn53O0JAbQYgi1XXBXFo6eG5BckEq/rftfmomPcz7qLm3ODJrJLJLn07kI8he8hUKd+NfLzPgsixzLObtXRkhqgFBCwMxLlQokMUPS0yaI8VXyFfPIBOsxGaTlVB0NCzn3g7QKvODGMLAkQXUpLBduv26xDGrxyTfRHGtLBrn9+UQS7JA1E1IIDrjdjuCdqBN7dtbmbE/PojwzMw9Bu218L+Oe8TKJnK5vRujLSoNj0Esuk6hmfBuF4LlDQLnjQO9kw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:13:13.5446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939ca538-174b-46ff-120a-08d7b05c927a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 02. 20 9:11, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 08:49:40AM +0100, Michal Simek wrote:
>> On 12. 02. 20 17:08, Peter Zijlstra wrote:
>>> On Wed, Feb 12, 2020 at 04:42:22PM +0100, Michal Simek wrote:
>>>
>>>> Microblaze has 32bit exclusive load/store instructions which should be used
>>>> instead of irq enable/disable. For more information take a look at
>>>> https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug984-vivado-microblaze-ref.pdf
>>>> starting from page 25.
>>>
>>>>  arch/microblaze/include/asm/Kbuild           |   1 -
>>>>  arch/microblaze/include/asm/atomic.h         | 265 ++++++++++++++++++-
>>>>  arch/microblaze/include/asm/bitops.h         | 189 +++++++++++++
>>>>  arch/microblaze/include/asm/cmpxchg.h        |  87 ++++++
>>>>  arch/microblaze/include/asm/cpuinfo.h        |   2 +-
>>>>  arch/microblaze/include/asm/pgtable.h        |  19 +-
>>>>  arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++
>>>>  arch/microblaze/include/asm/spinlock_types.h |  25 ++
>>>>  arch/microblaze/kernel/cpu/cache.c           | 154 ++++++-----
>>>>  arch/microblaze/kernel/cpu/cpuinfo.c         |  38 ++-
>>>>  arch/microblaze/kernel/cpu/mb.c              | 207 ++++++++-------
>>>>  arch/microblaze/kernel/timer.c               |   2 +-
>>>>  arch/microblaze/mm/consistent.c              |   8 +-
>>>>  13 files changed, 1040 insertions(+), 197 deletions(-)
>>>>  create mode 100644 arch/microblaze/include/asm/bitops.h
>>>>  create mode 100644 arch/microblaze/include/asm/spinlock.h
>>>>  create mode 100644 arch/microblaze/include/asm/spinlock_types.h
>>>
>>> I'm missing asm/barrier.h
>>
>> This has been sent in previous patchset. Link was in this email.
> 
> lkml.org link, please don't use them. The kernel.org links (example
> below) have the Message-Id in them, which allows me to search for them
> in my local storage without having to use a web browser.
> 
> You mean this one, right?
> 
>   https://lkml.kernel.org/r/be707feb95d65b44435a0d9de946192f1fef30c6.1581497860.git.michal.simek@xilinx.com
> 
> So the PDF says this is a completion barrier, needed for DMA. This is a
> very expensive option for smp_mb(), but if it is all you have and is
> required, then yes, that should do.

Yes that's the one.

Thanks,
Michal



Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECA5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEAC217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="be4yle3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgBMInr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:43:47 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:51710
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMInr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:43:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0SaHEqw5z3+8UrtA/LoHDrIZIydAGvblq4Igpl9DRHafkhMec0CVHJvRwzsrIbOjaZ8SX0waqk35Q6d5H/99bSQCXZo7Y5xwwwD62IOwb8eOLqqfDZ7binXNGUpIw+5G8moBXzfTS2SGnjVl6jBvGybMdxUXzF3173fLnB2KJOIQzQZG4LLF1gVpGtfQS3APyTIwkitpBbMRYRG6pRa21FrOJ1uZYrnCAg33Xd24Iu/i2Kgl/kzVc3pyyprSyMVw/FMWhC1Vi6OfPmuTf6vNdnX//0TNOTQOJUzkEaSAzT2yPMgw2sk9CbMJT3R1jagVwrePVKSRc5xsL2rvV/tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXNhmnWF48lYQU6Klqv7Ry1mzvTlKQ5idXWAfRD1C7A=;
 b=UyxH5x7eeR4OBeUyfMIxgTcw2meRU0ombUdcImk8FFfTUVKo1LIxrSDlxJruoI67uiTqGoCvpCYNtlo78RqDvKyjJBzkQrdeKDFyXxGmR6hhDEQz7KNxDRVwe3UU0s8DwjjvF+APp+NERDyOttNUV6xd6wWPdd1bH55qUTCJ1pAKIdmhg0Odd/YVCzCrmS85BPmA9dq1EgLnAPMRa/EnXwCh0SES+2FOto5ZbZFG5H3P2KbdVOAXENM1ouULiq+vtsNH//nEK36Hzt56SHmqV7uAEtKHgJJsTOHTIWZ7WrAw0vlqSM+3v0E/3FYl5G7oZufcYrUTSGKchRK/OWv7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXNhmnWF48lYQU6Klqv7Ry1mzvTlKQ5idXWAfRD1C7A=;
 b=be4yle3YuujAw6SDm2v3aMQj8WGIh5qrLE5wSfJJ++wEnuTaeH1ib+P6AxNZW8q+b4a6T2DbD+ryxpwec/4E+zG5Z6BaiO9ZpOAhJMpvYUEMdc8ltayEuHjfpV+1MzAcnH4FKRhCkIeULJ827n+/tFcqKurBvHm+q9kBLOxWJhw=
Received: from BN6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:404:5f::25)
 by DM6PR02MB7035.namprd02.prod.outlook.com (2603:10b6:5:25b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Thu, 13 Feb
 2020 08:43:03 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR02CA0039.outlook.office365.com
 (2603:10b6:404:5f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Thu, 13 Feb 2020 08:43:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Thu, 13 Feb 2020 08:43:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j2A5O-0002iu-Uf; Thu, 13 Feb 2020 00:43:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j2A5J-0008WC-RI; Thu, 13 Feb 2020 00:42:57 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01D8gqlV020865;
        Thu, 13 Feb 2020 00:42:52 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j2A5E-0008Uv-1d; Thu, 13 Feb 2020 00:42:52 -0800
Subject: Re: [PATCH 3/7] microblaze: Define SMP safe bit operations
To:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
 <20200212155309.GA14973@hirez.programming.kicks-ass.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <cd4c6117-bc61-620c-8477-44df6e51d7b8@xilinx.com>
Date:   Thu, 13 Feb 2020 09:42:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212155309.GA14973@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(186003)(26005)(110136005)(356004)(54906003)(316002)(6666004)(4326008)(36756003)(426003)(5660300002)(2616005)(336012)(44832011)(478600001)(31696002)(81166006)(81156014)(8676002)(9786002)(8936002)(2906002)(31686004)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB7035;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8312dd5d-d76c-4095-4ec7-08d7b060bd3c
X-MS-TrafficTypeDiagnostic: DM6PR02MB7035:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR02MB7035719EFE98DB669B5C8E4DC61A0@DM6PR02MB7035.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031257FE13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoKtdMFz82wT/WNthEgTpJKW0vUCcy3KGgRh8+VclBVQtmVer5iZWRWWCwMpY07CaYa1PthuPW16iybXKl3qwsy4pFSZ4S1jRzy25zgoAgKyD2Jax+MWVaIOcOvpSVLyrR8eVwcGpHZZcJeZabmeCgQS+MJYX0zM2Kjjg/h5IrQK8yLdtm9bZdL+BffCr3jeXuGrHU1BI/q1OC/2p1bHu4QnqLNDue5ymJ8BN5qBxEjoxfRjl6Z7ww23EEtLpBiGM8o1L+ROLhQX4dM4a6MkaJn6sqLfHESc1WF530oxU4RJwkDf6GygzcMUgQzMqKKLb1tM13RbZljou11kgyx8UbmI4ucHQU8PQg1cl9dLXe+uwSHCDb2go7Cc7MyND8rSjHKQP+Cz6RYJ52SFTs6rwpycRBmtsrjyqukVXLGvqM1vJj5Y/ktdD/u/Wg9EsaoU
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:43:03.3288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8312dd5d-d76c-4095-4ec7-08d7b060bd3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 16:53, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 04:42:25PM +0100, Michal Simek wrote:
>> From: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>
>> For SMP based system there is a need to have proper bit operations.
>> Microblaze is using exclusive load and store instructions.
>>
>> Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
>> +/*
>> + * clear_bit doesn't imply a memory barrier
>> + */
>> +#define smp_mb__before_clear_bit()	smp_mb()
>> +#define smp_mb__after_clear_bit()	smp_mb()
> 
> These macros no longer exist.

ok. Easy to remove.

> 
> Also, might I draw your attention to:
> 
>   include/asm-generic/bitops/atomic.h
> 
> This being a ll/sc arch, I'm thinking that if you do your atomic_t
> implementation right, the generic atomic bitop code should be near
> optimal.
> 

Based on my look it looks like that I can replace implementations in
this file by sourcing which will be using atomic operations.

#include <asm-generic/bitops/atomic.h>
#include <asm-generic/bitops/lock.h>

Correct?

Would be good to run any testsuite to prove that all operations works as
expected. Is there any testsuite I can use to confirm it?

Thanks,
Michal

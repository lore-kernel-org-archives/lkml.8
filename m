Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8322C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D942168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N+UTdaeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgBMHvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:51:52 -0500
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:15428
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729735AbgBMHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:51:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZL7VPwFdlXFdNpNi4P67ffdhN+ik8fKy3Vn+ruZrMvWjuHvRR6ouGBqK9hyrglC3ZOUw7k1YwV5iIqPa5sNLF5SdeZYdl9I8/nPz4LtUPfCh5Y3GyJLypz+yRb3mifyF/SO8d2UVLM3AnKwK6g+XZNHG3TpQyE7ixgPdtaj4W6oA9yqebemcHyQmijvLChaBPMI2l+1wg9B1m44YgQEE8Isx8JiRx4XWriX+xd0moe3j0LcyWGilk9agjUpt1DKnSLLoNtBWxb1CUULCr7/md1iQZyqKjYRCQR82RhrXvan6QLIOrVzO243lP2QqnKAHaGOfu90MDKcQrOi3pZ5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+ZCNapIV+7WWEBW0pDcBXQwu+X0ngqo5x2U67zMfSE=;
 b=U37SKz7vwLe76rllDonCOsIEpk5maE2fSo4DbZzf7XaQvYaXSMTVJ16XKqrBUrRHE4jcgFVFkta0f5hrVtBOepWgZB8QzcldF6U3eByGFTM6jRZ0b7lwnaKqsSioti36YpMpuDueTurr8ZMvz1UJxTEAqiE1rXw1fJLWdOk6Pcm3HcxMrDvTWFX8LQcD0cWqZJL2YQ0uBXaJagUQywefY3bAYlakaYLUtUBiyx4E2dLn/qAu0jdLp2nIch92hQ8HuHCXU3+DrflZ2mcdmybIckqp2jXECIf3YbZkLyldC6csdR4BvfvcBdOD7DNO5xPfnXMGIfblauj/XqGEcCJXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+ZCNapIV+7WWEBW0pDcBXQwu+X0ngqo5x2U67zMfSE=;
 b=N+UTdaeJ1HPdAv/vVF59wOc5Cuj1QKU9MCgTnIDpgZ5qYNJmmeadRdyaj5OgWgFJsQjV91z+/vzPdD6DGzz8DoXcS41wvVogoAqdUOx7aLMMjdz5rl/jpzDOwsS79eqb/Bo2tCPG/5m8n9IvSBeiGRY6pk0DWOFjohk/n5BaHYg=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by CY4PR02MB3383.namprd02.prod.outlook.com (2603:10b6:910:7f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Thu, 13 Feb
 2020 07:51:48 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Thu, 13 Feb 2020 07:51:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Thu, 13 Feb 2020 07:51:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29Hn-0001DP-SW; Wed, 12 Feb 2020 23:51:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29Hi-0000vM-PM; Wed, 12 Feb 2020 23:51:42 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01D7pfBq031167;
        Wed, 12 Feb 2020 23:51:41 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j29Hg-0000uy-SI; Wed, 12 Feb 2020 23:51:41 -0800
Subject: Re: [PATCH 6/7] microblaze: Implement architecture spinlock
To:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ed53474e9ca6736353afd10ebe7ea98e4c6c459e.1581522136.git.michal.simek@xilinx.com>
 <20200212154756.GY14897@hirez.programming.kicks-ass.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5315513c-2492-6bb7-2961-b249851b2051@xilinx.com>
Date:   Thu, 13 Feb 2020 08:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212154756.GY14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(81156014)(8676002)(4326008)(81166006)(31696002)(8936002)(2906002)(36756003)(9786002)(44832011)(336012)(2616005)(426003)(54906003)(26005)(31686004)(186003)(478600001)(6666004)(110136005)(356004)(5660300002)(70586007)(70206006)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3383;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9e8892-6f34-4d2d-b7b3-08d7b0599460
X-MS-TrafficTypeDiagnostic: CY4PR02MB3383:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR02MB338303E9F2F83595C7F53CF5C61A0@CY4PR02MB3383.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031257FE13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcUNaYSqUWeHHpq3u0wHj8A2YU+67JDpAnOEIMD0CWia2/981mHCZMxzjm2pyeKmyMfC4bt7ggMMEVCYe2fACr3qXnolvFS78iRsNws+SQaTZ4IBzwS+WTXcCQli5OgHTCrMaIXg+QEZ0bTZKWKAPzUrp9TbWbNNm0iNJXXSpxRub0RdC3/l9a5oHv01MsVbMiyD+uQxk7CjDEhGrZbM33OPb14ZCrporPACHVPIjI3Xa07g5TxJiJSnn+xPIy7h5xQ88ynqGxbKvQbUO9JI91WYiY+Y6sUmGC4t21pFxBezT/qJUpFq4w47yn644xLj00dPYYG0JHhX2aUo2EPMfZ1k4+PU8k0Zw426z8wDUjevsTYmaCJlbfrOZmSH4MsVziVs/kWQbYogNTs3dY5PaPWi39H5OqDCdaUi05Sh9pOZmZTYRpgt0QKCSi/D86RV
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 07:51:48.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9e8892-6f34-4d2d-b7b3-08d7b0599460
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 16:47, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 04:42:28PM +0100, Michal Simek wrote:
>> From: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>
>> Using exclusive loads/stores to implement spinlocks which can be used on
>> SMP systems.
>>
>> Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++++
>>  arch/microblaze/include/asm/spinlock_types.h |  25 ++
>>  2 files changed, 265 insertions(+)
>>  create mode 100644 arch/microblaze/include/asm/spinlock.h
>>  create mode 100644 arch/microblaze/include/asm/spinlock_types.h
>>
>> diff --git a/arch/microblaze/include/asm/spinlock.h b/arch/microblaze/include/asm/spinlock.h
>> new file mode 100644
>> index 000000000000..0199ea9f7f0f
>> --- /dev/null
>> +++ b/arch/microblaze/include/asm/spinlock.h
>> @@ -0,0 +1,240 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2013-2020 Xilinx, Inc.
>> + */
>> +
>> +#ifndef _ASM_MICROBLAZE_SPINLOCK_H
>> +#define _ASM_MICROBLAZE_SPINLOCK_H
>> +
>> +/*
>> + * Unlocked value: 0
>> + * Locked value: 1
>> + */
>> +#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
>> +
>> +static inline void arch_spin_lock(arch_spinlock_t *lock)
>> +{
>> +	unsigned long tmp;
>> +
>> +	__asm__ __volatile__ (
>> +		/* load conditional address in %1 to %0 */
>> +		"1:	lwx	 %0, %1, r0;\n"
>> +		/* not zero? try again */
>> +		"	bnei	%0, 1b;\n"
>> +		/* increment lock by 1 */
>> +		"	addi	%0, r0, 1;\n"
>> +		/* attempt store */
>> +		"	swx	%0, %1, r0;\n"
>> +		/* checking msr carry flag */
>> +		"	addic	%0, r0, 0;\n"
>> +		/* store failed (MSR[C] set)? try again */
>> +		"	bnei	%0, 1b;\n"
>> +		/* Outputs: temp variable for load result */
>> +		: "=&r" (tmp)
>> +		/* Inputs: lock address */
>> +		: "r" (&lock->lock)
>> +		: "cc", "memory"
>> +	);
>> +}
> 
> That's a test-and-set spinlock if I read it correctly. Why? that's the
> worst possible spinlock implementation possible.

This was written by Stefan and it is aligned with recommended
implementation. What other options do we have?

Thanks,
Michal



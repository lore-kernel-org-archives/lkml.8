Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A3FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0A82073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XCIJENYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgBMIGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:06:45 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:17538
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:06:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2rYGNVdkt7x3KvWpKOFQmYubvsVSxD1dIs5W7m5bjgofbhjNz7XpUD7hvWu7QgIaIYe0DO9ht0eccDWLQcaGHrxsogy82H82knQcT7smPKcpbFDE9qtzC9OwfwRy/jOr0O3wKP+S0akpuO5Qxzhg5CL2Why60QEQ8ar3uLss7wSieDW7na3xwOr7DcC2IKTkpY3SefrPetzrRdYMDweqtDsXSsGLwc+4QsVNmDXKvRI7TdA5lHYDgVZCqeoDFM6jgrofzWEhBd9Ls5mxOzUnGpO1D2vHtJGlJo/r3llg+XY28Yj0FcBFJBQEF1TqjTtdfg1K2ZuRaL1EqfnI8nQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT8u7vKpEZ5KWq/hLMTqyW8BxZVsyAriEXSrXONzPTg=;
 b=mrQAjK4Id3B1FUXhcR5cek6wtPXSlDZIoTLeHhbEBgPdHTRlJ045GWqbondHrzeJ+MpCa73S3Y5v/Kb5FvOYRazf4mTYMAEGLBGTWQJqzYOCtaoHizcB08ky7W5RobjpLbbjwdsiTizrABFIRSnlnvfyXuoTZ0RayLIXfY/hSbfpjcnyE+zRctQHd1QRoZ1GiWG18/hc4EelNpwU1ddKGB3OyF+FPGW5VN35dgv3gk2OHezUGQHx1CQBqXdPYJFhtmz3pHDydEwbG4CUtxMhgXTGNnJ/ioKjEensBA9VGQYWAVzfkJLTDiYLVIj6xUxYmKgjWBrM3W6mfLlSukc83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT8u7vKpEZ5KWq/hLMTqyW8BxZVsyAriEXSrXONzPTg=;
 b=XCIJENYUeE7Bw3zwUs537FTb4dK15DujnCcAhR9LWEnatCAvTMNqhYRBxAiCrDhuOrh9EsdEZQyO240W30y+4XnpAognVayLS0QGQFqeWV1cEbqcjPBCYmDBbYu38g4m7rsu9dsNU2sC7vaMvyfg6+OGtqb/wS0kL/l4+9C57eg=
Received: from BN7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:20::23)
 by SN6PR02MB4367.namprd02.prod.outlook.com (2603:10b6:805:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 13 Feb
 2020 08:06:42 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN7PR02CA0010.outlook.office365.com
 (2603:10b6:408:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Thu, 13 Feb 2020 08:06:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Thu, 13 Feb 2020 08:06:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29WD-0001ee-RO; Thu, 13 Feb 2020 00:06:41 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j29W8-0006gm-OI; Thu, 13 Feb 2020 00:06:36 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01D86RFI004960;
        Thu, 13 Feb 2020 00:06:27 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j29Vz-0006dm-6t; Thu, 13 Feb 2020 00:06:27 -0800
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
To:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
Date:   Thu, 13 Feb 2020 09:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212155500.GB14973@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(4326008)(8676002)(54906003)(316002)(70206006)(70586007)(31686004)(356004)(81156014)(110136005)(8936002)(81166006)(6666004)(31696002)(44832011)(426003)(478600001)(336012)(2616005)(26005)(186003)(5660300002)(2906002)(9786002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4367;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f62ad0c-4b03-4a92-bf20-08d7b05ba940
X-MS-TrafficTypeDiagnostic: SN6PR02MB4367:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB4367696494A17ACF19ED579DC61A0@SN6PR02MB4367.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031257FE13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdrZG66Lq4h+LyY1v7q8AWLnKeqMiG8anxvMgBJ+lZlKo04plOiRObtbtNVneqXgb+2/4akFcW/MCOFJo6KvWJWP3Zvp+P0dQCFj9StIOfmdAWnMhUxaf7IpEdZ3FPQ5x/LDDW1bqzrawU9FBSr860SCjsWOfP0GUwHfsAsUCVSdPJ75VrmKHIKfXViLPm2MDm5UqKVdYqQrj7WuG4x0Q82zqYNKLSgISI2o6Wfb/W1CUUM2HDC4utQaqSJGRKTGzOCmNN9FUoF1TIbGYa71v2dnxPg2fWe51zJY89AJTCD2TDwvnS4hgrh2QCmK9RL10eoy1f9duLi/jHA0ABCfwA8Dq36vktuaUHsglxBXmCN4JvETAVY2BioY36bKRLQZBnTdEMflAp6MsnKnTXMJ1ArXmU+ydN9nUAg4u9gZEyo7SELdkKcN9bR1j2PBNpk3
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:06:42.2598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f62ad0c-4b03-4a92-bf20-08d7b05ba940
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 16:55, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 04:42:29PM +0100, Michal Simek wrote:
>> From: Stefan Asserhall load and store <stefan.asserhall@xilinx.com>
>>
>> Implement SMP aware atomic operations.
>>
>> Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/microblaze/include/asm/atomic.h | 265 +++++++++++++++++++++++++--
>>  1 file changed, 253 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/microblaze/include/asm/atomic.h b/arch/microblaze/include/asm/atomic.h
>> index 41e9aff23a62..522d704fad63 100644
>> --- a/arch/microblaze/include/asm/atomic.h
>> +++ b/arch/microblaze/include/asm/atomic.h
>> @@ -1,28 +1,269 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2013-2020 Xilinx, Inc.
>> + */
>> +
>>  #ifndef _ASM_MICROBLAZE_ATOMIC_H
>>  #define _ASM_MICROBLAZE_ATOMIC_H
>>  
>> +#include <linux/types.h>
>>  #include <asm/cmpxchg.h>
>> -#include <asm-generic/atomic.h>
>> -#include <asm-generic/atomic64.h>
>> +
>> +#define ATOMIC_INIT(i)	{ (i) }
>> +
>> +#define atomic_read(v)	READ_ONCE((v)->counter)
>> +
>> +static inline void atomic_set(atomic_t *v, int i)
>> +{
>> +	int result, tmp;
>> +
>> +	__asm__ __volatile__ (
>> +		/* load conditional address in %2 to %0 */
>> +		"1:	lwx	%0, %2, r0;\n"
>> +		/* attempt store */
>> +		"	swx	%3, %2, r0;\n"
>> +		/* checking msr carry flag */
>> +		"	addic	%1, r0, 0;\n"
>> +		/* store failed (MSR[C] set)? try again */
>> +		"	bnei	%1, 1b;\n"
>> +		/* Outputs: result value */
>> +		: "=&r" (result), "=&r" (tmp)
>> +		/* Inputs: counter address */
>> +		: "r" (&v->counter), "r" (i)
>> +		: "cc", "memory"
>> +	);
>> +}
>> +#define atomic_set	atomic_set
> 
> Uuuuhh.. *what* ?!?
> 
> Are you telling me your LL/SC implementation is so bugger that
> atomic_set() being a WRITE_ONCE() does not in fact work?

Just keep in your mind that this code was written long time ago and
there could be a lot of things/technique used at that time by IIRC
powerpc and I hope that review process will fix these things and I
really appreciation your comments.

Stefan is the right person to say if we really need to use exclusive
loads/stores instructions or use what I see in include/linux/compiler.h.

Please correct me if I am wrong.
WRITE_ONCE is __write_once_size which is normal write in C which I
expect will be converted in asm to non exclusive writes. And barrier is
called only for cases above 8bytes.

READ_ONCE is normal read follow by barrier all the time.

Also is there any testsuite I should run to verify all these atomics
operations? That would really help but I haven't seen any tool (but also
didn't try hard to find it out).

Thanks,
Michal






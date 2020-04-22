Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBADD20747
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="OH3hLSAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDVC4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:56:18 -0400
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:7394
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgDVC4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDvgiXDiXnZR9FQ33vFW4M/2WZe7R4lhjJuJ1W2jfMBAwXtzsfLZUzX79UzcN9ryZBq8uKZhGMjCv/fE2B3LpqDR8U3awiF8Nvkrh5QXcsXULZUjsAz1hrJCBPngAYPG+OXXmGgUE65w1SEgOW7myoZdRtN1yalj7eQC4NIz4bcHT+PCyNXdUwqX9PMpGsGQ1noCtjp9JLtwFkzzVM/weRtVMIN0S4VSTt51Bbf/NHqL289hK6H46uEmhvee4RvSSvCF78wsGn2B/77OSmMaFaoB+vHODeCAgSeeCIVi+ia9GTRkibHwyT5g5aUH5EtlbzVtKlLgS7cw6GBORLT/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PKSVpCDFhaUFa0QKb7+uLvKwAfwWP736ftI562lwfM=;
 b=oNvGFhcZ5pTIW3D2Qw+F1s/KD8acox7yC5hk7nMt80BXUviuQXGzBvTibICtJ/TbmSt9QnOvzZT3sbvf11m0cTwlKtUvSBrf/wYSgpkulsJm7yqzySznBDeZ+U8vXVKwT9JMoF3MrVZRdp9PXoWjPpY6BlYnykrDNpyZxIX+19R+QnofBVIb5l0elT54BeIm2OPF6Ifv6/hlOrFCuc61fEA6judZ6Oow2zKlgB+eocALtUWUwTq2TNY6f0m4gv37n80RXB8erC69QSrASr3AU30ozjm3REuf+z4SB4Yb148Mlo2PpMs1cgMqDbp6+FoVv748EmMaI4oqaJFOEVesbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PKSVpCDFhaUFa0QKb7+uLvKwAfwWP736ftI562lwfM=;
 b=OH3hLSAx+r0TqCEnKK3oAPK7zCKFEGsv2fP4ea1U4qR1938iNuIKp5xiwTWaJbQtllPAllvCQGeP77AFAwEneS5txNdRy7Uopg4WzDoK+IBJO7U+O/bV28nAgXEWWLSykmE1ekJfVpKzkVZnLsVUtfFrcDw8SaLolmD3BoRQ5Js=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiping.Ma2@windriver.com; 
Received: from CH2PR11MB4215.namprd11.prod.outlook.com (2603:10b6:610:3b::26)
 by CH2PR11MB4405.namprd11.prod.outlook.com (2603:10b6:610:49::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 02:56:15 +0000
Received: from CH2PR11MB4215.namprd11.prod.outlook.com
 ([fe80::48e7:73e7:ca6d:c32a]) by CH2PR11MB4215.namprd11.prod.outlook.com
 ([fe80::48e7:73e7:ca6d:c32a%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 02:56:15 +0000
Subject: Re: [PATCH] Perf: support to unwind userspace application stacks
 generated with thumb.
To:     Will Deacon <will@kernel.org>
Cc:     will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200416053829.130395-1-jiping.ma2@windriver.com>
 <20200416071023.GB29742@willie-the-truck>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <01029876-e167-a1ba-cb1a-d97adf23dde4@windriver.com>
Date:   Wed, 22 Apr 2020 10:56:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <20200416071023.GB29742@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To CH2PR11MB4215.namprd11.prod.outlook.com
 (2603:10b6:610:3b::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK0PR03CA0101.apcprd03.prod.outlook.com (2603:1096:203:b0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 02:56:11 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79d49b77-4e84-472c-3cc9-08d7e668b90b
X-MS-TrafficTypeDiagnostic: CH2PR11MB4405:
X-Microsoft-Antispam-PRVS: <CH2PR11MB440581C7DCCB0D6335EC32C6D8D20@CH2PR11MB4405.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(39850400004)(136003)(186003)(6916009)(16526019)(52116002)(8936002)(31686004)(5660300002)(6706004)(81156014)(7416002)(478600001)(16576012)(36756003)(53546011)(316002)(26005)(6486002)(2906002)(31696002)(2616005)(86362001)(956004)(66476007)(66946007)(4326008)(6666004)(66556008)(8676002)(78286006);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfFrwoZry+XIuLYqsD2v4NhoDEbC5IvUsjeyA8S/ushAO5NT4iWrkyi7B8NewmGs7Wkno1Q7VA7DteSU2gLDZdvVMRwe3ZU8Y/DWJO/oKT+XZybnov1byvBNu7b+HGxxMLqx46eoyrFxrqD/oe6f56hQP/4ubeSLZtXIAvzJogQPRR+pu5wHry2amgbH4XKAh07yWA5FFwhRXlDTyT4HJl4oOKwQlX8R0NsPQFHW/iI2UEJZMb5vbnAZDTFs3L2E31hUT2Dni5NxwDFHZaFA9Mn5AozQFjlvMjXB5y+fDsRFQxQ/fd+PM0aBVZCx8v4a9Uxfe8lzo7uaqGejCT0NG64z5gWId9sFdQUFhRm3DPdRopWzI3RuEXyyICiS+gWGJJEbH7fjrJFXiyz7E8af0J0cCv5UIq7D6PXPucZqYXGE5bepaNtXx0oUc/oQLGQ0Mxl/mf2k93I5wEryDClFVzETC/qb96s9LRric6gkCIeFjP2ypoGBeGC8GyzCs2CCxFZNTH4JFwoE7NqGXOWEen7UldLzzQDI2GoPczcUx7M=
X-MS-Exchange-AntiSpam-MessageData: 30USma/y8NIsQ9BQE6ApAq5txw4P5XafuPVCDYJH8u/ne+zjFpVEJDYalNZjSYYcctq1/YZCHvqACJx2hYBbLdUBBm8qW3BxOf8RfeuAAgNVF0KFtjle+24/9V4XTzUgQoOWWiXqZ0VJkBtbkn7RmA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d49b77-4e84-472c-3cc9-08d7e668b90b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 02:56:15.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Q6dKUVOQMChtcKwnm/K7TPmNy10JHYY8D1fEr2gPxTzZtHZBDcuIOX3CyxmORW3sN2+bUn7+Qfqwi0ZetBN0HTpJQbgE0F73xUbfj4gMu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/16/2020 03:10 PM, Will Deacon wrote:
> On Thu, Apr 16, 2020 at 01:38:29PM +0800, Jiping Ma wrote:
>> Only push sp and lr in the stack for thumb mode. it will go
>> through the stack find sp and lr.
>>
>> Change this to the more detailed description of the patch
>>
>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>> ---
>>   arch/arm64/kernel/perf_callchain.c | 36 +++++++++++++++++++++++++++---
>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
>> index bcafd7dcfe8b..97dde271c121 100644
>> --- a/arch/arm64/kernel/perf_callchain.c
>> +++ b/arch/arm64/kernel/perf_callchain.c
>> @@ -104,6 +104,30 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
>>   
>>   	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
>>   }
>> +
>> +void
>> +user_backtrace_thumb(struct perf_callchain_entry_ctx *entry,
>> +		     struct pt_regs *regs)
>> +{
>> +	u32 sp;
>> +	u32 *sp_t;
>> +	/*
>> +	 * Only push sp, lr to stack.
>> +	 */
>> +	for (sp = regs->compat_sp; (sp < current->mm->start_stack) &&
>> +		(entry->nr < entry->max_stack); sp += 4) {
>> +		sp_t = (u32 *)(unsigned long)sp;
>> +		if ((*sp_t > regs->compat_sp) &&
>> +			(*sp_t < current->mm->start_stack)) {
>> +			if (*(sp_t + 1) < current->mm->end_code &&
>> +				*(sp_t + 1) > current->mm->start_code) {
>> +				perf_callchain_store(entry,  *(sp_t + 1)-1);
>> +				sp += 4;
>> +			}
>> +		}
>> +	}
>> +}
> This looks like a pile of fragile heuristics to me. Why don't you just use
> libunwind in userspace, the same way you'd have to if you compiled without
> framepointers?
Hi, Will

Could you share more details for libunwind in userspace? Following is 
our build command for test app.
bt_perf.thumb: arm-wrs-linux-gnueabi-gcc -march=armv7ve -mthumb 
-mfpu=neon -mfloat-abi=softfp -mcpu=cortex-a15 
--sysroot=sysroots/cortexa15t2-neon-wrs-linux-gnueabi -O0 -g -ggdb -Wall 
-funwind-tables -fno-omit-frame-pointer -frecord-gcc-switches 
-mapcs-frame bt_perf.c -o bt_perf.thumb

Thanks,
Jiping

>
> Will
>


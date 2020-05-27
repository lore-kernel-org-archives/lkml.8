Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78086C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C85620663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="X8DRUH43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgE0BaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:30:14 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:6123
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgE0BaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:30:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5mcDwlBU1cRh9IT2sHkEism5xWpPHoW3w/RJ6Y9v8szoVbDXhoRWS3YcbYzq16Ygn5fWqpM+T50bwyNtfPesx14dG793pfVOh0Gb5lx0PjWqgmy02B1bnhhMnx9xSrd+BybRjCi8bMRKA2xzefBJnf94/3lpWOMdI3NTw3+xbxsl7ja7QlMiQ5p4WbicE8UMM7VgW6wGISUMBeur0hXBPSdkG9hu4fsj8O0cWLNTiGEY+jRN6SvNCfMi2SLTCOKB/eoYGuyxvXb7ilvMgz4tOlzG1nybicffYx6FbUgpEQV+ViuPkEYlyScUeyZvwTfi++LXdu0spd3aGEZlN2mIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROMvWvbxsEkjpXH1mLOqjn4H+91iWe+L300YMg4/SRM=;
 b=BPKNO/WE9xTtMkPPgpr3QbvUm2dIpSjFUnfEPLc90R9O1yiJFrreKjuzy+wc4sbYcLB7KmAhIT5CFHonNxh0+8IiUo6L5kTeJGbTYTm2Wt0oejLIo2sJ76Ms1oh9abfZyr0maTAkSpHw7VLxEbaekY32NPSV81B56XVS1IAoNTO230MoabNPOsX2VM9qfcflLcIsv34tNbUUEABuD2M4Qb3gRd4N/HGSd5fyuRLemBTFFSUo83uUaIbMKboz22hp1J8QPK9vCbpdzu8Cg4Fa9ZwQLID0GIg4YvkZSse8hdt5fydZTcd/Q13uuTQiMhn60Xz+1FW3BvK2XeBrCurkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROMvWvbxsEkjpXH1mLOqjn4H+91iWe+L300YMg4/SRM=;
 b=X8DRUH43tquFc/WOGPLDPK3fAM+pwshZ74qwRlBUROtYD+Yv+dMrqVGsAu5l+9Nct3Z/dveH2sC2iVD7Rk4ycttF1WANkgeZgcc1XpcFgTepKIlWdZlWlRHHPb1i+bb8N8kYRMrfKoRCSt468qzptueWRtryMLRju5VMNexDDJU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB3932.namprd11.prod.outlook.com (2603:10b6:5:194::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Wed, 27 May 2020 01:30:10 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 01:30:09 +0000
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     zhe.he@windriver.com, bruce.ashfield@gmail.com,
        yue.tao@windriver.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <20200526195419.GB2206@willie-the-truck>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <6ed68001-522c-14f6-d162-e68da4c10e43@windriver.com>
Date:   Wed, 27 May 2020 09:30:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <20200526195419.GB2206@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Wed, 27 May 2020 01:30:06 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a5a4c4-d6c8-40df-a6d1-08d801dd7e8c
X-MS-TrafficTypeDiagnostic: DM6PR11MB3932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB39325C25BA8FF839596D871AD8B10@DM6PR11MB3932.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3QDQSZYlQHByPllvX9gV+jXLXXKmq6KrXiMblUyA/iabNTLHlMDQL4UmrORLVgiQJY6Zx6QAWTRQd/a1aBmX1GfUzCa1AXTwyLe0PF0cBQT/NZQ4bPtoxBhPnLrXRDa6wBMTr8Ju2ok9x2ffAolAYXppi4OiCtV9OxEpIm2ETD5CbQMV1aaafAbs6foPNiKIXBlbbPE1C9ltn4Io6+/Iv/Za4mX7c/p+KASpJs3ZA+m/x6yvW//aHcgAUgVaCLa1+25xQ04kPjLO1mV3cH9R7b2+OBGydEQ4VCFeWdnLHomNerEHQsw4ZDHUfYYr3ZV0q1UUUGMA4IROHzXtSvH5EG+0yf5WQ7e9DE7eMpQSk6i1SKOwDz2gRhRrm6qwXkPjYz61i9TvakIFCBApTnm8yivuEJJdA1tglEoovuIMH+MsX7WnVE64Q5RtofldrXX90l3agfFXQKsJn4gthmfzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(376002)(346002)(39850400004)(6666004)(52116002)(956004)(53546011)(6706004)(31696002)(36756003)(478600001)(2616005)(86362001)(186003)(66556008)(66476007)(16526019)(26005)(6486002)(2906002)(66946007)(8676002)(8936002)(110136005)(4326008)(316002)(31686004)(5660300002)(16576012)(83380400001)(78286006)(15583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +2ie/ai6OsNqTY+uB+HqsRflydhvKYyutADdD1Ra+o3DxekfyLJQhwuA5lnfDECNbuP57DBGIKheJkF1GWOmvoxuWx4Wc17mWRIWSLg6UEl9t66AJtvOJUzbYKst8N/8U9olHhXDWnFDNeS8WZgxw8HDJbHLd1O8ZZ30t89x5xaQi/Rip+4kR5/uAqGC6f0JH94QJO/ORgnF1CJhmD7DUvXR7NTT43gxntAsl9qo3oLPAW9Fvk4BSethQyqfFkFHoRiwj8PHi8kymo2yh3qRLV+HJ2Oxi02afoY4VQzCfSFf/lQjJulh+/QKNazUPTs5jKGRakhiFBjFSz3wckRS9mEJgr0ftIiiveMvbWwFT0khUvzi0RZAhKwFWGdQ1j0jYBVcz9cjydVwYLnAiL7IRbLAQNbm+uH4BHmwXKTWJZR1JQg3sy4Oy6w+2ypQPrtQ1UwQraV3O7eellGpyun6Xrorkf7RlIkQ3/OUz8tFqT0=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a5a4c4-d6c8-40df-a6d1-08d801dd7e8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 01:30:09.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1an08Cbpk20Z8OJ0fKkObtv3MXx6nfZF6n8FVvUcsFMZVQjKDlKVj0aYDFTHWZyVUmd+oYo2d5EdxS7pdE/4oLLD5LWmkzfMHTT20tprsWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/27/2020 03:54 AM, Will Deacon wrote:
> On Tue, May 26, 2020 at 11:26:11AM +0100, Mark Rutland wrote:
>> On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
>>> Modified the patch subject and the change description.
>>>
>>> PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
>>> is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
>>> that perf can not parser the backtrace of app with dwarf mode in the
>>> 32bit system and 64bit kernel.
>>>
>>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>> Thanks for this.
>>
>>
>>> ---
>>>   arch/arm64/kernel/perf_regs.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
>>> index 0bbac61..0ef2880 100644
>>> --- a/arch/arm64/kernel/perf_regs.c
>>> +++ b/arch/arm64/kernel/perf_regs.c
>>> @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>>   	if ((u32)idx == PERF_REG_ARM64_PC)
>>>   		return regs->pc;
>>>   
>>> +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
>>> +		&& idx == 15)
>>> +		return regs->pc;
>> I think there are some more issues here, and we may need a more
>> substantial rework. For a compat thread, we always expose
>> PERF_SAMPLE_REGS_ABI_32 via per_reg_abi(), but for some reason
>> perf_reg_value() also munges the compat SP/LR into their ARM64
>> equivalents, which don't exist in the 32-bit sample ABI. We also don't
>> zero the regs that don't exist in 32-bit (including the aliasing PC).
> I think this was for the case where you have a 64-bit perf profiling a
> 32-bit task, and it was passing the registers off to libunwind. Won't that
> break if we follow your suggestion?
Yes, it is for 64-bit perf profiling a 32-bit task, not for a compat thread.

>
> Will
>


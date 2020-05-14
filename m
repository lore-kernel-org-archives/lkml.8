Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D750CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20F420722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZBVfpBsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgENTET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:04:19 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:32583
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727795AbgENTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:04:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGtlbk6UjEkWuEFv0rZDY+PgtHyTb40K08vce9tMt9LfzagMxN+h7pA/9wE78UMKaQVWybGU6TPBBeWidABuLZcPz+dJSw2u/nB+GX/YrXFX8yOvv+cAdHG4BQ8fPzzFHyxExiOFm4mqmk6TbyT3zKiLA1xG+xbwbpcjys/7JUaDA98Qxll1dcPGk61PJ2Er25EUeaPAXZCE2REI1B4wJa7wWX/KznXCOJZ47PtUqRoxuI0kkDEUSTGOV8tMuANfzpkPzQAPyjps1rTvd4iOrfABPlqy5gCYDfDm8PtjmgkbzkgZt4cFJ9PV8Nnh9EW0hFRuToj2KP54MEzRsOhc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itaESPmLfNPswnzVpu4uS/VcQJUH4NGgQkZ87ROpp/0=;
 b=aR6F7hZ2rbMwCX2Kxa3M5Owc4Ppncq6Cg/s+nzZ/aQugXTnx6nA+0LzRVspnsnJNVjegZMkSrMkP/yVcAhFH1ZEUrMjbpoM1KwUgfOxgBnsdUvvBmdyuDw+ju/Wu8Vi0uUySCw2+3YufJZV0KyDi5PTiynxInz8S2LEHQzcMNpuK+dd1F00fLIA4cvdTA74UxyQL/i/G8c5+Z/j4t7GE798BbH4VxIlQ/vzxYsNqK8jf0zZu4lM5uF1CPnk8a+zea+xnhzwRFMvBdhTkZzOWH0UKt8pXmdmTh/I36MGSOv14Xq2APMsSxcbKI3V2v6QSILOb4oSv0z3gGuRMwezg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itaESPmLfNPswnzVpu4uS/VcQJUH4NGgQkZ87ROpp/0=;
 b=ZBVfpBsYx2S6a/WRLqvR/aksRpQ3eFS59MTAu54j8DkUxlY4953hYuGf8lpRvrwNtt0CA2WRQohKbkA2vhpPo/xE/UImmfBwjmzm+UDifJcRs/8l5YdDMqpWfzQ/MytYL6EV2ALr1hu49+BalZCGSXBOrxbmFS8YKTSRQTVjBe4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 19:04:08 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 19:04:08 +0000
Subject: RE: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <3a9c21e1b8108094d9132ca0c0271e8c7b93c847.1588808538.git.reinette.chatre@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <eefd2231-cdbe-1250-3069-bb9204c940c1@amd.com>
Date:   Thu, 14 May 2020 14:04:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <3a9c21e1b8108094d9132ca0c0271e8c7b93c847.1588808538.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN6PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.5 via Frontend Transport; Thu, 14 May 2020 19:04:07 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dc0a806-a6e8-40f1-aa2c-08d7f839947b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2558012D0D02D834A947A4D895BC0@SN1PR12MB2558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dg7fBRPRN1xvFbgmQPLYj4XtEYU2dejBwZvyEqVyYE54Y3uvPoQUxk9y60Sa/cW56cL56PnCqYnH4+B+7DdED/bhwWSvPuuIhO/yITimk80727mrESFfVXatIz/ljNlpvANFHpr0dFA0jjeb2bA6Z1gfr2QkV7tj06Zyvm2XNBDF6jeRw66XTbo7QoRGDB0L2jjIf2m4t9NpZJ0mSw3X9o4QfC58K/+HUqQerkEZAZJgIAIyTETTev4prjZlV5h0JAJ2GHLATVkZ+TCuzMLGgTbmfZhlf/bXPr9UqtmjE9Dw7+aI/dThhJFhqTGZ84mfrV/dJRv00pepWsY8TTthXMQl4fuMOyeVEvMQu/f2eIGsQcwTHUWkof9lZi+37u3S4wGJJTfoE+mETJ0r8lS9oFMNzveEBaqSFbXc4TrkGQLm7WJMKGSY01M09Rs0mwwj6wDpkVHH2FXjxqP8z7EgrTttCxB9C88K2PUxUOmgtXlLZMLgqqkq/wj7Xu7RTztI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(16576012)(4326008)(52116002)(316002)(66476007)(110136005)(66946007)(66556008)(6486002)(54906003)(86362001)(7416002)(31696002)(36756003)(53546011)(8676002)(8936002)(2616005)(956004)(2906002)(186003)(6666004)(31686004)(478600001)(16526019)(5660300002)(44832011)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fcSp5JAp2yzGOVEyXoTCCc8ojg9mj7EgnComtIHmLAF/jjn925x5sJdB59ieobAOC+azVu9KZvZalFBSVDl8b88HLeUGkVBaBEB0Y6YxGDPiD5JacAh6BsIe4DbfTY4aL3Gr60EIcWMYftc2bZa1dI74Vsgqslz/V8AgssexE61MeUKuLsVqBZDel3+zMluNWNGTAaeSuwCmB07x8fQ6ClRJorAMqPq6m6Ke48Wrxzt+uMh+1v+m83AJD6cE0yJuNFqDzljGNvvfHPaVRhLP21toG0Fmy/CVNld4wd4Ssmp7cI6GCE03M6x09tKyNNJ1ykdi9058E7cVeqeizBwaL6Xw9EcHpP23fXf2Po75YTQGXvLe/u3SdyTsK7U6ijhkcobsyArSNIoS4+W7xnIgOc97MOfpWtQ8qsX9WvIrD6bDKH7dHA02+J5Vpl2wZ+p/kEK400RdsePHxfFBFiCZzEzAvf5zBrLnEuUPgXb5z28=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc0a806-a6e8-40f1-aa2c-08d7f839947b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 19:04:08.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXLMVSeE87JDOh1mAnYvtRWmbtgyWxqtVpfeUg21xhUpgKrwzZ/tfJt3wx1xrBEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Wednesday, May 6, 2020 6:50 PM
> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
> Subject: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
> 
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Some systems support per-thread Memory Bandwidth Allocation (MBA) which
> applies a throttling delay value to each hardware thread instead of to
> a core. Per-thread MBA is enumerated by CPUID.
> 
> No feature flag is shown in /proc/cpuinfo. User applications need to
> check a resctrl throttling mode info file to know if the feature is
> supported.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h
> b/arch/x86/include/asm/cpufeatures.h
> index db189945e9b0..d0ec26ce7f66 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -286,6 +286,7 @@
>  #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user
> entry SWAPGS path */
>  #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* ""
> LFENCE in kernel entry SWAPGS path */
>  #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock
> */
> +#define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread
> Memory Bandwidth Allocation */
> 
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512
> BFLOAT16 instructions */
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-
> deps.c
> index 3cbe24ca80ab..3e30b26c50ef 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -69,6 +69,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_CQM_MBM_TOTAL,
> 	X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_CQM_MBM_LOCAL,
> 	X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
> +	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA
> },
>  	{}
>  };
> 
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 62b137c3c97a..bccfc9ff3cc1 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -35,6 +35,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1
> },
>  	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2
> },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
> +	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3
> },

This is a CPUID feature. You can actually detect this feature without
checking vendor model in patch @1. This patch looks good to me.

>  	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> --
> 2.21.0


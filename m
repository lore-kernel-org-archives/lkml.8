Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E00C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF21207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o8OAFRXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgERR3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:29:48 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:12240
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbgERR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4ByUNDRlCRU9tOCVD/vS5jQu499/1TeSnBtLMQqRMulte4rEb6RjqIokKo75bnlXDTovwoAERmatR65XqwCTfXHi65oiLzcR/uGis6+hoWQUHmnKyMp+REf6C+VRsqke2vEq/gQpIINZQF0umLT462fkhe8IUQ3TXgHxldnxfm1/0kuEU4AuvmIn3rreyG4w83M1mIO2tla6tM67D6REUiqzAh9ujWSEkJ7BZyL3If2jqVKR2a1h5VvQhCDq2/0ZSv52Ep1z1s+xGcP62rqbLzmZ/LB/pqJ1pu5dyE34kOKay1lQPEb/7xitWD24C/sPokKxH3Ppo/HWN2DtuLi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgbukwDwiB5Mi3pkc2HEWzt/xjmGEhVEhDrgtISoPCw=;
 b=I30FWQF+S5U0svXJQhzdeRaAmMONj6Mm8TexemFdTKmTHMZdZLhnVFY9FNVV+1NdEt/360z253yKDo7FlpoGHyrmrkA10bt5glu8uSR+70dDm9uI9wm4Tq9xT3tWs5BjdXnV0LS1AQ54mBQE+2rE7XpdRV4/iNcErY1MMXz1QWoBDA7TakariIio5z7ejYTej4SVmMzE/94B1RMQdaf23nm93zkCQGnYs2PQYxaHv0tfCE0PnWW0FlHENAq9zON/eakbicd2ChkJi/PzLzznanO1tzvoWXsq92Lu4HL67RSMRbrX03VB5dBigV3BRkxTLIRVykRBs4h8twrjBpimEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgbukwDwiB5Mi3pkc2HEWzt/xjmGEhVEhDrgtISoPCw=;
 b=o8OAFRXyEJtmaA8tiSli+t5CpFd5sgqywqawCwSqqFOzN3yksgItLKdt1asiuxq1saX0MJTc/47qJwuLnNYzqLLrbYgyMOnDICDghSg3x3g7yLE3aS4PoU+x2yFyd1jcHK5F9yiokHvkCw2TmE35eXeI4AJ9Di1sGt58Ag+3aU0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 17:29:42 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 17:29:42 +0000
Subject: RE: [PATCH V4 2/4] x86/resctrl: Enumerate per-thread MBA
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
References: <cover.1589652468.git.reinette.chatre@intel.com>
 <c4e6730bdc35b707cc30a1bba540a05c306c5978.1589652468.git.reinette.chatre@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <8e959bf9-1139-b1c2-a39e-c1e1ef45c5d8@amd.com>
Date:   Mon, 18 May 2020 12:29:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <c4e6730bdc35b707cc30a1bba540a05c306c5978.1589652468.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR12CA0004.namprd12.prod.outlook.com (2603:10b6:4:1::14)
 To SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR12CA0004.namprd12.prod.outlook.com (2603:10b6:4:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 17:29:41 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84f0ec43-7081-4dcc-92b1-08d7fb510d08
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25116495ED88A361862DC16C95B80@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52fwn8rsUeFGjZShakNnCrhXqs0D6qDIk69umxHF/VcBm4hbHeC05zoGSEH+YrJTp8NVboAHBqhlx+lQ2vU+1zsWiyqLaDLPH+EVrt1s+N1vL1wyctlcOOd4LUd0/dwW1i+LGPUeSGXOdTmWq3ITMwGB2K3mc1dEBJhD+2yq0JEesnvGeZngpRMvqGlCp5gsbGaa7QERadUHkRvC7TCLWR7AbLe7UIbjvfidFBUoibja58AYQNuZHdXlYaJmMxVpUsh+1Q+2AzmnrIg2FtZXWjtY3GN0bhR5FrCUwwdhKqC9PkPPHpFZEKxqlX4aWhXlOOGhnNDEKvlRDvqp2WesFE5dmTjsrO4QmawXX0oMEk9mW5lmO4CQxFeAtuZBjGeVeCTL/bhGoYOwr4MxDGNkMOTeaSixjJY3RXN1vZM6kQAJ/H5hjqVAxnuCEEO66ZiJiDha4LSluCE0OlEbCYacuRk1ZL8KXM5UfEZly2kuY64gOMi1m8coWMsQEG1CxYWo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(316002)(66476007)(66556008)(956004)(2616005)(16576012)(86362001)(54906003)(7416002)(31696002)(186003)(16526019)(8676002)(5660300002)(26005)(4326008)(2906002)(110136005)(31686004)(52116002)(66946007)(8936002)(478600001)(6486002)(36756003)(53546011)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Eip2ZIy1YCKbFWsbJx5EkpE0/7KwZk1UIRzo70xb0zoll1IhYkKiggtX/+MOIAM03R4DIQMG9GtU1fOUjOK2LrbZipw64V1uqxzL/E5fD9qy0R3hf0heTdp5nIwow5UYgG2jEVyE8rp8HXfgZ8vFRFOEVbe4UzmI/waw4BYXFZvpYIkPr+ZuwGt4tUu9HT92uuSndqum3QBVwduzf00DvTfQDNHi3P7fSqih564k9Oa6dqqqMNX1cB0r3k45uHbqb7cZNKzNOCR048QJcTuRmjZMxwUNErHd76IJu39QjYDJa193EQRQAAJqD8SNxJgoFgOj2xUzsGBUOHxhvMD90kTdBincc+/iHi/khuWOmOPneXSnWHwABtCl1nlsJy5287qxRdcDzFuA6ZfP/wXDMLqaZbU+bgUlZTWkQ45LoFefNP/h74uSAtxWi+Ir5kQaGBiXn0OYslLQPbM7DXNQ96K4VYNrtD0dbmKpMnLJERM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f0ec43-7081-4dcc-92b1-08d7fb510d08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 17:29:42.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Dl9opnOYTGGtslfi5e1YA/UmGaYvk1BuAeuJDEyhsC2aHoigSdXvwNqnWSLm2Qd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Saturday, May 16, 2020 1:29 PM
> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
> Subject: [PATCH V4 2/4] x86/resctrl: Enumerate per-thread MBA
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

Reviewed-by: Babu Moger <babu.moger@amd.com>

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
>  	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> --
> 2.21.0


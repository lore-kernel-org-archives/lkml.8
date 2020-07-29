Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA81C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CAB2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AlXGkVnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2NPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:15:06 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com ([40.107.76.58]:33188
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgG2NPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:15:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh3TVwr1bwRiGVgvW6oYLNM+JI0YbUGrNTgIwCilS3yartUL66tvAmKiwmtzB89GjykTTYbbzniG8WZFzQv+ZQu9zR+YyXxDiYAfTUT9b2RG+PIV9aLe3BH0MPxqIKI5I013q4SOKRClP2+pL4UOKp5cxmwiihiLoB+2vs3HMZ1RtqS91HfYYqGnFsqw5Cq1SrMxSv+Mid/+TCnufo8IW8U91/SiD2VNTK18U4NvR5oivCYAMWKO69bnwtYXTAUvx8TALB3ZDuVJ2myrnC4DJ4Y3njooaKmG53O4rNRGrXAsrPMLV8Bezz4VwuWagvG060U1m8FiK8V29T1HKdP2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJWrDmvEjAGI0/9B3Al9t7VZHsqVFINmR60zLw34thw=;
 b=Ewx9s9XdbSL7lewXvTDuXwaqPdxB99+H7Tu7/LO/3bu8dMmByvPN44gMyioXP/csqg+C51V37XNBaLc0aECy2HQS4drrdr1JwcgZ7Al8XU0S9Ju9Dq/rJ+KE1Aa/b/b6Tp7a2zqt9bKjXjY8Rt06ypbUZ8wUeuiX2mHFjQFQup2sbTgQMK9XyZqT3eKeKJy2Ctrt/ycNoE7x/gIM6kmAXLzSuTv+gLJsI4SD1V+QkNbBMmKobNU9LIPJlzOAFjoy3hZC8nqLo18kx2rU55nlO5xOr5f4wbMa+tUifawmPUzDaTmG8RKtVKjv/lDTQBzMBNICKYyguVlrRgK0AhdJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJWrDmvEjAGI0/9B3Al9t7VZHsqVFINmR60zLw34thw=;
 b=AlXGkVnWYucGViO9n9auKVsVzKXv+J6t3tBNLaNBbi/5oQwYU9SlS8sDwvx0aNIRvQCO7/NPu3aNMIfmMS+QoAWCppeEqWwRHvF3/aLkDKwPpxfiav4B4/MzkiX9Ptk/qtwMLW6pMKksDaCFWvaHklUdizpOycSoJ6BlsMeHTMY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Wed, 29 Jul 2020 13:15:00 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::25ec:e6ba:197c:4eb0]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::25ec:e6ba:197c:4eb0%8]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 13:15:00 +0000
Subject: Re: [PATCH v2 4/5] prctl: Hook L1D flushing in via prctl
To:     Balbir Singh <sblbir@amazon.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org
References: <20200729001103.6450-1-sblbir@amazon.com>
 <20200729001103.6450-5-sblbir@amazon.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <982c1d40-aac1-df0c-c3b7-2699dc0b9b6f@amd.com>
Date:   Wed, 29 Jul 2020 08:14:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729001103.6450-5-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN6PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend Transport; Wed, 29 Jul 2020 13:14:58 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec11e64d-1a25-4c2a-2c7f-08d833c16590
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00287B91BE447D22ED7694A8EC700@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjEDdylBHqOlmht7p+nT/Tk5HcwXgSIbVz3S8yrOIuCarK6iMODgHjfIMWYkp2fzgBXCj1GjTqhTalTs/2gtYKmo/xjUXKWPOXfTL6ahNnq8oDsHSpGHrbGmCzoQT9mKookmWGJqgCnCcjpYR0N/e/cRRNP2aW0WFv+BR/RwSehRL29lQhcem+mECiI12PgDXgUgY5wn3uxqwKw4M3fwFKdwYtjm3C0/m6gHPMGQlNBrIFFx7h16RQKUVlAzuZ0PCS8wMMSYyGpEn7ph9pN668ESUtUbpVgdH44n8oF4yGKxh1H1XQV63Ei9yQH3fFBcxzqoXS+JaNWJi7XW0Be7klvecKnzFYcJvDJEPna1Id+AU+1jx0t6W/yLDxyLrVoGfs2VenQUVJUT/cQt31Y9dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(956004)(2616005)(66476007)(66556008)(66946007)(36756003)(86362001)(5660300002)(31696002)(16526019)(186003)(52116002)(53546011)(4326008)(83380400001)(478600001)(26005)(31686004)(8936002)(316002)(16576012)(7416002)(2906002)(8676002)(6486002)(17423001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TKBcTAVPTh8EVkLXQlJhNwLQ1tCbN83/o1t5L8C7BXU6deMBQQF4/+X+YdF6Vh7iK6k7qcf5Cg98CqkUKq6MWNd5z1KcSOiJlHbGv0GLM5VlXnpMh70/xJt036G4XXQ6Blw/C/7ZHRXlaKFE/NmtcAYyp9AhcBUqczpKkmD68kz7neJ6Ij9YcrFw/hnAO4c2TYwnQia4BcnKhdU9QNcRLk6HYdMRzRa7qoKuRs61hQ4UmzuavouihhygGWFl7FwhEjTwsYhjt/5kXwqyHli0HnSLNmuCAi2s1z5urBePBjXIBu3e8Dtqan5i8HkkrljZc0fclnmXYLbGnFa7ZCwTn+TuEsdkVuWeqFmrhzwMz+DqIDZnT40wWWzw6WBfIxD6ev3VRXXXxDeCBTJpxyX6dvie+flBj0L8RjRNcWMS0qsklJy034poKwRPC9GVw6QhVPES8Fx1D6QdNo43k+DskV8GRiItyTIQ3h9yV/oSww0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec11e64d-1a25-4c2a-2c7f-08d833c16590
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 13:15:00.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abCFAe8VI6z83qz2o9F14rBDliLuwkkbDOMx1hJmQmbzteMyCVCogm1X++H9M6dh9dodDw87HZA1tRfOLpNdEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 7:11 PM, Balbir Singh wrote:
> Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
> flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
> PR_SPEC_DISABLE_NOEXEC are not supported.
> 
> There is also no seccomp integration for the feature.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 54 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/mm/tlb.c          | 25 +++++++++++++++++-
>  include/uapi/linux/prctl.h |  1 +
>  3 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 0b71970d2d3d..935ea88313ab 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -295,6 +295,13 @@ enum taa_mitigations {
>  	TAA_MITIGATION_TSX_DISABLED,
>  };
>  
> +enum l1d_flush_out_mitigations {
> +	L1D_FLUSH_OUT_OFF,
> +	L1D_FLUSH_OUT_ON,
> +};
> +
> +static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;
> +
>  /* Default mitigation for TAA-affected CPUs */
>  static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
>  static bool taa_nosmt __ro_after_init;
> @@ -378,6 +385,18 @@ static void __init taa_select_mitigation(void)
>  	pr_info("%s\n", taa_strings[taa_mitigation]);
>  }
>  
> +static int __init l1d_flush_out_parse_cmdline(char *str)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_L1TF))
> +		return 0;

Shouldn't this set the l1d_flush_out_mitigation to L1D_FLUSH_OUT_OFF since
it is set to L1D_FLUSH_OUT_ON by default? Or does it not matter because
the enable_l1d_flush_for_task() will return -EINVAL if the cpu doesn't
have the L1TF bug?

I guess it depends on what you want l1d_flush_out_prctl_set() and
l1d_flush_out_prctl_get() to return in this case.

Thanks,
Tom

> +
> +	if (!strcmp(str, "off"))
> +		l1d_flush_out_mitigation = L1D_FLUSH_OUT_OFF;
> +
> +	return 0;
> +}
> +early_param("l1d_flush_out", l1d_flush_out_parse_cmdline);
> +
>  static int __init tsx_async_abort_parse_cmdline(char *str)
>  {
>  	if (!boot_cpu_has_bug(X86_BUG_TAA))
> @@ -1220,6 +1239,23 @@ static void task_update_spec_tif(struct task_struct *tsk)
>  		speculation_ctrl_update_current();
>  }
>  
> +static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
> +{
> +
> +	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
> +		return -EPERM;
> +
> +	switch (ctrl) {
> +	case PR_SPEC_ENABLE:
> +		return enable_l1d_flush_for_task(task);
> +	case PR_SPEC_DISABLE:
> +		return disable_l1d_flush_for_task(task);
> +	default:
> +		return -ERANGE;
> +	}
> +	return 0;
> +}
> +
>  static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
>  {
>  	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
> @@ -1312,6 +1348,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>  		return ssb_prctl_set(task, ctrl);
>  	case PR_SPEC_INDIRECT_BRANCH:
>  		return ib_prctl_set(task, ctrl);
> +	case PR_SPEC_L1D_FLUSH_OUT:
> +		return l1d_flush_out_prctl_set(task, ctrl);
>  	default:
>  		return -ENODEV;
>  	}
> @@ -1328,6 +1366,20 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
>  }
>  #endif
>  
> +static int l1d_flush_out_prctl_get(struct task_struct *task)
> +{
> +	int ret;
> +
> +	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
> +		return PR_SPEC_FORCE_DISABLE;
> +
> +	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
> +	if (ret)
> +		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
> +	else
> +		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
> +}
> +
>  static int ssb_prctl_get(struct task_struct *task)
>  {
>  	switch (ssb_mode) {
> @@ -1381,6 +1433,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
>  		return ssb_prctl_get(task);
>  	case PR_SPEC_INDIRECT_BRANCH:
>  		return ib_prctl_get(task);
> +	case PR_SPEC_L1D_FLUSH_OUT:
> +		return l1d_flush_out_prctl_get(task);
>  	default:
>  		return -ENODEV;
>  	}
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 48ccc3dd1492..77b739929ad2 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -316,8 +316,31 @@ EXPORT_SYMBOL_GPL(leave_mm);
>  
>  int enable_l1d_flush_for_task(struct task_struct *tsk)
>  {
> +	int cpu, ret = 0, i;
> +
> +	/*
> +	 * Do not enable L1D_FLUSH_OUT if
> +	 * b. The CPU is not affected by the L1TF bug
> +	 * c. The CPU does not have L1D FLUSH feature support
> +	 * c. The task's affinity is on cores with SMT on.
> +	 */
> +
> +	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
> +			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
> +		return -EINVAL;
> +
> +	cpu = get_cpu();
> +
> +	for_each_cpu(i, &tsk->cpus_mask) {
> +		if (cpu_data(i).smt_active == true) {
> +			put_cpu();
> +			return -EINVAL;
> +		}
> +	}
> +
>  	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
> -	return 0;
> +	put_cpu();
> +	return ret;
>  }
>  
>  int disable_l1d_flush_for_task(struct task_struct *tsk)
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..1e864867a367 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -213,6 +213,7 @@ struct prctl_mm_map {
>  /* Speculation control variants */
>  # define PR_SPEC_STORE_BYPASS		0
>  # define PR_SPEC_INDIRECT_BRANCH	1
> +# define PR_SPEC_L1D_FLUSH_OUT		2
>  /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
>  # define PR_SPEC_NOT_AFFECTED		0
>  # define PR_SPEC_PRCTL			(1UL << 0)
> 

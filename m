Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09294C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91DA20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KGVwweRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDXTEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:04:25 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:23777
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbgDXTEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbuRQz+quitebZhCuXohMwNrvFrmvBXaCGCug23XVuwh7kBrS39NihfJcCBwh3L0al/2dtrpCMDB0/GB+td56x1p6hOugv1Ys7MWA023yoAyO8TveS1NIXt6aOaWEtHjH0OcNbNmCY3RQrFwZuHK518iY90N+lw/EHyWIUgdURJfPb4PFvp9Jz1C1Jd3chbSPQoIBnzPZNWpOPe0PDtY//+2Nz92f0eedec1SkRH06GeTGhbSG1X/BoqdIW9yGQRDgSN530Su/VOSlvH2iZg4i6PxT8ZhA7PmuJlniNPAYHkHIC8Ty9SQDL+INRi/b3GkCd7stObs8OVTKAKCXbIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l7+JdPiaREHLCUr2uhRxkt0fEiUe+lSMSu9CZDP+I4=;
 b=AjIVHbmH2Y1FnTKHJJaSnGgIkZgFmHlSbZr6HNmP/252/bYehWZD7MiPstipXMkKairl9m63ojQa0pSZzFx+AyziZiG0QnpOoj/YvdIjpI3u++76IpRQ+GInNyDbwpIdwjAtiWKqjGPa5SKZUpi0TTCIM+xcoc0S26PYJNL2Wr04uS8X4fF8Qm3SqH8ON+XKKZvsbPnRfwAxhvc+acEPE1O2U4hIxLN1ZZJVQRkxm+IDHrDPuHGkVWqkHYZLCDlI/jVboIV0/MX2C6UwFrotU4z/0JQ5aSPPJTwuznqoWImbPU4rvnv21+Z9F3ucwJftSeqMe1SdOuUU7TfAiBkQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l7+JdPiaREHLCUr2uhRxkt0fEiUe+lSMSu9CZDP+I4=;
 b=KGVwweRWPuhaXyJ/3lWoTX0LD7bQIditE2VpCmHm1A+G5KBHvGkAXRpagxkqvQx62tOOUgc2wK86ED0TBLMc5FhogOXsKcDeDD5uUlWmBY6VgYk+jufD5Po6zzZ6NwIERh+tNq73iwi0AAmvOvay+3qyrRvHAaGFDBsgJenu+Io=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 19:04:18 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf%4]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 19:04:18 +0000
Subject: Re: [PATCH v4 2/6] arch/x86/kvm: Refactor tlbflush and l1d flush
To:     Balbir Singh <sblbir@amazon.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com
References: <20200423140125.7332-1-sblbir@amazon.com>
 <20200423140125.7332-3-sblbir@amazon.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e500fe9a-5c62-8304-92f1-18a2ee185fe4@amd.com>
Date:   Fri, 24 Apr 2020 14:04:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200423140125.7332-3-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:805:f2::43) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR04CA0102.namprd04.prod.outlook.com (2603:10b6:805:f2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 19:04:16 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2efebab-946e-4bd1-336e-08d7e88249b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41243307B32EEEA02993EFDCECD00@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(36756003)(478600001)(31696002)(86362001)(2616005)(31686004)(16526019)(2906002)(956004)(4326008)(8936002)(5660300002)(66946007)(316002)(52116002)(6506007)(6512007)(186003)(53546011)(66476007)(81156014)(26005)(66556008)(8676002)(6486002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylc9jhc7nQC34RgdI+03/QldGUiezWKpdz6sJZbQLyEBJhiygO3PzdIuZYj54OJSYDbFelPlRtlu/BGvfPN9UCBMsMrGmrJGynoCZsovjzJRucSCXdnPm1XeKRINzw9uDr7hmI9oWpUKBBcgtzRkXqA4pcsSv7q3TM4OSKYTkZM0xU6KKO5+uLRmB+qLwJO7cuWA7+aK0AYFDp9+XYKbkAGtnZ+hkEtyH0G6io9GmQh7ID82NLf8f5OLzt1RpEgiDW/6j/jEC99Bvi2D0s66K6qAGQUJJce87w0J7TWSoYHNekQbY5e27l8W46NJ59A8XSeCYYFUwPrxc2T0dVvYZ/Dn5IbyYcakMA/XLy+DbZcI4xBuq62yxmY3jlKyTReOekaZchjqAyVg4hbYr2nchTX2grONmnhZRuHjMGJPOEkIDakHta6aLdTavtrD9wYu
X-MS-Exchange-AntiSpam-MessageData: Z/UqnKWQajq017xjiPNvZj9DfEQkFshBRzTvY97HyqDEIuZQwmvMNZwwqdBfL53WvdXtII8IrnZ2Hc/oqU+v6CYf698wRPc1bMDqWc7JMRm1z6NR0PO8KRPMrqA777bOEWr1csKJPGszhliG0T8Acw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2efebab-946e-4bd1-336e-08d7e88249b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 19:04:17.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0TEDeN/pE6AXvw+kofY80lcmrT6tS68/+0Mne0w5Wax2Lg8h5BOBhq2f7+mWVxURgISP0DUTQ6fKdFQQOEwDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 9:01 AM, Balbir Singh wrote:
> Refactor the existing assembly bits into smaller helper functions
> and also abstract L1D_FLUSH into a helper function. Use these
> functions in kvm for L1D flushing.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>   arch/x86/include/asm/cacheflush.h |  3 ++
>   arch/x86/kernel/l1d_flush.c       | 54 +++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c            | 29 ++---------------
>   3 files changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index bac56fcd9790..21cc3b28fa63 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -8,7 +8,10 @@
>   
>   #define L1D_CACHE_ORDER 4
>   void clflush_cache_range(void *addr, unsigned int size);
> +void l1d_flush_populate_tlb(void *l1d_flush_pages);
>   void *l1d_flush_alloc_pages(void);
>   void l1d_flush_cleanup_pages(void *l1d_flush_pages);
> +void l1d_flush_sw(void *l1d_flush_pages);
> +int l1d_flush_hw(void);
>   
>   #endif /* _ASM_X86_CACHEFLUSH_H */
> diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
> index d605878c8f28..5871794f890d 100644
> --- a/arch/x86/kernel/l1d_flush.c
> +++ b/arch/x86/kernel/l1d_flush.c
> @@ -34,3 +34,57 @@ void l1d_flush_cleanup_pages(void *l1d_flush_pages)
>   	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
>   }
>   EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
> +
> +/*
> + * Not all users of l1d flush would want to populate the TLB first
> + * split out the function so that callers can optionally flush the L1D
> + * cache via sw without prefetching the TLB.
> + */
> +void l1d_flush_populate_tlb(void *l1d_flush_pages)
> +{
> +	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> +
> +	asm volatile(
> +		/* First ensure the pages are in the TLB */
> +		"xorl	%%eax, %%eax\n"
> +		".Lpopulate_tlb:\n\t"
> +		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> +		"addl	$4096, %%eax\n\t"
> +		"cmpl	%%eax, %[size]\n\t"
> +		"jne	.Lpopulate_tlb\n\t"
> +		"xorl	%%eax, %%eax\n\t"
> +		"cpuid\n\t"
> +		:: [flush_pages] "r" (l1d_flush_pages),
> +		    [size] "r" (size)
> +		: "eax", "ebx", "ecx", "edx");
> +}
> +EXPORT_SYMBOL_GPL(l1d_flush_populate_tlb);
> +
> +int l1d_flush_hw(void)
> +{
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> +		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +		return 0;
> +	}
> +	return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(l1d_flush_hw);
> +
> +void l1d_flush_sw(void *l1d_flush_pages)
> +{
> +	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> +
> +	asm volatile(
> +			/* Fill the cache */
> +			"xorl	%%eax, %%eax\n"
> +			".Lfill_cache:\n"
> +			"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> +			"addl	$64, %%eax\n\t"
> +			"cmpl	%%eax, %[size]\n\t"
> +			"jne	.Lfill_cache\n\t"
> +			"lfence\n"
> +			:: [flush_pages] "r" (l1d_flush_pages),
> +			[size] "r" (size)
> +			: "eax", "ecx");
> +}

If the answer to my previous question in patch 1/6 about the allocation 
being twice the size is yes, then could you allocate the flush pages the 
same size as the cache and just write it twice? Wouldn't that accomplish 
the same goal and provide a performance improvement with (mostly) now 
present L1D entries of the flush pages? Also, can't you unroll this loop a 
bit and operate on multiple entries in each loop, reducing the overall 
looping compares and jumps as an optimization?

Thanks,
Tom


> +EXPORT_SYMBOL_GPL(l1d_flush_sw);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 225aa8219bac..786d1615a09f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5983,8 +5983,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>    */
>   static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>   {
> -	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> -
>   	/*
>   	 * This code is only executed when the the flush mode is 'cond' or
>   	 * 'always'
> @@ -6013,32 +6011,11 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>   
>   	vcpu->stat.l1d_flush++;
>   
> -	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> -		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +	if (!l1d_flush_hw())
>   		return;
> -	}
>   
> -	asm volatile(
> -		/* First ensure the pages are in the TLB */
> -		"xorl	%%eax, %%eax\n"
> -		".Lpopulate_tlb:\n\t"
> -		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> -		"addl	$4096, %%eax\n\t"
> -		"cmpl	%%eax, %[size]\n\t"
> -		"jne	.Lpopulate_tlb\n\t"
> -		"xorl	%%eax, %%eax\n\t"
> -		"cpuid\n\t"
> -		/* Now fill the cache */
> -		"xorl	%%eax, %%eax\n"
> -		".Lfill_cache:\n"
> -		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> -		"addl	$64, %%eax\n\t"
> -		"cmpl	%%eax, %[size]\n\t"
> -		"jne	.Lfill_cache\n\t"
> -		"lfence\n"
> -		:: [flush_pages] "r" (vmx_l1d_flush_pages),
> -		    [size] "r" (size)
> -		: "eax", "ebx", "ecx", "edx");
> +	l1d_flush_populate_tlb(vmx_l1d_flush_pages);
> +	l1d_flush_sw(vmx_l1d_flush_pages);
>   }
>   
>   static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
> 

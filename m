Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D237C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD0F20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dQsiXBq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDXS7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:59:13 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:51937
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbgDXS7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyD+5C9oKckXp8aZuwO20lKqNyR+lhBqrQvNgOXx1SRnUCpr5k4fTxaiGX04DyahruDAl9noQrq37m2weVkMlx9fgOqOuycSkkTY8pG9osXpETDD5DnyTEV8v4Mp4LuLHVrwRQwnLl7AsNfTeCVGuwwkr5uEvQJMflDw7qyoyEKr9Tna81P8t5BpzcLiv7cBEDz6IljPrnNlXgeyvQ3Xz3G5eCxXhy47nzBsqhv36v+yNKoyEC90nEGJA2QtrgnWluEu66Yqym53WTSBmtb9hM6caB1estFgfpeiOO4jFoZiUh3FhX1xiFDJOXXyoVrpFg7P/8GFRueWx4VXn5x7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIs051TRgZ/w2Rt2TDGRIftCNRgKhzm0zM0cC99IhVo=;
 b=QgfHAku5KmqAamSPK4hWZX1/WHXaXpl6lB5r2ePuN1zhNy9Uu1XKUdr+1sbZ2pEsnqVmskWecH8oev6ARRkuTQU5ZqI+6qDzC89Sv7Lm2434BOohvNzbgKgzPsVmJ4UtoxHyf4p1EM+9QHEGjr7KKW9gMmAgxaNRatOTPcRrWa6bIbWrkwXZBLhRFh9Izuk8tTNnBh6ss+p/l3wGfRdM1TMogDY/zu36EGPSBJxkBdNnOo/t6wVXNAo6khIRz0cy9G5+ogxhuK1DyoiMxF6ZvwV3PlRwOC2sP+0A0nofCBEGwZMvBNvVxQgz/HwVAgElOkiuF34etBg1RXuXqDtt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIs051TRgZ/w2Rt2TDGRIftCNRgKhzm0zM0cC99IhVo=;
 b=dQsiXBq9zza0X6xa6eH1KX/jPbaNln/ydRakgLWsWfaJjgGtMlq8fBuoIicEYmS1F+dXKPhOWuy9PEO4kW1+WeDLvXYfTyooacSu62l364Gx9OVW/OM0xUgDNIHnfUoFffbnS2ggLAny0TPJO2fFuWRMkSm0ozJoNooDW600B08=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 24 Apr
 2020 18:59:09 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf%4]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 18:59:09 +0000
Subject: Re: [PATCH v4 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
To:     Balbir Singh <sblbir@amazon.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com
References: <20200423140125.7332-1-sblbir@amazon.com>
 <20200423140125.7332-2-sblbir@amazon.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c45c0539-dd48-0e6c-5bb4-22d905b778aa@amd.com>
Date:   Fri, 24 Apr 2020 13:59:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200423140125.7332-2-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0701CA0001.namprd07.prod.outlook.com (2603:10b6:803:28::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 18:59:08 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20b208c0-7e49-4ec8-c06e-08d7e88191e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426818534C8436DCE8D06A7EECD00@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(26005)(2906002)(53546011)(52116002)(6506007)(66556008)(66476007)(66946007)(316002)(8676002)(16526019)(31696002)(86362001)(186003)(81156014)(8936002)(2616005)(956004)(6486002)(478600001)(5660300002)(31686004)(36756003)(4326008)(6512007)(473944003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpytVNLv3QGC6MaymwLLB2eYC7C3kJQgQlcLzEWdCgX76jvS3udnM9rN3oS39unlUghqcYB2jf+dwJTZv1EcLfUgO55xxl4KJXoDv4+nui7aNRkAXlzirPEetKRDyUpAjz9kygYrmOHPiioZTkJXUNiWBOWUdumW8TFNPyay/NTfdEBqNratsGK82Z0HX5jWLW7/4nJ2hVPqmjHN95EmWPaTTMy2NvO6j4HreG0xX4BaK+9K8Nlt7d1h7GKkQWELJZiWHcBXBZAq7q2tdTPLPYXFUaEwW1aCAFJTm0ic2b/Y7GOVQSkVgLF5xJnAV6OD+IlYD1pj8rqSZ3vMv7psidre29vCy/DZQi3eTDs6vkOqG8MLt5ptt7H2/aZB+aUqeepvpUh7G487ji8EwcS4NfOwLAN9O4wX4RRJemV130TuybyLMMBQiVjyPaehwhutFN205ZyZzI8GK8cwO8rRMDnadv7FVHrj2xpK2rlqzkhM5ywEt8PEeoHv0TTUOdhW
X-MS-Exchange-AntiSpam-MessageData: ZnJ0b7twCGVVn/p9nOtIvrbqIsqyeV9JtVNrV0C2aYLyUeJtJNLR1Qv4bLndJzKU2GSPT++PuPNUsAy7BIHJV/7DFFVT4FfH9lXYkM7rjzcD/BVUdHBHd/TakpHj1X9NJOe1PWwAcLXlZBI81C3lbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b208c0-7e49-4ec8-c06e-08d7e88191e4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 18:59:09.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tz7ZDiERFzz25OzY+Zfh7sdv5jORPv0t3H9nabqopILfOh/Qs7ilpUSNCKS3oBXXptwcdLG2bChp9zFWPiXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 9:01 AM, Balbir Singh wrote:
> Split out the allocation and free routines to be used in a follow
> up set of patches (to reuse for L1D flushing).
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>   arch/x86/include/asm/cacheflush.h |  3 +++
>   arch/x86/kernel/Makefile          |  1 +
>   arch/x86/kernel/l1d_flush.c       | 36 +++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c            | 25 +++------------------
>   4 files changed, 43 insertions(+), 22 deletions(-)
>   create mode 100644 arch/x86/kernel/l1d_flush.c
> 
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index 63feaf2a5f93..bac56fcd9790 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -6,6 +6,9 @@
>   #include <asm-generic/cacheflush.h>
>   #include <asm/special_insns.h>
>   
> +#define L1D_CACHE_ORDER 4

Since this is becoming a generic function now, shouldn't this value be 
based on the actual L1D cache size? Is this value based on a 32KB data 
cache and the idea is to write twice the size of the cache to be sure that 
every entry has been replaced - with the second 32KB to catch the odd line 
that might not have been pulled in?

Thanks,
Tom

>   void clflush_cache_range(void *addr, unsigned int size);
> +void *l1d_flush_alloc_pages(void);
> +void l1d_flush_cleanup_pages(void *l1d_flush_pages);
>   
>   #endif /* _ASM_X86_CACHEFLUSH_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 92e1261ec4ec..42c11ca85f1c 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -158,3 +158,4 @@ ifeq ($(CONFIG_X86_64),y)
>   endif
>   
>   obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
> +obj-y						+= l1d_flush.o
> diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
> new file mode 100644
> index 000000000000..d605878c8f28
> --- /dev/null
> +++ b/arch/x86/kernel/l1d_flush.c
> @@ -0,0 +1,36 @@
> +#include <linux/mm.h>
> +#include <asm/cacheflush.h>
> +
> +void *l1d_flush_alloc_pages(void)
> +{
> +	struct page *page;
> +	void *l1d_flush_pages = NULL;
> +	int i;
> +
> +	/*
> +	 * This allocation for l1d_flush_pages is not tied to a VM/task's
> +	 * lifetime and so should not be charged to a memcg.
> +	 */
> +	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
> +	if (!page)
> +		return NULL;
> +	l1d_flush_pages = page_address(page);
> +
> +	/*
> +	 * Initialize each page with a different pattern in
> +	 * order to protect against KSM in the nested
> +	 * virtualization case.
> +	 */
> +	for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
> +		memset(l1d_flush_pages + i * PAGE_SIZE, i + 1,
> +				PAGE_SIZE);
> +	}
> +	return l1d_flush_pages;
> +}
> +EXPORT_SYMBOL_GPL(l1d_flush_alloc_pages);
> +
> +void l1d_flush_cleanup_pages(void *l1d_flush_pages)
> +{
> +	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
> +}
> +EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 83050977490c..225aa8219bac 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -203,14 +203,10 @@ static const struct {
>   	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
>   };
>   
> -#define L1D_CACHE_ORDER 4
>   static void *vmx_l1d_flush_pages;
>   
>   static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
>   {
> -	struct page *page;
> -	unsigned int i;
> -
>   	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
>   		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
>   		return 0;
> @@ -253,24 +249,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
>   
>   	if (l1tf != VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
>   	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> -		/*
> -		 * This allocation for vmx_l1d_flush_pages is not tied to a VM
> -		 * lifetime and so should not be charged to a memcg.
> -		 */
> -		page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
> -		if (!page)
> +		vmx_l1d_flush_pages = l1d_flush_alloc_pages();
> +		if (!vmx_l1d_flush_pages)
>   			return -ENOMEM;
> -		vmx_l1d_flush_pages = page_address(page);
> -
> -		/*
> -		 * Initialize each page with a different pattern in
> -		 * order to protect against KSM in the nested
> -		 * virtualization case.
> -		 */
> -		for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
> -			memset(vmx_l1d_flush_pages + i * PAGE_SIZE, i + 1,
> -			       PAGE_SIZE);
> -		}
>   	}
>   
>   	l1tf_vmx_mitigation = l1tf;
> @@ -8026,7 +8007,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
>   static void vmx_cleanup_l1d_flush(void)
>   {
>   	if (vmx_l1d_flush_pages) {
> -		free_pages((unsigned long)vmx_l1d_flush_pages, L1D_CACHE_ORDER);
> +		l1d_flush_cleanup_pages(vmx_l1d_flush_pages);
>   		vmx_l1d_flush_pages = NULL;
>   	}
>   	/* Restore state so sysfs ignores VMX */
> 

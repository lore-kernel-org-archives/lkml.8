Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF8BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00585206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OIjjOHSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgDTNvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:51:33 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:4001
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgDTNvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyY89+2UFVz1r1fp1aNdRWjIu7QML8C/6Ew0b2CK9ME1ulbpQ8oQNXywnhYUyq4RaZ+KZUHa0A8ZYoT0hApRR03lyzvmjnRKVYSEuGY9JAkM4uBNQkNoFgIQ7dLRaX5B7BKuH6MUFhhYL8qAinfv2UnnV//9bMjlaa2J6UAX11A4AwjyuoDajsZY4xgPVWHYgyxf3hkOUBJ1G0G/CPhk1V+hw/b89fKeAq3CDj7rd08Uo1bEiS+ovPUS+eJ7w4+VVO1Jn6vWa8GGBV4iEIAqlxCZXjOd+hy9zixkeWSXktb/33lzd0G4PS2XYZbUyeFFcEglKrGIa6rFlrv1AVH3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unP677CihvvcBRKQVPV/0nTUHA3DmJOWpjcuzxW2rRw=;
 b=mtk7FEJVfHonMfdCMklDVjRWJCHVse+bHcFYIaNLpVWTOMqMX2/CGuyAy9mY4CUkhAw777WU49WwX/GyFib6vSX10uquVMJdervcE5T80a5hoKa7VDa8jWjmjc1tfq6flvhzzJwpO89d4xZisOTDsbstO4tRci6ltL4MJGy9v8VE3RADvo0Sjsdm1TK7KrX4702ZNT0jpWzIJ3VUs0nWX7BfOJ0x8sLljzuDRy0r4FtKIYpZi1EPwGACu7ChKtUOO+0UIxxDDyONRLVrZwPKdWZV9RAAiiro/L2zecalNVC6BpjXBP89S6RxuAbzw0Y0LHEb9m+lKSmeTp+JH7PELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unP677CihvvcBRKQVPV/0nTUHA3DmJOWpjcuzxW2rRw=;
 b=OIjjOHSyr9IfuQRZF3D3CVUn5iqweLHzVl5pbiOCwLq6bcCZLere2cjidC0hhn8f8S1t4lQM/8nfaeTeRxJLpO8KRN38V6sWPadcG7n7npbKQXYYOrgxBzsuiPyNRu+hPyutH3UuaT+TpQkDEXMe5McF22nuqwVMO8bglttKsyw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 13:48:52 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf%4]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 13:48:52 +0000
Subject: Re: [patch 05/15] x86/tlb: Move __flush_tlb() out of line
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200419203137.214111265@linutronix.de>
 <20200419203336.134117165@linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5857df01-abeb-c6cd-8e92-64eb365dc835@amd.com>
Date:   Mon, 20 Apr 2020 08:48:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200419203336.134117165@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 13:48:51 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51e99b83-e134-4875-35df-08d7e5318f90
X-MS-TrafficTypeDiagnostic: DM6PR12MB3001:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3001DDDDF8B065B77E82D46AECD40@DM6PR12MB3001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(6512007)(86362001)(36756003)(6486002)(4326008)(316002)(31696002)(16526019)(186003)(478600001)(54906003)(110136005)(2906002)(8936002)(8676002)(81156014)(53546011)(6506007)(2616005)(956004)(66476007)(66556008)(5660300002)(66946007)(52116002)(26005)(31686004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2temJr58VjUSlpDgOoJeRaA0K1WDfA31tIbxco+d3SFvyursrIVPe+0A/1C/x4qISC3gclqlsDsDlwO/gDcNDQNXXvCwRgqjUECR+TrG0UUYa6qL2jtH7mtaV5IH/LkDUyeuGVuPJ5QfgopWvbKCMIxZFCfzLsMG0wIrWBIlK16yGFZmSlCrjpqprhFnpwm1ZxScmPrIdFEBDPBER3ZWirhIq8wWndpMQJ0W+jlfae6MCFdG5jk0z1mywn9pJJhbyfLXrIvLAew2PbgapUnm3L27kTb+97z1fqC4s5j9paV2pNlwf3KHOTH+Dx25u61X5SGI1erjsb/T/qH+ziVLKjsl5Rx2aXBmzXrRtWl/WqlWCnEZbj/dzTbdg4J+xtS1TiHiI4ji6ZE+gw7I8SEAoPs3CHqIRxPils6xAoHpoY6+rL4CqJefr8+T48OfaWA
X-MS-Exchange-AntiSpam-MessageData: D5HCeJM0FkfOMQ1JC40HcpCT9e9G+w03phD/chBbSStSEfjIaZylqfAn9yqyLbkvj8PZZ6jPoW1sdpBNyg56/ki9G0DsN2TxxImS6sI3O0b+2HSMHzTdXNvu9cmLfzSpnkBVaS1RI3ifZFy/xVUjLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e99b83-e134-4875-35df-08d7e5318f90
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 13:48:52.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYveHfdhQ67zLoSPhARQf+24IsddN5yD64Qf7fOvSZGFpq7BOZHaW7IZT5KyvNa2SlmSSYc5gy3xIhX5LbY63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/20 3:31 PM, Thomas Gleixner wrote:
> cpu_tlbstate is exported because various TLB related functions need access
> to it, but cpu_tlbstate is sensitive information which should only be
> accessed by well contained kernel functions and not be directly exposed to
> modules.
> 
> The various TLB flush functions need access to cpu_tlbstate. As a first
> step move __flush_tlb() out of line and hide the native function. The
> latter can be static when CONFIG_PARAVIRT is disabled.
> 
> Consolidate the name space while at it and remove the pointless extra
> wrapper in the paravirt code.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>   arch/x86/include/asm/paravirt.h    |    4 +++-
>   arch/x86/include/asm/tlbflush.h    |   29 +++++------------------------
>   arch/x86/kernel/cpu/mtrr/generic.c |    4 ++--
>   arch/x86/kernel/paravirt.c         |    7 +------
>   arch/x86/mm/mem_encrypt.c          |    2 +-
>   arch/x86/mm/tlb.c                  |   33 ++++++++++++++++++++++++++++++++-
>   arch/x86/platform/uv/tlb_uv.c      |    2 +-
>   7 files changed, 45 insertions(+), 36 deletions(-)
> 
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -47,7 +47,9 @@ static inline void slow_down_io(void)
>   #endif
>   }
>   
> -static inline void __flush_tlb(void)
> +void native_flush_tlb_local(void);
> +
> +static inline void __flush_tlb_local(void)
>   {
>   	PVOP_VCALL0(mmu.flush_tlb_user);
>   }
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -140,12 +140,13 @@ static inline unsigned long build_cr3_no
>   	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
>   }
>   
> +void flush_tlb_local(void);
> +
>   #ifdef CONFIG_PARAVIRT
>   #include <asm/paravirt.h>
>   #else
> -#define __flush_tlb() __native_flush_tlb()
> -#define __flush_tlb_global() __native_flush_tlb_global()
> -#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
> +#define __flush_tlb_global()		__native_flush_tlb_global()
> +#define __flush_tlb_one_user(addr)	__native_flush_tlb_one_user(addr)
>   #endif
>   
>   struct tlb_context {
> @@ -371,24 +372,6 @@ static inline void invalidate_user_asid(
>   }
>   
>   /*
> - * flush the entire current user mapping
> - */
> -static inline void __native_flush_tlb(void)
> -{
> -	/*
> -	 * Preemption or interrupts must be disabled to protect the access
> -	 * to the per CPU variable and to prevent being preempted between
> -	 * read_cr3() and write_cr3().
> -	 */
> -	WARN_ON_ONCE(preemptible());
> -
> -	invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> -
> -	/* If current->mm == NULL then the read_cr3() "borrows" an mm */
> -	native_write_cr3(__native_read_cr3());
> -}
> -
> -/*
>    * flush everything
>    */
>   static inline void __native_flush_tlb_global(void)
> @@ -461,7 +444,7 @@ static inline void __flush_tlb_all(void)
>   		/*
>   		 * !PGE -> !PCID (setup_pcid()), thus every flush is total.
>   		 */
> -		__flush_tlb();
> +		flush_tlb_local();
>   	}
>   }
>   
> @@ -537,8 +520,6 @@ struct flush_tlb_info {
>   	bool			freed_tables;
>   };
>   
> -#define local_flush_tlb() __flush_tlb()
> -
>   #define flush_tlb_mm(mm)						\
>   		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
>   
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -761,7 +761,7 @@ static void prepare_set(void) __acquires
>   
>   	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
>   	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
> -	__flush_tlb();
> +	flush_tlb_local();
>   
>   	/* Save MTRR state */
>   	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
> @@ -778,7 +778,7 @@ static void post_set(void) __releases(se
>   {
>   	/* Flush TLBs (no need to flush caches - they are disabled) */
>   	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
> -	__flush_tlb();
> +	flush_tlb_local();
>   
>   	/* Intel (P6) standard MTRRs */
>   	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn
>   	return insn_len;
>   }
>   
> -static void native_flush_tlb(void)
> -{
> -	__native_flush_tlb();
> -}
> -
>   /*
>    * Global pages have to be flushed a bit differently. Not a real
>    * performance problem because this does not happen often.
> @@ -359,7 +354,7 @@ struct paravirt_patch_template pv_ops =
>   #endif /* CONFIG_PARAVIRT_XXL */
>   
>   	/* Mmu ops. */
> -	.mmu.flush_tlb_user	= native_flush_tlb,
> +	.mmu.flush_tlb_user	= native_flush_tlb_local,
>   	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
>   	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
>   	.mmu.flush_tlb_others	= native_flush_tlb_others,
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -134,7 +134,7 @@ static void __init __sme_early_map_unmap
>   		size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
>   	} while (size);
>   
> -	__native_flush_tlb();
> +	flush_tlb_local();

This invoked __native_flush_tlb() because of how early it is called and 
the paravirt ops support isn't set up yet, resulting in a crash if not 
invoking the native version directly. So this needs a "native" version of 
the tlb flush to invoke.

Thanks,
Tom

>   }
>   
>   void __init sme_unmap_bootdata(char *real_mode_data)
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -18,6 +18,13 @@
>   
>   #include "mm_internal.h"
>   
> +#ifdef CONFIG_PARAVIRT
> +# define STATIC_NOPV
> +#else
> +# define STATIC_NOPV			static
> +# define __flush_tlb_local		native_flush_tlb_local
> +#endif
> +
>   /*
>    *	TLB flushing, formerly SMP-only
>    *		c/o Linus Torvalds.
> @@ -645,7 +652,7 @@ static void flush_tlb_func_common(const
>   		trace_tlb_flush(reason, nr_invalidate);
>   	} else {
>   		/* Full flush. */
> -		local_flush_tlb();
> +		flush_tlb_local();
>   		if (local)
>   			count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>   		trace_tlb_flush(reason, TLB_FLUSH_ALL);
> @@ -884,6 +891,30 @@ unsigned long __get_current_cr3_fast(voi
>   EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
>   
>   /*
> + * Flush the entire current user mapping
> + */
> +STATIC_NOPV void native_flush_tlb_local(void)
> +{
> +	/*
> +	 * Preemption or interrupts must be disabled to protect the access
> +	 * to the per CPU variable and to prevent being preempted between
> +	 * read_cr3() and write_cr3().
> +	 */
> +	WARN_ON_ONCE(preemptible());
> +
> +	invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> +
> +	/* If current->mm == NULL then the read_cr3() "borrows" an mm */
> +	native_write_cr3(__native_read_cr3());
> +}
> +
> +void flush_tlb_local(void)
> +{
> +	__flush_tlb_local();
> +}
> +EXPORT_SYMBOL_GPL(flush_tlb_local);
> +
> +/*
>    * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
>    * This means that the 'struct flush_tlb_info' that describes which mappings to
>    * flush is actually fixed. We therefore set a single fixed struct and use it in
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -293,7 +293,7 @@ static void bau_process_message(struct m
>   	 * This must be a normal message, or retry of a normal message
>   	 */
>   	if (msg->address == TLB_FLUSH_ALL) {
> -		local_flush_tlb();
> +		flush_tlb_local();
>   		stat->d_alltlb++;
>   	} else {
>   		__flush_tlb_one_user(msg->address);
> 

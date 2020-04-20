Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52602C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217BE20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CyQb/m+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgDTO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:27:02 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:6881
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbgDTO1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:27:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo4wEagL474xnBz+cw1fcqf6KE1V8FJ1/jVoESse4EyWfumDK5pkI/anP6pZ+f0rC5EXtDTsc2rkF2ZepSRs/agWziafXOLE6EYSv5S0gzSlIqCGaglt+a0p0Dmg/MB5DGTNPme8KKcpRkVvgeooa0gsCV9viMHJi0SHpQEGayY6amGfjP/9VUkvupD2mMxmrHZocPfbaTg/j6YJNjMkBUsPnDt15W9b6LLk3Yj8JreWcBfI39kCw/gpwCntIuFnNzq8Vdp7KbW4dG5n4jsL/KyoP5YyLUIKREbNtG/7Rt6Z5eu5erQ6qtaV2oVEh5XNhbkqtbePFIFQdytVYeE7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr7WkK6uotISoQS1Cwh5eywXlMdgCCRm7a9/cWHUxbw=;
 b=bSLzk/kWNw0QVs7rB04CenbNLnYYzltkbkQMHDIuC94y6UGQiXHcSPJ35ITofhaKC3M+ROrCg5ozAxei86Vhem3R66I4d6mSVhKrtkOdMUvgNyVGM4UyqYottHROtToeeF2h/z/AJ9sm+F33qCdOeB08kR6P8jTFSyMc3e0DMPWIMqsDc6v+CZrxELvv9aMYYagqElLwPfs7YFBXgmcrQzikkuV3rlO4MGsOFJ+ABSnlUdGbRx8L00EQohKqCu3Y+ppUo4HR8IrbMXsx382ES1Dg37Q53KKUkYPprDQfsFLUUi7bcV/Q0wK98OJh77+k4wn6mumSCpTvsrSztgY3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr7WkK6uotISoQS1Cwh5eywXlMdgCCRm7a9/cWHUxbw=;
 b=CyQb/m+slmHTKiCc/VwXBy7Yx7EW9CwNrr4HibMzAUaid86WEi09332zL0jdWEGWkxb2+vvYesZ1/+yTKRfjmFbRLHeCV89Opdkznpg1Yzf5uph+tZAfeSDKriHtU3KfMQr0lConoQiEEh1b1NUvOrcaKCIxAgaoniWya2rC/e4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2731.namprd12.prod.outlook.com (2603:10b6:5:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 14:26:57 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9ae:cb95:c925:d5bf%4]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 14:26:57 +0000
Subject: Re: [patch 05/15] x86/tlb: Move __flush_tlb() out of line
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200419203137.214111265@linutronix.de>
 <20200419203336.134117165@linutronix.de>
 <5857df01-abeb-c6cd-8e92-64eb365dc835@amd.com>
 <fab4e80a-3df2-a177-c5fe-1ab995953727@suse.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <852c1af7-bc1c-a86c-d390-7547563bdde4@amd.com>
Date:   Mon, 20 Apr 2020 09:26:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <fab4e80a-3df2-a177-c5fe-1ab995953727@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR05CA0030.namprd05.prod.outlook.com (2603:10b6:805:de::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 14:26:57 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14b4b2e0-7479-4202-9132-08d7e536e1e1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2731:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2731B7A5C314241571F9471DECD40@DM6PR12MB2731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(66946007)(66556008)(81156014)(2906002)(66476007)(8676002)(26005)(52116002)(36756003)(5660300002)(316002)(54906003)(110136005)(86362001)(31686004)(956004)(478600001)(186003)(4326008)(16526019)(6512007)(6506007)(53546011)(8936002)(31696002)(6486002)(66574012)(2616005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIKQZ1eXMH+Kdqcl2oyIJQ5YAKriqEdSrhZZSgFW1NYMmfwH63WDMxy7mehB16lJCMyai66td6aB29+wsmYpZ4x2l2+AMd79kf/z3VwAjTSYLdozKB7BBe31g9gpk8Tb/DIfEGfqbWE9QSgBahlRwjRzP1mv1ajzVTExydHfIBoND9EJ/g2aKQMf42A9SlusC22pxhxEkthuXH3wgFs8KBlrCebyrfrqm+4s332qQGgsjw6jvdzCny7t7ShaNANWRwQL2nIchC7SwqeJknYho8eipjbBt6hh6buryzJLZoF2956O4AiThS9RnZmK80g7b7a9c0ackHV5+W4OzFMKXFHfyDp4ABE8RXh8q1bIDh8vlGCgT+wMn/bzsxEBfo7u4H950N/sfddGaH9ZaLKbjQookmGhBvyzcorn0IakPD9OsB/6RZibdatrSKeT0ae1
X-MS-Exchange-AntiSpam-MessageData: AVb9Ys16jQ+SllNk3tA2yKlUN15UXS7qzYNPC/NTPdEN4HN5Jybz0dc3+icAJK6HBtjw4/3XC/7Tw6V5CQqTC60JsV6CzhkOY710cOTzQNDIjfQkXFH0Iw7vhc6sWAAudac6Bqnnc0jbS1infWmfGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b4b2e0-7479-4202-9132-08d7e536e1e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 14:26:57.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJmU6xsGkqxvfeb1n7ap/nB7Vd8kFD1lqG8ByCVfnHKxdeVeC2y8llakw26w+Hi/XNVeArZRvbpCaVbGLkWe2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 9:03 AM, Jürgen Groß wrote:
> On 20.04.20 15:48, Tom Lendacky wrote:
>> On 4/19/20 3:31 PM, Thomas Gleixner wrote:
>>> cpu_tlbstate is exported because various TLB related functions need access
>>> to it, but cpu_tlbstate is sensitive information which should only be
>>> accessed by well contained kernel functions and not be directly exposed to
>>> modules.
>>>
>>> The various TLB flush functions need access to cpu_tlbstate. As a first
>>> step move __flush_tlb() out of line and hide the native function. The
>>> latter can be static when CONFIG_PARAVIRT is disabled.
>>>
>>> Consolidate the name space while at it and remove the pointless extra
>>> wrapper in the paravirt code.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> ---
>>>   arch/x86/include/asm/paravirt.h    |    4 +++-
>>>   arch/x86/include/asm/tlbflush.h    |   29 +++++------------------------
>>>   arch/x86/kernel/cpu/mtrr/generic.c |    4 ++--
>>>   arch/x86/kernel/paravirt.c         |    7 +------
>>>   arch/x86/mm/mem_encrypt.c          |    2 +-
>>>   arch/x86/mm/tlb.c                  |   33 
>>> ++++++++++++++++++++++++++++++++-
>>>   arch/x86/platform/uv/tlb_uv.c      |    2 +-
>>>   7 files changed, 45 insertions(+), 36 deletions(-)
>>>
>>> --- a/arch/x86/include/asm/paravirt.h
>>> +++ b/arch/x86/include/asm/paravirt.h
>>> @@ -47,7 +47,9 @@ static inline void slow_down_io(void)
>>>   #endif
>>>   }
>>> -static inline void __flush_tlb(void)
>>> +void native_flush_tlb_local(void);
>>> +
>>> +static inline void __flush_tlb_local(void)
>>>   {
>>>       PVOP_VCALL0(mmu.flush_tlb_user);
>>>   }
>>> --- a/arch/x86/include/asm/tlbflush.h
>>> +++ b/arch/x86/include/asm/tlbflush.h
>>> @@ -140,12 +140,13 @@ static inline unsigned long build_cr3_no
>>>       return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
>>>   }
>>> +void flush_tlb_local(void);
>>> +
>>>   #ifdef CONFIG_PARAVIRT
>>>   #include <asm/paravirt.h>
>>>   #else
>>> -#define __flush_tlb() __native_flush_tlb()
>>> -#define __flush_tlb_global() __native_flush_tlb_global()
>>> -#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
>>> +#define __flush_tlb_global()        __native_flush_tlb_global()
>>> +#define __flush_tlb_one_user(addr)    __native_flush_tlb_one_user(addr)
>>>   #endif
>>>   struct tlb_context {
>>> @@ -371,24 +372,6 @@ static inline void invalidate_user_asid(
>>>   }
>>>   /*
>>> - * flush the entire current user mapping
>>> - */
>>> -static inline void __native_flush_tlb(void)
>>> -{
>>> -    /*
>>> -     * Preemption or interrupts must be disabled to protect the access
>>> -     * to the per CPU variable and to prevent being preempted between
>>> -     * read_cr3() and write_cr3().
>>> -     */
>>> -    WARN_ON_ONCE(preemptible());
>>> -
>>> -    invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
>>> -
>>> -    /* If current->mm == NULL then the read_cr3() "borrows" an mm */
>>> -    native_write_cr3(__native_read_cr3());
>>> -}
>>> -
>>> -/*
>>>    * flush everything
>>>    */
>>>   static inline void __native_flush_tlb_global(void)
>>> @@ -461,7 +444,7 @@ static inline void __flush_tlb_all(void)
>>>           /*
>>>            * !PGE -> !PCID (setup_pcid()), thus every flush is total.
>>>            */
>>> -        __flush_tlb();
>>> +        flush_tlb_local();
>>>       }
>>>   }
>>> @@ -537,8 +520,6 @@ struct flush_tlb_info {
>>>       bool            freed_tables;
>>>   };
>>> -#define local_flush_tlb() __flush_tlb()
>>> -
>>>   #define flush_tlb_mm(mm)                        \
>>>           flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
>>> --- a/arch/x86/kernel/cpu/mtrr/generic.c
>>> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
>>> @@ -761,7 +761,7 @@ static void prepare_set(void) __acquires
>>>       /* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
>>>       count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>>> -    __flush_tlb();
>>> +    flush_tlb_local();
>>>       /* Save MTRR state */
>>>       rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>>> @@ -778,7 +778,7 @@ static void post_set(void) __releases(se
>>>   {
>>>       /* Flush TLBs (no need to flush caches - they are disabled) */
>>>       count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>>> -    __flush_tlb();
>>> +    flush_tlb_local();
>>>       /* Intel (P6) standard MTRRs */
>>>       mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>>> --- a/arch/x86/kernel/paravirt.c
>>> +++ b/arch/x86/kernel/paravirt.c
>>> @@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn
>>>       return insn_len;
>>>   }
>>> -static void native_flush_tlb(void)
>>> -{
>>> -    __native_flush_tlb();
>>> -}
>>> -
>>>   /*
>>>    * Global pages have to be flushed a bit differently. Not a real
>>>    * performance problem because this does not happen often.
>>> @@ -359,7 +354,7 @@ struct paravirt_patch_template pv_ops =
>>>   #endif /* CONFIG_PARAVIRT_XXL */
>>>       /* Mmu ops. */
>>> -    .mmu.flush_tlb_user    = native_flush_tlb,
>>> +    .mmu.flush_tlb_user    = native_flush_tlb_local,
>>>       .mmu.flush_tlb_kernel    = native_flush_tlb_global,
>>>       .mmu.flush_tlb_one_user    = native_flush_tlb_one_user,
>>>       .mmu.flush_tlb_others    = native_flush_tlb_others,
>>> --- a/arch/x86/mm/mem_encrypt.c
>>> +++ b/arch/x86/mm/mem_encrypt.c
>>> @@ -134,7 +134,7 @@ static void __init __sme_early_map_unmap
>>>           size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
>>>       } while (size);
>>> -    __native_flush_tlb();
>>> +    flush_tlb_local();
>>
>> This invoked __native_flush_tlb() because of how early it is called and 
>> the paravirt ops support isn't set up yet, resulting in a crash if not 
>> invoking the native version directly. So this needs a "native" version 
>> of the tlb flush to invoke.
> 
> I don't think this is still true. With my rework of pvops to have all
> functions in one struct which is initialized statically initially
> everything should work from the time the kernel is mapped.
> 
> In case it doesn't there is something very wrong IMO.

The memory encryption support was implemented in 4.14, so it's quite 
possible that this isn't an issue now. I'll test out the patch and verify 
it. What release did your pvops rework land in?

Thanks,
Tom

> 
> 
> Juergen

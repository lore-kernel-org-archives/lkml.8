Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D0C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4724821924
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgDQOl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:41:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E36C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:41:27 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPSB9-0001HI-BB; Fri, 17 Apr 2020 16:41:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CDE79104096; Fri, 17 Apr 2020 16:41:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 4/5] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <20200408090229.16467-5-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com> <20200408090229.16467-5-sblbir@amazon.com>
Date:   Fri, 17 Apr 2020 16:41:14 +0200
Message-ID: <87mu7akwdx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:
 
> +static void *l1d_flush_pages;
> +static DEFINE_MUTEX(l1d_flush_mutex);
> +
> +int enable_l1d_flush_for_task(struct task_struct *tsk)

static ?

> +{
> +	struct page *page;
> +	int ret = 0;
> +
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
> +		goto done;
> +
> +	page = READ_ONCE(l1d_flush_pages);
> +	if (unlikely(!page)) {
> +		mutex_lock(&l1d_flush_mutex);
> +		if (!l1d_flush_pages) {
> +			l1d_flush_pages = alloc_l1d_flush_pages();
> +			if (!l1d_flush_pages) {
> +				mutex_unlock(&l1d_flush_mutex);
> +				return -ENOMEM;
> +			}
> +		}
> +		mutex_unlock(&l1d_flush_mutex);
> +	}

So this is +/- the mutex the same code as KVM has. Why is this not moved
into l1d_flush.c, i.e. 

static void *l1d_flush_pages;
static DEFINE_MUTEX(l1d_flush_mutex);

int l1d_flush_init(void)
{
	int ret;
        
	if (static_cpu_has(X86_FEATURE_FLUSH_L1D) || l1d_flush_pages)
		return 0;

	mutex_lock(&l1d_flush_mutex);
	if (!l1d_flush_pages)
		l1d_flush_pages = l1d_flush_alloc_pages();
        ret = l1d_flush_pages ? 0 : -ENOMEM;        
	mutex_unlock(&l1d_flush_mutex);
        return ret;
}
EXPORT_SYMBOL_GPL(l1d_flush_init);

which removes the export of l1d_flush_alloc_pages() and gets rid of the
cleanup counterpart. In a real world deployment unloading of VMX if used
once is unlikely and with the task based one you end up with these pages
'leaked' anyway if used once.

Can we please make this simple and consistent?

> +done:
> +	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return ret;
> +}
> +
> +int disable_l1d_flush_for_task(struct task_struct *tsk)

static void?

> +{
> +	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return 0;
> +}
> +
> +int arch_prctl_l1d_flush_get(struct task_struct *tsk)
> +{
> +	return test_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +}
> +
> +int arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable)
> +{
> +	if (enable)
> +		return enable_l1d_flush_for_task(tsk);
> +	return disable_l1d_flush_for_task(tsk);
> +}

If any other architecture enables this, then it will have _ALL_ of this
code duplicated. So we should rather have:

  - CONFIG_FLUSH_L1D which gets selected by features requesting
    it, i.e. X86 + VMX

  - CONFIG_FLUSH_L1D_PRCTL which gets selected by architectures
    supporting it, i.e. X86. This selects CONFIG_FLUSH_L1D and enables
    the prctl logic.

  - arch/xxx/include/asm/l1d_flush.h which has for x86:

    #include <linux/l1d_flush.h>
    #include <asm/thread_info.h>

    #define L1D_CACHE_ORDER 4

    static inline bool arch_has_l1d_flush_hw(void)
    {
    	return static_cpu_has(X86_FEATURE_FLUSH_L1D);
    }

    // This is to make the allocation function conditional or if an
    // architecture knows upfront compile time optimized.

    static inline void arch_l1d_flush(void *pages, unsigned long options)
    {
        if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
        	...
                return;
        }

        if (options & POPULATE_TLB)
        	l1d_flush_populate_tlb(pages);
        l1d_flush_sw(pages);
    }

    // The option bits go into linux/l1d_flush.h and the asm header has
    // exactly one file which includes it: lib/l1d_flush.c
    //
    // All other places (VMX, arch context switch code) include 
    // linux/l1d_flush.h which also contains the prototypes for
    // l1d_flush_init() and l1d_flush().

  - Have l1d_flush_init() and the alloc function in lib/l1d_flush.c

  - The flush invocation in lib/l1d_flush.c:

    void l1d_flush(unsigned long options)
    {
   	arch_l1d_flush(l1d_flush_pages, options);
    }
    EXPORT_SYMBOL_GPL(l1d_flush);

  - All architectures have to use TIF_SPEC_FLUSH_L1D if they want to
    support the prctl.

    So all of the above arch_prctl*() stuff becomes generic and sits in
    lib/l1d_flush.c hidden behind CONFIG_FLUSH_L1D_PRCTL.

    The only architecture specific bits are in the actual context switch
    code.

Hmm?

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..42cb3038c81a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -238,4 +238,8 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +/* Flush L1D on context switch (mm) */
> +#define PR_SET_L1D_FLUSH		59
> +#define PR_GET_L1D_FLUSH		60
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index d325f3ab624a..578aa8b6d87e 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2262,6 +2262,16 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  	return -EINVAL;
>  }
>  
> +int __weak arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable)
> +{
> +	return -EINVAL;
> +}
> +
> +int __weak arch_prctl_l1d_flush_get(struct task_struct *t)
> +{
> +	return -EINVAL;
> +}
> +
>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
>  
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> @@ -2514,6 +2524,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>  		break;
> +	case PR_SET_L1D_FLUSH:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_prctl_l1d_flush_set(me, arg2);
> +		break;
> +	case PR_GET_L1D_FLUSH:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_prctl_l1d_flush_get(me);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;

The prctl itself looks fine to me.

Thanks,

        tglx


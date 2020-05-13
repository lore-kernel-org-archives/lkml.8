Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C50207EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgEMP2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgEMP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:28:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD42C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:28:06 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYtIX-0007C3-Pu; Wed, 13 May 2020 17:27:53 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3D63D100605; Wed, 13 May 2020 17:27:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v6 5/6] Optionally flush L1D on context switch
In-Reply-To: <20200510014803.12190-6-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-6-sblbir@amazon.com>
Date:   Wed, 13 May 2020 17:27:53 +0200
Message-ID: <878shv3ldy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:

> Implement a mechanism to selectively flush the L1D cache. The goal is to
> allow tasks that are paranoid due to the recent snoop assisted data sampling
> vulnerabilites, to flush their L1D on being switched out.  This protects
> their data from being snooped or leaked via side channels after the task
> has context switched out.
>
> There are two scenarios we might want to protect against, a task leaving
> the CPU with data still in L1D (which is the main concern of this patch),
> the second scenario is a malicious task coming in (not so well trusted)
> for which we want to clean up the cache before it starts. Only the case
> for the former is addressed.
>
> A new thread_info flag TIF_SPEC_FLUSH_L1D is added to track tasks which
> opt-into L1D flushing. cpu_tlbstate.last_user_mm_spec is used to convert
> the TIF flags into mm state (per cpu via last_user_mm_spec) in
> cond_mitigation(), which then used to do decide when to call flush_l1d().
>
> Add prctl()'s to opt-in to the L1D cache on context switch out, the
> existing mechanisms of tracking prev_mm via cpu_tlbstate is
> reused to track state of the tasks and to flush the L1D cache.
> The prctl interface is generic and can be ported over to other
> architectures.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/thread_info.h |  7 ++++-
>  arch/x86/mm/tlb.c                  | 44 ++++++++++++++++++++++++++++--
>  include/uapi/linux/prctl.h         |  4 +++
>  kernel/sys.c                       | 20 ++++++++++++++
>  4 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 8de8ceccb8bc..67de693d9ba1 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -84,7 +84,7 @@ struct thread_info {
>  #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>  #define TIF_SECCOMP		8	/* secure computing */
>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
> -#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
> +#define TIF_SPEC_FLUSH_L1D	10	/* Flush L1D on mm switches (processes) */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
>  #define TIF_UPROBE		12	/* breakpointed or singlestepping */
>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
> @@ -96,6 +96,7 @@ struct thread_info {
>  #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
>  #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
>  #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
> +#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
>  #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
>  #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
>  #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
> @@ -132,6 +133,7 @@ struct thread_info {
>  #define _TIF_ADDR32		(1 << TIF_ADDR32)
>  #define _TIF_X32		(1 << TIF_X32)
>  #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
> +#define _TIF_SPEC_FLUSH_L1D	(1 << TIF_SPEC_FLUSH_L1D)

Bah. These defines are ordered in the same way as the TIF defines....

>  /*
> - * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
> + * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
>   * stored in cpu_tlb_state.last_user_mm_spec.
>   */
>  #define LAST_USER_MM_IBPB	0x1UL
> -#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
> +#define LAST_USER_MM_L1D_FLUSH	0x2UL
> +#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)

You lost

+       BUILD_BUG_ON(TIF_SPEC_FLUSH_L1D != TIF_SPEC_IB + 1);

from patch I gave you.

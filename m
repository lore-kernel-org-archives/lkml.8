Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84F5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1D920657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHSA6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:58:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:24920 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHSA63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:58:29 -0400
IronPort-SDR: zL93azRjQxXWuHMBXudIO16Tgu6ukyIDDoTT53Y6BEtcwagTA/dKwfPeFqPC2h0qeGLitp//mg
 qCAfQub8XRXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="156100347"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="156100347"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 17:58:28 -0700
IronPort-SDR: wlO/uBnVpHem/P2UcCaELNv/WywFQxBYmZh7Hi8juyQVPQKnNcOUubfirWTqWZWpNXyW6Vbzv9
 /SqTKGvo7F2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="320290486"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2020 17:58:28 -0700
Date:   Tue, 18 Aug 2020 18:00:19 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [PATCH] x86/cpu: Fix typos and improve the comments in
 sync_core()
Message-ID: <20200819010019.GA7074@ranerica-svr.sc.intel.com>
References: <20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com>
 <159767927411.3192.1923111080573965673.tip-bot2@tip-bot2>
 <20200818053130.GA3161093@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818053130.GA3161093@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 07:31:30AM +0200, Ingo Molnar wrote:
> 
> * tip-bot2 for Ricardo Neri <tip-bot2@linutronix.de> wrote:
> 
> > --- a/arch/x86/include/asm/sync_core.h
> > +++ b/arch/x86/include/asm/sync_core.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/preempt.h>
> >  #include <asm/processor.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/special_insns.h>
> >  
> >  #ifdef CONFIG_X86_32
> >  static inline void iret_to_self(void)
> > @@ -54,14 +55,23 @@ static inline void iret_to_self(void)
> >  static inline void sync_core(void)
> >  {
> >  	/*
> > +	 * The SERIALIZE instruction is the most straightforward way to
> > +	 * do this but it not universally available.
> > +	 */
> > +	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> > +		serialize();
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * For all other processors, there are quite a few ways to do this.
> > +	 * IRET-to-self is nice because it works on every CPU, at any CPL
> > +	 * (so it's compatible with paravirtualization), and it never exits
> > +	 * to a hypervisor. The only down sides are that it's a bit slow
> > +	 * (it seems to be a bit more than 2x slower than the fastest
> > +	 * options) and that it unmasks NMIs.  The "push %cs" is needed
> > +	 * because, in paravirtual environments, __KERNEL_CS may not be a
> > +	 * valid CS value when we do IRET directly.
> 
> So there's two typos in the new comments, there are at least two 
> misapplied commas, it departs from existing style, and there's a typo 
> in the existing comments as well.
> 
> Also, before this patch the 'compiler barrier' comment was valid for 
> the whole function (there was no branching), but after this patch it 
> reads of it was only valid for the legacy IRET-to-self branch.
> 
> Which together broke my detector and triggered a bit of compulsive 
> bike-shed painting. ;-) See the resulting patch below.
> 
> Thanks,
> 
> 	Ingo
> 
> ================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Tue, 18 Aug 2020 07:24:05 +0200
> Subject: [PATCH] x86/cpu: Fix typos and improve the comments in sync_core()
> 
> - Fix typos.
> 
> - Move the compiler barrier comment to the top, because it's valid for the
>   whole function, not just the legacy branch.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/sync_core.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
> index 4631c0f969d4..0fd4a9dfb29c 100644
> --- a/arch/x86/include/asm/sync_core.h
> +++ b/arch/x86/include/asm/sync_core.h
> @@ -47,16 +47,19 @@ static inline void iret_to_self(void)
>   *
>   *  b) Text was modified on a different CPU, may subsequently be
>   *     executed on this CPU, and you want to make sure the new version
> - *     gets executed.  This generally means you're calling this in a IPI.
> + *     gets executed.  This generally means you're calling this in an IPI.
>   *
>   * If you're calling this for a different reason, you're probably doing
>   * it wrong.
> + *
> + * Like all of Linux's memory ordering operations, this is a
> + * compiler barrier as well.
>   */
>  static inline void sync_core(void)
>  {
>  	/*
>  	 * The SERIALIZE instruction is the most straightforward way to
> -	 * do this but it not universally available.
> +	 * do this, but it is not universally available.

Indeed, I missed this grammar error.

>  	 */
>  	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
>  		serialize();
> @@ -67,10 +70,10 @@ static inline void sync_core(void)
>  	 * For all other processors, there are quite a few ways to do this.
>  	 * IRET-to-self is nice because it works on every CPU, at any CPL
>  	 * (so it's compatible with paravirtualization), and it never exits
> -	 * to a hypervisor. The only down sides are that it's a bit slow
> +	 * to a hypervisor.  The only downsides are that it's a bit slow
>  	 * (it seems to be a bit more than 2x slower than the fastest
> -	 * options) and that it unmasks NMIs.  The "push %cs" is needed
> -	 * because, in paravirtual environments, __KERNEL_CS may not be a
> +	 * options) and that it unmasks NMIs.  The "push %cs" is needed,
> +	 * because in paravirtual environments __KERNEL_CS may not be a

I didn't realize that the double spaces after the period were part of the
style.

FWIW,

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

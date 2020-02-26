Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D8BC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED824656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKb208fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgBZVlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:41:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41103 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBZVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:41:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so218775plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wf+hQg66hhCzpMAXWHM+HuBnD6U1j60tq45EYdsucCI=;
        b=mKb208fdH4VjrwAPiQEKqixvPOAB9C95cgTfKiEVpaRU9pMoAh2U424X2d1KOS351h
         v3QCIIUBYYnbICJoZx66ooI34HW+uVxKVR5ZWT6qVHHx9+aGuRZ8VDIMeA/2CqbHpdlI
         OGf1aiGEA7cFYbwiUUymDfbs0m5xFpVfrYVAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wf+hQg66hhCzpMAXWHM+HuBnD6U1j60tq45EYdsucCI=;
        b=WO72VcxvYpJkZ6C5rgBcrgqjtJKQqMmLQtgRIj71c6ZTb7aj5iL2KMIYpCv90EqtuF
         E6yS1bzu3PtYg/CCfcdMSb8yKVdRyAFMXB7fNtUIAujobEjMAhIgJumQTmzGy7Y903bc
         UW1DusxVCYvGrwwJyXboQbWhCYJvPGsMTpbzOSk1aREubqM22bgieEGycikLCxfmjIZr
         bE7b1qinPE+6OMzGKGTSJMnmbAWM4/q9z8maGz738d7U3RuDCkJvYb4vMG/WJT9KpNda
         MojUMkPkaFLX/8kNv2neXbX3unT6HnVkbV5G3RCvZhKBOUz4MJbfiWHLSnJ8gBsP9VKJ
         rsRA==
X-Gm-Message-State: APjAAAWH8OehRE+jWzlZsIZ/B8MLSRFABks+KqblOoTfnDDeyQIfqSGS
        Wv/l4hZy9vW7Fx65nQ0GPZvHjA==
X-Google-Smtp-Source: APXvYqxpYrxZJdpgyDEYgt85Ahen+tbff9vS44VZV/k6JWS5lmBiIhwZErrVfzYTUAItJHsrFUDOuA==
X-Received: by 2002:a17:90a:fa8d:: with SMTP id cu13mr1177001pjb.68.1582753280049;
        Wed, 26 Feb 2020 13:41:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm4283587pfq.33.2020.02.26.13.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:41:19 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:41:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 07/11] arm64: unify native/compat instruction skipping
Message-ID: <202002261341.17C9BC2222@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
 <20200226155714.43937-8-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-8-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:10PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Skipping of an instruction on AArch32 works a bit differently from
> AArch64, mainly due to the different CPSR/PSTATE semantics.
> 
> Currently arm64_skip_faulting_instruction() is only suitable for
> AArch64, and arm64_compat_skip_faulting_instruction() handles the IT
> state machine but is local to traps.c.
> 
> Since manual instruction skipping implies a trap, it's a relatively
> slow path.
> 
> So, make arm64_skip_faulting_instruction() handle both compat and
> native, and get rid of the arm64_compat_skip_faulting_instruction()
> special case.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/traps.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b8c714dda851..bc9f4292bfc3 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -272,6 +272,8 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
>  
> +static void advance_itstate(struct pt_regs *regs);
> +
>  void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  {
>  	regs->pc += size;
> @@ -282,6 +284,9 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  	 */
>  	if (user_mode(regs))
>  		user_fastforward_single_step(current);
> +
> +	if (regs->pstate & PSR_MODE32_BIT)
> +		advance_itstate(regs);
>  }
>  
>  static LIST_HEAD(undef_hook);
> @@ -644,19 +649,12 @@ static void advance_itstate(struct pt_regs *regs)
>  	compat_set_it_state(regs, it);
>  }
>  
> -static void arm64_compat_skip_faulting_instruction(struct pt_regs *regs,
> -						   unsigned int sz)
> -{
> -	advance_itstate(regs);
> -	arm64_skip_faulting_instruction(regs, sz);
> -}
> -
>  static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
>  {
>  	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
>  
>  	pt_regs_write_reg(regs, reg, arch_timer_get_rate());
> -	arm64_compat_skip_faulting_instruction(regs, 4);
> +	arm64_skip_faulting_instruction(regs, 4);
>  }
>  
>  static const struct sys64_hook cp15_32_hooks[] = {
> @@ -676,7 +674,7 @@ static void compat_cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
>  
>  	pt_regs_write_reg(regs, rt, lower_32_bits(val));
>  	pt_regs_write_reg(regs, rt2, upper_32_bits(val));
> -	arm64_compat_skip_faulting_instruction(regs, 4);
> +	arm64_skip_faulting_instruction(regs, 4);
>  }
>  
>  static const struct sys64_hook cp15_64_hooks[] = {
> @@ -697,7 +695,7 @@ void do_cp15instr(unsigned int esr, struct pt_regs *regs)
>  		 * There is no T16 variant of a CP access, so we
>  		 * always advance PC by 4 bytes.
>  		 */
> -		arm64_compat_skip_faulting_instruction(regs, 4);
> +		arm64_skip_faulting_instruction(regs, 4);
>  		return;
>  	}
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook

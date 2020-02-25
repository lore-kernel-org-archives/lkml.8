Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CEC35E1C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4032176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+pDnoGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgBYVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:10:18 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36585 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgBYVKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:10:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so278380pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJKpOOFGEfUAGGLqO1NUhiGzKjVzNOK2IgBZIyJHxc0=;
        b=h+pDnoGOYsk+E8Wt6TpmxUxdwV6kjF4atGpRldLId/Yw8w9WfMNnrM8XJReblD9SwC
         8LeJhqiafUtArcvC4wLH1Ri6+yqFHMw0jvz4WTjgvML3xSZUD/c8wIZT5mi6IVRxMhSV
         aNZy8mj/AVPfjzspIlHT7j9dhhuOVWKWW+0mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJKpOOFGEfUAGGLqO1NUhiGzKjVzNOK2IgBZIyJHxc0=;
        b=S8VIsSjTJIG9lrlpgrh8nl/qVcpWdg6U7eGtueQ6jW0Q4W+Jq6ni42PcXwvn6xtfyD
         TkAh3B4pDFvVTYNVh+Grx9yT07ttXJtA1z1TW4RKmu72NChFsfRuTMkDNwFEAl0CBhVt
         vqFno2VZA3SGzb25VdS0lpsHRtdLCsr6ZQU9szQRkfniPGjx3VscK/uwPOKblf/yIE9H
         gjagra0qAIfqXzdu7vK98ebnBoR/FFVmKakh8880AtB/u/vGfwdeFmjoWqDSumtB36nh
         5mz5zNDJET07JSyKXV1S9ryxhWt9Z+hB7/mN+uyjKhKd207QQi0sJrO4HJNLRZzZir5d
         Y7JA==
X-Gm-Message-State: APjAAAU5snO+5eEPQX5UiBNG6CduFp/0+IbOJDxt9BuN+Q1+ZKRpnq63
        A+8RK5rZ7OFWDHeHbNINn4rPWA==
X-Google-Smtp-Source: APXvYqzQAbfYXF5TtmiNKwyw9CCTemc+ykrjzmXEtfYjXSRlSbhEiGrlXLqSnZ/Ps0gefcUFE6oD5g==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr467640pls.310.1582665016973;
        Tue, 25 Feb 2020 13:10:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w81sm18583961pff.95.2020.02.25.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:10:16 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:10:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 18/27] x86/cet/shstk: Introduce WRUSS instruction
Message-ID: <202002251309.E238DFEEB4@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-19-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:26AM -0800, Yu-cheng Yu wrote:
> WRUSS is a new kernel-mode instruction but writes directly to user Shadow
> Stack (SHSTK) memory.  This is used to construct a return address on SHSTK
> for the signal handler.
> 
> This instruction can fault if the user SHSTK is not valid SHSTK memory.
> In that case, the kernel does a fixup.

Since these functions aren't used in this patch, should this get merged
with patch 19?

-Kees

> 
> v4:
> - Change to asm goto.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/special_insns.h | 32 ++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 6d37b8fcfc77..1b9b2e79c353 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -222,6 +222,38 @@ static inline void clwb(volatile void *__p)
>  		: [pax] "a" (p));
>  }
>  
> +#ifdef CONFIG_X86_INTEL_CET
> +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	asm_volatile_goto("1: wrussd %1, (%0)\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: "r" (addr), "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EPERM;
> +}
> +#else
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	WARN_ONCE(1, "%s used but not supported.\n", __func__);
> +	return -EFAULT;
> +}
> +#endif
> +
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> +{
> +	asm_volatile_goto("1: wrussq %1, (%0)\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: "r" (addr), "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EPERM;
> +}
> +#endif /* CONFIG_X86_INTEL_CET */
> +
>  #define nop() asm volatile ("nop")
>  
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook

Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD7EC35E1D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B16321927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="er2wAeec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgBYVWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:22:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgBYVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:22:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so217310pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2zye8CzKnlnL3hA+RUHlbvvqNNCO2c7gcM4lHhCQD7I=;
        b=er2wAeecxK4UnrRNkC9cYYNiionMSp5Smjcbl6UiT0KNH69ScSdC7Jsx08Dy0furLI
         jWCR/e8g60UHKVgZgkBWxWKRSwhcOEQym0+qXug/oVndKzvKxq60+XOxqdlr0IwaMYKC
         OiAkSi9GgJSOqn1fDGi9cbYAWXPsC7HlVh27E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2zye8CzKnlnL3hA+RUHlbvvqNNCO2c7gcM4lHhCQD7I=;
        b=DQw9w5VCQM6UNjaTpYh/oypKhOW7G6Q35saQLtwacaXaKnttKFY9AzTQTOZ+DESYSh
         ybZbQ9hg3i4eqgHvMhS23eP0M7X/WVB450bJuYlciG3B1geHBA8affGUxiar1aQcngcB
         +/YtRLPHmlYWKtYJSfC/8pnyAL+ZUlrTqznnHax+HcZ28tbQEOZmrwscF434/mv5c04v
         pcXlii5ERiRpuOhQrzgfTw6f0iCvj4yX96BRNS93E3JezJ519eCeQX/x40M5OM+uwXkp
         2igce2JdTnpEWPHu9MveA24jHFfEVBQru+Q+0eart99N/zKc/MbxLRqMP0D1tDKH/sbU
         XZ6A==
X-Gm-Message-State: APjAAAUzW91a+owEw99uC7shaSb9gfXEDPO9Md9Q+wS+42skTu7uQtw5
        LUbeM0JjWrYoXt9cz/O8xbaObQ==
X-Google-Smtp-Source: APXvYqxxA9M2zklRloHbo/iqZPq+qupQCqxsxip0cOp0qvCs8wbLa9ELHMTKt7NR8+CPB8YZDGuC8A==
X-Received: by 2002:a63:e4d:: with SMTP id 13mr433732pgo.343.1582665769122;
        Tue, 25 Feb 2020 13:22:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7sm17525973pgp.44.2020.02.25.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:22:48 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:22:47 -0800
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
Subject: Re: [RFC PATCH v9 24/27] x86/cet/shstk: ELF header parsing for
 Shadow Stack
Message-ID: <202002251321.6C21B71F@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-25-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-25-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:32AM -0800, Yu-cheng Yu wrote:
> Check an ELF file's .note.gnu.property, and setup Shadow Stack if the
> application supports it.
> 
> v9:
> - Change cpu_feature_enabled() to static_cpu_has().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/Kconfig             |  2 ++
>  arch/x86/include/asm/elf.h   | 13 +++++++++++++
>  arch/x86/kernel/process_64.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6c34b701c588..d1447380e02e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1987,6 +1987,8 @@ config X86_INTEL_SHADOW_STACK_USER
>  	select ARCH_USES_HIGH_VMA_FLAGS
>  	select X86_INTEL_CET
>  	select ARCH_HAS_SHSTK
> +	select ARCH_USE_GNU_PROPERTY
> +	select ARCH_BINFMT_ELF_STATE
>  	---help---
>  	  Shadow Stack (SHSTK) provides protection against program
>  	  stack corruption.  It is active when the kernel has this
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 69c0f892e310..fac79b621e0a 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -367,6 +367,19 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
>  					      int uses_interp);
>  #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
>  
> +#ifdef CONFIG_ARCH_BINFMT_ELF_STATE
> +struct arch_elf_state {
> +	unsigned int gnu_property;
> +};
> +
> +#define INIT_ARCH_ELF_STATE {	\
> +	.gnu_property = 0,	\
> +}
> +
> +#define arch_elf_pt_proc(ehdr, phdr, elf, interp, state) (0)
> +#define arch_check_elf(ehdr, interp, interp_ehdr, state) (0)
> +#endif
> +
>  /* Do not change the values. See get_align_mask() */
>  enum align_flags {
>  	ALIGN_VA_32	= BIT(0),
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 506d66830d4d..99548cde0cc6 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -732,3 +732,34 @@ unsigned long KSTK_ESP(struct task_struct *task)
>  {
>  	return task_pt_regs(task)->sp;
>  }
> +
> +#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
> +int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> +			     bool compat, struct arch_elf_state *state)
> +{
> +	if (type != GNU_PROPERTY_X86_FEATURE_1_AND)
> +		return 0;
> +
> +	if (datasz != sizeof(unsigned int))
> +		return -ENOEXEC;
> +
> +	state->gnu_property = *(unsigned int *)data;
> +	return 0;
> +}
> +
> +int arch_setup_elf_property(struct arch_elf_state *state)
> +{
> +	int r = 0;
> +
> +	memset(&current->thread.cet, 0, sizeof(struct cet_status));
> +
> +	if (static_cpu_has(X86_FEATURE_SHSTK)) {
> +		if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +			r = cet_setup_shstk();
> +		if (r < 0)
> +			return r;

This test is redundant; there's no loop. This can just fall through to
the final return.

-Kees

> +	}
> +
> +	return r;
> +}
> +#endif
> -- 
> 2.21.0
> 

-- 
Kees Cook

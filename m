Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B853C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA37920B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587416107;
	bh=3Rft6Xo+yUX9yKXCCAXSFprstMdX0LEXPTtKv5UxrqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FKcvtQ9PczmhqbtqZq8v31oIusEPmNIAltLGYrj460CmLwR0bi/ojAepplPKwHvQz
	 2LrYHiTATQXIS0A1WI4RkwhXiQFwmifd3EdBkv3wxR7IkrPYxyVXJ01koc+jqnYYVq
	 hGuM+ytvZoIzlVh1kXlikFae2YGDv/sTm9XBA1Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgDTUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDTUzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:55:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B098206E9;
        Mon, 20 Apr 2020 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587416104;
        bh=3Rft6Xo+yUX9yKXCCAXSFprstMdX0LEXPTtKv5UxrqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCVwMIiUex03OuMbSo1VvNRl1hdp13/WfOl0GKswvu3nBoHT1SxNaGZ63K5poBEwk
         CFbl2CKaxWkijsFgfx/uGBWozQbk3I0p+2+rK4tOQqAlDXzMS8o2pN72/mp7qypVK0
         tGiUnz4ZcN/2NHsEiBMou/2dPAI+MKqgJ89DTi4A=
Date:   Mon, 20 Apr 2020 21:54:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <20200420205458.GC29998@willie-the-truck>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324203231.64324-6-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> Allow for a randomized stack offset on a per-syscall basis, with roughly
> 5 bits of entropy.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/Kconfig          |  1 +
>  arch/arm64/kernel/syscall.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0b30e884e088..4d5aa4959f72 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -127,6 +127,7 @@ config ARM64
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index a12c0c88d345..238dbd753b44 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -5,6 +5,7 @@
>  #include <linux/errno.h>
>  #include <linux/nospec.h>
>  #include <linux/ptrace.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  
>  #include <asm/daifflags.h>
> @@ -42,6 +43,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  {
>  	long ret;
>  
> +	add_random_kstack_offset();
> +
>  	if (scno < sc_nr) {
>  		syscall_fn_t syscall_fn;
>  		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
> @@ -51,6 +54,13 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	}
>  
>  	regs->regs[0] = ret;
> +
> +	/*
> +	 * Since the compiler chooses a 4 bit alignment for the stack,
> +	 * let's save one additional bit (9 total), which gets us up
> +	 * near 5 bits of entropy.
> +	 */
> +	choose_random_kstack_offset(get_random_int() & 0x1FF);

Hmm, this comment doesn't make any sense to me. I mean, I get that 0x1ff
is 9 bits, and that is 4+5 but so what?

Will

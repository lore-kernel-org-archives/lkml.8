Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71810C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D470214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587577571;
	bh=BZ6+GxqnknwEXTVUtex2UCZYN1TnyT2nFbqPEZvID5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ScbFc8FoxAWIABNX4DdPm6WfHdlubeX0+uzsc2HRtqrZfZIr2c53YYRm2KHEehoGN
	 +Q/FeJRJe81CnMUT1sstn1zN0bqdAxjFrNQBNZW6azCaZBq2oeelcXZu4kDPBsAxaP
	 SKcXr0urahs8pOmjUtTD2muwYNA1U5st4Snqut5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDVRqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDVRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:46:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61B420882;
        Wed, 22 Apr 2020 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587577569;
        bh=BZ6+GxqnknwEXTVUtex2UCZYN1TnyT2nFbqPEZvID5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xeCqLIAIf4jizG2Ckht2qwltfYk8W5t7dkqurW5+DudPXgEs52Se1z8kA6BYPOJvg
         zWeehGFavyojT3LhGVeOWARgj6LEsxC0YHGvVxWT4c7cDFTYsZV2It6kXt09f/QSfF
         HpAJI7pNWvgcdxfndttxPkynvgEj5eZLoxc5MmEQ=
Date:   Wed, 22 Apr 2020 18:46:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 03/12] scs: add support for stack usage debugging
Message-ID: <20200422174602.GB3121@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200421021453.198187-1-samitolvanen@google.com>
 <20200421021453.198187-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421021453.198187-4-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 07:14:44PM -0700, Sami Tolvanen wrote:
> Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
> also prints out the highest shadow stack usage per process.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/scs.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 7eea2d97bd2d..147917e31adf 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -68,6 +68,43 @@ int scs_prepare(struct task_struct *tsk, int node)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +static unsigned long __scs_used(struct task_struct *tsk)
> +{
> +	unsigned long *p = __scs_base(tsk);
> +	unsigned long *end = __scs_magic(p);
> +	unsigned long s = (unsigned long)p;
> +
> +	while (p < end && READ_ONCE_NOCHECK(*p))
> +		p++;
> +
> +	return (unsigned long)p - s;
> +}
> +
> +static void scs_check_usage(struct task_struct *tsk)
> +{
> +	static unsigned long highest;
> +	unsigned long used = __scs_used(tsk);
> +	unsigned long prev;
> +	unsigned long curr = highest;
> +
> +	while (used > curr) {
> +		prev = cmpxchg(&highest, curr, used);

I think this can be cmpxchg_relaxed(), since we don't care about ordering
here afaict.

With that:

Acked-by: Will Deacon <will@kernel.org>

Cheers,

Will

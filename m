Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86BCC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33FA21D94
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403070;
	bh=wXEAfThnDs14N1G/spAtmfJQE33jZSGAx1cIEKIIuc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GM9xbvv5ApgTb7Bps9J7a+s3oQvtwxAVYjhbntI+Lj1tjF+5L0dnZrxYBl0Mc7ZPi
	 ooDggMXULUc1eKMr6KcEEWYrvhm11rTn9LxS/1hCgkWbBfuGc0lpfJt20FjUQwtQsQ
	 4u8EXRX7uza8vpRKvhmQFgMCa9LKY5QPVjUVAhl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgDTRRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTRRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:17:49 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54EF720B1F;
        Mon, 20 Apr 2020 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403069;
        bh=wXEAfThnDs14N1G/spAtmfJQE33jZSGAx1cIEKIIuc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ph/dGiaW6TygCcuAfJaNmpuzQDZkB3Fcj9NIV3BJO6mMxd7giMQgjXFhuJSUDQYFR
         gZ3RV//pTvooHvX3I1ePN4Q//oI89A9oXCSzfPmLTT3Eh9DIizNl4CnAJKoR6P7BEw
         Y5eQXMPJpUVmD5phFHnzKLJXCdESnzk7IjbYWxfk=
Date:   Mon, 20 Apr 2020 18:17:42 +0100
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
Subject: Re: [PATCH v11 03/12] scs: add support for stack usage debugging
Message-ID: <20200420171741.GC24386@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161245.148813-4-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:12:36AM -0700, Sami Tolvanen wrote:
> Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
> also prints out the highest shadow stack usage per process.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 5245e992c692..ad74d13f2c0f 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -184,6 +184,44 @@ int scs_prepare(struct task_struct *tsk, int node)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +static inline unsigned long scs_used(struct task_struct *tsk)
> +{
> +	unsigned long *p = __scs_base(tsk);
> +	unsigned long *end = scs_magic(p);
> +	unsigned long s = (unsigned long)p;
> +
> +	while (p < end && READ_ONCE_NOCHECK(*p))
> +		p++;

I think the expectation is that the caller has already checked that the
stack is not corrupted, so I'd probably throw a couple of underscores
in front of the function name, along with a comment.

Also, is tsk ever != current?

> +
> +	return (unsigned long)p - s;
> +}
> +
> +static void scs_check_usage(struct task_struct *tsk)
> +{
> +	static DEFINE_SPINLOCK(lock);
> +	static unsigned long highest;
> +	unsigned long used = scs_used(tsk);
> +
> +	if (used <= highest)
> +		return;
> +
> +	spin_lock(&lock);
> +
> +	if (used > highest) {
> +		pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
> +			tsk->comm, task_pid_nr(tsk), used);
> +		highest = used;
> +	}
> +
> +	spin_unlock(&lock);

Do you really need this lock? I'd have thought you could cmpxchg()
highest instead.

Will

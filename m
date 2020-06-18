Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B39EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0EE208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgFRQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgFRQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:42:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB6520707;
        Thu, 18 Jun 2020 16:41:59 +0000 (UTC)
Date:   Thu, 18 Jun 2020 12:41:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Use linker magic instead of recasting
 ftrace_ops_list_func()
Message-ID: <20200618124157.0b9b8807@oasis.local.home>
In-Reply-To: <CAG48ez04Fj=1p61KAxAQWZ3f_z073fVUr8LsQgtKA9c-kcHmDQ@mail.gmail.com>
References: <20200617165616.52241bde@oasis.local.home>
        <CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com>
        <20200617183628.3594271d@oasis.local.home>
        <CAG48ez04Fj=1p61KAxAQWZ3f_z073fVUr8LsQgtKA9c-kcHmDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 01:12:37 +0200
Jann Horn <jannh@google.com> wrote:

> static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
> +static ftrace_asm_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
>  {
> +#if FTRACE_FORCE_LIST_FUNC
> +       return ftrace_ops_list_func;
> +#else
>         /*
>          * If this is a dynamic, RCU, or per CPU ops, or we force list func,
>          * then it needs to call the list anyway.
>          */
> -       if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU) ||
> -           FTRACE_FORCE_LIST_FUNC)
> +       if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU))
>                 return ftrace_ops_list_func;
> 
>         return ftrace_ops_get_func(ops);

But ftrace_ops_get_func() returns ftrace_func_t type, wont this complain?

-- Steve


> +#endif
>  }


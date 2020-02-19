Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D4C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0C20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MabFU/LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSRTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:19:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33495 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgBSRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:00 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so1437419ioh.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFFLbtKV1wHoHpSbO1vGKr55xKiOdJlHlqvO+VL5miQ=;
        b=MabFU/LNJ6iK5i7PFe+0avSvRodkDyxJVTzJwbnwlmFp8ec7HckrwZ5WxlPngA3Lbu
         m0uacrHQ6Ij6wWXzRbWXh9cb9byO2GB+jpP06/CxTTIdI31eSIVpKXB5U9enJNcfLFxw
         Dq67E9Hxga7B00YTYr/Eq/p6Cz8AihY8xCBwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFFLbtKV1wHoHpSbO1vGKr55xKiOdJlHlqvO+VL5miQ=;
        b=tng1EtcxiV/x8thSRA+bJBwbuevfDxcWdB7VFPBKUIwTrcCuDyll5LfuArhbQJOokT
         m0s6hvFEI3fZDY294Lr1TF/wL/vJjqQAqgrE0/42rGCgKm/sjapAjn/xB76gZeX4YXKA
         71m3Iu/ab5jELKFDC6VQs+5zP++lv9cUVa5D7CpIQaKI2IkFZNulxNI2B7DnZ+vQck2e
         WtedjctLFQ6tgcmbxk8z5aFo7fkFMDKDcLx3TA5Xzf/4GHADd2xVK3YCY+yJJp0H5KF5
         Jk4nY7VTsV5+SWI0gw7RX2kCfCGukvasjfNbdnogK1tYcfLGaDqw3BcZdwHHAQzOVFJI
         mUmQ==
X-Gm-Message-State: APjAAAUWNgNzcwmA8wrwyT0/psVcyiGPnGxH9BYCm57Wii83IY90ARsL
        FgdBjzvqkjojALR1qvD3MOJMCzoyr9wakNzgqGXJ9Q==
X-Google-Smtp-Source: APXvYqxB0l8/vhLc9U7gaSNF9v5Zi7hFO2pFY075Vik0MUlviJ4M/JnZkM7hLnjg1q0jDOD2pAvydSBAEchSKICMsEY=
X-Received: by 2002:a6b:db0d:: with SMTP id t13mr20864493ioc.171.1582132739221;
 Wed, 19 Feb 2020 09:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72> <20200219121609.45548925@gandalf.local.home>
In-Reply-To: <20200219121609.45548925@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 19 Feb 2020 12:18:48 -0500
Message-ID: <CAEXW_YT1W4ctSt8xc2ErWwRucp2BTdV3FhB3F3iVdGogWAqELg@mail.gmail.com>
Subject: Re: [PATCH] rcu/kprobes: Comment why rcu_nmi_enter() is marked NOKPROBE
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> It's confusing that rcu_nmi_enter() is marked NOKPROBE and
> rcu_nmi_exit() is not. One may think that the exit needs to be marked
> for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
> state back to what it was before rcu_nmi_enter(). But the reason has
> nothing to do with the state of RCU.
>
> The breakpoint handler (int3 on x86) must not have any kprobe on it
> until the kprobe handler is called. Otherwise, it can cause an infinite
> recursion and crash the machine. It just so happens that
> rcu_nmi_enter() is called by the int3 handler before the kprobe handler
> can run, and therefore needs to be marked as NOKPROBE.
>
> Comment this to remove the confusion to why rcu_nmi_enter() is marked
> NOKPROBE but rcu_nmi_exit() is not.
>
> Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1694a6b57ad8..ada7b2b638fb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -846,6 +846,14 @@ void rcu_nmi_enter(void)
>  {
>         rcu_nmi_enter_common(false);
>  }
> +/*
> + * All functions called in the breakpoint trap handler (e.g. do_int3()
> + * on x86), must not allow kprobes until the kprobe breakpoint handler
> + * is called, otherwise it can cause an infinite recursion.
> + * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> + * before the kprobe breakpoint handler is called, thus it must be
> + * marked as NOKPROBE.
> + */
>  NOKPROBE_SYMBOL(rcu_nmi_enter);
>
>  /**

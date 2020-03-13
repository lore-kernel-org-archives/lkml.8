Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD352C2BAEE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90870206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e+obtGsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCMDwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:52:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34069 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCMDwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:52:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id f3so10354119qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ER4yQwvRL6bFJRFz9hkOSe0+qiSsIHfISgRhaLCNYXM=;
        b=e+obtGsMJrNM8VC93u6iDKH6pQiUVW0J+QmWSLfLGxex6nuLo6NkDpCubzWzmHBPzK
         a6TDmhdQpog/5B1h7Wp7OlnvTG1AIxbxkmiFzL2zYN0oUa4y5fYmZWTkdlQUH+8OW+9J
         c/ajjNujOlO0zF617cS5W4r8rDENWu+4SmAp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ER4yQwvRL6bFJRFz9hkOSe0+qiSsIHfISgRhaLCNYXM=;
        b=MUiR5PqAskCjXv60SfEZ3KEK2nwq9meH0LK1RQAMYSltKhCwvuglzHaAq9h025wKi4
         bmMpbJ486ZqqBVqw6MEXQn+bi2TDkUE9hB+fa8CN6V3YtSJ7/h3B6FNzl7wJuw9Z4Swy
         9ZOic3ELu9V0tuLtQ7uMYwATxBDSFYvAAwI0/NFclXD1cXjzgELL8lKB1zaO9byrV7ao
         I9tFU08JY7J7xzRy1AZQ41OWOYouak522f/Y+MGjZO2p//2eV2zU5RB2RIUM0vDRLp1g
         prEqSJLlB5MqEqk2XwBBQ3zsZM3wb14O4BJ8tyqyMK1wv5PWGqLlnrUd/VmVMjwgU1CP
         Rb3w==
X-Gm-Message-State: ANhLgQ1U+KVnBXKeZpHqt+1TDSL568FJEZAOhYocMPcGDaxnZa/8fBLJ
        lxpQZiSF2C+A5LEcdWb+NIaiIg==
X-Google-Smtp-Source: ADFU+vv/2QzBA+A05d6GNkRKznzI55wUVWpJfeZUpugFkkQpSNLqAzNrGDsZ29ruZPq0GJrQvyyahw==
X-Received: by 2002:a37:a6d4:: with SMTP id p203mr11452462qke.184.1584071522866;
        Thu, 12 Mar 2020 20:52:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 131sm28733662qkl.86.2020.03.12.20.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 20:52:02 -0700 (PDT)
Date:   Thu, 12 Mar 2020 23:52:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, "# 5 . 5 . x" <stable@vger.kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 1/2] rcu: Don't acquire lock in NMI
 handler in rcu_nmi_enter_common()
Message-ID: <20200313035201.GB190951@google.com>
References: <20200313024007.GA27492@paulmck-ThinkPad-P72>
 <20200313024046.27622-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313024046.27622-1-paulmck@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 07:40:45PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The rcu_nmi_enter_common() function can be invoked both in interrupt
> and NMI handlers.  If it is invoked from process context (as opposed
> to userspace or idle context) on a nohz_full CPU, it might acquire the
> CPU's leaf rcu_node structure's ->lock.  Because this lock is held only
> with interrupts disabled, this is safe from an interrupt handler, but
> doing so from an NMI handler can result in self-deadlock.
> 
> This commit therefore adds "irq" to the "if" condition so as to only
> acquire the ->lock from irq handlers or process context, never from
> an NMI handler.

I think Peter's new lockdep changes for NMI would also catch this issue.

> 
> Fixes: 5b14557b073c ("rcu: Avoid tick_dep_set_cpu() misordering")

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.5.x
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d3f52c3..f7d3e48 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -825,7 +825,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  			rcu_cleanup_after_idle();
>  
>  		incby = 1;
> -	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> +	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
>  		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
>  		   READ_ONCE(rdp->rcu_urgent_qs) &&
>  		   !READ_ONCE(rdp->rcu_forced_tick)) {
> -- 
> 2.9.5
> 

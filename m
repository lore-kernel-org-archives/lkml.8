Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6196CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCDF2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHaM5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:57:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaM47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07FDDADCD;
        Mon, 31 Aug 2020 12:56:58 +0000 (UTC)
Date:   Mon, 31 Aug 2020 14:56:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com
cc:     peterz@infradead.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Free the trampoline when ftrace_startup()
 fails
In-Reply-To: <20200831122631.28057-1-mbenes@suse.cz>
Message-ID: <alpine.LSU.2.21.2008311455440.16475@pobox.suse.cz>
References: <20200831122631.28057-1-mbenes@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I used Masami's address which did not work. Sorry about that. Should be ok 
now.

On Mon, 31 Aug 2020, Miroslav Benes wrote:

> Commit fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
> missed to remove ops from new ftrace_ops_trampoline_list in
> ftrace_startup() if ftrace_hash_ipmodify_enable() fails there. It may
> lead to BUG if such ops come from a module which may be removed.
> 
> Moreover, the trampoline itself is not freed in this case.
> 
> Fix it by calling ftrace_trampoline_free() during the rollback.
> 
> Fixes: fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
> 
> It would be fair to add
> 
> Fixes: f8b8be8a310a ("ftrace, kprobes: Support IPMODIFY flag to find IP modify conflict")
> 
> too. The situation was a bit more complicated back then though since
> RCU-tasks support was missing.
> 
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 275441254bb5..656d7cb5a78c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2862,6 +2862,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
>  		__unregister_ftrace_function(ops);
>  		ftrace_start_up--;
>  		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
> +		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> +			ftrace_trampoline_free(ops);
>  		return ret;
>  	}
>  
> -- 
> 2.28.0
> 


Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A7D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgG1NCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbgG1NCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:02:14 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAB5206D8;
        Tue, 28 Jul 2020 13:02:13 +0000 (UTC)
Date:   Tue, 28 Jul 2020 09:02:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH 2/2] ftrace: setup correct flags before replace code of
 module rec
Message-ID: <20200728090211.4c94a14d@oasis.local.home>
In-Reply-To: <20200728102720.46837-2-zhouchengming@bytedance.com>
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
        <20200728102720.46837-2-zhouchengming@bytedance.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 18:27:20 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> When module loaded and enabled, we will use __ftrace_replace_code
> for module if any ftrace_ops referenced it found. But we will get
> wrong ftrace_addr for module rec in ftrace_get_addr_new, because
> rec->flags has not been setup correctly.
> So setup correct rec->flags when we call referenced_filters to find
> ftrace_ops references it.

This is somewhat correct ;-)

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/trace/ftrace.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index fca01a168ae5..00087dea0174 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6190,8 +6190,17 @@ static int referenced_filters(struct dyn_ftrace *rec)
>  	int cnt = 0;
>  
>  	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
> -		if (ops_references_rec(ops, rec))
> -		    cnt++;
> +		if (ops_references_rec(ops, rec)) {

> +			cnt++;
> +			if (ops->flags & FTRACE_OPS_FL_DIRECT)
> +				rec->flags |= FTRACE_FL_DIRECT;

The above should be:

			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
				continue;
			cnt++;

The direct flag is *very* special, and should not be set automatically
like this.

Probably should add the same kind of warning and skip for
FTRACE_OPS_FL_IPMODIFY.

> +			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
> +				rec->flags |= FTRACE_FL_REGS;

The above is definitely a bug fix. I'm thinking this patch should be
broken up into two. One with just this update (and the clear below),
and the rest later. As this should be backported to stable.

> +			if (cnt == 1 && ops->trampoline)
> +				rec->flags |= FTRACE_FL_TRAMP;
> +			else
> +				rec->flags &= ~FTRACE_FL_TRAMP;

The above is correct, but not critical that it would need to be
backported.

Thanks!

-- Steve

> +		}
>  	}
>  
>  	return cnt;
> @@ -6373,7 +6382,8 @@ void ftrace_module_enable(struct module *mod)
>  			cnt += referenced_filters(rec);
>  
>  		/* This clears FTRACE_FL_DISABLED */
> -		rec->flags = cnt;
> +		rec->flags &= ~FTRACE_FL_DISABLED;
> +		rec->flags += cnt;
>  
>  		if (ftrace_start_up && cnt) {
>  			int failed = __ftrace_replace_code(rec, 1);


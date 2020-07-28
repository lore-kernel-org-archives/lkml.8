Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB79C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7672920714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgG1MxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgG1MxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:53:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B93F206D8;
        Tue, 28 Jul 2020 12:53:21 +0000 (UTC)
Date:   Tue, 28 Jul 2020 08:53:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH 1/2] ftrace: clear module from hash of all ftrace ops
Message-ID: <20200728085320.6b04e03f@oasis.local.home>
In-Reply-To: <20200728102720.46837-1-zhouchengming@bytedance.com>
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 18:27:19 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> We should clear module from hash of all ops on ftrace_ops_list when
> module going, or the ops including these modules will be matched
> wrongly by new module loaded later.

This is really up to the owner of the hash and not the registered
system.

If we want, we could register some kind of callback table for all
ftrace_ops to have this updated, but the current code is incorrect.

Like:

 register_ftrace_ops_hash()

Where the hash will get updated on module removal.

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/trace/ftrace.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1903b80db6eb..fca01a168ae5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6223,18 +6223,20 @@ clear_mod_from_hash(struct ftrace_page *pg, struct ftrace_hash *hash)
>  /* Clear any records from hashs */
>  static void clear_mod_from_hashes(struct ftrace_page *pg)
>  {
> -	struct trace_array *tr;
> +	struct ftrace_ops *op;
>  
> -	mutex_lock(&trace_types_lock);
> -	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> -		if (!tr->ops || !tr->ops->func_hash)

The tr->ops hashes are persistent without being registered. They match
what's in set_ftrace_filter and similar files.

Your patch just introduced a bug, because those hashes now would not
get updated if the ops were not registered.

i.e.

 # echo some_module_function > set_ftrace_filter
 # rmmod module_with_that_function
 # insmod module_with_same_address_of_function
 # echo function > current_tracer

Now the tr->ops->hash would still have the function of the original
module.


Either have all owners of ftrace_ops handle this case, or add a helper
function to handle it for them. But using ftarce_ops_list is the wrong
place to do it.

-- Steve


> +	mutex_lock(&ftrace_lock);
> +
> +	do_for_each_ftrace_op(op, ftrace_ops_list) {
> +		if (!op->func_hash)
>  			continue;
> -		mutex_lock(&tr->ops->func_hash->regex_lock);
> -		clear_mod_from_hash(pg, tr->ops->func_hash->filter_hash);
> -		clear_mod_from_hash(pg, tr->ops->func_hash->notrace_hash);
> -		mutex_unlock(&tr->ops->func_hash->regex_lock);
> -	}
> -	mutex_unlock(&trace_types_lock);
> +		mutex_lock(&op->func_hash->regex_lock);
> +		clear_mod_from_hash(pg, op->func_hash->filter_hash);
> +		clear_mod_from_hash(pg, op->func_hash->notrace_hash);
> +		mutex_unlock(&op->func_hash->regex_lock);
> +	} while_for_each_ftrace_op(op);
> +
> +	mutex_unlock(&ftrace_lock);
>  }
>  
>  static void ftrace_free_mod_map(struct rcu_head *rcu)


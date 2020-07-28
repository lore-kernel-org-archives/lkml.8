Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A8C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354CA20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgG1R0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgG1R0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:26:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D742078E;
        Tue, 28 Jul 2020 17:26:31 +0000 (UTC)
Date:   Tue, 28 Jul 2020 13:26:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH 1/2] ftrace: clear module from hash of
 all ftrace ops
Message-ID: <20200728132630.678f94f7@oasis.local.home>
In-Reply-To: <557fa115-1247-e058-4a18-e73f6fb7d636@bytedance.com>
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
        <20200728085320.6b04e03f@oasis.local.home>
        <557fa115-1247-e058-4a18-e73f6fb7d636@bytedance.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 00:59:33 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:


> > i.e.
> >
> >   # echo some_module_function > set_ftrace_filter
> >   # rmmod module_with_that_function
> >   # insmod module_with_same_address_of_function
> >   # echo function > current_tracer
> >
> > Now the tr->ops->hash would still have the function of the original
> > module.  
> 
> I thought all ftrace_ops has non empty func_hash are on the ftrace 
> global list...

Nope, the two are disjoint.

> 
> Well, so I just leave this function unmodified.
> 
> Just call that new function register_ftrace_ops_hash() from 
> ftrace_release_mod.

I would say to have anything that uses one of the
ftrace_set_filter/notrace* functions, to also register itself for
module removal.

	register_ftrace_mod_removal(struct ftrace_ops *ops);

and then also have a unregister_ftrace_mod_removal() as there needs to
be a way to remove it from the list before the ops gets freed.

Then these functions would add the ops to a list, and this list is
traversed to remove modules. The trace_arrays can register their ops
too, so you can update that function.

-- Steve


> 
> Thanks!
> 
> >
> > Either have all owners of ftrace_ops handle this case, or add a helper
> > function to handle it for them. But using ftarce_ops_list is the wrong
> > place to do it.
> >
> > -- Steve
> >
> >  
> >> +	mutex_lock(&ftrace_lock);
> >> +
> >> +	do_for_each_ftrace_op(op, ftrace_ops_list) {
> >> +		if (!op->func_hash)
> >>   			continue;
> >> -		mutex_lock(&tr->ops->func_hash->regex_lock);
> >> -		clear_mod_from_hash(pg, tr->ops->func_hash->filter_hash);
> >> -		clear_mod_from_hash(pg, tr->ops->func_hash->notrace_hash);
> >> -		mutex_unlock(&tr->ops->func_hash->regex_lock);
> >> -	}
> >> -	mutex_unlock(&trace_types_lock);
> >> +		mutex_lock(&op->func_hash->regex_lock);
> >> +		clear_mod_from_hash(pg, op->func_hash->filter_hash);
> >> +		clear_mod_from_hash(pg, op->func_hash->notrace_hash);
> >> +		mutex_unlock(&op->func_hash->regex_lock);
> >> +	} while_for_each_ftrace_op(op);
> >> +
> >> +	mutex_unlock(&ftrace_lock);
> >>   }
> >>   
> >>   static void ftrace_free_mod_map(struct rcu_head *rcu)  


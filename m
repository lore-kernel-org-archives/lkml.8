Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA2C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B6A206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mhJZK62y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDTSTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgDTSTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:19:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52154C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:19:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so9368832qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wbj5Jn5Vw1aw1JPpmJhE17asrFe9woSoR8mVODQoPqk=;
        b=mhJZK62yxd1Yt8t6+e73NqmCAyFLNSwOAD3UGKApIsnrGptryq3MQchKcLvkJr7AYd
         mF4qLwxJlib0XfyJLGWFBhZikt5+atLR6e1BuhwE9eJl3ZRnRFy7zfEAlw4sqI+nfk8Y
         Wk8A8CcA4NLyU9SCD8W1IHeJeltDBvfUiCXRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbj5Jn5Vw1aw1JPpmJhE17asrFe9woSoR8mVODQoPqk=;
        b=GGFkPl+zHV5EOJ1KesA31jNTwmJeIhFnRy87BQCmdv9Xd4QpWrvrK0G9k/GTOyyBcV
         5ekZyOnKdmXJ6fNKDmZXGW+qD5+1Zlla8j7g9QomASzPeBAgdCCFVH6eCtUTXo8+Vkec
         e7NUZ0yezAsE3i9De80sHox1yLxMbjM7u4rz6QBr5khZkzyxyRh3ZaFanOFsNkdAAHpz
         UqxpHdjTI6OMHOT7dbrqDG4zdZY64GQWdnZQrwlwcWlra+WoJ0hm8LlCzY3i1XaN38TY
         UgxZrFw8GJddjtFyWsi77/BMOV4oA97ixwzN0wByVzGDelGwlJ3RDX70FFNKIZO47o6i
         makA==
X-Gm-Message-State: AGi0PuYr8zWVuEP6ZxS52qhfPYqiwiCFz0IlRyl7fx92hd5MRCOUausN
        aCjKQgitF2FkLVdTAebO9IsCKA==
X-Google-Smtp-Source: APiQypK5aRYcjAbwnF0DrucCOVmO+azYt8ByKi1esZgOEhz+FFAE8PfIMu7anl08Bx6LRK++QnQIrg==
X-Received: by 2002:ac8:1b97:: with SMTP id z23mr17149912qtj.294.1587406788282;
        Mon, 20 Apr 2020 11:19:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b5sm181704qkf.131.2020.04.20.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:19:47 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:19:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/dev -fixes 3/4] rcu/tree: Avoid using xchg() in
 kfree_call_rcu_add_ptr_to_bulk()
Message-ID: <20200420181947.GD90777@google.com>
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-4-joel@joelfernandes.org>
 <20200420171829.GA12196@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420171829.GA12196@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 07:18:29PM +0200, Uladzislau Rezki wrote:
> On Mon, Apr 20, 2020 at 11:38:36AM -0400, Joel Fernandes (Google) wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > There is no need to use xchg(), the access is serialized by krcp->lock.
> > The xchg() function adds some atomic barriers which remain hidden in
> > x86's disassembly but are visible on ARM for instance.
> > 
> > Replace xchg() with a load + store.
> > 
> > Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/rcu/tree.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index cd61649e1b001..f6eb3aee0935e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3088,7 +3088,8 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> >  	/* Check if a new block is required. */
> >  	if (!krcp->bhead ||
> >  			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> > -		bnode = xchg(&krcp->bcached, NULL);
> > +		bnode = krcp->bcached;
> > +		krcp->bcached = NULL;
> >  		if (!bnode) {
> >  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> >  
> >
> But we populate the cache without holding the krcp->lock. That is why it
> is xchg here. See below:
> 
> <snip>
>   if (cmpxchg(&krcp->bcached, NULL, bhead))
>      free_page((unsigned long) bhead);
> <snip>
> 
> we do not hold any krcp->lock here, we do not need it.

You are right. This patch is not helpful in this situation even though it
does not break things. Let us drop this patch. Please review the other 3 and
provide your Reviewed-by tag if they look Ok to you, thanks.

For the workqueue one that Paul asked us to look into - we are continuing to
discuss there if we need to move it outside the lock or not. If we decide to
move it outside lock, we can add that as one more patch to this series and
I'll send a v2.

thanks,

 - Joel


Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEA0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F97E20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610393;
	bh=knMGEU53xC+KPtKJP1jsuRoJ7sa4gkeHaJVEPUc4f7Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=JY5wCq1AAH8+Kb6+ybklCuk0bBfQJU+VX6KTXrTZI/J8D0yMQkpCs8wgp43LLsn60
	 +8Lv23yG5ubNj8cjRrs032YJokTGFKdhLgB9TWuy916FttRtBgzqdZ4iABZFD98noc
	 cdZz5CKQnFYOaCaGpqaELsckwucle4aN2H9O2+Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgC3XTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgC3XTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:19:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FE720675;
        Mon, 30 Mar 2020 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585610391;
        bh=knMGEU53xC+KPtKJP1jsuRoJ7sa4gkeHaJVEPUc4f7Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U5XF6eygiF8K/M6F+FMs3jEOjwHcIgGS9MuHISkDZX3KyqITcsD8Xs1yD+UVKVXGM
         tHl5zq4QhbfFv04/h+wmlll0DUgUESlTLoM1jqIkVs9LBv9cVPtQVTw1oM7Js11ZuJ
         zKnLUqTXu2m7dAXVATi7QmOizyd+rO8Af/b1+3P0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80B403523140; Mon, 30 Mar 2020 16:19:51 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:19:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 07/21] Revert "list: Use WRITE_ONCE() when adding to
 lists and hlists"
Message-ID: <20200330231951.GB19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-8-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:29PM +0000, Will Deacon wrote:
> This reverts commit 1c97be677f72b3c338312aecd36d8fff20322f32.
> 
> There is no need to use WRITE_ONCE() for the non-RCU list and hlist
> implementations.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Which means that the lockless uses of hlist_empty() will also need
attention, correct?

							Thanx, Paul

> ---
>  include/linux/list.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index ec1f780d1449..c7331c259792 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -70,7 +70,7 @@ static inline void __list_add(struct list_head *new,
>  	next->prev = new;
>  	new->next = next;
>  	new->prev = prev;
> -	WRITE_ONCE(prev->next, new);
> +	prev->next = new;
>  }
>  
>  /**
> @@ -843,7 +843,7 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
>  	n->next = first;
>  	if (first)
>  		first->pprev = &n->next;
> -	WRITE_ONCE(h->first, n);
> +	h->first = n;
>  	n->pprev = &h->first;
>  }
>  
> @@ -858,7 +858,7 @@ static inline void hlist_add_before(struct hlist_node *n,
>  	n->pprev = next->pprev;
>  	n->next = next;
>  	next->pprev = &n->next;
> -	WRITE_ONCE(*(n->pprev), n);
> +	*(n->pprev) = n;
>  }
>  
>  /**
> -- 
> 2.20.1
> 

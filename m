Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DCD20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609559;
	bh=sZoG49IlE//Cd5eYwc8Z5AQTYaI/Iwc0/gOeae7abfU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nD6B50S0lo8/oMplWrrJBd7eW2Sp8zUwDhDL94dvr6WW9q/6QZ67jsCwR/5aqHBKw
	 64+ckwZIcIhVYPxffRZglXaICNOlHNhdHScd8oQ18C4H7gG2bYdnweZI1thypdfzjO
	 C7Vflgs0sBSf55eiO7ysil2/bcUZvYcPeQqYlpn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgC3XF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgC3XF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:05:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7CDB20733;
        Mon, 30 Mar 2020 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585609556;
        bh=sZoG49IlE//Cd5eYwc8Z5AQTYaI/Iwc0/gOeae7abfU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dGAFrVwci1oqhpIsKl9e9+zoXRjlgxHw5cpzSTUVgiES3WLX3ScneiKQilOC6lGcZ
         XNawhAWA3v2G4nG3wtxPEVFjvFb1Mh1GTLuJLeJxcfZntUMVSTQJtiGPphMx3BDEpL
         ndPHqyKu/FUvPHQAgJPIuod7vfZ1BCr9hfKUTdjg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BE5CA3523140; Mon, 30 Mar 2020 16:05:55 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:05:55 -0700
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
Subject: Re: [RFC PATCH 01/21] list: Remove hlist_unhashed_lockless()
Message-ID: <20200330230555.GX19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-2-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:23PM +0000, Will Deacon wrote:
> Commit c54a2744497d ("list: Add hlist_unhashed_lockless()") added a
> "lockless" variant of hlist_unhashed() that uses READ_ONCE() to access
> the 'pprev' pointer of the 'hlist_node', the intention being that this
> could be used by 'timer_pending()' to silence a KCSAN warning. As well
> as forgetting to add the caller, the patch also sprinkles
> {READ,WRITE}_ONCE() invocations over the standard (i.e. non-RCU) hlist
> code, which is undesirable for a number of reasons:
> 
>   1. It gives the misleading impression that the non-RCU hlist code is
>      in some way lock-free (despite the notable absence of any memory
>      barriers!) and silences KCSAN in such cases.
> 
>   2. It unnecessarily penalises code generation for non-RCU hlist users
> 
>   3. It makes it difficult to introduce list integrity checks because
>      of the possibility of concurrent callers.
> 
> Retain the {READ,WRITE}_ONCE() invocations for the RCU hlist code, but
> remove them from the non-RCU implementation. Remove the unused
> 'hlist_unhashed_lockless()' function entirely and add the READ_ONCE()
> to hlist_unhashed(), as we do already for hlist_empty() already.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

No objection, however 90c018942c2b ("timer: Use hlist_unhashed_lockless()
in timer_pending()") in -tip must change from hlist_unhashed_lockless()
to hlist_unhashed().  Easy fix, though, so:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/list.h | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 884216db3246..4fed5a0f9b77 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -777,19 +777,6 @@ static inline void INIT_HLIST_NODE(struct hlist_node *h)
>   * node in unhashed state, but hlist_nulls_del() does not.
>   */
>  static inline int hlist_unhashed(const struct hlist_node *h)
> -{
> -	return !h->pprev;
> -}
> -
> -/**
> - * hlist_unhashed_lockless - Version of hlist_unhashed for lockless use
> - * @h: Node to be checked
> - *
> - * This variant of hlist_unhashed() must be used in lockless contexts
> - * to avoid potential load-tearing.  The READ_ONCE() is paired with the
> - * various WRITE_ONCE() in hlist helpers that are defined below.
> - */
> -static inline int hlist_unhashed_lockless(const struct hlist_node *h)
>  {
>  	return !READ_ONCE(h->pprev);
>  }
> @@ -852,11 +839,11 @@ static inline void hlist_del_init(struct hlist_node *n)
>  static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
>  {
>  	struct hlist_node *first = h->first;
> -	WRITE_ONCE(n->next, first);
> +	n->next = first;
>  	if (first)
> -		WRITE_ONCE(first->pprev, &n->next);
> +		first->pprev = &n->next;
>  	WRITE_ONCE(h->first, n);
> -	WRITE_ONCE(n->pprev, &h->first);
> +	n->pprev = &h->first;
>  }
>  
>  /**
> @@ -867,9 +854,9 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
>  static inline void hlist_add_before(struct hlist_node *n,
>  				    struct hlist_node *next)
>  {
> -	WRITE_ONCE(n->pprev, next->pprev);
> -	WRITE_ONCE(n->next, next);
> -	WRITE_ONCE(next->pprev, &n->next);
> +	n->pprev = next->pprev;
> +	n->next = next;
> +	next->pprev = &n->next;
>  	WRITE_ONCE(*(n->pprev), n);
>  }
>  
> @@ -881,12 +868,12 @@ static inline void hlist_add_before(struct hlist_node *n,
>  static inline void hlist_add_behind(struct hlist_node *n,
>  				    struct hlist_node *prev)
>  {
> -	WRITE_ONCE(n->next, prev->next);
> -	WRITE_ONCE(prev->next, n);
> -	WRITE_ONCE(n->pprev, &prev->next);
> +	n->next = prev->next;
> +	prev->next = n;
> +	n->pprev = &prev->next;
>  
>  	if (n->next)
> -		WRITE_ONCE(n->next->pprev, &n->next);
> +		n->next->pprev  = &n->next;
>  }
>  
>  /**
> -- 
> 2.20.1
> 

Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BD620774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610476;
	bh=3yuZSaQ36wyLBlKdpsQHW3thBDOr3nwmhonGyIIq6BQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=X3l638gXXwLpqNMqgLgetpMvuZpeMO1OVwGaHBEDiEQQ+9tqsaztZqaZuI/IZ7325
	 0aJROf4Aumv9n9IJpX+4RkMt2zoOx6YvfQoWJwg6fr6IX03Oq8edqNGK14XLkBTxr+
	 XKBMC4sQAzYaawAx79QCGOgeibSolrwx1YtlpCwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgC3XVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgC3XVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:21:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F032020675;
        Mon, 30 Mar 2020 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585610475;
        bh=3yuZSaQ36wyLBlKdpsQHW3thBDOr3nwmhonGyIIq6BQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GwtNJliugD8mSTia+pLAwHnYuw88NISnmBDSifRCYu8M8RxiQb73Rzdx2oXlg0lzF
         UsUIushsMgvd5Z83F9KrAsb4kNex+24c7eBETE39ZiNuNB78geEQ6t31td7mmgg5oC
         tuAlci+SA49SUzt802ziva3EY7/q2NZZaR6bgx3o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CAF893523140; Mon, 30 Mar 2020 16:21:14 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:21:14 -0700
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
Subject: Re: [RFC PATCH 06/21] list: Remove superfluous WRITE_ONCE() from
 hlist_nulls implementation
Message-ID: <20200330232114.GC19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-7-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:28PM +0000, Will Deacon wrote:
> Commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev
> for hlist_nulls") added WRITE_ONCE() invocations to hlist_nulls_add_head()
> and hlist_nulls_del().
> 
> Since these functions should not ordinarily run concurrently with other
> list accessors, restore the plain C assignments so that KCSAN can yell
> if a data race occurs.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

And this means that the lockless uses of hlist_nulls_empty() need
attention, correct?

							Thanx, Paul

> ---
>  include/linux/list_nulls.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
> index fa51a801bf32..fd154ceb5b0d 100644
> --- a/include/linux/list_nulls.h
> +++ b/include/linux/list_nulls.h
> @@ -80,10 +80,10 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
>  	struct hlist_nulls_node *first = h->first;
>  
>  	n->next = first;
> -	WRITE_ONCE(n->pprev, &h->first);
> +	n->pprev = &h->first;
>  	h->first = n;
>  	if (!is_a_nulls(first))
> -		WRITE_ONCE(first->pprev, &n->next);
> +		first->pprev = &n->next;
>  }
>  
>  static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
> @@ -99,7 +99,7 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
>  static inline void hlist_nulls_del(struct hlist_nulls_node *n)
>  {
>  	__hlist_nulls_del(n);
> -	WRITE_ONCE(n->pprev, LIST_POISON2);
> +	n->pprev = LIST_POISON2;
>  }
>  
>  /**
> -- 
> 2.20.1
> 

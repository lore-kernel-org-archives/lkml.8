Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DBDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C6620784
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609675;
	bh=4AVexlNiYtLyPvD8KLzOZUsgxdPsZ/3OqrKRBK5t78U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WnFrktabcUY0ve1uBMG0khZWiACo79TrCRkp/0b0WHZOzCSoE1ntKdTEMkDbIfRCR
	 snYNMx3e+C/jC8jSfNHe4sgqK7HTesYU2mYsO3ROfku6wINofRQ9hnl7RsMWyh/A6p
	 /e41p3Vi+di94RtsIkH9hFOOtYU2sLEBmK/Ew3B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgC3XHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgC3XHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:07:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6516420771;
        Mon, 30 Mar 2020 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585609672;
        bh=4AVexlNiYtLyPvD8KLzOZUsgxdPsZ/3OqrKRBK5t78U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eaMgIeH63FPjbwbmlPJ1EDvOTFm3tqCkT0ss3Y+WINaDPNQ/I4KjnasBeJbiDOt2L
         5MGtBK1edC6BncMz8rT8XPOqspWxPMHbLCCJF+s2hhVMeB1/VazpACz3WjycFJQy2X
         c2AXDCapRXA5Sjy7/HLSbURBVhd4l+B3/Wh9AUd8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3F4403523140; Mon, 30 Mar 2020 16:07:52 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:07:52 -0700
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
Subject: Re: [RFC PATCH 02/21] list: Remove hlist_nulls_unhashed_lockless()
Message-ID: <20200330230752.GY19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-3-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:24PM +0000, Will Deacon wrote:
> Commit 02b99b38f3d9 ("rcu: Add a hlist_nulls_unhashed_lockless() function")
> introduced the (as yet unused) hlist_nulls_unhashed_lockless() function
> to avoid KCSAN reports when an RCU reader checks the 'hashed' status
> of an 'hlist_nulls' concurrently undergoing modification.
> 
> Remove the unused function and add a READ_ONCE() to hlist_nulls_unhashed(),
> just like we do already for hlist_nulls_empty().
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Well, I guess that the added docbook comment might be seen as worthwhile.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/list_nulls.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
> index fa6e8471bd22..3a9ff01e9a11 100644
> --- a/include/linux/list_nulls.h
> +++ b/include/linux/list_nulls.h
> @@ -65,20 +65,6 @@ static inline unsigned long get_nulls_value(const struct hlist_nulls_node *ptr)
>   * but hlist_nulls_del() does not.
>   */
>  static inline int hlist_nulls_unhashed(const struct hlist_nulls_node *h)
> -{
> -	return !h->pprev;
> -}
> -
> -/**
> - * hlist_nulls_unhashed_lockless - Has node been removed and reinitialized?
> - * @h: Node to be checked
> - *
> - * Not that not all removal functions will leave a node in unhashed state.
> - * For example, hlist_del_init_rcu() leaves the node in unhashed state,
> - * but hlist_nulls_del() does not.  Unlike hlist_nulls_unhashed(), this
> - * function may be used locklessly.
> - */
> -static inline int hlist_nulls_unhashed_lockless(const struct hlist_nulls_node *h)
>  {
>  	return !READ_ONCE(h->pprev);
>  }
> -- 
> 2.20.1
> 

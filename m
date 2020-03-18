Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFEAC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E87E2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584547451;
	bh=aXyZJLocilqRkVD/Q9Q72ooMd4G8gtU7jTK0V492smA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=A7tz4gTqD/olLmNDIe9oswOg6ay4UN81nXwjQFEtKKmwoX/mukv+e6PRmul5Na4bq
	 DmkY0WHWKF4fVgWQagjIMF9GsQ783c5al4w6/AqhBF1OgKM7blE2Y6523e8WF0/m71
	 JLq9OAV+JjKQuRSt8se3uU95paU2yF+pLOttJa4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRQEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgCRQEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:04:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809E220768;
        Wed, 18 Mar 2020 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584547449;
        bh=aXyZJLocilqRkVD/Q9Q72ooMd4G8gtU7jTK0V492smA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RCa3AAPUSlzSu1f9+WV+FC+1Q48U6TkHmrBQeQ0RaLLzp7hvte/kVjODsL3B3mK/K
         UIWYEfKmI+yitnbPnnV8nkxaH7sMf1SMzF16u0xLb4LP1T9NILGDKexPJCW7AUZAYz
         zNkv6myuj9WDkPNAQ0vj8OJkZKR79tP7bn7qyqZI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5081835204E4; Wed, 18 Mar 2020 09:04:09 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:04:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux: fix some typos
Message-ID: <20200318160409.GS3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200318114837.159978-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318114837.159978-1-shile.zhang@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 07:48:37PM +0800, Shile Zhang wrote:
> s/Not/Note/
> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Or I can take it if no one else wants it.  ;-)

							Thanx, Paul

> ---
>  include/linux/list_nulls.h | 4 ++--
>  include/linux/once.h       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
> index fa6e8471bd22..c845761fe5de 100644
> --- a/include/linux/list_nulls.h
> +++ b/include/linux/list_nulls.h
> @@ -60,7 +60,7 @@ static inline unsigned long get_nulls_value(const struct hlist_nulls_node *ptr)
>   * hlist_nulls_unhashed - Has node been removed and reinitialized?
>   * @h: Node to be checked
>   *
> - * Not that not all removal functions will leave a node in unhashed state.
> + * Note that not all removal functions will leave a node in unhashed state.
>   * For example, hlist_del_init_rcu() leaves the node in unhashed state,
>   * but hlist_nulls_del() does not.
>   */
> @@ -73,7 +73,7 @@ static inline int hlist_nulls_unhashed(const struct hlist_nulls_node *h)
>   * hlist_nulls_unhashed_lockless - Has node been removed and reinitialized?
>   * @h: Node to be checked
>   *
> - * Not that not all removal functions will leave a node in unhashed state.
> + * Note that not all removal functions will leave a node in unhashed state.
>   * For example, hlist_del_init_rcu() leaves the node in unhashed state,
>   * but hlist_nulls_del() does not.  Unlike hlist_nulls_unhashed(), this
>   * function may be used locklessly.
> diff --git a/include/linux/once.h b/include/linux/once.h
> index 9225ee6d96c7..095c6debd63b 100644
> --- a/include/linux/once.h
> +++ b/include/linux/once.h
> @@ -16,7 +16,7 @@ void __do_once_done(bool *done, struct static_key_true *once_key,
>   * out the condition into a nop. DO_ONCE() guarantees type safety of
>   * arguments!
>   *
> - * Not that the following is not equivalent ...
> + * Note that the following is not equivalent ...
>   *
>   *   DO_ONCE(func, arg);
>   *   DO_ONCE(func, arg);
> -- 
> 2.24.0.rc2
> 

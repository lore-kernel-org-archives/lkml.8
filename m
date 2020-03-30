Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ECEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF4B20784
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610098;
	bh=VVSNPfwNTi/eewRuFYhE6zHWE9KPNO3Iea9w8iAWJQU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ild8kp2mLcUbR/bHHo2aXabBfL6dxwXHBPEwgMI06eiZUfam3W8GB5BGRXdgwWekq
	 o1kimnWZuZy8VB9L7iwD0aO5hG+Q+QrUGokFRoqsY+QaA5XXo0iLFxsI3AhYKVMbQT
	 0N6EL38YhMY47e1r1FGUDDui+cc1hULVoxa4E3Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3XO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgC3XO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:14:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF2220409;
        Mon, 30 Mar 2020 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585610096;
        bh=VVSNPfwNTi/eewRuFYhE6zHWE9KPNO3Iea9w8iAWJQU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=siSm447IUzxXtgfrXMT+dm2UB+eOcmg2IHY8EYAANBKNIAAlzAe3U4hgLktrF2Nl0
         Jj+C/sJZu0iMwZ9MwXpCOB6xmTvpUstfmu8CIgfvaT+eJiBiOgkJdKf16h2iNK/hEF
         1nUyulakvnSeA5XBjFaYwTfmhRJCU+qwebq1dzVA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1ED83523140; Mon, 30 Mar 2020 16:14:56 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:14:56 -0700
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
Subject: Re: [RFC PATCH 05/21] list: Comment missing WRITE_ONCE() in
 __list_del()
Message-ID: <20200330231456.GA19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-6-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:27PM +0000, Will Deacon wrote:
> Although __list_del() is called from the RCU list implementation, it
> omits WRITE_ONCE() when updating the 'prev' pointer for the 'next' node.
> This is reasonable because concurrent RCU readers only access the 'next'
> pointers.
> 
> Although it's obvious after reading the code, add a comment.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

OK, I will take the easy one.  ;-)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/list.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 4d9f5f9ed1a8..ec1f780d1449 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -109,6 +109,7 @@ static inline void list_add_tail(struct list_head *new, struct list_head *head)
>   */
>  static inline void __list_del(struct list_head * prev, struct list_head * next)
>  {
> +	/* RCU readers don't read the 'prev' pointer */
>  	next->prev = prev;
>  	WRITE_ONCE(prev->next, next);
>  }
> -- 
> 2.20.1
> 

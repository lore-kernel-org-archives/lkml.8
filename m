Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90C0207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LR37Tsje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbgEZTyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389154AbgEZTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:54:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972AC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:54:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so17207206qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mwplw+QHzlz83TFWS9be70CzNxCzzZLsPeNhJujEwwE=;
        b=LR37TsjeQNOIlNstzA0TIMjLsS4i9FUnBoooNyMU1ZtakBSA1dUMQ0e0mAkt7fQib3
         xxG+LrP+Jvs/4euMgEnYyxa4ixyyfR9xmm/7UQTHbBAKejH4FyvvncURE+LWxOly62dI
         ZG3pNlp90pYrssfFAo/mGS3g2z9izSxaZbgXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwplw+QHzlz83TFWS9be70CzNxCzzZLsPeNhJujEwwE=;
        b=bcjJ1A5//ouEPQAH1sDibQzLnzIseF2fux/gX28II8z0xZEpI0K8jrrKjpdgGaW0B5
         VbLZWJYFz4OyLTt+o2uCVWQWNkWlAFN0Hi6dJ+Sc/Fx73nNIFCBDNVA3TZbvHMdFv+FL
         r+yb1v5XRdYfUxfCHSpVYGxtvHevGj6RZCbISFrM8rjqXReltpj3ZjHW23rngw1lA7hM
         UaJMaMxReZbmPwcTHStSZDd9M+BVypKUYhoz3g2WAQEsddGK1zi0oIIg9FC3VSpV84at
         ugEYZgxVshnj3asZ8F4G2Ia4ds74Nbo4WSunLfANE4jIvev7kV2zqrOwBShz+MkI7Fi4
         th7g==
X-Gm-Message-State: AOAM531JXj08sQdQb5weKanvdQp20w9JEeyILIDuis/V603t2oR966c6
        9kifCd6qTwELpx6tVE2uaSfXvQ==
X-Google-Smtp-Source: ABdhPJzx+PipEK63HkGBT0fNGXgA4rFvwoBgtJWt55NTyQgqQ7r8EqfyJWjfsAT9PSW5liSHhuwqxQ==
X-Received: by 2002:aed:24db:: with SMTP id u27mr525457qtc.256.1590522863428;
        Tue, 26 May 2020 12:54:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c58sm656652qtd.27.2020.05.26.12.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:54:22 -0700 (PDT)
Date:   Tue, 26 May 2020 15:54:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 03/10] rcu: Make locking explicit in
 do_nocb_deferred_wakeup_common()
Message-ID: <20200526195422.GB149611@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-4-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:07PM +0200, Frederic Weisbecker wrote:
> It can either be called inline (locally or CPU hotplug locked) when
> rdp->nocb_defer_wakeup is pending or from the nocb timer. In both cases
> the rdp is offlined and we want to take the nocb lock.
> 
> Clarify the locking rules and expectations.

And you did inline the code in the locking helper already as I was suggesting
in 01/10. :-) So that's settled ;-)

thanks,

 - Joel

> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_plugin.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1d22b16c03e0..1dd3fdd675a1 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2142,9 +2142,9 @@ static void do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
>  	unsigned long flags;
>  	int ndw;
>  
> -	rcu_nocb_lock_irqsave(rdp, flags);
> +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
>  	if (!rcu_nocb_need_deferred_wakeup(rdp)) {
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
>  		return;
>  	}
>  	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
> -- 
> 2.25.0
> 

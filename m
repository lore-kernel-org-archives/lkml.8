Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BFFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCEA206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DH1tWi6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFKBe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKBe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:34:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F0C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:34:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so3453313qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55Gy25i6MWT9R2Sy3CAwrMigrI5YAB45T9Iy8NhgGeg=;
        b=DH1tWi6y94mWYgFSHkuj2ZwvjarHqQyX0ydceO/EdpVgvPsqky3ujppY3dggDEwWfo
         bGxGOi4eCh99xuyFnaIpkxwysp5f4A14KIF7iBT2S0pWsc4kud/SAhObdl52dn+I/XrV
         JO7U+JMDW7TVrnxNMK9TUjQOSjLozsRpg4A9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55Gy25i6MWT9R2Sy3CAwrMigrI5YAB45T9Iy8NhgGeg=;
        b=FFwl/TqAOd2cuFiR5OICbnjZQjf3re0yfnCcacmC1lJK8mOb6j+etpVyR1fXt4gieo
         69zJVmkcvGeMsHB5zjADAhABjogcEX6TNvaIf12Rk5YhRgtAJKYHlxpHF7eAp5Lg0+AT
         QxELDDZznjMskDwTt/OxhyS4ELhLmZzdzA0nLdSAqRzH4SgeDqOVQk1YjKSL6DCnPrzA
         1JgtEGyhA6SOUvCElYqCrecIP+UO/eC84ilS0kFkqzzsTezW2J5EUInP4FM/d5VeNTad
         h6P16X/H3wXzJmsqaWAkAQaqNJILs+BRqXqr1bHUPi3HvRm+XhiiiHWQFKfTiGR9eZkk
         JWvQ==
X-Gm-Message-State: AOAM531ebxC/jYdTEGuRxuswIOIIGhpfpSUq2H75umLMLd5EWo4GYbKp
        hLK4e/SIEjCstLwIzkEjTz9Iawbc4WA=
X-Google-Smtp-Source: ABdhPJzR53fwQYF4rMdlZKKO43GIOTfeOYOuxLqI7tMkeVzyZ4FumvZ0dS6IU1FmSiqBS4/t7dtZyg==
X-Received: by 2002:aed:3f25:: with SMTP id p34mr6133961qtf.92.1591839267917;
        Wed, 10 Jun 2020 18:34:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l8sm1363568qtb.57.2020.06.10.18.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:34:27 -0700 (PDT)
Date:   Wed, 10 Jun 2020 21:34:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 06/10] rcu: Make nocb_cb kthread parkable
Message-ID: <20200611013426.GB12037@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-7-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:10PM +0200, Frederic Weisbecker wrote:
> This will be necessary to correctly implement rdp de-offloading. We
> don't want rcu_do_batch() in nocb_cb kthread to race with local
> rcu_do_batch().
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/rcu/tree_plugin.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1dd3fdd675a1..43ecc047af26 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2104,7 +2104,9 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  	if (needwake_gp)
>  		rcu_gp_kthread_wake();
>  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> -				 !READ_ONCE(rdp->nocb_cb_sleep));
> +				    !READ_ONCE(rdp->nocb_cb_sleep) ||
> +				    kthread_should_park());
> +
>  	if (!smp_load_acquire(&rdp->nocb_cb_sleep)) { /* VVV */
>  		/* ^^^ Ensure CB invocation follows _sleep test. */
>  		return;
> @@ -2125,6 +2127,8 @@ static int rcu_nocb_cb_kthread(void *arg)
>  	// if there are no more ready callbacks, waits for them.
>  	for (;;) {
>  		nocb_cb_wait(rdp);
> +		if (kthread_should_park())
> +			kthread_parkme();
>  		cond_resched_tasks_rcu_qs();
>  	}
>  	return 0;
> -- 
> 2.25.0
> 

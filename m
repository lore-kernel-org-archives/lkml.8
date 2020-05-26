Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F90C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA1A207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KRRoEtMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390582AbgEZT7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbgEZT7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:59:30 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F6C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:59:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p4so10056346qvr.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWN+w1Fv4bIYBummlgoeyT/3ykM1S7qQr4+u580L+X0=;
        b=KRRoEtMWfjI5kcAmoTD3JZh7J4HE099FLTDx4GRXexZUZUiTMxsmztMFd8puPj037Y
         GU3FYtFUqUo1ecZ+N+yZYqd29THZFimV8EIUZ5lDWnh+ogNl5kyk0TmJelMrH6ZkhqDq
         iEUCNE2CXUghOqiQS24olpvmmX8eQnHsWY5uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWN+w1Fv4bIYBummlgoeyT/3ykM1S7qQr4+u580L+X0=;
        b=lPfnr0MusrZy4KmxTDbO0h93nxMpQaPHNmTNPI0WVgYhulREzCzKjA4UdiPFmn1DfI
         lXZr8C0/CM05RPouul/dzXLW/F88LTRKp6fbU380RDolMn9C/67+vG4+1gaNcecMlYQ/
         tYcpPF0fXIxARxsgRBCMzMsa00mOur1mY1u3Ehy0uCHxl15FqMPZ5m/M1KXy526ubdQB
         4V4ATrtPlGT+eBomf2Km9xsG5G8411EpchAkKZ2YhnEY+S/n/mbZbpljM39oW+glbe8A
         aXkbYPsLJ/+1mEk+vHKyRVZh0QEu5ddzqeyuM8vfPjIM85TtO9cf+YILt7MSEP54i+K7
         rqoA==
X-Gm-Message-State: AOAM531/4gdqNvUPfHurrI68SGeNDzi7nBAe0lmo2NXx2UypaOx8Pgna
        FTH0S5RVBfzeK4dsvICp0ceBWg==
X-Google-Smtp-Source: ABdhPJwiBPeWFM0xQ+KkdX3szcJOAAlqE8bzoqZmBN1LJ42auBD5o8v2P0bSVPhkQ/sJBVIfN0+OpQ==
X-Received: by 2002:ad4:5506:: with SMTP id az6mr20439931qvb.136.1590523169282;
        Tue, 26 May 2020 12:59:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w10sm691146qtc.15.2020.05.26.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:59:28 -0700 (PDT)
Date:   Tue, 26 May 2020 15:59:28 -0400
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
Message-ID: <20200526195928.GC149611@google.com>
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

s/offlined/offloaded/

thanks,

 - Joel

> 
> Clarify the locking rules and expectations.
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

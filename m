Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE447C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FF4207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590676525;
	bh=RTmn9I/P/h/b2BAlvnmL5VL241LIu4BNAQWUSjN0NX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QAnDpLXoTSrZetYUspL8+zB2oNZiBPXXcZs5+WgLuUR5c1DIoD/TNmK9PwZ7eF/J8
	 D2EzxP0rG68xxQkJfHS0qvIdJ0+pf3AIxUS9NjX+KM0wcwwCelqMKsVUC6+oXSD4gq
	 qVYCvm3YiGSaySwmOqQWf6EnrN6ndkDoMtEjvd5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgE1OfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgE1OfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:35:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E0C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:35:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g18so154567qtu.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcAb2KpcuRPfgfB5jORmrIWIuJewUz8Wtbi29XX230A=;
        b=jtN+TaOEPI9GArXzBTG/FsSfByBqNnwA9+Pzz4nDsmi94Ju3aJfChT/Rd72wQMjn7r
         vvwDR8daI7Bock14JBETyWZWnrOHAx1mf+cYXazPuijo2ReKCQ3vAeAMA8Co0YdZmre9
         aieQGdaZkvlA1nZxMfAjjw79cmZ2FdwZFkTQzf6XsIeSFufCa8HHXFQkhWVhNNyChn4x
         wN+zArWYK702o1TmzQcEMBgoLYVUsxCO5d3+19QqIiJleWwmAm2cVV9p8H5EMkvnVXDr
         +UO4vDIZHI9P843hYxfLqIFQGetwhNdjuGVDx8HGl52Yg4pXG8X/NI5cmlwuGL9b/gwA
         5WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xcAb2KpcuRPfgfB5jORmrIWIuJewUz8Wtbi29XX230A=;
        b=rpih9VZsUQ6LdNT3FckCRJszAx7nJDA2EWLP0HRiDg3VDkw5APehnWu3jIEAt3Qy5L
         jtEqdefDUnP3krIiL97zY7qBdWvNqoSj68ZS+olqaWH7uwdKXICjOAAzkC9VAe+c4c+n
         MYa/Ngg1JXMn0fUKWCVT+jnLqPWewuUqxNz/6kx9veovKMxAOqCbdHCQUBxX+6zOHA1d
         qxWE5uE2q9opvpSYakpezkMgZ8cUCl4JB2pOjXJGN7+K4SWzcZEjMuSuh16jprDSho5m
         eK0f4NYDpf6LI/HRVu8MT/0scMljjwGYaxh02itgRfTi5fkzPu6lFsm5pNNLhE8GsUj0
         yV0Q==
X-Gm-Message-State: AOAM532IUJ0058SM7NiRvUMAXu7g1j/L2BW2+JlxvJ5eI5s0QnjxztjR
        qLnw+5JfDHvObethQYMD9L4=
X-Google-Smtp-Source: ABdhPJz1vfe5Sk2jtVPNDYukh8JAkxVWKOD9EHEyXlc18+76FG8E0pjwWLpfB8ULY+xMkGx4sqtpxQ==
X-Received: by 2002:ac8:7b4c:: with SMTP id m12mr3165443qtu.97.1590676522504;
        Thu, 28 May 2020 07:35:22 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id a62sm4967178qkg.71.2020.05.28.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:35:21 -0700 (PDT)
Date:   Thu, 28 May 2020 10:35:19 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 1/2] workqueue: pin the pool while it is managing
Message-ID: <20200528143519.GN83516@mtj.thefacebook.com>
References: <20200527194633.1660952-2-bigeasy@linutronix.de>
 <20200528030657.1690-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528030657.1690-1-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 28, 2020 at 03:06:55AM +0000, Lai Jiangshan wrote:
> @@ -2129,10 +2128,21 @@ __acquires(&pool->lock)
>  static bool manage_workers(struct worker *worker)
>  {
>  	struct worker_pool *pool = worker->pool;
> +	struct work_struct *work = list_first_entry(&pool->worklist,
> +					struct work_struct, entry);

I'm not sure about this. It's depending on an external condition (active
work item) which isn't obvious and when that condition breaks the resulting
bug will be one which is difficult to reproduce. Adding to that, pwq isn't
even the object this code path is interested in, which is the cause of the
previous problem too.

> @@ -2140,7 +2150,7 @@ static bool manage_workers(struct worker *worker)
>  
>  	pool->manager = NULL;
>  	pool->flags &= ~POOL_MANAGER_ACTIVE;
> -	wake_up(&wq_manager_wait);
> +	put_pwq(pwq);

So, this works only because pwq release bounces through another work item,
so even if a worker of the pool which is currently being destroyed initiates
the release of the containing pool, it still works out, because by the time
the async release path kicks in and grabs the pool lock, everything should
be idle.

I get that this can work but it's sitting on top of a bunch of subtleties.
The current code is more verbose but also significantly more explicit and
straight-forward. I'd rather keep the current behavior unless we can get rid
of the subtleties.

Thanks.

-- 
tejun

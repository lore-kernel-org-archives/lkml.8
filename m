Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3965C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C92C20836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8Kp91uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFLRGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLRGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:06:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E91C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:06:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so4106829pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVTxDzO4IZAFd863UtOldIkTlBTqxYr5OyZkbNt9Exo=;
        b=A8Kp91uLI+tQnJ3jKC2jR+cD8mIyaVyhikfRs5WrP7Tf5fkSUzCnv3fpv+kDxW46D8
         zByT6xorZdwpIhX3RK1H3dShiz7nBjBJHSaxYamI70PD3uOr04gMI8pZX3ZMRktzqAXk
         T7mXdzqrUXZaHCkLNVFfsi4oNSiSBYSb9n5eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVTxDzO4IZAFd863UtOldIkTlBTqxYr5OyZkbNt9Exo=;
        b=H0X0q9qkvqEASh8+SFuxoq5eNL4/nx4nG9vjcc+w+T3C4DISgBVVbCtqLjHwkP0dQM
         LYLfXGpBTNF5pfU5ctl9ctbYEP605WJw/YMPSROLf+yulVBTItUwG9TtFou9gx6Gktlx
         m1kMeAKhs6pDrTU0Lnsw7HT7PNnR9wVeREUZ7IqOX8MstTmMkResvN+qMwxPy8rAbsI+
         HC+LGWBHcscL/ML/uIhfNvbh8j+7ybKrMjPpxvdz41uGZ5sUem6eIxqMLO4DzEkirocA
         tnW8mCH0m+QqJ08tou23Ev8pdI1umeA+CHU/2+fERS3mpvK0gdOk7ASEy5i7hnlpPql4
         xJsQ==
X-Gm-Message-State: AOAM530srGGrOHqGMluDlBh+C9ketCGt+6KJJykJE+mx0Gd1kefPFw2M
        LPF1X5eCFFvifqU23+bgRJlObKxVTZ9QQg==
X-Google-Smtp-Source: ABdhPJzaM91KwTq0GfU+yJwlNVmGgCNWW+GjbS/BrKOKZX9qrL1SoPS2lXjidIaCtL8PwC5/+PsUyA==
X-Received: by 2002:a17:902:b28a:: with SMTP id u10mr11985726plr.178.1591981611903;
        Fri, 12 Jun 2020 10:06:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h35sm6107361pje.29.2020.06.12.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:06:51 -0700 (PDT)
Date:   Fri, 12 Jun 2020 10:06:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, paul@paul-moore.com,
        edumazet@google.com, paulmck@kernel.org, dhowells@redhat.com,
        shakeelb@google.com, jamorris@linux.microsoft.com,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] cred: Add WARN to detect wrong use of get/put_cred
Message-ID: <202006121001.149B5D20C5@keescook>
References: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
 <20200612163345.GF2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612163345.GF2497@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:33:45PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 06:28:15PM +0800, Xiaoming Ni wrote:
> > Cred release and usage check code flow:
> > 	1. put_cred()
> > 		if (atomic_dec_and_test(&(cred)->usage))
> > 			__put_cred(cred);
> > 
> > 	2. __put_cred()
> > 		BUG_ON(atomic_read(&cred->usage) != 0);
> > 		call_rcu(&cred->rcu, put_cred_rcu);
> > 
> > 	3. put_cred_rcu()
> > 		if (atomic_read(&cred->usage) != 0)
> > 			panic("CRED: put_cred_rcu() sees %p with usage %d\n",
> > 			       cred, atomic_read(&cred->usage));
> > 		kmem_cache_free(cred_jar, cred);
> > 
> > If panic is triggered on put_cred_rcu(), there are two possibilities
> > 	1. Call get_cred() after __put_cred(), usage > 0
> > 	2. Call put_cred() after __put_cred(), usage < 0
> > Since put_cred_rcu is an asynchronous behavior, it is no longer the first
> > scene when panic, there is no information about the murderer in the panic
> > call stack...
> > 
> > So, add WARN() in get_cred()/put_cred(), and pray to catch the murderer
> > at the first scene.
> 
> Why not not use refcount_t? It has all that goodness and more.

I thought these had been applied already, I guess not:
https://lore.kernel.org/lkml/20190306110549.7628-1-elena.reshetova@intel.com/

Can we try again?

-- 
Kees Cook

Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AFAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16667206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="msumWpjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgHSN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgHSNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:25:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:25:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so17693881qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oub4DT+nxeyPZAIUHhbv2Qd15f55cLS7blrm9y7LqSs=;
        b=msumWpjbrhePPIDAQHg1nPaSE6QdJ/aagtAu8huGWKROwE7Lm5xEcnwQEk+fEcE3mT
         2wNeytscDzHCfUzb8oqpmWCUrFsI+JPLDn9OjfXVxKjdW8u9BvFNGEsQ7Z8TIa0heSlQ
         wHRS1ejxR8mCzVMfuWJ2dkU9a2To2cXLqzYPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oub4DT+nxeyPZAIUHhbv2Qd15f55cLS7blrm9y7LqSs=;
        b=tuWfuq+KbjaCgbnv69SqAXH7vDcZ1XteoYKaOKGJwjlhIiGk9aaXOq2Ia2zb9w7oao
         HcxCcxBGAWDFQxF5fZWKadJ80m2ykU2KrBFjlMCgYA9lHGAvVMj+J9+G1j1098/tVcX+
         VU79VXPBp1GPTtTQ5PnJeLtF1gBZxliVvcFvrxhyDFkSGNmttlpZVmMmYzSFZcUGDpUy
         OK7tAWT/Wj8MvnAPaBFD+dW1QSOOazjYFDFBeFnBCPnEzGiXzA+hpfKFJhRW2u5KcDKB
         IhaQEqFlsxjysE2cAdJO5SBrh5wOUuKYrEnbAQUFb1FfWT0Wi3bAZEpxxRoz+3zlcwCr
         5ZwA==
X-Gm-Message-State: AOAM530/drlq2/j4IhiQkFRIo0P3LMKEIVB7XceSe2LWgUisg/IsZUnf
        oAxa9rnEXdkpQ77gGBblTIv6dA==
X-Google-Smtp-Source: ABdhPJz5vi0T0gUjoJrUvVQETHNZvLci7q8Qs7ZwHUh1LP4fyY8aJVk5SiwojcZd2bCP4rmEHGFnQQ==
X-Received: by 2002:ac8:6052:: with SMTP id k18mr22205327qtm.60.1597843548673;
        Wed, 19 Aug 2020 06:25:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d8sm27287911qtr.12.2020.08.19.06.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 06:25:47 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:25:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
Message-ID: <20200819132547.GA3875610@google.com>
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <20200819112225.GA6177@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819112225.GA6177@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 01:22:25PM +0200, Uladzislau Rezki wrote:
> On Tue, Aug 18, 2020 at 08:04:20PM -0400, Joel Fernandes wrote:
> > On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index b8ccd7b5af82..6decb9ad2421 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > > >  {
> > > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > > +       struct kfree_rcu_cpu *krcp;
> > > >
> > > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > >                 return 0;
> > > >
> > > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > > +       krcp = this_cpu_ptr(&krc)
> > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > +
> > > >
> > > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > > Maybe be never.
> > >
> > > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > > hard time getting too worried about it.  ;-)
> > 
> > Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> > on the cache reaper who's job is to flush the per-cpu caches. So I
> > believe during CPU offlining, the per-cpu slab caches are flushed.
> > 
> SLAB does it for sure, same as page allocator. There are special CPU-offline
> callbacks for both cases to perform cleanup when CPU dies.

Got it, thanks for confirming, makes sense.

thanks,

 - Joel


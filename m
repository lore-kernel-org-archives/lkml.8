Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C29206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UyL5MW2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFKBcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFKBcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:32:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18569C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:32:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so4148437qkn.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p0oFHDjI08jT9iTHKdobvcRxzsq4WDae5ZHB1yQgzBU=;
        b=UyL5MW2a8MG0TeBlnSUTgQmcnvkvBtDwiJwnewAkXrxV+DS3izNpu18JruVRKn/LFr
         411zmCx1QUqEfFUHMjryKOGWFYAYMBDevUOohraO5Ogi7JBE+wEJ4LjQEbJmtuUdUyqa
         vaYYY6XiYEGLs6x4vrboCm8lVxhaj5dEuXqSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p0oFHDjI08jT9iTHKdobvcRxzsq4WDae5ZHB1yQgzBU=;
        b=F3Lehfwb7ClPbpAw2ESeNX9L0wPWhwNG48S6E+slYH7ERRV6V0oNDBZ2VpGH+gFLP1
         uY9dCQTxAWp14SXxIe9dp2QD5w99svlFXrBfUnOVql+gvBBrxc73zpO3dfm1ukwUn9KA
         D5j1kHf+HuDjME5ZL6wCqyMNHv4nOlNUNSsXpjEsJn4HE6EKEjReheMqRGSim7GChZzg
         2YI5aRJY7qgw9TKh02af7wK2+b24sZvEXgKs/mKB23AnKEq0yip6PRzNuk+kPe34VPO8
         pVrHffTLzi4+cZajdaPZJgA0AuXAnH+1BqvcPvbFCcKYSqDpHEK/w8wflJwOZnvhBqTR
         REPw==
X-Gm-Message-State: AOAM533yFCgME7Ay/zbNFl8uLnYB3XNs44rXNXwRlbPXRB1iKGfRQue4
        J6JMhsXRhYqWHlMFN+5rM9C32A==
X-Google-Smtp-Source: ABdhPJziiI1zjLqqrMyT6TUlbues/W/IxrBUDz3qPLPZRh+MUXvJBQf7cbXt5CttVAMI3Grg8ZA0cQ==
X-Received: by 2002:a05:620a:2110:: with SMTP id l16mr6041699qkl.290.1591839125067;
        Wed, 10 Jun 2020 18:32:05 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d17sm1170709qke.101.2020.06.10.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:32:04 -0700 (PDT)
Date:   Wed, 10 Jun 2020 21:32:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200611013203.GA12037@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200526212017.GE76276@google.com>
 <20200526224908.GC16672@google.com>
 <20200604131029.GA27571@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604131029.GA27571@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:10:30PM +0200, Frederic Weisbecker wrote:
> On Tue, May 26, 2020 at 06:49:08PM -0400, Joel Fernandes wrote:
> > On Tue, May 26, 2020 at 05:20:17PM -0400, Joel Fernandes wrote:
> >  
> > > > The switch happens on the target with IRQs disabled and rdp->nocb_lock
> > > > held to avoid races between local callbacks handling and kthread
> > > > offloaded callbacks handling.
> > > > nocb_cb kthread is first parked to avoid any future race with
> > > > concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
> > > > so that the nocb_gp kthread ignores this rdp.
> > > 
> > > nit: you mean cblist is set to non-offloaded mode right?
> > > 
> > > Also, could you clarify better the rcu_barrier bits in the changelog. I know
> > > there's some issue if the cblist has both offloaded and non-offloaded
> > > callbacks, but it would be good to clarify this here better IMHO.
> > 
> > And for archival purposes: rcu_barrier needs excluding here because it is
> > possible that for a brief period of time, the callback kthread has been
> > parked to do the mode-switch, and it could be executing a bunch of callbacks
> > when it was asked to park.
> > 
> > Meanwhile, more interrupts happen and more callbacks are queued which are now
> > executing in softirq. This ruins the ordering of callbacks that rcu_barrier
> > needs.
> 
> I think in that case the callbacks would still be executed in order. We wait
> for the kthread to park before switching to softirq callback execution.

Ah ok, you are parking the CB kthread after the no-cb CB's are already
invoked (that's when parkme() is called -- i.e. after rcu_do_batch() in the
CB kthread runs).

Yeah, I don't see the purpose of acquiring rcu_barrier mutex either now. Once
you park, all CBs should have been invoked by the nocb CB thread right?
kthread_park() waits for the thread to be parked before proceeding. And you
don't de-offload before it is parked.

> Initially it was to avoid callback ordering issues but I don't recall
> exactly which. Maybe it wasn't actually needed. But anyway I'll keep it
> for the next version where, for a brief period of time, nocb kthread will
> be able to compete with callback execution in softirq.

Which nocb kthread is competing? Do you mean GP or CB?

Either way, could you clarify how does softirqs compete? Until the thread is
parked, you wouldn't de-offload. And once you de-offload, only then the
softirq would be executing callbacks. So at any point of time, it is
either the CB kthread executing CBs or the softirq executing CBs, not both.
Or did I miss something?

thanks,

 - Joel


> I'll clarify that in the changelog.
> 
> Thanks.

Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6869C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4652078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591794767;
	bh=ccKcrDJ9vgY+vczOxvBZN8klM3S/Ibm9bitAkG+Tg1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E7n6grVkrAONJlyJSevg2w82eVyPS4UMUTH00bubGgZAbFp18goUw0SCSTgd6MI1C
	 rr59S1jeBOd1UmiQwYmq+lDaon15xRfZW/1lrh1mEGVlrnr6I0nHuTTlTM+oFbaviJ
	 EJFDTnJUl42M9N4xCuT8I19n5bTN2J3TKEJLZJyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgFJNMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgFJNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:12:42 -0400
Received: from localhost (lfbn-ncy-1-1025-94.w92-138.abo.wanadoo.fr [92.138.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A320206F4;
        Wed, 10 Jun 2020 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591794762;
        bh=ccKcrDJ9vgY+vczOxvBZN8klM3S/Ibm9bitAkG+Tg1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtcXatLaGES4NGAyOj2p9rtVKe3kKZWB8ifao71wky3x/aWfeFYl/jvEEB7mjBIVx
         BgL9X+EyM/SRPK0QB0n5bPb2LbliG5mvtiBbecz3K5PsqfPd8kEKdsXOy/EFLglyQc
         8kLQaX2eDfl+Xw/NXJoKH+B2Bhj6v6EGYYfhvH2Q=
Date:   Wed, 10 Jun 2020 15:12:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200610131238.GA26639@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
 <20200604163655.GC29598@paulmck-ThinkPad-P72>
 <20200608125715.GA30920@lenoir>
 <20200609180227.GR4455@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609180227.GR4455@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:02:27AM -0700, Paul E. McKenney wrote:
> > > > And anyway we still want to unconditionally lock on many places,
> > > > regardless of the offloaded state. I don't know how we could have
> > > > a magic helper do the unconditional lock on some places and the
> > > > conditional on others.
> > > 
> > > I was assuming (perhaps incorrectly) that an intermediate phase between
> > > not-offloaded and offloaded would take care of all of those cases.
> > 
> > Perhaps partly but I fear that won't be enough.
> 
> One approach is to rely on RCU read-side critical sections surrounding
> the lock acquisition and to stay in the intermediate phase until a grace
> period completes, preferably call_rcu() instead of synchronize_rcu().
> 
> This of course means refusing to do a transition if the CPU is still
> in the intermediate state from a prior transition.

That sounds good. But using synchronize_rcu() would be far easier. We
need to keep the hotplug and rcu barrier locked during the transition.

> > Also I've been thinking that rcu_nocb_lock() should meet any of these
> > requirements:
> > 
> > * hotplug is locked
> > * rcu barrier is locked
> > * rnp is locked
> > 
> > Because checking the offloaded state (when nocb isn't locked yet) of
> > an rdp without any of the above locks held is racy. And that should
> > be easy to check and prevent from copy-pasta accidents.
> > 
> > What do you think?
> 
> An RCU read-side critical section might be simpler.

Ok I think I can manage that.

Thanks.

Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5127620870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bw++BqBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgEZV17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390398AbgEZV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:27:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99EDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:27:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so5541671qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8nz3CDdcS0xjg02CzjJ/lD/bQypLpbpXtrEAGZZGJUk=;
        b=bw++BqBUqQLwetAA+/ZijHCPOEGMEeXrj+Qs81iqTH2f8gn3pTZQ68PSv7k6Kt+20V
         hUHG7KXbyZ0Tnp8Z6P6JlBw6WYpSwvwlHcWA8RPpKumqh0HJ7Qm7z9vUu61SVsibaaU8
         Pp5/SndwTBno2mTJzp2xXXhGCRk3aomYP0b5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nz3CDdcS0xjg02CzjJ/lD/bQypLpbpXtrEAGZZGJUk=;
        b=jgGx+ollFBxCguYeAEkH90M1m2nRwfCOl8A90GHOV0274F65UnR3d8FbGH6q8nyxsl
         RQ3n+94L6aWHI/EDqKFXqhZDV4MqruG3/D1P15s5jo5TO3WFKPkByBUIp6JIehjeIu16
         JBpw8/tdax32tThNgzCHdEuymEziLYh19HO6nLRI0jMv88imksJDzDqO5ori52BXeuYV
         fyJa33px+KorNMoTXyGIf33P5iJNudRvvPQJP9NV9+BJyQF9JQhxurLTEoPNIUjsgpoA
         Gujc7CbeOHnEzqM+tXU7CFhGWc3h1+IKiY1U5PERBZtqJtYDOe7A/vUYui8aO5tZFo7/
         y42A==
X-Gm-Message-State: AOAM530lw7JZZYVvA+XMgsCMzI6vsOD9+mo2b4J61BabXi/El3hE9HgT
        j1zXWaObBl7St1/iN3ZuMFHl7A==
X-Google-Smtp-Source: ABdhPJw3XUatTVpVI17pXopA5eDOr2OQSshcYbBh2ZNq2C7/GcywYOXahUTWvoavCbET3sGzaTubfA==
X-Received: by 2002:a37:a111:: with SMTP id k17mr897818qke.376.1590528477822;
        Tue, 26 May 2020 14:27:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o6sm802514qtd.59.2020.05.26.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:27:57 -0700 (PDT)
Date:   Tue, 26 May 2020 17:27:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200526212756.GF76276@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200526152137.GB76276@google.com>
 <20200526162946.GK2869@paulmck-ThinkPad-P72>
 <20200526201840.GC76276@google.com>
 <20200526210947.GP2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526210947.GP2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:09:47PM -0700, Paul E. McKenney wrote:
[...]
> > > > BTW, I'm really itching to give it a try to make the scheduler more deadlock
> > > > resilient (that is, if the scheduler wake up path detects a deadlock, then it
> > > > defers the wake up using timers, or irq_work on its own instead of passing
> > > > the burden of doing so to the callers). Thoughts?
> > > 
> > > I have used similar approaches within RCU, but on the other hand the
> > > scheduler often has tighter latency constraints than RCU does.	So I
> > > think that is a better question for the scheduler maintainers than it
> > > is for me.  ;-)
> > 
> > Ok, it definitely keeps coming up in my radar first with the
> > rcu_read_unlock_special() stuff, and now the nocb ;-). Perhaps it could also
> > be good for a conference discussion!
> 
> Again, please understand that RCU has way looser latency constraints
> than the scheduler does.  Adding half a jiffy to wakeup latency might
> not go over well, especially in the real-time application area.

Yeah, agreed that the "deadlock detection" code should be pretty light weight
if/when it is written.

> But what did the scheduler maintainers say about this idea?

Last I remember when it came up during the rcu_read_unlock_special() deadlock
discussions, there's no way to know for infra like RCU to know that it was
invoked from the scheduler.

The idea I am bringing up now (about the scheduler itself detecting a
recursion) was never brought up (not yet) with the sched maintainers (at
least not by me).

thanks,

 - Joel




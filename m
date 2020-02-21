Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A90C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879A5208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582322502;
	bh=Ht0E3O9Qs6E2ovk0jMpytA79AV8156aqu9AkN7EDT2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rF9t9XwseLSzCu+6BjI1dmUOIN0uUivd5XsH6VFk5dPXjT6Ut6HeMo+d+60GhMQ1/
	 2ZuE79NicIy8LDQLeY1ELiburZLpkywZwMo+wCNVSE/stj0Qd4JN/z3Kedg4Dbfiag
	 4v6w2mebvUNij59PZDew+OUTXsXMn2QyjaRcmf30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgBUWBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbgBUWBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:01:41 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B6F206DB;
        Fri, 21 Feb 2020 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582322500;
        bh=Ht0E3O9Qs6E2ovk0jMpytA79AV8156aqu9AkN7EDT2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd1jqmQ27OeAFQd9EAdBchzNOWMbQqEq3zfOM3fMEJlCiXtNLJf8CsJhEwWoANLaQ
         3BWNoFUx8NGw0mb2ka2KUOqk8oWCktt2mE2iKL7LvgvfZfN61N2BT1ZlTkqpE9x8ml
         mEsTQwvkipNKLc4llAa1cuC9qUjNb63z+02kbJKA=
Date:   Fri, 21 Feb 2020 23:01:37 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Message-ID: <20200221220136.GA28251@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200221100855.2f9bec3a@gandalf.local.home>
 <20200221202511.GB14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221202511.GB14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:25:11PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 10:08:55AM -0500, Steven Rostedt wrote:
> > On Fri, 21 Feb 2020 14:34:17 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
> > >  
> > >  void lockdep_off(void)
> > >  {
> > > -	current->lockdep_recursion++;
> > > +	current->lockdep_recursion += BIT(16);
> > >  }
> > >  EXPORT_SYMBOL(lockdep_off);
> > >  
> > >  void lockdep_on(void)
> > >  {
> > > -	current->lockdep_recursion--;
> > > +	current->lockdep_recursion -= BIT(16);
> > >  }
> > >  EXPORT_SYMBOL(lockdep_on);
> > >  
> > 
> > > +
> > > +static bool lockdep_nmi(void)
> > > +{
> > > +	if (current->lockdep_recursion & 0xFFFF)
> > 
> > Nitpick, but the association with bit 16 and this mask really should be
> > defined as a macro somewhere and not have hard coded numbers.
> 
> Right, I suppose I can do something like:
> 
> #define LOCKDEP_RECURSION_BITS	16
> #define LOCKDEP_OFF (1U << LOCKDEP_RECURSION_BITS)
> #define LOCKDEP_RECURSION_MASK (LOCKDEP_OFF - 1)

With that I'd say

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

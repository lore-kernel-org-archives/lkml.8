Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24976C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E952220786
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593003828;
	bh=0qG4FzuUMsbomqk+xttMakSicquRd3Y77xHixAAXZFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=UILeZ3HEstoxCtBfJ0DFmqwscRlIfRXSXkI8dBykkSI3bcOeaFz4Rfq9iK9+kiQPq
	 cqhLv+wER2j+8AO3SOtMRwB0EOog8XBjAYo3OVHH4VM+4w4JDq8kHdLSwu004LC9k/
	 GLoenp/+gp174XGhcRhPLARaGuGcCWUHvhNWkq+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbgFXNDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390586AbgFXNDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:03:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23C22082F;
        Wed, 24 Jun 2020 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593003818;
        bh=0qG4FzuUMsbomqk+xttMakSicquRd3Y77xHixAAXZFE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eUtzm10VWIy9qeD2lgs6qftL20dV65oXtRI7OgMkTiaTnbgNxGwMXYwBk1Xfyx4sE
         WMBEbkfDn8OJnJ5mvptg4MKEeRmkBw2SxkUQAqfH7wx/I91cGm1Oqy3pfv5qcqkCk2
         ceXHzvWEywom7NT6HJh4gBQxY0vAESvzYNHgcn/I=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA3743523267; Wed, 24 Jun 2020 06:03:38 -0700 (PDT)
Date:   Wed, 24 Jun 2020 06:03:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200624130338.GF9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
 <20200619221555.GA12280@paulmck-ThinkPad-P72>
 <20200623204646.GF2483@worktop.programming.kicks-ass.net>
 <20200623214433.GX9247@paulmck-ThinkPad-P72>
 <20200624075249.GC4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624075249.GC4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:52:49AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 02:44:33PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 23, 2020 at 10:46:46PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jun 19, 2020 at 03:15:55PM -0700, Paul E. McKenney wrote:
> > > 
> > > > Just following up because I don't see this anywhere.  If I am supposed
> > > > to take this (which is more plausible now that v5.8-rc1 is out), please
> > > > let me know.
> > > 
> > > Sorry, I got distracted by that NULL ptr thing, but that seems sorted
> > > now. If you don't mind taking it through your rcu/urgent tree for -rc3
> > > or so that would be awesome.
> > 
> > Will do!
> > 
> > Just to double-check, this is the patch from you with Message-ID
> > 20200603114051.896465666@infradead.org, correct?
> > 
> > Or, if you prefer, this commit now on -rcu?
> > 
> > 	5fe289eccfe5 ("rcu: Fixup noinstr warnings")
> > 
> > If this is the correct commit, I will rebase it on top of v5.8-rc2,
> > and if it passes tests, send it along via rcu/urgent.
> 
> Ah, I was thinking about:
> 
>   https://lore.kernel.org/lkml/20200615162427.GI2554@hirez.programming.kicks-ass.net/
> 
> seeing how I added that instrumentation you wanted :-), but either
> version should work for now. KCSAN is sad without this.

Glad I asked!  I will substitute the one you pointed out above.

							Thanx, Paul

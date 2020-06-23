Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B215C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701622078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948682;
	bh=F3cduie+7HxSmm3SlSwpnqOPWqiGsIacr9+k/Jixv34=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=l324rO+qR3TQN0ybpK7O8u24FFNiOHQEjoEsGf7MvoQ8qtFkZk7tzfMatFfpeddhN
	 NlbK80zJr1LT/1uDc3aGJBFdy44otzUxRQgdp5MHY8mDx2eE1iDP47ME6MQL9Xudes
	 JVUbTj4JrowHn9Y3TtjKLSerNV0Ya8qQFw/L/BDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393868AbgFWVok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388581AbgFWVoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:44:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58EC2078A;
        Tue, 23 Jun 2020 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592948673;
        bh=F3cduie+7HxSmm3SlSwpnqOPWqiGsIacr9+k/Jixv34=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M5bJeLzLT3a2G97qkSIxIdL8AP9OVQH66mZATVT5N9VcCipgteLJXmLIdzHwhFAys
         xPdKK4dYoA8o0b4cNSS0tWZhXiMqCl65BAwqglM5u6GJDFQB2ccrPA6CqOpyEePXej
         uHDE1j5uiQI2UNKyh5G0tWXRmiViTwulhSUZqmdc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D19AD3522657; Tue, 23 Jun 2020 14:44:33 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:44:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200623214433.GX9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
 <20200619221555.GA12280@paulmck-ThinkPad-P72>
 <20200623204646.GF2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623204646.GF2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:46:46PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 19, 2020 at 03:15:55PM -0700, Paul E. McKenney wrote:
> 
> > Just following up because I don't see this anywhere.  If I am supposed
> > to take this (which is more plausible now that v5.8-rc1 is out), please
> > let me know.
> 
> Sorry, I got distracted by that NULL ptr thing, but that seems sorted
> now. If you don't mind taking it through your rcu/urgent tree for -rc3
> or so that would be awesome.

Will do!

Just to double-check, this is the patch from you with Message-ID
20200603114051.896465666@infradead.org, correct?

Or, if you prefer, this commit now on -rcu?

	5fe289eccfe5 ("rcu: Fixup noinstr warnings")

If this is the correct commit, I will rebase it on top of v5.8-rc2,
and if it passes tests, send it along via rcu/urgent.

							Thanx, Paul

Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29358C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F9F24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582139124;
	bh=a8v8o/RLgXbtSPWW2aaagFCiOmMgfZKdTuyS8Lp1V+8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jEdXsrNAutzlfUXQH20uxMUNqywaxo6OLRdLDmUj8TZdbTmgDfomFCBKXTTcpI2S9
	 xtnSq4p8z4e5FbUP68e7cbQreVCadqlsn6MpKEowA83IpkK5bky8WuL7vj0TJ1GJe0
	 KeMzLRW3U/iua6uyJZhVN5YgCghlWYaR/237DypQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBSTFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgBSTFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:05:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025C624654;
        Wed, 19 Feb 2020 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582139122;
        bh=a8v8o/RLgXbtSPWW2aaagFCiOmMgfZKdTuyS8Lp1V+8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aoKhVjpyyOdq2W0Mcocjnqb+Ff8EeI0eZ2hOC84yrZTmvSpFNnA6UWbKVu2QtjC48
         xcm/bJycVQnY8Yewh/mwYYPiiXBF6eCgEfdgrAepABeWgp8/BosEa+FVsTAorMv/4p
         9i8cE787xpfvfTYv29SzApEvz0/xZah1hbKFDT5Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D2D903520BB6; Wed, 19 Feb 2020 11:05:21 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:05:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200219190521.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150745.125119627@infradead.org>
 <20200219164356.GB2935@paulmck-ThinkPad-P72>
 <20200219164736.GL18400@hirez.programming.kicks-ass.net>
 <20200219170507.GH14946@hirez.programming.kicks-ass.net>
 <20200219122116.7aeaf230@gandalf.local.home>
 <20200219174025.GJ2935@paulmck-ThinkPad-P72>
 <20200219130012.116670fd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219130012.116670fd@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:12PM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 09:40:25 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Correct, and if rcuidle is not set, and this is a macro, the SRCU
> > > portion is compiled out.  
> > 
> > Sigh!  Apologies for the noise!
> > 
> > If we are using SRCU, we don't care whether or not RCU is watching.  OK,
> > maybe finally catching up -- the whole point was use of RCU in other
> > tracing code, wasn't it?
> 
> Some callbacks (namely perf) might use RCU, but then the callbacks
> need to make sure rcu is watching.

Got it, thank you!

							Thanx, Paul

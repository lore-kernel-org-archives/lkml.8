Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675EB2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589471434;
	bh=5tSjNChQ6lIWRMBCkikt2nPuu1u6XyTfuXs2AiZn6Ws=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LKjYEclXOdkoRpF+xeucOyosuwoWTQdDIvJSnep6hVrjM7Sw52vNwg+YnnUMygMcS
	 HxCcXcc1bvLiuXHj+x9kKxaFsGFb9z5ohFQmTLZn0NFQ44QXpbmJXIe+6nQpkhjVnV
	 aJDgfA9GPCFH3a7Zcqy6CoJ8YAe5/8+lO9sS/T1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgENPud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgENPud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:50:33 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C24206A5;
        Thu, 14 May 2020 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589471432;
        bh=5tSjNChQ6lIWRMBCkikt2nPuu1u6XyTfuXs2AiZn6Ws=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PJPRRTfSUaf9HnO7ggpV1YaRRzlO36Yg5u5DvUb3QyKw34quNnibbBMuEqvwvaR5s
         rPOIao0VbaPs5gIhJRITJEvZwsQzlNZvZfJfMdbjVPNX9Z9pGpN/vT7B+660iGyMjB
         rNj1sUjoWWp1KF65oOlaWbiLYS18Y4C2f478GyY4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 86A6C35229C5; Thu, 14 May 2020 08:50:32 -0700 (PDT)
Date:   Thu, 14 May 2020 08:50:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 07/10] rcu: Temporarily assume that nohz full CPUs might
 not be NOCB
Message-ID: <20200514155032.GN2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-8-frederic@kernel.org>
 <20200513182527.GU2869@paulmck-ThinkPad-P72>
 <20200513230827.GC18303@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513230827.GC18303@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:08:28AM +0200, Frederic Weisbecker wrote:
> On Wed, May 13, 2020 at 11:25:27AM -0700, Paul E. McKenney wrote:
> > On Wed, May 13, 2020 at 06:47:11PM +0200, Frederic Weisbecker wrote:
> > > So far nohz_full CPUs had to be nocb. This requirement may change
> > > temporarily as we are working on preparing RCU to be able to toggle the
> > > nocb state of a CPU. Once that is done and nohz_full can be toggled as
> > > well dynamically, we'll restore that initial requirement.
> > 
> > Would it simplify anything to make the CPU exit nohz_full first and
> > then exit rcu_nocb and vice versa in the other direction?  That way the
> > assumption about nohz_full CPUs always being rcu_nocb could remain while
> > still allowing runtime changes to both states.
> 
> That's the future plan but for now nohz_full can't even be exited yet.
> RCU is unlucky enough to be chosen as the starting point of this whole work :-)

But testing could still start with CPUs marked rcu_nocb but not marked
nohz_full, right?  I must confess that I am a bit concerned about the
increase in state space.

> > Of course, given that setup, it would not be possible to cause a CPU to
> > exit rcu_nocb state if it was still in nohz_full state.
> 
> Right.
> 
> > My fear is that allowing a CPU to be in nohz_full state without also
> > being in rcu_nocb state will cause needless confusion and bug reports.
> 
> Well, it should only be visible to those who work on it since there
> won't be a proper interface before we achieve the whole.

Fair point, but I am also concerned about the welfare of the people
working on it.  ;-)

							Thanx, Paul

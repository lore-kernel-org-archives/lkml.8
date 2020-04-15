Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3DC38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA14206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586919573;
	bh=Yjt5Xq2CfAH7PhBOXhU96HyCZf6QmoQWQKekQwpFeCg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OUc3Q7ob9TnQufBr8CqsSqijfdMZbFeodoJzQfWTn1St56raickrDHRIjwcpwmc0R
	 y3z+BCJ+yMCOeLzXo2u8Mp1oHypVsXQsLK/OGb2K/5CdScSfGP+rCOxCZcuqEk8PAP
	 Ki7t6ZRqJFoaJxEGTsPm6snFWzf+LI8B4b+No3Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393027AbgDOC71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgDOC5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:57:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34EA92072D;
        Wed, 15 Apr 2020 02:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586919469;
        bh=Yjt5Xq2CfAH7PhBOXhU96HyCZf6QmoQWQKekQwpFeCg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=msllIUY/kLaFCL4HM+f8aIub1ex1rah0PrYYaz/dyaYD+brlkSekA3MQC3seRRbvE
         YXfX8FG8V/HfIBAgx0GwdEm4XYTsWCCJPid3Uan7iY2mOS5INPdgBj8PHAjg5NGt48
         sSi/0pgRi9WDdAQLCRsVZyOyAi2ir/+RzN2pchz4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0721B3522B2F; Tue, 14 Apr 2020 19:57:49 -0700 (PDT)
Date:   Tue, 14 Apr 2020 19:57:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415025748.GV17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 07:20:01PM -0700, John Stultz wrote:
> Hey folks,
>   So recently I was looking at converting some drivers to be loadable
> modules instead of built-in only, and one of my patches just landed in
> -next and started getting build error reports.
> 
> It ends up, recently in the merge window, the driver I was converting
> to module switched a trace_*() function to trace_*_rcuidle() to fix a
> bug.  Now when building as a module, if tracing is configured on, it
> can't seem to find the trace_*_rcuidle() symbol.
> 
> This is because, as you are aware, we don't declare trace_*_rcuidle
> functions in modules - and haven't for quite some time:
>   https://lore.kernel.org/lkml/20120905062306.GA14756@leaf/
> 
> I wanted to better understand the background rationale for that patch,
> to understand if not exporting the rcu_idle_exit and rcu_idle_enter,
> calls was because they weren't used or if it was a more intentional
> decision to avoid allowing modules to use them.
> 
> Would it be reasonable to revisit that patch? Or is there some
> recommended alternative solution?

I will defer to Steven and Josh on the rationale.  (Cowardly of me,
I know!)

What I do is to maintain a wrapper for tracepoints within a built-in
portion of RCU, export the wrapper, and invoke the wrapper from the
rcutorture module.  Maybe you can do something similar?

But why would a module be invoked from the idle loop?  Is the module
supplying an idle driver or some such?

							Thanx, Paul

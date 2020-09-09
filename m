Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAE62087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599705158;
	bh=GitDIBjazlg2aEqgUHmiwSZ1KvMEnONcmZnbecWQMHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lmrra/W9r+femQHr9nTxWW5XGGQzuySgCRxsIeQvcS3R/Z851lfWSBItQviaoDgeu
	 9OP1LWEy3dOfTLdjWSFJZIpLMkJtm0+3152PpEj3k7znI3BpXE9px2kdN1JKi7O8OF
	 osAUBwV21biy8hWxm5Y7F96ewWPCY9x2V1cxoDns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgIJCc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730920AbgIJCZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:25:30 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C863520C09;
        Wed,  9 Sep 2020 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599691735;
        bh=GitDIBjazlg2aEqgUHmiwSZ1KvMEnONcmZnbecWQMHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWBOrgBhJ6HySZn5zs3kJR2qeJSz9FHowfK3pRxJokck9fF7dQDomXTHwy2FSiAJl
         r2nuh0mLY0R75xVoBe/3vRdkWNP04KJ4e8z8/pHu2SzmMgpAy+79VLmBzEK6yT5+2h
         4KYi+gJ8FApk6hC0cW3PTD13MAv7IOogBAXJAyYM=
Date:   Thu, 10 Sep 2020 00:48:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200909224852.GC20541@lenoir>
References: <20200901104640.GA13814@lenoir>
 <20200904204740.GP29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904204740.GP29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 01:47:40PM -0700, Paul E. McKenney wrote:
> On Tue, Sep 01, 2020 at 12:46:41PM +0200, Frederic Weisbecker wrote:
> > Hi,
> > 
> > I'm currently working on making nohz_full/nohz_idle runtime toggable
> > and some other people seem to be interested as well. So I've dumped
> > a few thoughts about some pre-requirements to achieve that for those
> > interested.
> > 
> > As you can see, there is a bit of hard work in the way. I'm iterating
> > that in https://pad.kernel.org/p/isolation, feel free to edit:
> > 
> > 
> > == RCU nocb ==
> > 
> > Currently controllable with "rcu_nocbs=" boot parameter and/or through nohz_full=/isolcpus=nohz
> > We need to make it toggeable at runtime. Currently handling that:
> > v1: https://lwn.net/Articles/820544/
> > v2: coming soon
> 
> Looking forward to seeing it!

So many ordering riddles I had to put on paper. But I'm getting close to
something RFC-postable now.

> 
> > == TIF_NOHZ ==
> > 
> > Need to get rid of that in order not to trigger syscall slowpath on CPUs that don't want nohz_full.
> > Also we don't want to iterate all threads and clear the flag when the last nohz_full CPU exits nohz_full
> > mode. Prefer static keys to call context tracking on archs. x86 does that well.
> 
> Would it help if RCU was able to, on a per-CPU basis, distinguish between
> nohz_full userspace execution on the one hand and idle-loop execution
> on the other?  Or do you have some other trick in mind?

No it's more about context tracking. Initially it used TIF_NOHZ to enter
the syscall slow path and call to context tracking on kernel entry and exit.

The problem is that it forces all CPUs, including housekeepers, to run into
that syscall slowpath. So we rather want the context tracking call conditional
on a per cpu basis and not on a per task basis. And static keys are good for
that. That's what x86 does.

So RCU can't help much I fear (but hey, first time I can say that! ;-)

Thanks.

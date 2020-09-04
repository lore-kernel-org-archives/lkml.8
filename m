Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2812C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765852083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599249391;
	bh=kyHoXHEB1z/l8Lhheci0db779WAaZP7g3X/GY0wTX/0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mLACwoy4ih/pyl+Aa8bYzllBy3mXDR3cTrJgiHSWcrq3ar0irNbPcQ7+uhw+Vz7Ig
	 0wZRhDUbq9PKAEwfJTXTQN6cGDF3LVjQbNr858kNvC4YSslDv/gi1g2Y93ftCfQyNW
	 jVzaK7ojqrMhruswAUfUj4EHW4TQYdb6yf4kVvic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgIDT4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDT43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:56:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C614F2083B;
        Fri,  4 Sep 2020 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599249388;
        bh=kyHoXHEB1z/l8Lhheci0db779WAaZP7g3X/GY0wTX/0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fgpqOGhQGo60q54JVzmValSlg7QFPXxeDRZdxmpBBH7tU+CIllfB6wZk6AFjNzcXs
         ItTNSOX0Xog2hhqh/W//kqasiYD6UR/n2ZAbS3xMKuACgHkSKgfiJmSpmE92DbCAYV
         92v3JwoEyNfxAKwxZEP996hhGAqpiu3VR1jvwiFw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9976C352162B; Fri,  4 Sep 2020 12:56:28 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:56:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200904195628.GL29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
 <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
 <20200902155410.GH29330@paulmck-ThinkPad-P72>
 <20200903200639.GA8956@paulmck-ThinkPad-P72>
 <20200904172432.wgxn6x5tpnt4lcln@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904172432.wgxn6x5tpnt4lcln@linux-p48b>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 10:24:32AM -0700, Davidlohr Bueso wrote:
> On Thu, 03 Sep 2020, Paul E. McKenney wrote:
> 
> > commit d93a64389f4d544ded241d0ba30b2586497f5dc0
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Sep 1 16:58:41 2020 -0700
> > 
> >    torture: Periodically pause in stutter_wait()
> > 
> >    Running locktorture scenario LOCK05 results in hangs:
> > 
> >    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
> > 
> >    The lock_torture_writer() kthreads set themselves to MAX_NICE while
> >    running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
> >    also SCHED_OTHER.  This results in these other locktorture kthreads
> >    indefinitely preempting the lock_torture_writer() kthreads.  Note that
> >    the cond_resched() in the stutter_wait() function's loop is ineffective
> >    because this scenario is built with CONFIG_PREEMPT=y.
> > 
> >    It is not clear that such indefinite preemption is supposed to happen, but
> >    in the meantime this commit prevents kthreads running in stutter_wait()
> >    from being completely CPU-bound, thus allowing the other threads to get
> >    some CPU in a timely fashion.  This commit also uses hrtimers to provide
> >    very short sleeps to avoid degrading the sudden-on testing that stutter
> >    is supposed to provide.
> > 
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviwed-by: Davidlohr Bueso <dbueso@suse.de>

Applied, thank you!

							Thanx, Paul

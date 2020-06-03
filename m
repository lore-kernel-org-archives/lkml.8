Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8577F207ED
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591207872;
	bh=dbdZ2Zri2MRs+RtGvh5/n56tv50ACELvzX6ycBRjknM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZKK3Lqk7R3v6vSjncZI0wta0AJBXF9DxWG6xsWeZQY/qD7TryuIIXSECPYHJa4K1l
	 0yh/tGtxwG6Bc3IPwwpxZCqjPiGHYHeiJRuo97EpsZa9K7Wav6kiBpHexGIgS2sxtc
	 m2LJ1S1ePrYuyAjTomdjAeAJPCbElEK68b5MWV+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFCSLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgFCSLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:11:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8827207D3;
        Wed,  3 Jun 2020 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591207869;
        bh=dbdZ2Zri2MRs+RtGvh5/n56tv50ACELvzX6ycBRjknM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F7CUJv/UYkI0d5tmTC5kszJufUeac232ZpexEXJ5S5wW5RwSa2s/BliRunX8tXXT9
         rsHSFY/F785waDH+jrn++C+auqsfpbMIW8pgJGU0lwAIkwV2O9fYp0iZx5k/WgX8c7
         lnDZZOU8pgTPuedsblLadu0vA5SU2GczCrcFODgA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AB01935209C5; Wed,  3 Jun 2020 11:11:09 -0700 (PDT)
Date:   Wed, 3 Jun 2020 11:11:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>
Subject: Re: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
Message-ID: <20200603181109.GA5438@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
 <20200526182744.GA3722128@gmail.com>
 <20200527011413.GD149611@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200527011413.GD149611@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:14:13PM -0400, Joel Fernandes wrote:
> On Tue, May 26, 2020 at 08:27:44PM +0200, Ingo Molnar wrote:
> [...]
> > ./include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument
> > of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’
> > [-Wformat=] 5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */ |
> > ^~~~~~
> > ./include/linux/kern_levels.h:9:20: note: in expansion of macro ‘KERN_SOH’
> >     9 | #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
> >       |                    ^~~~~~~~
> > ./include/linux/printk.h:295:9: note: in expansion of macro ‘KERN_ALERT’
> >   295 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> >       |         ^~~~~~~~~~
> > kernel/rcu/rcuperf.c:726:2: note: in expansion of macro ‘pr_alert’
> >   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> >       |  ^~~~~~~~
> > kernel/rcu/rcuperf.c:726:32: note: format string is defined here
> >   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> >       |                              ~~^
> >       |                                |
> >       |                                long unsigned int
> >       |                              %u
> > 
> > 
> > The reason for the warning is that both kfree_mult and sizeof() are 
> > 'int' types on 32-bit kernels, while the format string expects a long.
> > 
> > Instead of casting the type to long or tweaking the format string, the 
> > most straightforward solution is to upgrade kfree_mult to a long. 
> > Since this depends on CONFIG_RCU_PERF_TEST
> 
> Thanks for fixing it.
> 
> > BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
> > to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
> > mistakenly believe that it's somehow related to perf, while it isn't. =B-)
> 
> Would it be better to call it 'RCUPERF_TEST' instead of the
> 'RCU_PERFORMANCE_TEST' you are proposing? I feel the word 'PERFORMANCE' is
> too long.  Also, 'rcuperf test' instead of the 'rcu performance test' you are
> proposing.  I am Ok with doing it however you and Paul want it though, let me
> know.

As long as we are bikeshedding the name...  How about refscale.c and
RCU_REF_SCALE_TEST on the one hand and rcuscale.c and RCU_SCALE_TEST on
the other?  That keeps the names reasonably short and does not allude
to perf at all.

> Paul, should I send you a renaming patch for the new performance tests as
> well (which I believe should be in the -dev branch).

I am still modifying refperf/refscale/refwhatever, so I will update
that one.

						Thanx, Paul

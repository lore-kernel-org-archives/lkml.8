Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4E1206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589496926;
	bh=aGeCI+Qv8B6n0K42ZzRxKJ2ucEtQcxVngEp1XIb0pco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qx7K+3UawWKwQIQXHT8yN3El6DpnWO3bKSlEhxRIprklIdEq2EcjwXqgEO35SY6/T
	 i3IYt3W2366IYjvfuivblajCYOq6M27lne2M3+VhwJ6F+NSjNOZVOBCcX5c+jRcpk2
	 DMv6aheBQKyn8F6sGahFTyHc4bg52aZGKC0W4Xvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgENWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgENWzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:55:23 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063692065C;
        Thu, 14 May 2020 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589496923;
        bh=aGeCI+Qv8B6n0K42ZzRxKJ2ucEtQcxVngEp1XIb0pco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3AHuFskzTCvg6R7XIzApf7njfTeEYG1yxqd7ZRAYRucvX9TtS+kz6R7nriZmQ8RY
         cXNEEx+QizC6lb1mbikr5fnClqaXRYOETWjHDJURvrKvq+2c/ttzXd8cAs9WXg0KpJ
         cmW08QcnWCfgGxU1v++/tvGfVA3mGMbf9PIFh04A=
Date:   Fri, 15 May 2020 00:55:21 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200514225520.GC4071@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200513183831.GV2869@paulmck-ThinkPad-P72>
 <20200513224525.GA18303@lenoir>
 <20200514154707.GL2869@paulmck-ThinkPad-P72>
 <20200514223021.GA4071@lenoir>
 <20200514224735.GA2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514224735.GA2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:47:35PM -0700, Paul E. McKenney wrote:
> On Fri, May 15, 2020 at 12:30:23AM +0200, Frederic Weisbecker wrote:
> > On Thu, May 14, 2020 at 08:47:07AM -0700, Paul E. McKenney wrote:
> > > On Thu, May 14, 2020 at 12:45:26AM +0200, Frederic Weisbecker wrote:
> > > This last seems best to me.  The transition from CBLIST_NOT_OFFLOADED
> > > to CBLIST_OFFLOADING of course needs to be on the CPU in question with
> > > at least bh disabled.  Probably best to be holding rcu_nocb_lock(),
> > > but that might just be me being overly paranoid.
> > 
> > So that's in the case of offloading, right? Well, I don't think we'd
> > need to even disable bh nor lock nocb. We just need the current CPU
> > to see the local update of cblist->offloaded = CBLIST_OFFLOADING
> > before the kthread is unparked:
> > 
> >     cblist->offloaded = CBLIST_OFFLOADING;
> >     /* Make sure subsequent softirq lock nocb */
> >     barrier();
> >     kthread_unpark(rdp->nocb_cb_thread);
> > 
> > Now, although that guarantees that nocb_cb will see CBLIST_OFFLOADING
> > upon unparking, it's not guaranteed that the nocb_gp will see it on its
> > next round. Ok so eventually you're right, I should indeed lock nocb...
> 
> I suspect that our future selves would hate us much less if we held
> that lock.  ;-)

Also, taking the decision to hold that lock could teach a lesson to our
past selves. Win-win! Let us become that most welcome time bridge!

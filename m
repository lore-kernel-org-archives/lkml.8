Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD441C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE68D2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589411314;
	bh=McI+T2hmy1wwsLIjP6KHQL0XtS4SuVPV85zl2tKT4R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aqrHFdpo3cNjemonJF/MpEcHqIsPkMm/4xGrBhvSluoEGY2NIrcMXZYwRFhoy3BjP
	 viVoey5xtQ8rRCfwdsLdsacYlY6Xpi8GRsqCdFvOMzR/AX+ZCWIOZp6yBANwuXeC+F
	 A7ObRYS5jz+FCYWm7+haVCxRCnBDPSYBbsBnwQZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgEMXId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbgEMXIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:08:31 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02F42054F;
        Wed, 13 May 2020 23:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589411311;
        bh=McI+T2hmy1wwsLIjP6KHQL0XtS4SuVPV85zl2tKT4R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FykKUVt2XXJz9k5bULOrNTaBEImxREfbnLQ89y6LYJmgLYhxSoCOYimRQhDZAsBUG
         kvfisUu5mlMWAA//YJlD6+QsxMRyoZxQbIO/9TCPJFzn/5N1ivzQPzMdnqG9JDGPVj
         lYDQv+UxYs33lGoTs3o2hqYpksBXGCva+7Qx11OY=
Date:   Thu, 14 May 2020 01:08:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 07/10] rcu: Temporarily assume that nohz full CPUs might
 not be NOCB
Message-ID: <20200513230827.GC18303@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-8-frederic@kernel.org>
 <20200513182527.GU2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513182527.GU2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:25:27AM -0700, Paul E. McKenney wrote:
> On Wed, May 13, 2020 at 06:47:11PM +0200, Frederic Weisbecker wrote:
> > So far nohz_full CPUs had to be nocb. This requirement may change
> > temporarily as we are working on preparing RCU to be able to toggle the
> > nocb state of a CPU. Once that is done and nohz_full can be toggled as
> > well dynamically, we'll restore that initial requirement.
> 
> Would it simplify anything to make the CPU exit nohz_full first and
> then exit rcu_nocb and vice versa in the other direction?  That way the
> assumption about nohz_full CPUs always being rcu_nocb could remain while
> still allowing runtime changes to both states.

That's the future plan but for now nohz_full can't even be exited yet.
RCU is unlucky enough to be chosen as the starting point of this whole work :-)

> Of course, given that setup, it would not be possible to cause a CPU to
> exit rcu_nocb state if it was still in nohz_full state.

Right.

> My fear is that allowing a CPU to be in nohz_full state without also
> being in rcu_nocb state will cause needless confusion and bug reports.

Well, it should only be visible to those who work on it since there
won't be a proper interface before we achieve the whole.

Thanks.

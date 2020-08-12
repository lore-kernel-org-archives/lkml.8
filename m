Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2BEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E198A20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597272398;
	bh=oc+ohRag7pYOn+FcUWQS7UZxM6OM07zEbxj2hV6ktV8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=L3dSe22yaWlFyGl5nmPcrSKJdz1D+uV/X2e263VzoEfcd0xbPogaz/NYRdx5ijBIW
	 lC+gxvMmzmFGLRldlByGQLlrQbAHo9X9lYGkYO4D4vURO/91HDj3OvwjwqsPAi54Gs
	 JUmpNEPmUUAXrY3mF8qLG9UfC9humj91HeX9ZqnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHLWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHLWqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:46:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197ED20771;
        Wed, 12 Aug 2020 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597272396;
        bh=oc+ohRag7pYOn+FcUWQS7UZxM6OM07zEbxj2hV6ktV8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=INtZAQeXLlaOFthMX/864ZzbNKQTD+ov/t+kWeNzZUhit0Jf3Jd9Z8nLd4nY9dFqb
         iCj1Hx9p/2E8NiPhWgyDaGP57Hke6JoYpsGjELW50PP0MAzJXXF/37b9p1DtACAp0Q
         JDX7rTFJgf/4U6yVCdJzNSL4CdRrBx7mN8mwtGKY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EF6943522615; Wed, 12 Aug 2020 15:46:35 -0700 (PDT)
Date:   Wed, 12 Aug 2020 15:46:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Optimize debugfs stats counters
Message-ID: <20200812224635.GL4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200810080625.1428045-1-elver@google.com>
 <CANpmjNP5WpDyfXDc=v6cerd5=GpKyCmBKAKH+6qLT6JrBGPqnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP5WpDyfXDc=v6cerd5=GpKyCmBKAKH+6qLT6JrBGPqnw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 03:02:14PM +0200, Marco Elver wrote:
> On Mon, 10 Aug 2020 at 10:06, Marco Elver <elver@google.com> wrote:
> > Remove kcsan_counter_inc/dec() functions, as they perform no other
> > logic, and are no longer needed.
> >
> > This avoids several calls in kcsan_setup_watchpoint() and
> > kcsan_found_watchpoint(), as well as lets the compiler warn us about
> > potential out-of-bounds accesses as the array's size is known at all
> > usage sites at compile-time.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  kernel/kcsan/core.c    | 22 +++++++++++-----------
> >  kernel/kcsan/debugfs.c | 21 +++++----------------
> >  kernel/kcsan/kcsan.h   | 12 ++++++------
> >  kernel/kcsan/report.c  |  2 +-
> >  4 files changed, 23 insertions(+), 34 deletions(-)
> 
> Hi Paul,
> 
> I think this one is good to apply. I do not expect conflicts with current -rcu.

Applied and pushed, thank you!  And as you say, no drama.  ;-)

							Thanx, Paul

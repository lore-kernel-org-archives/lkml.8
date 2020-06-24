Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEF2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580352073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Xu6e4Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404745AbgFXQBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404503AbgFXQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:01:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CA4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v3x/1+aA2hYxMqnc8Sv46f0APOAZVpXfQ+x0uGwc2I4=; b=1Xu6e4JcBi33P7SGcOnGkbyQa3
        miIj5qy5c0klrtgHanTlyDn4OGcORb6D6SW8aIvhajqrGfe95icUusLuz+zeIfd1zrcqYiJw5d8R1
        IeiCbsdQnzssNtsCAHpwYhuTkcsS3WcS+nPRWK8KISkDaIfQSxk7PsciFL3z11yJZXPeICvLQnmoT
        FPWm/CCRHH18L+1qjbgbfbIYxi/OmgxG/hU+7539IpJbOtD2E6yI4t/IQjyro7gUGxr0GR8Ei02PK
        4vSoQZGU3xWGftYfo2qs0bHIpQxhsssOhy3Zh63ZcTTUPceMlHYd2PrM+37N1TS15frAUhb7/qK+g
        x3lRcPJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7pm-00064Y-Iy; Wed, 24 Jun 2020 16:01:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FF19300261;
        Wed, 24 Jun 2020 18:01:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D08B203CDC50; Wed, 24 Jun 2020 18:01:09 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:01:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200624160109.GK4781@hirez.programming.kicks-ass.net>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:40:21PM +0100, Qais Yousef wrote:
> On 06/22/20 11:21, Doug Anderson wrote:
> 
> [...]
> 
> > > If you propose something that will help the discussion. I think based on the
> > > same approach Peter has taken to prevent random RT priorities. In uclamp case
> > > I think we just want to allow driver to opt RT tasks out of the default
> > > boosting behavior.
> > >
> > > I'm a bit wary that this extra layer of tuning might create a confusion, but
> > > I can't reason about why is it bad for a driver to say I don't want my RT task
> > > to be boosted too.
> > 
> > Right.  I was basically just trying to say "turn my boosting off".
> > 
> > ...so I guess you're saying that doing a v2 of my patch with the
> > proper #ifdef protection wouldn't be a good way to go and I'd need to
> > propose some sort of API for this?
> 
> It's up to Peter really.
> 
> It concerns me in general to start having in-kernel users of uclamp that might
> end up setting random values (like we ended having random RT priorities), that
> really don't mean a lot outside the context of the specific system it was
> tested on. Given the kernel could run anywhere, it's hard to rationalize what's
> okay or not.
> 
> Opting out of default RT boost for a specific task in the kernel, could make
> sense though it still concerns me for the same reasons. Is this okay for all
> possible systems this can run on?
> 
> It feels better for userspace to turn RT boosting off for all tasks if you know
> your system is powerful, or use the per task API to switch off boosting for the
> tasks you know they don't need it.
> 
> But if we want to allow in-kernel users, IMO it needs to be done in
> a controlled way, in a similar manner Peter changed how RT priority can be set
> in the kernel.
> 
> It would be good hear what Peter thinks.

Hurmph.. I think I understand the problem, but I'm not sure what to do
about it :-(

Esp. given the uclamp optimization patches now under consideration. That
is, if random drivers are going to install uclamps, then that will
automagically enable the static_key and make the scheduler slower, even
if that driver isn't particularly interesting to the user.



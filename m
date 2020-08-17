Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83C2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73DF2065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677285;
	bh=vmZopscrrrNVPg+TZSZSOT25ARHVYFGtjVF3we5IiyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D8gP+oOW1Oe6MhhwYD1j/1Aacmq1FCBs9pVJBAbdDADgmaGMqsla762RVSbAXCz2Y
	 mVPaY9YzdOr1kgH6JqDGdu23sLxLLfSsqg6hFanLU6GeMg2VhJIr+M0KFgJxPo2F0+
	 FQGR6k2MKPbjXpDqv+CfNEXS7oJll5YucgnsW9C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgHQPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:14:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D422065C;
        Mon, 17 Aug 2020 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677281;
        bh=vmZopscrrrNVPg+TZSZSOT25ARHVYFGtjVF3we5IiyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFbu64yLvCssDuY4hU3yyUolk8H3x2CQiPa2i8Ipvkb3dLW2HTQC7JCkzoXKIg/k3
         do8VFwoBvLDDsj0CgxNYpVR7eS98GAxajWsSQERzn28DFAiqrBFF1EOt+wXyHje5uI
         v02gQuNr4fJ4JcyRo2ZGZ5UUOxUyK/3qa5FeddGs=
Date:   Mon, 17 Aug 2020 17:15:00 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: y2038 backport to v5.4
Message-ID: <20200817151500.GA659819@kroah.com>
References: <d159c66c6e67480ab48ac44716443358@ginzinger.com>
 <CAK8P3a2icd72R+4Z5dLPvGuofsq3VOBYBdCnC4806V5znqrytg@mail.gmail.com>
 <6c77e2a615ca01e753735e21752fe5e1b3fb636f.camel@ginzinger.com>
 <20200817143513.GA539521@kroah.com>
 <372cbefff43c2a96379f00de5880bc9d54df6acd.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372cbefff43c2a96379f00de5880bc9d54df6acd.camel@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 03:00:24PM +0000, Roosen Henri wrote:
> On Mon, 2020-08-17 at 16:35 +0200, gregkh@linuxfoundation.org wrote:
> > On Mon, Aug 17, 2020 at 02:15:16PM +0000, Roosen Henri wrote:
> > > On Tue, 2020-06-09 at 16:18 +0200, Arnd Bergmann wrote:
> > > > On Tue, Jun 9, 2020 at 2:36 PM Roosen Henri <
> > > > Henri.Roosen@ginzinger.com> wrote:
> > > > > Hi Arnd,
> > > > > 
> > > > > I hope you are well and could answer me a quick question.
> > > > > 
> > > > > I've read on the kernel mailing-list that initially there was
> > > > > an
> > > > > intention to backport the final y2038 patches to v5.4. We're
> > > > > currently targeting to use the v5.4 LTS kernel for a project
> > > > > which
> > > > > should be y2038 compliant.
> > > > > 
> > > > > I couldn't find all of the y2038-endgame patches in the current
> > > > > v5.4-stable branch. Are there any patches still required to be
> > > > > backported in order for v5.4 to be y2038 compliant, or can the
> > > > > remaining patches be ignored (because of only cleanup?)? Else,
> > > > > is
> > > > > there still an intention to get the v5.4 LTS kernel y2038
> > > > > compliant?
> > > > 
> > > > I don't think there are currently any plans to merge my y2038-
> > > > endgame 
> > > > branch
> > > > into the official linux-5.4 lts kernel, but you should be able to
> > > > just pull from
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-endgame
> > > > 
> > > > and get the same results. If you see any problems with that,
> > > > please
> > > > report
> > > > that to me with Cc to the mailing list and perhaps gregkh, so I
> > > > can
> > > > see if
> > > > I can resolve it by rebasing my patches, or if he would like to
> > > > merge
> > > > the
> > > > patches.
> > > 
> > > Pulling the y2038-endgame branch does lead to some conflicts, which
> > > are
> > > currently still kinda staightforward to solve.
> > > 
> > > However I'd be very interested in getting this branch merged to
> > > v5.4,
> > > so we don't run into more difficult merge conflicts the coming
> > > years
> > > where the v5.4-LTS still gets stable updates (Dec, 2025) and
> > > possibly
> > > to get any related fixes from upstream.
> > > 
> > > @Greg: any chance to get the y2038-endgame merged into v5.4.y?
> > 
> > I have no idea what this really means, and what it entails, but odds
> > are, no :)
> 
> I fully understand, thanks for your statement on this.
> 
> > 
> > Why not just use a newer kernel?  Why are you stuck using a 5.4
> > kernel
> > for a device that has to live in 2038?  That feels very foolish to
> > me...
> 
> Oh I agree on that :) It's just that these are currently customer
> requirements.

Are you sure that customers really understand what they want?

Usually they want a well-supported, stable, system.  Why do they care
about a specific kernel version?  That feels odd.

Good luck!

greg k-h

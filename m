Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F3424654
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583342083;
	bh=xT1sEwZjPK8JKf0tY/gJOxvv0KwpERViNrL1nxk5oa8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=H4sfm1zhMVz8iafA2yCAN/mlAdzcDOx1+YeJ1hUbRVQkCq7acMlhF4TjPQdjeSEEX
	 ddxoNVLBZYZH4FcZRLQQgVtKP3aybsaXi5OCB4cXrsIh+jfr3RbJxu7RbKLGAOdIns
	 9OnBbdORDDXiFRgkHwvVgL60a5IaxvLVpmH35s44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgCDROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgCDROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:14:42 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8071E21775;
        Wed,  4 Mar 2020 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342081;
        bh=xT1sEwZjPK8JKf0tY/gJOxvv0KwpERViNrL1nxk5oa8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FYOjqES9z3Ri/3gvgS805sO+LvHMa/0HSUDyXXfGBNDIbra/4sXJk9BgAWRJM0ODX
         33Zt7g7aQzc1E7i92GGbB6qwtwHxtvxLO7pttvIQ+XSdQubPwmqShVE3ik6aaF+S0a
         x5EvHmnJzUEOoQ8IJLT//zw2Ju0OonsYN9FTb4qQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 495A03522731; Wed,  4 Mar 2020 09:14:41 -0800 (PST)
Date:   Wed, 4 Mar 2020 09:14:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200304171441.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
 <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72>
 <CANpmjNOotdBa_7EhA75f2Y59HfEVsGsquv1cvQ=OjtA784poRA@mail.gmail.com>
 <1583341858.7365.155.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583341858.7365.155.camel@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 12:10:58PM -0500, Qian Cai wrote:
> On Wed, 2020-03-04 at 17:40 +0100, Marco Elver wrote:
> > On Wed, 4 Mar 2020 at 15:10, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > On Tue, Mar 03, 2020 at 08:33:56PM -0800, Matthew Wilcox wrote:
> > > > On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > > > > > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > > > > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > > > > > could happen concurrently result in data races, but those operate only
> > > > > > > on a single bit that are pretty much harmless. For example,
> > 
> > I currently do not see those as justification to blacklist the whole
> > file. Wouldn't __no_kcsan be better? That is, in case there is no
> > other solution that emerges from the remainder of the discussion here.
> 
> I suppose it is up to Matthew. Currently, I can see there are several functions
> may need __no_kcsan,
> 
> xa_get_mark(), xas_find_marked(), xas_find_chunk() etc.
> 
> My worry was that there could be many of those functions operating on marks
> (which is a single-bit) in xarray that could end up needing the same treatment.
> 
> So far, my testing is thin on filesystem side where xarray is pretty much used
> for page caches, so the reports I got from KCSAN runs does not necessary tell
> the whole story. Once I updated my KCSAN runs to include things like xfstests,
> it could add quite a few churns later if we decided to go with the __no_kcsan
> route.

Agreed, the filesystems developers and maintainers will decide how they
would like to approach this.

							Thanx, Paul

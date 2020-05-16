Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4405C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 17:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CF920756
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589648579;
	bh=xZm7SPScu0iT7/Cap3mdxG8rP6DsmX787bsWocbqih4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YsVjXhMmD7ElLycOmp1JwlzZd2BkYUphDO69ado836oHNv7EUIdp7gJVp5LWHkG1c
	 bLqdoigQo6PgAW00yuzCnYtDRprfxjsWxFBZd2gGQtyv2awmQSVk8eQJjgOWBFvKFf
	 NeBb+AXoBCFk3Df0vAUue0l+5bsbISh7jFX7f07U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgEPRC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 13:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgEPRC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 13:02:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED27D2065C;
        Sat, 16 May 2020 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589648578;
        bh=xZm7SPScu0iT7/Cap3mdxG8rP6DsmX787bsWocbqih4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e0xPncZvFrWRMb/0Cqty50usN0twn62boJeud92ye32kBTeeir+IPtCdypvv+kC5x
         ZD7xIewwPKI4xjYl42ObQYazrNtbR5qh1BcNOLZbbJn68E4/eMR2Dcs+NI63kwSN3+
         p56Z78i+0SimwruO90LrEkAVa2o4eznWDQvWopN4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CB8EA3522CED; Sat, 16 May 2020 10:02:57 -0700 (PDT)
Date:   Sat, 16 May 2020 10:02:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's
 README into top-level one
Message-ID: <20200516170257.GA2639@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
 <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
 <20200514004618.GA94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200514171656.GR2869@paulmck-ThinkPad-P72>
 <0ded5099-fe59-914a-d0dd-999cc334ff0a@gmail.com>
 <20200514224558.GZ2869@paulmck-ThinkPad-P72>
 <ed5b16b9-b522-8f9b-847b-e18d6387017e@gmail.com>
 <20200515150530.GG2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515150530.GG2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:05:30AM -0700, Paul E. McKenney wrote:
> On Sat, May 16, 2020 at 12:01:41AM +0900, Akira Yokosawa wrote:
> > On Thu, 14 May 2020 15:45:58 -0700, Paul E. McKenney wrote:
> > > On Fri, May 15, 2020 at 07:03:33AM +0900, Akira Yokosawa wrote:
> > >> On Thu, 14 May 2020 10:16:56 -0700, Paul E. McKenney wrote:
> > >>> On Thu, May 14, 2020 at 08:46:18AM +0800, Boqun Feng wrote:
> > >>>> On Wed, May 13, 2020 at 06:39:03AM +0900, Akira Yokosawa wrote:
> > >>>>> From 96fa6680e3b990633ecbb6d11acf03a161b790bd Mon Sep 17 00:00:00 2001
> > >>>>> From: Akira Yokosawa <akiyks@gmail.com>
> > >>>>> Date: Sun, 10 May 2020 15:12:57 +0900
> > >>>>> Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README into top-level one
> > >>>>>
> > >>>>> Where Documentation/litmus-tests/README lists RCU litmus tests,
> > >>>>> Documentation/litmus-tests/atomic/README lists atomic litmus tests.
> > >>>>> For symmetry, merge the latter into former, with some context
> > >>>>> adjustment in the introduction.
> > >>>>>
> > >>>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > >>>>> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> > >>>>> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >>>>
> > >>>> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> > >>>>
> > >>>> Thanks!
> > >>>
> > >>> Applied, and thank you all!
> > >>>
> > >>> I rebased, cancelling the revert with the original, resulting in an
> > >>> updated lkmm branch on -rcu.  There was one minor conflict, so could
> > >>> one of you please check to make sure that I resolved things appropriately?
> > >>
> > >> One thing I noticed.
> > >>
> > >> Commit b2998782ded4 ("Documentation/litmus-tests: Clarify about the RCU
> > >> pre-initialization test")'s change log says:
> > >>
> > >>     Since this test returned to tools/memory-model/, make sure that it is
> > >>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >>     at least referenced from Documentation/litmus-tests/'s README.
> > >>
> > >> Because of the rebase, this needs amendment as well as the title.
> > >>
> > >> Something like
> > >>
> > >>     Documentation/litumus-tests: Cite a relevant litmus test in tools/memory-model
> > >>
> > >>     For ease of finding the RCU related litmus test under
> > >>     tools/memory-model/, add an entry in README.
> > >>
> > >> ?
> > > 
> > > Good catch, and yes, I will update that on the next rebase.
> > > 
> > > Any other things in need of adjustment?
> > 
> > Aside from the missing Signed-off-by tags Stephen pointed out, I don't
> > see anything.
> 
> Yeah, I did mess that up!  ;-)
> 
> Thank you for checking!!!

And I have fixed these during the merge with Thomas's and Peter's series
(or at least the noinstr-rcu-nmi-2020-05-15 portion of it), again,
thank you!

							Thanx, Paul

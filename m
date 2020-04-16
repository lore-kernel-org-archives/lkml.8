Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7531C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5AF20936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586996278;
	bh=8ZQpLIyNQ6xi0fOhO4mCXoEaA0yi2F4kZ5SGENO7/iM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=O96Leg8ukR77hdLyPquD6Q1ekwIdJy5fMbFMKPTk3qH3QYSHl1t2oBrUgWKjNosNQ
	 +RbtWvQGjeSMMC1+UMVtF6OJCSLLI25ao6zf3YQm/8Qcxy3betnB/89Cl2IgWXISM0
	 q4PVpEXQHciNE/3flzJdnIbGT5dDqt1RbwY5xtKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbgDPARz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgDPARm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:17:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0AF2078B;
        Thu, 16 Apr 2020 00:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586996261;
        bh=8ZQpLIyNQ6xi0fOhO4mCXoEaA0yi2F4kZ5SGENO7/iM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1mYg783pLKeIT3Vs6V1bsfRFNrd+8xsKVJCqJuRlJmFTDRf8WgJCBAfHH43lEBT6f
         UkELQtSEYyiuzrqLENpa5ofYeQ5RC07OgZXODRyY8LJyBU1cW7eXkInA4889tMYRQW
         ijwnM3iAb42KBmlrThDQ83H6gccJAXqI591uFW2o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 629C73522AD1; Wed, 15 Apr 2020 17:17:41 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:17:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
Message-ID: <20200416001741.GJ17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
 <20200415184945.16487-6-paulmck@kernel.org>
 <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:39:59PM -0700, Joe Perches wrote:
> On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> > Also add me as Reviewer for LKMM. Previously a patch to do this was
> > Acked but somewhere along the line got lost. Add myself in this patch.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  R:	Akira Yokosawa <akiyks@gmail.com>
> >  R:	Daniel Lustig <dlustig@nvidia.com>
> > +R:	Joel Fernandes <joel@joelfernandes.org>
> >  L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> > @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst
> >  F:	Documentation/memory-barriers.txt
> >  F:	tools/memory-model/
> > +F:	Documentation/litmus-tests/
> 
> trivia:
> 
> Alphabetic ordering of F: entries please.
> This should be between core-api and memory-barriers.
> 
> >  LIS3LV02D ACCELEROMETER DRIVER
> >  M:	Eric Piel <eric.piel@tremplin-utc.net>

New one on me, but it does make a lot of sense, especially for cases
with lots of scattered paths.  How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit e3b73adbd732e13e7e9f42c9adc95e7b9439426c
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sun Mar 22 21:57:35 2020 -0400

    MAINTAINERS: Update maintainers for new Documentation/litmus-tests
    
    This commit adds Joel Fernandes as official LKMM reviewer.
    
    Acked-by: Boqun Feng <boqun.feng@gmail.com>
    Acked-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    [ paulmck: Apply Joe Perches alphabetization feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db..15eb800 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
+R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 S:	Supported
@@ -9814,6 +9815,7 @@ F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
 F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
+F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
 

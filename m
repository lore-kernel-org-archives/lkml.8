Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331ABC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3D720722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584984942;
	bh=uXXSKJp5CwTUb4df1FREu+0M5RzU6HwfYVJmnZw0DIU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ngm+nQtyrf74ZxawWPGlKNGmXKW2NLgiYjR5A13NsXVrdj7CyydCU02vTfOdq04KL
	 cMhUCefegtNsd0SK9jeYAq4vfhSC9Uuh5LurBUv3vwpikSlknujf+DaLJb7ZrmuQb2
	 FXRtjzi6uU4YzLBrkYzKAcoKb9Vl2wCuPwxhsAAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCWRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbgCWRfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:35:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B0E20714;
        Mon, 23 Mar 2020 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584984940;
        bh=uXXSKJp5CwTUb4df1FREu+0M5RzU6HwfYVJmnZw0DIU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sO01DjzU9Eb8qtPLXChTjAmDfH1RQc5fdWa52EFiIxAObWsqwB+tnJ1ObF6b96hzo
         duhL9qIMwQWI4FjxBRRaLsZtvFn9YMTjUyyXXHP0WW9+UVDAJ55pGGMvzHYmqH3uE9
         aRv2VBwguNTNyq+opsCGW2e3qYrA5ruS3RFdZvlI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BB03735226E4; Mon, 23 Mar 2020 10:35:39 -0700 (PDT)
Date:   Mon, 23 Mar 2020 10:35:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Update maintainers for new
 Documentaion/litmus-tests/
Message-ID: <20200323173539.GM3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <20200323015735.236279-4-joel@joelfernandes.org>
 <20200323085943.GA10674@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323085943.GA10674@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 09:59:43AM +0100, Andrea Parri wrote:
> On Sun, Mar 22, 2020 at 09:57:35PM -0400, Joel Fernandes (Google) wrote:
> > Also add me as Reviewer for LKMM. Previously a patch to do this was
> > Acked but somewhere along the line got lost. Add myself in this patch.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> For the entire series:
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Queued and pushed with your ack and Boqun's on this patch, thank you all!

							Thanx, Paul

> Thanks,
>   Andrea
> 
> 
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cc1d18cb5d186..fc38b181fdff9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9699,6 +9699,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  R:	Akira Yokosawa <akiyks@gmail.com>
> >  R:	Daniel Lustig <dlustig@nvidia.com>
> > +R:	Joel Fernandes <joel@joelfernandes.org>
> >  L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> > @@ -9709,6 +9710,7 @@ F:	Documentation/atomic_t.txt
> >  F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst
> >  F:	Documentation/memory-barriers.txt
> > +F:	Documentation/litmus-tests/
> >  
> >  LIS3LV02D ACCELEROMETER DRIVER
> >  M:	Eric Piel <eric.piel@tremplin-utc.net>
> > -- 
> > 2.25.1.696.g5e7596f4ac-goog
> > 

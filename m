Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3538BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EBC21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596234622;
	bh=A2Jhu+La0kQMmpq+iGxTm4iOgqXSXSakDKJqIBAkyO4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fm88/NnnBs4DGDwEOM3ya5GfPBx8aB2yoKHTDGH+L87fcbNYwOXtfRrf7hljDz3wo
	 /2G/4UpSPhYV3lqmW4CnMYpLiffFOJHRaUlcERGvak298j6Q+0xinMMgvchdeNe/Zy
	 KtvNnjiSTdhgl2ZBKUkFuufjDdAHLs2R8UediyDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGaWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgGaWaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2021921744;
        Fri, 31 Jul 2020 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596234617;
        bh=A2Jhu+La0kQMmpq+iGxTm4iOgqXSXSakDKJqIBAkyO4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1xnpjR8iFCz9z0h9wQsHGuoMDXr/Fjx2AKcZkrM+KPaFWB1eZ/Bqek9YNv0pmCa4k
         FeW4i0Rv2Oq+9713pfqxikKnQINsQbp18lufhO0+r8gAMIVwg/DjHneSsWlTCwJKTd
         HhC33Ml11cR6wvtb/VecAlhLSjT4kCJWax6zgg6s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E9F2435231D2; Fri, 31 Jul 2020 15:30:16 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:30:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, urezki@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-ID: <20200731223016.GT9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
 <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
 <20200731204855.GR9247@paulmck-ThinkPad-P72>
 <20200731205933.GT23808@casper.infradead.org>
 <20200731212457.GS9247@paulmck-ThinkPad-P72>
 <20200731142919.36c4c741189426db0f8b8514@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731142919.36c4c741189426db0f8b8514@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 02:29:19PM -0700, Andrew Morton wrote:
> On Fri, 31 Jul 2020 14:24:57 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > The reason for this restriction is that in -rt, the spin_lock(&zone->lock)
> > in rmqueue_bulk() can sleep.
> 
> So if there is runtime overhead, this overhead could be restricted to
> -rt kernels with suitable ifdefs?

In theory, yes.  In practice, with CONFIG_PROVE_RAW_LOCK_NESTING=y,
lockdep will complain regardless of -rt or not.

							Thanx, Paul

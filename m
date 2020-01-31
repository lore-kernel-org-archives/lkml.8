Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3BC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580505831;
	bh=peMZG9b/uAJt7ENpe0W72OxrDImy5aYQHXPH/fnHJcA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PrYymTQZa8Hl3njvhx0/cAjw1WtZyizBxNsIlRukRLKbcJelS6V8gx0vVdUQm7+SY
	 XtZw8oPVE4f44x7+mwKVlr9ZtOh3bvMT6exn6g4Z7UyWn1xyFlGCJO0QcX8/Jv5JR4
	 4kLudV/LFUkKO9YQAkLklHT5u4slh7WsEibYoAqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAaVXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaVXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:23:50 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8394620CC7;
        Fri, 31 Jan 2020 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580505829;
        bh=peMZG9b/uAJt7ENpe0W72OxrDImy5aYQHXPH/fnHJcA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uLCVbDFEPr2BhFrB0j0GvYxs+XRnHKIVnVVhILHbxCwW94vIy4y66DEFp93Q9QSXp
         BXpogD/IKACDUwALIh3KOoOVYJE8Z/YTpwa8mC9R1R3i4n6R7I34HZaQtBE5Ah1pvN
         kOIkgppRQDh4ql5mQIb3bqIX3QgE0CbGfpWOe6cE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2F1EF3522722; Fri, 31 Jan 2020 13:23:49 -0800 (PST)
Date:   Fri, 31 Jan 2020 13:23:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, SeongJae Park <sjpark@amazon.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Documentation/memory-barriers: Fix typos
Message-ID: <20200131212349.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131205237.29535-1-sj38.park@gmail.com>
 <20200131205237.29535-6-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131205237.29535-6-sj38.park@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:52:37PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Good catches, queued, thank you!

But if Jon would rather take this:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> ---
>  Documentation/memory-barriers.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index ec3b5865c1be..01ab5e22b670 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -185,7 +185,7 @@ As a further example, consider this sequence of events:
>  	===============	===============
>  	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
>  	B = 4;		Q = P;
> -	P = &B		D = *Q;
> +	P = &B;		D = *Q;
>  
>  There is an obvious data dependency here, as the value loaded into D depends on
>  the address retrieved from P by CPU 2.  At the end of the sequence, any of the
> @@ -569,7 +569,7 @@ following sequence of events:
>  	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
>  	B = 4;
>  	<write barrier>
> -	WRITE_ONCE(P, &B)
> +	WRITE_ONCE(P, &B);
>  			      Q = READ_ONCE(P);
>  			      D = *Q;
>  
> @@ -1721,7 +1721,7 @@ of optimizations:
>       and WRITE_ONCE() are more selective:  With READ_ONCE() and
>       WRITE_ONCE(), the compiler need only forget the contents of the
>       indicated memory locations, while with barrier() the compiler must
> -     discard the value of all memory locations that it has currented
> +     discard the value of all memory locations that it has currently
>       cached in any machine registers.  Of course, the compiler must also
>       respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
>       though the CPU of course need not do so.
> @@ -1833,7 +1833,7 @@ Aside: In the case of data dependencies, the compiler would be expected
>  to issue the loads in the correct order (eg. `a[b]` would have to load
>  the value of b before loading a[b]), however there is no guarantee in
>  the C specification that the compiler may not speculate the value of b
> -(eg. is equal to 1) and load a before b (eg. tmp = a[1]; if (b != 1)
> +(eg. is equal to 1) and load a[b] before b (eg. tmp = a[1]; if (b != 1)
>  tmp = a[b]; ).  There is also the problem of a compiler reloading b after
>  having loaded a[b], thus having a newer copy of b than a[b].  A consensus
>  has not yet been reached about these problems, however the READ_ONCE()
> -- 
> 2.17.1
> 

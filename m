Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25364C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A3D206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586156505;
	bh=/miZDcwo/LKOwYst2qseuCoD+V/d3a4WWbj5j23oSeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wPFY6bU0VfBwaV756moSW9Q2bSGXIf7hB+mZ5g7ppTe/OQqc0BgkrRCdd2Lb/frDj
	 7N2z1XTiLONU4tFYPDVYsLZEBIuSwjk9y9vK5tR8G7/G0u20mSv3AjG263VDqe5sTm
	 31nuY7v60pTp/XzWRDvDmJiz4JfbbxgX0imaRgWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDFHBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:01:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:01:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so16027704wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 00:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69TN40+/3rdC5VHL4PnojXQb7Y3XtFrcgwQ12Kvr8T0=;
        b=l+NmnwvrdxWKvP83nYz1LAqOo2JCm2OWJ6eWvXaNrkzrMBnKdQgBjpNW+5TTxfdGfG
         4sDIDhatKWGFrITyOaQcyEalzpbIMi1W0bQ4cvIfgD8aeNBqIF33RMbh0tlCRt30WhXT
         gBVbONvRZq9KsqMzPdrbq9IbvWq+n6CUvNKZysGkVJmN2W5+AP5TganVjNA/bMDjJZkG
         ZqjEBQmjNUoYzWeX0Fn9akeogg8SGnJ3Bedjzp9957cPPpWdHZ/M5Z1vM2jv4AJ8gFqk
         frz2KgoAN2u6l8lBCk8mdz31b/K5oe6gMZtUMiY61PVnJdW/Y7wHVxCW/RVG6smnoYZo
         WaJA==
X-Gm-Message-State: AGi0PuaQK6Tg6sdeMEg13n8MYYdgnR0jeCTsgq1fUWXbg3XH0RpLvaXj
        /Cse/ysBUnA00rkH/d0w+JL1g9fJ
X-Google-Smtp-Source: APiQypL3/RnoyZOsqU3zvwU+/VtmGNcdoAvzDeAPyNEcLkX2yMKzP2qPTiiB9qFEact5c8k3WtQQxg==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr23374656wrl.296.1586156500828;
        Mon, 06 Apr 2020 00:01:40 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id q14sm23411956wrx.57.2020.04.06.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 00:01:39 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:01:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
Message-ID: <20200406070137.GC19426@dhcp22.suse.cz>
References: <20200403083543.11552-1-mhocko@kernel.org>
 <20200403083543.11552-2-mhocko@kernel.org>
 <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
 <87blo8xnz2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blo8xnz2.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-04-20 08:23:45, Neil Brown wrote:
> On Fri, Apr 03 2020, David Rientjes wrote:
[...]
> > Hmm, any guidance that we can offer to users of this flag that aren't 
> > aware of __GFP_MEMALLOC internals?  If I were to read this and not be 
> > aware of the implementation, I would ask "how do I know when I'm at risk 
> > of depleting this reserve" especially since the amount of reserve is 
> > controlled by sysctl.  How do I know when I'm risking a depletion of this 
> > shared reserve?
> 
> "how do I know when I'm at risk of depleting this reserve" is definitely
> the wrong question to be asking.  The questions to ask are:
> - how little memory to I need to ensure forward progress?
> - how quick will that forward progress be?

Absolutely agreed. The total amount of reserves will always depend on
all other users. Unless they are perfectly coordinated, which is not the
case.

> In the ideal case a small allocation will be all that is needed in order
> for that allocation plus another page to be freed "quickly", in time
> governed only by throughput to some device.  In that case you probably
> don't need to worry about rate limiting.

Right but I wouldn't expect this to be a general usage pattern of this
flag. "Allocate to free memory" suggests this would be a part of the
memory reclaim process and that really needs some form of rate
limiting. Be it the reclaim itself directly or some other mechanism if
this happens from a different context.

> The reason I brought up ratelimiting is that RCU is slow.  You can get
> quite a lot of memory caught up in the kfree-rcu lists.  That's not much
> of a problem for normal memory, but it might be for the more limited
> reserves.

Right.

> The other difficulty with the the kfree_rcu case is that we have no idea
> how many users there will be, so we cannot realistically model how long
> the queue might get.  Compare with NFS swap-out there the only user it
> the VM swapping memory which (I think?) already tries to pace writeout
> with the speed of the device (or is that just writeback...).  I'm
> clearly not sure of the details but it is a more constrained environment
> so it is more predicatable.

Mel explained this http://lkml.kernel.org/r/20200401131426.GN3772@suse.de

> In many cases, preallocating a private reserve is better than using
> GFP_MEMALLOC.  That is what mempools provide and they are very effective
> (though often way over-allocated*).
> GFP_MEMALLOC was added because swap-over-NFS requires lots of different
> allocations (transmit headers, receive buffers, possible routing changes
> etc), many of them in the network layer which is very sensitive
> to latency (and mempools require a spinlock to get the reserves).

Yes.

> Maybe the documentation should say.
>  Don't use this - use a mempool.  Here be dragons.

OK, this looks like a good idea.
 
> I'm not sure you can really say anything more useful without writing a
> long essay.

Yes and I am not sure it would be really more helpful than confusing.
What do you think about this updated patch?

From 6c90b0a19a07c87d24ad576e69b33c6e19c2f9a2 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 1 Apr 2020 14:00:56 +0200
Subject: [PATCH] mm: clarify __GFP_MEMALLOC usage

It seems that the existing documentation is not explicit about the
expected usage and potential risks enough. While it is calls out
that users have to free memory when using this flag it is not really
apparent that users have to careful to not deplete memory reserves
and that they should implement some sort of throttling wrt. freeing
process.

This is partly based on Neil's explanation [1].

Let's also call out that a pre allocated pool allocator should be
considered.

[1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..9cacef1a3ee0 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -110,6 +110,11 @@ struct vm_area_struct;
  * the caller guarantees the allocation will allow more memory to be freed
  * very shortly e.g. process exiting or swapping. Users either should
  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the consumption
+ * of the reserve based on the amount of freed memory.
+ * Usage of a pre-allocated pool (e.g. mempool) should be always considered before
+ * using this flag.
  *
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
-- 
2.25.1

-- 
Michal Hocko
SUSE Labs

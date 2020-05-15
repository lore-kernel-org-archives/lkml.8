Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81DCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8066020758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P86XXdpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEONE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEONE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:04:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0551C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T0TocZQ3NetM/G0O6+afnXX9jSSzKnmUGcd3kXVJgN0=; b=P86XXdpLZ2qUa/pn05/UYTG1m/
        uQfte15iA4jExIteuPSAiO6vBQFE7NSTRaVZ4qyFavO/g5hnr9Tj4RUL4bSyJ0yYyauSUGPaeeg3R
        BHpSwqmSmNLkQ53RW8+SCOflzINYM7nIlFmPch2WRMv51XZ5q5JqB9CexpYWFNmrz0+XcRDsgpCzE
        K0kUXUG9/ubCVIQF8SwpGgkwHvAm7ftn5iwxOlXnJMosInOh9+Y3v+BH6v1eB3spAW/nYs1vyIoK/
        7q5Y+TW0epkD7KqZpiPwV+rBzJr55CveuxmNvcSBKReAfVKZ1enW+Q3CCGnz1Baw0izr4IYVhtIUT
        7PV9y0eA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZa14-0002VA-KW; Fri, 15 May 2020 13:04:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5076B301A66;
        Fri, 15 May 2020 15:04:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A89C02024968B; Fri, 15 May 2020 15:04:39 +0200 (CEST)
Date:   Fri, 15 May 2020 15:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] rbtree_latch: don't need to check seq when it found
 a node
Message-ID: <20200515130439.GW2957@hirez.programming.kicks-ass.net>
References: <20200515124710.16439-1-laijs@linux.alibaba.com>
 <20200515124710.16439-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515124710.16439-2-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:47:07PM +0000, Lai Jiangshan wrote:
> latch_tree_find() should be protected by caller via RCU or so.
> When it find a node in an attempt, the node must be a valid one.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: David Woodhouse <David.Woodhouse@intel.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  include/linux/rbtree_latch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
> index b012bd95eabf..09a3c05d1c5b 100644
> --- a/include/linux/rbtree_latch.h
> +++ b/include/linux/rbtree_latch.h
> @@ -208,7 +208,7 @@ latch_tree_find(void *key, struct latch_tree_root *root,
>  	do {
>  		seq = raw_read_seqcount_latch(&root->seq);
>  		node = __lt_find(key, root, seq & 1, ops->comp);
> -	} while (read_seqcount_retry(&root->seq, seq));
> +	} while (!node && read_seqcount_retry(&root->seq, seq));

So in the case where we search for key=N and race with { erase(N);
insert(N) }, we can now return the old N, as opposed to the new N.

But given that is entirely subject to timing anyway, that is irrelevant.
We change the boundary case in the timing.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

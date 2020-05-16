Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3235C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 04:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93F0206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 04:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mq7hZ7t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPE1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 00:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPE1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 00:27:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27706C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:27:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so1762166plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPkPOYZysew96j08Wnlp5zLqgqkBLLZVAOPiwHUVlcU=;
        b=Mq7hZ7t0c4Mp5Zsz60GwWUOIj2CQRi9FIHgIM7oaIylr4JiEgVCON6Vio7F0LDGCMR
         EjkBgq7Bn1+ixfF68MflbDXNcZ5QcERKQjPj6nzVx66oKunFwogsQdcQmQtAqjXdnGDH
         uSZIgtZlKxxaXXZ8A+kMoPe3OMc+ui9P1tKjZhlMMoxLGfs3fdp+cZ3DJHGbA6HlPI9h
         Wy1dQPqiWU3zOiombSq5kUvUMtzTnNWI3XPouyFR+Wl9I+XJ2tvRr/ymNuhDwj5h0Zkk
         uprtVMK8MvNTYqOzbdrtfvy8xN6cm3kPAEDFUk2jMq0zqJ259mcwv67p5pBpMIYcdKtL
         9ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPkPOYZysew96j08Wnlp5zLqgqkBLLZVAOPiwHUVlcU=;
        b=W8gwQXUz/TdWWPrIhiqVkvI9/Vd20e3H5VI4t6RU4vpts3eehXhXZ6GDjjLije8JR3
         0acdB5oF21e5xebRI7h6JlhlPFlAecNOc8rnzKp8G2x/q+V+6HVRUQafZvYQHGq4dPVO
         C1c08+XhoyHNCJFqwWdx71VWdz2dJNUb80ywSzcZYnBAiqy/8+SvnNi/39jvreqYQZIQ
         wc2scgfeM2hqqYX81n12dQjrJch1qdTy4RNrOEFFALCUyt9EapYFNUiVsta9CkucWwr+
         yQopfOp+69ZtGuaAEsP9a3LdUlJre2JlDF7IOgKvpg4dy3k9986PuGdFexii09iFxOUn
         cBRA==
X-Gm-Message-State: AOAM532ppZzow0YqDbcTUrlYwQJolJe5yvcjtb2EKIv+pNnRjiuy8UaJ
        XEna0g9xfPpWWfQMn6noaiPIHg==
X-Google-Smtp-Source: ABdhPJx83N5ilwFzhmwX2USC+EChRORAFmxYt53NMlow85JNFoFTVDq0ZokayI7+FeCWgaFlR7ejsA==
X-Received: by 2002:a17:90a:4149:: with SMTP id m9mr6748252pjg.200.1589603231320;
        Fri, 15 May 2020 21:27:11 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id ay15sm2702004pjb.18.2020.05.15.21.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 21:27:07 -0700 (PDT)
Date:   Fri, 15 May 2020 21:27:05 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 2/2] rbtree_latch: don't need to check seq when it
 found a node
Message-ID: <20200516042705.GA82414@google.com>
References: <20200515150122.GY2957@hirez.programming.kicks-ass.net>
 <20200515155912.1713-1-laijs@linux.alibaba.com>
 <20200515155912.1713-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515155912.1713-2-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:59:09PM +0000, Lai Jiangshan wrote:
> latch_tree_find() should be protected by caller via RCU or so.
> When it find a node in an attempt, the node must be a valid one
> in RCU's point's of view even the tree is (being) updated with a
> new node with the same key which is entirely subject to timing
> anyway.

I'm not sure I buy this. Even if we get a valid node, is it the one we
were searching for ? I don't see how this could be guaranteed if the
read raced with a tree rebalancing.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.

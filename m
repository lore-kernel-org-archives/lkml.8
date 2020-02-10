Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08873C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40C020863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581365236;
	bh=w8vBFIvguIV+MWYpm0YIyUKRWCzgYp/O1vSDiAjrv3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W3w+EHhGn8pUrKHHiCQ5MT3uMUgZDfVjUBMM9X5XelPxkhROUW6n0IT4N4e6vjPvG
	 SKpV6ALUTXrErPxsrFAWoGwuNeF75D/jfKUTkIk3pTWmaziAg5pDxsl4rQyHBUx2CR
	 CkumRNKdxEIZ17Btypy5XSP03U4mQeumh+6/XiUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBJUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:07:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33976 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:07:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so3266335plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+cqML+P3N7yJQnV2zTRY/y5Nvd3dQGJHvto5Od+38s=;
        b=nYw08oxZjmO4zn2+ikSa97mAagYwtfHTdBAbDM1y5lu4lPlcoKnlxF9No6DTfojLf9
         tVgOHn68zq4suzeUF0j6D+fLYiICM/TGXaxFBQZWSZlAi4CQ6iimTStugdqn+gUkeDI+
         DC7kQnav5A4bDkIRnszARnTfVqKxZOVAegwDGi7Ncc60q5cM8haAFpv4xCvJYo4v5Ntt
         MNMbRVRZIauqayUV67J9JyfkRrye5fDdMUFFeslwHEly4BaEcIVK8bT1JeQW7LTs1gBY
         MRfkZnuJDami5XArICdA3xAxB7hk7Cs/pXOrn8c8i32785FB5xcCVNDQtpnP2R4eKL37
         V23g==
X-Gm-Message-State: APjAAAUSuzkzgEzkJWISoJ2KfEFVpFX4v9hXzhzd9GGrBVoXKPtCiS3T
        498yrZXHTjz3QyLVn1yHbfg=
X-Google-Smtp-Source: APXvYqw80gUZm7XUYw4jfRzU1zd2+e8EVkBxhkc2TFoihi5Pwoyd3x8ijQeDQUs3jagnbQGcGQsm1w==
X-Received: by 2002:a17:902:864c:: with SMTP id y12mr14321858plt.8.1581365234327;
        Mon, 10 Feb 2020 12:07:14 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m12sm244067pjf.25.2020.02.10.12.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 12:07:13 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4EE8E4060F; Mon, 10 Feb 2020 20:07:12 +0000 (UTC)
Date:   Mon, 10 Feb 2020 20:07:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/5] lib/rbtree: introduce linked-list rbtree interface
Message-ID: <20200210200712.GM11244@42.do-not-panic.com>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200207180305.11092-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207180305.11092-2-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:03:01AM -0800, Davidlohr Bueso wrote:
> When doing in-order tree traversals, the rb_next() and rb_prev() helpers can
> be sub-optimal as plain node representations incur in extra pointer chasing
> up the tree to compute the corresponding node. This can impact negatively
> in performance when traversals are a common thing. This, for example, is what
> we do in our vm already to efficiently manage VMAs.
> 
> This interface provides branchless O(1)

I think including the word "branchless" does injustice to the
optimization, just O(1) sells it to me more to how I read the code.
Why is the "branchless" prefix needed here?

> access to the first node as well as
> both its in-order successor and predecessor. This is done at the cost of higher
> memory footprint: mainly additional prev and next pointers for each node. Such
> benefits can be seen in this table showing the amount of cycles it takes to
> do a full tree traversal:
> 
>    +--------+--------------+-----------+
>    | #nodes | plain rbtree | ll-rbtree |
>    +--------+--------------+-----------+
>    |     10 |          138 |        24 |
>    |    100 |        7,200 |       425 |
>    |   1000 |       17,000 |     8,000 |
>    |  10000 |      501,090 |   222,500 |
>    +--------+--------------+-----------+

Sold, however I wonder if we can have *one new API* where based on just one
Kconfig you either get the two pointers or not, the performance gain
then would only be observed if this new kconfig entry is enabled. The
benefit of this is that we don't shove the performance benefit down
all user's throughts but rather this can be decided by distributions
and system integrators.

> diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
> index 523d54b60087..fe38fb257931 100644
> --- a/Documentation/rbtree.txt
> +++ b/Documentation/rbtree.txt
> @@ -5,6 +5,7 @@ Red-black Trees (rbtree) in Linux
>  
>  :Date: January 18, 2007
>  :Author: Rob Landley <rob@landley.net>
> +         Davidlohr Bueso <dave@stgolabs.net>
>  
>  What are red-black trees, and what are they for?
>  ------------------------------------------------
> @@ -226,6 +227,79 @@ trees::
>  				 struct rb_augment_callbacks *);
>  
>  
> +Linked-list rbtrees
> +-------------------
> +
> +When doing in-order tree traversals, the rb_next() and rb_prev() helpers can
> +be sub-optimal as plain node representations incur in extra pointer chasing
> +up the tree to compute the corresponding node. This can have a negative impact
> +in latencies in scenarios where tree traversals are not rare. This interface
> +provides branchless O(1) access to the first node as well as both its in-order
> +successor and predecessor. This is done at the cost of higher memory footprint:
> +mainly additional prev and next pointers for each node, essentially duplicating
> +the tree data structure. While there are other node representations that optimize
> +getting such pointers without bloating the nodes as much, such as keeping a
> +parent pointer or threaded trees where the nil prev/next pointers are recycled;
> +both incurring in higher runtime penalization for common modification operations
> +as well as any rotations.
> +
> +As with regular rb_root structure, linked-list rbtrees are initialized to be
> +empty via::
> +
> +  struct llrb_root mytree = LLRB_ROOT;
> +
> +Insertion and deletion are defined by:
> +
> +  void llrb_insert(struct llrb_root *, struct llrb_node *, struct llrb_node *);
> +  void llrb_erase(struct llrb_node *, struct llrb_root *);
> +
> +The corresponding helpers needed to iterate through a tree are the following,
> +equivalent to an optimized version of the regular rbtree version:
> +
> +  struct llrb_node *llrb_first(struct llrb_root *tree);
> +  struct llrb_node *llrb_next(struct rb_node *node);
> +  struct llrb_node *llrb_prev(struct rb_node *node);
> +
> +
> +Inserting data into a Linked-list rbtree
> +----------------------------------------
> +
> +Because llrb trees can exist anywhere regular rbtrees, the steps are similar.
> +The search for insertion differs from the regular search in two ways. First
> +the caller must keep track of the previous node,

can you explain here why, even though its clear in the code: its because
we need to pass it as a parameter when the new node is inserted into the
rb tree.

Also, what about a selftest for this?

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>   

  Luis

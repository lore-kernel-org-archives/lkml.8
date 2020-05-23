Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FD620738
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKniocDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgEWA4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 20:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWA4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 20:56:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 17:56:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d7so13489835ioq.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9S0RiXcysyDyrw/uU0SAl4xNOzcawDBDDP1VxqQedw=;
        b=aKniocDAxguBjAudWw6WHjVYyXiEqtsc4vvsGV7Y4HsFZdP2KWMg8RTqbciA27dNrW
         cer4AEa4ovPuT6MsnnObsZePb7dalizrFqV+SoXiUSMk61fwyjfy/bR4GLBabyRnpDs2
         Yeb3hu1kVo6HIQvo+977Le7crew69Oj5Z3Lo0sXtLex5p6OjcPDvc55v2ssJPbLcFIt9
         ljBMv0qbnGUC5gvBX/rcO/EB9+vYunOYvcDDxWK8f+HE6ef3lQeEXgue07oqG7Rk7r+/
         S1v+Yj/282LynJ+mS9s9O1WUi9/Qn9X16Ob+ktGUvJMqQ/NqYOb5aGhcNTEIutc3Tij0
         xiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9S0RiXcysyDyrw/uU0SAl4xNOzcawDBDDP1VxqQedw=;
        b=ADQFYlXhHGqdEDWFDrCuR6PXpRZTNNoUXNJud8d1zG0nR0qHjl/iYpsxfihc+Jb0IQ
         UdLJKGjMffIXSCFGEw9BEc5R/VLkRudL5o1FKk6kBLbuMZuP7ZQ7GLZdGnoA9UtrYVPt
         5sl5IsKQrC3x1YK5hFhuhhSLgzUTqHos2boTxZgkIBO0UBRKiPXZd8D71Ks5BKGFDyWP
         Z43jelDGxJjYRRXFTFdeO8V54HRLuhoGpO287tHsZerv15wMiI/DBY4D7liUBJt+IoUV
         5Pt5ZQV003R3yxXaCVb7BpISFsOJcr/j9wc4YaeHn9RYhKmh/Qi7nt9z62oLjQGz9cfO
         51dg==
X-Gm-Message-State: AOAM531dT13v+TQWlbHim9jqDVNI9IsmfR2uapM4DANfhYUHBilfU57B
        lWIvgI6JQj/Vc/XlbP1ClBopsP+Fy/x1IMxHk2Y=
X-Google-Smtp-Source: ABdhPJxNkIjmq2MVzXsPkxGeuply98zzmVt4nDdyWWYCJNyNYyIimBABD4ua/+DK5lgWIJ9gZgtNgMKduR3qpxSEJgI=
X-Received: by 2002:a02:a58b:: with SMTP id b11mr10403758jam.56.1590195392607;
 Fri, 22 May 2020 17:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200515150122.GY2957@hirez.programming.kicks-ass.net> <20200515155912.1713-1-laijs@linux.alibaba.com>
In-Reply-To: <20200515155912.1713-1-laijs@linux.alibaba.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 23 May 2020 08:56:21 +0800
Message-ID: <CAJhGHyDp4LYcd8xzL761UYAhj6AY=R4Uik6b4tVN1sqyw95Dsg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] rbtree_latch: quit searching when reaching to
 maximum depth
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 12:01 AM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
>
> lib/rbtree.c has ensured that there is not possible to
> inadvertently cause (temporary) loops in the tree structure
> as seen in program order of the modifier. But loop is still
> possible to be seen in searcher due to CPU's reordering.
>
> for example:
> modifier                                searcher
>
> left rotate at parent
> parent->rb_right is node
>                                         search to parent
>                                         parent->rb_right is node
>                                      +->see node->rb_left changed
> WRITE_ONCE(parent->rb_right, tmp);-+ |  node->rb_left is parennt
> no smp_wmb(), some ARCHs can       | |
> reorder these two writes           | |  loop long between
> WRITE_ONCE(node->rb_left, parent);-+-+  parent and node
>                                    |
>                                    +--->finally see
>                                         parent->rb_right
>
> The long loop won't stop until the modifer's CPU flushes
> its writes. Too avoid it, we should limit the searching depth.
> There are no more than (1<<BITS_PER_LONG)-1 nodes in the tree.
> And the max_depth of a tree is no more than 2*lg(node_count+1),
> which is no mare than 2*BITS_PER_LONG.
>
> So the searching should stop when diving down up to
> 2*BITS_PER_LONG depth.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---

Hello

Could anyone have a review or an ack on the updated patch?
Compared v1:
  Applied Mathieu's suggest to change the changelog
  Avoid the depth check on x86, so the patch makes no functionality
    change on x86

And which tree should the patches route to? It is memory ordering
related.

Thanks
Lai

>  include/linux/rbtree_latch.h | 39 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
> index 7d012faa509a..638942f53c0a 100644
> --- a/include/linux/rbtree_latch.h
> +++ b/include/linux/rbtree_latch.h
> @@ -102,11 +102,47 @@ __lt_erase(struct latch_tree_node *ltn, struct latch_tree_root *ltr, int idx)
>         rb_erase(&ltn->node[idx], &ltr->tree[idx]);
>  }
>
> +/*
> + * Beware when rbtree is being searched in RCU read sites.
> + *
> + * lib/rbtree.c has ensured that there is not possible to
> + * inadvertently cause (temporary) loops in the tree structure
> + * as seen in program order of the modifier. But loop is still
> + * possible to be seen in searcher due to CPU's reordering.
> + *
> + * for example:
> + * modifier                               searcher
> + *
> + * left rotate at parent                  search to parent
> + * parent->rb_right is node               parent->rb_right is node
> + *                                     +->see node->rb_left changed
> + * WRITE_ONCE(parent->rb_right, tmp);-+ |  node->rb_left is parennt
> + * no smp_wmb(), some ARCHs can       | |
> + * reorder these two writes           | |  loop long between
> + * WRITE_ONCE(node->rb_left, parent);-+-+  parent and node
> + *                                   |
> + *                                   +--->finally see
> + *                                        parent->rb_right
> + *
> + * The long loop won't stop until the searcher finally see the changes
> + * from the modifier. Too avoid it, we should limit the searching depth.
> + *
> + * Limited by the address space of the kernel, there are no more than
> + * (1<<BITS_PER_LONG)-1 nodes in the tree. And the max_depth of a tree is
> + * no more than 2*lg(node_count+1), which is no mare than 2*BITS_PER_LONG.
> + *
> + * So the searching should stop when diving down up to
> + * 2*BITS_PER_LONG depth.
> + *
> + * Note: the above problem is not subject to the TSO memory model, such as
> + * x86, which can dispense with the depth check.
> + */
>  static __always_inline struct latch_tree_node *
>  __lt_find(void *key, struct latch_tree_root *ltr, int idx,
>           int (*comp)(void *key, struct latch_tree_node *node))
>  {
>         struct rb_node *node = rcu_dereference_raw(ltr->tree[idx].rb_node);
> +       int depth = 2 * BITS_PER_LONG;
>         struct latch_tree_node *ltn;
>         int c;
>
> @@ -120,6 +156,9 @@ __lt_find(void *key, struct latch_tree_root *ltr, int idx,
>                         node = rcu_dereference_raw(node->rb_right);
>                 else
>                         return ltn;
> +
> +               if (!IS_ENABLED(CONFIG_X86) && (--depth < 0))
> +                       break;
>         }
>
>         return NULL;
> --
> 2.20.1
>

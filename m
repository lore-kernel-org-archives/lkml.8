Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53899C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E00520770
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vh5N3/eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCQNky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:40:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgCQNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hX6CKNL7CusklL+Fw9f8ryCwL5vN/tcTcBjv1KpGoiM=; b=Vh5N3/eAh8zUCgdk+FrfPGZCP4
        hQo41olnbI89BYyHvcJ5V78oRyh34GVfTEVVdEzdk/xBI7gtmZjqebmFMZ4PdIgCL6wDAVewXnUBk
        Y6LF2Td6r1gjNcsLglm+bm+h+t1l3RA4OY/HZgoaFgiuntPUkLWk0YlwcB7stEbqYsCWW/IALSI6B
        jYL3wOTZMQE/FiJ/layQNCpfSp0xbnt8lIyMcmsjt00sGg9DgGR+nM2BVX3Pv9k9PawaXkEPp8yAB
        6T9HFmu9U+EjzJvILllx4QVkCtUg3h0BL7BoXteOotpvExZtjn1YRkjEikqrtOzyP6ZHi3VbVbZSW
        /Iq1VUAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jECSZ-0000ab-33; Tue, 17 Mar 2020 13:40:47 +0000
Date:   Tue, 17 Mar 2020 06:40:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     JaeJoon Jung <rgbi3307@gmail.com>
Cc:     maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>, koct9i@gmail.com
Subject: Re: [PATCH] Add next, prev pointer in xa_node at the lib/xarray.c
Message-ID: <20200317134043.GA22433@bombadil.infradead.org>
References: <CAHOvCC7ZLpOkdWPjY3art8LYOh2SJWwgqYRHRMVm-E4-kD06mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOvCC7ZLpOkdWPjY3art8LYOh2SJWwgqYRHRMVm-E4-kD06mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:32:34PM +0900, JaeJoon Jung wrote:
> Hi Matthew,
> I add next, prev pointer in the xa_node to improve search performance.
> XArray currently has the following search capabilities:
> 
> Search algorithm performance is O(n) = n x log(n)

That's not how "big-O" notation is used.
https://en.wikipedia.org/wiki/Big_O_notation

What you mean to say here is O(n.log(n)).

> For example,
> XA_CHUNK_SHIFT 2
> XA_CHUNK_SIZE 4

I'm not really interested in the performance of a cut-down radix tree.
You can re-run the numbers with a SHIFT of 6 and SIZE of 64 to get a
more useful set of performance numbers.

> If you connect the leaf node with the next and prev pointers as follows,
> the search performance is improved to O (n) = n.

But that's not free.  Right now, the xa_node is finely tuned in
size to 576 bytes on 64-bit systems (32-bit systems are a secondary
consideration).  That gets us 7 nodes per page.  Increasing the size any
further reduces the number per page to 6, which is a pretty meaningful
increase in memory usage.

> @@ -1125,6 +1125,8 @@ struct xa_node {
>         unsigned char   count;          /* Total entry count */
>         unsigned char   nr_values;      /* Value entry count */
>         struct xa_node __rcu *parent;   /* NULL at top of tree */
> +        struct xa_node __rcu *prev;     /* previous node pointer */
> +        struct xa_node __rcu *next;     /* next node pointer */

You should be indenting with tabs, not spaces.  Or your mail system is
messing with your patches.


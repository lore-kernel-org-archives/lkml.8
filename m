Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC69207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgETToM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:44:11 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 12:44:11 PDT
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F676C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:44:11 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C6D98C009; Wed, 20 May 2020 21:37:02 +0200 (CEST)
Date:   Wed, 20 May 2020 21:36:47 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, lucho@ionkov.net, ericvh@gmail.com,
        rminnich@sandia.gov, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [V9fs-developer] [PATCH] 9p/xen: increase XEN_9PFS_RING_ORDER
Message-ID: <20200520193647.GA17565@nautica>
References: <20200520184113.24727-1-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520184113.24727-1-sstabellini@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Stabellini wrote on Wed, May 20, 2020:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> Increase XEN_9PFS_RING_ORDER to 9 for performance reason. Order 9 is the
> max allowed by the protocol.
> 
> We can't assume that all backends will support order 9. The xenstore
> property max-ring-page-order specifies the max order supported by the
> backend. We'll use max-ring-page-order for the size of the ring.
> 
> This means that the size of the ring is not static
> (XEN_FLEX_RING_SIZE(9)) anymore. Change XEN_9PFS_RING_SIZE to take an
> argument and base the calculation on the order chosen at setup time.
> 
> 
> Finally, modify p9_xen_trans.maxsize to be divided by 4 compared to the
> original value. We need to divide it by 2 because we have two rings
> coming off the same order allocation: the in and out rings. This was a
> mistake in the original code. Also divide it further by 2 because we
> don't want a single request/reply to fill up the entire ring. There can
> be multiple requests/replies outstanding at any given time and if we use
> the full ring with one, we risk forcing the backend to wait for the
> client to read back more replies before continuing, which is not
> performant.

Sounds good to me overall. A couple of comments inline.
Also worth noting I need to rebuild myself a test setup so might take a
bit of time to actually run tests, but I might just trust you on this
one for now if it builds with no new warning... Looks like it would
probably work :p

> [...]
> @@ -264,7 +265,7 @@ static irqreturn_t xen_9pfs_front_event_handler(int irq, void *r)
>  
>  static struct p9_trans_module p9_xen_trans = {
>  	.name = "xen",
> -	.maxsize = 1 << (XEN_9PFS_RING_ORDER + XEN_PAGE_SHIFT),
> +	.maxsize = 1 << (XEN_9PFS_RING_ORDER + XEN_PAGE_SHIFT - 2),
>  	.def = 1,
>  	.create = p9_xen_create,
>  	.close = p9_xen_close,
> [...]
> @@ -401,8 +405,10 @@ static int xen_9pfs_front_probe(struct xenbus_device *dev,
>  		return -EINVAL;
>  	max_ring_order = xenbus_read_unsigned(dev->otherend,
>  					      "max-ring-page-order", 0);
> -	if (max_ring_order < XEN_9PFS_RING_ORDER)
> -		return -EINVAL;
> +	if (max_ring_order > XEN_9PFS_RING_ORDER)
> +		max_ring_order = XEN_9PFS_RING_ORDER;

(If there are backends with very small max_ring_orders, we no longer
error out when we encounter one, it might make sense to add a min
define? Although to be honest 9p works with pretty small maxsizes so I
don't see much reason to error out, and even order 0 will be one page
worth.. I hope there is no xenbus that small though :))

> +	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
> +		p9_xen_trans.maxsize = XEN_FLEX_RING_SIZE(max_ring_order);

So base maxsize initial value is 1 << (order + page_shift - 2) ; but
this is 1 << (order + page_shift - 1) -- I agree with the logic you gave
in commit message so would think this needs to be shifted down one more
like the base value as well.
What do you think?

-- 
Dominique

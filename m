Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD8C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895820828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ym7NgKj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCIQzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:55:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50006 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCIQzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L9W0UbpChESWksr603x3b8JT+mm1g1y8Y901wxtJi4M=; b=Ym7NgKj1jFWdn31wAuHnFV3X2r
        HWhZW+Z63SuobfGBtvlWZmQKHtJreCDPL9+dEoqzxfvhH8v3rj3Uo1ekDSMOFWaojYdVJioZ82ypC
        ADAvUp6BPOENzzODXsu9jIm0hCHu0I7uIcyzp30B0+KBda0Vru52/uRrzlYKlzN1ew9koEND+BMUC
        tYZyKvYBbdLIsEtAuAHlk65kSAgW4HjGNzgPFIlmGDQf8xt7uV1V9Ssv20AO55OXgrqTJOizdaDc+
        vImXK2PqJg14h2hxa/0nWypiZmJZInVPBbCXsdLuBBAAq9UU4k62yndHnIPxn2qPO7OyQEopS/4vj
        lWFVBUXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBLgQ-0000kn-Pa; Mon, 09 Mar 2020 16:55:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7EE8D300F7A;
        Mon,  9 Mar 2020 17:55:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 680A1214344E9; Mon,  9 Mar 2020 17:55:11 +0100 (CET)
Date:   Mon, 9 Mar 2020 17:55:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiwuchen55@gmail.com
Cc:     akpm@linux-foundation.org, walken@google.com, rfontana@redhat.com,
        dbueso@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] rbtree: introduce three helpers about sort-order
 iteration
Message-ID: <20200309165511.GK12561@hirez.programming.kicks-ass.net>
References: <1583769734-1311-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583769734-1311-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:02:14AM +0800, qiwuchen55@gmail.com wrote:
> +/**
> + * rbtree_for_each_entry_safe - iterate in sort-order over of given type
> + * allowing the backing memory of @pos to be invalidated.
> + * @pos:	the 'type *' to use as a loop cursor.
> + * @n:		another 'type *' to use as temporary storage.
> + * @root:	'rb_root *' of the rbtree.
> + * @field:	the name of the rb_node field within 'type'.
> + *
> + * rbtree_order_for_each_entry_safe() provides a similar guarantee as
> + * list_for_each_entry_safe() and allows the sort-order iteration to
> + * continue independent of changes to @pos by the body of the loop.
> + *
> + * Note, however, that it cannot handle other modifications that re-order the
> + * rbtree it is iterating over. This includes calling rb_erase() on @pos, as
> + * rb_erase() may rebalance the tree, causing us to miss some nodes.
> + */
> +#define rbtree_for_each_entry_safe(pos, n, root, field) \
> +	for (pos = rb_entry_safe(rb_first(root), typeof(*pos), field); \
> +	     pos && ({ n = rb_entry_safe(rb_next(&pos->field), \
> +			typeof(*pos), field); 1; }); \
> +	     pos = n)

Since this cannot deal with rb_erase(), what exactly is the purpose of
this thing?

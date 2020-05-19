Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2898C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA992072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M2cIOnKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgESOpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgESOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:45:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vijp3ax4bbjLHEFlE42c26bubWJnhGdQUG2gMFm2ejw=; b=M2cIOnKvgkqLTWJviXN1qmeGtM
        cprLvfZfhPOYZpY6DlRTq6c0xIjDYZRw6zPRKyBFgAvz20y+nnGChRlXI2Cd7EKbWA5bLg6Px79ub
        8XdcE6369nFacmAMHhNtGy5TGR5dmhhnW8ia81dNNtonjeKHdkJ2WfAv+I1lF/40AELGXSwzOdBEV
        TEITT7eQ2rHnYRMbXrIUa+ha0q3pYrxYAkbrBtGmTWjCLlTEmY8QR+d26hYi2Zg8rN1ZAEZ5lCUMu
        F3ACE/m2NRB/mdLQ7AnzllhUlneVGLqmbaDaV24vf0Ifq0w6PFFbXWtOtiSnN2xcHuCKzBimUG/w/
        f26zElHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb3Uz-0006IJ-0Y; Tue, 19 May 2020 14:45:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4245230067C;
        Tue, 19 May 2020 16:45:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28DBC20C24271; Tue, 19 May 2020 16:45:39 +0200 (CEST)
Date:   Tue, 19 May 2020 16:45:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: lockdep tracing and using of printk return value ?
Message-ID: <20200519144539.GB317569@hirez.programming.kicks-ass.net>
References: <335067f871a85db5f24650a3dff96f19727bed50.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335067f871a85db5f24650a3dff96f19727bed50.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 05:41:47AM -0700, Joe Perches wrote:
> Except for some ancient code in drivers/scsi, this code
> may be the only kernel use of the printk return value.

Is using the printk() return value a problem?

> Code that uses the printk return value in
> kernel/locking/lockdep.c is odd because the printk
> return length includes both the length of a KERN_<LEVEL>
> prefix and the newline.  depth also seems double counted.

Yeah, it seems dodgy. OTOH printk() really ought to discard the
KERN_<level> crud from the return size.

> Perhaps there's a better way to calculate this?
> 
> Maybe:
> ---
>  kernel/locking/lockdep.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 2fadc2635946..265227edc550 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1960,11 +1960,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
>  
>  	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
>  		if (class->usage_mask & (1 << bit)) {
> -			int len = depth;
> -
> -			len += printk("%*s   %s", depth, "", usage_str[bit]);
> -			len += printk(KERN_CONT " at:\n");
> -			print_lock_trace(class->usage_traces[bit], len);
> +			printk("%*s   %s at:\n", depth, "", usage_str[bit]);
> +			print_lock_trace(class->usage_traces[bit],
> +					 depth + 3 + strlen(usage_str[bit]);
>  		}
>  	}
>  	printk("%*s }\n", depth, "");

Doesn't seem crazy...

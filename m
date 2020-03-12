Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D035EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D694E20737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583974762;
	bh=JABgZCHmEBb3tn/P9d99r9kBtaxONATZlzJZzI6/7h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qp2fpSh5hztmJe+pVQ4rB3ugH+PlZY923l2g78N+scXT5MWfpSa12c6Fj1mj2T/8x
	 Sp7lLqxA6zaNhiZGBoNtF5KLUklkyIhlqUzlZfhMK9Z+sosWP3cVnyUwEGti199R79
	 N/JFfwOSKkljB+gcYzAwJFNcmB3hs9yPF3Q87QqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgCLA7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387518AbgCLA7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:59:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0D520734;
        Thu, 12 Mar 2020 00:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583974760;
        bh=JABgZCHmEBb3tn/P9d99r9kBtaxONATZlzJZzI6/7h4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dljkngR2apT/UPuwBHxo/d8Tb+tarA2I5DfIGV5mm0seMImzOdeOOyzU3ZheyPq4B
         mzK2fcyoCMlaF9y1ccJ5JxNstj7+bz3gA4xqrc7sVXAMGPrELUUNEIf9hLVaW+Ocer
         SJ0ooQgN9AgmmZ6r2ObKEfsiuWWZ2xP5MyamOCmI=
Date:   Wed, 11 Mar 2020 17:59:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] backing-dev: refactor wb_congested_put()
Message-Id: <20200311175919.30523d55b2e5307ba22bbdc0@linux-foundation.org>
In-Reply-To: <20200312002156.49023-2-jbi.octave@gmail.com>
References: <20200312002156.49023-1-jbi.octave@gmail.com>
        <20200312002156.49023-2-jbi.octave@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 00:21:56 +0000 Jules Irenge <jbi.octave@gmail.com> wrote:

> wb_congested_put() was written in such a way that made it difficult
> 	for Sparse tool not to complain
> Expanding the function locking block in the if statement improves on
> the readability of the code. Rewritting it  comes with one add-on:
> 
> It fixes a warning reported by Sparse tool at wb_congested_put()
> 
> warning: context imbalance in wb_congested_put() - unexpected unlock
> 
> Refactor the function wb_congested_put()
> 
> ...
>
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -464,18 +464,21 @@ void wb_congested_put(struct bdi_writeback_congested *congested)
>  {
>  	unsigned long flags;
>  
> -	if (!refcount_dec_and_lock_irqsave(&congested->refcnt, &cgwb_lock, &flags))
> -		return;
> -
> +	if (!refcount_dec_not_one(&congested->refcnt)) {
> +		spin_lock_irqsave(&cgwb_lock, flags);
> +		if (!refcount_dec_and_test(&congested->refcnt)) {
> +			spin_unlock_irqrestore(&cgwb_lock, flags);
> +			return;
> +		}
>  	/* bdi might already have been destroyed leaving @congested unlinked */
> -	if (congested->__bdi) {
> -		rb_erase(&congested->rb_node,
> -			 &congested->__bdi->cgwb_congested_tree);
> -		congested->__bdi = NULL;
> +		if (congested->__bdi) {
> +			rb_erase(&congested->rb_node,
> +				 &congested->__bdi->cgwb_congested_tree);
> +			congested->__bdi = NULL;
> +		}
> +		spin_unlock_irqrestore(&cgwb_lock, flags);
> +		kfree(congested);
>  	}
> -
> -	spin_unlock_irqrestore(&cgwb_lock, flags);
> -	kfree(congested);
>  }

hm, it's hard to get excited over this.  Open-coding the
refcount_dec_and_lock_irqsave() internals at a callsite in order to
make sparse happy.

Is there some other way, using __acquires (for example)?

Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5485C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954D0207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hCzwWIuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAMOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:55:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zh4QUZLzvgMWwTWktPzWJ7VG+SXjfjlk+HJG7tNPPF8=; b=hCzwWIuhWrKQ4ZB+odRihAPPp
        9/2+9RV0pnAD53kgq7fzWS1an+ByKVlBpMgU8aTShWp8bZqPD+uUehIrUjRj8AbY/1vI6YeHobzu2
        /aY/19P4ierCov3QHXXN0Z+XCmsgjgqpr4XjbNQa0mp5byT68X+ngK9MJffVxu70VnUz5XRTJFOC4
        n9XoVPle85NWAvs2mHQqkP62ms1D9jWgsikoeFwtP8QGVdMOxYf65hFpv0A3tS/y83L8ePChsMLaP
        BTKP97b9aXRHpRdq7gVn2UYh+nz4AJtBsVGuMhkpffktLE2gCk/LNxpnGjXGYyUWOWcn8Qv3Y0NXB
        2Gjkg9kTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir185-0002Uk-JG; Mon, 13 Jan 2020 14:55:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76EDA304121;
        Mon, 13 Jan 2020 15:54:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB930201D941B; Mon, 13 Jan 2020 15:55:42 +0100 (CET)
Date:   Mon, 13 Jan 2020 15:55:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 1/6] locking/lockdep: Track number of zapped classes
Message-ID: <20200113145542.GV2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151517.7060-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:15:12AM -0500, Waiman Long wrote:
> The whole point of the lockdep dynamic key patch is to allow unused
> locks to be removed from the lockdep data buffers so that existing
> buffer space can be reused. However, there is no way to find out how
> many unused locks are zapped and so we don't know if the zapping process
> is working properly.
> 
> Add a new nr_zapped_classes variable to track that and show it in
> /proc/lockdep_stats if it is non-zero.
> 

> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index dadb7b7fba37..d98d349bb648 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -336,6 +336,15 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
>  	seq_printf(m, " debug_locks:                   %11u\n",
>  			debug_locks);
>  
> +	/*
> +	 * Zappped classes and lockdep data buffers reuse statistics.
> +	 */
> +	if (!nr_zapped_classes)
> +		return 0;
> +
> +	seq_puts(m, "\n");
> +	seq_printf(m, " zapped classes:                %11lu\n",
> +			nr_zapped_classes);
>  	return 0;
>  }

Why is that conditional?

Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD1C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AE121569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGmDUza5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgDWJ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgDWJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:26:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80BC03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AhqqTWP07O6E8+pNvQs5WZMEOhvWks1ANvCjRq43y8s=; b=EGmDUza5qNYoWfeduybh4XZoUS
        CQVfQ0XuMxATSC4TL9wEMHCSphDdgmMVAvVpqBBTnKNEb7V0aZ9UESlSEC2jAbvjaheY3uTCWIN8Q
        pbNEZu/hnl/bLNuqTrVnlRRqjRembY0SDAmq1c6HlMCkVE7/ghBDNNYgXnI+PpXLA2uy4g0rhEKzQ
        TR6ryKn3DnpGNsxYnPe9e8HaoYTd2/oH4UfiUt/wmnamb1/G1/s1bp5KYjF/kppa45IX1R+EBbY+6
        o/nQAkM8L1sSvuiPWv9DSl2CUz9XNfQ/GYFKBIE1un1jsIkMSjvX4B8p6PPbPWucSfKM0RxstWPer
        FznTrTpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRY7i-00029C-Ap; Thu, 23 Apr 2020 09:26:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93577306099;
        Thu, 23 Apr 2020 11:26:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A5F323D19EEE; Thu, 23 Apr 2020 11:26:20 +0200 (CEST)
Date:   Thu, 23 Apr 2020 11:26:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: make p->prio independent of p->mm
Message-ID: <20200423092620.GR20730@hirez.programming.kicks-ass.net>
References: <20200423040128.6120-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423040128.6120-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:01:28PM +0800, Hillf Danton wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4796,13 +4796,19 @@ recheck:
>  		return -EINVAL;
>  
>  	/*
> -	 * Valid priorities for SCHED_FIFO and SCHED_RR are
> -	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
> -	 * SCHED_BATCH and SCHED_IDLE is 0.
> +	 * The MAX_USER_RT_PRIO value allows the actual maximum
> +	 * RT priority to be separate from the value exported to
> +	 * user-space.  This allows kernel threads to set their
> +	 * priority to a value higher than any user task.
>  	 */
> -	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
> -	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
> -		return -EINVAL;
> +	if (p->flags & PF_KTHREAD) {
> +		if (attr->sched_priority > MAX_RT_PRIO - 1)
> +			return -EINVAL;
> +	} else {
> +		if (attr->sched_priority > MAX_USER_RT_PRIO - 1)
> +			return -EINVAL;
> +	}
> +

Arguably we can do away with the check entirely, MAX_RT_PRIO ==
MAX_USER_RT_PRIO.

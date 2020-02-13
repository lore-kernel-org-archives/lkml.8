Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34044C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0432F24688
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aGET5ETM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgBMQpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:45:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBMQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FnVNlx6gJa1Ab6LLHb8C32dPYmEFN6PkGP/v8k0yALc=; b=aGET5ETMJhZ4GgaI15v2EbCUAM
        1zxRNVaocSqgwz2j/FU+9BYKspBxctWtnXJ48ILjd4V55v8buA0i1Rjau7LQWzsYjXkUa7bfMQBrY
        3tvdSA5PA7bN2CONo9Aeb1BqYOf0k8puIz1YbdZdYlVcRM8fwkVO0XMoY5fYhBjhzeFFIMLokNnVW
        WkF+a/hdDMrxqg/w/VFl6ISI8L4h6J1ps99+EPSaCnjKgqG2r8g6G9W9EtJn5g1sjZaA5BBerq3Um
        AnILDxo9N+Tu7V1tZrCaDGbwLi+45PXdznxHsoKwVnM05WOprPu8WPW2VeK1jnhvFt9p5xubMPbmv
        96e+PHog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Hc9-0000bc-Cf; Thu, 13 Feb 2020 16:45:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 010B23077E8;
        Thu, 13 Feb 2020 17:43:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EDD220206D69; Thu, 13 Feb 2020 17:45:18 +0100 (CET)
Date:   Thu, 13 Feb 2020 17:45:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Replace zero-length array with
 flexible-array member
Message-ID: <20200213164518.GI14914@hirez.programming.kicks-ass.net>
References: <20200213151951.GA32363@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213151951.GA32363@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:19:51AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f38ff5a335d3..12a424878b23 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1081,7 +1081,7 @@ struct numa_group {
>  	 * more by CPU use than by memory faults.
>  	 */
>  	unsigned long *faults_cpu;
> -	unsigned long faults[0];
> +	unsigned long faults[];
>  };

Hurmph, and where are all the other similar changes for kernel/sched/ ?
Because this really isn't the only such usage and I really don't see the
point in having a separate patch for every single one of them.

Also; couldn't you've taught the compiler to also warn about [0] ?
There's really no other purpose to having a zero length array.

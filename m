Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FC9C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1234C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDwsefBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDWI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgDWI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:58:12 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4766C03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4o8bmRbgfzERZRr7sLF0I+2xbIArysmLzxBcWgMJVC4=; b=BDwsefBPrd+dwXtJcxJPyrwWSE
        iDa37to/V7PFWgkap7P1snECeHtcRz31rXjX9PgoyjXNcz9NAJO76YvxwoiLkTqaIiXGJbCBbBq5i
        kIGHq/CkJkd2MsRFAWuJ6BnuEMHWwwsBu6JKHjd+ITcj3UYUnLa3Cx51PCpHmo5HPV1+lq3UB1KzB
        cHOeW6QpFFbNDFcp9ojpbJja1GJgcsilOwYJZ+idYUB+ERsKZgWLfHuWN5v+rFUliK6XQD5bQTdCe
        /rUIOMlxX9yPS3KUGseoFXkjKEFggQJfDNuAejalrqVlsBp1RhWzjoxjfTrVERB7Jicl/xxpWtHMC
        gV0bLPVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRXft-00034J-MY; Thu, 23 Apr 2020 08:57:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D01E1300739;
        Thu, 23 Apr 2020 10:57:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE34D20BE0448; Thu, 23 Apr 2020 10:57:35 +0200 (CEST)
Date:   Thu, 23 Apr 2020 10:57:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        axboe@kernel.dk
Subject: Re: [PATCH 05/23] sched,drbd: Convert to sched_set_fifo*()
Message-ID: <20200423085735.GU20713@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.515522261@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112831.515522261@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:24PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> In this case, use fifo_low, because it only cares about being above
> SCHED_NORMAL. Effectively changes prio from 2 to 1.
> 
> Cc: axboe@kernel.dk
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/block/drbd/drbd_receiver.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -6020,9 +6020,8 @@ int drbd_ack_receiver(struct drbd_thread
>  	unsigned int header_size = drbd_header_size(connection);
>  	int expect   = header_size;
>  	bool ping_timeout_active = false;
> -	struct sched_param param = { .sched_priority = 2 };
>  
> -	rv = sched_setscheduler(current, SCHED_RR, &param);
> +	rv = sched_set_fifo_low(current);

As noted by Dietmar, I forgot to mention loosing RR in the changelog,
bad me.

In this case I'm not actually 100% sure, but there was no comment with
it that justified it being RR, and RR-SMP is not optimal (in fact it's
rather buggered).

In general RR is even more 'interesting' to get right thatn FIFO and
therefore I figured it probably didn't want to be RR, but given there
can be multiple of such threads, it might have been an attempt at
providing some sort of fairness between the multiple threads.

At the same time, if you're running the threads so hard that RR makes a
difference, it's unlikely there is any actual NORMAL time left and
things will be unhappy anyway.

Therefore, and me being lazy, make it FIFO.

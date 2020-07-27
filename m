Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D82206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rG1283Do";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oabFngj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgG0PlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgG0PlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:41:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:41:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595864465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2GoCD6qjiCp2SZh/B51AWSLCQivBgFFObpLzIT1tS4=;
        b=rG1283DoQ5qLCZ574zhNvf40GyaDkQrdPlUP9Iv5UQ8JOaetvZsFPsvgerdjwyQsP0CfIH
        dbH5HMelj7eSirYeGuHhUKV8rL1/PpQ49hvqNyTpVm/5zViRGg481mtxRhCNyzHgbGm7Y9
        P9Gw6Q39k+PnboWZDwIXpcH8oEgaO1f3N4d8t+MPx+1jjPyNnAqwP64AVYGugtw+gKwE2D
        tLpQ4fSMOBCvX/mpGpPLxZP2IpFay23N95P9gJtqZ8fLSjuvnLKDrcgXPvVPKBx+ciiaHl
        REDbY0H2jGgCd3bIiPQpD9+gyX9Af7uLEpW6leLlqA3bD3Nw7TLgNIFUV9+W/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595864465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2GoCD6qjiCp2SZh/B51AWSLCQivBgFFObpLzIT1tS4=;
        b=oabFngj7mpGC/vE+Ror7c/XAQUxxNR3FamgmIhbF7oLNio+SG/GFlC4z4NIQgzSs94O/Cy
        XzJfFyj5/DtMGwBw==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, laoar.shao@gmail.com,
        urezki@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
In-Reply-To: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
Date:   Mon, 27 Jul 2020 17:41:04 +0200
Message-ID: <87sgddaru7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian,

qianjun.kernel@gmail.com writes:
>  /*
>   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
>   * but break the loop if need_resched() is set or after 2 ms.
> - * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
> - * certain cases, such as stop_machine(), jiffies may cease to
> - * increment and so we need the MAX_SOFTIRQ_RESTART limit as
> - * well to make sure we eventually return from this method.
> + * In the loop, if the processing time of the softirq has exceeded 2
> + * milliseconds, we also need to break the loop to wakeup the
> ksofirqd.

You are removing the MAX_SOFTIRQ_RESTART limit explanation and I rather
have MAX_SOFTIRQ_TIME_NS there than '2 milliseconds' in case the value
gets adjusted later on. Also while sched_clock() is granular on many
systems it still can be jiffies based and then the above problem
persists.

> @@ -299,6 +298,19 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  		}
>  		h++;
>  		pending >>= softirq_bit;
> +
> +		/*
> +		 * the softirq's action has been running for too much time
> +		 * so it may need to wakeup the ksoftirqd
> +		 */
> +		if (need_resched() && sched_clock() > end) {
> +			/*
> +			 * Ensure that the remaining pending bits are
> +			 * handled.
> +			 */
> +			or_softirq_pending(pending << (vec_nr + 1));

To or the value interrupts need to be disabled because otherwise you can
lose a bit when an interrupt happens in the middle of the RMW operation
and raises a softirq which is not in @pending and not in the per CPU
local softirq pending storage.

There is another problem. Assume bit 0 and 1 are pending when the
processing starts. Now it breaks out after bit 0 has been handled and
stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
again. ksoftirqd runs and handles bit 0, which takes more than the
timeout. As a result the bit 0 processing can starve all other softirqs.

So this needs more thought.

Thanks,

        tglx

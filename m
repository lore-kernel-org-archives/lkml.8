Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED8E2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fMnEueT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgFRQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgFRQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:26:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52139C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zqaqiG8aBBfXnolcoZWCcqMsQ7mBjjocEXvjqDyysTI=; b=fMnEueT9WILfVhQXmU0o4+d5WF
        LBtUw0dc3SmSXwMkFgB5ouipemTfNUZ1mZe2EY/Aphli1sWBMOOIhaYfc9l4arKSqZVeXLegDUjhY
        BAVpj0HnITAn9Ygfsj5GEm9FQUW5OA2a8x87V4vjwnu0FOyglZyCm5KS5rhUWzEhVdwMcrQ31o8OX
        XeewF+Ww3N0IpOLah9kCCoaNZfDBBkVVre1fCY9gDVasVJ9R4He4reVw0P0XIQ2Xc14W+5zrRzA9k
        mHl6Rzni0p4Ht7IlujKJ8CXZI0C7bgHWnZAOnYHws0Rve63GW+Ahaxkh3VQ0GI5+4FIXdyKiO6ma4
        7DHu98Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlxMP-00010y-7s; Thu, 18 Jun 2020 16:25:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B27430018A;
        Thu, 18 Jun 2020 18:25:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCD122B9C1B8B; Thu, 18 Jun 2020 18:25:49 +0200 (CEST)
Date:   Thu, 18 Jun 2020 18:25:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        tsbogend@alpha.franken.de, axboe@kernel.dk, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, dchickles@marvell.com,
        davem@davemloft.net, kuba@kernel.org, daniel.thompson@linaro.org,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 6/6] smp: Cleanup smp_call_function*()
Message-ID: <20200618162549.GM576905@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.434079683@infradead.org>
 <20200617082349.GA19894@infradead.org>
 <20200617110401.GG2531@hirez.programming.kicks-ass.net>
 <20200618065107.GA4406@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618065107.GA4406@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:51:07PM -0700, Christoph Hellwig wrote:
> Much better.  Although if we touch all the callers we might as well
> pass the csd as the argument to the callback, as with that we can
> pretty trivially remove the private data field later.

My plan was to introduce a new function and type and convert
smp_call_function_async() callers over to that. The csd as it exists is
useful for the regular smp_call_function*() API.

> Btw, it seems the callers that don't have the CSD embedded into the
> containing structure seems to be of these two kinds:
> 
>  - reimplementing on_each_cpumask (mostly because they can be called
>    from irq context)

These are fairly special purpose constructs; and they come at the cost
of extra per-cpu storage and they have the limitiation that they must
wait for completion of the first before they can be used again.

>  - reimplenenting smp_call_function_single because they want
>    to sleep instead of busy wait

These are atrocious pieces of crap (the x86/msr ones), the reason it was
done is because virt :/

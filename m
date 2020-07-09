Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8008B2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/qUL+5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGIK7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGIK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:59:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88629C061A0B;
        Thu,  9 Jul 2020 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wy3SRsF7VDgB6D0qXNwkslDxCCLOyMo8ONtDn/aSD/s=; b=n/qUL+5M+rBeTJFzWOJL9JDwzy
        4tJ6+FS1DxlA7Drg64uyJG24hR2YB1hWVX6MmBdCptL5sKVlSPFRnPMfMZ+laFqae0ghBsky3bStA
        vTXxRfkEaDRP5RPBXdh67TENjEJe+lMASlQcaonOvMxgPq66MeCJqt2HUvXgnU4SXMFkUea4pvwAc
        nzBkDliD+JKOJVbZHjWYV0HFwOL86TqkzVrI5VT43lo86YNDADNdZXJkbhUobDH6goIfaL0kEb1lt
        KlC2x3h6wZvq47Fhh+ejYoRkV4pOzsvSu1ZSD4L4h3cl0uggnV39o0sZEuXx9O/t9F1Pc20UwRdir
        h73o8pvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtUGj-0003sE-Jd; Thu, 09 Jul 2020 10:59:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ED8D30047A;
        Thu,  9 Jul 2020 12:59:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CD29235B3D18; Thu,  9 Jul 2020 12:59:06 +0200 (CEST)
Date:   Thu, 9 Jul 2020 12:59:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel/smp: Fix an off by one in csd_lock_wait_toolong()
Message-ID: <20200709105906.GR597537@hirez.programming.kicks-ass.net>
References: <20200709104818.GC20875@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709104818.GC20875@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 01:48:18PM +0300, Dan Carpenter wrote:
> The __per_cpu_offset[] array has "nr_cpu_ids" elements so change the >
> >= to prevent a read one element beyond the end of the array.
> 
> Fixes: 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")

I don't have a copy of that patch in my inbox, even though it says Cc:
me.

Paul, where do you expect that patch to go? The version I see from my
next tree needs a _lot_ of work.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 78b602cae6c2..f49966713ac3 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -171,7 +171,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
>  		*bug_id = atomic_inc_return(&csd_bug_count);
>  	cpu = csd_lock_wait_getcpu(csd);
>  	smp_mb(); // No stale cur_csd values!
> -	if (WARN_ONCE(cpu < 0 || cpu > nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
>  		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
>  	else
>  		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
> -- 
> 2.27.0
> 

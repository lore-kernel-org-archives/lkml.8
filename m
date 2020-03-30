Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5282C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784D720781
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vy4IBQoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgC3Ofo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:35:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3Ofn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8dMy6oB8LEYaBCY+FzoIKWz2v2QtoooKj9X6ubO8KXU=; b=Vy4IBQoK98Z60ZjL3zRngHaWgw
        vcGAnEw2/V8560zv7nzyLqmSk2Imv/obaivNjUoxf+GqTcxmjZG6tA+MSp6FrcqqUpuXxbmroe7WV
        FBI/SBRzPCpm/MutyeoGgy0XxwYq7axf5Lj9lcS5h7NMFmkn0Ktzbv27KPiRw3Xo4UG34SrjjIfYR
        IZlamVRtp+S5SW4lIYwKUy1HMMiK0hIfD/A0pHSSyYaN+iwSmoGKKH6hiCjA9eYiP1f+C2+YWLQ4w
        YPBY0IhL6YypJKoidlmszmIOp4Ry44EofKcwTinp1p1BeohxgYqMNWuEyrF+mC+eeDyc4m8ZnNtun
        uVQWmyXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIvVv-0007hu-5y; Mon, 30 Mar 2020 14:35:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE4C5300F28;
        Mon, 30 Mar 2020 16:35:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9972203B8790; Mon, 30 Mar 2020 16:35:40 +0200 (CEST)
Date:   Mon, 30 Mar 2020 16:35:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/vtime: Fix an unitialized variable warning
Message-ID: <20200330143540.GQ20696@hirez.programming.kicks-ass.net>
References: <20200327214334.GF8015@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200327214334.GF8015@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:43:34PM +0100, Borislav Petkov wrote:
> Hi dude,
> 
> right before I was going to send the trivial, shut-up-gcc variant, I
> thought that maybe we should do this instead.
> 
> Thoughts?
> 
> ---
> Fix:
> 
>   kernel/sched/cputime.c: In function ‘kcpustat_field’:
>   kernel/sched/cputime.c:1007:6: warning: ‘val’ may be used \
> 	  uninitialized in this function [-Wmaybe-uninitialized]
>    1007 |  u64 val;
>         | ^~~
> 
> because gcc can't see that val is used only when err is 0.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  kernel/sched/cputime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index dac9104d126f..ff9435dee1df 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -1003,12 +1003,12 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
>  		   enum cpu_usage_stat usage, int cpu)
>  {
>  	u64 *cpustat = kcpustat->cpustat;
> +	u64 val = cpustat[usage];
>  	struct rq *rq;
> -	u64 val;
>  	int err;
>  
>  	if (!vtime_accounting_enabled_cpu(cpu))
> -		return cpustat[usage];
> +		return val;
>  
>  	rq = cpu_rq(cpu);


Hurph.. this might result in an unconditional load (and extra
cache-miss) for the vtime_accounting_enabled_cpu() case.

I suspesct the =0 this would be better. Stupid stupid compiler!


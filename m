Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F1C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF44B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJxRw5xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXJcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:32:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YE6seiuyITlCDuzDkVuYwXtaOchvz2Zcj5WBB7bLhu0=; b=pJxRw5xvyA192Np0aiMhypwZx5
        6oXL9mvcpUosr3wV8H+J4Pe0XSbsDTfuIGe/lznJnmhRjC1QOh+svtG3exsfFw2TsiSD9nwLUauZh
        QyKAb45l6kxXSQnWG9VimZkphBY5F3R5hmB6oZPk3jLs7NFo57HiA+dR/p5iOSE7JMCMF+EoC2zHK
        ZO+9bHWYjD99JOZqewDCfXi812/xZHfqRRJYVXesmhmmBTFa3HSlfyFN7cSimQHbkSuhFPEjT1Qn3
        yQIoiitPZYoT2vQCv5mc8c295Y2yPEWWU3wl4VKbhR/oId6VvceXkO12wCmV+KCqP/05N4ug7nGwb
        6Ksxurig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6A66-0002rC-HM; Mon, 24 Feb 2020 09:32:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3696300F7A;
        Mon, 24 Feb 2020 10:30:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59F282B4DAAD0; Mon, 24 Feb 2020 10:32:15 +0100 (CET)
Date:   Mon, 24 Feb 2020 10:32:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiwuchen55@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] sched/pelt: use shift operation instead of division
 operation
Message-ID: <20200224093215.GC14897@hirez.programming.kicks-ass.net>
References: <1582515055-14515-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582515055-14515-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:30:55AM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use shift operation to calculate the periods instead of division,
> since shift operation is more efficient than division operation.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  kernel/sched/pelt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index bd006b7..ac79f8e 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -114,7 +114,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>  	u64 periods;
>  
>  	delta += sa->period_contrib;
> -	periods = delta / 1024; /* A period is 1024us (~1ms) */
> +	periods = delta >> 10; /* A period is 1024us (~1ms) */

Find me a compiler that stupid.

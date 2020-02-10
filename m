Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD57FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F9F2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581348119;
	bh=H/nYGXOoJ9XQc05LV8U38gSp+jP0pv2BrR9tJM36noo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Hn0DqdsQUqOwX8JJ3zp25Fu7FCyDKczc987b/+bosFH8VSts5xOym4X57Mmy1A0IG
	 O3/wG2zCdyUXJrOutj+0Qeh+h+6HvukIGOwOb1ES/H48FFaZxam1oHRVtfHf9ee1lR
	 CHvnY8lVUpjhBor45SFY9AOWICZB2X1bq9WHY1Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgBJPV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgBJPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:21:57 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB872082F;
        Mon, 10 Feb 2020 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581348117;
        bh=H/nYGXOoJ9XQc05LV8U38gSp+jP0pv2BrR9tJM36noo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p542MkWc8cSnDtsdb7NqIlx70Z1Q/+ToiQ04R/WRnYkYzb6IHv3jkxy9JlpPcgf7j
         R48UtIp1EjDJ8Fb3qDXCJ+WyRqRDIyECqrTzmrhbZHXpU3hj5yI5l5NiWVvij7CFcS
         54eYPatRAy+21UOaFYd1xJQn7QXi2KSi/u8jIVz4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 11DD33522700; Mon, 10 Feb 2020 07:21:54 -0800 (PST)
Date:   Mon, 10 Feb 2020 07:21:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Fix misreporting if concurrent races on same
 address
Message-ID: <20200210152154.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210145639.169712-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210145639.169712-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:56:39PM +0100, Marco Elver wrote:
> If there are more than 3 threads racing on the same address, it can
> happen that 'other_info' is populated not by the thread that consumed
> the calling thread's watchpoint but by one of the others.
> 
> To avoid deadlock, we have to consume 'other_info' regardless. In case
> we observe that we only have information about readers, we discard the
> 'other_info' and skip the report.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued for testing and review, thank you!!!

							Thanx, Paul

> ---
>  kernel/kcsan/report.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 3bc590e6be7e3..e046dd26a2459 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -422,6 +422,26 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
>  			return false;
>  		}
>  
> +		access_type |= other_info.access_type;
> +		if ((access_type & KCSAN_ACCESS_WRITE) == 0) {
> +			/*
> +			 * This is not the other_info from the thread that
> +			 * consumed our watchpoint.
> +			 *
> +			 * There are concurrent races between more than 3
> +			 * threads on the same address. The thread that set up
> +			 * the watchpoint here was a read, as well as the one
> +			 * that is currently in other_info.
> +			 *
> +			 * It's fine if we simply omit this report, since the
> +			 * chances of one of the other reports including the
> +			 * same info is high, as well as the chances that we
> +			 * simply re-report the race again.
> +			 */
> +			release_report(flags, KCSAN_REPORT_RACE_SIGNAL);
> +			return false;
> +		}
> +
>  		/*
>  		 * Matching & usable access in other_info: keep other_info_lock
>  		 * locked, as this thread consumes it to print the full report;
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C16C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1449206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHY4kKyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGERQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgGERQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 13:16:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B3C061794;
        Sun,  5 Jul 2020 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L1auyt688+bbEX1l1nLyPpGgpWer7N9IYMfrLy9J6Eo=; b=MHY4kKyjb2OHPtA22Bpdqx2OmK
        5iykedNwaCDASGPU+NcaFguZTihnIoxbmvNT54CkW5NqAX7fpumDigULYe5pX55132gzgaL6HXLXJ
        M5MWGeDQ9SySjLGlVid37prIZNHFn/6ln5sBZYBEKN1au9ZNQPLyXeEzzmshrBdGDcKulSxjSFiw9
        SUWnms9dqA2zQeGdx2bjy6VwhWqNsWlIjSxq1MoAPmBauSBkhJvxUBo85ua61GfE3cEFabGeqSbZq
        SxC4jGJkY3GlrByxLSKxfLa/VO0Lv4uRpg/5sAejp88JSkGsfbTXNVZReFk6CUaaYSapHVd5MuHuI
        Zdk95I4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1js8Fl-00015L-CF; Sun, 05 Jul 2020 17:16:33 +0000
Date:   Sun, 5 Jul 2020 18:16:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yang che <chey84736@gmail.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] hung_task:add detecting task in D state milliseconds
 timeout
Message-ID: <20200705171633.GU25523@casper.infradead.org>
References: <1593953332-29404-1-git-send-email-chey84736@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593953332-29404-1-git-send-email-chey84736@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 08:48:52PM +0800, yang che wrote:
> @@ -16,8 +16,9 @@ extern unsigned int sysctl_hung_task_all_cpu_backtrace;
>  
>  extern int	     sysctl_hung_task_check_count;
>  extern unsigned int  sysctl_hung_task_panic;
> +extern unsigned long  sysctl_hung_task_timeout_millisecs;

I would suggest an '_msec' suffix to go along with ...

> @@ -37,6 +37,7 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
>   * the RCU grace period. So it needs to be upper-bound.
>   */
>  #define HUNG_TASK_LOCK_BREAK (HZ / 10)
> +#define SECONDS 1000

We have #define MSEC_PER_SEC      1000L

> @@ -44,9 +45,14 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
>  unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
>  
>  /*
> + * Zero means only use sysctl_hung_task_timeout_secs
> + */
> +unsigned long  __read_mostly sysctl_hung_task_timeout_millisecs;

Why not:

unsigned long  __read_mostly sysctl_hung_task_timeout_msec = \
		CONFIG_DEFAULT_HUNG_TASK_TIMEOUT * MSEC_PER_SEC;

> @@ -108,7 +114,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  		t->last_switch_time = jiffies;
>  		return;
>  	}
> -	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
> +
> +	if (time_is_after_jiffies(t->last_switch_time + (timeout * HZ) / SECONDS))
>  		return;

We have msecs_to_jiffies() which handles the rounding properly for you.

> -		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> -		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
> +
> +		pr_err("INFO: task %s:%d blocked for more than %ld seconds %ld milliseconds.\n",

I'd use "%ld.%0.3ld seconds" ... or whatever the right format string is.
I have to work it out every time.

> +			t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
> +			(jiffies - t->last_switch_time) % HZ * (SECONDS / HZ));

... and again, use jiffies_to_msec() to get the rounding right.


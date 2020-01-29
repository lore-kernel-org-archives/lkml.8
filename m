Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F330420702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZVXY/r+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA2WTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:19:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38936 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgA2WTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:19:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so376759pfy.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 14:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O3TiciWiwwK058w7XwXNGwARhLlgPQ6fF5uUmz3hDNg=;
        b=ZVXY/r+ShX4Zivq4Z3I92ZVcd9Q7yKQCKt5uLMSe1JV6beO0vhHafVP6G8W7GVtlj7
         U3yclnWmQQtKtgAPvzOkPgwlFTllAuYDCWVVSps74/ea10Rwiiihy3lQGy+MloFQptD7
         4xlu5FXqZ+G3ITsL8ifb2SZWTgFScovf/OT2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3TiciWiwwK058w7XwXNGwARhLlgPQ6fF5uUmz3hDNg=;
        b=Ui2NeuN+j6S1OOCdBcm6VLINRJzqn6G9Byb02YUCTwmCXxWMSkJYaRlXyQ64FTOX4D
         tafClGj2/qNutd3UsJ67p4JumVpKawBaEafTOOjqqt83qpe2YN70MoB89PKy3fkPPkAe
         IznpveZvSlDU6Xe0wGqo6fEEZza7wUKCqGJEsvlm9JJBQyQ+LwlFl3FYReudCo+1hD3C
         u0DBf80Rl63jJ4z4Zst77L6LV7VL2k7VZ4Xtzs8EbNppkd48zzuyRVcqdvMfN9kiAAgb
         NfBm8CqY0V58iUiUYGCDqLQMfIdiSWK68tlIYUEBEO1mrQNP1UNo0LEEkoMqqFHg9Dox
         GbWw==
X-Gm-Message-State: APjAAAXTHEKDIYkPxCeLuHRY5WgeeZOKSGZaNOctIXdSt6v4QK601Dxz
        H8atTAHkDbv8zqRM96bJ2DvV6w==
X-Google-Smtp-Source: APXvYqwMu5y/wTdfADHxCBrK+vWTaIAyop18k8T0NxA/phdbf6TsWaAzC3FXZ2QAR/E8I9/J547EFA==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr1278832pgt.432.1580336380030;
        Wed, 29 Jan 2020 14:19:40 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h11sm3660407pgv.38.2020.01.29.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:19:39 -0800 (PST)
Date:   Wed, 29 Jan 2020 17:19:38 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/2] events: callchain: Annotate RCU pointer with __rcu
Message-ID: <20200129221938.GA71381@google.com>
References: <20200129160813.14263-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129160813.14263-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 09:38:12PM +0530, Amol Grover wrote:
> Fixes following instances of sparse error
> error: incompatible types in comparison expression
> (different address spaces)
> kernel/events/callchain.c:66:9: error: incompatible types in comparison
> kernel/events/callchain.c:96:9: error: incompatible types in comparison
> kernel/events/callchain.c:161:19: error: incompatible types in comparison
> 
> This introduces the following warning
> kernel/events/callchain.c:65:17: warning: incorrect type in assignment

Would have been nice if you mentioned the warning is fixed in your second
patch. But I think its ok.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  kernel/events/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index c2b41a263166..f91e1f41d25d 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -32,7 +32,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
>  static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
>  static atomic_t nr_callchain_events;
>  static DEFINE_MUTEX(callchain_mutex);
> -static struct callchain_cpus_entries *callchain_cpus_entries;
> +static struct callchain_cpus_entries __rcu *callchain_cpus_entries;
>  
>  
>  __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> -- 
> 2.24.1
> 

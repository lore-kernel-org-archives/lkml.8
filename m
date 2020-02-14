Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84291C3B1B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583A220873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlN8Rr9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405313AbgBNSUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:20:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgBNSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:20:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so4990187pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErA6jWmmhfb1QGDKOQtEER5Ilc0UgOh2Gqv2PGMN0HE=;
        b=AlN8Rr9wAt7e/JdQ398Ln/0Pgz9LEQu52lKml03hoYL+Kej1LX1Cr4EeA10Qe8zdrP
         RK5SP9i2jYx35aykVGR2g/0onBcpFUJNpFwV4ymCb2LK76xcOP9aPMs6fRWoa5WdtKQd
         0lbSub1/AJjFLlTVC6kAYd/C/yWF/VPZ9UVBw4Dxnn1dVhBoMDo0d09btXNlKci2LOb3
         TONpvgLieMjffTOazxw56KMEaMYiO5AfO5eZKVow4wKVjpBiKetJn4EUQoKoyYoQbL30
         ldK/cUpZwYrhB+k/33T0vmnMq6nS5FeADc4EdcgS/WPWtsgWAw88v+i2+w59r7ob/irL
         7HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErA6jWmmhfb1QGDKOQtEER5Ilc0UgOh2Gqv2PGMN0HE=;
        b=g0X0LuqhjHE71Gr+Q7uifXSAZkzmKzbpfT3vVUtjEqkjgsF3BsoLVZ294aLUuJ5TRk
         dk0FgPzn/lblf/da1rDYhlX4zpASX+AFOJbRaTTe87q+y/FV+bl7i7NBEFl+laYijSwp
         q16LUK3ZOy+5bR+cAqXv9lmjzHe+3qh61iKzTTqQomNNKxd2sGlri86kv7u+liGfKFlP
         mpdYA4VeLzDT54qA1y2qsUatLatFeIc5AWfUNH+azUz0HAtTECUq9kw6Bz46HWoAH/+M
         mWuW8rYAZyKj3ncf1eLLIRsz+zQU+tbAXLCnzTXkZjsj1LhUlRw7Iqa/dTb+kiVAf7wZ
         P+/A==
X-Gm-Message-State: APjAAAVjC5l3epf/bvh3dYpsi89qVH7uuMY9q189BeTltl5d63GBWDZL
        WnvqYq2sOxvX6ESI+t84hrk=
X-Google-Smtp-Source: APXvYqxRukUjTxlNcRdQc6EB6yehiYsWGKukYpYn476AdEmv6xHv+atjQeeskaxXJY1Etjlq4A58CQ==
X-Received: by 2002:a63:3712:: with SMTP id e18mr4918078pga.316.1581704436575;
        Fri, 14 Feb 2020 10:20:36 -0800 (PST)
Received: from workstation-portable ([146.196.37.246])
        by smtp.gmail.com with ESMTPSA id o11sm7196634pjs.6.2020.02.14.10.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:20:36 -0800 (PST)
Date:   Fri, 14 Feb 2020 23:50:27 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] callchain: Annotate RCU pointer with __rcu
Message-ID: <20200214182027.GB15350@workstation-portable>
References: <20200130141818.18391-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130141818.18391-1-frextrite@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:48:19PM +0530, Amol Grover wrote:
> Fixes following instances of sparse error
> error: incompatible types in comparison expression
> (different address spaces)
> kernel/events/callchain.c:66:9: error: incompatible types in comparison
> kernel/events/callchain.c:96:9: error: incompatible types in comparison
> kernel/events/callchain.c:161:19: error: incompatible types in comparison
> 
> This introduces the following warning
> kernel/events/callchain.c:65:17: warning: incorrect type in assignment
> which is fixed as below
> 
> callchain_cpus_entries is annotated as an RCU pointer.
> Hence rcu_dereference_protected or similar RCU API is
> required to dereference the pointer.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Hey Peter,

Can you have a look at this patch as well? I have already done the
requested changes.

Thanks
Amol

> ---
> v2:
> - Squash both the commits into a single one.
> 
>  kernel/events/callchain.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index c2b41a263166..a672d02a1b3a 100644
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
> @@ -62,7 +62,8 @@ static void release_callchain_buffers(void)
>  {
>  	struct callchain_cpus_entries *entries;
>  
> -	entries = callchain_cpus_entries;
> +	entries = rcu_dereference_protected(callchain_cpus_entries,
> +					    lockdep_is_held(&callchain_mutex));
>  	RCU_INIT_POINTER(callchain_cpus_entries, NULL);
>  	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
>  }
> -- 
> 2.24.1
> 

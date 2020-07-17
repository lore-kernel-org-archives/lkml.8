Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C013C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2712070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHrhcfR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGQWHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGQWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:07:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3EC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:07:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so14382185ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiQfWs2fx3fTrwDphEBcfgKpdcsXpv0sGShDJM5qgag=;
        b=CHrhcfR82O/MGzzydIaFdR9XnOY9G0ooAH9zBg5JEOJtXSbYcfVy1RpB7slVor3Iiu
         aLKxmtIvHuThka5LePJOtibm3JkQ7SFrK2xt0rJRqXYossWIDqy7m8ff2/qbfNOJLgfx
         /ZEZHLWHLrtdNfOn2Q/H4mIkpcQxS0DlP7SqvLz50PQnc09+Di2nXm3wfHvsSDvzKcLY
         Uc7ZagUataa9ShXN0qzE/GvRdiLJDVQ+aQAL2a4bwuPz6uXTf7DwQiQXais414y+W7H0
         /73bLFuexssba5r2xbGNV1L9i0dDvVcOvabsa8t9sSKwUwY1wh+/x8zT2UoaKYAlXVdx
         vD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiQfWs2fx3fTrwDphEBcfgKpdcsXpv0sGShDJM5qgag=;
        b=bkHeuFUu1OZJfojEfWmVv0GZ8wsCEFYML88C+NYzSRAjBUeSDgu1/8x3gN0bZxi54V
         /+mCxlGqoIRBHNXBTLfzHZPgOah8/zbObQWmZnKh4z3rmlsHkt/yAZnxuI0obwxymJEB
         B6RKs9MkWPE1Nrne+LEarsY8rsh411vIKtaxTjygvio39zZWmHA5BcUDoI2JMQX3aQee
         S8vm00FxgEjJZDSyDhLbxqBV82daLlwoUEE6GUFZbhvJw9V6eIlHRUXdCU/0ha0bi4Uw
         QV09XWJZ7V/VQ6ogamsoHOXmatRwOjN62NJwVwwqAELlMhh5S8EpZSh94frUAYyKLNYp
         HELw==
X-Gm-Message-State: AOAM5334aGP6jdNsRBq3FQhAgaAXYx6GMTtLMiKIwpx/VP0d3fZh2hKV
        hfTpo+IMmX0m6BDzBfMJ3z8=
X-Google-Smtp-Source: ABdhPJxSd7aw6UiiOYFBx1s0MVsBWBX8RrAXiShaj/TnopGC3um/9qeojJR8yT5azlicgopi6/vKEg==
X-Received: by 2002:a2e:b702:: with SMTP id j2mr4997586ljo.354.1595023658107;
        Fri, 17 Jul 2020 15:07:38 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d22sm1315952lfs.26.2020.07.17.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 15:07:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 18 Jul 2020 00:07:35 +0200
To:     qianjun.kernel@gmail.com
Cc:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [RFC PATCH 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200717220735.GA5965@pc636>
References: <1594967873-29522-1-git-send-email-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594967873-29522-1-git-send-email-qianjun.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: jun qian <qianjun.kernel@gmail.com>
> 
> When get the pending softirqs, it need to process all the pending
> softirqs in the while loop. If the processing time of each pending
> softirq is need more than 2 msec in this loop, or one of the softirq
> will running a long time, according to the original code logic, it
> will process all the pending softirqs without wakeuping ksoftirqd,
> which will cause a relatively large scheduling delay on the
> corresponding CPU, which we do not wish to see. The patch will check
> the total time to process pending softirq, if the time exceeds 2 ms
> we need to wakeup the ksofirqd to aviod large sched delay.
> 
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/softirq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c4201b7f..602d9fa 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -299,6 +299,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  		}
>  		h++;
>  		pending >>= softirq_bit;
> +
> +		if (time_after(jiffies, end) && need_resched())
> +			break;
>  	}
>  
>  	if (__this_cpu_read(ksoftirqd) == current)
> 
I have a small concern about MAX_SOFTIRQ_TIME. The problem is that
an "end" time is based on jiffies/tick update, so it depends on CONFIG_HZ
value of your kernel.

For example if we have CONFIG_HZ=100, msecs_to_jiffies(2) will return 1.
For HZ=100 one jiffie is 10 milliseconds. So we can not rely on it,
because of low resolution.

Maybe it make sense to fix it first in order to be at least aligned with
"2 milliseconds time limit" documentation?

<snip>
 * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
 * but break the loop if need_resched() is set or after 2 ms.
<snip>

ktime_get()/ktime_before()...?

--
Vlad Rezki

Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0366C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5C2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596732936;
	bh=xGt61VXl0JXC+OP2QjtwWPAk9TtHHrvDaRrvwx763jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xmX77g6AmxBWIPw96ihqO74I203GMhhGQXG+4wxcskf50FU6rPlRjDBMbLo7B3dpn
	 q7RTIIDNUoAqonh6fukm+wTHnfqDhqJRafEVQY0HOYigbMud5fU9fp3mF+c7WvkORA
	 wdbJF7bxKiY3zrDwiUM0l5H04rAfTL4iVGOtdW1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgHFQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgHFQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:55:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5264FC0A8895
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 07:45:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c15so25673405edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yYVuBVabzbzwKa6QXgVhZky/17L0x8BFmX65otxgpTI=;
        b=XKYy8IuTF3Kcgk3+NCYYk35dOiKkzZQpswgbR1Z8aRUyW1omIB1koVTJMQuWvGhaXy
         a6OYG1ElcCAB9PTbfxkN8JSQIcOm+XE9iOXVVpivKdIpHXNgX3kB4u67mISjzca5SHr1
         4ucC8ReziEal1HCTrJMjqgRmxpe9+OPxsDiZgmZSXimlQk2mzNQHMElHjjaZGTFv+PY2
         b/HT8N9QsacZGbpFmYW62YPcFv5t63jz7oX73Nnm1jYM83izwZNT2a6jO+Slzn7BbvRH
         3lA1+DWNmuVI3rFKxc031YQ8MNdEs1nn0IUVz/ngVR9McQKwE5EYzA4NltBlsdic2Hp9
         uvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yYVuBVabzbzwKa6QXgVhZky/17L0x8BFmX65otxgpTI=;
        b=QwoI2KVcFLrJxu06k0gA942QxUgk/z6e0PMFUt9E4uSSjs13Tg7i59Gtyr2VJujpw6
         gidpJCbl9lwd4eH2NtYvJ20sw7qpPS83M8ceWgdklc7Dd3e3/mmuZjaBztAcSveBj+5W
         UArz3aR8Q+CWgxiI2OIE6LMsy8YpJIRlCP908f5PCnNRKY2g+Ke9Ed4oJZ6D2LtGUqWg
         ZWqcgYGWQtWC6JAII804eYGZNN4NdsE+y4yeo5JTJ6UtXxw+R3SMMx34V3YX59ixsIZW
         2LDsZ7i0eIH7VY8sayMm4JyNJL3ShsqyaU7b7zmSmVoWuzv8xS604DASx8V7GauEKn0y
         E0lw==
X-Gm-Message-State: AOAM531aNU7h+fOeXkN7U/e51Ax7ykpW9uWfTucVfPmagLSxTppjtrd+
        oz9P2dis8clh1QwC4yQz2kE=
X-Google-Smtp-Source: ABdhPJy5Adtz5OUMX+QruORlC+ggIIh8g6p8eKEuoHSCOc/OlOCUCLa/ueOHhp5KbtbGCX5wiwmflw==
X-Received: by 2002:aa7:c697:: with SMTP id n23mr4310500edq.50.1596725136036;
        Thu, 06 Aug 2020 07:45:36 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i5sm3648201edt.52.2020.08.06.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:45:34 -0700 (PDT)
Date:   Thu, 6 Aug 2020 16:45:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: add unlikely in group_has_capacity()
Message-ID: <20200806144533.GA2123716@gmail.com>
References: <20200730135423.232776-1-arch0.zheng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730135423.232776-1-arch0.zheng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qi Zheng <arch0.zheng@gmail.com> wrote:

> 1. The group_has_capacity() function is only called in
>    group_classify().
> 2. Before calling the group_has_capacity() function,
>    group_is_overloaded() will first judge the following
>    formula, if it holds, the group_classify() will directly
>    return the group_overloaded.
> 
> 	(sgs->group_capacity * imbalance_pct) <
>                         (sgs->group_runnable * 100)
> 
> Therefore, when the group_has_capacity() is called, the
> probability that the above formalu holds is very small. Hint
> compilers about that.
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2ba8f230feb9..9074fd5e23b2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8234,8 +8234,8 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>  	if (sgs->sum_nr_running < sgs->group_weight)
>  		return true;
>  
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> +	if (unlikely((sgs->group_capacity * imbalance_pct) <
> +			(sgs->group_runnable * 100)))
>  		return false;

Isn't the probability that this second check will match around 0%?

I.e. wouldn't the right fix be to remove the duplicate check from 
group_has_capacity(), because it's already been checked in 
group_classify()? Maybe while leaving a comment in place?

Thanks,

	Ingo

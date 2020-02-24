Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C9C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCF62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582557407;
	bh=EZfbob6DqP1Mxfcyil8FcnNZTorQqzCvSKib1Ins734=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SOmRYUvOZm4p4CTVuDT85sVkXyyeAwRlt+ZTZjBTrd5241CPFyouAxEhN2CvkQ5SR
	 d5OBcvvepTdPItYXuDTRFLeMq0blV+m7L10raWE1jwQYbQLGIgbpP/yc6bsNNVe+YM
	 bPH6SmWwzwn2BnxzhrYPDv2c34ijrpUgzBP6+3gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBXPQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:16:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34972 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:16:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so9815375wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqVvyjr72l7GvXkRWMW7L0FSrdJA85t6oDGifsmwlm8=;
        b=l+4AxzNapEhq9AsxW24XIMk6YIdoEzrG5Nk8ElQPjS15clqXQvbTNzg4F8uUe9IrVa
         B3AmniB+0m8QrRYamEQ9AU8Pe9Bwi+dVVBlWFHhtopYo4oQyV+ZG0mlHLpX4UHZUpkWv
         RGfeV+C0cO/W/ZdEvAlS+WyAW2QAXIJfkVN9oyC7o41BIWF7hqm6wPXQ4ZlwQ4BqyNog
         +C29/Zt5BuYe23/ZiCp7L24NtdqfM1lsp1oKD+D5KRy7dA0EWqBaAqWQiJ6F3ZKOnZoX
         U2UEpxh0RMNVi9KzqSmvbGHqY1YJdCS5iqSWY7zIhnd/arRQ0IAON38amuVctYWCNP3P
         UfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqVvyjr72l7GvXkRWMW7L0FSrdJA85t6oDGifsmwlm8=;
        b=FngKYnFWhiksIFReJvGn/2Yxl/zEGvLGjJ3IMwbnE5MuwlfDQv/3hYH4csJ+RKkHZt
         o5wlxSPvr4ZFHlYQl5WLs2Azsvy2NGA6f25TqgOUBGNQgS2Wz6TdgKJvnaLaky2KTDNl
         xEqkoPpFAMqIwC6LlEhATDAX71dB1+mE/hqAGokvbWu+izvyCGxu0OFidLtSl8HIUic0
         /s/xvLi1zv8BRL/zwaVQvbFlsflSMHQpI+UXhRbfuA2SymzB+zR5hEhaZbydmMkSMuzP
         dH/0L2IgHRWiF5Ocvy7LLPUXxApV8zsESKGrs86zVyiz/HMYZl3UL/fQw5C7uop/TpSz
         DxyA==
X-Gm-Message-State: APjAAAUZSTe23kJxqrIB72Sk1OLDNgZonNZmwzifBNxu8fM6ScLV/VCp
        Dik0JljHSNsS6uBHtSJYPss=
X-Google-Smtp-Source: APXvYqxcuahIGIZddPtvRNsIsiwnGqPIO9L1692MF0AMkZYpVJBZ/4tvXWJsj/yV8RrZsedWOd4tuA==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr22753769wmb.186.1582557404074;
        Mon, 24 Feb 2020 07:16:44 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i204sm18539040wma.44.2020.02.24.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:16:43 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:16:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200224151641.GA24316@gmail.com>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224095223.13361-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> The only differences in V6 are due to Vincent's latest patch series.
> 
> This is V5 which includes the latest versions of Vincent's patch
> addressing review feedback. Patches 4-9 are Vincent's work plus one
> important performance fix. Vincent's patches were retested and while
> not presented in detail, it was mostly an improvement.
> 
> Changelog since V5:
> o Import Vincent's latest patch set

>  include/linux/sched.h        |  31 ++-
>  include/trace/events/sched.h |  49 ++--
>  kernel/sched/core.c          |  13 -
>  kernel/sched/debug.c         |  17 +-
>  kernel/sched/fair.c          | 626 ++++++++++++++++++++++++++++---------------
>  kernel/sched/pelt.c          |  59 ++--
>  kernel/sched/sched.h         |  42 ++-
>  7 files changed, 535 insertions(+), 302 deletions(-)

Applied to tip:sched/core for v5.7 inclusion, thanks Mel and Vincent!

Please base future iterations on top of a0f03b617c3b (current 
sched/core).

Thanks!

	Ingo

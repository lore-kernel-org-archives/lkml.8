Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DE20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vo8i1Ula"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgDTRy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgDTRy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:54:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54069C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:54:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so181860pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dqBfsWyyq6t+6bMO2rN3e4SQjTW8qN7uhnhzkb+nlXQ=;
        b=Vo8i1Ula+LDWLFAN3KAehusRllfgEMmALbrfGQ6iINBwlNcubu8avcT/yFM7gsRYDD
         OEZca8VnLvTHrzyGtWLRvJg7NzGn+Ia0gxTajmLnwptKW5aXO16/s0go/fjDnLO94FAi
         +Ph+3+3qHmsPaB4BEqikfdg6v1If0v1UqWoB8F8v3z/35F/VeD3WhyoOAsRWQsZlN3op
         rPO/Pap2T699qK5Msjh3zPTcTHXUS8Hg/JcAWemudVLsJqYcICWf5475AS0yZY3dWP+p
         vEJrwZFYyOTwGjuBjB0i+0GCR6ihdzddEMJEZS6+/DH/YwhVtyuiAhotEH2wegfTKVij
         OXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=dqBfsWyyq6t+6bMO2rN3e4SQjTW8qN7uhnhzkb+nlXQ=;
        b=uMLOuLqenqp+ge7fXfFxwx2FjrAxAJmfn3TfwJlLNLXGCs906CHLGt4daMVvT7sWfO
         Cz4H0XbTFjP4Fl0RB/S1BZVPo+GhPQcZf/UX6Q9G3TwgWXudKUinYCIFeb87gB+czaW5
         oMjS90W2Z/mWS+Lmb9SnBbsMcm6C7BarP7AqVxOb3dQ9QFz5dcBn0oiEPxBDmLUNcw5c
         MkXIa7wN4nlH0Js0qLLliGACnbkbwaw9vD2rmKP4FCR5crEoabWcqdALUMPSaPTP1bPR
         z0gTUJ+oPofd4mTlhjLlMGA+j3qSRrjZi0VAGRDlJz/GB2k8xHyeQC3DFkpe82KBE7je
         e6Hg==
X-Gm-Message-State: AGi0PuaAFHGp2++84wnqtGo2yTPST7KfEKaBmrMGNom1CkzBQhSCIBNn
        AwObHmTMC4VwkE3PBgb9WTvj0Q==
X-Google-Smtp-Source: APiQypL/Ib90fCwKSXKE2wwBq+tfYWAr8jA0rrQdW0R/fMnB7BrLC8h/A2UVjlSwUFHmxLJBddczlA==
X-Received: by 2002:a17:90a:eb05:: with SMTP id j5mr645942pjz.86.1587405295702;
        Mon, 20 Apr 2020 10:54:55 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id e29sm1686062pgn.57.2020.04.20.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:54:55 -0700 (PDT)
From:   bsegall@google.com
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org, pauld@redhead.com
Subject: Re: [PATCH 2/2] sched/fair: Refill bandwidth before scaling
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
        <20200420024421.22442-3-changhuaixin@linux.alibaba.com>
Date:   Mon, 20 Apr 2020 10:54:53 -0700
In-Reply-To: <20200420024421.22442-3-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Mon, 20 Apr 2020 10:44:21 +0800")
Message-ID: <xm26wo6akpoy.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaixin Chang <changhuaixin@linux.alibaba.com> writes:

> In order to prevent possible hardlockup of sched_cfs_period_timer()
> loop, loop count is introduced to denote whether to scale quota and
> period or not. However, scale is done between forwarding period timer
> and refilling cfs bandwidth runtime, which means that period timer is
> forwarded with old "period" while runtime is refilled with scaled
> "quota".
>
> Move do_sched_cfs_period_timer() before scaling to solve this.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Fixes: 2e8e19226398 ("sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup")
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..9ace1c5c73a5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5152,6 +5152,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  		if (!overrun)
>  			break;
>  
> +		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
> +
>  		if (++count > 3) {
>  			u64 new, old = ktime_to_ns(cfs_b->period);
>  
> @@ -5181,8 +5183,6 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  			/* reset count so we don't come right back in here */
>  			count = 0;
>  		}
> -
> -		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
>  	}
>  	if (idle)
>  		cfs_b->period_active = 0;

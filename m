Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA696C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978AD20825
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="bLOzNR/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgEUM6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgEUM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:58:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:58:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so8672622ejd.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zE0q+anVt0YABBKa0iOm9d1qeItC3z2sLcxqGncBVQI=;
        b=bLOzNR/s9S7I+d6/VAHg3FcIB91TnIH4PTsQDruoSc+fbSfnEh3cUbmsQecHLhLaOX
         4vj+ItRpXsQBcQkYDtk35GJ237GUVOK950cf+h6475GY+7lSmLi/9YcoCmEDa9fwkyN1
         veDn1mKKC0Xc4FQ/FjilKO0iTyrz98Xo8C16s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zE0q+anVt0YABBKa0iOm9d1qeItC3z2sLcxqGncBVQI=;
        b=XZmTU3JrIJnFmuE8Rt3B76lF1H3mnGiB8Xejny9yDm866b2N9vzc34gAKjBDCrBDz2
         JLASzUcYduRtnohbBI2qzR6Lfrb235D7cs5xDD4YpIDdjJwv1weQntl2qzov5BPt+wh5
         2I/tXDoznUsNvAwdnqYBtqBqjzlSwit3XV5oc48QW5dRHj7V8zpAS/mZBDK+oXqByX74
         rWWUzVB86t6mI3Z2e6+iTizmUgn5un5HhiJfcM1G5DVy7vySaJd7RynOJte86s8y8qqP
         fWi8tmjCyhEIfOU4j/YlfQNHkwr2sFPDs5K2YTSwl9JBvzuUthugu++NfrePp1p/5h/o
         FCpg==
X-Gm-Message-State: AOAM53126Mwg+AEEAxiR18yBkPM5QiqU//5QDjETkcJ+nGRkEULnf17I
        rZf3xHipJfRT3xxlQtoTJ+VQfQ==
X-Google-Smtp-Source: ABdhPJwUlPCcc8nSFDOxIqSfKdRpccOkuvlBZZUOzHd1MhWNz7hN6UxMTNyjgr9XgEoNGyCUvOKvaA==
X-Received: by 2002:a17:906:ae18:: with SMTP id le24mr3597119ejb.155.1590065880626;
        Thu, 21 May 2020 05:58:00 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id o2sm4806631eja.68.2020.05.21.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:58:00 -0700 (PDT)
Date:   Thu, 21 May 2020 13:57:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521125759.GD990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521123742.GO6462@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>> A cgroup is a unit and breaking it down into "reclaim fairness" for
>> individual tasks like this seems suspect to me. For example, if one task in
>> a cgroup is leaking unreclaimable memory like crazy, everyone in that cgroup
>> is going to be penalised by allocator throttling as a result, even if they
>> aren't "responsible" for that reclaim.
>
>You are right, but that doesn't mean that it is desirable that some
>tasks would be throttled unexpectedly too long because of the other's activity.

Are you really talking about throttling, or reclaim? If throttling, tasks are 
already throttled proportionally to how much this allocation is contributing to 
the overage in calculate_high_delay.

If you're talking about reclaim, trying to reason about whether the overage is 
the result of some other task in this cgroup or the task that's allocating 
right now is something that we already know doesn't work well (eg. global OOM). 

>> So the options here are as follows when a cgroup is over memory.high and a
>> single reclaim isn't enough:
>>
>> 1. Decline further reclaim. Instead, throttle for up to 2 seconds.
>> 2. Keep on reclaiming. Only throttle if we can't get back under memory.high.
>>
>> The outcome of your suggestion to decline further reclaim is case #1, which
>> is significantly more practically "unfair" to that task. Throttling is
>> extremely disruptive to tasks and should be a last resort when we've
>> exhausted all other practical options. It shouldn't be something you get
>> just because you didn't try to reclaim hard enough.
>
>I believe I have asked in other email in this thread. Could you explain
>why enforcint the requested target (memcg_nr_pages_over_high) is
>insufficient for the problem you are dealing with? Because that would
>make sense for large targets to me while it would keep relatively
>reasonable semantic of the throttling - aka proportional to the memory
>demand rather than the excess.

memcg_nr_pages_over_high is related to the charge size. As such, if you're way 
over memory.high as a result of transient reclaim failures, but the majority of 
your charges are small, it's going to hard to make meaningful progress:

1. Most nr_pages will be MEMCG_CHARGE_BATCH, which is not enough to help;
2. Large allocations will only get a single reclaim attempt to succeed.

As such, in many cases we're either doomed to successfully reclaim a paltry 
amount of pages, or fail to reclaim a lot of pages. Asking try_to_free_pages() 
to deal with those huge allocations is generally not reasonable, regardless of 
the specifics of why it doesn't work in this case.

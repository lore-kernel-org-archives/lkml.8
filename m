Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68012072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="WUx7EMZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgEUOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbgEUOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i16so6775814edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXVdafa9z18urmVF3KS9w5IeKlLTrJcs4nowtAYCuh4=;
        b=WUx7EMZXoTwxert//L8QB2qHfWrZiacoi76OCdMTNyuay8JGMq6fWNmQj0SQnbRFEh
         WRh1UcI6g53+15lQHxMx26j8V4Gxuc5gDqobeFXzjZDMWfdl3fkdcoRgn0v8vArqtsrt
         1Vv1WER8yCs5NkdKv+KCn0M/GlQDXzUtCKOAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXVdafa9z18urmVF3KS9w5IeKlLTrJcs4nowtAYCuh4=;
        b=G/0FHrvnq9uiFWs/g/dF04OhTrZjRKqHFdifv19+Ql6xuQTyvr0ZsErAPGkn+/fLzw
         8CcYI+DZptNPGg/Jv7c6m5W2Q2xb7q9l0/PrrpTWGqaXrJQDTTtosaDRcyutNOANHXTo
         eFG36AcXTqScDrfGG2Fi2SqKZ4ijJV9t91SFKCfhbgmouKjSY8O/k4HQSYx/GMY2jV0o
         0BmzjGM37/KiQ9l+I03ZHdRLiteRSuWNWh6POpo/faNlGOb/Q8mJN5Ez0K7J6f7gMRbQ
         bTZvvVjBcukRfb27rQM8q7QD1UfJfDJTtHgPJWrnETPnnj7g4cr5+ZI1k+TmEf4DIh5d
         Lxew==
X-Gm-Message-State: AOAM533O9LeOcdkOSS5/RF9eMpI5kar8G0hlNOVasT0LdQ3L5jfewcwU
        gCOwVdwyhC2ePyKXQ76LG/mGVQ==
X-Google-Smtp-Source: ABdhPJy8mfT4IP25yMwlh6TstUIzlUkg7uNP8ZDxoGoGuZc54HVQpdqG/mu217uXfwgIu/hzemCzXA==
X-Received: by 2002:a05:6402:1c0e:: with SMTP id ck14mr8165813edb.356.1590070947093;
        Thu, 21 May 2020 07:22:27 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id i2sm4588656edy.30.2020.05.21.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:22:26 -0700 (PDT)
Date:   Thu, 21 May 2020 15:22:23 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521142223.GG990580@chrisdown.name>
References: <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
 <20200521132120.GR6462@dhcp22.suse.cz>
 <20200521133324.GF990580@chrisdown.name>
 <20200521135838.GT6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521135838.GT6462@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>On Thu 21-05-20 14:41:47, Chris Down wrote:
>> Michal Hocko writes:
>> > On Thu 21-05-20 13:57:59, Chris Down wrote:
>[...]
>> > > If you're talking about reclaim, trying to reason about whether the overage
>> > > is the result of some other task in this cgroup or the task that's
>> > > allocating right now is something that we already know doesn't work well
>> > > (eg. global OOM).
>> >
>> > I am not sure I follow you here.
>>
>> Let me rephrase: your statement is that it's not desirable "that some task
>> would be throttled unexpectedly too long because of [the activity of another
>> task also within that cgroup]" (let me know if that's not what you meant).
>> But trying to avoid that requires knowing which activity abstractly
>> instigates this entire mess in the first place, which we have nowhere near
>> enough context to determine.
>
>Yeah, if we want to be really precise then you are right, nothing like
>that is really feasible for the reclaim. Reclaiming 1 page might be much
>more expensive than 100 pages because LRU order doesn't reflect the
>cost of the reclaim at all. What, I believe, we want is a best effort,
>really. If the reclaim target is somehow bound to the requested amount
>of memory then we can at least say that more memory hungry consumers are
>reclaiming more. Which is something people can wrap their head around
>much easier than a free competition on the reclaim with some hard to
>predict losers who do all the work and some lucky ones which just happen
>to avoid throttling by a better timing. Really think of the direct
>reclaim and how the unfairness suck there.

I really don't follow this logic. You're talking about reclaim-induced latency, 
but the alternative isn't freedom from latency, it's scheduler-induced latency 
from allocator throttling (and probably of a significantly higher magnitude). 
And again, that's totally justified if you are part of a cgroup which is 
significantly above its memory.high -- that's the kind of grouping you sign up 
for when you put multiple tasks in the same cgroup.

The premise of being over memory.high is that everyone in the affected cgroup 
must do their utmost to reclaim where possible, and if they fail to get below 
it again, we're going to deschedule them. *That's* what's best-effort about it.

The losers aren't hard to predict. It's *all* the tasks in this cgroup if they 
don't each make their utmost attempt to get the cgroup's memory back under 
control. Doing more reclaim isn't even in the same magnitude of sucking as 
getting allocator throttled.

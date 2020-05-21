Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB212072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="mVLBa0Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgEUNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEUNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:41:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2FCC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:41:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l21so8873670eji.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xV51Tcrf9NcqZbm5wUPmCudngXiKCmzHzaVIGwxSLX0=;
        b=mVLBa0YkwB4qr/nGUx3mTqt/IBNkDYMevgIGIDvGXl6mMe9hC/iNBgUGd5KNQhW1C2
         9VRaEeFAhHWBGnn62P2YYa9mMqk5yFn72KsrQrJt2qlo1uogjLnYcd8FWbScxgkMXJYD
         LjLNQZqXCO3CrKOtpR884DuapuK4oJipI1hO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xV51Tcrf9NcqZbm5wUPmCudngXiKCmzHzaVIGwxSLX0=;
        b=bWt6JZn2Zfa0OSpOe4XoaP2g7NuQQg+scARIYYew1xOulX5sW9UPfe/msbnpgds1pP
         bXxBEhRaJSRRoinZwWXOzx2Abp+uUzd50Lxo3imksqoajcbAQALrD+gE6ym70nyDsahm
         Or/gaoDMVQSlm6Kgr3VEt4Pi17bYpZ/Mlj2JCvZzEpOE6/ZBfZNfAfFycZfgrQiUbm9o
         dPkkhJj5BMxAeaN2PuYFusUhf6Ql4WJ4YcQl+wM9JXbSugFe4m3TrQ22LQCh1ZK87eXc
         XwmQcNvgK42ROzbFutLMR/S37vQycKm6dnHF9TeC9Yrv4RNJKoyJS2n6mCcdMDSoSUZu
         PbuQ==
X-Gm-Message-State: AOAM533noQxnXWrAHLxgBrc9ECn5Ltz2WghgmaPb7xA+bdv5cMLMFhhp
        jhh0c75AJIk9uVYlZYEHw74EoA==
X-Google-Smtp-Source: ABdhPJyPmqgON7ZwGWSaHZxJk6nAVtW7JFpeftFSfh6aqvslRE6WSSH/itVmXPZpIv9jK/4agLflLg==
X-Received: by 2002:a17:906:edd3:: with SMTP id sb19mr3469182ejb.39.1590068508871;
        Thu, 21 May 2020 06:41:48 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id f24sm4741685edq.21.2020.05.21.06.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:41:48 -0700 (PDT)
Date:   Thu, 21 May 2020 14:41:47 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521133324.GF990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
 <20200521132120.GR6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521132120.GR6462@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>On Thu 21-05-20 13:57:59, Chris Down wrote:
>> Michal Hocko writes:
>> > > A cgroup is a unit and breaking it down into "reclaim fairness" for
>> > > individual tasks like this seems suspect to me. For example, if one task in
>> > > a cgroup is leaking unreclaimable memory like crazy, everyone in that cgroup
>> > > is going to be penalised by allocator throttling as a result, even if they
>> > > aren't "responsible" for that reclaim.
>> >
>> > You are right, but that doesn't mean that it is desirable that some
>> > tasks would be throttled unexpectedly too long because of the other's activity.
>>
>> Are you really talking about throttling, or reclaim? If throttling, tasks
>> are already throttled proportionally to how much this allocation is
>> contributing to the overage in calculate_high_delay.
>
>Reclaim is a part of the throttling mechanism. It is a productive side
>of it actually.

I guess let's avoid using the term "throttling", since in this context it 
sounds like we're talking about allocator throttling :-)

>> If you're talking about reclaim, trying to reason about whether the overage
>> is the result of some other task in this cgroup or the task that's
>> allocating right now is something that we already know doesn't work well
>> (eg. global OOM).
>
>I am not sure I follow you here.

Let me rephrase: your statement is that it's not desirable "that some task 
would be throttled unexpectedly too long because of [the activity of another 
task also within that cgroup]" (let me know if that's not what you meant). But 
trying to avoid that requires knowing which activity abstractly instigates this 
entire mess in the first place, which we have nowhere near enough context to 
determine.

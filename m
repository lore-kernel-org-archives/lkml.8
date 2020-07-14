Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC369C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9252E2236F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="TeT4WtuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGNPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:45:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:45:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b185so16012350qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7U8JsZvgXHH3n8xgxoCLEbRbt6AY8Z+mxAelisJgRw8=;
        b=TeT4WtuDoSJlYSAQH2bV1YMeSx1E6X2BFU8rj0/8YyGh0bErT86/GtYKHAowuaOF6E
         i5sZLU99YAKqeQ4qr4Qp40qynq4yNSyzg1yH0BPltc5IY1ZLrkVQwxI8UTVm3ozseEdy
         5ZkeWdsxPMWs2cvuTkyXFRGoW6rRjLvtArEwKHjtaJEZrrRGsCnu7J5y946a97v7K8xc
         O8xhwzvcMs0lb/N+ymrisTzO4wstCoEc86JTj/YVRRwGUOkVXxACR80FW58sUvUxstgn
         J4rgoTKUsqwoXilNN1i9HA6gtgwsAfe+lhDNrffl8KLuAP0+jQXa9OkWVGhEGjbFqp8/
         6C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7U8JsZvgXHH3n8xgxoCLEbRbt6AY8Z+mxAelisJgRw8=;
        b=NvWTDoxFghjjAwkRVEBBaHCqtEcDgTGOB2Z7zW1lAoxyz3iKOQc1EWHtFjaVpy7tA5
         AEMwJBRh6bkAI9WUI/VTA5Wuy6FX3GqvMmqM9+GL/g9f0fp/xsgWeByZ1HgYUqJumHId
         edFmSkLogtxtCz0hc5SVzXflF96BXuipiISd4Jne23ePlPWCtR6QseNk9nR8rlphc9qy
         ip+BWgwqj6GAASdkuJRB9T+lKogKdRogITqQ9V+jTHrsGAen6oZjAnHa8iF9ioiLARps
         MCV/eVhli4S6KCH6Xe3mx63W93BKZ/OwGSWwkrSySPDEDhXh2DIK2bA8+eyshGWhZiAq
         sBbA==
X-Gm-Message-State: AOAM531a0uw9b42nmsT4aDXQ7YIB7/i+NgWjYvXDbelLe/ZgNLr4rCtz
        j6GwmKRm3doGwF0C7ECHERrSDg==
X-Google-Smtp-Source: ABdhPJwDgYPEzL6yjkDXQkBKQCvfcAKX1idi2WJWmoKy4Y+Sz7jQrn0lIt5Ndq1K+62+h1vAQ0vstA==
X-Received: by 2002:a37:689:: with SMTP id 131mr4805114qkg.468.1594741554235;
        Tue, 14 Jul 2020 08:45:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:81a8])
        by smtp.gmail.com with ESMTPSA id r6sm23081172qtt.81.2020.07.14.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:45:53 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:45:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200714154504.GB215857@cmpxchg.org>
References: <cover.1594640214.git.chris@chrisdown.name>
 <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:42:35PM +0100, Chris Down wrote:
> In Facebook production, we've seen cases where cgroups have been put
> into allocator throttling even when they appear to have a lot of slack
> file caches which should be trivially reclaimable.
> 
> Looking more closely, the problem is that we only try a single cgroup
> reclaim walk for each return to usermode before calculating whether or
> not we should throttle. This single attempt doesn't produce enough
> pressure to shrink for cgroups with a rapidly growing amount of file
> caches prior to entering allocator throttling.
> 
> As an example, we see that threads in an affected cgroup are stuck in
> allocator throttling:
> 
>     # for i in $(cat cgroup.threads); do
>     >     grep over_high "/proc/$i/stack"
>     > done
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> 
> ...however, there is no I/O pressure reported by PSI, despite a lot of
> slack file pages:
> 
>     # cat memory.pressure
>     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
>     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
>     # cat io.pressure
>     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
>     # grep _file memory.stat
>     inactive_file 1370939392
>     active_file 661635072
> 
> This patch changes the behaviour to retry reclaim either until the
> current task goes below the 10ms grace period, or we are making no
> reclaim progress at all. In the latter case, we enter reclaim throttling
> as before.
> 
> To a user, there's no intuitive reason for the reclaim behaviour to
> differ from hitting memory.high as part of a new allocation, as opposed
> to hitting memory.high because someone lowered its value. As such this
> also brings an added benefit: it unifies the reclaim behaviour between
> the two.
> 
> There's precedent for this behaviour: we already do reclaim retries when
> writing to memory.{high,max}, in max reclaim, and in the page allocator
> itself.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C8C43445
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7020738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qu2t9/SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgGMOvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgGMOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:51:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED61C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:51:04 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u25so9226450lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUKZlCYinai0Luu2hOdm2qnhIZ2lqYBnLnpnyrbTn3I=;
        b=qu2t9/SUqzkLaYFEwlQpODBK/nnlgLwz7l2VJYTrR/DC+v3zsZaCKn56tElzWPtcHn
         /Q0rjazMjk+yHC1rwE1i8nQL9hhJXzlcyXtEAtlmk9i3HxETJsnHiDlivYKSIbc56wK/
         8vm0kqjPm0gBZH2MdJQMaQ5byy/UHj4ypCn6Iu2V1CFGE83BYFlgkmJS557gdfQUsRz3
         YCMy6tBmB+wtWOtLsa5DPlxcueem/ZeE7vP6YDeQQ//bYUkOA57A027j5wKUEAQ6LZem
         gCLVAA+bEN8QBxtkQksQwh1Z7ionO2BfUakJra1klkKve+16G5WCJ3i2xVXyCdXj5tKF
         OcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUKZlCYinai0Luu2hOdm2qnhIZ2lqYBnLnpnyrbTn3I=;
        b=t8YAH7KDuToYGGTCHsREwJ7idYGPBfh4v9ovdVDUHcduHjCKIC0t2zB+4iq1L/JBU+
         mNruvLgLt52pCygHVI6Ki0OIbjHJkl6KJi6vxvosKiHaOOd+QXWpsYnoybjxZz8VCSur
         RbB3YU5C3yqpe/qYKXK0HiF4fBhbBAOrcnWKuMs/RZN6dhTZZW/lot2M5CjGMWfa2edi
         es22zGkeyKGEXn02eA9SZIsoY0wyDUlXcAuE5L38t1f+FQRxmkhDmbMDmxlJi4MJ6CfB
         tgytmfHxJRNV828mB0a+UGkVcIOF1KUsAuj4UMRRtszZU9Dxj/O3qVl2Xjai97L/hKr/
         F/jQ==
X-Gm-Message-State: AOAM533CDXpLaUt568upmZyjLXkwJP7Jm8cgZDQc4vvZ1Rh367sWLHPR
        9Y55tKi82ytoFSY0IX2INQv8UttgMJuGvDy4h8pmRQ==
X-Google-Smtp-Source: ABdhPJwNsAK/CvIXssjQkfKmEI8SIz4CvARlnMPg9iz3ip4AYuZHOz+ZuUOX/MXzLaMOcYrwbWlCf5fUMZQ0vnAJXFI=
X-Received: by 2002:a19:e61a:: with SMTP id d26mr47379303lfh.96.1594651862566;
 Mon, 13 Jul 2020 07:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594640214.git.chris@chrisdown.name> <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
In-Reply-To: <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Jul 2020 07:50:51 -0700
Message-ID: <CALvZod5BKXs52A2R-d=aOsjB7idBejsMDgQUKc1H_6y=PuBsew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, memcg: reclaim more aggressively before high
 allocator throttling
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 4:42 AM Chris Down <chris@chrisdown.name> wrote:
>
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

Reviewed-by: Shakeel Butt <shakeelb@google.com>

Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA803C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB53321897
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q98veh9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgEVOIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:08:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8351DC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:08:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so6596525lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASpIJRV1LgbYaIn/8sihf9PSqZ7K//HA8oIfV5Jji1U=;
        b=Q98veh9b1zBp4PWhmCf74WRK0Byrzkwey2rtOIQaXyx1kyEDcG3M6jXlCJOhaNxM5/
         9sj2TOOYHXEwh0fYzQ9FWMZfc0E8eE1/WZ2qrZajc+2KYj6iyYljfm/4TvkU3jkfOFI3
         YYUty1xtwI/bERs9jSMcLkRivOd74V0q8VEyy+weMSJJux6/WgAlmVEJMy5S77lYpI6X
         C4RRVTYaZZ3O6DoGtybBgW13esxeDx7YL6yHgkoJ4xGvMUndKjLCAM0tNGLW0pfCIKJU
         1RIk/vV7uokJ+qdYAfnkLwrgbKEC2CRiXSL18tpjvsHmOZiGRKjVtgqW4lxZcNme/MRF
         2niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASpIJRV1LgbYaIn/8sihf9PSqZ7K//HA8oIfV5Jji1U=;
        b=YGpBA7fbXCGyXZRWeQUi8mL0DxEmo45fyNapsVUintq9f4TKICAgiE9yZqYoForOS3
         Y3tgoiZ1Eu/hXX/nfO+bBRF42SF4TqBF3ezF4Thr2t8Dbnmlf+bAamdVw+EMYJkZd2bs
         GkNjYAq/58obiNzsrptXMOodQRdg8tpUS5LC+LA2xLA9XzZv0b7zQJRhNr7hHONjmZz1
         Yz3EpSColCtKlvAwy+anFwky+jS7sJsqdXw3K8n0xPjhwj59o9Tybv2cLTbKZ4848IRr
         3EpDcr9MzSG7rSJSCQnZn7T/N7E09Q/TnQMQEOLS+x1+am7WVHvMsnq3bfHmlQulzjht
         ffzA==
X-Gm-Message-State: AOAM532NCnFGeC1nYkH7ZdDbEhZIGxzIgWt8/ZcEjyQUfU5AYrhlkqUD
        LWUiCHE5rKmJhvkyjqHUQ/RX/g9yUl7T4cioyZ2PaA==
X-Google-Smtp-Source: ABdhPJx2ifzFEDI+8FVLUA5dMaNvcKyEcuulaqadgxsGJ+06MBXDJr9QzwzWTQLe7Y3YlQblnOnWWMOrrm/JyeFd854=
X-Received: by 2002:a19:490d:: with SMTP id w13mr7491640lfa.96.1590156487605;
 Fri, 22 May 2020 07:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163142.GA808793@chrisdown.name>
In-Reply-To: <20200520163142.GA808793@chrisdown.name>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 May 2020 07:07:56 -0700
Message-ID: <CALvZod6ijEUKTXzi1oDV0R2HdU6bcxUn_zDigskuSPtzn-vw0g@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page allocator
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

On Wed, May 20, 2020 at 9:32 AM Chris Down <chris@chrisdown.name> wrote:
>
> Reclaim retries have been set to 5 since the beginning of time in
> 66e1707bc346 ("Memory controller: add per cgroup LRU and reclaim").
> However, we now have a generally agreed-upon standard for page reclaim:
> MAX_RECLAIM_RETRIES (currently 16), added many years later in
> 0a0337e0d1d1 ("mm, oom: rework oom detection").
>
> In the absence of a compelling reason to declare an OOM earlier in memcg
> context than page allocator context, it seems reasonable to supplant
> MEM_CGROUP_RECLAIM_RETRIES with MAX_RECLAIM_RETRIES, making the page
> allocator and memcg internals more similar in semantics when reclaim
> fails to produce results, avoiding premature OOMs or throttling.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

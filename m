Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577EDC83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D42208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="sf3CTAKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD3BqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgD3BqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:46:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0584C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:46:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so88014wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kVsytFlvwmRlPq2e2ylTjFJxkqfOFOkO0kcwGuxLXfk=;
        b=sf3CTAKS22+/2W8CwVyZC4W5QTvjxrSQYXYwimx3E04EnhPb09pbOUhgikHbXuQcH8
         4+kqjU+Fm6hsIahZ+JkODsSb30DePYkcdcqXccwLuKGWPQYKN3XiBFqR9XU6ww7e4oJS
         9Sr9WGpbT8cDQDnyDiRS7W5/TjJvUOnc3fL/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVsytFlvwmRlPq2e2ylTjFJxkqfOFOkO0kcwGuxLXfk=;
        b=Kb1pAhCdJqydEL7YE0Ibpjef3c6S3zb1TkY4ksYDfwD038F6vbiP+cpZ34HuurBBOh
         /btyGR3/gX90aPzn1VOgS2/vg2L/nrf00p2LFj9zRIdCw7uwSlAAFsBc+ElJstqBAf1j
         zaKdujzmjPTPtNGqYlZuxMbwtkcU6LUeYCLS7XHPaVrco02chdPjcc21PHxOe81gQClB
         i46ZJziuQbVEIlgiLoFjHvhSjFXi7dLrryc2CGrG3mL1B7Be22HT4A0e0rep++Qtu9Nd
         HpM4c8hO7Z59ZGYPfykmlED90JbZbvWlicmZ4viyCUE4w4Db6qMg5XaUsWL1m79IO/4W
         CA1A==
X-Gm-Message-State: AGi0PuaNpKH/4uKXHSkuK2/oFzVl1XFKNKJRj1JLqmGSHSabHxwDLFgL
        FmmGDKPr0XHTFdlqavwVnq6OMg==
X-Google-Smtp-Source: APiQypL/aU3Pwq63058Nq5MGjoH0yWWJ2d7gZXE32aHzAXjf5qhNdcbhBoNgFELiTQFwET2TOZwLhA==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr208786wmh.180.1588211165307;
        Wed, 29 Apr 2020 18:46:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id a187sm10437581wmh.40.2020.04.29.18.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:46:04 -0700 (PDT)
Date:   Thu, 30 Apr 2020 02:46:03 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200430014603.GB2754277@chrisdown.name>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com>
 <20200430011626.GA2754277@chrisdown.name>
 <CALOAHbCL_JJgcy9r99Kn81-o_t-fs_nQ+n7aKMHO-02QMCufEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbCL_JJgcy9r99Kn81-o_t-fs_nQ+n7aKMHO-02QMCufEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yafang Shao writes:
>My concern is why we add these barriers to memcg protection
>specifically but don't add these barriers to the other memebers like
>memcg->oom_group which has the same issue ?
>What is the difference between these members and that members ?

There are certainly more missing cases -- I didn't look at oom_group 
specifically, but it sounds likely if there's not other mitigating factors.  
Most of us have just been busy and haven't had time to comprehensively fix all 
the potential store and load tears.

Tearing is another case of something that would be nice to fix once and for all 
in the memcg code, but isn't causing any significant issues for the timebeing.  
We should certainly aim to avoid introducing any new tearing opportunities, 
though :-)

So the answer is just that improvement is incremental and we've not had the 
time to track down and fix them all. If you find more cases, feel free to send 
out the patches and I'll be happy to take a look.

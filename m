Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC6BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020F221531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnvOhSKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgE0Tsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0Tse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:48:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A70EC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:48:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so30422911ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aQnJXyiQA3IowsNfVoOSqHgT1OkRmP0E5K+YnP6bZ0=;
        b=TnvOhSKlFxE31tFdDGs7QlyMOK6Y7cUfkHrTbOmzpDgDbGW+JPoveR4i0MYR41TeBh
         z3XnFBVgJIiV5+i6dphaBvKpRVeqDNoT8mp9flwB3oLqK1X+fKUW4N0cq1KlbOxLaPD9
         Oa23F4+5CyZa0ZuPBk7SL9bZg/5tT/T3VwRO4DQnpNMjhqK/pwF2PDzUOFa1n1wSpaeh
         EwhNhB4cA+b/YBoGMYrYiD2SZEprrV0KkYUySrjMaaqPGLzkzYx+J+ACdgcVMl8lAxwC
         0oA2BItbx/b+YNSeQcDZX1HHFzlW05hAPbrEyTQnb8VcyMMKWD1rAKGjasJC4kcIOcN/
         ZeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aQnJXyiQA3IowsNfVoOSqHgT1OkRmP0E5K+YnP6bZ0=;
        b=lQpR2X08XheWcLAjLEIxUJdEzU1yr5Vip8YRMiF/zgCE7YN4D2NMxWlm7IF+TeeF88
         SyfsqWef4mGs5zscbWBCZsSDv6T0GvD2j9NiTH7OjDFXrYX5fYKSwDsdSGJ4/gurTbwZ
         NesSPeRvMKAop7R7isJqlrFEunbJ0XVKmAUsdnas0XVA8tAvJW66QD9q3G7xJjMGF152
         fjCO8r8Gxlgncyi21Icy8gljpmrgiP8wmGPJ9ZiPCyrgu7h/ln7ovq1FnZw35W+G9+Jz
         mqviJu7nQPOWhn5rl240vRPHr0G4lJBQp9qdUO105T8cmBBrO1yfNNcdCp454XfouP/Y
         n+Sg==
X-Gm-Message-State: AOAM530el0J8GBStTHCntUm8yyk5C5vh5PZbFKlrT24ymZvWl/S5b2bS
        RJqGR1vIZsYyrgBYin6Go3KEhWP9yZVi25zgxbpKBg==
X-Google-Smtp-Source: ABdhPJyEZKW3APXVi32eLvyHMFmU9WePyudCh1ndYkbgbtfCupI8fzy9fNXJFu97bCHQmtzpSyDl6UVJ40xglAwJ4VY=
X-Received: by 2002:a2e:8e79:: with SMTP id t25mr4050863ljk.446.1590608911447;
 Wed, 27 May 2020 12:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-1-hannes@cmpxchg.org> <20200520232525.798933-2-hannes@cmpxchg.org>
In-Reply-To: <20200520232525.798933-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 May 2020 12:48:20 -0700
Message-ID: <CALvZod5ayJ3UzuNw-a5cio3equRFaWGdLGxf+fxcokRx3mCJXQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] mm: fix LRU balancing effect of new transparent
 huge pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 4:28 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Currently, THP are counted as single pages until they are split right
> before being swapped out. However, at that point the VM is already in
> the middle of reclaim, and adjusting the LRU balance then is useless.
>
> Always account THP by the number of basepages, and remove the fixup
> from the splitting path.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Rik van Riel <riel@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

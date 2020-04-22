Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969CC5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB302076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtBnqEYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgDVSCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726924AbgDVSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:02:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41AC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:02:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so3338707ljl.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxPQfRGdb/9tZKOeYvx9nsO533AAnUsM72YkEAHTBCI=;
        b=MtBnqEYdd89iXzsWZUzdrGnwyjo111BKIiu7L3ZHWXsQEJMUCoEyKDRbJIyIbEZ0UL
         DV3+yaBUmM6gMxXui+ZOIe6OyD7VtRJ23975UXk+/Wj0COST+PbV9MJTROveWW0bw2T7
         GtXFKn4EezlfKVlwrZaFUmoy/J+Vyg0tVlz69s+eov79IvvYBC6QTV2+OAVc8P/TxcAB
         A8+D4KWyIqFJwYB36BbmoTeDFQv2oa4PzTVNJUV6suxSZPhHbZMiB3N4XCK8SMiAZedT
         H6oGGCppXSeyYI9Pa+3Rc/6Drhivl0uuWfd0hsHATauPrPn70QbuvXx3LUDAOw5klFM8
         xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxPQfRGdb/9tZKOeYvx9nsO533AAnUsM72YkEAHTBCI=;
        b=TgXgWMHvRJrILc+KhVew6dHXcBkAR/+Iw5bAOrPmsMRC+B6U8Tg1qYW/TWbmhHoqVC
         2TOYp9Zt+BgnXsTqnI5nhhIR7P8pApkxbivE4rgmfNd8mmy1c3KqfDl/eyNM3CLYWQ+R
         0bZ6CvLA1sSBEkpyXsJdF8Nq2d3+c6PeffWCt0RcSLD8C6DYbfragJGR4fcZGS2lCmSB
         EYB0FX/NNhu9dTIQNu+80+2zjakxYnY+gydoDkmV+bh8xBJ12renIsZo+0PFK0WncpkZ
         JRu7icw54ygQ34Wlk0tqGX2kvTycvixb+rD+uh6fAWMfCKUHVR3lIyaCM1phPZuQpUPR
         EvrA==
X-Gm-Message-State: AGi0Pub77xBPYN7WHwa8VWWrDE+y0tIdM/wBqnVenYE3XeTGhBd1y7cW
        jYbe3rMVtGBkm7y/t+Ox4syGdynL/VB3vNaPdiFT2w==
X-Google-Smtp-Source: APiQypKntPoBdVTS/8WRMaXpnY/jdYe0MPd3EYScD5Cm/9aT/zP0pcWdgKz8DqlIB8lwr7cYH+N/ASnro4D3GssV3l8=
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr21615lja.250.1587578553958;
 Wed, 22 Apr 2020 11:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-3-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 11:02:22 -0700
Message-ID: <CALvZod5XC+v_ThY=QyiXu9uWgkuc6x63jwUjW9mdWueoPh3LBw@mail.gmail.com>
Subject: Re: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge moving
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The move_lock is a per-memcg lock, but the VM accounting code that
> needs to acquire it comes from the page and follows page->mem_cgroup
> under RCU protection. That means that the page becomes unlocked not
> when we drop the move_lock, but when we update page->mem_cgroup. And
> that assignment doesn't imply any memory ordering. If that pointer
> write gets reordered against the reads of the page state -
> page_mapped, PageDirty etc. the state may change while we rely on it
> being stable and we can end up corrupting the counters.
>
> Place an SMP memory barrier to make sure we're done with all page
> state by the time the new page->mem_cgroup becomes visible.
>
> Also replace the open-coded move_lock with a lock_page_memcg() to make
> it more obvious what we're serializing against.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

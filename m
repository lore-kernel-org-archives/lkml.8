Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ABC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502E42088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgQVm3l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgE0Tq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:46:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E20FC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:46:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so7970020ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWhAV+oalNjQE28LBxoMsLXJD6jlzY/ddZHzS5PvNwY=;
        b=tgQVm3l2X8qPOygWBAnzNsgUIRIcVeW2WuBwqzLOuKVx3HMHaiOAay8Zivr02tExiz
         6VtK81R3seVi6PTDTNkRw090IS5JYXDZklfI8TtuFyDUGIt3ZMtYFdKHVbX/lH+rpDAN
         AsnFxXNdnRY0OKiSi/PctDt0ko1DsNswoTGUpzqg3RyPFA+1AxX6StlVcpuLUv4CTQZk
         5wXe7T86+CQnb/J7QN2nApObS8C8S12EhYq707hVdn11Llw5MjPqTYIzgBLu0wjWENtI
         4OQZvOVY0galy6YdtiwNnrOJGoB1KX9XEnCXCXiq6vtYNNo9CKQ/0VCj2w4ARspj9AQr
         DKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWhAV+oalNjQE28LBxoMsLXJD6jlzY/ddZHzS5PvNwY=;
        b=Qo8Rp3b6XFeqpJnzQ5D0tqbMQ4yHvLtq6sIH6o0SjOgz1oPz8TjE3vGEKBA5OCm131
         EJ+GPiD2AXK4SL7LNIjyRjE6Hm7/PuTF3iysGUzr3wYZxfnnRCVi+PFfkkIsaDwCkh/D
         bqrAG9Htn7GEofpDFv1ndKC3hJT0mvm4EJ/JnU1n0WyZTKPqC60JIK1IHFUYJ7ZpT0SR
         KfuCLv4AFF1YtKICfDlubPOIeAz+1ViaR6XeVJjIfUwJ9z0ehKnVv0DhEwigltb9oYzR
         5E3nRHgGmSD+3+j1kmctc3KrBbEHgTMsehGwX5IShjjwraJKroQlUbdgDpQaBvy4PD44
         +5+w==
X-Gm-Message-State: AOAM5303ykw9DGPHzC4BM8hwW5tPshDqnnJn1Klw6ygQ2n+YC5lcy5vG
        rAT9cb4X87DW8KuKRJrezMFPd1nakDAFYV/EG1QqSg==
X-Google-Smtp-Source: ABdhPJxOcdjgr3W3iJp2ZHQW3sk0rlBDc+qPkqLsHMJGAot3E0Nyk/3oLAFsChktA4ZzE+QNK+yp04GOTz4yqxubtcc=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr3993911ljp.347.1590608783797;
 Wed, 27 May 2020 12:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200527182958.252402-1-shakeelb@google.com> <20200527194148.GA47905@cmpxchg.org>
In-Reply-To: <20200527194148.GA47905@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 May 2020 12:46:12 -0700
Message-ID: <CALvZod6tbWvCT9swej9+h_F3Z0v-Cw7KV6o_NARUPgke7K41qA@mail.gmail.com>
Subject: Re: [PATCH resend 3/3] mm: fix LRU balancing effect of new
 transparent huge pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:42 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, May 27, 2020 at 11:29:58AM -0700, Shakeel Butt wrote:
> > From: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Currently, THP are counted as single pages until they are split right
> > before being swapped out. However, at that point the VM is already in
> > the middle of reclaim, and adjusting the LRU balance then is useless.
> >
> > Always account THP by the number of basepages, and remove the fixup
> > from the splitting path.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> This is now already in mm as part of the "mm: balance LRU lists based
> on relative thrashing" series that I sent out last week and where it
> was originally from.

Oh sorry, I missed it.

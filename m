Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB7BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D6A2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1a3QzyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgHaOqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaOp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:45:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8344C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:45:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so5939494ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiXcm4u36vD6BWyxr4Psu6FC09upa/dV/NKGEiJVOTg=;
        b=M1a3QzyLYSn+zE0HTt5zRzioXgASrO4Sf7UZjrgCUjtgHLL60fZixK7uxwhWImpBNP
         YIxSDm9DBW1tjLB4iNyGRYx6VSi7qetHjnf0n+oiwZbKn0WTA6Xhth9svZQO/Dihd4ih
         YojnXuoph1S2i+GG4M1m1uRnyF5RMDV6ZbFjPaaOi5jC2iC3NbFbhKrLXSEvM/WoizmE
         pj/rA8c6owsHeCgyFKZUrVDtkUzqZ3lqW+LpdGrkCAsSVxN2Pm4+NE8qx/pDAgaS3pZm
         PVxVxTbZSVqqK7ys1LmKh7nLTao8pfGFc8Mu+c1d99MMl1ey3q8UnN9GY8tpm6Py7Xix
         2pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiXcm4u36vD6BWyxr4Psu6FC09upa/dV/NKGEiJVOTg=;
        b=b7g32tDMXWpYx787ygIpO3Mm5csQGZhQZ4b9FIZMT8X/BpV65DB5OqYDC7S/vW4af6
         x6ZphsYzlzze1ngVksTDqvZRWSEyvJC0rCWplpkY0gnNp2JwThJkuiN5iZKNPPcGuR59
         PaSqEDyc433GsM1QWdBdgmqF5GrNvC3xKdPHJjJqEenzINGAtdrMhwjIxac01l0A5Iro
         TeeVJpWxkicuxy94zjY/SNlJ/BtKUVpzCscpQ5DzhKW0kb2CynozToMiZ11nU6YncBR3
         vdRN7NgokQEkXfJ1kXG2sxvb/SR/QZ1BXoyen/99Jl9ELagrVJF8d30kSV1rKx07pO2o
         UYDQ==
X-Gm-Message-State: AOAM531Imwn7HtUhisX9HIW2ts0L1VMzgvjJUZ79NzKU5J095mRO5C0Y
        2g1HQxxTwbORuOR+Zii7d5gbl8rcnoUSc62o5+x+Cw==
X-Google-Smtp-Source: ABdhPJxP8gyhsjqUA4CRMZqi/U2msM03KKKj3jptfQij8wgITLblI2ohbPI3RD9nsxY5gUoMWJ0MFH2ltHt/S4kWxBg=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr873904ljj.332.1598885155998;
 Mon, 31 Aug 2020 07:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301408230.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301408230.5954@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 Aug 2020 07:45:44 -0700
Message-ID: <CALvZod6ZV8zog2cXPA+TOK3Le896HCY8V4xYsoTiWdxtrxP7=g@mail.gmail.com>
Subject: Re: [PATCH 5/5] mlock: fix unevictable_pgs event counts on THP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:09 PM Hugh Dickins <hughd@google.com> wrote:
>
> 5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
> established that vm_events should count every subpage of a THP,
> including unevictable_pgs_culled and unevictable_pgs_rescued; but
> lru_cache_add_inactive_or_unevictable() was not doing so for
> unevictable_pgs_mlocked, and mm/mlock.c was not doing so for
> unevictable_pgs mlocked, munlocked, cleared and stranded.
>
> Fix them; but THPs don't go the pagevec way in mlock.c,
> so no fixes needed on that path.
>
> Fixes: 5d91f31faf8e ("mm: swap: fix vmstats for huge page")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

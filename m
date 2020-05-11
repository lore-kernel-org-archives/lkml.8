Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E78DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDEC206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSF4+U2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEKVih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEKVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:38:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869FEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:38:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u4so8799180lfm.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChSHe7FyTa+zjt6baNaGuWMAUroI1EbP4D6mMzh7YJM=;
        b=oSF4+U2KXK69tC+TCifckd1LCmMy3VPdfqBe1H3p00uNL+RZoV+8g1FlZFsG+WV5Nc
         ywCLC0VjdXoWrmB7QP8d50OgBUxhPzo0JiuH4cdGazSFfHdbujS2CZDHTRMHJ6SsfKBk
         JYyFZXi7rto2xB8IQtklg0A/bR6KPzuoOtdecmUvVd5u33iqoWbEnqVtJsbNjKbHHFFp
         EqldSHq8bgLJKfgjCjWQJpvVSjHjo32giKfT7S0D6FteIkZ8uTsjTM0kbfE0s9cGl7Bh
         9U4qVdpc4splQNkTxucNUaXK01X4kxCce6g6rUVcJUII44ETF0RrwW5YBsykyhzS9bd6
         DK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChSHe7FyTa+zjt6baNaGuWMAUroI1EbP4D6mMzh7YJM=;
        b=V+Iwv6LTc+4G7p+VweQOyjvOWlKqV1pLh/fMeUvyvqjBcpRf6NU9S0oEMEZd/eUEHj
         l7NevDKxy69uoWlBNUxrHSAZjr+vtso0fsSBg9dKXYcU3k4fElODDhqX0KtJtuJ2MCV0
         3b5ilKDN7wzdooAqGa4bpV6KV9YOb1eTcBdbjm0HHYK0XH7V+eorBLGYCeOKv7+koTrJ
         JWuNvIa5deSOePHfVDskIrVNWBMWLOfhtttHhuJbenA95bKrbjtFx/hfoKcjNkAw+5Za
         lX0TjOXIUwiOn87XI2WgRG8L8HDsF5xJn+YKbJJeR/bXPlENNdS9fPdgDPi19ViHCtxT
         Boyg==
X-Gm-Message-State: AOAM530V3MMSFkU+fgu+bUnBxsyQDW22TgJIjFa7JlWGJw74U8GGIEY1
        s61WEmAKtv8SyhPke88SqWFsMF1ETe6c8F8GuBw0lg==
X-Google-Smtp-Source: ABdhPJzEElsneOzpJM1AZJZxWL1/CIWd8ha2yYl9sAEzl8q88dZ6kCXi9uzvw3rSEUq8Fa2zOdSobO/bBpYArZvnJm0=
X-Received: by 2002:ac2:5ccf:: with SMTP id f15mr12233151lfq.216.1589233114742;
 Mon, 11 May 2020 14:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200509141946.158892-1-shakeelb@google.com> <20200511141122.9b03e2f0852b57b224eab066@linux-foundation.org>
In-Reply-To: <20200511141122.9b03e2f0852b57b224eab066@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 11 May 2020 14:38:23 -0700
Message-ID: <CALvZod7848_BETonZJFxXN1n1E7KtZ4DzT1-BeaN6hvBysN8WQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix LRU balancing effect of new transparent huge pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat,  9 May 2020 07:19:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > Currently, THP are counted as single pages until they are split right
> > before being swapped out. However, at that point the VM is already in
> > the middle of reclaim, and adjusting the LRU balance then is useless.
> >
> > Always account THP by the number of basepages, and remove the fixup
> > from the splitting path.
>
> Confused.  What kernel is this applicable to?

It is still applicable to the latest Linux kernel. Basically
lruvec->reclaim_stat->recent_[scanned|rotated] counters are used as
heuristic in get_scan_count() to measure how much file and anon LRUs
should be scanned by the current reclaim. Previously huge pages are
treated as single page while updating the recent_[scanned|rotated]
counters in swap.c while vmscan.c correctly updates them as huge
pages.

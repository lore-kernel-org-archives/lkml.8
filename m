Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BEEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13B8206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqVy0fps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgHNIfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:35:52 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32EC061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:35:50 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e14so4820212ybf.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdqxtBBzE8zkm3kxwd6M5EQuKDKvTyliTVOnv4Gy5lw=;
        b=oqVy0fpsXt6mcaf8A0SC3B/hbz8tbu1sLp+p2pRxvv8AbXvXwBHIFsfkMCRqNri3GF
         qJ5LaxL7IMvfVknso37KHelMIw8Dd2z7cxXhdshfuODzyH2Xseg89iJdaKUlQjvHq7Hq
         lhVM/0EfF59L/acBDsdGpzOFVzg978mH+5YR0Xnus5a+hauEXlwXVyH0k/uzyUQXeOV+
         GoD9sItD5ZTLV2cb+jVfv+1qVPtgrDmNyETiLEcVRayEQDHThAdY1wjwZE3Exe3WMAGf
         B0CMyWrcmpON8PTov2dXTjRTU6wL6B8HVQWcoUhp+BuAHQUBWllyB0qzr6niC+D7+S2F
         fxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdqxtBBzE8zkm3kxwd6M5EQuKDKvTyliTVOnv4Gy5lw=;
        b=HjLoSOJTQfwseycxreI59sUFE6mUunqnrzkGCDcqmkpsW7Ae8tIfAI9StYCBdPnyed
         FlUBUQvrsUcrzegxFoKnDLt5KcE89gC+rJh2gN+b/BopN0Kl5jLyNi7YNhvkQer6byYm
         ZY/kPFzrYaebs3ulVKwH9L8y3SB6JSUykJ2F7ZmHlQcEGwZcz01v1HSM/gNLvTKCseoe
         A3hECLbphA8f0g0rEY9x8ErmccbrZKweszKQ4JpsHJ3/8zCekrUGBj9zsdGZ9JcTUy+m
         Ob0PBod9CEsC99ufdMsnpJk11qGTiz95uB9549mP6kOIbFUJjmNMQIx+Y75XjzCbD7pq
         AJyw==
X-Gm-Message-State: AOAM533P+dHZ0yj/tYZjjMxEBxbPrcw52ztdQN0/M9zdJg+ID25oxj8V
        vKfwR3igW3WmaucpoFvQhYaBS0wRR9FdVB2MJxD3Hw==
X-Google-Smtp-Source: ABdhPJy4hZxzSJG2zp9/9fyOvZB1bpfPoOKRLt/YSmrRg6wSBSlJmdqUtSRvhcYGxO1/TjNY1yNIgU0oMFRVQUhfajs=
X-Received: by 2002:a25:7455:: with SMTP id p82mr2121422ybc.287.1597394149918;
 Fri, 14 Aug 2020 01:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com> <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
In-Reply-To: <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 14 Aug 2020 01:35:37 -0700
Message-ID: <CANN689FtCsC71cjAjs0GPspOhgo_HRj+diWsoU1wr98YPktgWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: proc: smaps_rollup: do not stall write
 attempts on mmap_lock
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:13 PM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
> smaps_rollup will try to grab mmap_lock and go through the whole vma
> list until it finishes the iterating. When encountering large processes,
> the mmap_lock will be held for a longer time, which may block other
> write requests like mmap and munmap from progressing smoothly.
>
> There are upcoming mmap_lock optimizations like range-based locks, but
> the lock applied to smaps_rollup would be the coarse type, which doesn't
> avoid the occurrence of unpleasant contention.
>
> To solve aforementioned issue, we add a check which detects whether
> anyone wants to grab mmap_lock for write attempts.

I think your retry mechanism still doesn't handle all cases. When you
get back the mmap lock, the address where you stopped last time could
now be in the middle of a vma. I think the consistent thing to do in
that case would be to retry scanning from the address you stopped at,
even if it's not on a vma boundary anymore. You may have to change
smap_gather_stats to support that, though.

Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1775AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE7420702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlvzt4sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgF3Sg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgF3Sg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:36:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB70C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:36:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so16629670lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmMd8dJzrh6Vbw+MGljTp8jU8xpCSAjIfg+twyARNbY=;
        b=nlvzt4srVPfvdNTbxPzMxWr2bpcP3G+zeXKZJpHtK/9tLbmDCLXFBOABQDpjJCANOb
         tExsqVoRZuHmGThsd9zd+SDypDB/jV9PJBuemv5XHM7+ldXkLULO5yl9xg4tj9bBoHi2
         U6DN0A5HR8j0kV1jYCHY2vTPczwW/ucBq97bCoTuq7EY7JV/ctM395nrfA7yK7jieePn
         JLu15ue7i5arhIUCVhwHSJoZisVQ8hFpXSJRP8KX4h5v6QwEQAgPombqVdGOsG4RFQEl
         nzHiy7vUYvbmLRMw8MkvhA1iUez/j2KbDf/fMpXPrfzvKefH4vsd30bUvJFFbCn0V41Z
         0Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmMd8dJzrh6Vbw+MGljTp8jU8xpCSAjIfg+twyARNbY=;
        b=LeZ/maRzK7JVTNhoYAn6zghZW85u5+vGxzhQxxohiME4w7ZkwXqptlwb8AZInfSq/E
         A1c0vv+kIFpkgD7Qu5s27ipNdqe+4+gOSBfKsYyz/uQzIoY3nD9Ag35+2nFBh9uCSB4I
         pVHFuwdrTvydli2q0v/qVefB4JCkb0t790+P8/ompKKbq9vYsEeLyoJ83txUIi8d2bK9
         0s80Wj6z+H6bXPXetJkUwGLJPuk9X0qQfI4LG6tR4BxfB9N1Xf0vYLpZyOkyJwfJ8VO5
         o7umFae5d0P8GNQtoz+yLSM7ly6j/A8H2KDp2Air9BPHv8w7lm70lcPibIopxWnnMqnZ
         bKIw==
X-Gm-Message-State: AOAM530zq8Rk2FoCCHdypGIiaQDPo0jMdBISZyJwlcPlYCRTD2da9fVz
        xsGYSUmztSPcZAA7Jg3B2axVVEPYDwRnfVHEaru0Ig==
X-Google-Smtp-Source: ABdhPJzICJHyF7j4SzEYMvu9uRna6ekqoyKW/gnwuQugvxHqnSV0ara77pUHOzK2yf82Xb022rKhB9mlhUu8MbGLz6c=
X-Received: by 2002:a2e:9585:: with SMTP id w5mr10019121ljh.58.1593542215095;
 Tue, 30 Jun 2020 11:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 30 Jun 2020 11:36:43 -0700
Message-ID: <CALvZod55OFzOozsDbyTkUh1uZEobo4CZ=+8JgrJJHw8QuWh0hw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 4:48 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> I've been sitting on these for too long.  Tha main purpose of this
> post is to have a public discussion with the other folks who are
> interested in this functionalty and converge on a single
> implementation.
>
> This set directly incorporates a statictics patch from Yang Shi and
> also includes one to ensure good behavior with cgroup reclaim which
> was very closely derived from this series:
>
>         https://lore.kernel.org/linux-mm/1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com/
>
> Since the last post, the major changes are:
>  - Added patch to skip migration when doing cgroup reclaim
>  - Added stats patch from Yang Shi
>
> The full series is also available here:
>
>         https://github.com/hansendc/linux/tree/automigrate-20200629
>
> --
>
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
>
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
>
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
>
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
>
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
>
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Other things need to be built to
> promote hot pages back to DRAM.
>
> This is part of a larger patch set.  If you want to apply these or
> play with them, I'd suggest using the tree from here.  It includes
> autonuma-based hot page promotion back to DRAM:
>
>         http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com
>
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
>
>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
>

I have a high level question. Given a reclaim request for a set of
nodes, if there is no demotion path out of that set, should the kernel
still consider the migrations within the set of nodes? Basically
should the decision to allow migrations within a reclaim request be
taken at the node level or the reclaim request (or allocation level)?

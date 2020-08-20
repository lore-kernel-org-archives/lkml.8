Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4482C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EF92075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyVasFG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHTAsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHTAsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:48:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB0EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:48:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so602578ejx.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWR/eDOYSmSVzczzo6qbGdfO4pCgUsBX0AEa/KnN3jA=;
        b=HyVasFG1fl4fG/iXKZkNWPqtu9OF1wAHPJFL5xKE4K5PVXaRHNZfuPl5ObgPVNHOQt
         /htjOJIF2gzq6iLuXNRz09A1VwBpeyptHNhBWS1A8fyDbvNWyQXhX5FawuLAheY3ty8+
         D5pWABLubEXetY0V+8FZkLNjerqN3uETEGS/v5KBy4Ta7MVWu8Jk8VOFClzlWfGq+0Y6
         y8yyLyR0MO1DLw9CWcggVwGbuU+46BMzO4oUnrd9VMYC48AOU5MRIfWaxbTPjN3Rm+hO
         v98ZyBTXH1/nGNovMA8nv0SinlQ1Iow+nVzg2oFPX1p3RzIYDze4uS+RIJqHGLy5Bict
         hQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWR/eDOYSmSVzczzo6qbGdfO4pCgUsBX0AEa/KnN3jA=;
        b=a82ftL13gRq+9S1634ZBpRxFx+vzxyLLQGHt706qRWD5q2kILpEtuJmTMcOp4+h7oL
         yXI//j833rB8q63AmPWA0fkNdKgI8ryFMkv8yZv9PuNvOAktLQI9p3/SOvvYOk4P8E2Y
         qX01mInOaIXSbWMGp9aU5DIMHxhkBhO4a1y3eGMAY2ZIRP6uJrRARovXnelRNUIc8dfB
         fyWcsq3cXO32nB47qT6vhxzSZLDbe1Up5r53l5jxfdaY16HLvp06dXWTxHppkvEOYoJb
         6st03Vy/iomXaV5a+T7FUZ0ODm3Z3Z1mgF+RoJYi/PeYeYjqbZ5NouYa0TISGnJQj+NP
         b4KA==
X-Gm-Message-State: AOAM531+uIDeFjr313W1tgZb4HXdXYhtwHJjBdd4qGbH0+4K4nhCGkTQ
        +nU0w4IbPLeYNlJrOTkjqgnCcmoxBqAA0tGe60o=
X-Google-Smtp-Source: ABdhPJxvdzXT6NM+jo0exsa3ykTI/5zJ81iR0HKM/WV5zYDeWG1qkf3V5Pvuk3az7y+KnGMfb2ms6/BsOrCsPjg1mWY=
X-Received: by 2002:a17:906:990c:: with SMTP id zl12mr884319ejb.488.1597884490658;
 Wed, 19 Aug 2020 17:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Aug 2020 17:47:59 -0700
Message-ID: <CAHbLzkqTrzsSJQW8Jkob+aBiVkt2kVR7FsH5-_d5cxmnYw39Pg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/9] [v3] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:50 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> todo:
> Changes since (https://lwn.net/Articles/824830/):
>  * Use higher-level migrate_pages() API approach from Yang Shi's
>    earlier patches.

Thanks for incorporating in this. I believe this would be more efficient.

>  * made sure to actually check node_reclaim_mode's new bit
>  * disabled migration entirely before introducing RECLAIM_MIGRATE
>  * Replace GFP_NOWAIT with explicit __GFP_KSWAPD_RECLAIM and
>    comment why we want that.
>  * Comment on effects of that keep multiple source nodes from
>    sharing target nodes
>
> The full series is also available here:
>
>         https://github.com/hansendc/linux/tree/automigrate-20200818
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
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
>
>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
>
> == Open Issues ==
>
>  * For cpusets and memory policies that restrict allocations
>    to PMEM, is it OK to demote to PMEM?  Do we need a cgroup-
>    level API to opt-in or opt-out of these migrations?

I'm not sure if this would work or not, but AFAICT, it is unlikely.
The nasty thing about cgroupv1 is you may end up having threads from
the same process in different cgroups although it is rare.

My initial thought is to make cpuset process only (the threads in the
same process must be in the same cpuset group), but it sounds not too
feasible either since it may break some user configurations.

>  * Migration failures will result in pages being unreclaimable.
>    Need to be able to fall back to normal reclaim.

That should be transient, shouldn't? The migration logic is supposed
to wake up kswapd on pmem nodes, then the pages should become
migratable in later retry.

>
>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
>
> --
>
> Dave Hansen (5):
>       mm/numa: node demotion data structure and lookup
>       mm/vmscan: Attempt to migrate page in lieu of discard
>       mm/numa: automatically generate node migration order
>       mm/vmscan: never demote for memcg reclaim
>       mm/numa: new reclaim mode to enable reclaim-based migration
>
> Keith Busch (2):
>       mm/migrate: Defer allocating new page until needed
>       mm/vmscan: Consider anonymous pages without swap
>
> Yang Shi (1):
>       mm/vmscan: add page demotion counter
>
>  Documentation/admin-guide/sysctl/vm.rst |    9
>  include/linux/migrate.h                 |    6
>  include/linux/node.h                    |    9
>  include/linux/vm_event_item.h           |    2
>  include/trace/events/migrate.h          |    3
>  mm/debug.c                              |    1
>  mm/internal.h                           |    1
>  mm/migrate.c                            |  400 ++++++++++++++++++++++++++------
>  mm/page_alloc.c                         |    2
>  mm/vmscan.c                             |   88 ++++++-
>  mm/vmstat.c                             |    2
>  11 files changed, 439 insertions(+), 84 deletions(-)

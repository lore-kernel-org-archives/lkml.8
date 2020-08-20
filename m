Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F579C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BD62078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QecQW2KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgHTBWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHTBV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:21:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA79C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:21:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so373994ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2YYW8edHeX1XU5Hyd3BTnCfsz4e6RGc2J6WqCLqZNs=;
        b=QecQW2KN7UqoOPEbPzIa1X6BNdwEoPIK3Zx/Cz1cbaaaWzq0I96Bg2sxEjLXoWhVuK
         PbvXHn2Uii0TYpGDnCXfHmmE5XrHtrf1FGFTrn8xLggR1p7SiGD9AVvWs4E17GLlQa7i
         +9RrO2pb+ivo2qh5kdDdamSMyool04JXjvdTpV/WTFdoqvC3TWaq+DcnVBQyRrWAkEpv
         zXGfccmBw8kfZ3Bt8Ot5yOjSVYSdr5sTrBrHT/1eU3R2BLyb/87hGhY7iwc/z+zSRxBS
         oAePzBtUQ7cH/w548Cl4Y81xeBa3/xsK+VsEs77pv6y3y7buQY14LPj6t2wYozvtscQN
         x5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2YYW8edHeX1XU5Hyd3BTnCfsz4e6RGc2J6WqCLqZNs=;
        b=baNQNqPiIwmml+8lmy/3caRg4IA4ZupdBElmk/o1e5k4K5NNGiALolw4qH9hV7kTpq
         6imIN0NUDJ2/7heWzfpsqWmTnS81qFz/oqgGUVqswKbPHL+V5vYlVlGgBMPeexqNLyE6
         Vv2r3SAmFoKwr6U9DGR6y0XORwRPlXsRiKpqtPgVPsKHGb/jYIu1ikzViQjuDW4Hzf/e
         sKR9h6h+57zjC5blJBSR89nT8fyKTJA/vX7l/hQPaBYgGyTtiU4BkAEx4OlP225U7pUk
         7pLmoohMci2p931YyJkFHqNQQcmzZtDcnp/wT48iQCIypE7HSur5n4lI9XjyoE1ZVB9a
         cVJA==
X-Gm-Message-State: AOAM530jr6Xz682622LCQ2CCOa0KLNOO5fIwpa2fbPw3r7rrihuFKhoQ
        ar9Ci4s0vIQe1n8D3ut2EUSALcDeFYB52mhnk6cnug==
X-Google-Smtp-Source: ABdhPJw37D5+GBoWe31O7oE4FkKmrNPnt4yXn6gWy6RLRKh0JBcxDx/XhFlwEmWfYkIVaYDsUe1DzfQA3e5OU0nIeHk=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr442161ljh.446.1597886516487;
 Wed, 19 Aug 2020 18:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200818072501.30396-1-sjpark@amazon.com>
In-Reply-To: <20200818072501.30396-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 19 Aug 2020 18:21:44 -0700
Message-ID: <CALvZod6RS66aSFjWHvpbjuinz2mwbGDnz+gh5L7dp+c3D_Zy1w@mail.gmail.com>
Subject: Re: [RFC v7 00/10] DAMON: Support Physical Memory Address Space Monitoring
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        "Du, Fan" <fan.du@intel.com>, foersleo@amazon.de,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>, mark.rutland@arm.com,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:25 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Changes from Previous Version
> =============================
>
> - Use 42 as the fake target id for paddr instead of -1
> - Fix a typo
>
> Introduction
> ============
>
> DAMON[1] programming interface users can extend DAMON for any address space by
> configuring the address-space specific low level primitives with appropriate
> ones including their own implementations.  However, because the implementation
> for the virtual address space is only available now, the users should implement
> their own for other address spaces.  Worse yet, the user space users who rely
> on the debugfs interface and user space tool, cannot implement their own.
>
> This patchset implements another reference implementation of the low level
> primitives for the physical memory address space.  With this change, hence, the
> kernel space users can monitor both the virtual and the physical address spaces
> by simply changing the configuration in the runtime.  Further, this patchset
> links the implementation to the debugfs interface and the user space tool for
> the user space users.
>
> Note that the implementation supports only the user memory, as same to the idle
> page access tracking feature.
>
> [1] https://lore.kernel.org/linux-mm/20200706115322.29598-1-sjpark@amazon.com/
>

I am still struggling to find the benefit of this feature the way it
is implemented i.e. region based physical address space monitoring.
What exactly am I supposed to do for a given hot (or cold) physical
region? In a containerized world, that region can contain pages from
any cgroup. I can not really do anything about the accesses PHY-DAMON
provides me for a region.

Now if you give me per-page information that would be useful as I can
at least get per-cgroup accesses (idle or re-use data) but that would
be as costly as Page Idle Tracking.

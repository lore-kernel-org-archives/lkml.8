Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3052E208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGVcx2or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgDLCDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 22:03:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37845 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDLCDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 22:03:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id s63so2078912qke.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 19:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTR+zpwxcbVOUwzqsmeeqcbb+Q1XYy8eEoh4oeKA1+4=;
        b=wGVcx2orE/ZVZkEcNH2KSyudN0OW6aFG0jnf5fZ0swkTt/t9Bs6g5Ho2Kdg8lfipRw
         4/MbdH90jzLeHdNTrdwfEu32oalNNzUq0LYN8kGaHsxHevKcDOnmC+JaLcNwGOHeTWvR
         s8v2JU5w0RpbA4eJ+9kOK1/RB9vKgL03ERCdCDjcU7yqGeb+nMXVfoL5MFSpYC5ive+S
         lEBqJiBjcbgQviYrkBlOltdijYWQ/YgWsxrNYQIMxT4ELnQ8cVLIh+3/VXYjMTn+Xw2b
         LXX2iGyGUMeFi0F9FFDueAFnhRwF8zGp3iJgvpXkAHvYqYG3e8xAKbj8p52Xwm5LT3/r
         c46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTR+zpwxcbVOUwzqsmeeqcbb+Q1XYy8eEoh4oeKA1+4=;
        b=ih3eaZD1T0LDeVizV+tZM5wIe3b/BQfvnpPdkfuUzpUO0B/BNhYDIRsYFs+3VVQSFo
         8SyiSGdpMpkuQxR7NBO3t0DRe906WIlHWps2Qf1FxJgOQoBlqZs1Wm3ZbdtjSBQfTHd/
         x3nY1sVfzwxYw9QNKMvOGjveXejXc8qRT3OacPTp8AEdOjjnebl3wT5IvPC3boQynfKI
         Be7Y6QnoLCy4HjClh65kvdXYnpsUJtFzPQCIhdpLTdt/hBUgQzhtOFfGLh7zE+hSurYJ
         dTZv7qzMJTS6zbN4FmzIbuYNgCcyIT34zRqOLf6rEonxxhMUgRywjx13ElstLd590S1I
         qFkw==
X-Gm-Message-State: AGi0PuYEfU/BaQjFEEOaejQVsK+WXlRiHS654tEQS0h1AaZZm69px3kT
        GSXU968kgjRp8xC8FBYkIXaJ7ERt7qbOanluewkxRw==
X-Google-Smtp-Source: APiQypLUxCqVPR4GKG7CUyPrOvnrUMFusgjUaLgM2ynAlBnJRFglKYD101lhX74B/A8J6SBq1M75pG/FgXK9oPUN5h0=
X-Received: by 2002:a37:a9cc:: with SMTP id s195mr10307114qke.124.1586656997961;
 Sat, 11 Apr 2020 19:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200410225208.109717-1-joshdon@google.com>
In-Reply-To: <20200410225208.109717-1-joshdon@google.com>
From:   Josh Don <joshdon@google.com>
Date:   Sat, 11 Apr 2020 19:03:07 -0700
Message-ID: <CABk29NufEj5L4fi0h8Ag4ri2LLYUwYNSeLrwq06t80WmVkfsEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix race in CFS bandwidth
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, pauld@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 3:52 PM Josh Don <joshdon@google.com> wrote:
>
> This series contains a fix for CFS bandwidth and a related cleanup
> patch.
>
> Josh Don (2):
>   sched: eliminate bandwidth race between throttling and distribution
>   sched: remove distribute_running from CFS bandwidth
>
>  kernel/sched/fair.c  | 91 +++++++++++++++++++++++---------------------
>  kernel/sched/sched.h |  1 -
>  2 files changed, 47 insertions(+), 45 deletions(-)
>
> --
> 2.26.0.110.g2183baf09c-goog
>

+pauld@redhat.com

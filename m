Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFA720773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joExhaby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGGUB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgGGUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:01:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D4C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:01:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so133855pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deVKVkd1dAk3e08j5i5GNiXNm5xjlkJJyaPmekMgYU0=;
        b=joExhabyZB0vt1CrjiLBBJuh2y0s7Ge6/UUdEHw/Rj+xbg/+H0a6S2IOIN3IiViQ4W
         rxW2IIFm9AuobZCgTrgrZ3PNONPWHIO4Sv/zazlNvo3sEgs+oyIGKXJrFoDEs5DZo7JA
         podQjUBXC8G6qX6tTkd+AqoL4n+R8nXmVyuHB9AUzlja1OPlBFUgiSywtkJwqa5Aepem
         +IJ9BKFmSeCExYlUbF41YilpU0wu0MfKQryD6KqPxRDkC4/cE74YKU1ltEhGYhbpzeU1
         2qWH5br7P9OjtB8rVNXM+68xisqJQ/pe9s/3FI9Hvp7nQkFxQO2Yo3bbMbSC3hFsoY9Q
         duaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deVKVkd1dAk3e08j5i5GNiXNm5xjlkJJyaPmekMgYU0=;
        b=q6qPU01hAOYkV3noTZ2hQKr/aln6n3Ee5ncGA5Z7lrIs0JaoKZI+X5q6Cuc/Rw1QCz
         dqT2WcNF9295X+0x4G7rjHPjT38wQB7tDBvadfOJKBa8OQZ9i4BU+Y2BTHqVkmJovZJF
         VFp7TcQ3n96gtRJHGPeh1VJq1Ar1eudFvX9XP7C7E39aCH8nP0jvUmR9fFDklnZb07SX
         qnhJ+HN3RCGkT1cjOWS28kpZ45UDmPIcafdbAE4Crd58UHRQSdpaLKipHYuVW65lewXY
         1z/tEfLm2og+YaBJ83UtrhKooO3rUqsg6dk7fJlqfQWLI/NoiiPssur6sHQlYSiGwH4H
         /RXg==
X-Gm-Message-State: AOAM532vx5ic4BMH0FfldQtKzEuMhz6HGbzdKnSPb6OEloFBUEjSZXyn
        UPxUQw49YQL3mG19z5jjSZMa1k6ohjNJkwt5Yln2WA==
X-Google-Smtp-Source: ABdhPJwlyVLVKZHN4qDBBNdeHNC6CEZw4PyXOcicJbwGgUEhBHxpMRM661Kzpz4Odl5vxpRmyjw74Leq6xMBk9xk4ug=
X-Received: by 2002:a17:90a:4bc7:: with SMTP id u7mr6113647pjl.217.1594152117794;
 Tue, 07 Jul 2020 13:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200707144540.21216-1-sjpark@amazon.com> <20200707144540.21216-4-sjpark@amazon.com>
In-Reply-To: <20200707144540.21216-4-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Jul 2020 13:01:46 -0700
Message-ID: <CAFd5g45iCQKUquBCL+htQaQB6B4_dxpkp2wWCUXP6zMTuddiBQ@mail.gmail.com>
Subject: Re: [RFC v5 03/11] mm/damon-test: Add more unit tests for 'init_regions'
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        brendan.d.gregg@gmail.com, cai@lca.pw,
        Colin King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, david@redhat.com,
        dwmw@amazon.com, foersleo@amazon.de,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        kirill@shutemov.name, Mark Rutland <mark.rutland@arm.com>,
        mgorman@suse.de, minchan@kernel.org,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, riel@surriel.com,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, Shakeel Butt <shakeelb@google.com>,
        shuah <shuah@kernel.org>, SeongJae Park <sj38.park@gmail.com>,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 7:47 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds more test cases for the new feature, 'init_regions'.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

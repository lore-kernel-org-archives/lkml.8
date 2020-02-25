Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFBC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F042084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxKVlRjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgBYTCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:02:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44910 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgBYTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:02:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id a14so6931386pgb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnuAAHpvexBjIgdo0I3jrPe9EJ/pU5+xJDjbC5sUyiI=;
        b=KxKVlRjnC+d7tQegfRjfdNgx2ipP6nvGyd5QB8ZZzy7mmMUGCdScE2uEKcRHF+xH5I
         ZCvV0zy+a0nqzdjcr99NTvLBz+2Kb75n/PEHOX884PqVqBAe88B7QftJ2Hkp/ZphDMAk
         /7aI3moveWsQsnA4S+KrUiDOMkYspBNZumNzn5bEj7qdgjnal0nnMVAQsP02fljrdlXu
         TcMUh9ae9rdlKlrR6gR9UVLEUAs97wBzRSJ6Z6XrrwSuVmd4y8vSALYJuCatu1mAmM4w
         JOk2GuUTZonZaTimtjxPXazdOkBVYOtZCsm5JticS6tDGLMqdfX6uywoDec/Yag6N39F
         xmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnuAAHpvexBjIgdo0I3jrPe9EJ/pU5+xJDjbC5sUyiI=;
        b=Fxoeed13i2ta2e4O6zAESdKpfd6zvlCxutG5gcY/8qaAZ4aPZ4bY1DLmnJ4w+Y3dLA
         hl1Uo0R2bwVHd6iV4zwrlKL8pcO6BagmAYYxKtAqrPI5vbWiezlcQL2fKe9ePIf6IL/w
         BL1Nn1BsTrQ+ZXkTkBH7KSVgTqfsKUE9sO9p9ehDWPl4kc9neea5RGKx6Tt7BOrrSTxG
         3mVmxMzKXXPD01NdRUfS1RkT5i2SL1Sc7Osqx/Aa2hkeFTedEpjoTEUPJX52Z3soncEl
         SCVXR6LyW8fTfxaoSy+9ScjFxznIr2+ckPvsxSeLMzY31lswuTZXcISccvBt4QlRButL
         gLpQ==
X-Gm-Message-State: APjAAAUQwvtfmTVz20cZVMEN7EAFfFZ5PrUXm8Hz84uxj1QSbQhuP3/K
        MGs0XX+oUjqI6ALSPPdpa8qs04CbrJG0wggzZz8d1g==
X-Google-Smtp-Source: APXvYqxiqiqC/hdkXfuggm+uvyphsX1XfkSIzlfeJv1IXJ45qMugmyF98WdyHS+UQyAyVLn8W5R2X0INNO88GBDaO5I=
X-Received: by 2002:a63:fd17:: with SMTP id d23mr1344578pgh.159.1582657341835;
 Tue, 25 Feb 2020 11:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20200225102300.23895-1-sjpark@amazon.com> <20200225102300.23895-6-sjpark@amazon.com>
In-Reply-To: <20200225102300.23895-6-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 25 Feb 2020 11:02:10 -0800
Message-ID: <CAFd5g45-=8Qykkziy4mhMW+ZM4xqA1xnHJLGVveg=eGSC92=Nw@mail.gmail.com>
Subject: Re: [RFC v3 5/7] mm/damon-test: Add kunit test case for regions age accounting
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, aarcange@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, brendan.d.gregg@gmail.com, cai@lca.pw,
        Colin King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name,
        Mark Rutland <mark.rutland@arm.com>, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 2:25 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> After merges of regions, each region should know their last shape in
> proper way to measure the changes from the last modification and reset
> the age if the changes are significant.  This commit adds kunit test
> cases checking whether the regions are knowing their last shape properly
> after merges of regions.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

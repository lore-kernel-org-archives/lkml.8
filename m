Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D09AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9720734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsT+DFYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFCVHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgFCVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:07:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 14:07:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so2496935pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eS1jlrF5dIoVCt2cap3U6PGFm0QYhhEb3nQkUTWhvqk=;
        b=RsT+DFYT6D5YsWzVi4cljkX8CV3M1DCiDfa7l7cRw1So9ilwxqWZPtREFmfeqfhhfQ
         viydwlm+nm3TKNhE+jQ3EvVLiGeHBBl1v1jPl8f8R3H0swgAKjUSCNs01d7E/b1GwE5L
         l0Xt2PdLhRSGqYrZipRsJUfxEGYTqEnRTbR0i4K7eOhr9soRf1TYS7uWa2Ve3ibKhDS0
         oJjh4n5FUeaugSBkB2Ul1oDC4UY8AIBCQI2xFkE148+o4QVMyvq7+BZeHLHQ/tuxzrgQ
         48yMpapCdgGy7G07EDRgCteGx+olUDymyJ6aGB7dUPGFvsuO9fGlHIyyzR155+uK7rph
         IUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eS1jlrF5dIoVCt2cap3U6PGFm0QYhhEb3nQkUTWhvqk=;
        b=bQdU98+s39mbZngWalipcbIps38Rkospf0x566xkZ6bhw8YMRncBMFZm1kwEqFrAdC
         mlzbhUMgY285WHIFxrgrRUlfgJ6F9EABOyFd9QbwW9Aib8qbbNOpxAppKuJ584aHvq+e
         4muP2KaJhFNiIVJntn4YsFG0LBwGF/I2d7EDhA4A+1dZYHCP4CYtFrQg1eOC1efsPgGH
         T7x1v+Ri85km+aifdRu8Umo5yrjfrjuRdjcG5QgWeXntt75rR5hSJLvWAut9UTsKJREF
         w+070CnBIBzHHkDL+6aAB6UEZ3uhO/gzDHN2jWLeGIwzO83xyv8YifLCSNoL+GilGKa8
         i5WQ==
X-Gm-Message-State: AOAM532FlfAAFLXu0Y2jr0pVb1HNFgcGnwHqLBgzsPVaOg9WAMHdMWMI
        a02xsogydnQ/Jx/5sY/1QHyGAMKIy28AyxBa3x5dqQ==
X-Google-Smtp-Source: ABdhPJzZ+Jd+/4HzFp2FSwwqa538R5MLRSyoU0QMAzZ5btgctS4vtQVLIOIwG8x59wIaAeIvxlcFBKtLlfOmH1eJvPg=
X-Received: by 2002:a63:d04b:: with SMTP id s11mr1183851pgi.384.1591218459042;
 Wed, 03 Jun 2020 14:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd5g447MLhQ5F2MeizMEM+V1kSUY7Cqjp-1XxrfdLvEzxXFEg@mail.gmail.com>
 <20200603124203.22719-1-sjpark@amazon.com>
In-Reply-To: <20200603124203.22719-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Jun 2020 14:07:28 -0700
Message-ID: <CAFd5g45Wnwtv50AdekYjmBrJxE9UVDGRZptF9VsGnsfBwPtZ_A@mail.gmail.com>
Subject: Re: Re: [PATCH v14 13/15] mm/damon-test: Add a kunit test for
 recording setup
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        brendan.d.gregg@gmail.com, cai@lca.pw,
        Colin King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, kirill@shutemov.name,
        Mark Rutland <mark.rutland@arm.com>, mgorman@suse.de,
        minchan@kernel.org, Ingo Molnar <mingo@redhat.com>,
        namhyung@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, riel@surriel.com,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, sblbir@amazon.com,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 5:42 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On Tue, 2 Jun 2020 13:28:03 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:
>
> > On Tue, Jun 2, 2020 at 6:16 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > This commit adds another unit test case for the recording setup.
> > >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> Thanks for the review!  As the previous patch is also for the kunit test and it
> already received your 'Reviewed-by', I would like to merge this patch into the
> previous one in the next spin.  If there is any problem, please let me know.

No problem. Feel free to do so.

Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D354C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D320663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZ4Hx50p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgFVRAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbgFVRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:00:13 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E9C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:00:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so20124525lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQdYXJJ8aajHEyxPlujyQj7k2waV2Qojg9Cpu5IO7Ac=;
        b=CZ4Hx50pgYSwjX86Sz3Ki8gsPln+cIso6QohnxyYMXqgFyLQUuuasfGy+DnE+mfAea
         CNOOqSN/KbV/EeEVGSBT4EQ8zq4H4ekwe7blTVPm24QVg590wmVnzrAGoT+xkvETsqbo
         yTh+b9i1xqIMhXUkOljpe+dU6JzWpwcwWSWILoAmRlQhbgpr5yAHJnkCL6cWxaXXLgjK
         C4c15V4srZutZn9om8u86xB9Jpu6auEEE4G2L/s61Xmb2X3JOl8ji7orGkY116hmLbnt
         4cm48rmPk7ETc0JBTN/7BrPnCbDw8dC3lJ5OsiNYj1SlmP6jK0fKzF2XMw6ibOPsMOz9
         ZyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQdYXJJ8aajHEyxPlujyQj7k2waV2Qojg9Cpu5IO7Ac=;
        b=hKVwh0X1qyp2r0FTfn5PlydFfTUnCnd3WAFOglWX6QFmQ0y/mbxU9F+wzZWFZj8IbE
         hzLwpatWIdRVRl9Cq7Hu4RucVM3wsMY6ViWeU4l0QehUnS3dHSymFGz/sdS2ftKhobVS
         ewtGyKtg6Rld2p38iCVes+gFj3L9hILkVAvlQgYfmSWNFYIVFNKJRd7VxA973zYag6/J
         cQ/oa9nuD42mYsU5s9V7HWHFMqmPfh6y/dQD9BBBlfsE7fVzDBDM3+IeKcWOO2oLJbjO
         KvhjIi/Ma96rypNqxfcg3aCWntaBxdy/rFpjc1ekPJS4tQPLqDc89cd0ZBwsEY0OC1Nw
         7/EQ==
X-Gm-Message-State: AOAM5315ujlUKFCJiUkk29eM4J2Mn8I6P6z7jvb9gKIicXPygbpKZZ1B
        33lwxE+fDmOhuAzNuSf/c0fKhj4QmbsOm+J1zRrf0g==
X-Google-Smtp-Source: ABdhPJxCjr67KOVAvgelXLOnHbou/HOig3TyYJq0uDo7cKOOn21uwlrk4DgmE0FNmEKeeYB5Anah1zrf1c4T3gJX0FM=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr9485607ljg.332.1592845211583;
 Mon, 22 Jun 2020 10:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200615161927.12637-1-sjpark@amazon.com> <20200622084054.23445-1-sjpark@amazon.com>
In-Reply-To: <20200622084054.23445-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 10:00:00 -0700
Message-ID: <CALvZod7j=8YJ2OJtujrdKVP3CmvG9jSLGnKvMMcVX5fWYhEpoQ@mail.gmail.com>
Subject: Re: [PATCH v16 00/14] Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
        mark.rutland@arm.com, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, sblbir@amazon.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

On Mon, Jun 22, 2020 at 1:42 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> Last week, this patchset received 5 'Reviewed-by' tags, but no further comments
> for changes.  I updated the documentation, but the change is only small.  For
> the reason, I'm only asking more reviews rather than posting the whole series
> again.  Any comment is welcome.
>
>
> Thanks,
> SeongJae Park


This is on my review TODO list and I will get to it in a couple of
days. No need to post new versions.

thanks,
Shakeel

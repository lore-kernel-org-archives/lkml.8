Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79162C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552C820678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="KqIgm1YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbgDNQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391697AbgDNQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:31:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F65C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:31:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so13859344qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VLlqU4q1Tg1FlNFBFuJbOrDiNdW49LDEweZ01PUJ+98=;
        b=KqIgm1YWeupPQ5AKLZtSk0DWobRLAyx4G0DicpwgPEuui+DlaMsDiKTWKhHut76tPe
         cYkvg60mA+l32MQOTN2Yo9cr2x9SfF7mZFyW2bPkKGoWpB9W4i9Fg/XLdxsyHIRG6xIv
         Vdu9Te/V8atdgTrrO4LzPtLZ5EpU2OptdF7l28ADsB3fiAaEBk922FWRSmKrVCt6HG0T
         xX+N2nBIgTpHnzmZk3oEfPv09qpNqpyFn1/hmFKdTUV/HIjx0pv9hZkhSNQb2tcIGmmd
         fw0D7qs3MC9hPJXIiHPKn2r0dwccVBsgYR0SfZ5+96775nW8w/RprUF1bKur1zG/sKiy
         6YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VLlqU4q1Tg1FlNFBFuJbOrDiNdW49LDEweZ01PUJ+98=;
        b=kgU/Kd38GKa87JAhIfkBqJtw/t2bTJO0V4aeqUjmky83QQ+9p7HYX4HenKRpPxA0RL
         J9Zp/+GJafIZwtDgl6A6hUglFS3N8SyZj0KR8p+b9ehZBU71DVi9uXhJ2ELNm4YMiplX
         pNZoUIz7en6gqdFRFZQ8i+C8hVcT+NWeAAxB6z45c2UyCz2r1mg3GIoAQfFvBErkM/eP
         RMSC8YBBFK4FEJhZNYYcnjev9er+tIyxe5xczXZlsLUTWMTNNcXVIri9y0LNPflGEqqY
         WDgVEecrxXXeo9Bto0c3h8Objv2Sj1h9ZbaO7vJyKmnmdVza6HrVvb/Bb7V8bfvlm0hR
         KYuA==
X-Gm-Message-State: AGi0PuaBVEWAV6gVip0bPClaMLWkQrN/Tl3zlhrAiWLbrus3wHTOXUGA
        048ULx2unOi/fjqOVD54KYXf8w==
X-Google-Smtp-Source: APiQypJC4xDXZh2RTbpe7APa2bCoLe+wBervVwS7oEjfiQ4YylFde7I8dO9567LUfW0QyczZeiX5wQ==
X-Received: by 2002:a37:4a85:: with SMTP id x127mr22454961qka.152.1586881876177;
        Tue, 14 Apr 2020 09:31:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id s14sm8027858qts.70.2020.04.14.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:31:15 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:31:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200414163114.GA136578@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:52:30PM +0800, Alex Shi wrote:
> 在 2020/4/14 上午2:07, Johannes Weiner 写道:
> > Plus, the overhead of tracking is tiny - 512k per G of swap (0.04%).
> > 
> > Maybe we should just delete MEMCG_SWAP and unconditionally track swap
> > entry ownership when the memory controller is enabled. I don't see a
> > good reason not to, and it would simplify the entire swapin path, the
> > LRU locking, and the page->mem_cgroup stabilization rules.
> > 
> 
> Sorry for not follow you up, did you mean just remove the MEMCG_SWAP configuration
> and keep the feature in default memcg? 

Yes.

> That does can remove lrucare, but PageLRU lock scheme still fails since
> we can not isolate the page during commit_charge, is that right?

No, without lrucare the scheme works. Charges usually do:

page->mem_cgroup = new;
SetPageLRU(page);

And so if you can TestClearPageLRU(), page->mem_cgroup is stable.

lrucare charging is the exception: it changes page->mem_cgroup AFTER
PageLRU has already been set, and even when it CANNOT acquire the
PageLRU lock itself. It violates the rules.

If we make MEMCG_SWAP mandatory, we always have cgroup records for
swapped out pages. That means we can charge all swapin pages
(incl. readahead pages) directly in __read_swap_cache_async(), before
setting PageLRU on the new pages.

Then we can delete lrucare.

And then TestClearPageLRU() guarantees page->mem_cgroup is stable.

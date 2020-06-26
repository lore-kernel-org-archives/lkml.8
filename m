Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C911D207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gIbnxLuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFZNfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:35:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA4C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:35:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so8731512qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xn71QFIb8qusqk6JAn4tYu6VJ7+zbg7ZI59cESgAEKE=;
        b=gIbnxLujnMPTJPjMstwtM2cv7Rg3sVR0z1lIPDXa8D7lyOP07aknCWIcE/IxySeEIU
         veQNeet69QpvCzaEZE4pQTtSZPKdpX00B0oDOOgBVb+oMii3xGkjsi6QCaj/r8b8Sqdn
         PZ7C+Qx0WdXJdne4PscOqu6s4HUhVM3XW5SdWohXtrF4/Mrr2PNhkL5uApP5igTlZeqa
         QNIvHj051iT9uhr6+D01oitcmxXsxMdji7rXRFYD9+mSeR7AlnUSCRsMslcn2LIntanc
         2EJnJoGS/4C5kZTqQvMZzc/MranpZiVywjgCML/r7lqyRec6k4ubnmLAeXuHKzZuwK/s
         4yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xn71QFIb8qusqk6JAn4tYu6VJ7+zbg7ZI59cESgAEKE=;
        b=GPX7pNtxEvISKZuWiR0DyuREaklWEPCFygQY+Xm8R7Db8BtrLYxJodI+e4D7pQaZEy
         u4JuzgBTsWbHUIJIbfiQIQu6lsAS+Kwedg/wvEn8TYNnpQzdX4nIjTwdstSTxrMevV0W
         OBvJMGBdGNoP+Nfurr9Ih6YLMvmccaEEzwSM/JJ4TODNvpLW3EhUtYS2JPEuJaV1AyeP
         DLjGkWDRF3hjHxkvP5sbU3huN6qAoXVURXVmENlfnIbBu8uEG3+pf6NI07hGD0m+A0iz
         Cmn7d+ZioWRiTZZLPuTI8sTFkSxK/MhjLvwK+8jfotpmmlEodCUoNcoewoCnJmMSm0+P
         UGdA==
X-Gm-Message-State: AOAM533Or2t4pdujVElm+enaO7R0cQPXgPRxheIPlBW14lLheRPlknQ5
        AP+3q7jA3N6wDOX+clqXOF++mEOq754LIg==
X-Google-Smtp-Source: ABdhPJzrPtm0RKVTxghv+yE8IvD/PfDgFvmqJDyTjnDquuanCkcbhkwlgua0WRtE1UBAddUHUYWpFw==
X-Received: by 2002:a37:46ca:: with SMTP id t193mr2727669qka.293.1593178530579;
        Fri, 26 Jun 2020 06:35:30 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v45sm9773254qtv.47.2020.06.26.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:35:29 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:35:21 -0400
From:   Qian Cai <cai@lca.pw>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Message-ID: <20200626133521.GA3933@lca.pw>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:01:22PM +0000, nao.horiguchi@gmail.com wrote:
> I rebased soft-offline rework patchset [1][2] onto the latest mmotm.  The
> rebasing required some non-trivial changes to adjust, but mainly that was
> straightforward.  I confirmed that the reported problem doesn't reproduce on
> compaction after soft offline.  For more precise description of the problem
> and the motivation of this patchset, please see [2].
> 
> I think that the following two patches in v2 are better to be done with
> separate work of hard-offline rework, so it's not included in this series.
> 
>   - mm,hwpoison: Take pages off the buddy when hard-offlining
>   - mm/hwpoison-inject: Rip off duplicated checks
> 
> These two are not directly related to the reported problem, so they seems
> not urgent.  And the first one breaks num_poisoned_pages counting in some
> testcases, and The second patch needs more consideration about commented point.
> 
> Any comment/suggestion/help would be appreciated.

Next-20200626 failed to compile due to this series. Reverting the whole
thing [1] will fix the issue below right away,

mm/memory-failure.c: In function ‘__soft_offline_page’:
mm/memory-failure.c:1827:3: error: implicit declaration of function ‘page_handle_poison’; did you mean ‘page_init_poison’? [-Werror=implicit-function-declaration]
   page_handle_poison(page, false, true);
   ^~~~~~~~~~~~~~~~~~
   page_init_poison

.config used,

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

[1] git revert --no-edit f296ba1d3a07..0bd1762119e9

> 
> [1] v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> [2] v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
> 
> Thanks,
> Naoya Horiguchi
> ---
> Summary:
> 
> Naoya Horiguchi (7):
>       mm,hwpoison: cleanup unused PageHuge() check
>       mm, hwpoison: remove recalculating hpage
>       mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
>       mm,hwpoison-inject: don't pin for hwpoison_filter
>       mm,hwpoison: remove MF_COUNT_INCREASED
>       mm,hwpoison: remove flag argument from soft offline functions
>       mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
> 
> Oscar Salvador (8):
>       mm,madvise: Refactor madvise_inject_error
>       mm,hwpoison: Un-export get_hwpoison_page and make it static
>       mm,hwpoison: Kill put_hwpoison_page
>       mm,hwpoison: Unify THP handling for hard and soft offline
>       mm,hwpoison: Rework soft offline for free pages
>       mm,hwpoison: Rework soft offline for in-use pages
>       mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
>       mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
> 
>  drivers/base/memory.c      |   2 +-
>  include/linux/mm.h         |  12 +-
>  include/linux/page-flags.h |   6 +-
>  include/ras/ras_event.h    |   3 +
>  mm/hwpoison-inject.c       |  18 +--
>  mm/madvise.c               |  39 +++---
>  mm/memory-failure.c        | 331 ++++++++++++++++++++-------------------------
>  mm/migrate.c               |  11 +-
>  mm/page_alloc.c            |  63 +++++++--
>  9 files changed, 233 insertions(+), 252 deletions(-)
> 

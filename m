Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3569FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7904820A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LgobU2Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgHCTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:07:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:07:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r19so9354173qvw.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IeBeldkRrD22fvtVV+mtMkDymTt3dfsj1i9JtKFUgrs=;
        b=LgobU2BcYYKuG6B8AnOxZfRg39IVR5X8Vi10uHdQntG/+aYk9OlFOnd7P+q8E0tHxn
         KP0FaBkUp8au6PBybfIWTQr1xhZPsLfKQLV2kg+J9s7XfDBFJDwBmUj5Skv3WKtEY6TO
         c1uhGQ/QZEgByVTPbynKoY9F/EpdoqEf/JCS1bwETiKc/uoCL1t735GIFiV7eEVa8Fp0
         IamCh8tZkZVsOig1zYzcerc7fjtwDwqylJm8LK/Inhyl43bCBxKnv0/TiVsSEV8ev3q3
         WdN0KUguuLvcBbpzQbYpaG8Fmzbda1+kfLcFuFYlWPY4lMdJDnwI5EqCFdfUiHZwz66r
         4FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IeBeldkRrD22fvtVV+mtMkDymTt3dfsj1i9JtKFUgrs=;
        b=OXLYsz1KeZmQ97RcjXDY36kQ7B3FdYZXsOCa1Dhic3oPk8QCKyK8lLVVhgvw7M2MCc
         TnwVWvceI4jowPvSJ7UTRAp1LN0DBDdKfJQmuxo1USrSbS2ObfMe/or1T0ahp8uoHFJ5
         CyrnD8fYDsb58cETwYLVZ0RMmwzOCj+cjVqGeOIPmoRAF8dVd88G86HC7bVPg49YEwFo
         mcMoJ026ZIFB6vJYhlN77xE3faFc4THTvDgyT9qb36h0rEhwrehO1LR5hcGFTaJgSktp
         vVCcmolhV8hly1qfz9fZRY92FDTJnQv2rZNnprZboJMI4SbhXJCfXWlJC6KPljq012n9
         mdUQ==
X-Gm-Message-State: AOAM533ww9NAZx5JpPghvRabQ+8NeMsPoa/z+P2hesDsgs/em4fnRGWo
        3fOhWRqWy1m75pfSdCUVUOJKHg==
X-Google-Smtp-Source: ABdhPJx+ygbPhzrgcXU8FME7EhJ/fFVN7a4A/Dw5d7AMubrpNsjNqgEuAMMDdWmZsfvGiEM3HsdB8g==
X-Received: by 2002:a0c:ac4c:: with SMTP id m12mr18784977qvb.218.1596481632707;
        Mon, 03 Aug 2020 12:07:12 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b23sm19414471qtp.41.2020.08.03.12.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:07:12 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:07:09 -0400
From:   Qian Cai <cai@lca.pw>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
Message-ID: <20200803190709.GB8894@lca.pw>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:20:56PM +0000, nao.horiguchi@gmail.com wrote:
> This patchset is the latest version of soft offline rework patchset
> targetted for v5.9.
> 
> Main focus of this series is to stabilize soft offline.  Historically soft
> offlined pages have suffered from racy conditions because PageHWPoison is
> used to a little too aggressively, which (directly or indirectly) invades
> other mm code which cares little about hwpoison.  This results in unexpected
> behavior or kernel panic, which is very far from soft offline's "do not
> disturb userspace or other kernel component" policy.
> 
> Main point of this change set is to contain target page "via buddy allocator",
> where we first free the target page as we do for normal pages, and remove
> from buddy only when we confirm that it reaches free list. There is surely
> race window of page allocation, but that's fine because someone really want
> that page and the page is still working, so soft offline can happily give up.
> 
> v4 from Oscar tries to handle the race around reallocation, but that part
> seems still work in progress, so I decide to separate it for changes into
> v5.9.  Thank you for your contribution, Oscar.
> 
> The issue reported by Qian Cai is fixed by patch 16/16.
> 
> This patchset is based on v5.8-rc7-mmotm-2020-07-27-18-18, but I applied
> this series after reverting previous version.
> Maybe https://github.com/Naoya-Horiguchi/linux/commits/soft-offline-rework.v5
> shows what I did more precisely.
> 
> Any other comment/suggestion/help would be appreciated.

There is another issue with this patchset (with and without the patch [1]).

[1] https://lore.kernel.org/lkml/20200803133657.GA13307@hori.linux.bs1.fc.nec.co.jp/

Arm64 using 512M-size hugepages starts to fail allocations prematurely.

# ./random 1
- start: migrate_huge_offline
- use NUMA nodes 0,1.
- mmap and free 2147483648 bytes hugepages on node 0
- mmap and free 2147483648 bytes hugepages on node 1
madvise: Cannot allocate memory

[  284.388061][ T3706] soft offline: 0x956000: hugepage isolation failed: 0, page count 2, type 17ffff80001000e (referenced|uptodate|dirty|head)
[  284.400777][ T3706] Soft offlining pfn 0x8e000 at process virtual address 0xffff80000000
[  284.893412][ T3706] Soft offlining pfn 0x8a000 at process virtual address 0xffff60000000
[  284.901539][ T3706] soft offline: 0x8a000: hugepage isolation failed: 0, page count 2, type 7ffff80001000e (referenced|uptodate|dirty|head)
[  284.914129][ T3706] Soft offlining pfn 0x8c000 at process virtual address 0xffff80000000
[  285.433497][ T3706] Soft offlining pfn 0x88000 at process virtual address 0xffff60000000
[  285.720377][ T3706] Soft offlining pfn 0x8a000 at process virtual address 0xffff80000000
[  286.281620][ T3706] Soft offlining pfn 0xa000 at process virtual address 0xffff60000000
[  286.290065][ T3706] soft offline: 0xa000: hugepage migration failed -12, type 7ffff80001000e (referenced|uptodate|dirty|head)

Reverting this patchset and its dependency patchset [2] (reverting the
dependency alone did not help) fixed it,

# ./random 1
- start: migrate_huge_offline
- use NUMA nodes 0,1.
- mmap and free 2147483648 bytes hugepages on node 0
- mmap and free 2147483648 bytes hugepages on node 1
- pass: mmap_offline_node_huge

[2] https://lore.kernel.org/linux-mm/1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com/ 

> 
> Thanks,
> Naoya Horiguchi
> ---
> Previous versions:
>   v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
>   v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
>   v3: https://lore.kernel.org/linux-mm/20200624150137.7052-1-nao.horiguchi@gmail.com/
>   v4: https://lore.kernel.org/linux-mm/20200716123810.25292-1-osalvador@suse.de/
> ---
> Summary:
> 
> Naoya Horiguchi (8):
>       mm,hwpoison: cleanup unused PageHuge() check
>       mm, hwpoison: remove recalculating hpage
>       mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
>       mm,hwpoison-inject: don't pin for hwpoison_filter
>       mm,hwpoison: remove MF_COUNT_INCREASED
>       mm,hwpoison: remove flag argument from soft offline functions
>       mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
>       mm,hwpoison: double-check page count in __get_any_page()
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
>  mm/memory-failure.c        | 334 ++++++++++++++++++++-------------------------
>  mm/migrate.c               |  11 +-
>  mm/page_alloc.c            |  60 ++++++--
>  9 files changed, 233 insertions(+), 252 deletions(-)

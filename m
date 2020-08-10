Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AACB207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Cp9vxR/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgHJPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgHJPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:22:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56719C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:22:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o22so6982166qtt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=srW8JC4OGMffK9uy0eYrT8jtz9Osn+rCW418a4Q3BXw=;
        b=Cp9vxR/L94JlasdStrT2WqaBv+NMta2KiGO/xF5jxESwWDMM2WIVIiuZNB/8ZmMt8s
         abAply+auG+EFLF55gjNORKv4HMfgBCcavovvBd3PdtLna5CpBJBty0Tuh7okwnqWaU+
         Y/+KpUQ3ymS/WV4IHiOoI3aIEhcGrawtw7HywSkw5JVmmHhiTgdU5HAhJPsJvAxjyHzt
         2Gw6Wn3JhLjZOO3pYYy63Dsu5iGf0dc3cOUgIjDSTTfqkTX+EG6yWMZr1pFzOMUUOzEx
         25j0PyEgFvkp7cVoXvdv1X5y34fDqYDegSERjc1F8F+cNWEMzBe4KAed3bGx/5R8jaMt
         STEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srW8JC4OGMffK9uy0eYrT8jtz9Osn+rCW418a4Q3BXw=;
        b=Ch3IYbtXJJrQ6/UY0vuG6jWsXvOsX+r+JzSmzcPfzMGQQ4K1l60eBV8Iqt3OfFI5d0
         MYEFTbMHY+l5Ol3YiAS8s1TcEvF56vnJdWIZBOWqHVS0376mzO0+lX/q5/bD31r/bFA0
         oWZWOpz64YwTuYkZYlGqSvnVmdtaqrtaHaMGLm2ECmy7NzE3MF5GRHSLbJ/GeaNbG4C5
         7SsFj9CqR1q86UjYRewl6XuP3571qSQd6pHEgnl2ulOdzVO0mcLi1TwMUyEMSjnAVqYJ
         pOnsCeymE6EybMAV25o2f6qRJ/2CINZl91/qXUqkUXVEdiZQKYaVv9jpBQQgsjWsqpjz
         Vjiw==
X-Gm-Message-State: AOAM531K72wik2ARB6xmpb3HVuNb2dTMwgI7JswDTg2MqtRmAAkTYXUW
        jpus4dVsqKEXRJcSC3SzQJy7rQ==
X-Google-Smtp-Source: ABdhPJw5TBWS4UhDxulilFNmHHpADVn74rXj3bxQo1n1OihbcPe2ePr2Lgy52fq9OjWMF6W9audo0A==
X-Received: by 2002:ac8:1729:: with SMTP id w38mr27932185qtj.103.1597072978450;
        Mon, 10 Aug 2020 08:22:58 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o15sm13738608qkk.95.2020.08.10.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:22:57 -0700 (PDT)
Date:   Mon, 10 Aug 2020 11:22:55 -0400
From:   Qian Cai <cai@lca.pw>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH v6 00/12] HWPOISON: soft offline rework
Message-ID: <20200810152254.GC5307@lca.pw>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:49:11PM +0000, nao.horiguchi@gmail.com wrote:
> Hi,
> 
> This patchset is the latest version of soft offline rework patchset
> targetted for v5.9.
> 
> Since v5, I dropped some patches which tweak refcount handling in
> madvise_inject_error() to avoid the "unknown refcount page" error.
> I don't confirm the fix (that didn't reproduce with v5 in my environment),
> but this change surely call soft_offline_page() after holding refcount,
> so the error should not happen any more.

With this patchset, arm64 is still suffering from premature 512M-size hugepages
allocation failures.

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random 1
- start: migrate_huge_offline
- use NUMA nodes 0,1.
- mmap and free 2147483648 bytes hugepages on node 0
- mmap and free 2147483648 bytes hugepages on node 1
madvise: Cannot allocate memory

[  292.456538][ T3685] soft offline: 0x8a000: hugepage isolation failed: 0, page count 2, type 7ffff80001000e (referenced|uptodate|dirty|head)
[  292.469113][ T3685] Soft offlining pfn 0x8c000 at process virtual address 0xffff60000000
[  292.983855][ T3685] Soft offlining pfn 0x88000 at process virtual address 0xffff40000000
[  293.271369][ T3685] Soft offlining pfn 0x8a000 at process virtual address 0xffff60000000
[  293.834030][ T3685] Soft offlining pfn 0xa000 at process virtual address 0xffff40000000
[  293.851378][ T3685] soft offline: 0xa000: hugepage migration failed -12, type 7ffff80001000e (referenced|uptodate|dirty|head)

The fresh-booted system still had 40G+ memory free before running the test.

Reverting the following commits allowed the test to run succesfully over and over again.

"mm, hwpoison: remove recalculating hpage"
"mm,hwpoison-inject: don't pin for hwpoison_filter"
"mm,hwpoison: Un-export get_hwpoison_page and make it static"
"mm,hwpoison: kill put_hwpoison_page"
"mm,hwpoison: unify THP handling for hard and soft offline"
"mm,hwpoison: rework soft offline for free pages"
"mm,hwpoison: rework soft offline for in-use pages"
"mm,hwpoison: refactor soft_offline_huge_page and __soft_offline_page"

i.e., it is not enough to only revert,

mm,hwpoison: double-check page count in __get_any_page()
mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
mm,hwpoison: return 0 if the page is already poisoned in soft-offline

> 
> Dropped patches
> - mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
> - mm,madvise: Refactor madvise_inject_error
> - mm,hwpoison: remove MF_COUNT_INCREASED
> - mm,hwpoison: remove flag argument from soft offline functions
> 
> Thanks,
> Naoya Horiguchi
> 
> Quoting cover letter of v5:
> ----
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
> ---
> Previous versions:
>   v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
>   v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
>   v3: https://lore.kernel.org/linux-mm/20200624150137.7052-1-nao.horiguchi@gmail.com/
>   v4: https://lore.kernel.org/linux-mm/20200716123810.25292-1-osalvador@suse.de/
>   v5: https://lore.kernel.org/linux-mm/20200805204354.GA16406@hori.linux.bs1.fc.nec.co.jp/T/#t
> ---
> Summary:
> 
> Naoya Horiguchi (5):
>       mm,hwpoison: cleanup unused PageHuge() check
>       mm, hwpoison: remove recalculating hpage
>       mm,hwpoison-inject: don't pin for hwpoison_filter
>       mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
>       mm,hwpoison: double-check page count in __get_any_page()
> 
> Oscar Salvador (7):
>       mm,hwpoison: Un-export get_hwpoison_page and make it static
>       mm,hwpoison: Kill put_hwpoison_page
>       mm,hwpoison: Unify THP handling for hard and soft offline
>       mm,hwpoison: Rework soft offline for free pages
>       mm,hwpoison: Rework soft offline for in-use pages
>       mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
>       mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
> 
>  include/linux/mm.h         |   3 +-
>  include/linux/page-flags.h |   6 +-
>  include/ras/ras_event.h    |   3 +
>  mm/hwpoison-inject.c       |  18 +--
>  mm/madvise.c               |   5 -
>  mm/memory-failure.c        | 307 +++++++++++++++++++++------------------------
>  mm/migrate.c               |  11 +-
>  mm/page_alloc.c            |  60 +++++++--
>  8 files changed, 203 insertions(+), 210 deletions(-)

Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8734DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E4C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VSkxZqha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHCMkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgHCMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:40:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97821C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:40:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so27777058qtt.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BmbNE1buq5pXcu816xflWCrMTaLO2MZ62sTduj5sEmM=;
        b=VSkxZqhaTCw4jfRyyQHX5mduSPeV5UA3aoGAvElI/iRjr65POS1bMBjuPEedZWp+SO
         C4EvSD/S2+UBh9Ns39vOKEEMt1ZyQvTmCqKxSp3ZkqIIVwqeVxi9wNRK21BunM/zL3ej
         Qknk6EO15PutwX7PphSt6bIi7NfG8yffH+b3Nbk2Vgy6y5LmDqC8vs3MZ+U/NpRta1cu
         sfuLDQPBLHlx69c5XaK8rxcJJXczKkmyXM/w8sUJI938iD8IyRgTtlfVBMiDqoVMAuJd
         R+A2reXsFP1Ch9hLmrW7bY7wau6OdvCfZsTQ+zqpehQk8/lGLWmeP27daKGQ4spZaVbx
         NftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BmbNE1buq5pXcu816xflWCrMTaLO2MZ62sTduj5sEmM=;
        b=rS3qVVeps8e07xhgQxMLOxgVAatkYtChEo9omznBxf4jkBSakyfibCa/rTyITz7s95
         icQ+AC2kyS8wYUlUC3lifUGj6xi1ca0lx9hOou4cF6OOburbR454Azx+q/c4pIiIHYC3
         5XogWV4mRQ+Os0vYa8JixNDXvL2bd/LaLYBFhyhfTKZfSPzAdO4w3ZAC5cSEg8ZCU2fw
         AA1pt6ZecY04u5W7RN3rj24xy/c1vGBtJRw0YCChStiVQtbbREC8c4+69pMgucIXvDsM
         uZnqjCxjkPlrhC/CxtOtfzhCkPBZ6BhRUtIgFnPMLL2d4Qb4z4NpEUN/V0JQO+NbVeMf
         3y0A==
X-Gm-Message-State: AOAM5335QnNewcyR+jiYr2oZf2qUqmDx9bc1H33kF6y4a7+Xjt3SfUcJ
        prqQklCEzdc98GK/YxsWhYLq3w==
X-Google-Smtp-Source: ABdhPJyhP67WF654Q74haL5NM8BWjv2KU6FvcKM6NkYKcXg94B+h3ml0rPibaS3+uUc0lRUK6X+r0w==
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr16595368qta.146.1596458402728;
        Mon, 03 Aug 2020 05:40:02 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z197sm20327163qkb.66.2020.08.03.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:40:01 -0700 (PDT)
Date:   Mon, 3 Aug 2020 08:39:55 -0400
From:   Qian Cai <cai@lca.pw>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
Message-ID: <20200803123954.GA4631@lca.pw>
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

I am still getting EIO everywhere on next-20200803 (which includes this v5).

# ./random 1
- start: migrate_huge_offline
- use NUMA nodes 0,8.
- mmap and free 8388608 bytes hugepages on node 0
- mmap and free 8388608 bytes hugepages on node 8
madvise: Input/output error

From the serial console,

[  637.164222][ T8357] soft offline: 0x118ee0: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
[  637.164890][ T8357] Soft offlining pfn 0x20001380 at process virtual address 0x7fff9f000000
[  637.165422][ T8357] Soft offlining pfn 0x3ba00 at process virtual address 0x7fff9f200000
[  637.166409][ T8357] Soft offlining pfn 0x201914a0 at process virtual address 0x7fff9f000000
[  637.166833][ T8357] Soft offlining pfn 0x12b9a0 at process virtual address 0x7fff9f200000
[  637.168044][ T8357] Soft offlining pfn 0x1abb60 at process virtual address 0x7fff9f000000
[  637.168557][ T8357] Soft offlining pfn 0x20014820 at process virtual address 0x7fff9f200000
[  637.169493][ T8357] Soft offlining pfn 0x119720 at process virtual address 0x7fff9f000000
[  637.169603][ T8357] soft offline: 0x119720: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
[  637.169756][ T8357] Soft offlining pfn 0x118ee0 at process virtual address 0x7fff9f200000
[  637.170653][ T8357] Soft offlining pfn 0x200e81e0 at process virtual address 0x7fff9f000000
[  637.171067][ T8357] Soft offlining pfn 0x201c5f60 at process virtual address 0x7fff9f200000
[  637.172101][ T8357] Soft offlining pfn 0x201c8f00 at process virtual address 0x7fff9f000000
[  637.172241][ T8357] __get_any_page: 0x201c8f00: unknown zero refcount page type 87fff8000000000

> 
> This patchset is based on v5.8-rc7-mmotm-2020-07-27-18-18, but I applied
> this series after reverting previous version.
> Maybe https://github.com/Naoya-Horiguchi/linux/commits/soft-offline-rework.v5
> shows what I did more precisely.
> 
> Any other comment/suggestion/help would be appreciated.
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

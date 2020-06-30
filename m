Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BCDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861CC20720
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QXbYQ3PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgF3FIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgF3FIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:08:12 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420FC08C5DC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:08:11 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t7so8720144qvl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DSxnmPKX0MxVmbCefs4Hd9xUpYmSBeFrLYvEWBkx/fQ=;
        b=QXbYQ3PE0BBnr46trGaKFK0ymCesytNIPQ3pdrtevhDS2ZKOs497XmUeFmzGW7cN9N
         xJCWzd11KHCSvKcF3VhSKtf6Wn1wacnzlXX8RTi6ipgBBvoUZug+Fqubfl0JRPuTfwyd
         Z44vpuktTf6PJD/ZLELQ/fXnmdZuu/6LisUhkCg2dBQDoOVkl8msiSb67XtN287LRT14
         GUT92IPaQTHF2pv1SuFFKgeaQ94NrqtI35ri33NvHeZ6R5EyIUrCJ8I+Uy3ubss4+88Q
         nfON3Wbeu4JUnTWeCaKqmKI7GyHhNw+Tf7YQslVS0qZkDHSbHCJOmDIAoLASmeMU6YV7
         bmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DSxnmPKX0MxVmbCefs4Hd9xUpYmSBeFrLYvEWBkx/fQ=;
        b=rES3rjaqXj/pD58y/zBqY08knyBN45MA4QBZh1nIl0vdTyStlDf4tMnckeGTwD3qBh
         2yVTtffuJQoY4cbK/FuE5aOU3iDMJnWvb/NaIiLTNfCJULVz/XnqwqqyLOwx9ZhiFinY
         6dlbfqFlCNEYLM5YZTnUq0E+ina92j/fvzfwMz5361BOblZx11laRwepdMioTkz7wF/v
         oxC6Ray20J61tpsIyTyis4gxqKpcmKv1rA/ZZUyPfMSB4mP39IeXw4GO81iHHMDsZfrh
         tHnsesxpE2tH8xV9wGwTNYObu/CLCFZtfYefXc/seAfB80TqStIxxb2F53T/HCAIjpHX
         eJyQ==
X-Gm-Message-State: AOAM5305zqLx5zH+AF/S9AfVEAhEi23FxE2OPnxtSMQ9QfwHD9TYV8tM
        4T4BSjlGSnx33YYqObF8aCFzgQ==
X-Google-Smtp-Source: ABdhPJzpsl9pGhJPvelPiRyJzWTHAhRD4SCcaQX0HzhIlvxMPybROlPBfgSJuN/48jXfr4jIX8u+og==
X-Received: by 2002:ad4:42ad:: with SMTP id e13mr8751442qvr.89.1593493690534;
        Mon, 29 Jun 2020 22:08:10 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t5sm2115789qkh.46.2020.06.29.22.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 22:08:09 -0700 (PDT)
Date:   Tue, 30 Jun 2020 01:08:03 -0400
From:   Qian Cai <cai@lca.pw>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Message-ID: <20200630050803.GA2747@lca.pw>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Even after applied the compling fix,

https://lore.kernel.org/linux-mm/20200628065409.GA546944@u2004/

madvise(MADV_SOFT_OFFLINE) will fail with EIO with hugetlb where it
would succeed without this series. Steps:

# git clone https://github.com/cailca/linux-mm
# cd linux-mm; make
# ./random 1 (Need at least two NUMA memory nodes)
 start: migrate_huge_offline
- use NUMA nodes 0,4.
- mmap and free 8388608 bytes hugepages on node 0
- mmap and free 8388608 bytes hugepages on node 4
madvise: Input/output error

(x86.config is also included there.)

[10718.158548][T13039] __get_any_page: 0x1d1600 free huge page
[10718.165684][T13039] Soft offlining pfn 0x1d1600 at process virtual address 0x7f1dd2000000
[10718.175061][T13039] Soft offlining pfn 0x154c00 at process virtual address 0x7f1dd2200000
[10718.185492][T13039] Soft offlining pfn 0x137c00 at process virtual address 0x7f1dd2000000
[10718.195209][T13039] Soft offlining pfn 0x4c7a00 at process virtual address 0x7f1dd2200000
[10718.203483][T13039] soft offline: 0x4c7a00: hugepage isolation failed: 0, page count 2, type bfffc00001000f (locked|referenced|uptodate|dirty|head)
[10718.218228][T13039] Soft offlining pfn 0x4c7a00 at process virtual address 0x7f1dd2000000
[10718.227522][T13039] Soft offlining pfn 0x2da800 at process virtual address 0x7f1dd2200000
[10718.238503][T13039] Soft offlining pfn 0x1de200 at process virtual address 0x7f1dd2000000
[10718.247822][T13039] Soft offlining pfn 0x155c00 at process virtual address 0x7f1dd2200000
[10718.259031][T13039] Soft offlining pfn 0x203600 at process virtual address 0x7f1dd2000000
[10718.268504][T13039] Soft offlining pfn 0x417600 at process virtual address 0x7f1dd2200000
[10718.278830][T13039] Soft offlining pfn 0x20a600 at process virtual address 0x7f1dd2000000
[10718.288133][T13039] Soft offlining pfn 0x1d0800 at process virtual address 0x7f1dd2200000
[10718.299198][T13039] Soft offlining pfn 0x3e5800 at process virtual address 0x7f1dd2000000
[10718.308593][T13039] Soft offlining pfn 0x21f200 at process virtual address 0x7f1dd2200000
[10718.319725][T13039] Soft offlining pfn 0x18c600 at process virtual address 0x7f1dd2000000
[10718.329301][T13039] Soft offlining pfn 0x396a00 at process virtual address 0x7f1dd2200000
[10718.378882][T13039] Soft offlining pfn 0x4d5000 at process virtual address 0x7f1dd2000000
[10718.388415][T13039] Soft offlining pfn 0x4e5000 at process virtual address 0x7f1dd2200000
[10718.398807][T13039] Soft offlining pfn 0x2f5000 at process virtual address 0x7f1dd2000000
[10718.408236][T13039] Soft offlining pfn 0x50b400 at process virtual address 0x7f1dd2200000
[10718.419781][T13039] Soft offlining pfn 0x396800 at process virtual address 0x7f1dd2000000
[10718.429677][T13039] Soft offlining pfn 0xd69c00 at process virtual address 0x7f1dd2200000
[10718.440435][T13039] Soft offlining pfn 0x21f000 at process virtual address 0x7f1dd2000000
[10718.450341][T13039] Soft offlining pfn 0x399400 at process virtual address 0x7f1dd2200000
[10718.458768][T13039] __get_any_page: 0x399400: unknown zero refcount page type bfffc000000000

The main part is,
https://github.com/cailca/linux-mm/blob/master/random.c#L372

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

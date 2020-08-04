Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9586C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF68F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eiRVZLer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgHDBtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHDBtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:49:46 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 18:49:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so18302486qvk.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p8aoxtBKjpKezj0Xn3lJSuTf8xWXnxhNxmcUMANtU70=;
        b=eiRVZLerPMoajkB+s8SV6MJOuEFepX37u9gdFSD7tTDSLZCH6UiCaGomdDPi4aH+D4
         I1YJl2aQAVY1McIOo03pBEerWULuBbfafKLAPPb1elQHUmlLs+hTy5XxZrUvitCtXzoq
         X2kHhYBzK91YtZVg1TKj9PdcGhtE4fpfI9a/RAhkmHSN1fOp/0HYGuAzy4wFXHaNH7j/
         /ZpSwCZyMPEFQr0v2R5ARdKuOQnBFYfI52lPariD/SiSGIhrbkB+4m4WiC8aw4PXbaGI
         mF4TZzCyeH5vKBbcflbXPIeD1oa7DjVCFN0xe2MAZybfe9CD6eEBhEsXOpghVfpyINvD
         jsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p8aoxtBKjpKezj0Xn3lJSuTf8xWXnxhNxmcUMANtU70=;
        b=riwgS6dLDOmCdi3UyzWU4RU8eeFHzr/gOUudT17E20PhP7Ae8aIYWckuwnwpCDINVv
         HVi9Bv3aQRuBrzS3yjdbALzaBzLCWQE2St8TRsaTabv/TeaRzbvKPneRc+kw06lfV4hP
         WTNOiYoUAHGRo5vFvlKYVqwoxfww0ufAnsSsjh5puOYV+jY6Oal3owoNTJdWrJBiwBX4
         WAT6zkRVIUiRHHtqISJbVZVvvCZDTs3mWmKZsRsssv5+23YAsR4lfLOf494edZb1Ubue
         Wy49yK+vIHrF6zQxlhPdDtF9HNkJYojRnn+UqDz0Ks2cbkKRUfsCbAojFC1pJOYHJQTc
         bh/A==
X-Gm-Message-State: AOAM533Uz0djeSpaq2WUbSWS7EMBOc7K1i+WMSJHR66SkGBmtuaBY/kT
        lMa+3VEEUj7GAKedkgL0QRO2Gg==
X-Google-Smtp-Source: ABdhPJz+q1p2Tcfz3PzNsRFqQCW+MOXpujrRVRj8ngTDyJOShCooC24Z+RT39b2eYMvg0FzdS7QXIA==
X-Received: by 2002:a0c:8f12:: with SMTP id z18mr4130541qvd.153.1596505785818;
        Mon, 03 Aug 2020 18:49:45 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 78sm22222716qke.81.2020.08.03.18.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:49:45 -0700 (PDT)
Date:   Mon, 3 Aug 2020 21:49:42 -0400
From:   Qian Cai <cai@lca.pw>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
Message-ID: <20200804014942.GC8894@lca.pw>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803190709.GB8894@lca.pw>
 <20200804011644.GA25028@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804011644.GA25028@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:16:45AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Aug 03, 2020 at 03:07:09PM -0400, Qian Cai wrote:
> > On Fri, Jul 31, 2020 at 12:20:56PM +0000, nao.horiguchi@gmail.com wrote:
> > > This patchset is the latest version of soft offline rework patchset
> > > targetted for v5.9.
> > > 
> > > Main focus of this series is to stabilize soft offline.  Historically soft
> > > offlined pages have suffered from racy conditions because PageHWPoison is
> > > used to a little too aggressively, which (directly or indirectly) invades
> > > other mm code which cares little about hwpoison.  This results in unexpected
> > > behavior or kernel panic, which is very far from soft offline's "do not
> > > disturb userspace or other kernel component" policy.
> > > 
> > > Main point of this change set is to contain target page "via buddy allocator",
> > > where we first free the target page as we do for normal pages, and remove
> > > from buddy only when we confirm that it reaches free list. There is surely
> > > race window of page allocation, but that's fine because someone really want
> > > that page and the page is still working, so soft offline can happily give up.
> > > 
> > > v4 from Oscar tries to handle the race around reallocation, but that part
> > > seems still work in progress, so I decide to separate it for changes into
> > > v5.9.  Thank you for your contribution, Oscar.
> > > 
> > > The issue reported by Qian Cai is fixed by patch 16/16.
> > > 
> > > This patchset is based on v5.8-rc7-mmotm-2020-07-27-18-18, but I applied
> > > this series after reverting previous version.
> > > Maybe https://github.com/Naoya-Horiguchi/linux/commits/soft-offline-rework.v5
> > > shows what I did more precisely.
> > > 
> > > Any other comment/suggestion/help would be appreciated.
> > 
> > There is another issue with this patchset (with and without the patch [1]).
> > 
> > [1] https://lore.kernel.org/lkml/20200803133657.GA13307@hori.linux.bs1.fc.nec.co.jp/
> > 
> > Arm64 using 512M-size hugepages starts to fail allocations prematurely.
> > 
> > # ./random 1
> > - start: migrate_huge_offline
> > - use NUMA nodes 0,1.
> > - mmap and free 2147483648 bytes hugepages on node 0
> > - mmap and free 2147483648 bytes hugepages on node 1
> > madvise: Cannot allocate memory
> > 
> > [  284.388061][ T3706] soft offline: 0x956000: hugepage isolation failed: 0, page count 2, type 17ffff80001000e (referenced|uptodate|dirty|head)
> > [  284.400777][ T3706] Soft offlining pfn 0x8e000 at process virtual address 0xffff80000000
> > [  284.893412][ T3706] Soft offlining pfn 0x8a000 at process virtual address 0xffff60000000
> > [  284.901539][ T3706] soft offline: 0x8a000: hugepage isolation failed: 0, page count 2, type 7ffff80001000e (referenced|uptodate|dirty|head)
> > [  284.914129][ T3706] Soft offlining pfn 0x8c000 at process virtual address 0xffff80000000
> > [  285.433497][ T3706] Soft offlining pfn 0x88000 at process virtual address 0xffff60000000
> > [  285.720377][ T3706] Soft offlining pfn 0x8a000 at process virtual address 0xffff80000000
> > [  286.281620][ T3706] Soft offlining pfn 0xa000 at process virtual address 0xffff60000000
> > [  286.290065][ T3706] soft offline: 0xa000: hugepage migration failed -12, type 7ffff80001000e (referenced|uptodate|dirty|head)
> 
> I think that this is due to the lack of contiguous memory.
> This test program iterates soft offlining many times for hugepages,
> so finally one page in every 512MB will be removed from buddy, then we
> can't allocate hugepage any more even if we have enough free pages.
> This is not good for heavy hugepage users, but that should be intended.
> 
> It seems that random.c calls madvise(MADV_SOFT_OFFLINE) for 2 hugepages,
> and iterates it 1000 (==NR_LOOP) times, so if the system doesn't have
> enough memory to cover the range of 2000 hugepages (1000GB in the Arm64
> system), this ENOMEM should reproduce as expected.

Well, each iteration will mmap/munmap, so there should be no leaking. 

https://gitlab.com/cailca/linux-mm/-/blob/master/random.c#L376

It also seem to me madvise(MADV_SOFT_OFFLINE) does start to fragment memory
somehow, because after this "madvise: Cannot allocate memory" happened, I
immediately checked /proc/meminfo and then found no hugepage usage at all.

> 
> > 
> > Reverting this patchset and its dependency patchset [2] (reverting the
> > dependency alone did not help) fixed it,
> 
> But it's still not clear to me why this was not visible before this
> patchset, so I need more check for it.
> 
> Thanks,
> Naoya Horiguchi
> 
> > 
> > # ./random 1
> > - start: migrate_huge_offline
> > - use NUMA nodes 0,1.
> > - mmap and free 2147483648 bytes hugepages on node 0
> > - mmap and free 2147483648 bytes hugepages on node 1
> > - pass: mmap_offline_node_huge
> > 
> > [2] https://lore.kernel.org/linux-mm/1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com/ 
> > 
> > > 
> > > Thanks,
> > > Naoya Horiguchi
> > > ---
> > > Previous versions:
> > >   v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> > >   v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
> > >   v3: https://lore.kernel.org/linux-mm/20200624150137.7052-1-nao.horiguchi@gmail.com/
> > >   v4: https://lore.kernel.org/linux-mm/20200716123810.25292-1-osalvador@suse.de/
> > > ---
> > > Summary:
> > > 
> > > Naoya Horiguchi (8):
> > >       mm,hwpoison: cleanup unused PageHuge() check
> > >       mm, hwpoison: remove recalculating hpage
> > >       mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
> > >       mm,hwpoison-inject: don't pin for hwpoison_filter
> > >       mm,hwpoison: remove MF_COUNT_INCREASED
> > >       mm,hwpoison: remove flag argument from soft offline functions
> > >       mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
> > >       mm,hwpoison: double-check page count in __get_any_page()
> > > 
> > > Oscar Salvador (8):
> > >       mm,madvise: Refactor madvise_inject_error
> > >       mm,hwpoison: Un-export get_hwpoison_page and make it static
> > >       mm,hwpoison: Kill put_hwpoison_page
> > >       mm,hwpoison: Unify THP handling for hard and soft offline
> > >       mm,hwpoison: Rework soft offline for free pages
> > >       mm,hwpoison: Rework soft offline for in-use pages
> > >       mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
> > >       mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
> > > 
> > >  drivers/base/memory.c      |   2 +-
> > >  include/linux/mm.h         |  12 +-
> > >  include/linux/page-flags.h |   6 +-
> > >  include/ras/ras_event.h    |   3 +
> > >  mm/hwpoison-inject.c       |  18 +--
> > >  mm/madvise.c               |  39 +++---
> > >  mm/memory-failure.c        | 334 ++++++++++++++++++++-------------------------
> > >  mm/migrate.c               |  11 +-
> > >  mm/page_alloc.c            |  60 ++++++--
> > >  9 files changed, 233 insertions(+), 252 deletions(-)
> > 

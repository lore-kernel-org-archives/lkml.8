Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE787C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5532067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgF3Gfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:35:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbgF3Gfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:35:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44BA6AAC3;
        Tue, 30 Jun 2020 06:35:29 +0000 (UTC)
Message-ID: <1593498910.3046.2.camel@suse.de>
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>, nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Date:   Tue, 30 Jun 2020 08:35:10 +0200
In-Reply-To: <20200630050803.GA2747@lca.pw>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
         <20200630050803.GA2747@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-30 at 01:08 -0400, Qian Cai wrote:
> On Wed, Jun 24, 2020 at 03:01:22PM +0000, nao.horiguchi@gmail.com
> wrote:
> > I rebased soft-offline rework patchset [1][2] onto the latest
> > mmotm.  The
> > rebasing required some non-trivial changes to adjust, but mainly
> > that was
> > straightforward.  I confirmed that the reported problem doesn't
> > reproduce on
> > compaction after soft offline.  For more precise description of the
> > problem
> > and the motivation of this patchset, please see [2].
> > 
> > I think that the following two patches in v2 are better to be done
> > with
> > separate work of hard-offline rework, so it's not included in this
> > series.
> > 
> >   - mm,hwpoison: Take pages off the buddy when hard-offlining
> >   - mm/hwpoison-inject: Rip off duplicated checks
> > 
> > These two are not directly related to the reported problem, so they
> > seems
> > not urgent.  And the first one breaks num_poisoned_pages counting
> > in some
> > testcases, and The second patch needs more consideration about
> > commented point.
> > 
> > Any comment/suggestion/help would be appreciated.
> 
> Even after applied the compling fix,
> 
> https://lore.kernel.org/linux-mm/20200628065409.GA546944@u2004/
> 
> madvise(MADV_SOFT_OFFLINE) will fail with EIO with hugetlb where it
> would succeed without this series. Steps:
> 
> # git clone https://github.com/cailca/linux-mm
> # cd linux-mm; make
> # ./random 1 (Need at least two NUMA memory nodes)
>  start: migrate_huge_offline
> - use NUMA nodes 0,4.
> - mmap and free 8388608 bytes hugepages on node 0
> - mmap and free 8388608 bytes hugepages on node 4
> madvise: Input/output error

I think I know why.
It's been a while since I took a look, but I compared the posted
patchset with my newest patchset I had ready and I saw I made some
changes with regard of hugetlb pages.

I will be taking a look, although it might be better to re-post the
patchset instead of adding a fix on top since the changes are a bit
substantial.

Thanks for reporting.

-- 
Oscar Salvador
SUSE L3

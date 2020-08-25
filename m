Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26182C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2ECC2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgHYHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:21:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:54050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbgHYHVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:21:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A81FAE63;
        Tue, 25 Aug 2020 07:22:06 +0000 (UTC)
Date:   Tue, 25 Aug 2020 09:21:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200825072134.GA22869@dhcp22.suse.cz>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-08-20 11:42:04, Andrew Morton wrote:
> On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
> > The new version which bases on v5.9-rc2. The first 6 patches was picked into
> > linux-mm, and add patch 25-32 that do some further post optimization.
> 
> 32 patches, version 18.  That's quite heroic.  I'm unsure whether I
> should merge it up at this point - what do people think?

This really needs a proper review. Unfortunately
: 24 files changed, 646 insertions(+), 443 deletions(-)
is quite an undertaking to review as well. Especially in a tricky code
which is full of surprises.

I do agree that per memcg locking looks like a nice feature but I do not
see any pressing reason to merge it ASAP. The cover letter doesn't
really describe any pressing usecase that cannot really live without
this being merged.

I am fully aware of my dept to review but I simply cannot find enough
time to sit on it and think it through to have a meaningful feedback at
this moment.

> > Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> > containers on a 2s * 26cores * HT box with a modefied case:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> > With this patchset, the readtwice performance increased about 80%
> > in concurrent containers.
> 
> That's rather a slight amount of performance testing for a huge
> performance patchset!  Is more detailed testing planned?

Agreed! This needs much better testing coverage.

-- 
Michal Hocko
SUSE Labs

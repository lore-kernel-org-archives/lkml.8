Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED413C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12672078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFngGB4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgDPRrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgDPRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:47:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4BBC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:47:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so6301145lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKQyd28J6klVlExdivV63IY2/jZ+2G6tdYSQ07jc4aE=;
        b=PFngGB4TWfc2/U4qmnsspqOKfmB4btthlE7TyKvPnUzzuBsT/y+E9ROWYkjgOkMKyB
         Bz/Po84HWCXDL+0TeFUvxFI9Ms9AxQtdQ+WrWwiVklnNi4L953PXrTO/JZYIMomM08Gf
         L7TlFz2/ALlwYkVHLzjCuSk23gG8hDu25gqx3KeP7uPK2DcqKI7bSJBOP/DMaLbhKBvS
         7NTdWWuSyvp/vIZZx2O3VC6lu52ZSmL5tQwoE69Jy2qbuIUrdVIvMMQrgEcn8elB2t4L
         5fMSjejeGC7ACFX5tL+7GKZnRJFYb2/dtjpdDSSkn2SaMzRGevQOTE3hFE54IbSVV90y
         /oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKQyd28J6klVlExdivV63IY2/jZ+2G6tdYSQ07jc4aE=;
        b=YXVun/pwcTo2BBgMTcsqspAfTK4egiT8xNcWBzav9UTTaexlDQTl5hoM+SQApvHy2C
         Zri8mEMLBULx9ZxrIepfu1yq/jBJUSyD4RJmZEgi632MKH4LIJIUkvhpRleesq1+8b5H
         InD3KNirjvxRsw3izJ+O9Ky3wQLUjtJGIBjuQRbn/fd6hMVJfRAildzcSy3JoEEtfBHe
         4NODKM+FksULNw2kCJlj9MBBrXgJw1yeV1LZ9nj3LRrxtm6mEj99rXBd8+VweKngs2VJ
         bQPH6SjLYrUPB6mmMZCnHYFIBhbTviqlMgTHm1KIU3g1DCyEvKTaSV2aHnDRw5mjxXiJ
         hK2Q==
X-Gm-Message-State: AGi0PuaI72LCfYRkdcAP0W22TGVGZAudTPSt5i69YkNELuMPOWJDpLF3
        24P8l2ko+bsD8sV//5XXIaTk5HBNnwOyIZJSS5vx7yaap1fArw==
X-Google-Smtp-Source: APiQypJDp0D4AqUDwJHnySuxSP+B1kwEZrRgbzXx293VrEkAAtFPcqmlhTBHjBZ48dNkGluGECk4epotU8SiLM7h84Y=
X-Received: by 2002:a19:c1d3:: with SMTP id r202mr6625545lff.216.1587059231673;
 Thu, 16 Apr 2020 10:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org> <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org> <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
 <20200414163114.GA136578@cmpxchg.org> <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
 <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com> <20200416152830.GA195132@cmpxchg.org>
In-Reply-To: <20200416152830.GA195132@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 16 Apr 2020 10:47:00 -0700
Message-ID: <CALvZod4bdmkd_YG=96O8+zCSCFNpsBQiN+3Cq+6oD7jn3GTYog@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes & Alex,

On Thu, Apr 16, 2020 at 8:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hi Alex,
>
> On Thu, Apr 16, 2020 at 04:01:20PM +0800, Alex Shi wrote:
> >
> >
> > =E5=9C=A8 2020/4/15 =E4=B8=8B=E5=8D=889:42, Alex Shi =E5=86=99=E9=81=93=
:
> > > Hi Johannes,
> > >
> > > Thanks a lot for point out!
> > >
> > > Charging in __read_swap_cache_async would ask for 3 layers function a=
rguments
> > > pass, that would be a bit ugly. Compare to this, could we move out th=
e
> > > lru_cache add after commit_charge, like ksm copied pages?
> > >
> > > That give a bit extra non lru list time, but the page just only be us=
ed only
> > > after add_anon_rmap setting. Could it cause troubles?
> >
> > Hi Johannes & Andrew,
> >
> > Doing lru_cache_add_anon during swapin_readahead can give a very short =
timing
> > for possible page reclaiming for these few pages.
> >
> > If we delay these few pages lru adding till after the vm_fault target p=
age
> > get memcg charging(mem_cgroup_commit_charge) and activate, we could ski=
p the
> > mem_cgroup_try_charge/commit_charge/cancel_charge process in __read_swa=
p_cache_async().
> > But the cost is maximum SWAP_RA_ORDER_CEILING number pages on each cpu =
miss
> > page reclaiming in a short time. On the other hand, save the target vm_=
fault
> > page from reclaiming before activate it during that time.
>
> The readahead pages surrounding the faulting page might never get
> accessed and pile up to large amounts. Users can also trigger
> non-faulting readahead with MADV_WILLNEED.
>
> So unfortunately, I don't see a way to keep these pages off the
> LRU. They do need to be reclaimable, or they become a DoS vector.
>
> I'm currently preparing a small patch series to make swap ownership
> tracking an integral part of memcg and change the swapin charging
> sequence, then you don't have to worry about it. This will also
> unblock Joonsoo's "workingset protection/detection on the anonymous
> LRU list" patch series, since he is blocked on the same problem - he
> needs the correct LRU available at swapin time to process refaults
> correctly. Both of your patch series are already pretty large, they
> shouldn't need to also deal with that.

I think this would be a very good cleanup and will make the code much
more readable. I totally agree to keep this separate from the other
work. Please do CC me the series once it's ready.

Now regarding the per-memcg LRU locks, Alex, did you get the chance to
try the workload Hugh has provided? I was planning of posting Hugh's
patch series but Hugh advised me to wait for your & Johannes's
response since you both have already invested a lot of time in your
series and I do want to see how Johannes's TestClearPageLRU() idea
will look like, so, I will hold off for now.

thanks,
Shakeel

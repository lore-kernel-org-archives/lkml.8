Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA752C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30ED20663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="YgmoZBvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGXN5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:57:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C331C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:57:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so5260680pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjjQN8ks2b2RtZrHKrhZ4oEn8Kn+yd36Wb2kzIQgMkY=;
        b=YgmoZBvckAEgAfwuMocjyBcu/IyVoL401Htncdj0K2+rx5zBGYGcvyzaGczG8krg/0
         p4DtZvSOqMxV8FTKsCnG26DeO7Q1aaVr9TOQxoOPsbwFfovT7VaR5i+8QqqMaf+24iZL
         PFQ2cYFNJGML0CJYc8jjo2HxQvVz68FfAXpjmEarg01w4ugluOZOVslKxbxrZIuPxtJg
         qScHsb3HJZn1tLjuudk9yzaROEHAHMx3CtJih4lCmRngUKEMfbmYhipwBHH3TxC1SYhJ
         nChcLFEoixyOiSTzxicNB16E3OaWM0FIbspW6HxufhSiaZvgNccG8yRma2I9142ZFH7u
         wkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjjQN8ks2b2RtZrHKrhZ4oEn8Kn+yd36Wb2kzIQgMkY=;
        b=e60NYcLQ9fRuLYbK3FSraPyZdVGgaNrJNQiMaMwnoZtE8biZJHHt5LctdGhxW9D9OO
         HQkRn1HDpat18NppSNrpgcczbH1I5Jnjs41mGYuVFezaf0PCiGfkC39Y7uW/V+IayZou
         aR0yV31UdIOiyS8q8l+FnB6CWSzaFf1EmdMvMHUns5GSvLQ9qy9AubYUhMjwD2hut6p3
         9CV2KXx4Aj+bMqQ7cWLzUpRPACaN8QgFVK30kPgv4OoYwi0rq3M7G2N0jFvE1ETmtl9M
         bm/9uAGW4cAffuxsY8Q5AswLamb1bEUEPVzHVYhgLEf2K9oBsfpq2lWe7ROQUwGJUQap
         frgQ==
X-Gm-Message-State: AOAM5313RD61Ey9U4/AvRR4EhqJ0r3zYW4UiQ4TqyisBB5yRPDriG1Fs
        ArlxqY7HGvUcHYS72++QMvkTD8aqcFAtvvdhQJRm1w==
X-Google-Smtp-Source: ABdhPJwKzbMeNgQpLCc7PUfVVarPU4j6FpeRmmFMAfQwxGwOv0V5jGVpgNu2UtLa274ITps4QrCYk27NbvAsvN5WC7o=
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr5615501pjb.147.1595599025576;
 Fri, 24 Jul 2020 06:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200724100306.33457-1-songmuchun@bytedance.com> <20200724113415.GG4061@dhcp22.suse.cz>
In-Reply-To: <20200724113415.GG4061@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 24 Jul 2020 21:56:29 +0800
Message-ID: <CAMZfGtUVHN4HA45d18zxQVUJvWyVPimvKG=y3YDPJBhu4ocLPQ@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] Re: [PATCH v2] mm/hugetlb: add
 mempolicy check in the reservation routine
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, mgorman@suse.de,
        walken@google.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jianchao Guo <guojianchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 7:34 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 24-07-20 18:03:06, Muchun Song wrote:
> > In the reservation routine, we only check whether the cpuset meets
> > the memory allocation requirements. But we ignore the mempolicy of
> > MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> > memory allocation may fail due to mempolicy restrictions and receives
> > the SIGBUS signal. This can be reproduced by the follow steps.
> >
> >  1) Compile the test case.
> >     cd tools/testing/selftests/vm/
> >     gcc map_hugetlb.c -o map_hugetlb
> >
> >  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
> >     system. Each node will pre-allocate one huge page.
> >     echo 2 > /proc/sys/vm/nr_hugepages
> >
> >  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
> >     numactl --membind=0 ./map_hugetlb 4
> >
> > With this patch applied, the mmap will fail in the step 3) and throw
> > "mmap: Cannot allocate memory".
> >
> > Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >
> > changelog in v2:
> >  1) Reuse policy_nodemask().
> >
> >  include/linux/mempolicy.h |  1 +
> >  mm/hugetlb.c              | 19 ++++++++++++++++---
> >  mm/mempolicy.c            |  2 +-
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> > index ea9c15b60a96..6b9640f1c990 100644
> > --- a/include/linux/mempolicy.h
> > +++ b/include/linux/mempolicy.h
> > @@ -152,6 +152,7 @@ extern int huge_node(struct vm_area_struct *vma,
> >  extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
> >  extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
> >                               const nodemask_t *mask);
> > +extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
> >  extern unsigned int mempolicy_slab_node(void);
> >
> >  extern enum zone_type policy_zone;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 589c330df4db..a753fe8591b4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3463,12 +3463,25 @@ static int __init default_hugepagesz_setup(char *s)
> >  }
> >  __setup("default_hugepagesz=", default_hugepagesz_setup);
> >
> > -static unsigned int cpuset_mems_nr(unsigned int *array)
> > +static unsigned int allowed_mems_nr(struct hstate *h)
> >  {
> >       int node;
> >       unsigned int nr = 0;
> > +     struct mempolicy *mpol = get_task_policy(current);
> > +     nodemask_t *mpol_allowed, *mems_allowed, nodemask;
> > +     unsigned int *array = h->free_huge_pages_node;
> > +     gfp_t gfp_mask = htlb_alloc_mask(h);
> > +
> > +     mpol_allowed = policy_nodemask(gfp_mask, mpol);
> > +     if (mpol_allowed) {
> > +             nodes_and(nodemask, cpuset_current_mems_allowed,
> > +                       *mpol_allowed);
> > +             mems_allowed = &nodemask;
> > +     } else {
> > +             mems_allowed = &cpuset_current_mems_allowed;
> > +     }
>
> I believe you can simplify this and use a similar pattern as the page
> allocator. Something like
>
>         for_each_node_mask(node, mpol_allowed) {
>                 if (node_isset(node, &cpuset_current_mems_allowed))
>                         nr += array[node];
>         }
>
> There shouldn't be any need to allocate a potentially large nodemask on
> the stack.

An unsigned long can satisfy 64 nodes. So I think that nodemask is using
little stack memory. Right?

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun

Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCB6206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="1SLkZtZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgG1ORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgG1ORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:17:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E9EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:17:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so11709573pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGpofeA17dXnW8p+LpiNOYhDoLesFaEWeH9vhRlfQhI=;
        b=1SLkZtZeMIMwxIMuDjStl9UAdHtwooExe6Rg1P9sSgrqYPofvwdOniEsXPalrEj4ZE
         SJQpMRBb50bWQ0ZdwPNj1dtSaPXfhTFI5BCRMCzSEPPv+81mgGaKiuMq5unUV+0nlYPI
         HH5R90J3R709NQZxkyZ27sLlnbU2L/FvxJqIO6YQF9JLHd3b97q6hYFizpPSKODW9UKM
         lr+YFeqchqLmnIyvgl8no1etDAVJ0suvmIEtmovs7fC/fRpm7r0wDSq/l8YLQcsLWPrQ
         6nGU/Gy7mD4RTtr0WDhs+QFa6+Xh0qq3gkpvXEfXWGd2B+8+PAJQ2RIjeuskL9Or6nRJ
         1a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGpofeA17dXnW8p+LpiNOYhDoLesFaEWeH9vhRlfQhI=;
        b=eb5Ggr66hH7zhS0GVbgHO5tWCRiQaG2YLxdmLFchgpeqxwIi2qqb5fTZchc840TaNn
         MAKOd20CeNwWxblmfGjvQKd/svLXIeLO5FpEdOnyuFUtEA4JvGrhCO7OmeTBXWo5YCRU
         gAVhqKbEpjMSQQlY3nWCVX9mtQfqSg5tA+jOdgomIy5HfvQtojy2F+ST8K6b0S1NE0WW
         BsCdk0gmWTSMJOCNf/jA5AF8rfZQ/wpuXplKWZKMLaaeYhdoInPM5PA+4CdkzUmDQJvs
         wLBe1KIfJ6pWrswNAy9u3xeY2C6lgWShoFzz8RtlX25ssQPjqrxeJkHl3Ck5WinE5T+/
         DUuA==
X-Gm-Message-State: AOAM531ApihPmSAlLYM/lN3Q+2lS3bu5pkI+DxniXgLGg61wuKKFqSt2
        qOjZEO842JZfNTyfPusB+94c94ts0kO/58tMJAN7wQ==
X-Google-Smtp-Source: ABdhPJwJnfO4QjYiJywtGTs1VlxrNe5Tnx9vLxLG3J8+PobA6MnrnJatSc00k18wNmb7BHPagESfluqvmEh18mSXavQ=
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr4805430pjb.147.1595945825188;
 Tue, 28 Jul 2020 07:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200728034938.14993-1-songmuchun@bytedance.com> <20200728132453.GB14854@MiWiFi-R3L-srv>
In-Reply-To: <20200728132453.GB14854@MiWiFi-R3L-srv>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 28 Jul 2020 22:16:29 +0800
Message-ID: <CAMZfGtUSJN5KVpTb-cSe=76w6EX-7Z01nXFF+mqWGDvubCUj7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4] mm/hugetlb: add mempolicy check in the
 reservation routine
To:     Baoquan He <bhe@redhat.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>, mgorman@suse.de,
        Michel Lespinasse <walken@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jianchao Guo <guojianchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 9:25 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Muchun,
>
> On 07/28/20 at 11:49am, Muchun Song wrote:
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
>
> I think supporting the  mempolicy of MPOL_BIND case is a good idea.
> I am wondering what about the other mempolicy cases, e.g MPOL_INTERLEAVE,
> MPOL_PREFERRED. Asking these because we already have similar handling in
> sysfs, proc nr_hugepages_mempolicy writting. Please see
> __nr_hugepages_store_common() for detail.

Yeah, I know the nr_hugepages_mempolicy. But this new code will
help produce a quick failure as described in the commit message
instead of waiting until the page fault routine(and receive a SIGBUG
signal).

>
> Thanks
> Baoquan
>
> >
> > With this patch applied, the mmap will fail in the step 3) and throw
> > "mmap: Cannot allocate memory".
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> > changelog in v4:
> >  1) Fix compilation errors with !CONFIG_NUMA.
> >
> > changelog in v3:
> >  1) Do not allocate nodemask on the stack.
> >  2) Update comment.
> >
> > changelog in v2:
> >  1) Reuse policy_nodemask().
> >
> >  include/linux/mempolicy.h | 14 ++++++++++++++
> >  mm/hugetlb.c              | 22 ++++++++++++++++++----
> >  mm/mempolicy.c            |  2 +-
> >  3 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> > index ea9c15b60a96..0656ece1ccf1 100644
> > --- a/include/linux/mempolicy.h
> > +++ b/include/linux/mempolicy.h
> > @@ -152,6 +152,15 @@ extern int huge_node(struct vm_area_struct *vma,
> >  extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
> >  extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
> >                               const nodemask_t *mask);
> > +extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
> > +
> > +static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> > +{
> > +     struct mempolicy *mpol = get_task_policy(current);
> > +
> > +     return policy_nodemask(gfp, mpol);
> > +}
> > +
> >  extern unsigned int mempolicy_slab_node(void);
> >
> >  extern enum zone_type policy_zone;
> > @@ -281,5 +290,10 @@ static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
> >  static inline void mpol_put_task_policy(struct task_struct *task)
> >  {
> >  }
> > +
> > +static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> > +{
> > +     return NULL;
> > +}
> >  #endif /* CONFIG_NUMA */
> >  #endif
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 589c330df4db..a34458f6a475 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3463,13 +3463,21 @@ static int __init default_hugepagesz_setup(char *s)
> >  }
> >  __setup("default_hugepagesz=", default_hugepagesz_setup);
> >
> > -static unsigned int cpuset_mems_nr(unsigned int *array)
> > +static unsigned int allowed_mems_nr(struct hstate *h)
> >  {
> >       int node;
> >       unsigned int nr = 0;
> > +     nodemask_t *mpol_allowed;
> > +     unsigned int *array = h->free_huge_pages_node;
> > +     gfp_t gfp_mask = htlb_alloc_mask(h);
> > +
> > +     mpol_allowed = policy_nodemask_current(gfp_mask);
> >
> > -     for_each_node_mask(node, cpuset_current_mems_allowed)
> > -             nr += array[node];
> > +     for_each_node_mask(node, cpuset_current_mems_allowed) {
> > +             if (!mpol_allowed ||
> > +                 (mpol_allowed && node_isset(node, *mpol_allowed)))
> > +                     nr += array[node];
> > +     }
> >
> >       return nr;
> >  }
> > @@ -3648,12 +3656,18 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
> >        * we fall back to check against current free page availability as
> >        * a best attempt and hopefully to minimize the impact of changing
> >        * semantics that cpuset has.
> > +      *
> > +      * Apart from cpuset, we also have memory policy mechanism that
> > +      * also determines from which node the kernel will allocate memory
> > +      * in a NUMA system. So similar to cpuset, we also should consider
> > +      * the memory policy of the current task. Similar to the description
> > +      * above.
> >        */
> >       if (delta > 0) {
> >               if (gather_surplus_pages(h, delta) < 0)
> >                       goto out;
> >
> > -             if (delta > cpuset_mems_nr(h->free_huge_pages_node)) {
> > +             if (delta > allowed_mems_nr(h)) {
> >                       return_unused_surplus_pages(h, delta);
> >                       goto out;
> >               }
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 93fcfc1f2fa2..fce14c3f4f38 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1873,7 +1873,7 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
> >   * Return a nodemask representing a mempolicy for filtering nodes for
> >   * page allocation
> >   */
> > -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> >  {
> >       /* Lower zones don't get a nodemask applied for MPOL_BIND */
> >       if (unlikely(policy->mode == MPOL_BIND) &&
> > --
> > 2.11.0
> >
> >
>


--
Yours,
Muchun

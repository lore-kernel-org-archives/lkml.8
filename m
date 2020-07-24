Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B90020748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="lKqxA8aG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGXJFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:05:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30399C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:05:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 8so4867304pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJk0fXPunD7T/D5AVyjQEsNkNoXfI8ghmpNswYCIQ+s=;
        b=lKqxA8aGc7K9NzmQLYiWeEyRjpzKPH0blU5CHfbuSvK+02UDgogw+q1KXJNiqGDUQo
         rLR1hRiHnu5oFwv10CZ+GVGH2CGgOWkBXWYk//dbBzwHipMuwUA9qEy7y1Jn5gX6Z5K7
         UJ76IFF+NPl3Kb0cAzY9U5DY0ux9kZes/ohz9ihITTAc0vKCwyPle6Imfk276PSx/YBN
         ZlRwCib5SWxswWCFeevh5L7A7JTnjnHP2ztQ7PV6oXDXjKkDhNP7obbz9gp747djk18k
         zQfzH34OefTBx80I36pc1eHwt8VwfPU4gIEa1xvvLDHbGrU+gfDQ9RJZ9Hd5ZrZiKGQ8
         HNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJk0fXPunD7T/D5AVyjQEsNkNoXfI8ghmpNswYCIQ+s=;
        b=KNO0cSlR2fr/epQtmz1/E33/3jFUoKTpX1UvFCr8DU6bCuMgK16eA3J+PC3+YlRcZn
         UAEla8hIqiTMUilMmcu/WvFePDcI3f1KPjlUSbleiuUnW2+hL6tCpsWlC4tYgTTfFz9l
         QeFHb+BVMvom/LoQdIa4a/76Y6moOGQTACu4m5Gtzbj9RypMRRdrvThlYJ1GcEiIzhG+
         vc4cWXbgtBV69JSLIkMx+oz2ZX4On0IQE1Q3OVm/Eqd/NDHm3zEeCUyUMIPFb5/sQoYp
         BjjU0gRytq9AbM5AmtByXSUPr/3Jb0BM71q+PoXf0Ny5c1TVWfHexvbRieA2UmUEs3yp
         C/vw==
X-Gm-Message-State: AOAM5327dC77rUG/0580kE6musvwO0X8AeuKeNOaDNO1U0YzqFpvoGPk
        cpiKGJ2pz1GyLnAqk8nDi6gPf8CqtYKkOq9bQGJsqw==
X-Google-Smtp-Source: ABdhPJxeA0hqXJHpVHzj1cwmFS5tzvEzSY3DMRZ4Hx39L3nWeQW9bZb9LB+BrACsZn0Sb547epBrIqwxWO5voC6C5dU=
X-Received: by 2002:a17:90a:20e9:: with SMTP id f96mr4513310pjg.13.1595581504357;
 Fri, 24 Jul 2020 02:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200723074417.89467-1-songmuchun@bytedance.com> <20200724073942.GE4061@dhcp22.suse.cz>
In-Reply-To: <20200724073942.GE4061@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 24 Jul 2020 17:04:28 +0800
Message-ID: <CAMZfGtWUkW3AViM+vy6ffb44s_vjm0p0aXi=jdLkqKmN9HWJFA@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] Re: [PATCH] mm/hugetlb: add mempolicy
 check in the reservation routine
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jianchao Guo <guojianchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 3:39 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 23-07-20 15:44:17, Muchun Song wrote:
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
> Cpusets and mempolicy interaction has always been a nightmare and

Yeah, I agree with you.

> semantic might get really awkward in some cases. In this case I am not
> really sure anybody really does soemthing like that but anyway...

Someone may like to use numactl to bind memory nodes. So I think
that it is better to add a mempolicy check.

>
> [...]
>
> > -static unsigned int cpuset_mems_nr(unsigned int *array)
> > +static nodemask_t *mempolicy_current_bind_nodemask(void)
> > +{
> > +     struct mempolicy *mpol;
> > +     nodemask_t *nodemask;
> > +
> > +     mpol = get_task_policy(current);
> > +     if (mpol->mode == MPOL_BIND)
> > +             nodemask = &mpol->v.nodes;
> > +     else
> > +             nodemask = NULL;
> > +
> > +     return nodemask;
> > +}
>
> We already have policy_nodemask which tries to do this. Is there any
> reason to not reuse it?

Yeah, we can reuse it, I didn't know it before. Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun

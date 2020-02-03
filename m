Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E20C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675EA20732
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9vxuWfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBCXSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:18:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42026 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBCXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:18:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id j132so16511177oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4S8vHNwaTJoy9iVF47eyFtZHq86ah3z1R3R7OSO3+2M=;
        b=P9vxuWfA+Xz9O02Hf3pPI55HK5oO3beJiNSR+DkSHarWvGckjpVxj3+V9IaIcAJtZW
         mL9Vq5fV6HDoY5T3XjZwRYKZLxdyCMu0xYN0cx5DzBXtkfW6vhkiA1BBfH7tc+MnyXlT
         ooGWOmIwhM4GBBfvs9TLPhmk/Eq8kz7ojqO1i+vD6/wUHy2iP6866ydb5+Y6V0VY7xWD
         a/YvrUcthf9AcOfwYbCSNM7QKCs55X7EkSbGzpe2VhlEnkcQX70cj2cTugm1D9SnjfYm
         s+cZHlRxeIrDbRqXpGiNjtXGTQGo5xThTMF5DlS+ke3zqph4Cmd8k4bTjnhD35NTohrd
         vuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4S8vHNwaTJoy9iVF47eyFtZHq86ah3z1R3R7OSO3+2M=;
        b=CvVvuUfBJgbmDLwuIvo+dQGsFvN9gz4FKKs0+NL2ixUo/K/zXUqOtdwZmggTFpGMkO
         dNofol4hf5tNjnKG4p2jQ0JfSAmgNsOEYIgS2uo/KKDXXblGRHemBQXVxBneKhmTXg/2
         8r/5wP0wsCU1tvWAXwEzQIGZ88saFvx/ZFIzVTF8gGwEJ8VMeJlkE3imqS/Z1gCW9uWp
         5Zayk40CKSgLqW/YYln8edpsT2aRrYEJAxDyMrGcbk19dHjTDanuKxjW05o5UjfLskOx
         FlWWnAqlLSMrJkahJIKG3+p2mURonrq3CNGXLvWKA/mEihNSS3zyr9EnnrHHnzYT94pf
         ihEg==
X-Gm-Message-State: APjAAAUUCzxfzDEzKDMvVvXpvFnFkpFz9mwVjgiEnHKXJ/3OW3P8SsnC
        ILwV1fg0M0VJNXgbKLFUVkmInbx/zvUZbuwLcVLGBg==
X-Google-Smtp-Source: APXvYqyuj43djmIIaXiJRQDMfPEY4O5rvJgfItz8Cm1XFY7pfC3bE45El1OJ8nh1wyvDG/uukiMcMl2vAZyBV5IHz8Y=
X-Received: by 2002:a05:6808:7dd:: with SMTP id f29mr1176345oij.67.1580771883610;
 Mon, 03 Feb 2020 15:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-3-almasrymina@google.com> <alpine.DEB.2.21.2001291323270.175731@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2001291323270.175731@chino.kir.corp.google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 3 Feb 2020 15:17:52 -0800
Message-ID: <CAHS8izPNmO8urNCfVeMU1QnhGsrtg1CNLKXaL_VMe9jB6dtfyA@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     David Rientjes <rientjes@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 1:28 PM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 14 Jan 2020, Mina Almasry wrote:
>
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index dea6143aa0685..5491932ea5758 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -46,6 +46,16 @@ struct resv_map {
> >       long adds_in_progress;
> >       struct list_head region_cache;
> >       long region_cache_count;
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     /*
> > +      * On private mappings, the counter to uncharge reservations is stored
> > +      * here. If these fields are 0, then either the mapping is shared, or
> > +      * cgroup accounting is disabled for this resv_map.
> > +      */
> > +     struct page_counter *reservation_counter;
> > +     unsigned long pages_per_hpage;
> > +     struct cgroup_subsys_state *css;
> > +#endif
> >  };
> >  extern struct resv_map *resv_map_alloc(void);
> >  void resv_map_release(struct kref *ref);
> > diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> > index eab8a70d5bcb5..8c320accefe87 100644
> > --- a/include/linux/hugetlb_cgroup.h
> > +++ b/include/linux/hugetlb_cgroup.h
> > @@ -25,6 +25,33 @@ struct hugetlb_cgroup;
> >  #define HUGETLB_CGROUP_MIN_ORDER     2
> >
> >  #ifdef CONFIG_CGROUP_HUGETLB
> > +enum hugetlb_memory_event {
> > +     HUGETLB_MAX,
> > +     HUGETLB_NR_MEMORY_EVENTS,
> > +};
> > +
> > +struct hugetlb_cgroup {
> > +     struct cgroup_subsys_state css;
> > +
> > +     /*
> > +      * the counter to account for hugepages from hugetlb.
> > +      */
> > +     struct page_counter hugepage[HUGE_MAX_HSTATE];
> > +
> > +     /*
> > +      * the counter to account for hugepage reservations from hugetlb.
> > +      */
> > +     struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
> > +
> > +     atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> > +     atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> > +
> > +     /* Handle for "hugetlb.events" */
> > +     struct cgroup_file events_file[HUGE_MAX_HSTATE];
> > +
> > +     /* Handle for "hugetlb.events.local" */
> > +     struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> > +};
> >
> >  static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
> >                                                             bool reserved)
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 62a4cf3db4090..f1b63946ee95c 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -666,6 +666,17 @@ struct resv_map *resv_map_alloc(void)
> >       INIT_LIST_HEAD(&resv_map->regions);
> >
> >       resv_map->adds_in_progress = 0;
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     /*
> > +      * Initialize these to 0. On shared mappings, 0's here indicate these
> > +      * fields don't do cgroup accounting. On private mappings, these will be
> > +      * re-initialized to the proper values, to indicate that hugetlb cgroup
> > +      * reservations are to be un-charged from here.
> > +      */
> > +     resv_map->reservation_counter = NULL;
> > +     resv_map->pages_per_hpage = 0;
> > +     resv_map->css = NULL;
> > +#endif
>
> Might be better to extract out a resv_map_init() that does the
> initialization when CONFIG_CGROUP_HUGETLB is enabled?  Could be used here
> as well as hugetlb_reserve_pages().
>
> >
> >       INIT_LIST_HEAD(&resv_map->region_cache);
> >       list_add(&rg->link, &resv_map->region_cache);
> > @@ -3194,7 +3205,11 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
> >
> >       reserve = (end - start) - region_count(resv, start, end);
> >
> > -     kref_put(&resv->refs, resv_map_release);
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
> > +                                     (end - start) * resv->pages_per_hpage,
> > +                                     resv->css);
> > +#endif
> >
> >       if (reserve) {
> >               /*
>
> Mike has given is Reviewed-by so likely not a big concern for the generic
> hugetlb code, but I was wondering if we can reduce the number of #ifdef's
> if we defined a CONFIG_CGROUP_HUGETLB helper to take the resv, end, and
> start?  If CONFIG_CGROUP_HUGETLB is defined, it converts into the above,
> otherwise it's a no-op and we don't run into any compile errors because we
> are accessing fields that don't exist without the option.
>

Yes wherever possible I refactored the code a bit to remove #ifdefs in
the middle of hugetlb logic.

> Otherwise looks good!
>
> Acked-by: David Rientjes <rientjes@google.com>

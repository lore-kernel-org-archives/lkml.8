Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4364222288
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pk/pQjZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgFSWQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgFSWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:16:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:16:57 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so6416908lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/4ytESJPTv0Fk+cvfD+ZeYMt6Is89WPN3CMnUvmQxM=;
        b=pk/pQjZByX4EaFfPcnvBce0tQwY2dcpg0v4Xz6zZIDRbqHYcgE7gn2/6RtWuKabfTL
         A/6f9OlAfcoOvuVLwLbN7ImNbGHMhYOglePovUiVcwRMcocTq4BgxanpefaukEZJ5NZU
         76ZciuXOf985l0OsGnGhh3yAu04O2hAzWqWVmlF8EOEClXRzWw2dfD+RFvoJAFxX+mb3
         VMHYIsmYYwmT9/AoLecy0AybAneBBuvo+mqkdzvNLwPH8F3m6nB3uUMDfbUDl76ku3E4
         FLi0lVSWVB5xyIQolvMW8TKy/3JhLk2aGTUH3F0S3Y8UpMhDISe/VhD799hN5sJ3U6HI
         LNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/4ytESJPTv0Fk+cvfD+ZeYMt6Is89WPN3CMnUvmQxM=;
        b=qDl71rCziHpfi/SgaZywBA/gT5C9D6dk+3cPBhBYxXzoplJGnmAIq9JCXqQ386/Dgt
         STcgSjnm/KM47cDWw4kJ4eHI/4lA5tKm1ApgblGdFPAsKbeXEPtSBX6mGIlr28DrtNzb
         35b9YH+0EiAYBtQj+awXC5AstcoWC2x8EgDGa2Vw3a24P31x0PlUcU6E6EGomYRG3/+P
         DNQu9+8G95ZBpakvD2Ok84PYBW54ncySRP5dASdTCrYDvumHBlVF3utYHbx1jOE/hKCc
         lpMWMWGsmBpZfkJUWHSwj8LN9Mths34xdQuw2gF5hyqhJLUtU9XX3gdXMa0qHX6xYxAb
         F9KA==
X-Gm-Message-State: AOAM533VtxPhbkPeIam16o5BcUKATidCZDMBhAtRmHGLCfafH84bFJme
        Y7ZzVO43alhFZ9RNqz9vugWzD/PQ1wKnwB+xv8hwzQ==
X-Google-Smtp-Source: ABdhPJwYD6TFySTm5cYZmtRpAi8UMNhwXWW0cMMBEcQZMDvs2E75z8IPDt6LpAAGJhJXuTsXYwe6n4eEC09LOVn2Ey4=
X-Received: by 2002:a19:4301:: with SMTP id q1mr3056210lfa.96.1592605015159;
 Fri, 19 Jun 2020 15:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-7-guro@fb.com>
 <CALvZod4hq5moKcb6f5L6VAS+v5+jKf8Hyd0gLotD7bMK7FsKgg@mail.gmail.com> <20200619213810.GA237539@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200619213810.GA237539@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 15:16:44 -0700
Message-ID: <CALvZod4-hsXx6GcrftsXtMA08w9gJ3Sk_Lv0CxzDF20xsyf9JQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/19] mm: memcg/slab: obj_cgroup API
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 2:38 PM Roman Gushchin <guro@fb.com> wrote:
>
[snip]
> > > memcg->objcg is rcu protected.
> > > objcg->memcg is a raw pointer, which is always pointing at a memory
> > > cgroup, but can be atomically swapped to the parent memory cgroup. So
> > > the caller
> >
> > What type of caller? The allocator?
>
> Basically whoever uses the pointer. Is it better to s/caller/user?
>

Yes 'user' feels better.

> >
[...]
> >
> > The normal stock can go to 32*nr_cpus*PAGE_SIZE. I am wondering if
> > just PAGE_SIZE is too less for obj stock.
>
> It works on top of the current stock of 32 pages, so it can grab these
> 32 pages without any atomic operations. And it should be easy to increase
> this limit if we'll see any benefits.
>
> Thank you for looking into the patchset!
>
> Andrew, can you, please, squash the following fix based on Shakeel's suggestions?
> Thanks!
>
> --

For the following squashed into the original patch:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7ed3af71a6fb..2499f78cf32d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -326,7 +326,7 @@ struct mem_cgroup {
>         int kmemcg_id;
>         enum memcg_kmem_state kmem_state;
>         struct obj_cgroup __rcu *objcg;
> -       struct list_head objcg_list;
> +       struct list_head objcg_list; /* list of inherited objcgs */
>  #endif
>
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 70cd44b28db1..9f14b91700d9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2843,7 +2843,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>         struct obj_cgroup *objcg = NULL;
>         struct mem_cgroup *memcg;
>
> -       if (unlikely(!current->mm))
> +       if (unlikely(!current->mm && !current->active_memcg))
>                 return NULL;
>
>         rcu_read_lock();

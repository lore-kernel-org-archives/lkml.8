Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33265C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF9221473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lb8r9xb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDVQve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:51:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A077C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:51:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m2so2266549lfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMU2sdANRlebnl16w8n5PRa+nqFLI55fKcb7gFihZwY=;
        b=lb8r9xb492dHP5+E9i8W4r6C52dw70KTq4NynepcjSjXvxIqTqRhzsIw/ttkMxrwR+
         j65ZyTEhp61QhtOvHDWc1S1Gaoob8C7seTN0+h615yPlj2d3h6iKXEMBokSYRM7iBfw2
         wOx+DdKKvbiST5q/iSH8Zo6nzHoqELKr4D8cflowDrI/wIZIsZtR+puJFNCBBOQxCPFP
         zooVfRTMyWh0vdBpp4pjpVqBJTo8TpjwReKJMe+TIa/g0NEZPob/vo8o5fdY5lKWvlhe
         SAcrPWWpLCQCvjII891JE5HLeOF2Tg1gHwGQ+Pq6Z6lAAH1rPcLwEnbLP6JvB8ttEoSE
         Mstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMU2sdANRlebnl16w8n5PRa+nqFLI55fKcb7gFihZwY=;
        b=WJDH+HogGqtDPu9smJCP7zdjCZs9QoVYjdcoV5870+xmFjV2W6WDvfd6gePLlz4ycE
         mTs/dV399T3VpmVSF2Tot8wAjeLiAvyN+UsA5T+BaD+iPJ+x8wxa58bEYdp4mAfFVRtD
         waXwg/fwgbc94wq+gKvroRSp2BoM5NDEublHDMA7TtIHXFHoki6m2jFaNmEiWh+PdTU6
         oVeVRaW2P+sDjvNONdFDlLbVpf4VErbJh9ks6sNDnlBNL2488AImhxU1ULIL1sluMVoX
         5cEZYYbUTJZRWJBx0kIZwVSvLeKgycG4m0g46PoYJ25Xr7TnwK6w3162+fPWsC/k98Xg
         k3fw==
X-Gm-Message-State: AGi0PuaQ+M1cI9ZIergLTXVb5hgvpg1GnS9TLz9fIfrxZGyXmiouQtGe
        Q+j/oInWg6bWHpHjD73uEHGogWTjQuLVJC8bvpkmmQ==
X-Google-Smtp-Source: APiQypJtQGrxDfBO6FRzQwyn1VRRG66vnIy7KhdMUkT0BoBj6QcZuE2W1TDMuCsZHxMwE+LdhOg4VSc5w+oEWJXa/vc=
X-Received: by 2002:a19:7407:: with SMTP id v7mr17903201lfe.124.1587574291394;
 Wed, 22 Apr 2020 09:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-3-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 09:51:20 -0700
Message-ID: <CALvZod4gFC1TDo8dtdaeQKj_ZEoOnQvRnw_dZANH7qQYCmnnGA@mail.gmail.com>
Subject: Re: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge moving
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The move_lock is a per-memcg lock, but the VM accounting code that
> needs to acquire it comes from the page and follows page->mem_cgroup
> under RCU protection. That means that the page becomes unlocked not
> when we drop the move_lock, but when we update page->mem_cgroup. And
> that assignment doesn't imply any memory ordering. If that pointer
> write gets reordered against the reads of the page state -
> page_mapped, PageDirty etc. the state may change while we rely on it
> being stable and we can end up corrupting the counters.
>
> Place an SMP memory barrier to make sure we're done with all page
> state by the time the new page->mem_cgroup becomes visible.
>
> Also replace the open-coded move_lock with a lock_page_memcg() to make
> it more obvious what we're serializing against.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5beea03dd58a..41f5ed79272e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5372,7 +5372,6 @@ static int mem_cgroup_move_account(struct page *page,
>  {
>         struct lruvec *from_vec, *to_vec;
>         struct pglist_data *pgdat;
> -       unsigned long flags;
>         unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
>         int ret;
>         bool anon;
> @@ -5399,18 +5398,13 @@ static int mem_cgroup_move_account(struct page *page,
>         from_vec = mem_cgroup_lruvec(from, pgdat);
>         to_vec = mem_cgroup_lruvec(to, pgdat);
>
> -       spin_lock_irqsave(&from->move_lock, flags);
> +       lock_page_memcg(page);
>
>         if (!anon && page_mapped(page)) {
>                 __mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
>                 __mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
>         }
>
> -       /*
> -        * move_lock grabbed above and caller set from->moving_account, so
> -        * mod_memcg_page_state will serialize updates to PageDirty.
> -        * So mapping should be stable for dirty pages.
> -        */
>         if (!anon && PageDirty(page)) {
>                 struct address_space *mapping = page_mapping(page);
>
> @@ -5426,15 +5420,23 @@ static int mem_cgroup_move_account(struct page *page,
>         }
>
>         /*
> +        * All state has been migrated, let's switch to the new memcg.
> +        *
>          * It is safe to change page->mem_cgroup here because the page
> -        * is referenced, charged, and isolated - we can't race with
> -        * uncharging, charging, migration, or LRU putback.
> +        * is referenced, charged, isolated, and locked: we can't race
> +        * with (un)charging, migration, LRU putback, or anything else
> +        * that would rely on a stable page->mem_cgroup.
> +        *
> +        * Note that lock_page_memcg is a memcg lock, not a page lock,
> +        * to save space. As soon as we switch page->mem_cgroup to a
> +        * new memcg that isn't locked, the above state can change
> +        * concurrently again. Make sure we're truly done with it.
>          */
> +       smp_mb();

You said theoretical race in the subject but the above comment
convinced me that smp_mb() is required. So, why is the race still
theoretical?

>
> -       /* caller should have done css_get */
> -       page->mem_cgroup = to;
> +       page->mem_cgroup = to;  /* caller should have done css_get */
>
> -       spin_unlock_irqrestore(&from->move_lock, flags);
> +       __unlock_page_memcg(from);
>
>         ret = 0;
>
> --
> 2.26.0
>

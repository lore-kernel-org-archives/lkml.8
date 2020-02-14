Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D811C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DBE2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3eP57FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBNWok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:44:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43370 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgBNWok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:44:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so10652116oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BieUm8+5YIDYgpe+FhMyY8gKnYdFr8G076ODKkZnCSI=;
        b=L3eP57FHmgpwX0BXPjR4dUwWPeYx6VHKH+dC4bF26fzsa3xP9s0imlWA+E6uN0S05K
         6yf51tiwkAerV/SJR1fGiA7Wr7WLGZ+zBOxXt4Qenpn5rfbjKgPm/mIibXFJTTd1Tp8t
         Bq0p5XsdziD0E4io0BuEe8rJgP3xOcdLDCN8eS8l52k8BwSaxsGA+Wt0tRIEeIquIIJ2
         auK+UxC6K6JqgIfyOGPbbekMOBylIsf5X7uNHK4QhAbHdShRHe/5UFvUjzVGbTfgjopB
         SV18xbWZSDFVHxHJtWH3a/dtf1SPGdnTpCqTw50f6gi648Gtjpk6CtDMj2n25/NpIiJR
         DBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BieUm8+5YIDYgpe+FhMyY8gKnYdFr8G076ODKkZnCSI=;
        b=tFh/UI+i6Ukj9BOZLiWSZ6a+Djgk0TM83M67sh+qsN9MNfa1JQLXFSIez7/PQMeDCa
         EtYolCYXhmE5wramwwGBjkbURaZ2AtN/ohq7JmyVC3rXZbSUQ8bR/voX3g5CdPTAQnTt
         HsUGrxu9UqMz8IvnTCURd+rxDD48hdLhByQpasD/jJE69g5Ioo3HjO00cVHWyN6eeShf
         wOhv8VmtGMdFvg+CdOLKobsj9xRKWj71qcisG4CyBpwM6NAY96Xvcj6Xvisv8cvuo3hj
         I2b03nTFU8hO7vw415aN/TRqVwJMQAoSgapserScOmT2v255RDZrHEGbpRrpk74vAtMs
         /dfg==
X-Gm-Message-State: APjAAAUCyA7upjvY52jlx2CWUr+woQVErTvz4lOxsgQzeJRlGFxgZgiP
        ttSrq9IM08wxi8XGhTHAnT+lHWyA9fD5PhJPRdekSg==
X-Google-Smtp-Source: APXvYqwtMloELc8yyjiKROZUWk9iBobR5zrhOA3kDqcmzqBo65VARWEAjndXv65IUMTNhasNaouQOIRld/mI5menbbA=
X-Received: by 2002:a05:6830:1e2b:: with SMTP id t11mr4117327otr.81.1581720279231;
 Fri, 14 Feb 2020 14:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <20200214223303.GA60585@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200214223303.GA60585@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 14 Feb 2020 14:44:28 -0800
Message-ID: <CALvZod5Vbua5=J6p2RDqmdJTC3D234zy41t-DHrL=qWMjh_OdA@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>, Tejun Heo <tj@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 2:33 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Feb 14, 2020 at 02:24:15PM -0800, Shakeel Butt wrote:
> > We are testing network memory accounting in our setup and noticed
> > inconsistent network memory usage and often unrelated cgroups network
> > usage correlates with testing workload. On further inspection, it
> > seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
> > irq context specially for cgroup v1.
> >
> > mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in irq context
> > and kind of assumes that this can only happen from sk_clone_lock()
> > and the source sock object has already associated cgroup. However in
> > cgroup v1, where network memory accounting is opt-in, the source sock
> > can be unassociated with any cgroup and the new cloned sock can get
> > associated with unrelated interrupted cgroup.
> >
> > Cgroup v2 can also suffer if the source sock object was created by
> > process in the root cgroup or if sk_alloc() is called in irq context.
> > The fix is to just do nothing in interrupt.
> >
> > Fixes: 2d7580738345 ("mm: memcontrol: consolidate cgroup socket tracking")
> > Fixes: d979a39d7242 ("cgroup: duplicate cgroup reference when cloning sockets")
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >
> > Changes since v1:
> > - Fix cgroup_sk_alloc() too.
> >
> >  kernel/cgroup/cgroup.c | 4 ++++
> >  mm/memcontrol.c        | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 9a8a5ded3c48..46e5f5518fba 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -6449,6 +6449,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
> >               return;
> >       }
> >
> > +     /* Do not associate the sock with unrelated interrupted task's memcg. */
>                                                                        ^^^^^
>                                                                        cgroup?
> > +     if (in_interrupt())
> > +             return;
> > +
> >       rcu_read_lock();
> >
> >       while (true) {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 63bb6a2aab81..f500da82bfe8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6697,6 +6697,10 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> >               return;
> >       }
>
> Can you, please, include the stacktrace into the commit log?
> Except a minor typo (see above),
> Reviewed-by: Roman Gushchin <guro@fb.com>
>
> A really good catch.
>

Thanks, I will add the stack trace and fix the typo.

Shakeel

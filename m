Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EEFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CFF20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idQo3VGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEDNyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:54:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7280C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 06:54:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so9718452ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVLyyN3yDodf1IeoqdYhIU2b08myf8w4Qqrbvm4OznY=;
        b=idQo3VGpbrqwIifYmGR0a0EXYGiEZ9XzDk3FKw23XHc0K6JEMrIfLIXOVpTHNFxVn4
         fBXdc2Lv5STOs92mF4cOx5Fgbw6cZB7lLAUwRSCndR8WE7SqYkkp0kd2ath7wKjM/kmR
         GpgDMOzcLcBtpac0PraW4Rb6j0W+PMPs7VY6T9IQZNpz7uy2sIejK6HuQEk4VBeCTCtu
         ABxBnFOxp4m++CoMNOGY0n4RQm2I4KU9I5AEi8M/D35y0+Jt5CCmzdyC9n1tPH2Rf2Po
         /P3E0CMiEvFpTfV4zclQnU0CT4fPDqPRXyj1jRqfeg/x9ydp3iz1Tv3oudmuJXUcguuQ
         3M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVLyyN3yDodf1IeoqdYhIU2b08myf8w4Qqrbvm4OznY=;
        b=Y/Tq38tkV/6rmeBRQMgfdBmna0tU3rR/MXrouD4l5b08avLMiVZ8jTrFbVHKYFpZuE
         bvxmd1MvAcrSQLGGt1b4BJzX0byDqfjJlZ1LxKJrs56HiSVv+oHakiFMwbzgBi48Gvps
         vx7IdJooeYgJKHk0gysEwXbvEUCZn9GQJzw9pJvja9dMqfRBZGbR3iJSMsz6Dg2ToNBc
         mx9qKfEh5ypvqq3A3WS6lQRvVlTXDFhiqNQOBlbhcjXgMDUufSQeLWtATbt37EHORSjA
         ZicW1nnMzg/Oct8UFon4BbxTQHdnGKp2WOyegzTZmuJYVv8xR4K/0P43ur/CYKq6CTej
         sPKA==
X-Gm-Message-State: AGi0PubwOnlUk6/CEZ3M37OqUhxtLXYXI6jSMtR5pJ56foLq0cIlk7Ic
        yzDs/xFQieiURLK+4Law5zRQ24Q8Oq4/t/sk+Sxl5Q==
X-Google-Smtp-Source: APiQypLmK+Lu3onhk1e4czRFQm35FjeQJ5Js+7o4FHZrpWrpG84HWZRhWwd8FqQ01PdeSaWoMxUcnoTtgVngjWa85Ms=
X-Received: by 2002:a2e:9713:: with SMTP id r19mr10619521lji.89.1588600492864;
 Mon, 04 May 2020 06:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
In-Reply-To: <20200504065600.GA22838@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 06:54:40 -0700
Message-ID: <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 30-04-20 11:27:12, Shakeel Butt wrote:
> > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > succeed. However if oom-killer does not find a process for killing, it
> > dumps a lot of warnings.
>
> It shouldn't dump much more than the regular OOM report AFAICS. Sure
> there is "Out of memory and no killable processes..." message printed as
> well but is that a real problem?
>
> > Deleting a memcg does not reclaim memory from it and the memory can
> > linger till there is a memory pressure. One normal way to proactively
> > reclaim such memory is to set memory.max to 0 just before deleting the
> > memcg. However if some of the memcg's memory is pinned by others, this
> > operation can trigger an oom-kill without any process and thus can log a
> > lot un-needed warnings. So, ignore all such warnings from memory.max.
>
> OK, I can see why you might want to use memory.max for that purpose but
> I do not really understand why the oom report is a problem here.

It may not be a problem for an individual or small scale deployment
but when "sweep before tear down" is the part of the workflow for
thousands of machines cycling through hundreds of thousands of cgroups
then we can potentially flood the logs with not useful dumps and may
hide (or overflow) any useful information in the logs.

> memory.max can trigger the oom kill and user should be expecting the oom
> report under that condition. Why is "no eligible task" so special? Is it
> because you know that there won't be any tasks for your particular case?
> What about other use cases where memory.max is not used as a "sweep
> before tear down"?

What other such use-cases would be? The only use-case I can envision
of adjusting limits dynamically of a live cgroup are resource
managers. However for cgroup v2, memory.high is the recommended way to
limit the usage, so, why would resource managers be changing
memory.max instead of memory.high? I am not sure. What do you think?
FB is moving away from limits setting, so, not sure if they have
thought of these cases.

BTW for such use-cases, shouldn't we be taking the memcg's oom_lock?

>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  include/linux/oom.h | 3 +++
> >  mm/memcontrol.c     | 9 +++++----
> >  mm/oom_kill.c       | 2 +-
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > index c696c265f019..6345dc55df64 100644
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -52,6 +52,9 @@ struct oom_control {
> >
> >       /* Used to print the constraint info. */
> >       enum oom_constraint constraint;
> > +
> > +     /* Do not warn even if there is no process to be killed. */
> > +     bool no_warn;
> >  };
> >
> >  extern struct mutex oom_lock;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 317dbbaac603..a1f00d9b9bb0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1571,7 +1571,7 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> >  }
> >
> >  static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > -                                  int order)
> > +                                  int order, bool no_warn)
> >  {
> >       struct oom_control oc = {
> >               .zonelist = NULL,
> > @@ -1579,6 +1579,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >               .memcg = memcg,
> >               .gfp_mask = gfp_mask,
> >               .order = order,
> > +             .no_warn = no_warn,
> >       };
> >       bool ret;
> >
> > @@ -1821,7 +1822,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> >               mem_cgroup_oom_notify(memcg);
> >
> >       mem_cgroup_unmark_under_oom(memcg);
> > -     if (mem_cgroup_out_of_memory(memcg, mask, order))
> > +     if (mem_cgroup_out_of_memory(memcg, mask, order, false))
> >               ret = OOM_SUCCESS;
> >       else
> >               ret = OOM_FAILED;
> > @@ -1880,7 +1881,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
> >               mem_cgroup_unmark_under_oom(memcg);
> >               finish_wait(&memcg_oom_waitq, &owait.wait);
> >               mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> > -                                      current->memcg_oom_order);
> > +                                      current->memcg_oom_order, false);
> >       } else {
> >               schedule();
> >               mem_cgroup_unmark_under_oom(memcg);
> > @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> >               }
> >
> >               memcg_memory_event(memcg, MEMCG_OOM);
> > -             if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> > +             if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
> >                       break;
> >       }
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 463b3d74a64a..5ace39f6fe1e 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1098,7 +1098,7 @@ bool out_of_memory(struct oom_control *oc)
> >
> >       select_bad_process(oc);
> >       /* Found nothing?!?! */
> > -     if (!oc->chosen) {
> > +     if (!oc->chosen && !oc->no_warn) {
> >               dump_header(oc, NULL);
> >               pr_warn("Out of memory and no killable processes...\n");
> >               /*
> > --
> > 2.26.2.526.g744177e7f7-goog
>
> --
> Michal Hocko
> SUSE Labs

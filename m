Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1FBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4AD20704
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNtLk0Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGAENC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgGAENB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:13:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:13:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so25312725ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6rUzlISrs34S85/JGWbESTTDuKcTfeZ4SL0WqYY/u0=;
        b=DNtLk0VnUIIBJTq1Eoxv9t88gHW8Ptc6CdP9QpJt8jvvdaPrs/OoPHk202tbiLztbM
         /EJVRE/Qq74hIdO7pVtEiyR8rybRiAiLf1NnJ1M4vkDD0YJQAfy/MRI72bEkMgptTOhL
         KCihf1cTUhbY3QOihwQGZWHDWb7E8gRl7poU5uM5qn9/OXNrbi6f1ymQ9LzMVzuGVR8t
         K4du5sbTXfrh8YbzYpTiQh2ZW2EG5u/hvR0RBFUPUDdlH8oJ6poUxl1ShBq2gKQJtaQV
         zz9CfWISnE27H+ZGonrmnrNNghR8D4k8cHWGcvlAXx3pVuB3jw26FY5Vp28u6UPK7o6Q
         0B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6rUzlISrs34S85/JGWbESTTDuKcTfeZ4SL0WqYY/u0=;
        b=qsXVsHiEJz6U3Pnn1NKhVBpBRA/rQT5dQyQDxwCF6Rxy7FmaJ5yF8AfR4xI6Whnqc5
         RyipFCMOaokba4DLBGYmgJTac3imqW5z5l37DOI5TVyhWJbSo9WZhZ7wNKXn25w+rWmS
         oJuo+6stMIASO7QqKyjFM5n56YGOb4Ar9DVe95yc9OwSGZClr/YVq+r2dgKIqLnhLQdS
         k1X3/rRp/nfyVfTnjxD65qrUi6VKf+tHF6VchlA7zPqVt8XiG2oPbP5jRB2ey9HgYsWB
         Pe1ZBoKBqIzTgYg3KxN6OVavd9S6sDWy+nvxMeTrmWmTlGlyLDZ727XNHN4HcAkl97dP
         j9Lg==
X-Gm-Message-State: AOAM530CWHuaEkXl8pQfEvmImnwJf/G/9vusbUl/BXvyTSqmLCitQpYR
        QLY6+oRzeIcaVx/ct4IfkGMMpg+T9FAaapZTxKw=
X-Google-Smtp-Source: ABdhPJzSy2lK5wKJ+mBYqHetY1JduBex8mf28+evh5uyBni9bihb3pH+/Qmds/5JkCnlJdhp0gemROMclKjRaQKYHgI=
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr5618287ljk.335.1593576779321;
 Tue, 30 Jun 2020 21:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200630005422.2389686-1-daeho43@gmail.com> <a10baad2-350a-ea1b-c338-63b2bc58a26a@huawei.com>
In-Reply-To: <a10baad2-350a-ea1b-c338-63b2bc58a26a@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 1 Jul 2020 13:12:48 +0900
Message-ID: <CACOAw_wPVQP7qrXwb9fG-+450e6e0XF5MOv-5cpRuhiEWN_cCw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add GC_URGENT_LOW mode in gc_urgent
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it's correct.

2020=EB=85=84 7=EC=9B=94 1=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:35, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/6/30 8:54, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a new gc_urgent mode, GC_URGENT_LOW, in which mode
> > F2FS will lower the bar of checking idle in order to
> > process outstanding discard commands and GC a little bit
> > aggressively.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  4 +++-
> >  fs/f2fs/f2fs.h                          | 10 ++++++++--
> >  fs/f2fs/gc.c                            |  6 +++---
> >  fs/f2fs/segment.c                       |  4 ++--
> >  fs/f2fs/sysfs.c                         |  6 ++++--
> >  5 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index 4bb93a06d8ab..7f730c4c8df2 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -229,7 +229,9 @@ Date:             August 2017
> >  Contact:     "Jaegeuk Kim" <jaegeuk@kernel.org>
> >  Description: Do background GC agressively when set. When gc_urgent =3D=
 1,
> >               background thread starts to do GC by given gc_urgent_slee=
p_time
> > -             interval. It is set to 0 by default.
> > +             interval. When gc_urgent =3D 2, F2FS will lower the bar o=
f
> > +             checking idle in order to process outstanding discard com=
mands
> > +             and GC a little bit aggressively. It is set to 0 by defau=
lt.
> >
> >  What:                /sys/fs/f2fs/<disk>/gc_urgent_sleep_time
> >  Date:                August 2017
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e6e47618a357..4b28fd42fdbc 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1283,7 +1283,8 @@ enum {
> >       GC_NORMAL,
> >       GC_IDLE_CB,
> >       GC_IDLE_GREEDY,
> > -     GC_URGENT,
> > +     GC_URGENT_HIGH,
> > +     GC_URGENT_LOW,
> >  };
> >
> >  enum {
> > @@ -1540,6 +1541,7 @@ struct f2fs_sb_info {
> >       unsigned int cur_victim_sec;            /* current victim section=
 num */
> >       unsigned int gc_mode;                   /* current GC state */
> >       unsigned int next_victim_seg[2];        /* next segment in victim=
 section */
> > +
> >       /* for skip statistic */
> >       unsigned int atomic_files;              /* # of opened atomic fil=
e */
> >       unsigned long long skipped_atomic_files[2];     /* FG_GC and BG_G=
C */
> > @@ -2480,7 +2482,7 @@ static inline void *f2fs_kmem_cache_alloc(struct =
kmem_cache *cachep,
> >
> >  static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
> >  {
> > -     if (sbi->gc_mode =3D=3D GC_URGENT)
> > +     if (sbi->gc_mode =3D=3D GC_URGENT_HIGH)
> >               return true;
> >
> >       if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) =
||
> > @@ -2498,6 +2500,10 @@ static inline bool is_idle(struct f2fs_sb_info *=
sbi, int type)
> >                       atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
> >               return false;
> >
> > +     if (sbi->gc_mode =3D=3D GC_URGENT_LOW &&
> > +                     (type =3D=3D DISCARD_TIME || type =3D=3D GC_TIME)=
)
> > +             return true;
> > +
> >       return f2fs_time_over(sbi, type);
> >  }
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 6eec3b2d606d..3b718da69910 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -82,7 +82,7 @@ static int gc_thread_func(void *data)
> >                * invalidated soon after by user update or deletion.
> >                * So, I'd like to wait some time to collect dirty segmen=
ts.
> >                */
> > -             if (sbi->gc_mode =3D=3D GC_URGENT) {
> > +             if (sbi->gc_mode =3D=3D GC_URGENT_HIGH) {
> >                       wait_ms =3D gc_th->urgent_sleep_time;
> >                       down_write(&sbi->gc_lock);
> >                       goto do_gc;
> > @@ -176,7 +176,7 @@ static int select_gc_type(struct f2fs_sb_info *sbi,=
 int gc_type)
> >               gc_mode =3D GC_CB;
> >               break;
> >       case GC_IDLE_GREEDY:
> > -     case GC_URGENT:
> > +     case GC_URGENT_HIGH:
> >               gc_mode =3D GC_GREEDY;
> >               break;
> >       }
> > @@ -211,7 +211,7 @@ static void select_policy(struct f2fs_sb_info *sbi,=
 int gc_type,
> >        * foreground GC and urgent GC cases.
> >        */
> >       if (gc_type !=3D FG_GC &&
> > -                     (sbi->gc_mode !=3D GC_URGENT) &&
> > +                     (sbi->gc_mode !=3D GC_URGENT_HIGH) &&
> >                       p->max_search > sbi->max_victim_search)
> >               p->max_search =3D sbi->max_victim_search;
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index b45e473508a9..5924b3965ae4 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -174,7 +174,7 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
> >
> >       if (f2fs_lfs_mode(sbi))
> >               return false;
> > -     if (sbi->gc_mode =3D=3D GC_URGENT)
> > +     if (sbi->gc_mode =3D=3D GC_URGENT_HIGH)
> >               return true;
> >       if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> >               return true;
> > @@ -1759,7 +1759,7 @@ static int issue_discard_thread(void *data)
> >                       continue;
> >               }
> >
> > -             if (sbi->gc_mode =3D=3D GC_URGENT)
> > +             if (sbi->gc_mode =3D=3D GC_URGENT_HIGH)
> >                       __init_discard_policy(sbi, &dpolicy, DPOLICY_FORC=
E, 1);
> >
> >               sb_start_intwrite(sbi->sb);
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index e877c59b9fdb..ab40e1f89f23 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -350,14 +350,16 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >               return -EINVAL;
> >
> >       if (!strcmp(a->attr.name, "gc_urgent")) {
> > -             if (t >=3D 1) {
> > -                     sbi->gc_mode =3D GC_URGENT;
> > +             if (t =3D=3D 1) {
> > +                     sbi->gc_mode =3D GC_URGENT_HIGH;
> >                       if (sbi->gc_thread) {
> >                               sbi->gc_thread->gc_wake =3D 1;
> >                               wake_up_interruptible_all(
> >                                       &sbi->gc_thread->gc_wait_queue_he=
ad);
> >                               wake_up_discard_thread(sbi, true);
> >                       }
> > +             } else if (t =3D=3D 2) {
> > +                     sbi->gc_mode =3D GC_URGENT_LOW;
> >               } else {
> >                       sbi->gc_mode =3D GC_NORMAL;
>
> As functionality description in sysfs doc, shouldn't it be:
>
> if (t =3D=3D 0) {
>         sbi->gc_mode =3D GC_NORMAL;
> } else if (t =3D=3D 1) {
>         sbi->gc_mode =3D GC_URGENT_HIGH;
>         ...
> } else if (t =3D=3D 2) {
>         sbi->gc_mode =3D GC_URGENT_LOW;
> } else {
>         return -EINVAL;
> }
> return count;
>
> >               }
> >

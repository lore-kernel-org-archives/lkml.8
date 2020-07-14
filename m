Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C428C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0A62242E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mn0Ryrht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGNPrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGNPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:47:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE403C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:47:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so17719144edy.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXa/a8+v6atJW9I3K/8i8cY/Lmvtpiv+5qg62twrTiI=;
        b=mn0RyrhtCpG4LO11bnCZa/lH0u4e10/twWy/TsKJcWSQwrFQ5uc6hzPuo8XA/9zijo
         WXpQOqlkhvbUvdaMnYvaL5yMyMBiI13+6TT7c2XLV0U0dSXQYpZixce2KzXkEc9EMl61
         OqZZyQ5PLT6Z1OFgRTGde6rsKiTpakTwwGXYbmnV9rjo/Kjf6jGOKvwGN+YRjLW9lkhC
         kRnWpIq1+3mRuVGMoYQC1U7VWPy3zx8sqXja+EjvisR61blv1JMOgRN/U/u/wo35VUQo
         WZNr9i8Jsh/wLAI1XKQxMW1+KlUDFBsmTNNVjEHsl9KYkXD8OHwk3pGLriKFn9pzN7k3
         84yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXa/a8+v6atJW9I3K/8i8cY/Lmvtpiv+5qg62twrTiI=;
        b=A6aMEGV/VxvHrE8O0D7vegzYrHgQD1Wo1ud8GO7VOxnA9H1jF2MNAx7Z3W6aQ3MAxp
         rUIQs8k1pzN6j6VqYxGy6jvcoOpCbKgG/x6CWoITmbVAC18F8iFjEqZfQcDLx96Wryuc
         gz6eY0uktFc2gfhx34Tk1slGZZVsSh9IyAX4ACqPmCDDRtw2FA+MGzpfW4GludiE0Ube
         YrVlq/CqFMtGR2bNA6bPjhuqd5TRPz/tl6n7JT2wFMX9NddnQIBiVOB9aegRKqboQM7x
         Yr/xQnBxYKeX/JtYwOdefgDyTLXEc7t6POhfNgcFToroTIsBGz8o3s/FRT0QJpaMkj+s
         8Kgg==
X-Gm-Message-State: AOAM530PHPI5yGzjVJYnJiGnsqoxvUeLJhOKWZcUArXcWOl/3w48j9te
        hokWM0oHTVxiCYXoLaAQYOhvZz0nz32WKQmUrHYhxA==
X-Google-Smtp-Source: ABdhPJy+kyePNsPhuIE7ky0xWpId0cA5UdAi/NGYJUBWmwsXrWoAfYSuKigLeAwba34hq5mKjf42yjcDEybxERrageM=
X-Received: by 2002:aa7:dd8e:: with SMTP id g14mr5326572edv.208.1594741626195;
 Tue, 14 Jul 2020 08:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000b5f9d059aa2037f@google.com> <20200714033252.8748-1-hdanton@sina.com>
 <20200714053205.15240-1-hdanton@sina.com> <20200714140859.15156-1-hdanton@sina.com>
 <20200714141815.GP24642@dhcp22.suse.cz>
In-Reply-To: <20200714141815.GP24642@dhcp22.suse.cz>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 14 Jul 2020 08:46:55 -0700
Message-ID: <CAHRSSEzbCW3E0QTR0ryf3p=5J5uhs_vY2D6fFQEzP=HeCDkPGQ@mail.gmail.com>
Subject: Re: possible deadlock in shmem_fallocate (4)
To:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Suren Baghdasaryan +Hridya Valsaraju who support the ashmem driver.


On Tue, Jul 14, 2020 at 7:18 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 14-07-20 22:08:59, Hillf Danton wrote:
> >
> > On Tue, 14 Jul 2020 10:26:29 +0200 Michal Hocko wrote:
> > > On Tue 14-07-20 13:32:05, Hillf Danton wrote:
> > > >
> > > > On Mon, 13 Jul 2020 20:41:11 -0700 Eric Biggers wrote:
> > > > > On Tue, Jul 14, 2020 at 11:32:52AM +0800, Hillf Danton wrote:
> > > > > >
> > > > > > Add FALLOC_FL_NOBLOCK and on the shmem side try to lock inode upon the
> > > > > > new flag. And the overall upside is to keep the current gfp either in
> > > > > > the khugepaged context or not.
> > > > > >
> > > > > > --- a/include/uapi/linux/falloc.h
> > > > > > +++ b/include/uapi/linux/falloc.h
> > > > > > @@ -77,4 +77,6 @@
> > > > > >   */
> > > > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > > > >
> > > > > > +#define FALLOC_FL_NOBLOCK            0x80
> > > > > > +
> > > > >
> > > > > You can't add a new UAPI flag to fix a kernel-internal problem like this.
> > > >
> > > > Sounds fair, see below.
> > > >
> > > > What the report indicates is a missing PF_MEMALLOC_NOFS and it's
> > > > checked on the ashmem side and added as an exception before going
> > > > to filesystem. On shmem side, no more than a best effort is paid
> > > > on the inteded exception.
> > > >
> > > > --- a/drivers/staging/android/ashmem.c
> > > > +++ b/drivers/staging/android/ashmem.c
> > > > @@ -437,6 +437,7 @@ static unsigned long
> > > >  ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > >  {
> > > >   unsigned long freed = 0;
> > > > + bool nofs;
> > > >
> > > >   /* We might recurse into filesystem code, so bail out if necessary */
> > > >   if (!(sc->gfp_mask & __GFP_FS))
> > > > @@ -445,6 +446,11 @@ ashmem_shrink_scan(struct shrinker *shri
> > > >   if (!mutex_trylock(&ashmem_mutex))
> > > >           return -1;
> > > >
> > > > + /* enter filesystem with caution: nonblock on locking */
> > > > + nofs = current->flags & PF_MEMALLOC_NOFS;
> > > > + if (!nofs)
> > > > +         current->flags |= PF_MEMALLOC_NOFS;
> > > > +
> > > >   while (!list_empty(&ashmem_lru_list)) {
> > > >           struct ashmem_range *range =
> > > >                   list_first_entry(&ashmem_lru_list, typeof(*range), lru);
> > >
> > > I do not think this is an appropriate fix. First of all is this a real
> > > deadlock or a lockdep false positive? Is it possible that ashmem just
> >
> > The warning matters and we can do something to quiesce it.
>
> The underlying issue should be fixed rather than _something_ done to
> silence it.
>
> > > needs to properly annotate its shmem inodes? Or is it possible that
> > > the internal backing shmem file is visible to the userspace so the write
> > > path would be possible?
> > >
> > > If this a real problem then the proper fix would be to set internal
> > > shmem mapping's gfp_mask to drop __GFP_FS.
> >
> > Thanks for the tip, see below.
> >
> > Can you expand a bit on how it helps direct reclaimers like khugepaged
> > in the syzbot report wrt deadlock?
>
> I do not understand your question.
>
> > TBH I have difficult time following
> > up after staring at the chart below for quite a while.
>
> Yes, lockdep reports are quite hard to follow and they tend to confuse
> one hell out of me. But this one says that there is a reclaim dependency
> between the shmem inode lock and the reclaim context.
>
> > Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(fs_reclaim);
> >                                lock(&sb->s_type->i_mutex_key#15);
> >                                lock(fs_reclaim);
> >
> >   lock(&sb->s_type->i_mutex_key#15);
>
> Please refrain from proposing fixes until the actual problem is
> understood. I suspect that this might be just false positive because the
> lockdep cannot tell the backing shmem which is internal to ashmem(?)
> with any general shmem. But somebody really familiar with ashmem code
> should have a look I believe.
>
> --
> Michal Hocko
> SUSE Labs

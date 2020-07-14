Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43A022518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4yd2tYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgGNRce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:32:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:32:33 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a17so8945194vsq.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKQqoE49hY1h24A/ULTRwztiia1lkZDkVuV1AI5gZxk=;
        b=I4yd2tYCFpKnBAEJVZuPcvzbUCV4m/tg5VgJt6FqT4ufqa7EoCc4B2aKyESglcBlgX
         PLu4FPf8UWVCaeYsW+RGc0mQb7Hv5XWWXtexPhjFNgPDsY5V4ftKWElKMV0Tws+zwAXk
         qsZVPa5AxaahaIkc+inzI2cbFValQXQJWPdaYnZnwX4h/kTbqoBfVobXHqN6ZWuUDQm3
         VWmf8+5x8A8U3rMjwf9AVK0Csnfu+RnYYvDQ+uONGJpdU7Lot0o+ZjDbTCYt3RmkJsca
         EjLT2sGS9FszEK9xAw75LgkHEDZZapEbvAe0j1E/OvfVxw/WQI1UTWnQoiWZXYQZwWH/
         VhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKQqoE49hY1h24A/ULTRwztiia1lkZDkVuV1AI5gZxk=;
        b=VvB0pJI6fiabX+i80lxqCVnMawGZWj/v4220ZM2DIw3v+tfI0atT1HinE9JziT+6ih
         QbfesCKrawv8N9nps9qLsyi3PRe3griDxSyFrVAbBwUMUVi0MyoXs+5KNl2vhdKcRoEQ
         4tg94JskIqiSfmqunRgzaK64KUJ63FYNuF0SIPYp/BW9T5ooljvU6X1U5RUKGIL4In5i
         Sp5Hro2PK618XMuxCyI2OrSOX9Ie3nTmd2YrcFEzKmsyISHiAAKVwjF15+1rUgwwNlwb
         0Gqgy9A8Z5HbL4PHgLwM6jcsW2rwX8lCkyM60we9M6usEkIUvjashgYkB9MG0Z+PS6HH
         eZPQ==
X-Gm-Message-State: AOAM530RzQXy4Mx8SfxFOZDbQLdSCIetT82Euenr0xl5C+JAIYryyriu
        h11HtqEg64yNPSjw5iJMj2yBzVME8ApxPwb40pnxYw==
X-Google-Smtp-Source: ABdhPJwqIAsR0maZT2/rFgCAmd2x6qhrpX0RcDNO/WUFfXhQmZZ7p9b7sNbXzqCJmWk2gEmDf2IPXFGRTWsIZ2b9Ia0=
X-Received: by 2002:a67:ed82:: with SMTP id d2mr4484456vsp.221.1594747952390;
 Tue, 14 Jul 2020 10:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000b5f9d059aa2037f@google.com> <20200714033252.8748-1-hdanton@sina.com>
 <20200714053205.15240-1-hdanton@sina.com> <20200714140859.15156-1-hdanton@sina.com>
 <20200714141815.GP24642@dhcp22.suse.cz> <CAHRSSEzbCW3E0QTR0ryf3p=5J5uhs_vY2D6fFQEzP=HeCDkPGQ@mail.gmail.com>
 <CAJuCfpExhJJO_xPk663-eUkmAXVVwNDd9a7ahQuwMW8JVMBJpg@mail.gmail.com>
In-Reply-To: <CAJuCfpExhJJO_xPk663-eUkmAXVVwNDd9a7ahQuwMW8JVMBJpg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Jul 2020 10:32:20 -0700
Message-ID: <CAJuCfpFz9kEfTPxcausVj63mUvU7i6Dvv6=KNePVX2qR+-Ci2A@mail.gmail.com>
Subject: Re: possible deadlock in shmem_fallocate (4)
To:     Todd Kjos <tkjos@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Jul 14, 2020 at 9:41 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Jul 14, 2020 at 8:47 AM Todd Kjos <tkjos@google.com> wrote:
> >
> > +Suren Baghdasaryan +Hridya Valsaraju who support the ashmem driver.
>
> Thanks for looping me in.
>
> >
> >
> > On Tue, Jul 14, 2020 at 7:18 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 14-07-20 22:08:59, Hillf Danton wrote:
> > > >
> > > > On Tue, 14 Jul 2020 10:26:29 +0200 Michal Hocko wrote:
> > > > > On Tue 14-07-20 13:32:05, Hillf Danton wrote:
> > > > > >
> > > > > > On Mon, 13 Jul 2020 20:41:11 -0700 Eric Biggers wrote:
> > > > > > > On Tue, Jul 14, 2020 at 11:32:52AM +0800, Hillf Danton wrote:
> > > > > > > >
> > > > > > > > Add FALLOC_FL_NOBLOCK and on the shmem side try to lock inode upon the
> > > > > > > > new flag. And the overall upside is to keep the current gfp either in
> > > > > > > > the khugepaged context or not.
> > > > > > > >
> > > > > > > > --- a/include/uapi/linux/falloc.h
> > > > > > > > +++ b/include/uapi/linux/falloc.h
> > > > > > > > @@ -77,4 +77,6 @@
> > > > > > > >   */
> > > > > > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > > > > > >
> > > > > > > > +#define FALLOC_FL_NOBLOCK            0x80
> > > > > > > > +
> > > > > > >
> > > > > > > You can't add a new UAPI flag to fix a kernel-internal problem like this.
> > > > > >
> > > > > > Sounds fair, see below.
> > > > > >
> > > > > > What the report indicates is a missing PF_MEMALLOC_NOFS and it's
> > > > > > checked on the ashmem side and added as an exception before going
> > > > > > to filesystem. On shmem side, no more than a best effort is paid
> > > > > > on the inteded exception.
> > > > > >
> > > > > > --- a/drivers/staging/android/ashmem.c
> > > > > > +++ b/drivers/staging/android/ashmem.c
> > > > > > @@ -437,6 +437,7 @@ static unsigned long
> > > > > >  ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > > > >  {
> > > > > >   unsigned long freed = 0;
> > > > > > + bool nofs;
> > > > > >
> > > > > >   /* We might recurse into filesystem code, so bail out if necessary */
> > > > > >   if (!(sc->gfp_mask & __GFP_FS))
> > > > > > @@ -445,6 +446,11 @@ ashmem_shrink_scan(struct shrinker *shri
> > > > > >   if (!mutex_trylock(&ashmem_mutex))
> > > > > >           return -1;
> > > > > >
> > > > > > + /* enter filesystem with caution: nonblock on locking */
> > > > > > + nofs = current->flags & PF_MEMALLOC_NOFS;
> > > > > > + if (!nofs)
> > > > > > +         current->flags |= PF_MEMALLOC_NOFS;
> > > > > > +
> > > > > >   while (!list_empty(&ashmem_lru_list)) {
> > > > > >           struct ashmem_range *range =
> > > > > >                   list_first_entry(&ashmem_lru_list, typeof(*range), lru);
> > > > >
> > > > > I do not think this is an appropriate fix. First of all is this a real
> > > > > deadlock or a lockdep false positive? Is it possible that ashmem just
> > > >
> > > > The warning matters and we can do something to quiesce it.
> > >
> > > The underlying issue should be fixed rather than _something_ done to
> > > silence it.
> > >
> > > > > needs to properly annotate its shmem inodes? Or is it possible that
> > > > > the internal backing shmem file is visible to the userspace so the write
> > > > > path would be possible?
> > > > >
> > > > > If this a real problem then the proper fix would be to set internal
> > > > > shmem mapping's gfp_mask to drop __GFP_FS.
> > > >
> > > > Thanks for the tip, see below.
> > > >
> > > > Can you expand a bit on how it helps direct reclaimers like khugepaged
> > > > in the syzbot report wrt deadlock?
> > >
> > > I do not understand your question.
> > >
> > > > TBH I have difficult time following
> > > > up after staring at the chart below for quite a while.
> > >
> > > Yes, lockdep reports are quite hard to follow and they tend to confuse
> > > one hell out of me. But this one says that there is a reclaim dependency
> > > between the shmem inode lock and the reclaim context.
> > >
> > > > Possible unsafe locking scenario:
> > > >
> > > >        CPU0                    CPU1
> > > >        ----                    ----
> > > >   lock(fs_reclaim);
> > > >                                lock(&sb->s_type->i_mutex_key#15);
> > > >                                lock(fs_reclaim);
> > > >
> > > >   lock(&sb->s_type->i_mutex_key#15);
> > >
> > > Please refrain from proposing fixes until the actual problem is
> > > understood. I suspect that this might be just false positive because the
> > > lockdep cannot tell the backing shmem which is internal to ashmem(?)
> > > with any general shmem.

Actually looking some more into this, I think you are right. Ashmem
currently does not redirect writes into the backing shmem and
fallocate call from ashmem_shrink_scan is always performed against
asma->file, which is the backing shmem. IOW writes into the backing
shmem are not supported, therefore this concurrent locking can't
happen.

I'm not sure how we can annotate the fact that the inode_lock in
generic_file_write_iter and in shmem_fallocate always operate on
different inodes. Ideas?

> > >  But somebody really familiar with ashmem code
> > > should have a look I believe.
>
> I believe the deadlock is possible if a write to ashmem fd coincides
> with shrinking of ashmem caches. I just developed a possible fix here
> https://android-review.googlesource.com/c/kernel/common/+/1361205 but
> wanted to test it before posting upstream. The idea is to detect such
> a race between write and cache shrinking operations and let
> ashmem_shrink_scan bail out if the race is detected instead of taking
> inode_lock. AFAIK writing ashmem files is not a usual usage for ashmem
> (standard usage is to mmap it and use as shared memory), therefore
> this bailing out early should not affect ashmem cache maintenance
> much. Besides ashmem_shrink_scan already bails out early if a
> contention on ashmem_mutex is detected, which is a much more probable
> case (see: https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/staging/android/ashmem.c#L497).
>
> I'll test and post the patch here in a day or so if there are no early
> objections to it.
> Thanks!
>
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs

Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC68D22507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594736302;
	bh=C9GDixwLHPexvqfhXzRhZ8Gkagj6zmpnziT/CrUOpUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xl8zKZq+EOYoLpR5eKH/pcZMpb8OHoKWN53eoYIx/2MJQjy4FMnPojzc6egD5pban
	 XLw6tQ3R06hyM6V3ZwSJNwV2Tlj96NYlrl1NFFPRb8zg7sy4iZm+66fQjB+hy0+mN1
	 vLAdIi24aQmCFrXiP6YAFgsSBFTW0k8OOLqEg0OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGNOSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:18:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43772 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgGNOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:18:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id j4so21939564wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPqfDK3T+LSWfa2R0+LOJEnJPN7ZBy864xyViHBmNQo=;
        b=oiec0WdCUHv4X33lUFhdW+fTaFpDXFz+oLfhi7rMCRvzKkcHtgkLhLbg2JX1XNIO7V
         Uw3P9q21JZH8/z8ikJdBOLgAp88U9n8+VER0JLKWGprroRUmmaVUbKuY4uwUKh2T4LI0
         5/dQXnTphdrKLSW/uF/RqPFyiHiP9tU8DZ5viuZeOxKI4oYOB9jMYMYBqSyoQpKtx1/w
         PzhhC08X2RuaZklW4Vb7jahGhMOIxLGaRLjLjq2MW0hyaFWld95HwULcbfwrt5/yZSXM
         /7g2k2X4AyFvyx2hGvZRCo9+C0HqkIAlhw/a5h2qBsVdYxVvHgEYF41szwxjvrZC+j0x
         IVAw==
X-Gm-Message-State: AOAM531Fi7xydc0vZ+lA1PcW3GJ3Qmym8oFhvnEZw5SLExBBPSbOxUuv
        t7Ldy+/86BIZ0gHp8CoSEWw=
X-Google-Smtp-Source: ABdhPJzSJIFpcy8je8QoaOn+7sTmJWR6ZVWHrZuqwrHxoJvlNfO0Q+GwQhtamDhS1IQi0qFZsgfmtg==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr6250692wrn.179.1594736298161;
        Tue, 14 Jul 2020 07:18:18 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id 1sm4520678wmf.21.2020.07.14.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:18:17 -0700 (PDT)
Date:   Tue, 14 Jul 2020 16:18:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, arve@android.com, christian@brauner.io,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        hughd@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: possible deadlock in shmem_fallocate (4)
Message-ID: <20200714141815.GP24642@dhcp22.suse.cz>
References: <0000000000000b5f9d059aa2037f@google.com>
 <20200714033252.8748-1-hdanton@sina.com>
 <20200714053205.15240-1-hdanton@sina.com>
 <20200714140859.15156-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714140859.15156-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-07-20 22:08:59, Hillf Danton wrote:
> 
> On Tue, 14 Jul 2020 10:26:29 +0200 Michal Hocko wrote:
> > On Tue 14-07-20 13:32:05, Hillf Danton wrote:
> > > 
> > > On Mon, 13 Jul 2020 20:41:11 -0700 Eric Biggers wrote:
> > > > On Tue, Jul 14, 2020 at 11:32:52AM +0800, Hillf Danton wrote:
> > > > > 
> > > > > Add FALLOC_FL_NOBLOCK and on the shmem side try to lock inode upon the
> > > > > new flag. And the overall upside is to keep the current gfp either in
> > > > > the khugepaged context or not.
> > > > > 
> > > > > --- a/include/uapi/linux/falloc.h
> > > > > +++ b/include/uapi/linux/falloc.h
> > > > > @@ -77,4 +77,6 @@
> > > > >   */
> > > > >  #define FALLOC_FL_UNSHARE_RANGE		0x40
> > > > >  
> > > > > +#define FALLOC_FL_NOBLOCK		0x80
> > > > > +
> > > > 
> > > > You can't add a new UAPI flag to fix a kernel-internal problem like this.
> > > 
> > > Sounds fair, see below.
> > > 
> > > What the report indicates is a missing PF_MEMALLOC_NOFS and it's
> > > checked on the ashmem side and added as an exception before going
> > > to filesystem. On shmem side, no more than a best effort is paid
> > > on the inteded exception.
> > > 
> > > --- a/drivers/staging/android/ashmem.c
> > > +++ b/drivers/staging/android/ashmem.c
> > > @@ -437,6 +437,7 @@ static unsigned long
> > >  ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > >  {
> > >  	unsigned long freed = 0;
> > > +	bool nofs;
> > >  
> > >  	/* We might recurse into filesystem code, so bail out if necessary */
> > >  	if (!(sc->gfp_mask & __GFP_FS))
> > > @@ -445,6 +446,11 @@ ashmem_shrink_scan(struct shrinker *shri
> > >  	if (!mutex_trylock(&ashmem_mutex))
> > >  		return -1;
> > >  
> > > +	/* enter filesystem with caution: nonblock on locking */
> > > +	nofs = current->flags & PF_MEMALLOC_NOFS;
> > > +	if (!nofs)
> > > +		current->flags |= PF_MEMALLOC_NOFS;
> > > +
> > >  	while (!list_empty(&ashmem_lru_list)) {
> > >  		struct ashmem_range *range =
> > >  			list_first_entry(&ashmem_lru_list, typeof(*range), lru);
> > 
> > I do not think this is an appropriate fix. First of all is this a real
> > deadlock or a lockdep false positive? Is it possible that ashmem just
> 
> The warning matters and we can do something to quiesce it.

The underlying issue should be fixed rather than _something_ done to
silence it.
 
> > needs to properly annotate its shmem inodes? Or is it possible that
> > the internal backing shmem file is visible to the userspace so the write
> > path would be possible?
> > 
> > If this a real problem then the proper fix would be to set internal
> > shmem mapping's gfp_mask to drop __GFP_FS.
> 
> Thanks for the tip, see below.
> 
> Can you expand a bit on how it helps direct reclaimers like khugepaged
> in the syzbot report wrt deadlock?

I do not understand your question.

> TBH I have difficult time following
> up after staring at the chart below for quite a while.

Yes, lockdep reports are quite hard to follow and they tend to confuse
one hell out of me. But this one says that there is a reclaim dependency
between the shmem inode lock and the reclaim context.

> Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&sb->s_type->i_mutex_key#15);
>                                lock(fs_reclaim);
> 
>   lock(&sb->s_type->i_mutex_key#15);

Please refrain from proposing fixes until the actual problem is
understood. I suspect that this might be just false positive because the
lockdep cannot tell the backing shmem which is internal to ashmem(?)
with any general shmem. But somebody really familiar with ashmem code
should have a look I believe.

-- 
Michal Hocko
SUSE Labs

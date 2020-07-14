Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED79DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66BB21835
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594715195;
	bh=SBuBgJtRRTlCP4fyqBio+AuUhiyY9xIngdCP1RljlfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WaQz5hfSplSuVYSNpQYfpgbxysIa8yX18ja3RLb0jCcHi/ALqKyS7qL3gxd//mNHr
	 DhjhybS85lGyLVM15NV0whNcz28AYRyq6TU4ufDlTWgSVBpSlASmNeBNDLDlBjlLzI
	 mux45q6aw+kfqZDKU6ZNABPFOTiNqFmJAUU3CYuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGNI0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:26:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34340 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgGNI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:26:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so20267435wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ns93S8sUjsOmoco+YZg5on386bafVCD/6UpJdLKezho=;
        b=DahvqD6Y2kTxEunBO86QXAzB4wQVX1++pOMC/udDei5zwIetb4g9Bu7PPepDSSLecC
         MgjoZeB/T/TKZ3ie2Ts79/fit6NXsxVhozITM5eWpgbpEwGhRbcvqveH0bK1w3dyHyUy
         5RMAvFA//C/qTKAeCpbe5YLV1Mkh0VoadmgZPnhFXv7GYzd1iKA9ZXspSE6G1mM2VKPh
         H/TSq5vPFPmbYhlXcYgoA+O9VEXzNekASN2EbFc+fFCPd1AyzP/17ODhdyGCqLXs7DjO
         d1hFB4zcIDB/3o9bQOxAlHQgcmOyjZMVr2GJ0TB8Me6BVoqb3uqqGf4bXjhk6dsx7sZV
         NzMA==
X-Gm-Message-State: AOAM532S+sHdns/9uCmrgyrqLVm9tuH78WXvqxsmYqzPmU+Rx7PuKGf4
        rIljN2byRjsLLqaWq6kaix8=
X-Google-Smtp-Source: ABdhPJzNwoAmwTV4+wU4QSXAwmcZVDLWLo0xPsnDiu9lYtYjzRw7BLIt7QcH23Kx1jL0n9IEwHuung==
X-Received: by 2002:adf:f608:: with SMTP id t8mr3911676wrp.308.1594715191723;
        Tue, 14 Jul 2020 01:26:31 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id p29sm3326592wmi.43.2020.07.14.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:26:30 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:26:29 +0200
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
Message-ID: <20200714082629.GF24642@dhcp22.suse.cz>
References: <0000000000000b5f9d059aa2037f@google.com>
 <20200714033252.8748-1-hdanton@sina.com>
 <20200714053205.15240-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714053205.15240-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-07-20 13:32:05, Hillf Danton wrote:
> 
> On Mon, 13 Jul 2020 20:41:11 -0700 Eric Biggers wrote:
> > On Tue, Jul 14, 2020 at 11:32:52AM +0800, Hillf Danton wrote:
> > > 
> > > Add FALLOC_FL_NOBLOCK and on the shmem side try to lock inode upon the
> > > new flag. And the overall upside is to keep the current gfp either in
> > > the khugepaged context or not.
> > > 
> > > --- a/include/uapi/linux/falloc.h
> > > +++ b/include/uapi/linux/falloc.h
> > > @@ -77,4 +77,6 @@
> > >   */
> > >  #define FALLOC_FL_UNSHARE_RANGE		0x40
> > >  
> > > +#define FALLOC_FL_NOBLOCK		0x80
> > > +
> > 
> > You can't add a new UAPI flag to fix a kernel-internal problem like this.
> 
> Sounds fair, see below.
> 
> What the report indicates is a missing PF_MEMALLOC_NOFS and it's
> checked on the ashmem side and added as an exception before going
> to filesystem. On shmem side, no more than a best effort is paid
> on the inteded exception.
> 
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -437,6 +437,7 @@ static unsigned long
>  ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  {
>  	unsigned long freed = 0;
> +	bool nofs;
>  
>  	/* We might recurse into filesystem code, so bail out if necessary */
>  	if (!(sc->gfp_mask & __GFP_FS))
> @@ -445,6 +446,11 @@ ashmem_shrink_scan(struct shrinker *shri
>  	if (!mutex_trylock(&ashmem_mutex))
>  		return -1;
>  
> +	/* enter filesystem with caution: nonblock on locking */
> +	nofs = current->flags & PF_MEMALLOC_NOFS;
> +	if (!nofs)
> +		current->flags |= PF_MEMALLOC_NOFS;
> +
>  	while (!list_empty(&ashmem_lru_list)) {
>  		struct ashmem_range *range =
>  			list_first_entry(&ashmem_lru_list, typeof(*range), lru);

I do not think this is an appropriate fix. First of all is this a real
deadlock or a lockdep false positive? Is it possible that ashmem just
needs to properly annotate its shmem inodes? Or is it possible that
the internal backing shmem file is visible to the userspace so the write
path would be possible?

If this a real problem then the proper fix would be to set internal
shmem mapping's gfp_mask to drop __GFP_FS.
-- 
Michal Hocko
SUSE Labs

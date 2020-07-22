Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A130C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0347420737
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgGVSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:48:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47464 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGVSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:48:47 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jyJnI-0003lc-N5
        for linux-kernel@vger.kernel.org; Wed, 22 Jul 2020 18:48:44 +0000
Received: by mail-wm1-f69.google.com with SMTP id x8so840925wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fj5tDWbuTCkQYGvkoKjLGsFFqP8S1vhifunocsfi/nc=;
        b=Ox/qmvrNnQukwiYQRjKfFc58Sn1JzdCs+NGuQd8P9q9+Pz1K0lxMROUuAkUS0M1qUK
         E3ENbuBfrWBL7DO0tLs5UCwM2+X552sDukTQsWvRdB2wzFpNQ8YiN0H0d68LXrcvl9EN
         BS1LqA79Y8i0a1NYqFmah0vXrV2vDij3dyWvuJvZdhbqc8Zwuwxiq8g29vdkvfUEGX/s
         s1wLoQWr99ly2S6R6rwNKxsYjbEnWY+DKiAUzR2uNDLWrbl65+olzz9JUDgMU5SbE0o7
         xg+Hyjk9Yb/FagWpxikw4DuqUADVmgYjJAvbK+SKjZQAv2qf6T11jzIxMSPQ9Z5uUdqr
         65uQ==
X-Gm-Message-State: AOAM533IaDz8m56T5IFkR65m4MiO7oLFiQf1lkYwlCJCMxMKRrgyOV2s
        qpZ+Ygb4rSrcFRYjiLBeCef5lKH9QSw0neWBUk+M+2Zl7Mal352r12g2qBK4X+VHWw+JS9ny29e
        EN737YKLGAihrpc/47bd9mVka3xIIN+d/N7zcIliLpg==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr833271wru.374.1595443723932;
        Wed, 22 Jul 2020 11:48:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzytXJUXfcX9B33Jr71K2LtPXENOHJpSoG9eDG9+VXh+mjmyECJNZvvX84HgMJ04WXaI5eorg==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr833244wru.374.1595443723488;
        Wed, 22 Jul 2020 11:48:43 -0700 (PDT)
Received: from localhost (host-87-11-131-192.retail.telecomitalia.it. [87.11.131.192])
        by smtp.gmail.com with ESMTPSA id z63sm725561wmb.2.2020.07.22.11.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:48:42 -0700 (PDT)
Date:   Wed, 22 Jul 2020 20:48:41 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: do not wait for lock_page() in
 unuse_pte_range()
Message-ID: <20200722184841.GC841369@xps-13>
References: <20200722174436.GB841369@xps-13>
 <20200722180425.GP15516@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722180425.GP15516@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:04:25PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 22, 2020 at 07:44:36PM +0200, Andrea Righi wrote:
> > Waiting for lock_page() with mm->mmap_sem held in unuse_pte_range() can
> > lead to stalls while running swapoff (i.e., not being able to ssh into
> > the system, inability to execute simple commands like 'ps', etc.).
> > 
> > Replace lock_page() with trylock_page() and release mm->mmap_sem if we
> > fail to lock it, giving other tasks a chance to continue and prevent
> > the stall.
> 
> I think you've removed the warning at the expense of turning a stall
> into a potential livelock.
> 
> > @@ -1977,7 +1977,11 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >  			return -ENOMEM;
> >  		}
> >  
> > -		lock_page(page);
> > +		if (!trylock_page(page)) {
> > +			ret = -EAGAIN;
> > +			put_page(page);
> > +			goto out;
> > +		}
> 
> If you look at the patterns we have elsewhere in the MM for doing
> this kind of thing (eg truncate_inode_pages_range()), we iterate over the
> entire range, take care of the easy cases, then go back and deal with the
> hard cases later.
> 
> So that would argue for skipping any page that we can't trylock, but
> continue over at least the VMA, and quite possibly the entire MM until
> we're convinced that we have unused all of the required pages.
> 
> Another thing we could do is drop the MM semaphore _here_, sleep on this
> page until it's unlocked, then go around again.
> 
> 		if (!trylock_page(page)) {
> 			mmap_read_unlock(mm);
> 			lock_page(page);
> 			unlock_page(page);
> 			put_page(page);
> 			ret = -EAGAIN;
> 			goto out;
> 		}
> 
> (I haven't checked the call paths; maybe you can't do this because
> sometimes it's called with the mmap sem held for write)
> 
> Also, if we're trying to scale this better, there are some fun
> workloads where readers block writers who block subsequent readers
> and we shouldn't wait for I/O in swapin_readahead().  See patches like
> 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11 for more on this kind of thing.

Thanks for the review, Matthew. I'll see if I can find a better solution
following your useful hints!

-Andrea

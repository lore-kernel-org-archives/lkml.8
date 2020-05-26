Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D961C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1A8206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dPcQ0kHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgEZAhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 20:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEZAhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:37:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DAC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:37:07 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so5062374qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwgaUx15qArI/MvJblguGmz8NQaGNj+dkUzd6smjvaE=;
        b=dPcQ0kHjf2hdPwq2BsUfEuKw69ALOb6pHArNeYZBumyBmOD0PBhpj2Dec/kYXjecC3
         kls6wEEEEcHq4KT4xqDC21Mg/QuaC4zPOC38q26+jyQ7cr5FLwbpvNeHTV4Jc/pyzMAg
         ogxailW4cGFQhzqdGYC0G3DUpMehQpwCO97g6EF9/qlipus/DAhZta3/nb3NLhvSxedR
         aXtNwZ0JpC/zYvpT75g0HKKF/Gt2dt275USNgnyjeGimTylHLsdXDBHj7AEgbJ0//wvF
         dh1++zhTqXq78l50fPIATFtqneL27dCb1vBstaGfq3GbIYjeXhv6ZJ4p5WdycuMjtkyS
         RtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwgaUx15qArI/MvJblguGmz8NQaGNj+dkUzd6smjvaE=;
        b=YWu+KfMscFXmwQCF8g+I2EltZKqKFifSb0AzZj9qCggguwhDnzl6wR7tX9Nk+TIaDw
         lKTn/ZQypGb6aK9XHH/64ud1jG6VN0XqudbJpn1+GG56yT6itNS8KRPf6k2suXJF5VAn
         Ag6GeGz0iCYg/jtZNo3/1f4/eTBrAzgPAZ/m3kVTuOK3nheXgHKdtgD2H2S+x2FRgWxe
         iRL13uYU59/T/Jrak3Bc5JmmgL4NcRcUVjPkx4dRPFEJ+LfP1IyREhb/X3Lha/mvSduj
         TJpJdk7R7XDh65Sc+qiiPSG9IMyZqy+V9lkgRYjXRKQq+LcCrVt7xmrfMy3m2lY3HMwh
         RkIA==
X-Gm-Message-State: AOAM531ahXekKNDKoZP+iQ5pc4BSKaCgvwFIuMRwlfm9T++pjpzSpwyW
        66qJG2SU1Ub4WA5006ZkdShhdg==
X-Google-Smtp-Source: ABdhPJzZuO/zBh+TE7X4LbXJFlevNQJKppelZTU3o1ik5aByj0nBUFpLD08/RKg9XexiqQjYHROy1Q==
X-Received: by 2002:ac8:27cb:: with SMTP id x11mr31816848qtx.272.1590453426999;
        Mon, 25 May 2020 17:37:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a27sm1016832qtc.92.2020.05.25.17.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 17:37:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdNab-00024B-U4; Mon, 25 May 2020 21:37:05 -0300
Date:   Mon, 25 May 2020 21:37:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, cai@lca.pw,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200526003705.GK744@ziepe.ca>
References: <159017506369.18853.17306023099999811263.stgit@gimli.home>
 <20200523193417.GI766834@xz-x1>
 <20200523170602.5eb09a66@x1.home>
 <20200523235257.GC939059@xz-x1>
 <20200525122607.GC744@ziepe.ca>
 <20200525142806.GC1058657@xz-x1>
 <20200525144651.GE744@ziepe.ca>
 <20200525151142.GE1058657@xz-x1>
 <20200525165637.GG744@ziepe.ca>
 <3d9c1c8b-5278-1c4d-0e9c-e6f8fdb75853@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d9c1c8b-5278-1c4d-0e9c-e6f8fdb75853@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 01:56:28PM -0700, John Hubbard wrote:
> On 2020-05-25 09:56, Jason Gunthorpe wrote:
> > On Mon, May 25, 2020 at 11:11:42AM -0400, Peter Xu wrote:
> > > On Mon, May 25, 2020 at 11:46:51AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 25, 2020 at 10:28:06AM -0400, Peter Xu wrote:
> > > > > On Mon, May 25, 2020 at 09:26:07AM -0300, Jason Gunthorpe wrote:
> > > > > > On Sat, May 23, 2020 at 07:52:57PM -0400, Peter Xu wrote:
> > > > > > 
> > > > > > > For what I understand now, IMHO we should still need all those handlings of
> > > > > > > FAULT_FLAG_RETRY_NOWAIT like in the initial version.  E.g., IIUC KVM gup will
> > > > > > > try with FOLL_NOWAIT when async is allowed, before the complete slow path.  I'm
> > > > > > > not sure what would be the side effect of that if fault() blocked it.  E.g.,
> > > > > > > the caller could be in an atomic context.
> > > > > > 
> > > > > > AFAICT FAULT_FLAG_RETRY_NOWAIT only impacts what happens when
> > > > > > VM_FAULT_RETRY is returned, which this doesn't do?
> > > > > 
> > > > > Yes, that's why I think we should still properly return VM_FAULT_RETRY if
> > > > > needed..  because IMHO it is still possible that the caller calls with
> > > > > FAULT_FLAG_RETRY_NOWAIT.
> > > > > 
> > > > > My understanding is that FAULT_FLAG_RETRY_NOWAIT majorly means:
> > > > > 
> > > > >    - We cannot release the mmap_sem, and,
> > > > >    - We cannot sleep
> > > > 
> > > > Sleeping looks fine, look at any FS implementation of fault, say,
> > > > xfs. The first thing it does is xfs_ilock() which does down_write().
> > > 
> > > Yeah.  My wild guess is that maybe fs code will always be without
> > > FAULT_FLAG_RETRY_NOWAIT so it's safe to sleep unconditionally (e.g., I think
> > > the general #PF should be fine to sleep in fault(); gup should be special, but
> > > I didn't observe any gup code called upon file systems)?
> > 
> > get_user_pages is called on filesystem backed pages.
> > 
> > I have no idea what FAULT_FLAG_RETRY_NOWAIT is supposed to do. Maybe
> > John was able to guess when he reworked that stuff?
> > 
> 
> Although I didn't end up touching that particular area, I'm sure it's going
> to come up sometime soon, so I poked around just now, and found that
> FAULT_FLAG_RETRY_NOWAIT was added almost exactly 9 years ago. This flag was
> intended to make KVM and similar things behave better when doing GUP on
> file-backed pages that might, or might not be in memory.
> 
> The idea is described in the changelog, but not in the code comments or
> Documentation, sigh:
> 
> commit 318b275fbca1ab9ec0862de71420e0e92c3d1aa7
> Author: Gleb Natapov <gleb@redhat.com>
> Date:   Tue Mar 22 16:30:51 2011 -0700
> 
>     mm: allow GUP to fail instead of waiting on a page
> 
>     GUP user may want to try to acquire a reference to a page if it is already
>     in memory, but not if IO, to bring it in, is needed.  For example KVM may
>     tell vcpu to schedule another guest process if current one is trying to
>     access swapped out page.  Meanwhile, the page will be swapped in and the
>     guest process, that depends on it, will be able to run again.
> 
>     This patch adds FAULT_FLAG_RETRY_NOWAIT (suggested by Linus) and
>     FOLL_NOWAIT follow_page flags.  FAULT_FLAG_RETRY_NOWAIT, when used in
>     conjunction with VM_FAULT_ALLOW_RETRY, indicates to handle_mm_fault that
>     it shouldn't drop mmap_sem and wait on a page, but return VM_FAULT_RETRY
>     instead.

So, from kvm's perspective it was to avoid excessively long blocking in
common paths when it could rejoin the completed IO by somehow waiting
on a page itself?

It all seems like it should not be used unless the page is going to go
to IO?

Certainly there is no reason to optimize the fringe case of vfio
sleeping if there is and incorrect concurrnent attempt to disable the
a BAR.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8429d5aa31e44..e32e8e52a57ac 100644
> +++ b/include/linux/mm.h
> @@ -430,6 +430,15 @@ extern pgprot_t protection_map[16];
>   * continuous faults with flags (b).  We should always try to detect pending
>   * signals before a retry to make sure the continuous page faults can still be
>   * interrupted if necessary.
> + *
> + * About @FAULT_FLAG_RETRY_NOWAIT: this is intended for callers who would like
> + * to acquire a page, but only if the page is already in memory. If, on the
> + * other hand, the page requires IO in order to bring it into memory, then fault
> + * handlers will immediately return VM_FAULT_RETRY ("don't wait"), while leaving
> + * mmap_lock held ("don't drop mmap_lock"). For example, this is useful for
> + * virtual machines that have multiple guests running: if guest A attempts
> + * get_user_pages() on a swapped out page, another guest can be scheduled while
> + * waiting for IO to swap in guest A's page.
>   */
>  #define FAULT_FLAG_WRITE                       0x01
>  #define FAULT_FLAG_MKWRITE                     0x02

It seems reasonable but people might complain about the kvm
specifics of the explanation.

It might be better to explain how the caller is supposed to know when
it is OK to try GUP again and expect success, as it seems to me this
is really about externalizing the sleep for page wait?

Jason

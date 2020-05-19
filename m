Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B7B207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589867390;
	bh=FF7KN1OdpHlPUxJsyYLo5KCQclzjlL5l32hhGgYBOlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qOkJkS8h5Bc6as8wmSJsTkB0M711Uxc9YpwLIsfRSyyBpdmOCHhXiQWvGr4UhWQVv
	 OZLMnmhTntnzNY/FvvpoXuQKYo3pAhwl+03EW9TgCDUg9BG1ZJe/fd+RGI/wYGpr5F
	 SMcfN6pGNbGO01e3yjFGGX8sXw3ANsHBzKgiapw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgESFtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgESFtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:49:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F1812075F;
        Tue, 19 May 2020 05:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589867381;
        bh=FF7KN1OdpHlPUxJsyYLo5KCQclzjlL5l32hhGgYBOlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S184YSdBWMtOHDP29aI0nL6+Vz3uTarBr2r1hGAy4LD18h8TV71WlB0e/skLmU2md
         zfFN1D56nZtPSLakefrU45pdOvcRca4fJyPaLnRlfgtxCPnYquwQN8BmMQBg78LXUW
         b9hVs9YtmDz/ZdglI+V4fD2PW0FbBbnYFbIhR2so=
Date:   Tue, 19 May 2020 07:49:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com,
        syzbot+40b71e145e73f78f81ad@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 02/80] shmem: fix possible deadlocks on
 shmlock_user_lock
Message-ID: <20200519054939.GB3826326@kroah.com>
References: <20200518173450.097837707@linuxfoundation.org>
 <20200518173450.633393924@linuxfoundation.org>
 <20200518211330.GA25576@amd>
 <alpine.LSU.2.11.2005181714490.1094@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005181714490.1094@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 06:10:58PM -0700, Hugh Dickins wrote:
> Hi Pavel,
> 
> On Mon, 18 May 2020, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > This may not risk an actual deadlock, since shmem inodes do not take
> > > part in writeback accounting, but there are several easy ways to avoid
> > > it.
> > 
> > ...
> > 
> > > Take info->lock out of the chain and the possibility of deadlock or
> > > lockdep warning goes away.
> > 
> > It is unclear to me if actual possibility of deadlock exists or not,
> > but anyway:
> > 
> > >  	int retval = -ENOMEM;
> > >  
> > > -	spin_lock_irq(&info->lock);
> > > +	/*
> > > +	 * What serializes the accesses to info->flags?
> > > +	 * ipc_lock_object() when called from shmctl_do_lock(),
> > > +	 * no serialization needed when called from shm_destroy().
> > > +	 */
> > >  	if (lock && !(info->flags & VM_LOCKED)) {
> > >  		if (!user_shm_lock(inode->i_size, user))
> > >  			goto out_nomem;
> > 
> > Should we have READ_ONCE() here? If it is okay, are concurency
> > sanitizers smart enough to realize that it is okay? Replacing warning
> > with different one would not be exactly a win...
> 
> If a sanitizer comes to question this change, I don't see how a
> READ_ONCE() anywhere near here (on info->flags?) is likely to be
> enough to satisfy it - it would be asking for a locking scheme that
> it understands (being unable to read the comment) - and might then
> ask for that same locking in the numerous other places that read
> info->flags (and a few that write it).  Add data_race()s all over?
> 
> (Or are you concerned about that inode->i_size, which I suppose ought
> really to be i_size_read(inode) on some 32-bit configurations; though
> that's of very long standing, and has never caused any concern before.)
> 
> I am not at all willing to add annotations speculatively, in case this
> or that tool turns out to want help later.  So far I've not heard of
> any such complaint on 5.7-rc[3456] or linux-next: but maybe this is
> too soon to hear a complaint, and you feel this should not be rushed
> into -stable?
> 
> This was an AUTOSEL selection, to which I have no objection, but it
> isn't something we were desperate to push into -stable: so I've also
> no objection if Greg shares your concern, and prefers to withdraw it.
> (That choice may depend on to what extent he expects to be keeping
> -stable clean against upcoming sanitizers in future.)

Sanitizers run on stable trees all the time as that's the releases that
ends up on products, where people run them.  That's why I like to take
those types of fixes, especially when tools report them.

thanks,

greg k-h

Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72361C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5317020674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7GUHS8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgESBLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgESBLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:11:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E546C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:11:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d7so3470352ote.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vtRQphori25nZNykvWtUsb0UD5P41Yom5iiboVDediw=;
        b=V7GUHS8N1wCx4VHIznqnTvtPlzy/KoOnOE5y1Uhoarnny6fF2yD0sl+JoOs64u7IEe
         BmUmsFnoAcv1vrkvfAXTQ7VczcpayTNfrgdW+eIB+lk8WLpNAZMO/COw88OPbiNdZPdE
         gFH08S2HRh2r441kAeXfwSin8mJjg4eKnaHPigIy8g6Lp10APrWeypuVZQjhnieEas8c
         WVphBNW11irsaS9MyHFZGK0FNFcznyhckA2kZgZtF1h6/sY2TawEryCWBjMLQHPCE02B
         SOo2+kf9PKqASfaV937w9hhyNqZWz7atagpTA9LTg5yFAE8I/p9nXAb2wEqIA+L5xxqd
         kvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vtRQphori25nZNykvWtUsb0UD5P41Yom5iiboVDediw=;
        b=h84YI2RD5oM7ZeBVl5Q+F+lBDfzS+PBR6L5uDwEBUotn1tB6Lqmfp3KcNlPFi0oQPk
         +g0iLLsmWefVX2dUmqBQ8hLhYASZhquPqLRlrTJ7VihV4zOVzYFHyoBaysKCtoG2dzCu
         DKJ3RHD2H/oeRev8XulM4TdgebiUZ98s98W4Axs1KBuy9fDVjSxtQCUJYxs2EI92TWKQ
         Lo3FKafCXsty98xvRUBC/TVmr+rdnS5x5CCVWgLDQtXzxCfBhqFlaADZPmIcz6q1AtI5
         JUDXiv8xmUQtUIadpUtCapPj8IukL5DWkwUGBcW9jElWqA/wKj9gBSsdCIw+n8pweQQp
         NzsQ==
X-Gm-Message-State: AOAM530hUVRu0YlJBPlzkukjcYEdAYMeIksIpgoIRZblBvvlWkXzRied
        1bbDk2KQf9cGkpp9xPz2Tox5bw==
X-Google-Smtp-Source: ABdhPJysULqJq6VgZ+ul1yYNecyK64vPeSVnqVxSGgWCe/tmHBkjJMOEm9IK6LeEKuSvj4/ll6T5KA==
X-Received: by 2002:a05:6830:20ce:: with SMTP id z14mr9159756otq.209.1589850675133;
        Mon, 18 May 2020 18:11:15 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j23sm3403116otl.64.2020.05.18.18.11.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 18 May 2020 18:11:13 -0700 (PDT)
Date:   Mon, 18 May 2020 18:10:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Pavel Machek <pavel@denx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com,
        syzbot+40b71e145e73f78f81ad@syzkaller.appspotmail.com,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 02/80] shmem: fix possible deadlocks on
 shmlock_user_lock
In-Reply-To: <20200518211330.GA25576@amd>
Message-ID: <alpine.LSU.2.11.2005181714490.1094@eggly.anvils>
References: <20200518173450.097837707@linuxfoundation.org> <20200518173450.633393924@linuxfoundation.org> <20200518211330.GA25576@amd>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, 18 May 2020, Pavel Machek wrote:

> Hi!
> 
> > This may not risk an actual deadlock, since shmem inodes do not take
> > part in writeback accounting, but there are several easy ways to avoid
> > it.
> 
> ...
> 
> > Take info->lock out of the chain and the possibility of deadlock or
> > lockdep warning goes away.
> 
> It is unclear to me if actual possibility of deadlock exists or not,
> but anyway:
> 
> >  	int retval = -ENOMEM;
> >  
> > -	spin_lock_irq(&info->lock);
> > +	/*
> > +	 * What serializes the accesses to info->flags?
> > +	 * ipc_lock_object() when called from shmctl_do_lock(),
> > +	 * no serialization needed when called from shm_destroy().
> > +	 */
> >  	if (lock && !(info->flags & VM_LOCKED)) {
> >  		if (!user_shm_lock(inode->i_size, user))
> >  			goto out_nomem;
> 
> Should we have READ_ONCE() here? If it is okay, are concurency
> sanitizers smart enough to realize that it is okay? Replacing warning
> with different one would not be exactly a win...

If a sanitizer comes to question this change, I don't see how a
READ_ONCE() anywhere near here (on info->flags?) is likely to be
enough to satisfy it - it would be asking for a locking scheme that
it understands (being unable to read the comment) - and might then
ask for that same locking in the numerous other places that read
info->flags (and a few that write it).  Add data_race()s all over?

(Or are you concerned about that inode->i_size, which I suppose ought
really to be i_size_read(inode) on some 32-bit configurations; though
that's of very long standing, and has never caused any concern before.)

I am not at all willing to add annotations speculatively, in case this
or that tool turns out to want help later.  So far I've not heard of
any such complaint on 5.7-rc[3456] or linux-next: but maybe this is
too soon to hear a complaint, and you feel this should not be rushed
into -stable?

This was an AUTOSEL selection, to which I have no objection, but it
isn't something we were desperate to push into -stable: so I've also
no objection if Greg shares your concern, and prefers to withdraw it.
(That choice may depend on to what extent he expects to be keeping
-stable clean against upcoming sanitizers in future.)

Hugh

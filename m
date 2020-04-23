Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E778C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF3E20787
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgDWKsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:48:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:36930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDWKs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82A42AC84;
        Thu, 23 Apr 2020 10:48:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E4CB1E1293; Thu, 23 Apr 2020 12:48:27 +0200 (CEST)
Date:   Thu, 23 Apr 2020 12:48:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in
 fsnotify
Message-ID: <20200423104827.GD3737@quack2.suse.cz>
References: <20200423044050.162093-1-joel@joelfernandes.org>
 <20200423044518.GA162422@google.com>
 <CAOQ4uxgifK_XTkJO69-hQvR4xQGPgHNGKJPv6-MNgHcQat5UBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgifK_XTkJO69-hQvR4xQGPgHNGKJPv6-MNgHcQat5UBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-04-20 08:24:23, Amir Goldstein wrote:
> On Thu, Apr 23, 2020 at 7:45 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> > > While reading the famous slab paper [1], I noticed that the conn->lock
> > > spinlock and conn->list hlist in fsnotify code is being initialized
> > > during every object allocation. This seems a good fit for the
> > > constructor within the slab to take advantage of the slab design. Move
> > > the initializtion to that.
> > >
> > >        spin_lock_init(&conn->lock);
> > >        INIT_HLIST_HEAD(&conn->list);
> > >
> > > [1] https://pdfs.semanticscholar.org/1acc/3a14da69dd240f2fbc11d00e09610263bdbd.pdf
> > >
> >
> > The commit message could be better. Just to clarify, doing it this way is
> > more efficient because the object will only have its spinlock init and hlist
> > init happen during object construction, not object allocation.
> >
> 
> This change may be correct, but completely unjustified IMO.
> conn objects are very rarely allocated, from user syscall path only.
> I see no reason to micro optimize this.
> 
> Perhaps there is another justification to do this, but not efficiency.

Thanks for the suggestion Joel but I agree with Amir here. In principle
using constructor is correct however it puts initialization of object in
two places which makes the code harder to follow and the allocation of
connector does not happen frequently enough for optimizing out these two
stores to matter in any tangible way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

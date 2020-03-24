Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E15FC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D11F20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585037235;
	bh=f8cT9sVNNjuDD13bqAKIx8zkKrrCSqGk4wXhPLqd06A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mc/V1uxhY1rpPKhqKI31lPn51pQXZlsqYmTGOcLJvIwU4syq8qGMlUzYRbhXlGExT
	 Irbs7n9+UFvkRjKzwFzBrJNw1CK43aJft796r2wnc35s0U9orRDZddTxzB6SVW0tpr
	 qjxILSMkPKF9AhP70mr1FpnVjRs/asWJsoHX5DpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCXIHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgCXIHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:07:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DD02080C;
        Tue, 24 Mar 2020 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585037231;
        bh=f8cT9sVNNjuDD13bqAKIx8zkKrrCSqGk4wXhPLqd06A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpSU/mZC0wXo/ef1oShGUKm46qphvClM+NpopQTyyrz+3CeZHh7zgv7NXEWW17BZO
         ngqF+9OVsfJp/XyEXm5x2O+/KvfMFwQvBMcHzmS5ABf2FL8BYPjJFqp1ZNOiFDNcFR
         9iEfXcSWy83PCJ+FmPMhORLwNjsMSxj7Y7sLFZOc=
Date:   Tue, 24 Mar 2020 09:06:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 30/73] futex: Fix inode life-time issue
Message-ID: <20200324080633.GA2016351@kroah.com>
References: <20200318205337.16279-1-sashal@kernel.org>
 <20200318205337.16279-30-sashal@kernel.org>
 <CAG48ez1pzF76DpPWoAwDkXLJ01w8Swe=obBrNoBWr=iGTbH7-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1pzF76DpPWoAwDkXLJ01w8Swe=obBrNoBWr=iGTbH7-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:18:04PM +0100, Jann Horn wrote:
> On Wed, Mar 18, 2020 at 9:54 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > [ Upstream commit 8019ad13ef7f64be44d4f892af9c840179009254 ]
> >
> > As reported by Jann, ihold() does not in fact guarantee inode
> > persistence. And instead of making it so, replace the usage of inode
> > pointers with a per boot, machine wide, unique inode identifier.
> >
> > This sequence number is global, but shared (file backed) futexes are
> > rare enough that this should not become a performance issue.
> 
> Please also take this patch, together with
> 8d67743653dce5a0e7aa500fcccb237cde7ad88e "futex: Unbreak futex
> hashing", into the older stable branches. This has to go all the way
> back; as far as I can tell, the bug already existed at the beginning
> of git history.

I have queued these up now, thanks for the hint.

greg k-h

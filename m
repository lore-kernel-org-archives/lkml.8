Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A11C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DD1207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgGVQxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgGVQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:53:51 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE0B206F5;
        Wed, 22 Jul 2020 16:53:49 +0000 (UTC)
Date:   Wed, 22 Jul 2020 17:53:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] raw_copy_from_user() semantics
Message-ID: <20200722165346.GB4069@gaia>
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
 <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
 <20200722113707.GC27540@gaia>
 <8fde1b9044a34ff59eb5ff3dafbf2b97@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fde1b9044a34ff59eb5ff3dafbf2b97@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:14:21PM +0000, David Laight wrote:
> From: Catalin Marinas
> > Sent: 22 July 2020 12:37
> > On Sun, Jul 19, 2020 at 12:34:11PM -0700, Linus Torvalds wrote:
> > > On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > > I think we should try to get rid of the exact semantics.
> > >
> > > Side note: I think one of the historical reasons for the exact
> > > semantics was that we used to do things like the mount option copying
> > > with a "copy_from_user()" iirc.
> > >
> > > And that could take a fault at the end of the stack etc, because
> > > "copy_mount_options()" is nasty and doesn't get a size, and just
> > > copies "up to 4kB" of data.
> > >
> > > It's a mistake in the interface, but it is what it is. But we've
> > > always handled the inexact count there anyway by originally doing byte
> > > accesses, and at some point you optimized it to just look at where
> > > page boundaries might be..
> > 
> > And we may have to change this again since, with arm64 MTE, the page
> > boundary check is insufficient:
> > 
> > https://lore.kernel.org/linux-fsdevel/20200715170844.30064-25-catalin.marinas@arm.com/
> > 
> > While currently the fault path is unlikely to trigger, with MTE in user
> > space it's a lot more likely since the buffer (e.g. a string) is
> > normally less than 4K and the adjacent addresses would have a different
> > colour.
> > 
> > I looked (though briefly) into passing the copy_from_user() problem to
> > filesystems that would presumably know better how much to copy. In most
> > cases the options are string, so something like strncpy_from_user()
> > would work. For mount options as binary blobs (IIUC btrfs) maybe the fs
> > has a better way to figure out how much to copy.
> 
> What about changing the mount code to loop calling get_user()
> to read aligned words until failure?
> Mount is fairly uncommon and the extra cost is probably small compared
> to the rest of doing a mount.

Before commit 12efec560274 ("saner copy_mount_options()"), it was using
single-byte get_user(). That could have been optimised for aligned words
reading but I don't really think it's worth the hassle. Since the source
and destination don't have the same alignment and some architecture
don't support unaligned accesses (for storing to the kernel buffer), it
would just make this function unnecessarily complicated.

-- 
Catalin

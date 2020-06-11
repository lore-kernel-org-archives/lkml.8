Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C036C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333812078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591833642;
	bh=5sGHU0TXkJgqIou25g8bOOckwAZ4up5Cw9usUbqqcE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nPmjr9n8U9VStvo8ZkcoBx4tay+8/qjMxPV9tNlJrh/sIftOkqY+pDILmhN/GmVIf
	 +QgVLC1ngJE7rvLdzbtkvdaQsbG9x9OeR/zkf4NQopnQ7LJ4XmdbK7D3X5uRChPlWC
	 O+Fjt+0tTkEBmSs8YQV858WAcgGKg2CRjUmC7AV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFKAAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgFKAAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:00:39 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F5C20747;
        Thu, 11 Jun 2020 00:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591833638;
        bh=5sGHU0TXkJgqIou25g8bOOckwAZ4up5Cw9usUbqqcE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YL76uirKlAFVeJnBYKcm15iNePJ5NPoXXfgvDSo41XH9Qgq87gpdK0QlQeib2YKyM
         UUGnZeY7N7fl6hixkdG98ddnzmSNL2RngUOgq3Sz7hZSAWjy12Yz+n+mvU/0JyLqLG
         Q1iWCUgphwz4qbEDSQ+sqzaH3BtQKmmc34jSryIg=
Date:   Wed, 10 Jun 2020 17:00:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200611000037.GC1339@sol.localdomain>
References: <20200609060137.143501-1-daeho43@gmail.com>
 <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain>
 <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
 <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
 <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 08:53:10AM +0900, Daeho Jeong wrote:
> > > > > Using FMODE_WRITE is more proper for this case, since we're going to
> > > > > modify the data. But I think mnt_want_write_file() is still required
> > > > > to prevent the filesystem from freezing or something else.
> > > >
> > > > Right, the freezing check is actually still necessary.  But getting write access
> > > > to the mount is not necessary.  I think you should use file_start_write() and
> > > > file_end_write(), like vfs_write() does.
> >
> > I've checked this again.
> >
> > But I think mnt_want_write_file() looks better than the combination of
> > checking FMODE_WRITE and file_start_write(), because
> > mnt_want_write_file() handles all the things we need.
> > It checks FMODE_WRITER, which is set in do_dentry_open() when
> > FMODE_WRITE is already set, and does the stuff that file_start_write()
> > is doing. This is why the other filesystem system calls use it.
> >
> > What do you think?
> 
> Hmm, we still need FMODE_WRITE check.
> But mnt_want_write_file() looks better, because it'll call
> mnt_clone_write() internally, if the file is open for write already.

There's no need to get write access to the mount if you already have a writable
fd.  You just need file_start_write() for the freeze protection.  Again, see
vfs_write().

- Eric

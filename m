Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F5AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457D72080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588792577;
	bh=THl2Lpu9sfzGxpEl85CqvltCNIh7W5yIuzClFt9bv4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PNCY+z2h+uOZ4cjER6sN2AhnDR2+NW5OavXV0r42FTV30pDcgc244NUp8t9QGNjZK
	 gYC4gNECUmR69BhI4dv8UWL4dOSJqYdkQlTnoj7YZBInfVDhe5lSbIzCK0kpNdTITu
	 1x8AVEJfVimrLbJJzBc3wyomIieUzFUC5I65AfCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgEFTQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgEFTQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:16:16 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C9E2075A;
        Wed,  6 May 2020 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588792575;
        bh=THl2Lpu9sfzGxpEl85CqvltCNIh7W5yIuzClFt9bv4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjYUPi2pTno6Scq4ERj8iiHIh0GEoMacr7jaA2J4s/5IsEU1LWt5+o/FCoeLtkmFK
         DxxtXGvfDR1GG96aaJqEqyebWNFBkIFPkxTQQzxoqE1ij9FvnN6vpdfeXvcarR2rp6
         V5nPvdyZqzQ0PF6fqZkn4/A5yvF/qrA1pH9uGbDY=
Date:   Wed, 6 May 2020 12:16:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@gmx.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200506191613.GB842@sol.localdomain>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
 <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200506012428.GG128280@sol.localdomain>
 <20200506015813.GA9256@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200506064709.GA25482@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506064709.GA25482@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:47:19PM +0800, Gao Xiang wrote:
> On Wed, May 06, 2020 at 09:58:22AM +0800, Gao Xiang wrote:
> > On Tue, May 05, 2020 at 06:24:28PM -0700, Eric Biggers wrote:
> > > On Wed, May 06, 2020 at 08:14:07AM +0800, Gao Xiang wrote:
> > > > >
> > > > > Actually, I think this is wrong because the fsync can be done via a file
> > > > > descriptor that was opened to a now-deleted link to the file.
> > > >
> > > > I'm still confused about this...
> > > >
> > > > I don't know what's wrong with this version from my limited knowledge?
> > > >  inode itself is locked when fsyncing, so
> > > >
> > > >    if the fsync inode->i_nlink == 1, this inode has only one hard link
> > > >    (not deleted yet) and should belong to a single directory; and
> > > >
> > > >    the only one parent directory would not go away (not deleted as well)
> > > >    since there are some dirents in it (not empty).
> > > >
> > > > Could kindly explain more so I would learn more about this scenario?
> > > > Thanks a lot!
> > >
> > > i_nlink == 1 just means that there is one non-deleted link.  There can be links
> > > that have since been deleted, and file descriptors can still be open to them.
> >
> > Thanks for your inspiration. You are right, thanks.
> >
> > Correct my words... I didn't check f2fs code just now, it seems f2fs doesn't
> > take inode_lock as some other fs like __generic_file_fsync or ubifs_fsync.
> >
> > And i_sem locks nlink / try_to_fix_pino similarly in some extent. It seems
> > no race by using d_find_alias here. Thanks again.
> >
> 
> (think more little bit just now...)
> 
>  Thread 1:                                           Thread 2 (fsync):
>   vfs_unlink                                          try_to_fix_pino
>     f2fs_unlink
>        f2fs_delete_entry
>          f2fs_drop_nlink  (i_sem, inode->i_nlink = 1)
> 
>   (...   but this dentry still hashed)                  i_sem, check inode->i_nlink = 1
>                                                         i_sem d_find_alias
> 
>   d_delete
> 
> I'm not sure if fsync could still use some wrong alias by chance..
> completely untested, maybe just noise...
> 

Right, good observation.  My patch makes it better, but it's still broken.

I don't know how to fix it.  If we see i_nlink == 1 and multiple hashed
dentries, there doesn't appear to be a way to distingush which one corresponds
to the remaining link on-disk (if any; it may not even be in the dcache), and
which correspond to links that vfs_unlink() has deleted from disk but hasn't yet
done d_delete() on.

One idea would be choose one, then take inode_lock_shared(dir) and do
__f2fs_find_entry() to check if the dentry is really still on-disk.  That's
heavyweight and error-prone though, and the locking could cause problems.

I'm wondering though, does f2fs really need try_to_fix_pino() at all, and did it
ever really work?  It never actually updates the f2fs_inode::i_name to match the
new directory.  So independently of this bug with deleted links, I don't see how
it can possibly work as intended.

- Eric

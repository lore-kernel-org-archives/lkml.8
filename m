Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A4C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463F220735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588728272;
	bh=0MLo2NbZMkoEikI+0ws5DDZ7FousY6/b9nnHo7P+Gjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZfiMSn+OPOLMIzROQsaCRZOy9RIMMAcc8RZEQqJ1P1jOQFtZSDjDM58/CmxplWs2c
	 sMWLJGW5SzYTVswhq0ArXKjvTsquaOiZO8r5ZTY7JN4BEkDW1MbJvm0SCED4tz3QjB
	 xIQdD4/QZys0kyiTsYshsNkcgoR6iP+qAUADezNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEFBYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 21:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbgEFBYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:24:31 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C3320721;
        Wed,  6 May 2020 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588728270;
        bh=0MLo2NbZMkoEikI+0ws5DDZ7FousY6/b9nnHo7P+Gjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXVf6TQ1Sti0iAG5VHBet6ALroDk6gYzIaC5JV+smROfEfJggD6fgeg19XW+7O8/2
         bYWn7fbiDYwRISi5X8fDqEQVdH9Z1kdp2hU8Dh38/TYjeZjSAUC6kkug7gkha0bjeZ
         VQJDeO6Ztfl/XIAlww3YDrgnB3H7htuULoFp3GfM=
Date:   Tue, 5 May 2020 18:24:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@gmx.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200506012428.GG128280@sol.localdomain>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
 <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 08:14:07AM +0800, Gao Xiang wrote:
> >
> > Actually, I think this is wrong because the fsync can be done via a file
> > descriptor that was opened to a now-deleted link to the file.
> 
> I'm still confused about this...
> 
> I don't know what's wrong with this version from my limited knowledge?
>  inode itself is locked when fsyncing, so
> 
>    if the fsync inode->i_nlink == 1, this inode has only one hard link
>    (not deleted yet) and should belong to a single directory; and
> 
>    the only one parent directory would not go away (not deleted as well)
>    since there are some dirents in it (not empty).
> 
> Could kindly explain more so I would learn more about this scenario?
> Thanks a lot!

i_nlink == 1 just means that there is one non-deleted link.  There can be links
that have since been deleted, and file descriptors can still be open to them.

> 
> >
> > We need to find the dentry whose parent directory is still exists, i.e. the
> > parent directory that is counting towards 'inode->i_nlink == 1'.
> 
> directory counting towards 'inode->i_nlink == 1', what's happening?

The non-deleted link is the one counted in i_nlink.

> 
> >
> > I think d_find_alias() is what we're looking for.
> 
> It may be simply dentry->d_parent (stable/positive as you said before, and it's
> not empty). why need to d_find_alias()?

Because we need to get the dentry that hasn't been deleted yet, which isn't
necessarily the one associated with the file descriptor being fsync()'ed.

> And what is the original problem? I could not get some clue from the original
> patch description (I only saw some extra igrab/iput because of some unknown
> reasons), it there some backtrace related to the problem?

The problem is that i_pino gets set incorrectly.  I just noticed this while
reviewing the code.  It's not hard to reproduce, e.g.:

#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

int main()
{
        int fd;

        mkdir("dir1", 0700);
        mkdir("dir2", 0700);
        mknod("dir1/file", S_IFREG|0600, 0);
        link("dir1/file", "dir2/file");
        fd = open("dir2/file", O_WRONLY);
        unlink("dir2/file");
        write(fd, "X", 1);
        fsync(fd);
}

Then:

sync
echo N | dump.f2fs -i $(stat -c %i dir1/file) /dev/vdb | grep 'i_pino'
echo "dir1 (correct): $(stat -c %i dir1)"
echo "dir2 (wrong): $(stat -c %i dir2)"

i_pino will point to dir2 rather than dir1 as expected.

- Eric

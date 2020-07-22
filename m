Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20697C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DA52065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595437564;
	bh=OR5cu9ZiOnyEIuGOim8D0YhB42FI73IvAZzLYBaMrAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fAPy8thBtnVK+5JTcg5NY933lAdsds+U3UkUDYaZsz9zxeLdjG24LNBV36ti6+H2J
	 j8RRTeTO8g8NafXlXIuNlxeA0x/F8Jw/n9Ww7IoNzoLAmg+mc/ISsyPSwUqhzafnSC
	 Rv8Y8ykdbEK8mzhgbT0cpHMf/wlOWPwF45UwanF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgGVRGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbgGVRF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:05:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77903207E8;
        Wed, 22 Jul 2020 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595437558;
        bh=OR5cu9ZiOnyEIuGOim8D0YhB42FI73IvAZzLYBaMrAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fo21+ikbWeaUKIlmQNUaTc7OWl1nlaenOWLBZXBwygMsnaX9HuJ9knbDk583vacjj
         YNS64Wb3BIoGLj8a7Y/fgPhNnSc5EFsxGH21pGPqhSDx3BY8knZVbnQw+puTpgdjIy
         f1s8m7QiEWgjc5Abrl8IzGXrbNwOtsHQ0SzVKdFg=
Date:   Wed, 22 Jul 2020 19:06:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 1/2] f2fs: add sysfs symbolic link to kobject with volume
 name
Message-ID: <20200722170602.GA440171@kroah.com>
References: <20200719054409.3050516-1-daeho43@gmail.com>
 <20200719151640.GA301791@kroah.com>
 <20200722164356.GA3912099@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722164356.GA3912099@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:43:56AM -0700, Jaegeuk Kim wrote:
> On 07/19, Greg KH wrote:
> > On Sun, Jul 19, 2020 at 02:44:08PM +0900, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > > 
> > > Added a symbolic link directory pointing to its device name
> > > directory using the volume name of the partition in sysfs.
> > > (i.e., /sys/fs/f2fs/vol_#x -> /sys/fs/f2fs/sda1)
> > 
> > No, please no.
> > 
> > That is already created today for you in /dev/disk/  The kernel does not
> > need to do this again.
> > 
> > If your distro/system/whatever does not provide you with /dev/disk/ and
> > all of the symlinks in there, then work with your distro/system/whatever
> > to do so.
> 
> I don't get the point, since /dev/disk points device node, not any sysfs entry.
> Do you mean we need to create symlink to /sys/fs/f2fs/dm-X in /dev/disk?

Huh, no!  It's all done for you today automagically by userspace:

$ tree /dev/disk/by-label/
/dev/disk/by-label/
├── boot -> ../../sda1
├── fast_disk -> ../../md0
├── root -> ../../sda2
└── stuff -> ../../dm-0

Look on your laptop/desktop/server today for those, there's lots of
symlinks in /dev/disk/

> > Again, no need to do this on a per-filesystem-basis when we already have
> > this around for all filesystems, and have had it for 15+ years now.
> 
> Could you point out where we can get this? And, the label support depends
> on per-filesystem design. I'm not sure how this can be generic enough.

Userspace knows how to read labels on a per-filesystem-basis and does so
just fine.  That's how it creates those symlinks, no kernel support is
needed.

This has been implemented for 15+ years now, it's not a new thing...

Now if your embedded system doesn't support it, that's the userspace of
that system's fault, it's not the kernel's fault at all.  Go fix your
userspace if you want those things.

thanks,

greg k-h

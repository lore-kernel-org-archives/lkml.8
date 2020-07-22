Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E3C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95B20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595445025;
	bh=+t3jY0IpTJCIfsWEdsuY3x3kM796R1C8EohXWaLiw9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AkTSXTzJU3F0muACgGHJeoR1Wrwg1NEMOZJPsUZ7lcNVQdRJyPHaFH+TbniR7wH/+
	 7dSs3BefMQDfkDXP/e342V8zJDjQpEyKzCAwSmlh8K2YJ1UcMpyhmUDMJKjwzVCIHm
	 i278WL/TbFkppaNnIaPjAxYgYXk+i+b+w3xemgyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbgGVTKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbgGVTKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:10:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A34E204EA;
        Wed, 22 Jul 2020 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595445021;
        bh=+t3jY0IpTJCIfsWEdsuY3x3kM796R1C8EohXWaLiw9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebBukWMp5zxK6NJqb9nkijuy9EKOVU5lqYjUPomAlvOI+/ju8xrtyp6vOWZjcZpDT
         c3Qz1bSqDg5ljLRcS6+tBZHWGkz/PHcnaOAakmgFGT0PzLBBNPrFLqsBY6kA45UDdL
         0yg53bLhy0ZvdZ5lnTPO56hUnUzhVcNbGyDroYiA=
Date:   Wed, 22 Jul 2020 21:10:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 1/2] f2fs: add sysfs symbolic link to kobject with volume
 name
Message-ID: <20200722191026.GA583549@kroah.com>
References: <20200719054409.3050516-1-daeho43@gmail.com>
 <20200719151640.GA301791@kroah.com>
 <20200722164356.GA3912099@google.com>
 <20200722170602.GA440171@kroah.com>
 <20200722172437.GH3912099@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722172437.GH3912099@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:24:37AM -0700, Jaegeuk Kim wrote:
> On 07/22, Greg KH wrote:
> > On Wed, Jul 22, 2020 at 09:43:56AM -0700, Jaegeuk Kim wrote:
> > > On 07/19, Greg KH wrote:
> > > > On Sun, Jul 19, 2020 at 02:44:08PM +0900, Daeho Jeong wrote:
> > > > > From: Daeho Jeong <daehojeong@google.com>
> > > > > 
> > > > > Added a symbolic link directory pointing to its device name
> > > > > directory using the volume name of the partition in sysfs.
> > > > > (i.e., /sys/fs/f2fs/vol_#x -> /sys/fs/f2fs/sda1)
> > > > 
> > > > No, please no.
> > > > 
> > > > That is already created today for you in /dev/disk/  The kernel does not
> > > > need to do this again.
> > > > 
> > > > If your distro/system/whatever does not provide you with /dev/disk/ and
> > > > all of the symlinks in there, then work with your distro/system/whatever
> > > > to do so.
> > > 
> > > I don't get the point, since /dev/disk points device node, not any sysfs entry.
> > > Do you mean we need to create symlink to /sys/fs/f2fs/dm-X in /dev/disk?
> > 
> > Huh, no!  It's all done for you today automagically by userspace:
> > 
> > $ tree /dev/disk/by-label/
> > /dev/disk/by-label/
> > ├── boot -> ../../sda1
> > ├── fast_disk -> ../../md0
> > ├── root -> ../../sda2
> > └── stuff -> ../../dm-0
> > 
> > Look on your laptop/desktop/server today for those, there's lots of
> > symlinks in /dev/disk/
> 
> What I mean is "creating symlink from *userspace*", but the concern is
> "/dev/" looks like being used for device nodes only, not sysfs.

That is correct, that is what /dev/ is for, not sysfs.

> > > > Again, no need to do this on a per-filesystem-basis when we already have
> > > > this around for all filesystems, and have had it for 15+ years now.
> > > 
> > > Could you point out where we can get this? And, the label support depends
> > > on per-filesystem design. I'm not sure how this can be generic enough.
> > 
> > Userspace knows how to read labels on a per-filesystem-basis and does so
> > just fine.  That's how it creates those symlinks, no kernel support is
> > needed.
> > 
> > This has been implemented for 15+ years now, it's not a new thing...
> > 
> > Now if your embedded system doesn't support it, that's the userspace of
> > that system's fault, it's not the kernel's fault at all.  Go fix your
> > userspace if you want those things.
> 
> I'm not talking about whose fault tho. :) By any chance, could you please
> suggest a good location to create a symlink for this sysfs entry?

There is no need for such a sysfs entry, that's what I am trying to say.
Userspace already has all of the needed information here, do not try to
add filesystem-specific stuff like this, unless you somehow are going to
do it for all filesystems :)

thanks,

gregt k-h

Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0073207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595438679;
	bh=tq+JUZsj5AqgXnL2XBkXkqSDwpXEWCNQo14xO0Bbgj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fNLQ25Z58gFTu9L6PQNojFob0hL/mz1BQbUYMSQd3j8Tj646kyBDfPfjrjWG5EUR6
	 SReVZRJCIKc2sNr/zvzqkUTdzm/GQn9MOi4hqC8CjCnCRadr9f48PhP6tE6MoV9eyN
	 LAZn+6f6ySfOr9zzFZEpumi4KCD2DTSO6QLNq+70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgGVRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgGVRYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:24:38 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80ABB20781;
        Wed, 22 Jul 2020 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595438677;
        bh=tq+JUZsj5AqgXnL2XBkXkqSDwpXEWCNQo14xO0Bbgj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5ChkHzt67oS2+SLJyglBpw/aN+89aBu7menAe4zmmAVi7hKqKWd6Q6BpqDcuecrA
         xAkc3/rd7plKxLa20B65NfjxuDhMhu3/K/8iRv9sTNGtiYtaIP7s3ikBc7maCZb6Vo
         zgZE6HPk6INDytsvNyyIcPTU8PiNHsHgW8nVjgM4=
Date:   Wed, 22 Jul 2020 10:24:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 1/2] f2fs: add sysfs symbolic link to kobject with volume
 name
Message-ID: <20200722172437.GH3912099@google.com>
References: <20200719054409.3050516-1-daeho43@gmail.com>
 <20200719151640.GA301791@kroah.com>
 <20200722164356.GA3912099@google.com>
 <20200722170602.GA440171@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722170602.GA440171@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22, Greg KH wrote:
> On Wed, Jul 22, 2020 at 09:43:56AM -0700, Jaegeuk Kim wrote:
> > On 07/19, Greg KH wrote:
> > > On Sun, Jul 19, 2020 at 02:44:08PM +0900, Daeho Jeong wrote:
> > > > From: Daeho Jeong <daehojeong@google.com>
> > > > 
> > > > Added a symbolic link directory pointing to its device name
> > > > directory using the volume name of the partition in sysfs.
> > > > (i.e., /sys/fs/f2fs/vol_#x -> /sys/fs/f2fs/sda1)
> > > 
> > > No, please no.
> > > 
> > > That is already created today for you in /dev/disk/  The kernel does not
> > > need to do this again.
> > > 
> > > If your distro/system/whatever does not provide you with /dev/disk/ and
> > > all of the symlinks in there, then work with your distro/system/whatever
> > > to do so.
> > 
> > I don't get the point, since /dev/disk points device node, not any sysfs entry.
> > Do you mean we need to create symlink to /sys/fs/f2fs/dm-X in /dev/disk?
> 
> Huh, no!  It's all done for you today automagically by userspace:
> 
> $ tree /dev/disk/by-label/
> /dev/disk/by-label/
> ├── boot -> ../../sda1
> ├── fast_disk -> ../../md0
> ├── root -> ../../sda2
> └── stuff -> ../../dm-0
> 
> Look on your laptop/desktop/server today for those, there's lots of
> symlinks in /dev/disk/

What I mean is "creating symlink from *userspace*", but the concern is
"/dev/" looks like being used for device nodes only, not sysfs.

> 
> > > Again, no need to do this on a per-filesystem-basis when we already have
> > > this around for all filesystems, and have had it for 15+ years now.
> > 
> > Could you point out where we can get this? And, the label support depends
> > on per-filesystem design. I'm not sure how this can be generic enough.
> 
> Userspace knows how to read labels on a per-filesystem-basis and does so
> just fine.  That's how it creates those symlinks, no kernel support is
> needed.
> 
> This has been implemented for 15+ years now, it's not a new thing...
> 
> Now if your embedded system doesn't support it, that's the userspace of
> that system's fault, it's not the kernel's fault at all.  Go fix your
> userspace if you want those things.

I'm not talking about whose fault tho. :) By any chance, could you please
suggest a good location to create a symlink for this sysfs entry?

> 
> thanks,
> 
> greg k-h

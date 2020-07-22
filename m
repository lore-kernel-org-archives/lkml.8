Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFBFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CA2206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595436238;
	bh=NWmgMsYz/UjEHMAobNjaiLofiShGglCnNsamdsb/4Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HnGRhXQT0Fu8lalb1egZjKw7yUGhJ9GwhwbMd4xtKWd3yVLQkvMt35/SOknbqpTtn
	 +VO14Q6Dq2aN4cRZLVi6vfMctTH+0S6i+dWjRWRJRUQs+tmlsnJiO2Oby+Ehs2Ki8I
	 3jTB/DdRbB0iMqbo2xG3QZ5PwOiQ496z9LXrcn/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgGVQn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgGVQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:43:56 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D04C206C1;
        Wed, 22 Jul 2020 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595436236;
        bh=NWmgMsYz/UjEHMAobNjaiLofiShGglCnNsamdsb/4Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pr3QGSqDxjAvr5aSuvlajCCX0H8+kOeWvKsF32hJUChoXnX2+zQhaEqT51FsiyMl+
         QLaeEso28PHOmuS30c82ZfXTzIOb5GnXtq3aqJehFW3rr3TY3PShXks9vry8e4pDJi
         vhAajRuY/QG1uuNzvGDLZHSu7wgR+RnkLbA1z/Lw=
Date:   Wed, 22 Jul 2020 09:43:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 1/2] f2fs: add sysfs symbolic link to kobject with volume
 name
Message-ID: <20200722164356.GA3912099@google.com>
References: <20200719054409.3050516-1-daeho43@gmail.com>
 <20200719151640.GA301791@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719151640.GA301791@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19, Greg KH wrote:
> On Sun, Jul 19, 2020 at 02:44:08PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Added a symbolic link directory pointing to its device name
> > directory using the volume name of the partition in sysfs.
> > (i.e., /sys/fs/f2fs/vol_#x -> /sys/fs/f2fs/sda1)
> 
> No, please no.
> 
> That is already created today for you in /dev/disk/  The kernel does not
> need to do this again.
> 
> If your distro/system/whatever does not provide you with /dev/disk/ and
> all of the symlinks in there, then work with your distro/system/whatever
> to do so.

I don't get the point, since /dev/disk points device node, not any sysfs entry.
Do you mean we need to create symlink to /sys/fs/f2fs/dm-X in /dev/disk?

> 
> Again, no need to do this on a per-filesystem-basis when we already have
> this around for all filesystems, and have had it for 15+ years now.

Could you point out where we can get this? And, the label support depends
on per-filesystem design. I'm not sure how this can be generic enough.

> 
> thanks,
> 
> greg k-h

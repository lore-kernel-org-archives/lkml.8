Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B2AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7750F20775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594202733;
	bh=yTKUIgGMoXAh3uS6fiL+0DHrR3iq2vwf7Im4h1Eez5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qCQl4Tq0V8HVQyZEF/36SNpJGl+4IY9EY5+c5RQg5J8gKRIrglPyOJDKIFCiSvKNg
	 VOnXVpMLSx2ed7DzaZLwLkrrZc+zRHbDw1vZMLE+Na66LntFaFWyl8iL6smVIFIJs5
	 nLCUuqUrlyR3fgglNbfvGx/pi8r0Dn/UpUvcNPUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGHKFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGHKFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:05:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6CA204EC;
        Wed,  8 Jul 2020 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594202731;
        bh=yTKUIgGMoXAh3uS6fiL+0DHrR3iq2vwf7Im4h1Eez5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8OClbpMbY9OCMuHPR8z/AuEAjgWpqOX7j8VzUdtfTaahbtr4MtPYKhaOBXiw6sg+
         MWc3Jgcpu1fCrkNyH5b7QbY3pkYE3aNGJGn/l1f6N0H7EGaVSbdJjdk9D6xJg7dinV
         ecIALBSNJXAlmjN1/7LbgOjOH8YdGRKqMCebod6w=
Date:   Wed, 8 Jul 2020 12:05:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs: add symbolic link to kobject in sysfs
Message-ID: <20200708100527.GA448589@kroah.com>
References: <20200703065420.3544269-1-daeho43@gmail.com>
 <20200703141359.GA2953162@kroah.com>
 <CACOAw_yweR--34vBXBV07xEGxGhO2r9o_XYVw6h9dMP=C6zp5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_yweR--34vBXBV07xEGxGhO2r9o_XYVw6h9dMP=C6zp5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:47:07AM +0900, Daeho Jeong wrote:
> > No Documentation/ABI/ entry for your new sysfs file/link?
> 
> This is for adding a symbolic link to a pre-existed
> /sys/fs/f2fs/<disk> directory and it means /sys/fs/f2fs/<mount> points
> to /sys/fs/f2fs/<disk>. I already added the description of this in
> Documentation/filesystems/f2fs.rst.

Ok, but that's not the standard location for sysfs file documentation.

> > And what does this help with?
> 
> Some system daemons in Android access with the pre-defined sysfs entry
> name in the json file. So whenever the project changes and the
> partition layout is changed, we have to follow up the changes and
> modify /sys/fs/f2fs/<disk> name in the json file accordingly.

That's what partition names are for, you should never depend on a
"random number".

> This will help them access all the f2fs sysfs entries consistently
> without requiring to know those changes.

No, please use a partition name, that is the only way to always know you
are mounting the correct partition.  You have created a random number
here that might, or might not, change between boots depending on the
order of the filesystem being mounted.  It is not persistant or
deterministic at all, please do not treat it as such.

> > If it's really needed, why don't we do this for all filesystem types?
> 
> This is for the daemon to change the mode of only F2FS with the power
> hint of Android.

Again, the point is that a filesystem type is not unique, this, if
really really needed, should be an attribute for ALL filesystem types,
f2fs is not special here at all.

Please do not rely on this number ever being the same across boots,
because your code is such that you can not guarantee that.

And again, if you really want to know the partition you are mounting
really is the partition you think you are mounting, use the partition
label name, that is what it is there for, and is why we have been
relying on that for decades.  A new special per-filesystem-attribute
that is semi-random is not the correct solution for the problem you are
describing as far as I can determine.

thanks,

greg k-h
